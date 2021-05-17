Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69040382DB5
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 15:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbhEQNna (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 09:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237454AbhEQNn1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 09:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621258931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/7ogBL+LNdJ2jZ956/DJsdJPCwqblJZYhGffkhc86o=;
        b=E93Ut9rxS7hRrpbtZbR9+G5dZcagoCW8JOrbCvbAMYmuz5mRUzJFGjKoJQkBiqiZMkXPl3
        ht/uNGqxt2uxs1thJ2EjEpO9YkzlAUYvFM3OeBEvLHWcvif/tsXb90LBt9xKqIevtVjFDU
        Ay2icUL1nwxiJuGMem9+xaQMNjyiRts=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-wSnfoHjRMQ--z-3W747zmw-1; Mon, 17 May 2021 09:42:09 -0400
X-MC-Unique: wSnfoHjRMQ--z-3W747zmw-1
Received: by mail-ed1-f69.google.com with SMTP id r19-20020a05640251d3b02903888eb31cafso3940885edd.13
        for <linux-btrfs@vger.kernel.org>; Mon, 17 May 2021 06:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/7ogBL+LNdJ2jZ956/DJsdJPCwqblJZYhGffkhc86o=;
        b=ZVKRYBUp3LO/XqWZ6Y2V47MBF64g5rVoAEqDpPrShwMXxZOgYHtOVq/WWJ3pagGmJF
         cRl5X1aUupSSW3nN3HNoUrHu6p/unbcVIfm1sp6mdXCTrhKTGEgoBwXjEiQw6ZUty2xz
         wySvvgUnSVub7h6RU3eqxS5He+z9/hdiF3CvuQ7noCjOLdB3mtkbJJjO4odSrf8xMh6E
         x608/2JBr7VwMQNEeVW3kxJEe8q9kxmP14MVDL2bA+g3yqAUOCK1XYOqT0QYSVzFaY6p
         7t+pvad00fa0NEUuzDP4zXy0gH8rAD8IL8vvsdxE0X3tVYqImoSz4X383OT/zykD230l
         NNtA==
X-Gm-Message-State: AOAM5315fR25sImawhoW5wvO8NP7bRc69DcfZxteAWxL3+JNvtv+/WRy
        lZNsLs+dHIzqZpTfmDiM8i2v9O67wS8Fxzga332RlkHJq3GMAZWeaiNRgWrM+v+u8sxeR1it9In
        5v0Q3CqvwleLirjLb9H7dW+o=
X-Received: by 2002:a17:906:d1ce:: with SMTP id bs14mr63552960ejb.183.1621258927779;
        Mon, 17 May 2021 06:42:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwmY87sB+RI/eYOHiE4Q0GrYf2Jge+7AHgcZqApEDJVyA57Z96Ks3gQhOvtduuLmn2qVC3iQ==
X-Received: by 2002:a17:906:d1ce:: with SMTP id bs14mr63552938ejb.183.1621258927634;
        Mon, 17 May 2021 06:42:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id f7sm11302466edd.5.2021.05.17.06.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 06:42:06 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH v2 2/2] selinux: fix SECURITY_LSM_NATIVE_LABELS flag handling on double mount
Date:   Mon, 17 May 2021 15:42:01 +0200
Message-Id: <20210517134201.29271-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517134201.29271-1-omosnace@redhat.com>
References: <20210517134201.29271-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When mounting an NFS export that is a mountpoint on the host, doing the
same mount a second time leads to a security_sb_set_mnt_opts() call on
an already intialized superblock, which leaves the
SECURITY_LSM_NATIVE_LABELS flag unset even if it's provided by the FS.
NFS then obediently clears NFS_CAP_SECURITY_LABEL from its server
capability set, leading to any newly created inodes for this superblock
to end up without labels.

To fix this, make sure to return the SECURITY_LSM_NATIVE_LABELS flag
when security_sb_set_mnt_opts() is called on an already initialized
superblock with matching security options.

While there, also do a sanity check to ensure that
SECURITY_LSM_NATIVE_LABELS is set in kflags if and only if
sbsec->behavior == SECURITY_FS_USE_NATIVE.

Minimal reproducer:
    # systemctl start nfs-server
    # exportfs -o rw,no_root_squash,security_label localhost:/
    # mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
    # mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
    # ls -lZ /mnt
    [all labels are system_u:object_r:unlabeled_t:s0]

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 041529cbf214..367e7739cb18 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -734,7 +734,24 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		/* previously mounted with options, but not on this attempt? */
 		if ((sbsec->flags & SE_MNTMASK) && !opts)
 			goto out_double_mount;
+
+		/*
+		 * If we are checking an already initialized mount and the
+		 * options match, make sure to return back the
+		 * SECURITY_LSM_NATIVE_LABELS flag if applicable. If the
+		 * superblock has the NATIVE behavior set and the FS is not
+		 * signaling its support (or vice versa), then it is a
+		 * programmer error, so emit a WARNING and return -EINVAL.
+		 */
 		rc = 0;
+		if (sbsec->behavior == SECURITY_FS_USE_NATIVE) {
+			if (WARN_ON(!(kern_flags & SECURITY_LSM_NATIVE_LABELS)))
+				rc = -EINVAL;
+			else
+				*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
+		} else if (WARN_ON(kern_flags & SECURITY_LSM_NATIVE_LABELS)) {
+			rc = -EINVAL;
+		}
 		goto out;
 	}
 
-- 
2.31.1

