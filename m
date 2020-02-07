Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FD115581C
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 14:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBGNIN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 08:08:13 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:38099 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGNIN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 08:08:13 -0500
Received: by mail-wm1-f54.google.com with SMTP id a9so2701024wmj.3
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2020 05:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9/eeeHlzoWhaSK6jaeBjzRsz51KkIgRQMHuC/ESSF2U=;
        b=fVgsqZa+5UkmKw69WhK9JYgRH6g3/1VnPvvg3uKo/Y52Si0XJ6ok6ZTjdsaTuiEta+
         mzfUjUxiFG6GDHxD5Z0N2Q8RmAqXRZ58DURGtSPVVXU03Eo5td39yL7wxRYsILtFiEeB
         zI4/Qf8gpaNTFqbB+3dJM083lP81j9bpZ8P5r1dq2ACtjmJQ8/AoRvo2CohFyovVA6mZ
         E+YxDko8gWcnEs3AX3bf5pFz4OSst6x0TlQfJ1e8ZvbTLGZUcgp1Yu638SeGOR/NAbM3
         1dJVmxVDoh1jeSeE72LkH4ZakWIpkfvzN6vcST1RK+Mz3uYjaDGFNSWQMstXVyuYnoFu
         LIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/eeeHlzoWhaSK6jaeBjzRsz51KkIgRQMHuC/ESSF2U=;
        b=kZanKDcXmspsvfQ+SWEWxwjrbiM2jaHOwiJ+lAQ+uHiMv06Z9uXwI2X/9gaOldCdxg
         WpwTifRs3dkFv/CnoxFto8xFygkWte2ryrx5SIGzhxDkKlGgN62dh3QuXoolRQCZHuuE
         1K2Y+E2h5YtRlfCdRKxSq2RZsmKvkYQFJB92EUv+HeABpggIWofE8dRricEFYZZ1/WYb
         kHIkXAjFWwH73jw6mmy3TjPqcknqJ7s5eBTivGsHFxloF1NYAJPysNpqMlHq4933tXLf
         b1e3CrDXwApjhIEWFJgwylul1Xb3bNf5/Uk/R+Ww7DFE9rAfyV0WuVn0L6bwmNnr/GpZ
         xroQ==
X-Gm-Message-State: APjAAAVjQHG4gMJdQLh7qqWakBUsR/pH+83HP7c+NGb25CS04wTkHlH+
        1sm6ayc9EJeSG2Hm9tNaeC0=
X-Google-Smtp-Source: APXvYqzct3B+1F4M0vosfPAMULQ960gMgWqpTCMkNaLsOy+liFRzfhCva2koRlj3gcrgHfPIP8sHsw==
X-Received: by 2002:a1c:4d07:: with SMTP id o7mr4497369wmh.174.1581080891341;
        Fri, 07 Feb 2020 05:08:11 -0800 (PST)
Received: from hephaestus.suse.de ([186.212.94.124])
        by smtp.gmail.com with ESMTPSA id n1sm3260702wrw.52.2020.02.07.05.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 05:08:10 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv2 1/4] btrfs-progs: add IOC_SNAP_DESTROY_V2 to ioctl.h
Date:   Fri,  7 Feb 2020 10:10:25 -0300
Message-Id: <20200207131028.9977-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200207131028.9977-1-marcos.souza.org@gmail.com>
References: <20200207131028.9977-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This ioctl will make possible to delete a subvolume/snapshot by using
the subvolume id.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---

Changes from v1:
* Moved subvolid member to the same union containing name and devid (David)
* Changed BTRFS_SUBVOL_DELETE_BY_ID to BTRFS_SUBVOL_SPEC_BY_ID (David,
  Christoph)

 ioctl.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ioctl.h b/ioctl.h
index 1d53c100..1a2882df 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -53,12 +53,14 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args) == 4096);
 #define BTRFS_SUBVOL_RDONLY		(1ULL << 1)
 #define BTRFS_SUBVOL_QGROUP_INHERIT	(1ULL << 2)
 #define BTRFS_DEVICE_SPEC_BY_ID		(1ULL << 3)
+#define BTRFS_SUBVOL_SPEC_BY_ID		(1ULL << 4)
 
 #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
 			(BTRFS_SUBVOL_CREATE_ASYNC |	\
 			BTRFS_SUBVOL_RDONLY |		\
 			BTRFS_SUBVOL_QGROUP_INHERIT |	\
-			BTRFS_DEVICE_SPEC_BY_ID)
+			BTRFS_DEVICE_SPEC_BY_ID |	\
+			BTRFS_SUBVOL_SPEC_BY_ID)
 
 #define BTRFS_FSID_SIZE 16
 #define BTRFS_UUID_SIZE 16
@@ -104,6 +106,7 @@ struct btrfs_ioctl_vol_args_v2 {
 	};
 	union {
 		char name[BTRFS_SUBVOL_NAME_MAX + 1];
+		__u64 subvolid;
 		__u64 devid;
 	};
 };
@@ -940,6 +943,9 @@ static inline char *btrfs_err_str(enum btrfs_err_code err_code)
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

