Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDBC39FAF5
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhFHPih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Jun 2021 11:38:37 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:35798 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhFHPih (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Jun 2021 11:38:37 -0400
Received: by mail-pj1-f41.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso7777318pjb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Jun 2021 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BiD/Sie5ANsJtsF7Xh3x8auSFZYSwxMwh4yZVQHEapI=;
        b=hvLhBDR92jBTpT/ha7qBTsSRolqSplveEWdeRD13Nb3MiFdJmQFg8L/JJY7lTZ+ZOP
         s09U037aZCcP3OKX+HIb77R7F+cr5sIKBmamLkLbOby5EPeXW517US9Az3nVyrm0iLt+
         u+npPfM2ctlZ3XpOea6rMHUG5Bi6zKwpCMMP/e68fxX+PKyjJHshQRw7/pmSbizpGrgi
         wTEoQuftjr6G/bgMal7Za71q5QMWPFtPnGxN85Wn5r9g5ZMtV8gMEnL4UJ1wirzd/J2N
         3A73WW9xbBItPW0D+rVoEBerZkPT2I8d66UYlT+PQJL67K4cmKScb7bBLLjH/t1G+SDN
         Xxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BiD/Sie5ANsJtsF7Xh3x8auSFZYSwxMwh4yZVQHEapI=;
        b=RSA8aJzGni4XIGFZQul6+Kb8xTlQfBOi8ky99bsA3BhaqY9T4VKdi1umBaww9xK8pR
         HuboLN+Axm9C0bsJPCbO2NbfmXFQea6suyV9WuxFtdZNiLnHL7iWutmdbX7RymjbedNa
         LAWJikyYebvYey6+ROMmm7VSgR8FVhoHOSBUQqzQIH5JA74JvvV6+J0UPonmuUgbqwOw
         QhNco4pEouvFkzVvXsaAzizL7wriNoB0iiCyiykX0dOWXrBVldX44juFsZH4izw6L5gW
         vzi0a1CODb+HVQEyWzXO5MytAC3Q/qlwodpeuTJZUVK+/zjchWyNPK/jXPyZ+t/J4pmH
         OFUw==
X-Gm-Message-State: AOAM531+CziJrJD8dG+jnM5opbyVYq84f1OYrRWPnUIiHIb86SsbQSI9
        mmM7RMn0L0sLb3QYIcm3APY=
X-Google-Smtp-Source: ABdhPJwiU4/HYOqpHl/CMtjwdM18goDyuzdVUw/8TzV/dUmhz8jJJWe65LZeRia8o9phTykfI+OYxA==
X-Received: by 2002:a17:902:d50f:b029:10c:85d:6ae8 with SMTP id b15-20020a170902d50fb029010c085d6ae8mr230184plg.56.1623166531208;
        Tue, 08 Jun 2021 08:35:31 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id in24sm8120551pjb.54.2021.06.08.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:35:30 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2] btrfs-progs: device: print num_stripes in usage command
Date:   Tue,  8 Jun 2021 15:35:20 +0000
Message-Id: <20210608153520.820445-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch prints num_stripes for striping profiles in device usage commands.
It helps to see profiles easily. The output is like below.

/dev/vdc, ID: 1
   Device size:             1.00GiB
   Device slack:              0.00B
   Data,RAID0/2:          912.62MiB
   Metadata,RAID1:        102.38MiB
   System,RAID1:            8.00MiB
   Unallocated:             1.00MiB

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2:
 - print stripes if striping raid
 - use separator "/"
---
 cmds/filesystem-usage.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 107453d4..b92a4860 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -1192,20 +1192,41 @@ void print_device_chunks(struct device_info *devinfo,
 		const char *r_mode;
 		u64 flags;
 		u64 size;
+		u64 num_stripes;
+		u64 profile;
 
 		if (chunks_info_ptr[i].devid != devinfo->devid)
 			continue;
 
 		flags = chunks_info_ptr[i].type;
+		profile = flags & BTRFS_BLOCK_GROUP_PROFILE_MASK;
 
 		description = btrfs_group_type_str(flags);
 		r_mode = btrfs_group_profile_str(flags);
 		size = calc_chunk_size(chunks_info_ptr+i);
-		printf("   %s,%s:%*s%10s\n",
-			description,
-			r_mode,
-			(int)(20 - strlen(description) - strlen(r_mode)), "",
-			pretty_size_mode(size, unit_mode));
+		num_stripes = chunks_info_ptr[i].num_stripes;
+
+		switch (profile) {
+		case BTRFS_BLOCK_GROUP_RAID0:
+		case BTRFS_BLOCK_GROUP_RAID5:
+		case BTRFS_BLOCK_GROUP_RAID6:
+		case BTRFS_BLOCK_GROUP_RAID10:			
+			printf("   %s,%s/%llu:%*s%10s\n",
+				   description,
+				   r_mode,
+				   num_stripes,
+				   (int)(20 - strlen(description) - strlen(r_mode)
+						 - count_digits(num_stripes) - 1), "",
+				   pretty_size_mode(size, unit_mode));
+			break;
+		default:
+			printf("   %s,%s:%*s%10s\n",
+				   description,
+				   r_mode,
+				   (int)(20 - strlen(description) - strlen(r_mode)), "",
+				   pretty_size_mode(size, unit_mode));
+			break;
+		}
 
 		allocated += size;
 
-- 
2.25.1

