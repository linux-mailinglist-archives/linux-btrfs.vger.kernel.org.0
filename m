Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304DB6CCE9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 02:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjC2AN1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 20:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC2AN0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 20:13:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F344419C
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 17:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ljb6MjWI1tAnOUKiin3t2vXZ+5WY7QDlouEkLbokivw=; b=PD0mjkQ6RpWEIKwNaMSN8OBJ6b
        CA/VlbBMCMkNmGG6J4nw/dHniBD/zNo8+5iDWFlDNlojreXU/XcAKdhpWKB3HaZx7JXwR+beRxQ9g
        DoS8yqNL0OYpV9I0DAwx3s3dpfCUfu6z0Y6bVaBNFzeFHN6qZpHJl+M8lnIh/VzlRzkiXZm1gVxPj
        IonufX2OowxoFTw2f70Oc2W4+wxfw7p/oNsdnuYYgd3BxSrf7t1dNr7AFhQVxAqATmtBLNl/0efbw
        lAAHNldIOIB4WRboumOexR5CEAqpk0VigHsvvwLyp76Qgzi4h63shvBzKYVTKiJPZJLjRBRh/gZKi
        rYF5WSNA==;
Received: from mo146-160-37-65.air.mopera.net ([146.160.37.65] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phJRH-00GAyG-2M;
        Wed, 29 Mar 2023 00:13:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: don't offload CRCs generation to helpers if it is fast
Date:   Wed, 29 Mar 2023 09:13:04 +0900
Message-Id: <20230329001308.1275299-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

based on various observations from me and Chris, we really should never
offload CRCs generation to helpers if it is hardware accelerated.

This series implements that and also tidies up various lose ends around
that.


Diffstat:
 bio.c         |   32 ++++++++++++++------------------
 btrfs_inode.h |    3 ---
 disk-io.c     |   24 ++++++++++++++++++------
 file.c        |    9 ---------
 fs.h          |    1 -
 inode.c       |    1 -
 super.c       |    3 ---
 transaction.c |    2 --
 8 files changed, 32 insertions(+), 43 deletions(-)
