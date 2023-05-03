Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59256F4E46
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 03:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjECBAD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 21:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjECBAC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 21:00:02 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740D1358E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 18:00:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E5CE25C0316;
        Tue,  2 May 2023 21:00:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 May 2023 21:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1683075600; x=
        1683162000; bh=dFTnOYD7i0+LzW/Ouzk9kYFwhQ7rJPxOSqpojvo9gXk=; b=3
        j1lJ9rDD3to5g1i6RV3rWT6iehEvenIwecuJ4FgxiUHiAdKM5cLBrqdCKDEh0Pwf
        vhM8UpFioAyH++8Ts5TcXJi1JtpkbarAtqk6EtBfO1OSdNcioVvpd4SI4beFrzCH
        t0H5Z/srt/EJcrFchVfOhVWX0kR9Z/00p/k6gG0aFY3DH4tXhzKXyPym8sJH2/bs
        cGTT2pZSmYNrj/EicB7v7Pqfi22NfyrPM1oWY6fF5EoB+vXs/h+9pJmK4PuXSOwK
        SlH1VEGN4qPEOXX+q1g0ZpOHh/DonGG3JL+mC6FFVoGC4w78WIMgDaFhqBTeSHeP
        GmTiaBcemy/5bJbiTE4tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1683075600; x=1683162000; bh=d
        FTnOYD7i0+LzW/Ouzk9kYFwhQ7rJPxOSqpojvo9gXk=; b=P9y2CH0/AAn0IjxhC
        VMr3zXXsspvCB5tqe3frrdy9QjRK0biPLJoKqvyE/EYw0mw8txtm1Uanzq20XX8i
        +9wJjez8XHs1YGDhZ6h0zXzJG3K3DVX0jfMZRuOHt05xbO7Mp0wfnRpCj5wOURf6
        g7GrrILgwv8gh9KkHpw1RoIPxCnbdydZD+7aV732ikbkMVBerIDrWu9Lk1+6BRoz
        dFUjclStnjbWJUJvfC0qAQ7Uay18VJy9Tlrr5qvoPJQus7ftP7uIYHYcO7r2Utsx
        3Do0k7PsvbhqfWvjpdEoiUx+Uq8TmbVezoZiwJFlbhaZFZhLWdaUqnPXH/Jru1NA
        6yTGw==
X-ME-Sender: <xms:ELJRZC_nZpE7Am5c6Nw8BG6_q9-W8wJIVAMQYwoGzebSybAqX_8Hbg>
    <xme:ELJRZCvFzoU63gaXRzcZFFWd_8NHks0gnU6K7DoBduKS1DVbqlUZOCu2MyxOx_Pzm
    -NLcmUC4rbIzobnmiI>
X-ME-Received: <xmr:ELJRZIDtMsMNN3BDrURDaRq3jQiwG-oqhBg8OkrMoK4iaj-iqL5tRcZX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvjedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:ELJRZKeL8xSYdxzqn3eqpXe7_9w3GNKTKBShH2uTB6q42VlgGAjGtg>
    <xmx:ELJRZHNEYodNLTXI_mKbLQz7eb59hbAey_OQ6Bx97LKgb42EJjGcnQ>
    <xmx:ELJRZEkTQUO6ign4duY6btp-5jpgwi7oZ0p_dOS9WilLz2OJMgWYgg>
    <xmx:ELJRZJU64MZjHFtVVGletrMigfUeTwR--aFsji6O1sTYKSy9hCQHYQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 21:00:00 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 9/9] btrfs: free qgroup rsv on io failure
Date:   Tue,  2 May 2023 17:59:30 -0700
Message-Id: <185066f6b569a51c99b26046d1e33ea46385c083.1683075170.git.boris@bur.io>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1683075170.git.boris@bur.io>
References: <cover.1683075170.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we do a write whose bio suffers an error, we will never reclaim the
qgroup reserved space for it. We allocate the space in the write_iter
codepath, then release the reservation as we allocate the ordered
extent, but we only create a delayed ref if the ordered extent finishes.
If it has an error, we simply leak the rsv. This is apparent in running
any error injecting (dmerror) fstests like btrfs/146 or btrfs/160. Such
tests fail due to dmesg on umount complaining about the leaked qgroup
data space.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/ordered-data.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a9778a91511e..e6803587a13c 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -426,8 +426,12 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 			entry->bytes_left -= len;
 		}
 
-		if (!uptodate)
+		if (!uptodate) {
 			set_bit(BTRFS_ORDERED_IOERR, &entry->flags);
+			btrfs_qgroup_free_refroot(fs_info, inode->root->root_key.objectid,
+						  entry->qgroup_rsv, BTRFS_QGROUP_RSV_DATA);
+			entry->qgroup_rsv = 0;
+		}
 
 		/*
 		 * All the IO of the ordered extent is finished, we need to queue
-- 
2.40.0

