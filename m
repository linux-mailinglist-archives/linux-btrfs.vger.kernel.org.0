Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85124149E4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 03:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgA0CrQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jan 2020 21:47:16 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39960 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgA0CrP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jan 2020 21:47:15 -0500
Received: by mail-qv1-f66.google.com with SMTP id dp13so3824608qvb.7
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Jan 2020 18:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbkQGPFAWmKYo0rZ1cMDbYcu7w8CMW/6+w5W7pmoMrs=;
        b=BSvjLm6OTNj5lou5iePulrXmnc0M8FhBirxjNMMjXAKrGIHhxwI4S6lPUhC8Oa5cgs
         7XjSICxl3Sr6dJgwm12owXeETOBAMfYUm2BK51iwS795S+w7TLoyGByQBKDlsjkJ1cGz
         1Ro5BlcY4TrcZQgf/+EqkSdOJGl8zHM7JxWzZaDm1CSZXMSFVSc+BrOgp9scWKHKLdQ/
         h5+vrrA/j8TifBlrvYYpSMRdox3SBNFbmMHnP4uBWSiN+SVlCINbIJsLsF82dtLwIW8l
         vuepMZRRkoapXg3ToQ1rPKKxReGEGS47CJh5IiePGXUtoe6u4W4QS5SY0Xiy3o2+qGTd
         WNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbkQGPFAWmKYo0rZ1cMDbYcu7w8CMW/6+w5W7pmoMrs=;
        b=OgZuYiOPedejsESPucVcnnDpXLKnehf9hPn1Or3Yt/F4EBKdOoANCdrjKu7/Nu828S
         ZwFlJwiPCxyTHjh1Ts0q0OGa14T7+h9nYq/zfDwDbcH0bfA3fPPscRUs5HdgB2sdhNOm
         c6bZquMMNK8GNkL7YtWvE9mKGnh0+/Yfi06d+NzH7yqSAF+vnhmplZR2jX98l/iysmYY
         FgIXunZnEep6vfo0am+Gw3idMf3A0y8c3Uk084qtKt82Eh1inpoN3fnudiePkePsZuBL
         0V5w1pl39/VBG8EGmqgvdbvBJUgsOVJOBiDP514YTfYCPGMHFgc7wm6PjEJL4U2QcEpG
         d4Fg==
X-Gm-Message-State: APjAAAUJdiN0UEeHDW6G9Zwzp8xwr/3ydVEywbWCUFtrTLHiP2opmHfK
        7s8rhsBkvEI6Utjezfb9S9w=
X-Google-Smtp-Source: APXvYqwW/ernVyHwUSeF+bAiMnitjQUpQcp/Iq0EuUv7H6vxj/hqWZZqONLV9UEDfhj0M77A8DGQaw==
X-Received: by 2002:a05:6214:94b:: with SMTP id dn11mr14497756qvb.12.1580093234730;
        Sun, 26 Jan 2020 18:47:14 -0800 (PST)
Received: from localhost.localdomain (200.146.53.109.dynamic.dialup.gvt.net.br. [200.146.53.109])
        by smtp.gmail.com with ESMTPSA id c184sm8643337qke.118.2020.01.26.18.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 18:47:14 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 1/5] btrfs-progs: add IOC_SNAP_DESTROY_V2 to ioctl.h
Date:   Sun, 26 Jan 2020 23:49:50 -0300
Message-Id: <20200127024954.16916-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
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
 ioctl.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/ioctl.h b/ioctl.h
index 1d53c100..d4cf71de 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -53,12 +53,14 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args) == 4096);
 #define BTRFS_SUBVOL_RDONLY		(1ULL << 1)
 #define BTRFS_SUBVOL_QGROUP_INHERIT	(1ULL << 2)
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
@@ -103,7 +105,10 @@ struct btrfs_ioctl_vol_args_v2 {
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
@@ -940,6 +945,9 @@ static inline char *btrfs_err_str(enum btrfs_err_code err_code)
 				struct btrfs_ioctl_get_subvol_rootref_args)
 #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
 				struct btrfs_ioctl_ino_lookup_user_args)
+#define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
+				   struct btrfs_ioctl_vol_args_v2)
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.24.0

