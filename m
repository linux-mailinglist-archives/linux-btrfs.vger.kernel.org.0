Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71447DFAB2
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 04:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbfJVCAd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 22:00:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33857 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbfJVCAc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 22:00:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id e14so4632203qto.1
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 19:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=exC+Iu3uE8H1omtVa0Swd+N84x/kgFLsuUGXDgh1/5Y=;
        b=I4FiRu43IHYM4uD8V9YP3SLyCfVIjQpggJFlgW2Xlzwdf2ZwZU6EQLCBpJ0D2ObJMq
         dyZqnPa7q/3srzDalvIXtNA2GGVHpXnHkmvDIaWb8HfQZn2kd4C5S2xjIEdx0QirFK7/
         2NR2T5nY+NG2FG6V838WK9NcGErdvI2Is60xdhcCD2SB47I6V8k7bLtozHBnIs6AeQf7
         ItW36+afAS6TrS349H11DmM+4IY8ig31KukNanqobiv9HxoAbyuduCh0iwglHgW0HqHT
         FHBwYnduoukHETtOAsGc8rIqK2HSm+MSdmBIjUETW1X9IA2ibe0OV+JuRzSvPaUE01LA
         JucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=exC+Iu3uE8H1omtVa0Swd+N84x/kgFLsuUGXDgh1/5Y=;
        b=SUDbttptTSHx4lTlGet1RaI4VRsihWSl7DIhPPH9HaE62/sYHlyPN4M715ssh8tCv/
         MndzYJEnFeA+bqVgBqapexh5YXex3k2eonrk+ZgH+6ds7Fu6M0ezHGO+PsSNDKUwT8KA
         8X37mISF0vNcUO4u1mNM1EJQevSrWgtilsvIpZjmy/ZMYuWiR80Q4lLRa43oBcYGaaEs
         uBXnDmNW9XbIQNGxuf8jaN9bo0GPhPRlDWVUe0AMCGCQuiwTI+WT0H6o7bEOZTN2htOz
         iSy4rZF0+Ji17gu2Bc4v4ecoTZD6EjpY9NkPHLVBogfQs2X1QRG4DiqB+ObG5xD703cC
         erJw==
X-Gm-Message-State: APjAAAV+OvA6IwfQg2ZA2iIWGtt74c79m2J1kjTz6XdrrN4FPKJsUct8
        q3LHjojW30MbDjvZ8EtopQw=
X-Google-Smtp-Source: APXvYqwT9oGRu0M0Y+l5bgBH097IeMHfng4sN5pBSW80X1Qbrqp65ELXMsKQrPC8UASmBQF8Jp8vzg==
X-Received: by 2002:ac8:610e:: with SMTP id a14mr917382qtm.189.1571709630891;
        Mon, 21 Oct 2019 19:00:30 -0700 (PDT)
Received: from localhost.localdomain (189.26.180.57.dynamic.adsl.gvt.net.br. [189.26.180.57])
        by smtp.gmail.com with ESMTPSA id t65sm8511120qkh.23.2019.10.21.19.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 19:00:30 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 1/2] btrfs-progs: utils: Replace __attribute__(fallthrough)
Date:   Mon, 21 Oct 2019 23:02:27 -0300
Message-Id: <20191022020228.14117-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022020228.14117-1-marcos.souza.org@gmail.com>
References: <20191022020228.14117-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

When compiling with clang, this warning is shown:

common/utils.c:404:3: warning: declaration does not declare anything [-Wmissing-declarations]
                __attribute__ ((fallthrough));

This attribute seems to silence the same warning in GCC. Changing this
attribute with /* fallthrough */ fixes the warning for both gcc and
clang.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 common/utils.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/utils.c b/common/utils.c
index 2cf15c33..a88336b3 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -401,15 +401,15 @@ int pretty_size_snprintf(u64 size, char *str, size_t str_size, unsigned unit_mod
 	case UNITS_TBYTES:
 		base *= mult;
 		num_divs++;
-		__attribute__ ((fallthrough));
+		/* fallthrough */
 	case UNITS_GBYTES:
 		base *= mult;
 		num_divs++;
-		__attribute__ ((fallthrough));
+		/* fallthrough */
 	case UNITS_MBYTES:
 		base *= mult;
 		num_divs++;
-		__attribute__ ((fallthrough));
+		/* fallthrough */
 	case UNITS_KBYTES:
 		num_divs++;
 		break;
@@ -1135,14 +1135,14 @@ int test_num_disk_vs_raid(u64 metadata_profile, u64 data_profile,
 	default:
 	case 4:
 		allowed |= BTRFS_BLOCK_GROUP_RAID10;
-		__attribute__ ((fallthrough));
+		/* fallthrough */
 	case 3:
 		allowed |= BTRFS_BLOCK_GROUP_RAID6;
-		__attribute__ ((fallthrough));
+		/* fallthrough */
 	case 2:
 		allowed |= BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID1 |
 			BTRFS_BLOCK_GROUP_RAID5;
-		__attribute__ ((fallthrough));
+		/* fallthrough */
 	case 1:
 		allowed |= BTRFS_BLOCK_GROUP_DUP;
 	}
-- 
2.23.0

