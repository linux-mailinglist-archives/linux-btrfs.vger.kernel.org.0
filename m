Return-Path: <linux-btrfs+bounces-21734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF8AIyXmlGmjIgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21734-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 23:05:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA115144B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 23:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C121302C6D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 22:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E70730E0D2;
	Tue, 17 Feb 2026 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo3KeGBu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F13430B52B
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365892; cv=none; b=C+iLpaQWJ+lVgxAHKXDsCzTWrQO4dTMZy+usexdtoQlHlA/gC/UV8DRHrOHc+wzcg6vds1uch7EsG8gbf0Tkv1GKAJh88xaKyDjz6DgRRs8dQwy+LWaVk7i+JozgoysXS0gzR6A/NaiMmCxwW8/at+5ESnm0doF/AOPYAoa2dak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365892; c=relaxed/simple;
	bh=MdfMJUXPLQRe7TDF/bGdQOx3VH79EahEXuRAvg82M78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ha/yRo6YqBFhagbt8ucfbrAIlwsmsUHebWsFMGgAwQNacPVoZLuY4pIVCRo0Beu6gd9ZSs8l+iOltvOcj+BFAVMnNiL8x99J5snuKV5ZqzVPYBfn1gg78Tgzpd669CAAAPVuNskpkXK3ip/b/SK5g3KKqDbZWzslsgNIbvm/DN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo3KeGBu; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7927b1620ddso4347087b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 14:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771365890; x=1771970690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMfgil3lXov+0iV8klHTKXpaBNAj6HBDnrtQ7rx54DE=;
        b=Xo3KeGBuIhXDRc/ZrKRn3hLfRPVVTSTTkSS9IRSud4gf5btKQeiHgrHsVdPhzXIn/7
         jJwauPkoOmykEOPghp1s+Zjs4rV9JvZDzi05KvMvqf5/r0R4L0KmkhV4qurz0FfF7uVw
         PoihX0Furvy9VnP0D9z3eJSOGx6GcebAM4yjWG/EaNioy1/QtX75oFgjM9gv0uqPNXZ9
         ucil0y5RgVpkd57bjT3GLR36uYC2x989ti8lzyOXyVKonMwwFzs0miTLo+w7jydiiqyW
         jyn+1fNb6PRbJ1V4oceJdHyPhivM0AHpkOISTQ4k3M9HIpwAWGu7hPDP/e3K33zTD5pW
         LdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771365890; x=1771970690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eMfgil3lXov+0iV8klHTKXpaBNAj6HBDnrtQ7rx54DE=;
        b=YeBIxyc4tbrPw+fZqBxUrESky1uRDnsRydz0r7V/lDgyoYJqjOkN3cS+HXodmWEhDB
         R5/ArewlN6OYBTpWt07JwUPfrPxxkexigjTGidQlgur8Yx2Zr36QYEpmi48sURYo33i3
         sXZsm0mLk1NNXkiz+qJyuY9jUQ9ZUQrW9uATnfxMoRBIWNNRda9YSVUzSgIu0NUiiHMA
         FiBKFGiKDy5shL0zP19rT+GYWWjgIfJscSW/TYnGDCT0uRIk45XXwv4ffrGuNq+iZ3p+
         0YLbCGM3VoBR3v+jn0lhlKLw3pxlC8z2XiMBBiT9UhKkY64T7mut8MJYimx8cKhwTsYG
         JBNw==
X-Gm-Message-State: AOJu0Yx/rflGgJojrBUtig5MHNujakv42JtjW6l0iheGKw+QqFHtg+Gt
	HnA4q92cbExQsUQiQeiVO56cONqj1nAlOGlPBAG8+R//pFCehN2hycgS
X-Gm-Gg: AZuq6aJLG14zJSToKKL/o7S9rJaBZAhcbshIpYVoJA4GBxpHtUGJWUfZ3q8ZIWLZg2L
	smbEIDgOF5qepm6d6yWrGh3gpUtjzZ4g8rNroHM9PNqYvk2KdWwbgGPhOCq3b+cjZnAbwK6pWKh
	azkIk9dO7PD+Is6ociAVV0fy0UaocbkeEvQb7iSLhKzGfSPIaJo9vqUtj/VUxOMNzUKi9BsR3sn
	6F1u7KYzcLNuzCl/qMfMShP0I2pVsZPMCiboY8SBIPfulNzjM9hQs7MRWmFQoN4Yi2Zke6nr54X
	SfAVOkb/apa2I3PWjBLKqZUCkXADC3+c4XEbOmYQncxea9TFh0s/MHPTMDr4j4+cPUJBYsm+Kgc
	8J/4fDkALm2IifxqSlEaCro1CPBrGWZikUzLzZfMQ0DnfTyady7jkWLUznzBrEGF1sRMJuHFNat
	oNYX15UMUC95cwtaLX
X-Received: by 2002:a05:690c:c5cf:b0:797:d46b:e86e with SMTP id 00721157ae682-797d47b46c5mr41374587b3.14.1771365889981;
        Tue, 17 Feb 2026 14:04:49 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23d1edsm120947317b3.29.2026.02.17.14.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 14:04:49 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] btrfs: skip COW for written extent buffers allocated in current transaction
Date: Tue, 17 Feb 2026 14:04:26 -0800
Message-ID: <20260217220440.801494-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <bcde0730-b3d4-4aa2-88f9-7fee861601cc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21734-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDDA115144B
X-Rspamd-Action: no action

On Sat, 14 Feb 2026 09:25:03 +0800 Sun YangKai <sunk67188@gmail.com> wrote:

> Thanks for your working on this and I've expecting this for a long time :)

Thanks for the review!

> 
> On 2026/2/14 04:30, Leo Martins wrote:
> > When memory pressure causes writeback of a recently COW'd buffer,
> > btrfs sets BTRFS_HEADER_FLAG_WRITTEN on it. Subsequent
> > btrfs_search_slot() restarts then see the WRITTEN flag and re-COW
> > the buffer unnecessarily, causing COW amplification that can exhaust
> > block reservations and degrade throughput.
> > 
> > Overwriting in place is crash-safe because the committed superblock
> > does not reference buffers allocated in the current (uncommitted)
> > transaction, so no on-disk tree points to this block yet.
> > 
> > When should_cow_block() encounters a WRITTEN buffer whose generation
> > matches the current transaction, instead of requesting a COW, re-dirty
> > the buffer and re-register its range in the transaction's dirty_pages.
> > 
> > Both are necessary because btrfs tracks dirty metadata through two
> > independent mechanisms. set_extent_buffer_dirty() sets the
> > EXTENT_BUFFER_DIRTY flag and the buffer_tree xarray PAGECACHE_TAG_DIRTY
> > mark, which is what background writeback (btree_write_cache_pages) uses
> > to find and write dirty buffers. The transaction's dirty_pages io tree
> > is a separate structure used by btrfs_write_and_wait_transaction() at
> > commit time to ensure all buffers allocated during the transaction are
> > persisted. The dirty_pages range was originally registered in
> > btrfs_init_new_buffer() when the block was first allocated, but
> > background writeback may have already written and cleared it.
> > 
> > Keep BTRFS_HEADER_FLAG_WRITTEN set so that btrfs_free_tree_block()
> > correctly pins the block if it is freed later.
> > 
> > Exclude cases where in-place overwrite is not safe:
> >   - EXTENT_BUFFER_WRITEBACK: buffer is mid-I/O
> >   - Zoned devices: require sequential writes
> >   - Log trees: log blocks are immediately referenced by a committed
> >     superblock via btrfs_sync_log(), so overwriting could corrupt the
> >     committed log
> >   - BTRFS_ROOT_FORCE_COW: snapshot in progress
> >   - BTRFS_HEADER_FLAG_RELOC: block being relocated
> > 
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > ---
> >   fs/btrfs/ctree.c | 53 +++++++++++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 50 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 7267b2502665..a345e1be24d8 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -599,9 +599,9 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
> >   	return ret;
> >   }
> >   
> > -static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
> > +static inline bool should_cow_block(struct btrfs_trans_handle *trans,
> >   				    const struct btrfs_root *root,
> > -				    const struct extent_buffer *buf)
> > +				    struct extent_buffer *buf)
> >   {
> >   	if (btrfs_is_testing(root->fs_info))
> >   		return false;
> > @@ -621,8 +621,55 @@ static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
> >   	if (btrfs_header_generation(buf) != trans->transid)
> >   		return true;
> >   
> > -	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
> > +	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> > +		/*
> > +		 * The buffer was allocated in this transaction and has been
> > +		 * written back to disk (WRITTEN is set). Normally we'd COW
> > +		 * it again, but since the committed superblock doesn't
> > +		 * reference this buffer (it was allocated this transaction),
> > +		 * we can safely overwrite it in place.
> > +		 *
> > +		 * We keep BTRFS_HEADER_FLAG_WRITTEN set. The block has been
> > +		 * persisted at this bytenr and will be again after the
> > +		 * in-place update. This is important so that
> > +		 * btrfs_free_tree_block() correctly pins the block if it is
> > +		 * freed later (e.g., during tree rebalancing or FORCE_COW).
> > +		 *
> > +		 * We re-dirty the buffer to ensure the in-place modifications
> > +		 * will be written back to disk.
> > +		 *
> > +		 * Exclusions:
> > +		 * - Log trees: log blocks are written and immediately
> > +		 *   referenced by a committed superblock via
> > +		 *   btrfs_sync_log(), bypassing the normal transaction
> > +		 *   commit. Overwriting in place could corrupt the
> > +		 *   committed log.
> > +		 * - Zoned devices: require sequential writes
> > +		 * - FORCE_COW: snapshot in progress
> > +		 * - RELOC flag: block being relocated
> > +		 */
> > +		if (!test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags) &&
> > +		    !btrfs_is_zoned(root->fs_info) &&
> > +		    btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID &&
> > +		    !test_bit(BTRFS_ROOT_FORCE_COW, &root->state) &&
> it seems we need smp_mb__before_atomic() to see the FORCE_COW bit?

Good call, fixed in v3.

> > +		    !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) {
> > +			/*
> > +			 * Re-register this block's range in the current
> > +			 * transaction's dirty_pages so that
> > +			 * btrfs_write_and_wait_transaction() writes it.
> > +			 * The range was originally registered when the block
> > +			 * was allocated, but that transaction's dirty_pages
> > +			 * may have already been released.
> > +			 */
> > +			btrfs_set_extent_bit(&trans->transaction->dirty_pages,
> > +					     buf->start,
> > +					     buf->start + buf->len - 1,
> > +					     EXTENT_DIRTY, NULL);
> > +			set_extent_buffer_dirty(buf);
> why use set_extent_buffer_dirty() instead of btrfs_mark_buffer_dirty()? 
> I don't see any other callers doing this.

btrfs_mark_buffer_dirty() calls btrfs_assert_tree_write_locked(buf),
but should_cow_block() may be called from btrfs_search_slot() when the
buffer only holds a read lock (root node acquired with BTRFS_READ_LOCK
in btrfs_search_slot_get_root()). Added a comment explaining this in 
v3.

> > +			return false;
> > +		}
> >   		return true;
> > +	}
> >   
> >   	/* Ensure we can see the FORCE_COW bit. */
> >   	smp_mb__before_atomic();
> 
> And I wonder if we could have something more readable like this:
> 
> 	if (btrfs_header_generation(buf) != trans->transid)
> 		return true;
> 
> 	if (test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags))
> 		return true;
> 
> 	if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
> 	    btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))
> 		return true;
> 
> 	/* Ensure we can see the FORCE_COW bit. */
> 	smp_mb__before_atomic();
> 	if (test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
> 		return true;
> 
> 	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> 		if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID ||
> 		    btrfs_is_zoned(root->fs_info))
> 				return true;
> 		btrfs_set_extent_bit(&trans->transaction->dirty_pages,
> 				     buf->start,
> 				     buf->start + buf->len - 1,
> 				     EXTENT_DIRTY, NULL);
> 		btrfs_mark_buffer_dirty(trans, buf);
> 	}
> 
> 	return false;

Updated in v3!

> 
> Thanks,
> Sun YangKai

