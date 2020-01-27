Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B378149E51
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 03:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgA0Crs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jan 2020 21:47:48 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46933 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgA0Crs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jan 2020 21:47:48 -0500
Received: by mail-qk1-f193.google.com with SMTP id g195so8234970qke.13
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Jan 2020 18:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQIGKD8bWQIQT6bnu0tOIyktD523cvz8CgFPAnNGi0k=;
        b=iw3uoqyJ5IgYayDq/1IYVxS4I7HasHzcJNK20LgUa2ajwC5Vb9Dge7i+l202j5VjAA
         Q6P7CeIe8XcIkgl1nxXYlIhegksKxp3SuH4O++uFljRDADcNJuKbKYvNvw5hYXnPIleN
         tUNzqiJRMFhiDWfsCikgcuadxrHQPPP+cyUkf4thPAPQ0LdNShcDBK2CSwrDZgZFSxiD
         1CCVnqJDPQLkV53ygALo3wAtljwyDyBFCPcNZmdRbZUffnmA2Izj/pZ6C/lgLBytK4Vk
         KbHADoarTkisX/EpuFs8IhosPpMXObMMcie489XmrGOE0/OKEvX0tQhHuYPUIkhupJHp
         adWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQIGKD8bWQIQT6bnu0tOIyktD523cvz8CgFPAnNGi0k=;
        b=pny3HvtTftp/YR8b9EVxAOeSpnZAE+P8lWlReIcM3G9eVloJKe/yYRshYMJK8IUq/d
         19azPdBFaf5JQpqnJC6HKNCswC1zLDL00MXbdRuhBCDkL7+d4Mej3J6v6wOmE6Bmg+Ik
         BAdEg/sZh1AhO6Ousw1Hx02KhrnUX8cX/314xsiw+sZ6Je+XbblT3gppiXjm4Od02y3K
         8TaGkg0Tij6ZmMQm+saho7jqI+eypyQtaWRXfqElIOuhvLJuAuzylaoRhRvFIjEmhDgp
         xPUSxe0YXVkI8H5X1YYbJd+WAYLKze5ilVbP6WVPAFGV49Urs4ugnfxfwiuggfXCL+e4
         z6Vw==
X-Gm-Message-State: APjAAAVr1DMMHGqD/l9bJTm+8fTrt2NcNclxgle32nVemOR5loluX5zq
        cluc73Oj2Mt8sb7wAi4qtrnhtiA3
X-Google-Smtp-Source: APXvYqxjQpvzq/nu3/bh8EcygANzOFKBxXBVJHy5zEaQFXxuds4bDLzBB1pwg1I6Hq3EBmCl8XmP1A==
X-Received: by 2002:a05:620a:1249:: with SMTP id a9mr14741810qkl.147.1580093267021;
        Sun, 26 Jan 2020 18:47:47 -0800 (PST)
Received: from localhost.localdomain (200.146.53.109.dynamic.dialup.gvt.net.br. [200.146.53.109])
        by smtp.gmail.com with ESMTPSA id n32sm9196963qtk.66.2020.01.26.18.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 18:47:46 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 1/2] common: btrfs: Improve _require_btrfs_command
Date:   Sun, 26 Jan 2020 23:50:28 -0300
Message-Id: <20200127025029.17545-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Now _require_btrfs_command can also check for subfuntion options, like
"subvolume delete --subvolid".

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
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
2.24.0

