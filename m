Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A9F29F8F9
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgJ2XSM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:18:12 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44717 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbgJ2XSL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:18:11 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EB9325C0108;
        Thu, 29 Oct 2020 19:18:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 29 Oct 2020 19:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=1zRZzbHhPhzR9
        OcmNemivr166tSh1otrHWRfzw6OHGg=; b=d5oricVV3KSZ2bmUUCZfvRHRarNS4
        XY9EBbVjnPadp5n70+sYRVng+vnxsQdDktJHNzrYtnwnHAW6HnHf1T0Dg9UUDuSX
        ofgrYX1XfU6LxE55RHxI1JdgTNftTfdugDEuT4TB60C9iNenPpLxU+4b30SShPoC
        9JdTnV5+p9OJkhpNTVCrsf2/7dGFcBtGfFG2H9Mn/LzbVHfntr0mdvlHb3zf5IMC
        AtXHgbNZImBQw+ORlAIyi5DAM14vv596rgwS+Z1Mm4YQWWlQDHxrYOiMAx3mtg9f
        HGwFIch1g5rytgZ5pP1eJtQ6/ojocL9YOzEy1+qyPgZ4cpRMMjfdHtBsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=1zRZzbHhPhzR9OcmNemivr166tSh1otrHWRfzw6OHGg=; b=jPaQLFEG
        egjOQ5KStRfXM1UX2BIxCGBTERwTbp398ulXFfNXJYuy6EMQbBZwHi9D/0E2244I
        MfmSQuSc8VID+AMXf6eWK9K1r/Ctzkv0rjzR6i7ifdBxoM1ICVOA/gv8oLhPKsI8
        Tm9MNWQLwtlF2J5myWgyAsBvhbHWbjEF6wRSKpGv5sbJuN2+cLwf4MIQFdojI23U
        7pjAhMtHFCohvoNMrTkZGsaqvLMlz+KHQcbmD/UW6qDNjlzDsVhbgmMEori8CIif
        HvwRMSb11IXanMIB+0x26v/dhlMjr/nggJ6wn52oM3dqp59dJQWH6rRqJayv/wyC
        fQdN6ubR7AxBwg==
X-ME-Sender: <xms:sk2bX_IShgXp4pmjUAsnyzYmRP3r2fRk6uFPAAh0WCjnFQFoAUnXKw>
    <xme:sk2bXzKZKWqMj4ntNIkONKF2pF18zbfz6rAs2aECfPXadpsc5VtUNXxMlctypoocd
    R5KFqK1l68kt1VGng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdeulefhkeevkeeuhfduhe
    egheelffeigfffheevffehveduudelkeeivefghefgnecuffhomhgrihhnpehgihhthhhu
    sgdrtghomhenucfkphepudeifedruddugedrudefvddrudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:sk2bX3t-0SBiDCLiYqMS-X2_M-c2t6T5tx-r1VU8Gs0s5ROCmVWyiw>
    <xmx:sk2bX4bIHLkr3LULhPJWmmum4GjIqUjmZuOocE3doW88iRAIYyk96A>
    <xmx:sk2bX2aJNflN50GGP7jfYG-Albm5e_iKxVy_4gpcjlj_NfVO9uoV7w>
    <xmx:sk2bX5we9g0AGwzuON0I3YrEwMWrOMvU6rZJmaQ52NKjceVvNb_VKQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id D82EF3064610;
        Thu, 29 Oct 2020 19:18:09 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs-progs: rescue: Add create-control-device subcommand
Date:   Thu, 29 Oct 2020 16:17:36 -0700
Message-Id: <052b7f70aee959f0c724b3d0524a727b5e1f102d.1604013169.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604013169.git.dxu@dxuuu.xyz>
References: <cover.1604013169.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This commit adds a new `btrfs rescue create-control-device` subcommand
that creats /dev/btrfs-control. This is helpful on systems that may not
have `mknod` installed.

Link: https://github.com/kdave/btrfs-progs/issues/223
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 cmds/rescue.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/cmds/rescue.c b/cmds/rescue.c
index 100d25f3..e6972fb7 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -18,6 +18,12 @@
 
 #include "kerncompat.h"
 
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include <fcntl.h>
+#include <unistd.h>
+
 #include <getopt.h>
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/volumes.h"
@@ -264,6 +270,34 @@ out:
 }
 static DEFINE_SIMPLE_COMMAND(rescue_fix_device_size, "fix-device-size");
 
+static const char * const cmd_rescue_create_control_device_usage[] = {
+	"btrfs rescue create-control-device",
+	"Create /dev/btrfs-control (see 'CONTROL DEVICE' in btrfs(5))",
+	NULL
+};
+
+static int cmd_rescue_create_control_device(const struct cmd_struct *cmd,
+					    int argc, char **argv)
+{
+	dev_t device;
+	int ret;
+
+	if (check_argc_exact(argc, 1))
+		return 1;
+
+	device = makedev(10, 234);
+
+	ret = mknod("/dev/btrfs-control", S_IFCHR | S_IRUSR | S_IWUSR, device);
+	if (ret) {
+		error("could not create /dev/btrfs-control: %m");
+		return 1;
+	}
+
+	return 0;
+
+}
+static DEFINE_SIMPLE_COMMAND(rescue_create_control_device, "create-control-device");
+
 static const char rescue_cmd_group_info[] =
 "toolbox for specific rescue operations";
 
@@ -273,6 +307,7 @@ static const struct cmd_group rescue_cmd_group = {
 		&cmd_struct_rescue_super_recover,
 		&cmd_struct_rescue_zero_log,
 		&cmd_struct_rescue_fix_device_size,
+		&cmd_struct_rescue_create_control_device,
 		NULL
 	}
 };
-- 
2.26.2

