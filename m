Return-Path: <linux-btrfs+bounces-22078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJhQKqHjoWmUwwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22078-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 19:34:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C10541BC02D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 19:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 195B83187071
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 18:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADECC396D28;
	Fri, 27 Feb 2026 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9G+Rgvr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B52395D9F
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772217097; cv=none; b=BgAWIO34kf5m8/kOUc+Snc6kvXQSifJHbATx087d4b6iulNIDsC/OtuKq7QTfb9FbPv0FRHXeGsFzdtQKJcwExl1SiDYIhXemrEF/nlAJ5uhOStbc4OsLj7jRgOdVwG7C+dN+XmXIJb5hsBfGmzJkKZVN3aPF7YfrtBTcPyEa2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772217097; c=relaxed/simple;
	bh=wbw4doQYKaFLDbXuUD0eAgYHGmQXU9EWxpL+DBRBZ68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/loO8LNibPNizDA8d/s9H8SwKAhdcvQsYJ9Dzb6m1/CaneUrMaupULEEpJJNWrhbq8d1C+UXKc8ZSQO+YIoln79W371vYY0tkM7rCUTTlBqclomJPLd9sXWKk1SXZwtCiMy6vMSKZTUlm4zm2cciqKljn4YE31tZ+2cREA3Ukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9G+Rgvr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae239bd19eso7593225ad.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 10:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772217095; x=1772821895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WUSzdwnkAcRjrhv+jrxIK4jmmkvYOasrlp3X44R4ms=;
        b=R9G+Rgvr2srSwqSJuWH4CS4Rqm5UVdwqR+MgpkUHlsuvNy9zOGrcvU2e7f9SV8UcS+
         PeUZzJ31rrcwA1g/2b82v7EwZmjMybOl20QnroFsMgDeTn4NbFGxV/V5w/njczZwB6SZ
         qpWizkeO2fPfch1e1M6IQdznakKbnbwCXt0DlRM/0i9ddKl+SpKvWSl4y8RHqM3q4ZQF
         Thmb0T7O9m9btKw7DKoMC9Ior5RUrUYoU+RVXBvwtRg0vhurjthCCqSyWxG1IMze2Aik
         AYUCycKp8AnMup163MIOWIprvD0ZhEykJL0ht8Le9coHkrshsqQDHOg5wWALdFOnvbn6
         Jq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772217095; x=1772821895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2WUSzdwnkAcRjrhv+jrxIK4jmmkvYOasrlp3X44R4ms=;
        b=QHgsOGIUfgiXT5CahXgeqYLoOWXos3aMmncr27ep+WgLSP+sW4uNN4pFe+Xp6YpZUJ
         09rt83ODhtNk20dE6OFg5R/rVY5wS0gEhdCI2ytz+7WAsuZpDW1YzF77HjVGEgUcFsCa
         O+tGhpvKm6ebxC3sSt+NVqIf7Ox/UFg3BfcbKVjHzzeJXGwuj/4Zo/1PbrUB/7nCgC5I
         8qvj5eCnhAgDcDDn4a8/1knP7gS/Im9sQD1TVFS0cc3cVJV9NyRHNQpuqn15xuNQgxhP
         LjyJsfiYO6fgQf+TFcP7SMKv2ryJox+nr3j/ieGYJAl/PLPlyhymJLnpn2LCB+aHzZcW
         3y7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUw+it/QL26+fCFGJIyxpGsNfntlt7tYl2zjzejt3OaeSaTj1HqYACzLGf90qI7lT4RQMlsNXBQlgrTag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPUV9us3d2qbXDyOG10BdPNhp0bAaOMk8GJ3oWDt98SMo5ZIk
	Ib/oL29pK9gco8jun9DbFFAxjgm1GxpuKbgMOxMgg9sOg6ymA9OZ8Yul
X-Gm-Gg: ATEYQzxzpfWeWbdopdXucrhcgCagDSV9bH3jECGSWsJ4KpL4/nvxBGiBkg7wlut/2sw
	e2kd9PYkLai9DnKo5stQXsGDIcsOgZqOc1LFPi2feXSvdP2BfM6sg4GOJUy0Q2XvwbHWDGMOu6T
	0vxD5vObWal4nP7HE4hYB2SfW3UL76W/SKLivWBWUqNG7VJH/GT2HTSPgo7BZptLOE/Wdbr0ltj
	vzrROZPrA2AuLIj+9t1mcEkSLOpVBFzwHbP+/6GEdhjkxTbAG2rTVwCMc5K4c0MNl0fYTD6fUvz
	pkria07HPUOsyEeIp9u+PIEMAbFerpJeQZzPY+O9to94j0KQgN5sSp9iYwJPfpoeVdDYqhr1+PT
	KfI+978CMlIlIZSQwdho71/44YIHWg1ZCL0OVBoaCo3xARXPoy+c2khn/Ti6BGq4wmL0uRZ7sK8
	hGuNy/VNz74l8DxwD+ZPk5aZpX
X-Received: by 2002:a17:902:ce09:b0:2a0:b7d3:eec5 with SMTP id d9443c01a7336-2ae2e4b0d26mr40184335ad.33.1772217095207;
        Fri, 27 Feb 2026 10:31:35 -0800 (PST)
Received: from archlinux ([103.208.68.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbad2sm61932485ad.34.2026.02.27.10.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 10:31:34 -0800 (PST)
From: Adarsh Das <adarshdas950@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: terrelln@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adarsh Das <adarshdas950@gmail.com>
Subject: [PATCH 3/4] btrfs: replace BUG() and BUG_ON() with error handling in extent-tree.c
Date: Sat, 28 Feb 2026 00:01:10 +0530
Message-ID: <20260227183111.9311-4-adarshdas950@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-22078-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C10541BC02D
X-Rspamd-Action: no action

Replace BUG() and BUG_ON() calls with proper error handling instead
of crashing the kernel. Use btrfs_err() and return -EUCLEAN where
fs_info is available, and WARN_ON() with an error return where it
is not or where the condition is a programming bug rather than
on-disk corruption.

Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
 fs/btrfs/extent-tree.c | 82 ++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 03cf9f242c70..9748a4c5bc2d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -604,7 +604,13 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
 		return -EUCLEAN;
 	}
 
-	BUG_ON(num_refs < refs_to_drop);
+	if (unlikely(num_refs < refs_to_drop)) {
+		btrfs_err(trans->fs_info,
+			  "dropping more refs than available, have %u want %u",
+			  num_refs, refs_to_drop);
+		btrfs_abort_transaction(trans, -EUCLEAN);
+		return -EUCLEAN;
+	}
 	num_refs -= refs_to_drop;
 
 	if (num_refs == 0) {
@@ -863,7 +869,13 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 
 	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK && !skinny_metadata) {
 		ptr += sizeof(struct btrfs_tree_block_info);
-		BUG_ON(ptr > end);
+		if (unlikely(ptr > end)) {
+			btrfs_err(
+				fs_info,
+				"extent item overflow at slot %d, ptr %lu end %lu",
+				path->slots[0], ptr, end);
+			return -EUCLEAN;
+		}
 	}
 
 	if (owner >= BTRFS_FIRST_FREE_OBJECTID)
@@ -1237,7 +1249,12 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
 {
 	int ret = 0;
 
-	BUG_ON(!is_data && refs_to_drop != 1);
+	if (unlikely(!is_data && refs_to_drop != 1)) {
+		btrfs_err(trans->fs_info,
+			  "invalid refs_to_drop %d for tree block, must be 1",
+			  refs_to_drop);
+		return -EUCLEAN;
+	}
 	if (iref)
 		ret = update_inline_extent_backref(trans, path, iref,
 						   -refs_to_drop, NULL);
@@ -1453,8 +1470,9 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 
 	ASSERT(generic_ref->type != BTRFS_REF_NOT_SET &&
 	       generic_ref->action);
-	BUG_ON(generic_ref->type == BTRFS_REF_METADATA &&
-	       generic_ref->ref_root == BTRFS_TREE_LOG_OBJECTID);
+	if (WARN_ON(generic_ref->type == BTRFS_REF_METADATA &&
+		    generic_ref->ref_root == BTRFS_TREE_LOG_OBJECTID))
+		return -EINVAL;
 
 	if (generic_ref->type == BTRFS_REF_METADATA)
 		ret = btrfs_add_delayed_tree_ref(trans, generic_ref, NULL);
@@ -1622,7 +1640,9 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
 		ret = __btrfs_free_extent(trans, href, node, extent_op);
 	} else {
-		BUG();
+		btrfs_err(trans->fs_info, "unexpected delayed ref action %d",
+			  node->action);
+		return -EUCLEAN;
 	}
 	return ret;
 }
@@ -1639,7 +1659,8 @@ static void __run_delayed_extent_op(struct btrfs_delayed_extent_op *extent_op,
 
 	if (extent_op->update_key) {
 		struct btrfs_tree_block_info *bi;
-		BUG_ON(!(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK));
+		if (WARN_ON(!(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)))
+			return;
 		bi = (struct btrfs_tree_block_info *)(ei + 1);
 		btrfs_set_tree_block_key(leaf, bi, &extent_op->key);
 	}
@@ -1775,7 +1796,9 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		else
 			ret = __btrfs_free_extent(trans, href, node, extent_op);
 	} else {
-		BUG();
+		btrfs_err(trans->fs_info, "unexpected delayed ref action %d",
+			  node->action);
+		return -EUCLEAN;
 	}
 	return ret;
 }
@@ -2645,7 +2668,11 @@ int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num_bytes
 	struct btrfs_block_group *cache;
 
 	cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
-	BUG_ON(!cache); /* Logic error */
+	if (unlikely(!cache)) {
+		btrfs_err(trans->fs_info,
+			  "unable to find block group for bytenr %llu", bytenr);
+		return -EUCLEAN;
+	}
 
 	pin_down_extent(trans, cache, bytenr, num_bytes, true);
 
@@ -4125,7 +4152,9 @@ static int do_allocation(struct btrfs_block_group *block_group,
 	case BTRFS_EXTENT_ALLOC_ZONED:
 		return do_allocation_zoned(block_group, ffe_ctl, bg_ret);
 	default:
-		BUG();
+		btrfs_err(block_group->fs_info, "invalid allocation policy %d",
+			  ffe_ctl->policy);
+		return -EUCLEAN;
 	}
 }
 
@@ -4141,11 +4170,20 @@ static void release_block_group(struct btrfs_block_group *block_group,
 		/* Nothing to do */
 		break;
 	default:
-		BUG();
+		btrfs_err(block_group->fs_info, "invalid allocation policy %d",
+			  ffe_ctl->policy);
+		goto release;
+	}
+
+	if (unlikely(btrfs_bg_flags_to_raid_index(block_group->flags) !=
+		     ffe_ctl->index)) {
+		btrfs_err(block_group->fs_info,
+			  "mismatched raid index, block group flags %llu index %d",
+			  block_group->flags, ffe_ctl->index);
+		goto release;
 	}
 
-	BUG_ON(btrfs_bg_flags_to_raid_index(block_group->flags) !=
-	       ffe_ctl->index);
+release:
 	btrfs_release_block_group(block_group, delalloc);
 }
 
@@ -4172,7 +4210,8 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 		/* Nothing to do */
 		break;
 	default:
-		BUG();
+		WARN_ONCE(1, "invalid allocation policy %d", ffe_ctl->policy);
+		return;
 	}
 }
 
@@ -4238,7 +4277,9 @@ static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
 	case BTRFS_EXTENT_ALLOC_ZONED:
 		return can_allocate_chunk_zoned(fs_info, ffe_ctl);
 	default:
-		BUG();
+		btrfs_err(fs_info, "invalid allocation policy %d",
+			  ffe_ctl->policy);
+		return -EUCLEAN;
 	}
 }
 
@@ -4448,7 +4489,9 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
 	case BTRFS_EXTENT_ALLOC_ZONED:
 		return prepare_allocation_zoned(fs_info, ffe_ctl, space_info);
 	default:
-		BUG();
+		btrfs_err(fs_info, "invalid allocation policy %d",
+			  ffe_ctl->policy);
+		return -EUCLEAN;
 	}
 }
 
@@ -5292,8 +5335,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 			parent = ins.objectid;
 		flags |= BTRFS_BLOCK_FLAG_FULL_BACKREF;
 		owning_root = reloc_src_root;
-	} else
-		BUG_ON(parent > 0);
+	} else if (WARN_ON(parent > 0))
+		return ERR_PTR(-EINVAL);
 
 	if (root_objectid != BTRFS_TREE_LOG_OBJECTID) {
 		struct btrfs_delayed_extent_op *extent_op;
@@ -6437,7 +6480,8 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	int parent_level;
 	int ret = 0;
 
-	BUG_ON(btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID);
+	if (WARN_ON(btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID))
+		return -EINVAL;
 
 	path = btrfs_alloc_path();
 	if (!path)
-- 
2.53.0


