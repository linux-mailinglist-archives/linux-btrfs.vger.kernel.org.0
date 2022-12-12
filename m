Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAAB649936
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiLLHGS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiLLHGR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:06:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C6D265C
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=W++jHYPvTcavzZdypakOveMHW2jC5rpxLuxyOSaNGjM=; b=BeEe1J4bwkz6sAEZ73x91J0GsR
        K2LW/9nYJsx5a91AO9E3ew99Jq+/fxQnxSCAxYzzcafKiLHmM92yUGZmNDtYwdgTIQrF1SYiWkGtS
        38yVcQRnPCiG42Ec4DvUJdn1/gAFfZ5jDm92+Hk0oABzArpmm7c/toppMkVNpjXw3BTOqhZunyfI7
        E+x4PGbuoR3ALiXIFuESpwqX4wK2MusEhmzrDCEUCqDQS3ToupiAhiMm4lz5KxFaQ/Y1jAdvF2Dk9
        ryLWB3crnnR/m8WuQa5dPM82bFdGrdN7/hUJRzuZPmHvUIOZHzBST3sihWkKUCPCl32JMa5403/Nn
        PpfCpSlw==;
Received: from [2001:4bb8:192:2f53:34e0:118:ce10:200c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4ctB-009Doh-SY; Mon, 12 Dec 2022 07:06:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: small raid56 cleanups
Date:   Mon, 12 Dec 2022 08:06:08 +0100
Message-Id: <20221212070611.5209-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this series has a few trivial code cleanups for the raid56 code while
I looked at it for another project.

Diffstat:
 raid56.c |   91 ++++++++++++++++++++++++---------------------------------------
 1 file changed, 36 insertions(+), 55 deletions(-)
