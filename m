Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6453230A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 19:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhBWSYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 13:24:03 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36721 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233954AbhBWSXm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 13:23:42 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 68EA25C008E;
        Tue, 23 Feb 2021 13:22:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 23 Feb 2021 13:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=cFJPBEsguoVFlUtsgRgrQVzzY/
        rVmY5+eNtznHDrgAY=; b=Be/tExJx3LaVOmt6NN7EyWq8hbCamyxbDTqY68CJLU
        Nv2vIjNxROfIhjYTl4UPGPUD8H3u6dlbs/jLfVKCgMsUwkU7pAHqVRAjgJFdgTwN
        hqI6gtX+/jZeZUvHxbVgbpwD6i9Scn2O74WCZCvqeX4pX264TUanV2jtXGUsWOJ2
        Vnb5OoY76nuWszVKhkut9iwP9h4q9+N23YhSY0S0H+jtCB3Z2hY+lGBDebS1dnxw
        tM9XXRwrCFGEfP2e84i6bt7o28PttdPMCWwvEtJ2DWFhpydfcLek78br7JxDEOAO
        ktSDXqGjfwOw3v/n0EhP8Nr43bHMoYoRBvtfvMEL515Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=cFJPBEsguoVFlUtsg
        RgrQVzzY/rVmY5+eNtznHDrgAY=; b=IgzND0Ux3i2VEADN1JRB6vH+1Ih70dpB9
        WzLVRF17C0tppID7Hw34dtckwLE6wPprsIJtSr4rB4ok0LTotR2J7m4qGtDNwyUx
        sZZo2B60+oSmhaeCIKzeW8GohxWK2FJjg3pSBrLZ93XBzlhtvtGnyIxi47btxMiG
        492/KmfQAS2iYfmk9HDaNf3G6mu8GccDJ3WtAtJaW5pJ2fA/FnMqidX0ktJPsDf9
        zpnV9P6+zFiXjXhmiixTNEj8WxCnsM8HlzEK3vCMU+ZrrB/dH7rHhLbHr9qrRDGK
        89B0jMYrWjJoSsu1wN2ChTBYOydnQcdRBnpXmSK2MAWYE1KRp1fBA==
X-ME-Sender: <xms:60c1YFjQsxjIsl8gCp9WpY7ZxJPrBkO0Tb7z3_xFbubBsPklyo9EXA>
    <xme:60c1YKDh1LrJrPAA49EHHXc1IHfUXoJWKjFbFTGrafCrUMKx6--44WCuG1guWlrqv
    WZBNC4UERtujHJodww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeehgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucfkphepudeifedruddugedrudefvddrudenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hioh
X-ME-Proxy: <xmx:60c1YFEpOoasonqsrp4QJH27lKogdtqo_cCCWzbiH_F9Jy1Yg0CD4w>
    <xmx:60c1YKTJcQGGPsOHKNsmnk3j530vNIfFb1DfpcON60uYk_HTASzf-Q>
    <xmx:60c1YCz3DzA0yPjV3tH81qW7ihy6oU6-Dza8iZjue-5oRsZRzQg6UA>
    <xmx:7Ec1YIa_Kt2ackfiXdYvbMRgDVHqQmW8pnxX42ZuHCGuDV0pP90oIw>
Received: from localhost (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 07745108005B;
        Tue, 23 Feb 2021 13:22:35 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        'Chris Murphy ' <lists@colorremedies.com>
Subject: [PATCH] btrfs: fix spurious free_space_tree remount warning
Date:   Tue, 23 Feb 2021 10:22:32 -0800
Message-Id: <4a019f01584f1d818203b7c2ed65204583a11592.1614104082.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The intended logic of the check is to catch cases where the desired
free_space_tree setting doesn't match the mounted setting, and the
remount is anything but ro->rw. However, it makes the mistake of
checking equality on a masked integer (btrfs_test_opt) against a boolean
(btrfs_fs_compat_ro).

If you run the reproducer:
mount -o space_cache=v2 dev mnt
mount -o remount,ro mnt

you would expect no warning, because the remount is not attempting to
change the free space tree setting, but we do see the warning.

To fix this, convert the option test to a boolean.

I tested a variety of transitions:
sudo mount -o space_cache=v2 /dev/vg0/lv0 mnt/lol
(fst enabled)
mount -o remount,ro mnt/lol
(no warning, no fst change)
sudo mount -o remount,rw,space_cache=v1,clear_cache
(no warning, ro->rw)
sudo mount -o remount,rw,space_cache=v2 mnt
(warning, rw->rw with change)
sudo mount -o remount,ro mnt
(no warning, no fst change)
sudo mount -o remount,rw,space_cache=v2 mnt
(no warning, no fst change)

Reported-by: Chris Murphy <lists@colorremedies.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f8435641b912..d4992ceab5ea 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1918,7 +1918,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	btrfs_resize_thread_pool(fs_info,
 		fs_info->thread_pool_size, old_thread_pool_size);
 
-	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
+	if (!!btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
 	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
 	    (!sb_rdonly(sb) || (*flags & SB_RDONLY))) {
 		btrfs_warn(fs_info,
-- 
2.24.1

