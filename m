Return-Path: <linux-btrfs+bounces-15988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42708B20C37
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 16:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 476E07A65CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6372DAFBB;
	Mon, 11 Aug 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkayUyg9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465BF264A60
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923199; cv=none; b=OhxCps/2BZhxhAet5zJvuW1gUZaLnrrMI12tPB24K/dg99lAJFBk0DrILFlcfQE5FtrXDExxVmH/c1Ke3vexoFYV9c4XPZ0HvN7KnLGCX9Q4s+p8vthlLt2jk0pm94Ao8kDXCTxvVdOMURkG4KGXxp2V+VjdDXfpX4I5JNLRopA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923199; c=relaxed/simple;
	bh=/RkJtjEV80XxhNf5as20u3EFMwDFY27Gb0v/Rq5JlbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhECVDE+UQE0YtPGYJ5Jx4lE6blS7AK1xYyRxPsO/4AQ5HTO0qpDquXlJgeJdGjXWU7h8ac2+9/14ClTrJIDWzveiENNhitxOYgq25VZ4gIwFdBV0wQWhckpE2b/GINJFU6p51ZRjgl7mYg7GtzXa/ZTSFX/aQWztx5n6WL1vv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkayUyg9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754923197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xm0iYFfBOfajjEoxheRfcdwl0u9A+taNg4Dew7papsc=;
	b=PkayUyg9xwuO0gq3Iip+vFP2EBfR8K9mq66WdTxJaz3ZPaaFTnty9QABPxDj5i/4ETjuR+
	ehyemP/ozAK19swpvFRTWV7RnDwfxgW+dllrtxG3Fr1Z8ErfuAfMU1ZKVPqCi4ENJkZ6LH
	cRIvqa+vUKPiC8apGDW9XpHSLKyInOg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-DZpPvjDtNBCHpemSjV2emA-1; Mon, 11 Aug 2025 10:39:56 -0400
X-MC-Unique: DZpPvjDtNBCHpemSjV2emA-1
X-Mimecast-MFC-AGG-ID: DZpPvjDtNBCHpemSjV2emA_1754923195
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so23341975e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 07:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923195; x=1755527995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm0iYFfBOfajjEoxheRfcdwl0u9A+taNg4Dew7papsc=;
        b=P0b3WFSkiGWHkZ6kVYuY6ExlMuD1IJDcyil2RHnq2fBsslneD1mgwCL8WwrjwZsLW7
         pMkBgptB4DSvRbe3Ii0TVGLmLjuNznTZdqRNCVRIPqOnlFK7GU2W9NjZWGkBKb3Fk21+
         zjR//gk5EwCaqQPyLxU/5rx5gJQGywgB8Wqzd3L3JCUY+To/UlUv/HwX2GElxuOZG4ke
         Vp8xJojJPlz1/BXNJVLuqDCkQW5vOXhaM4l5jgKmscAxb3GpaOsHAq+k29E3/8NIwkuC
         ZmkJ3n9h9AS5u6UVW8i8UFynhexyX6nU8dKIsMXCVetkZn0n5URcE/NyaGTYAHfrn8Cf
         dMww==
X-Forwarded-Encrypted: i=1; AJvYcCUBmm59FCeCZ/MCopaHQsT30uqF1JEiEZ59i7EWpanbioCl1wA1FHxGywxOE5cguUEQsXwqXm77sF363w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+imhMbZreeksS9BGdaj8nLC6BBO2OvmYVYDjRAUGKLfPWRXwe
	93loAvW9vtDzrdJBdzAwwFFWPt1RBhB0qmuc2tYsdnxS28oVl6PsJM9SfFJlWhE0nq+E4Q7w0s9
	5XILY5ugi7K3zi07IeqxwEpUeRY6G5AozLPL3ncG0gd4RijFfRiAQXDF5Fyc0//az
X-Gm-Gg: ASbGnctvVdL1EfTMb5LR+iOn007Ef0bNuj1BF062qCrANPyRp4VSV7LN+ZHujV9v72h
	Cyidih/uss0WxqAw51nHbEeeV4SqIDvTqdSz7Su0PvM54yS1UbeMd6aeRilBLAVcLWJZgMW4C+k
	wfT0+DESsr4u1whqkgSnUBSW8XDLBbKVNoyimsM4NxKBhFCkQWLkM+3K+AfVYNegQIPJzIyXgcF
	Bq6weVeXAlU1PKiFGNnI3YlZsesGgKxyqlumEYz/jl6EkSH9W2TA6RqHVddlMtAtGwcqXAfjESn
	R8L+qouWNnhyo4pjnVDhQDknJ/D/33Ih8HAvEi85Gd80U1dtCiIEOH3HJ8KXqZiWAhoUdC14FUt
	nKb8anc8GWoZaxnCPGG/0uY6L
X-Received: by 2002:a05:600c:1d01:b0:458:be62:dcd3 with SMTP id 5b1f17b1804b1-459f4f9bd34mr130468235e9.17.1754923194988;
        Mon, 11 Aug 2025 07:39:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiigg+0PNvGEb3wRzSSq9JM70VE9hLMIH2EVbNkuJbtlZWW3Ch7GW5N/kbNcHDKqZhLgst/w==
X-Received: by 2002:a05:600c:1d01:b0:458:be62:dcd3 with SMTP id 5b1f17b1804b1-459f4f9bd34mr130467845e9.17.1754923194477;
        Mon, 11 Aug 2025 07:39:54 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459fb43b491sm120611835e9.3.2025.08.11.07.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 07:39:54 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-aio@kvack.org,
	linux-btrfs@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Dave Kleikamp <shaggy@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v1 1/2] mm/migrate: remove MIGRATEPAGE_UNMAP
Date: Mon, 11 Aug 2025 16:39:47 +0200
Message-ID: <20250811143949.1117439-2-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811143949.1117439-1-david@redhat.com>
References: <20250811143949.1117439-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

migrate_folio_unmap() is the only user of MIGRATEPAGE_UNMAP. We want to
remove MIGRATEPAGE_* completely.

It's rather weird to have a generic MIGRATEPAGE_UNMAP, documented to be
returned from address-space callbacks, when it's only used for an
internal helper.

Let's start by having only a single "success" return value for
migrate_folio_unmap() -- 0 -- by moving the "folio was already freed"
check into the single caller.

There is a remaining comment for PG_isolated, which we renamed to
PG_movable_ops_isolated recently and forgot to update.

While we might still run into that case with zsmalloc, it's something we
want to get rid of soon. So let's just focus that optimization on real
folios only for now by excluding movable_ops pages. Note that concurrent
freeing can happen at any time and this "already freed" check is not
relevant for correctness.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h |  1 -
 mm/migrate.c            | 40 ++++++++++++++++++++--------------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index acadd41e0b5cf..40f2b5a37efbb 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -18,7 +18,6 @@ struct migration_target_control;
  * - zero on page migration success;
  */
 #define MIGRATEPAGE_SUCCESS		0
-#define MIGRATEPAGE_UNMAP		1
 
 /**
  * struct movable_operations - Driver page migration
diff --git a/mm/migrate.c b/mm/migrate.c
index 425401b2d4e14..e9dacf1028dc7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1176,16 +1176,6 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	bool locked = false;
 	bool dst_locked = false;
 
-	if (folio_ref_count(src) == 1) {
-		/* Folio was freed from under us. So we are done. */
-		folio_clear_active(src);
-		folio_clear_unevictable(src);
-		/* free_pages_prepare() will clear PG_isolated. */
-		list_del(&src->lru);
-		migrate_folio_done(src, reason);
-		return MIGRATEPAGE_SUCCESS;
-	}
-
 	dst = get_new_folio(src, private);
 	if (!dst)
 		return -ENOMEM;
@@ -1275,7 +1265,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 
 	if (unlikely(page_has_movable_ops(&src->page))) {
 		__migrate_folio_record(dst, old_page_state, anon_vma);
-		return MIGRATEPAGE_UNMAP;
+		return 0;
 	}
 
 	/*
@@ -1305,7 +1295,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 
 	if (!folio_mapped(src)) {
 		__migrate_folio_record(dst, old_page_state, anon_vma);
-		return MIGRATEPAGE_UNMAP;
+		return 0;
 	}
 
 out:
@@ -1848,14 +1838,28 @@ static int migrate_pages_batch(struct list_head *from,
 				continue;
 			}
 
+			/*
+			 * If we are holding the last folio reference, the folio
+			 * was freed from under us, so just drop our reference.
+			 */
+			if (likely(!page_has_movable_ops(&folio->page)) &&
+			    folio_ref_count(folio) == 1) {
+				folio_clear_active(folio);
+				folio_clear_unevictable(folio);
+				list_del(&folio->lru);
+				migrate_folio_done(folio, reason);
+				stats->nr_succeeded += nr_pages;
+				stats->nr_thp_succeeded += is_thp;
+				continue;
+			}
+
 			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
 					private, folio, &dst, mode, reason,
 					ret_folios);
 			/*
 			 * The rules are:
-			 *	Success: folio will be freed
-			 *	Unmap: folio will be put on unmap_folios list,
-			 *	       dst folio put on dst_folios list
+			 *	0: folio will be put on unmap_folios list,
+			 *	   dst folio put on dst_folios list
 			 *	-EAGAIN: stay on the from list
 			 *	-ENOMEM: stay on the from list
 			 *	Other errno: put on ret_folios list
@@ -1905,11 +1909,7 @@ static int migrate_pages_batch(struct list_head *from,
 				thp_retry += is_thp;
 				nr_retry_pages += nr_pages;
 				break;
-			case MIGRATEPAGE_SUCCESS:
-				stats->nr_succeeded += nr_pages;
-				stats->nr_thp_succeeded += is_thp;
-				break;
-			case MIGRATEPAGE_UNMAP:
+			case 0:
 				list_move_tail(&folio->lru, &unmap_folios);
 				list_add_tail(&dst->lru, &dst_folios);
 				break;
-- 
2.50.1


