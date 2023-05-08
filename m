Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7946FB352
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 16:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjEHO6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 10:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjEHO6o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 10:58:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576F3E41
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=E0UMp1a7Kjjll0TivwUACd7fUKSo9PhPHGuWX2dJaP4=; b=MLyH2lKlqO00Q1po74ErFSokG8
        gv7tGqGe9+AkZJOwRvKdFTzklonCEPV2YeKXPMMruQBf4VrRFc6RF7H37L+yYD5LjpCK5d0FLr11D
        PfX4fgowQxl7+PXECnpXutl//HbajQTAqRHPLP9YMNZ3bA5e1czJ2/QUZH0lWdrcM5/AFzSn90ifl
        +Tf9mYy5q09Q9/T9mtkT0WT0sieTgjUgoWOJP5Cv5l3KmZUKREG+G3oUK4n+bliaCMj9oXf51MNeZ
        jiDyzmv652T1+2/BpGVHXLFxWTGhlfhrHO1R4m3dpzVr69kPOrlVtq0fCemga1UIZk90dlcprq0nq
        GQGJW8Nw==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw2K0-000ogG-1J;
        Mon, 08 May 2023 14:58:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
Subject: buffer redirtying fixes and cleanup
Date:   Mon,  8 May 2023 07:58:36 -0700
Message-Id: <20230508145839.43725-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this series fixed two small bugs in the buffer redirty code for the
zoned mode, and then removed some unnneded code in the same area.

Diffstat:
 disk-io.c     |    9 +--------
 extent_io.c   |    8 ++++----
 extent_io.h   |    3 +--
 transaction.c |    9 ---------
 transaction.h |    3 ---
 zoned.c       |   32 ++++++--------------------------
 zoned.h       |    2 --
 7 files changed, 12 insertions(+), 54 deletions(-)
