Return-Path: <linux-btrfs+bounces-22076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKJpGAnjoWmUwwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22076-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 19:31:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1E71BBFE0
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 19:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 370E33026B76
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 18:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A956395D81;
	Fri, 27 Feb 2026 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9WZ8ez7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5354C3803C6
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772217090; cv=none; b=FUP87UdLSTQQmfUxk3voP49rjGr+OZk5iohUdG61Nhfj6aodW69CieaJ5mKbsMpqkOYC/sTwFkOf8DWH0q2YlERswLYOl1CdpklBFyAS07fXw3KqSkcIRmTxwfzhmOElcf9S4ArnhoQcdqgGmChKabWDWgwEfdVhgXBDJzhtSAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772217090; c=relaxed/simple;
	bh=YkEWqnBAPzrqci0BPAz5n9V4vIu9oUwhi4bREqwiwYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6H0Y/AeN4cZEzi696UbK6Wk/0Hvm40HWFaoeHMmyZgGK21788OoMGSYywMfWd/S7Vf50r8y4Iy8ew0qarEsRHDORMXnKVsWP69k/2AmYrBb8alpT6p9rGVariP77tsiWxptvv7VI4f9QssGMXWECW8UEQ56qKoIXL2OftNBAWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9WZ8ez7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2adec255754so16109395ad.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 10:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772217089; x=1772821889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbJVYmXAbJJyKUBv1gVLWbj/RUC93TROXsUjXVfF1X4=;
        b=G9WZ8ez7OTtIMboZWnY7fu5mtitALVvtOI4lEipqXwSkiC5OpPEJajDvfJfkp2Dcbi
         YG4Kt/j/Eg0w+3OEbrz2duGZoO9mMt/FB8ci61qsJwnvnTK3s5chKX2vAM+US3YVPXv5
         52h2Md6U6Ng0lHSkZVn0MuYPTf3NUOYkAc42beUexHuVXXcfJAT0qoFkyQ8dYtCrQ8bj
         dPwuCZepJpO2a+Tdv2SUJGwdu9gy/ZXekco3fhLKNMe19Cwb5SFMVy6JZzE7qT5SS6Aj
         FsOxRg4hXNNCieBiKg9mc7rb/jqsPKEg7nuUz8RylVp5Rk5U6Psu1UnWzx4T7JQTsoUb
         Do6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772217089; x=1772821889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rbJVYmXAbJJyKUBv1gVLWbj/RUC93TROXsUjXVfF1X4=;
        b=oKMNzYVLGpBolfFO0f9Q6QRnA6qmO1Qc/6aug2TaAcG0QC7dPv5xVVMnC4drMC/iQJ
         XtHtOW2xGoR4WiNKuKD9ez9F1Lal6D9tN//xZJh3yOZJSpcVSwgimq9rgOX5Qh0hv/8U
         7/3rKjzD0ey+omVwG7iXAS4GNctqq3gmkT5f7LEzAwGUSxEBXoBqIRxj/sojtXvT6hxr
         Ta4972xBN8fN5OKAh8WAJrA+qgZ3MFjI20U88yPKoZkCZj4BbM1i+w6pdvv1sH1TPJoB
         kspxJ6p0r27pJ+ylzdu5QvOalT7IRU7aJPQs7VEN/b5XOPJ3NE7Uitk0Q5Lz8l0cP6La
         4qGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW6s51DcSsmMGkU0BFhRoGSEvXdkf3tCBLP8gaviOPJO60aGFpiyeECF0rSUtYQaGQVzE02Y/wcZgvRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTExkbMiuGRpr7hoxDaBgIYJ+RF+6EEuOSUWvOvwi8XFNjCc4M
	MExt9uI/mJ+hU5h7SNDFGcKoGRb93SR2xgxHYos/OZR8env0eWntsqC9
X-Gm-Gg: ATEYQzxtjvZ0bp2c1VC+gtPlptlKeF9PXFSuf+ekn9ycftjTBRgAK4EQZDvoYFIxmP2
	HagLjBaO4MZfMh4K1vGH66iRUZjJwNNcdycI866KDID6r6SHirx7nkBgOuYh3DPFKZ1XtnFxs2W
	8qHledlvk6A6dPLowpcTMSDso4cNdgYNTvz3PzjIILCaUdC6dHvZcy40KiLBIBdX/SjXMwjt43G
	8plbCyE71vCMkZ9eGFcjL/qH5pX8KgpaVP+OGfUhY+sLLlwxwnGXuPNOxkBwD7j6MdPgpKw2Nuk
	sjukDZnCoSuCpGewbknovyoOZ7SDm5FvPm/lNk5yymeIkK2/u02W0voktnGZJus3haWYMBs15L+
	lSaUvOMkxwl6nPHPTF8kRFnj/itgkpJtX4BuozJYpCb6ssUvlvcJ32eSYwJlOCofyPdhy8UAdwW
	mP5mAPY0Ux4pCJDrqX9R4dViGr
X-Received: by 2002:a17:902:ce84:b0:2ad:bd4c:9d with SMTP id d9443c01a7336-2ae2e3edc27mr43025325ad.3.1772217088429;
        Fri, 27 Feb 2026 10:31:28 -0800 (PST)
Received: from archlinux ([103.208.68.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbad2sm61932485ad.34.2026.02.27.10.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 10:31:28 -0800 (PST)
From: Adarsh Das <adarshdas950@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: terrelln@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adarsh Das <adarshdas950@gmail.com>
Subject: [PATCH 1/4] btrfs: replace BUG() with error handling in compression.c
Date: Sat, 28 Feb 2026 00:01:08 +0530
Message-ID: <20260227183111.9311-2-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227183111.9311-1-adarshdas950@gmail.com>
References: <20260227183111.9311-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-22076-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adarshdas950@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF1E71BBFE0
X-Rspamd-Action: no action

Replace BUG() calls with proper error handling. Where fs_info is
available, use btrfs_err() and return -EUCLEAN. Where fs_info is
not available, use WARN_ONCE() with the invalid type value so the
stack trace carries enough context for debugging.

Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
 fs/btrfs/compression.c | 42 ++++++++++++------------------------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 790518a8c803..29281aba925e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -95,11 +95,9 @@ static int compression_decompress_bio(struct list_head *ws,
 	case BTRFS_COMPRESS_ZSTD: return zstd_decompress_bio(ws, cb);
 	case BTRFS_COMPRESS_NONE:
 	default:
-		/*
-		 * This can't happen, the type is validated several times
-		 * before we get here.
-		 */
-		BUG();
+		btrfs_err(cb_to_fs_info(cb), "invalid compression type %d",
+			  cb->compress_type);
+		return -EUCLEAN;
 	}
 }
 
@@ -116,11 +114,7 @@ static int compression_decompress(int type, struct list_head *ws,
 						dest_pgoff, srclen, destlen);
 	case BTRFS_COMPRESS_NONE:
 	default:
-		/*
-		 * This can't happen, the type is validated several times
-		 * before we get here.
-		 */
-		BUG();
+		return -EUCLEAN;
 	}
 }
 
@@ -703,11 +697,8 @@ static struct list_head *alloc_workspace(struct btrfs_fs_info *fs_info, int type
 	case BTRFS_COMPRESS_LZO:  return lzo_alloc_workspace(fs_info);
 	case BTRFS_COMPRESS_ZSTD: return zstd_alloc_workspace(fs_info, level);
 	default:
-		/*
-		 * This can't happen, the type is validated several times
-		 * before we get here.
-		 */
-		BUG();
+		btrfs_err(fs_info, "invalid compression type %d", type);
+		return ERR_PTR(-EUCLEAN);
 	}
 }
 
@@ -719,11 +710,8 @@ static void free_workspace(int type, struct list_head *ws)
 	case BTRFS_COMPRESS_LZO:  return lzo_free_workspace(ws);
 	case BTRFS_COMPRESS_ZSTD: return zstd_free_workspace(ws);
 	default:
-		/*
-		 * This can't happen, the type is validated several times
-		 * before we get here.
-		 */
-		BUG();
+		WARN_ONCE(1, "invalid compression type %d", type);
+		return;
 	}
 }
 
@@ -874,11 +862,8 @@ static struct list_head *get_workspace(struct btrfs_fs_info *fs_info, int type,
 	case BTRFS_COMPRESS_LZO:  return btrfs_get_workspace(fs_info, type, level);
 	case BTRFS_COMPRESS_ZSTD: return zstd_get_workspace(fs_info, level);
 	default:
-		/*
-		 * This can't happen, the type is validated several times
-		 * before we get here.
-		 */
-		BUG();
+		btrfs_err(fs_info, "invalid compression type %d", type);
+		return ERR_PTR(-EUCLEAN);
 	}
 }
 
@@ -925,11 +910,8 @@ static void put_workspace(struct btrfs_fs_info *fs_info, int type, struct list_h
 	case BTRFS_COMPRESS_LZO:  return btrfs_put_workspace(fs_info, type, ws);
 	case BTRFS_COMPRESS_ZSTD: return zstd_put_workspace(fs_info, ws);
 	default:
-		/*
-		 * This can't happen, the type is validated several times
-		 * before we get here.
-		 */
-		BUG();
+		btrfs_err(fs_info, "invalid compression type %d", type);
+		return;
 	}
 }
 
-- 
2.53.0


