Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80FC295506
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 01:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507027AbgJUXHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 19:07:17 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:40415 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2507008AbgJUXHR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 19:07:17 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 58E1812A4;
        Wed, 21 Oct 2020 19:07:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Oct 2020 19:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=o+4Gls1Ddh0+i
        8PYylHoHW3FXgfqFqg1B1hDR+WgZ9k=; b=gCRXFvNO3z/j1+7exjs/DJepSO+iH
        n1KoPkKN8/v/Wx1byy+IoeRV+Rw95mZ6a+e4mRtUq8qqUoB6ilVEy9QdfJFbwSIP
        Fyukd0ji33cJ98/06+/3NCCCNvKsEN7APk0Km6aSi+UZ2zq2d+AeQy+WO9FVJ45i
        SST8miFghdEcxzapFRHMth9362Z/CUThKJokKUDrDb6M03qANQ981UN92BmXCwRi
        GBbm9JgOkhsLjyW46H8ytlT7PBlGBG4Dv/tbyhp7DuVuFtsUPhX11tXJm6iWJkSY
        mAZB3iwabLgCS2SouRaoqXyLYcqKj7ZxcWPV3fT17hPq9sL+UC4s6JkUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=o+4Gls1Ddh0+i8PYylHoHW3FXgfqFqg1B1hDR+WgZ9k=; b=DTNB3v2S
        HEFoDkmXve11apmOIuqnn8UlqE/A7TSFwXSNo7TpuExlRzZLhKWLU9uTobG/3iRN
        Vv3Yzp4xCEem6mgTlAz5rFXTVj2ZsqGSH8hjEGWY1VzpFuLsOXShe27zQIGKnIFp
        e+wpcrQNIG2scZCMumUBDNxQ4gYwpS9THt+i+ho1OtlsD26yN3IQmRu21Zv+XcsF
        1mpXv/iRMGspGxJJrv5MlMrb/uxdleLnttjhFGD11WLtPnAUd1XmH1H0vtzfzRlv
        kljbUnfhU0ptxSxOUmXxR6Smzg21zRVtBk/ImDjEIQCMn3o/BMkTKCzKs/4pAz1U
        FWakjpIIW20L9w==
X-ME-Sender: <xms:I7-QX5NTBliu1TMgkKUmAL_0VFSKYRcaGnMLA1Zi7EbWkbix75Ay2A>
    <xme:I7-QX7_DQfev6lq_a6V8Te6VdQsZfISZF-1T6P_qXjUEx0y96Jbx4Uv9MrZsujpOw
    CL9rMin8P8dqo4WdPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:I7-QX4RKUmpRyhG3zN86yuh71PY7W9cWtSzDNatEOGUjYT6g5v5xng>
    <xmx:I7-QX1u-j6Ip5f37PXmWBaUdir5Z47Fd1GjQdcKfe5Lbx_JeHZvoiw>
    <xmx:I7-QXxeTYf6fosjJvLINZ3lkYqY2iuHXJSTgOE1SmpiDitPjDO_aCA>
    <xmx:I7-QXxm0RLpUADOLc1Zvu32_yE7acA39oXhtSDKZFr1iiDwcc0iLyw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 96FC23064674;
        Wed, 21 Oct 2020 19:07:15 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v4 5/8] btrfs: use sb state to print space_cache mount option
Date:   Wed, 21 Oct 2020 16:06:33 -0700
Message-Id: <07f096a4826b78137d86f07878142655a5d059d8.1603318242.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1603318242.git.boris@bur.io>
References: <cover.1603318242.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To make the contents of /proc/mounts better match the actual state of
the file system, base the display of the space cache mount options off
the contents of the super block rather than the last mount options
passed in. Since there are many scenarios where the mount will ignore a
space cache option, simply showing the passed in option is misleading.

For example, if we mount with -o remount,space_cache=v2 on a read-write
file system without an existing free space tree, we won't build a free
space tree, but /proc/mounts will read space_cache=v2 (until we mount
again and it goes away)

cache_generation is set iff space_cache=v1, FREE_SPACE_TREE is set iff
space_cache=v2, and if neither is the case, we print nospace_cache.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index fd3dbf419072..c78e3379fa93 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1427,9 +1427,9 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",discard=async");
 	if (!(info->sb->s_flags & SB_POSIXACL))
 		seq_puts(seq, ",noacl");
-	if (btrfs_test_opt(info, SPACE_CACHE))
+	if (btrfs_free_space_cache_v1_active(info))
 		seq_puts(seq, ",space_cache");
-	else if (btrfs_test_opt(info, FREE_SPACE_TREE))
+	else if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
 		seq_puts(seq, ",space_cache=v2");
 	else
 		seq_puts(seq, ",nospace_cache");
-- 
2.24.1

