Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A6155838
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 14:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgBGNRQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 08:17:16 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:39032 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGNRP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 08:17:15 -0500
Received: by mail-wm1-f50.google.com with SMTP id c84so2723432wme.4;
        Fri, 07 Feb 2020 05:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZeCy0SlBZPOr5VrbSJdZIRhfwnw/AitJ1GVrZSolHI8=;
        b=LS6kCk2A6b66ybZd4lvfGbkd43PPrk+EyZw94HKKUnKQ/7jf8DVIaBxWd/qImjYJJT
         ObVKiwjYAg10ub0ig5ICcmCQSIi1pY24/6NncG7AILYEevTAbiBcgNHJtIJUn+mFDs5F
         47oajW8Ic5khIiosZ7q661OZDL2Wx8JfUbQmMLNY6uDJXQoqhEjErLnv8FCFdQNdktZF
         U5EsHOmq5V1ROmapwRhPJBi/ygLNK9C7n8imkDpsXW7KJbg6JjtZ4jg8r0TCdhnGKE+/
         w6e64i9uOhSkCYdfZxXaqmtfhIl4RK1v8IeQxwQLkEozTelry4jzifpQKYyMqsXmhFL3
         gATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZeCy0SlBZPOr5VrbSJdZIRhfwnw/AitJ1GVrZSolHI8=;
        b=C+ZqiZPcBRZIxObmaP+NXPOqGv2rS+OnEljqFwE5MeEw0AmEd5hYJpwFuKZSRVgtEK
         t9U1nLk4dtwY8yOBjQF6GkioDWpYFnvzWX1KgoAoUeBmPe7QrzyUUgv+90a1L8ALvIoG
         prZw4VgcwWcneEiM4fkBP+Yjzb84mJYl9dQasY9WxsNnR9SoowULmWD/uh/695igPfD+
         mh4mQlfXyVy81mOQAGIE2DxewoLeRwdjUFBfLPkvyioHHpAUGfsdbVY7Rxy2XXjboItD
         ZTY04GSnDT9La/KAH9dwdjvoqAHwOpsMIwyGUSi7NCo/MulcQTkuzEw75nI1KBUoyEh8
         YIFQ==
X-Gm-Message-State: APjAAAXfnZ2X5sqTFTbqjlsl6ehq2XtxOSaELY6kwyW4jORzbRhkAPpy
        Z3pjFWTFSH+ggtEKv0H0fXmZCbhp
X-Google-Smtp-Source: APXvYqxQind+od5Fegn2+0IRzV76/ieYOpgXu5K+bOwbAVSIcIFFPnBA+4H5vbc2WVuX+2FdX7jC3Q==
X-Received: by 2002:a05:600c:21c5:: with SMTP id x5mr4511601wmj.72.1581081433798;
        Fri, 07 Feb 2020 05:17:13 -0800 (PST)
Received: from hephaestus.suse.de ([186.212.94.124])
        by smtp.gmail.com with ESMTPSA id i204sm3472723wma.44.2020.02.07.05.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 05:17:13 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv2 1/2] common: btrfs: Improve _require_btrfs_command
Date:   Fri,  7 Feb 2020 10:19:50 -0300
Message-Id: <20200207131951.15859-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200207131951.15859-1-marcos.souza.org@gmail.com>
References: <20200207131951.15859-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Now _require_btrfs_command can also check for subfuntion options, like
"subvolume delete --subvolid".

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---

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
2.24.0

