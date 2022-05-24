Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAE35323E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 09:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiEXHSp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 03:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiEXHSo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 03:18:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E16A02A;
        Tue, 24 May 2022 00:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LiiC2t0dESoKqXVHPifrqbMerSaRyaOqJMY86+aoB3g=; b=fw9ZLNukjlxPOSeLi65MGyJvql
        ais1b7aSRK22nxb9IYcGxcVaBNY3OoS2m5adlG7V8679nNR/ze5jQ++waZ36qHv5bPc7dwck+V6Vd
        LoJGpoleTK6xt7BNko1FVvxd84JxQ6+2BtYULB0vZvl8J6aexY4njTD8MPUO4oXPrc70B6arq6UZt
        k8IgfvNgFTokzyJoNgbhZS7N+Bwkt3bvHYTqDI0sMX6nRuWfjWPZgf0CBSqbo6Nd74XX+CT7PkrZK
        nT6j5yNEIgBbGrvcWN5hDGN7QTi65fRpsz+HKw9Jlt4kYuMsETs1LvMzphCvpb5X/lF8e4K069pin
        BOBrt6kA==;
Received: from [2001:4bb8:18c:7298:31fd:9579:b449:3c3a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntOoV-0073Ei-2v; Tue, 24 May 2022 07:18:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: two more btrfs read repair tests v2
Date:   Tue, 24 May 2022 09:18:29 +0200
Message-Id: <20220524071838.715013-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this series adds two more tests for the btrfs read-repair code
that exercise the raid1c3 profile.

Changes since v1:

 - add common helpers for read repair
 - increase the offsets so thay they should be fine with 64k block size
   (although I don't have a system to actually verify that)
