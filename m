Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F50D169CA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 04:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgBXDdj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Feb 2020 22:33:39 -0500
Received: from gateway36.websitewelcome.com ([192.185.185.36]:16021 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727156AbgBXDdi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Feb 2020 22:33:38 -0500
X-Greylist: delayed 1354 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Feb 2020 22:33:38 EST
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id C902E40160F62
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2020 20:25:44 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 6499juXsdSl8q6499jZqDf; Sun, 23 Feb 2020 21:11:03 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pFaGorldvyQUpBmP2wGhnPUDjRezrXh+v53FzkL7yjM=; b=m7u+R2HYAqya/KnF+3vt7FSqLB
        XphOUmpYiKULE44M4YujAuahqCxaU2dFNLcR7mZzlgT56iT/EuiIaQdoPe4c+BFO7PTB8+ZV5BwlN
        lS6zejdOWFuZcpRU6JiGzsovYRssXR8diwyHwkeMvwdd7DB67lN7sS0DSEf+o4eIpUcMExslg4qjQ
        dt6nxsEsSVXFU5h5D2v2PusNwrOZC33Jf3RFj/C/ejMqD2GJObUvE7q2z5osfjpoc23CfyKXbrCvr
        2aTvpbzihtBdnS6cvkkY/zVzvADWhZwoX8xoamond+2GX0fJAnNwX3iBf7j1A0BTJ9hGaz6fbjX+z
        yENePM/w==;
Received: from [179.185.222.161] (port=40232 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j6496-0034Sn-Lg; Mon, 24 Feb 2020 00:11:01 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, guaneryu@gmail.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [ fstests PATCHv3 1/2] common: btrfs: Improve _require_btrfs_command
Date:   Mon, 24 Feb 2020 00:13:40 -0300
Message-Id: <20200224031341.27740-2-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224031341.27740-1-marcos@mpdesouza.com>
References: <20200224031341.27740-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.222.161
X-Source-L: No
X-Exim-ID: 1j6496-0034Sn-Lg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.222.161]:40232
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 10
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Now _require_btrfs_command can also check for subfuntion options, like
"subvolume delete --subvolid".

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes from v2:
* Added Reviewed-by from Nikolay to patch 0001

Changes from v1:
* New patch expanding the funtionality of _require_btrfs_command, which now
  check for argument of subcommands

 common/btrfs | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 19ac7cc4..ae3142b6 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -12,12 +12,14 @@ _btrfs_get_subvolid()
 
 # _require_btrfs_command <command> [<subcommand>|<option>]
 # We check for btrfs and (optionally) features of the btrfs command
-# It can both subfunction like "inspect-internal dump-tree" and
-# options like "check --qgroup-report"
+# This function support both subfunction like "inspect-internal dump-tree" and
+# options like "check --qgroup-report", and also subfunction options like
+# "subvolume delete --subvolid"
 _require_btrfs_command()
 {
 	local cmd=$1
 	local param=$2
+	local param_arg=$3
 	local safe_param
 
 	_require_command "$BTRFS_UTIL_PROG" btrfs
@@ -39,6 +41,13 @@ _require_btrfs_command()
 
 	$BTRFS_UTIL_PROG $cmd $param --help &> /dev/null
 	[ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old (must support $cmd $param)"
+
+	test -z "$param_arg" && return
+
+	# replace leading "-"s for grep
+	safe_param=$(echo $param_arg | sed 's/^-*//')
+	$BTRFS_UTIL_PROG $cmd $param --help | grep -wq $safe_param || \
+		_notrun "$BTRFS_UTIL_PROG too old (must support $cmd $param $param_arg)"
 }
 
 # Require extra check on btrfs qgroup numbers
-- 
2.25.0

