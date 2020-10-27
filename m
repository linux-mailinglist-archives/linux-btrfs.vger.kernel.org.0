Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D082829CAFA
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 22:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832094AbgJ0VJO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 17:09:14 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34485 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1832092AbgJ0VJN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 17:09:13 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 948135C00ED;
        Tue, 27 Oct 2020 17:09:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Oct 2020 17:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=cyLT8ihDVMziZ
        JFq7nEmekggQ/kxhXwGRc2vSDc47tA=; b=heIQ/kNkkjEMUXfgphBOV8uNQgYG9
        q+D59+quQhkJZXrNBUXn8OG7ooqDhqWJr2cqSeEQd9GvBgTDbRJ+xNU2o3Ym7K4K
        ykGoUlVRn11Pn+JrPHrCWQNnWmIQShSFJkE3aXgMi5aN1xHnJJEoYQrYskguctTM
        cRrl9YZ1sgWEnz2R3Ye5N791FQrv1EfuP6J/xCw/cHUK21oIfhdNztsatMFhdVts
        AI6SeQoOGi0fmPfvNm3TJurwKg+AXN+WQa0MaoLEfRUI2ekr6szJ9DQI9PIjdANz
        jdFFtcwNACeZLscngDsnwGuIn5SUWv6gP1BrbSD6hxAJXsiCclLLGp4Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=cyLT8ihDVMziZJFq7nEmekggQ/kxhXwGRc2vSDc47tA=; b=IeHcTbuS
        /8TGSQtIqg4286F34sF5C16MS1ATgFO3Wr/iliJy5WxZHxvsgj3ItbOv1xeLIyJR
        lfgj0gAGjBecZhs69bhyLan9+EX+GALgW8sk/XF1JbW797EktLosOPwvZCN21QU1
        5J9SeDAxqKNWYrGwk1QYM0+M8wkm8rBU4NQuqevWrRABRGqxd+iRD2B1OYLy2XTH
        diUMOaUYVftXbTpGL8S93fKKv1z4EZMFJ7+WvZWAeXKgdjPXxqTCsjHdGGbA94gi
        iAWBEvJNdNUpk9zUW7lFRy3dWPQI961rpuRoWmCi5CfXBtMOXzkH7GkHePEhU7ir
        ZWdY83uRmqa4yA==
X-ME-Sender: <xms:eIyYX1i6c6n5EPZ_FTZ9pFVXqnCGFw4HgouIND3_AfK2_TKpx6z-fQ>
    <xme:eIyYX6CDx4D5ZebLxilTYlQnArAWAz_pwO7Priu40eN5fNeIG4LbElp8OZ_2LFT0i
    v1HaF4nvHrrdWMs2lo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:eIyYX1EjFSSd6TXj7lFlr3VHKOFk60qpUmXyuGwta1hTm9tV9ueEXQ>
    <xmx:eIyYX6Q7Smyf_jn_eYeqr466b1_xgaCaBBf0TX8ib1H6nraAuNjwOw>
    <xmx:eIyYXyyBpDycsWb1Y7dytwJXgtRz5k_hskzXzZP-xdC_rGrtSwjGxQ>
    <xmx:eIyYX4b5qlnZoKjBbGdUOX5PgeQrefxfRa9TTdcdqdw3G-Z8VDBIbA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0B93E3280066;
        Tue, 27 Oct 2020 17:09:12 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v5 10/10] btrfs: skip space_cache v1 setup when not using it
Date:   Tue, 27 Oct 2020 14:08:04 -0700
Message-Id: <09febed7882924087141f081273fb4bbcaae7928.1603828718.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603828718.git.boris@bur.io>
References: <cover.1603828718.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we are not using space cache v1, we should not create the free space
object or free space inodes. This comes up when we delete the existing
free space objects/inodes when migrating to v2, only to see them get
recreated for every dirtied block group.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 8938b11a3339..59a130fdcd5c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2325,6 +2325,9 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	int retries = 0;
 	int ret = 0;
 
+	if (!btrfs_test_opt(fs_info, SPACE_CACHE))
+		return 0;
+
 	/*
 	 * If this block group is smaller than 100 megs don't bother caching the
 	 * block group.
-- 
2.24.1

