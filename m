Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD974591C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 16:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbhKVP5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 10:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbhKVP5e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 10:57:34 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FD2C061746
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 07:54:19 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q12so15649874pgh.5
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 07:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MIOl5FabVOqkD6AtHa6uCXmnh1LFQkwm3+TSpHEm/J4=;
        b=l8QMTG9tPndka4MQ9l6LP5VAGNvA4qWlbvy7hP/zpAKZ3H27/bo+UTQoUzO3VnmvPw
         emWcBbwuXFedUcua2S150M9nZCGUTiOef/wSDjCMPcxvQyYvOxrbtjoDPXdAsP0vpt6f
         zzlZyL/yRv5LjsNo33gHfP8hrAOS+ZVkJ5U6xoJ6YzfqkwBwUHcxktJmyEBFj4M/QX88
         OdWQ/5yuyUdIcrejLVn+KuKJgBBA8ar//yKkfT9NBr3vxoUTa22VMBhD2sNk5+vzYMs8
         lhl4wwUeeCTIlGA4klQY38mfXnOUknToYcd0MHawEql7nQMz/p2rpIQcO5aECsWj6nFF
         IgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MIOl5FabVOqkD6AtHa6uCXmnh1LFQkwm3+TSpHEm/J4=;
        b=5LXJQ0+FnUyOa12fLjHtm+YcGuH/0jt07qGjOUSF77ENpUeGnxIXctTCGFGGM7xL2E
         GCPAvGZAKKoIjV+7+OOnuIInbwSF/mDjHZqUruqmakDtACybt6SFn+j/n2BQfuo0KF8m
         7nMglOsDINzkCLA1OFJffHZAH9qOo3enqi/RjAORnhilpD8lPtl6s6mu5ZWDZoeK7MVL
         W2z+NyAXe/wnF51/NzeyZy0HT8IG9jBR08RFdY740eSg4UL26TGIY2ColjFjordCwfFz
         x/w2miYpbuxttXxTo6ZSGKNXS7lHmkK9c/iNfj6ICkHI4n3TvuoGX+m2zLuPW0U6I2yz
         eDiw==
X-Gm-Message-State: AOAM5330N2GVx+D6QCw0DQ30jgAvzRTQK4+YDh+i1ccBiTKY4OiQ64uC
        lDkoxWsOc3253TJaCSA8xx4=
X-Google-Smtp-Source: ABdhPJx4mbLEm2jPe/ry1HkhWUUAXsHqnqZNsIu2OyZi6Ph1RheqSVpKrb6dMaAsaJ44rBK2h/bzUw==
X-Received: by 2002:a62:1e81:0:b0:4a3:7a97:d868 with SMTP id e123-20020a621e81000000b004a37a97d868mr29169071pfe.52.1637596459457;
        Mon, 22 Nov 2021 07:54:19 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id b4sm9848456pfl.60.2021.11.22.07.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 07:54:19 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v3] btrfs-progs: filesystem: du: skip file that permission denied
Date:   Mon, 22 Nov 2021 15:54:11 +0000
Message-Id: <20211122155411.10626-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch handles issue #421. Filesystem du command fails and exit
when it access file that has permission denied. But it can continue the
command except the files. This patch prints error message just like
/bin/du does and it continues if it can.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v3:
 - prints error message like /bin/du does
---
 cmds/filesystem-du.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
index 5865335d..7ea2da85 100644
--- a/cmds/filesystem-du.c
+++ b/cmds/filesystem-du.c
@@ -403,14 +403,14 @@ static int du_walk_dir(struct du_dir_ctxt *ctxt, struct rb_root *shared_extents)
 						  dirfd(dirstream),
 						  shared_extents, &tot, &shr,
 						  0);
-				if (ret == -ENOTTY) {
-					ret = 0;
-					continue;
-				} else if (ret) {
+				if (ret) {
 					errno = -ret;
-					fprintf(stderr,
-					"failed to walk dir/file: %s : %m\n",
-						entry->d_name);
+					fprintf(stderr, "cannot access: '%s:' %m\n",
+							entry->d_name);
+					if (ret == -ENOTTY || ret == -EACCES) {
+						ret = 0;
+						continue;
+					}
 					break;
 				}
 
-- 
2.25.1

