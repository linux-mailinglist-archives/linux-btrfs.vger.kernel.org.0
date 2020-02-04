Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94FCA15151C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 05:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgBDEwC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 23:52:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42175 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgBDEwC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 23:52:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so8800978pfz.9
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 20:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2tSM4L3niTTINmgVmlUO9exe+pMM14fntWWKz6rMW1o=;
        b=AwOWmuY+4B8o/ITpw9YErP6SYfmq0EerwSOVOzLSz7CGtU5bc+kc89Fn052rfe8WZv
         BOef5gSPpeGq/OM37xLrA0m9/8tGLOg39wylID9ANXVHugHJaw/G/wDpYq59BXoTPyAz
         wwjTk7M6GtXMhYgS6fa+4eEV+JFvk384igw79plO1xK4u193A73Z6F2TEzuVZMfCz82O
         Cva0XTbxntuXMnHwbRiSHPocM1/CL0sQ4N3VTDSC/Wf2KmkavTNTNfFItLAvfa9w6xaq
         DiV9FtNDzF4fh+AOUsQxUq3PC0gw7flJmvugvILQonXrQODO3PyoxClt6Db80cE/hVN1
         C5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2tSM4L3niTTINmgVmlUO9exe+pMM14fntWWKz6rMW1o=;
        b=pHgIxkY1cpHvJUo3Lxo0twr3nqueqjueI7I+fHEkSB9gZxJ3lbSU6lRPMOYg9BN3Yr
         5kYur8VAfvKH/LJ56pvzXSK/n5H/hOmdQ2Z4tL+w3E/P3fsjLyVEFYFqx3OkaQzBhkpn
         agSXRGP5/MwxhcXSyaPv+WTGR7PoTz+aZqHAwA6ymI2UFAHFBMMFL9HS6CFAMf4/Zks0
         rdcQmPlB/rs1G9mXJfP0O2uZwMA5KG6umtLM2qJEOPfQcPWtda0pM65053IPd4rIwmcP
         jjpzlyZThp2hRuAfOF72ME2g4f5ereyFZq5MJhvlRGQwvpd6201E/Qx5iFR8BQC0PojK
         q7aQ==
X-Gm-Message-State: APjAAAUUB/vbu5FaLTYEmRLa8QX4rGtA87RTI7eQ+ytfzbrBd//L4/eW
        6hEJVgm7KUmzPnrvzuwaglyRhjo+tss=
X-Google-Smtp-Source: APXvYqzN1ZFGsb4Y0FRCn0TXj1xFf8yJmxhUfdEKb10nycDmI1w3DK+NExoDfMZ0zS+A7MKB81PK7A==
X-Received: by 2002:a63:8b44:: with SMTP id j65mr28394505pge.272.1580791920024;
        Mon, 03 Feb 2020 20:52:00 -0800 (PST)
Received: from p.lan (176.231.199.104.bc.googleusercontent.com. [104.199.231.176])
        by smtp.gmail.com with ESMTPSA id d14sm1171390pjz.12.2020.02.03.20.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 20:51:59 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH] btrfs: update the comment of btrfs_control_ioctl()
Date:   Tue,  4 Feb 2020 12:51:56 +0800
Message-Id: <20200204045156.1662-1-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

Btrfsctl was removed in 2012, now the function btrfs_control_ioctl()
is only used for devices ioctls. So update the comment.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 78de9d5d80c6..2341e7af4cb0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2168,7 +2168,7 @@ static int btrfs_control_open(struct inode *inode, struct file *file)
 }
 
 /*
- * used by btrfsctl to scan devices when no FS is mounted
+ * Used by /dev/btrfs-control for devices ioctls.
  */
 static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 				unsigned long arg)
-- 
2.25.0

