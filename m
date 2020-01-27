Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B74149E4D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 03:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgA0CrS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jan 2020 21:47:18 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44399 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgA0CrS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jan 2020 21:47:18 -0500
Received: by mail-qv1-f68.google.com with SMTP id n8so3812421qvg.11
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Jan 2020 18:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sl1KikS52sGJPVrPLK+8FiRqIhEolxXqPVH9h+iV/qM=;
        b=TvBPYk5uBJKRUMKdn/5PjFzXhl77yWTsuqkUIE9aCSHtnWp6h/g5Fr6zJO93QAxIQW
         iED1kveOiXox4N6IFgoT3ogXoBoonDedjJ/9nu4T8eiWYl5kkY4JitUZhpb8W/s3ZTc/
         Nakdg84Czr+SuDW73vVZ4v20nliWhEd+sRNcd2ycL42jCLewVe+uAcePQ0WKpARN7Tlp
         gNE/hZMoIQ7+oX9obj/gZL1RXcVoIKshpmBhDgIyBt7OCX7L3WMIvOEudxr0Wy/H5zob
         Sx1A7m3AxqvloUI9Ta8XuD30Se38TsynYN9Xixe7H/pJ3IlGZvl0KGQqmEzrK2EOteC3
         bLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sl1KikS52sGJPVrPLK+8FiRqIhEolxXqPVH9h+iV/qM=;
        b=pQpZz6HT022Nb9I+FQ2HkZlq+oOTTjUmZ0hR+4qP+40vLu+osPDpCveZP7SA1bljFX
         qbrKzYrDR5EiHFC/d2+3zRweYSJski2G1ZcbEHSIjVjBAiVYdPrc66qf3+jjeMENc5Zs
         jqwOgFHItlzGa+w2i7rWJyyt8FJPFcg/TOh8uueMdng1FEV5RTT4W5PpLIPKIwJKF+Tr
         8KkYd6fsoS/9sWeVxR2fre0B72EjFVt9LHFML9LIPgT/+tAT+KBOU3VL9jqOPDrvjhD3
         QDo4DCaJkspSRuGfMyqFYtkDLxYu95JUuby98PB8d5kC96um5FjyEOqmTVLpH5LCXTyv
         kVlg==
X-Gm-Message-State: APjAAAUVWLShceFf3A+WUE2UBNS1j4HcOsl0vpxwRdFnH3VB0TYbb22G
        p3M+rryzl/LEsXutrbzS5So=
X-Google-Smtp-Source: APXvYqyHqZXWPpceO9hzmQaUmASYiR+1ccnOi1M0S+OCCjxv6BIQSEJK+470cz2BY1p8IHXTTCdtoA==
X-Received: by 2002:a05:6214:15cf:: with SMTP id p15mr14705117qvz.140.1580093237219;
        Sun, 26 Jan 2020 18:47:17 -0800 (PST)
Received: from localhost.localdomain (200.146.53.109.dynamic.dialup.gvt.net.br. [200.146.53.109])
        by smtp.gmail.com with ESMTPSA id c184sm8643337qke.118.2020.01.26.18.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 18:47:16 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 2/5] libbtrfsutil: add IOC_SNAP_DESTROY_V2 to ioctl.h
Date:   Sun, 26 Jan 2020 23:49:51 -0300
Message-Id: <20200127024954.16916-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200127024954.16916-1-marcos.souza.org@gmail.com>
References: <20200127024954.16916-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This ioctl will make possible to delete a subvolume/snapshot by using
the subvolume id.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 libbtrfsutil/btrfs.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
index c9a61b30..fe478ab1 100644
--- a/libbtrfsutil/btrfs.h
+++ b/libbtrfsutil/btrfs.h
@@ -36,12 +36,14 @@ struct btrfs_ioctl_vol_args {
 #define BTRFS_DEVICE_PATH_NAME_MAX 1024
 
 #define BTRFS_DEVICE_SPEC_BY_ID		(1ULL << 3)
+#define BTRFS_SUBVOL_BY_ID	(1ULL << 4)
 
 #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
 			(BTRFS_SUBVOL_CREATE_ASYNC |	\
 			BTRFS_SUBVOL_RDONLY |		\
 			BTRFS_SUBVOL_QGROUP_INHERIT |	\
-			BTRFS_DEVICE_SPEC_BY_ID)
+			BTRFS_DEVICE_SPEC_BY_ID |	\
+			BTRFS_SUBVOL_BY_ID)
 
 #define BTRFS_FSID_SIZE 16
 #define BTRFS_UUID_SIZE 16
@@ -118,7 +120,10 @@ struct btrfs_ioctl_vol_args_v2 {
 		__u64 unused[4];
 	};
 	union {
-		char name[BTRFS_SUBVOL_NAME_MAX + 1];
+		union {
+			char name[BTRFS_SUBVOL_NAME_MAX + 1];
+			__u64 subvolid;
+		};
 		__u64 devid;
 	};
 };
@@ -942,5 +947,7 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_get_subvol_rootref_args)
 #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
 				struct btrfs_ioctl_ino_lookup_user_args)
+#define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
+				struct btrfs_ioctl_vol_args_v2)
 
 #endif /* _LINUX_BTRFS_H */
-- 
2.24.0

