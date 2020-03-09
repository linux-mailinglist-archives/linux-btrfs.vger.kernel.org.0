Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A306317EB3E
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgCIVdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:33:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43655 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgCIVdD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:33:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id c144so5421584pfb.10
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yua5TyER8qIELEn13ECCqGFnZ6AZvZjKXf3ys07KGec=;
        b=ScnBdFvrRSC7aoTecoKTv3RRBni+c4SGyrc4sG5oQL/tXrh+JqAzxe6fAjZIcjbRNN
         n/17PQOkgjuYgAqEH1+eq/pUeshm/nccHT32s1Q0eOnjU7hZrVPpRQvaakqJnX4o1EJa
         +15t0KiPw6LK2OJ47HmRAciUcCVWo3OAh2CYjqF42jWQb0bMkgOaoXThiShMTQTBburA
         7UA0HSLh7tFYg3wvdqEyT0JjKm+/ETV7/PRmamojMEtHY/X0coELoNQkrBTEnm7PHg+9
         RgdEx9fR/Wp7ERFJU+je4zVAKKuYJ9T0Z6fT5/AXasT8A3jEqq87CH5ayD6ZyzgAaNwW
         09cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yua5TyER8qIELEn13ECCqGFnZ6AZvZjKXf3ys07KGec=;
        b=T/iBH8g7jsGj51sQ0ABI+mgQtTIDaXJGZfN1EK/0Z/MKYNnT82uslW6yRRO9RrnifO
         ymM725kzjlQoDrJwAzaNlnb/m1lOABb/LssrKsvQ2xFSZYfFL3BLnFStUb4+554cxAC1
         LbHPONKGPTSVTINmUmjspIgNwZkG4itEjLNDDRtmN1XJaiqHlKoDqbOK5JbHqvNKCxU/
         6cLL36az5ZCvglBenuwWE/t7IPcERdoIq5RmxPkfuuk8nMQzKGVNH8MURVOG7ulKbG0N
         hjotYwLyCdnnGIk/F8IFvfYHNGs+iMrRNVkTvzK8sPwTKgfc+CFbxo6TnDWiYT9xrqy9
         JziQ==
X-Gm-Message-State: ANhLgQ1TpKol1G+e1oyn6R8GaMtrMMGoNR8jgNfRpKoO4jKRFtXXHn23
        Dc7kvfBY9NV9PGVK8w6J7o4uApW3twQ=
X-Google-Smtp-Source: ADFU+vvyv/K32iei+u0wc+bOS/kov+7h06hPOO2OM5O+HFLy73VEcd8yprRWMXMxjC0AzEv6b7uNCA==
X-Received: by 2002:a63:7b18:: with SMTP id w24mr17859941pgc.22.1583789582333;
        Mon, 09 Mar 2020 14:33:02 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:33:01 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 07/15] btrfs: make btrfs_check_repairable() static
Date:   Mon,  9 Mar 2020 14:32:33 -0700
Message-Id: <1ba159f3930fca7d11350f798ba140e1a2176358.1583789410.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583789410.git.osandov@fb.com>
References: <cover.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Since its introduction in commit 2fe6303e7cd0 ("Btrfs: split
bio_readpage_error into several functions"), btrfs_check_repairable()
has only been used from extent_io.c where it is defined.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/extent_io.c | 7 ++++---
 fs/btrfs/extent_io.h | 3 ---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 104374854cf1..aee35d431f91 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2528,9 +2528,10 @@ int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
 	return 0;
 }
 
-bool btrfs_check_repairable(struct inode *inode, bool need_validation,
-			    struct io_failure_record *failrec,
-			    int failed_mirror)
+static bool btrfs_check_repairable(struct inode *inode,
+				   bool need_validation,
+				   struct io_failure_record *failrec,
+				   int failed_mirror)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	int num_copies;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 64e176995af2..11341a430007 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -312,9 +312,6 @@ struct io_failure_record {
 };
 
 
-bool btrfs_check_repairable(struct inode *inode, bool need_validation,
-			    struct io_failure_record *failrec,
-			    int failed_mirror);
 struct bio *btrfs_create_repair_bio(struct inode *inode, struct bio *failed_bio,
 				    struct io_failure_record *failrec,
 				    struct page *page, int pg_offset, int icsum,
-- 
2.25.1

