Return-Path: <linux-btrfs+bounces-21765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGV6Ngb2lWn1XQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21765-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 18:25:26 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5688158449
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 18:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE80030071F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5303451D6;
	Wed, 18 Feb 2026 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ST60dWro"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327BB32ED55
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771435523; cv=pass; b=prpseJqQa8KBjgDV5dbZ3zwURWQpZZDWXEgeRkLFqqbpYCM2mQaQWma25ONpxBRFpsgaxKSlJgYgSNuXEyg2P6g+DrS1Laf0hqP3pOfjMF8ZQqLbnzZdpCkg/uunNs6MYqqXzUYEOO7rYHeyp0Mc0+ndAuKiqfPO0KEpz7hkR98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771435523; c=relaxed/simple;
	bh=N+tav2HTy87uvDs4cm+LHcXfnxXGxM0ESG6Aqemj0F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lszEco4ij/Ot4VT5PXv5BNrNwZFn77EURpOX+D9UvytaTN9OUwQeoSA3IVbpToqDd7mrcUFGox0MLcfdzhtWSuTPvDLmt3wEULvV6oeGkj7Uf7C2FZhGcSvq6TCeHnLI9lY6exiv/X17Zv//h0o5pGBB9onzZ7W7UXphmE1gQZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ST60dWro; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-480706554beso837705e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 09:25:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771435519; cv=none;
        d=google.com; s=arc-20240605;
        b=HOpjbGnSHnAlEFe1dayv5D+6WdHnZq5O9oKVoE97rbzH3I6ahyw9/ogtUMcIguUEmM
         52uLr7neGQI/OSgRuJzj5wEOI4sfxxm6SLJVlhb0ovbgX2DDbLxz8Z9TAS/uJjKQ7QB2
         NydUy/MjwC1ivH94pqtrLWzf3tiRqug/uNQis3yoJi6+DBgeFHCCeqOggOJUWsTPk2kB
         EBF1dPm45OkFy//f1S3ysLfJnYxao/qHYNZ2rS8AMTQ+xdN+vKGeTTsrQxtsjwa18TbQ
         18I5LoA+kxp2ToJ2fiTOO0xXvKP/03lbimQm8D7vLnc4UQkdjDSQdC5ukyMH4iBlw5yS
         ibaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D6PV26WrJgM8OsqISNWJ5AfIh8Z/AmyWHm0tc1qPxzY=;
        fh=DR+ZK5LTrZoi+u+oL9oP1xut9dCgMLV9WwbJ3d33bQE=;
        b=D0UzA1n84iLYHWq3P1v85fz329a3Dg/xLrxWzHs65/J8Epm9n0Kcz6kj/H+2VIL5V2
         x7k9ZSHY31Td9O73WDXa9EVyyQisJM1g/4Hb9tlL/7pbLwwXpbtINBbJYqA4eSFqp90m
         Kn9ORj3I3dlR+NNHN1spVhCKzRFhpDznhb6N03MzBp+SWpI34KXysj2h7otIiq6vdfdd
         USsi23DbWWJVDDdhZOwGMAlJC3HTqJBp7CW11qgc0Ntpiq0WmCJp87oEjk5SKaFSvXNy
         2k0mtxgC0AUE7yzKelJ4je1QweFrK2qPZPcqjylsRNy1qEH/AQOLR27D1UquNbkey9X6
         YWSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771435519; x=1772040319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D6PV26WrJgM8OsqISNWJ5AfIh8Z/AmyWHm0tc1qPxzY=;
        b=ST60dWro0wvwS2dgKYtI4A8AaDQy7wm+Qg3slO8Ahg9ZTnnZrLBfNxma2LnoswIn9W
         NLiOluW/rk20qQProSW3lRAhxJEjvY1hthDuLpjl07A1hgMMgnD3f2TmT9r7xn6wsfyX
         KJxXceqaQkAp6M//qKERt3dhbSD9KDyj7REFt4/yYj6a4F7XCq5GYCihzF7LTB94MFTq
         bV5/t8ujS6fzY7YhSxLLOlVsUIqv6YPuKf1iVGRckVMz3KMVcDn8aBy//PsD3KzgmbmJ
         0fXK30LPk5pLxkC5XdJKN7UFG0ox8b34T1xuhztJsGS8gVDjsWlPMASh6DgUrhbg2IzI
         ur8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771435519; x=1772040319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6PV26WrJgM8OsqISNWJ5AfIh8Z/AmyWHm0tc1qPxzY=;
        b=UCZIR94r1dN23iwHj0eaVygNYm7JUgRQOGHGRhksS7Tt5GAQthOIX6Ak5tjSW74UdV
         9ITRXiBZaiClLaYldnDVyJFCAxD3NvJ5+YwOJKbuEB6DSArSOcfJ3xEhewWK4n4+c3CZ
         leO48koTwHwN8ZzyKntkv5/m7GBG39h61kCOKmUTVHUfNo0xlM1tMW/5l7Fhlm0VzUOw
         8gYHSRSo43C8xw5bpRZ71V/P4uhom9xO5Z6Zx6m33wkLFsGY1tGezuhokQ+wT6jVXsoC
         3IHQtnRhq3HFT1CZ03Jz9jNHWkE8MLIYy9YYjdEKKfOt3TlamDOEZB+sHxkoi5Bl01p3
         rYDA==
X-Forwarded-Encrypted: i=1; AJvYcCW0VMDbuVegkXyIms8RLjU69tMbfX4sENSBV/Szfiizl+xX/C6hz58IyJp9PoWsZ37OAr87ij+vdnjX2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyqc6LOEYssSOrsNrU0qOXo8zzstEteUZEC43Z0/WJqnSJE7dV
	1medWBlAb4hEvlGTzOuOUDDjf/rY64wBIgchHZwrGo6FW4xjwABbXRjO4ExfDzR/ffrLtOPKN19
	db0q96++XYsD4pH9tDBkBsgNzrYRgdXKtZJ87RwYZkA==
X-Gm-Gg: AZuq6aKCNtphMv+gO295aLKjmcZy0WcPug1ye0daBmWRD101LUxOLu3WezfP1131s6L
	ZKK4IMiHmiyb7HKW5kE8palcz2uH/1n/OR6RJX2vgRQmf8YjgU0aZxEFGV/HUIsVu/XcynFcf9o
	4R10pqlS3HRuUxLfTGWdanJhJxQ/W5WoFeseSlQ3KFYEXukBDGEACP33/2GMssM9rEQO/hVHR3r
	B7I25JeKwLs60XYDAKn5422EfXMFiZVTKh4rzUXZgn+pn26Y/3i8PzWDI8qGbRv0QGKcok7lwnX
	bbGigwbXNUi7NhlRx6A9sGBOBMmPRDVn2dNg/z+r7e9WZDOVCprYnI0E4rlSGhiI2qSD1JlNu1w
	LwdMW
X-Received: by 2002:a05:6000:402b:b0:437:6e6e:6f95 with SMTP id
 ffacd0b85a97d-4379db70171mr28853405f8f.27.1771435519063; Wed, 18 Feb 2026
 09:25:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-25-neelx@suse.com>
 <20260208151728.3212554-1-clm@meta.com>
In-Reply-To: <20260208151728.3212554-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Feb 2026 18:25:07 +0100
X-Gm-Features: AaiRm507L4YZn8mKVfmFL0jTM398GIfUhQk4fH9ld-lHWQu5maDHhF9XOU_HEIA
Message-ID: <CAPjX3FdgJKQyM0tdCksgLAtVyjos_nx3TRg6rvjYB1wE2QH1Cw@mail.gmail.com>
Subject: Re: [PATCH v6 24/43] btrfs: add extent encryption context tree item type
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21765-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,meta.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C5688158449
X-Rspamd-Action: no action

On Sun, 8 Feb 2026 at 16:17, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > The fscrypt encryption context will be stored as a new tree item type.
> > This gives us flexibility to include different things in the future.
> >
> > Also update the tree-checker to validate the new item type.
>
> Hi everyone,
>
> I'm running the btrfs for-next branch, along with the encryption patch set
> through my AI review prompts:
>
> https://github.com/masoncl/review-prompts
>
> I'm working on some btrfs specific instructions, but hopefully these reviews
> are already useful.  I've kept the headers to make it easier to double check
> that I'm actually replying to the right email, but please let me know if any
> parts of this are incorrect:
>
> commit 203bfb91a4db9c826fa7f72034c13a1810a1b605
> Author: Josef Bacik <josef@toxicpanda.com>
>
> btrfs: add extent encryption context tree item type
>
> The fscrypt encryption context will be stored as a new tree item type.
> This gives us flexibility to include different things in the future.
> Also update the tree-checker to validate the new item type.
>
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 3c0db279f592e..639462164d089 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
>
> [ ... ]
>
> > @@ -496,6 +503,60 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
> >               args->extent_inserted = true;
> >       }
> >
> > +     if (first_ctx <= last_ctx) {
> > +             int slot, nritems;
> > +
> > +             btrfs_release_path(path);
> > +
> > +             key.objectid = ino;
> > +             key.type = BTRFS_FSCRYPT_CTX_KEY;
> > +             key.offset = first_ctx;
> > +
> > +             ret = btrfs_search_slot(trans, root, &key, path, modify_tree, !!modify_tree);
> > +             if (ret < 0)
> > +                     goto out_ctx;
>
> [ ... ]
>
> > +out_ctx:
> > +             if (args->path && args->extent_inserted) {
> > +                     btrfs_release_path(path);
> > +
> > +                     key.objectid = ino;
> > +                     key.type = BTRFS_EXTENT_DATA_KEY;
> > +                     key.offset = args->start;
> > +                     ret = btrfs_search_slot(trans, root, &key, path, 0, 0);
> > +             }
> > +     }
> > +
>
> Can btrfs_search_slot() at line 556 overwrite an error that occurred
> earlier in the out_ctx path?
>
> If btrfs_search_slot() at line 515 fails and execution jumps to out_ctx,
> but args->path and args->extent_inserted are both true, the second
> btrfs_search_slot() call will overwrite the original error stored in ret.
>
> If this second search succeeds (returns 0 or >0), the function returns
> success to the caller despite the fscrypt context cleanup having failed.
> This could lead to inconsistent filesystem state where extent data was
> inserted but the corresponding fscrypt context items were not properly
> cleaned up.

Right, the original error should be returned. We do not care that much
about the latter if the former failed.
This should do the trick:

--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -549,12 +549,16 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
         }
 out_ctx:
         if (args->path && args->extent_inserted) {
+            int err;
+
             btrfs_release_path(path);

             key.objectid = ino;
             key.type = BTRFS_EXTENT_DATA_KEY;
             key.offset = args->start;
-            ret = btrfs_search_slot(trans, root, &key, path, 0, 0);
+            err = btrfs_search_slot(trans, root, &key, path, 0, 0);
+            if (err && ret >= 0)
+                ret = err;
         }
     }


> > diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> > index 9675dbcd78a3b..776901f297fea 100644
> > --- a/fs/btrfs/tree-checker.c
> > +++ b/fs/btrfs/tree-checker.c
>
> [ ... ]
>
> > +static int check_fscrypt_context(struct extent_buffer *leaf,
> > +                              struct btrfs_key *key, int slot,
> > +                              struct btrfs_key *prev_key)
> > +{
> > +     u32 sectorsize = leaf->fs_info->sectorsize;
> > +     u32 item_size = btrfs_item_size(leaf, slot);
> > +
> > +     if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
> > +             file_extent_err(leaf, slot,
> > +"unaligned file_offset for encryption context, have %llu should be aligned to %u",
> > +                     key->offset, sectorsize);
> > +             return -EUCLEAN;
> > +     }
> > +
> > +     /*
> > +      * Previous key must have the same key->objectid (ino).
> > +      * It can be XATTR_ITEM, INODE_ITEM or just another EXTENT_DATA.
> > +      * But if objectids mismatch, it means we have a missing
> > +      * INODE_ITEM.
> > +      */
>
> This isn't a bug, but the comment says "It can be XATTR_ITEM, INODE_ITEM
> or just another EXTENT_DATA" - can EXTENT_DATA actually be the previous
> key type?
>
> For BTRFS_FSCRYPT_CTX_KEY (type=42), EXTENT_DATA (type=108) cannot be a
> previous key because keys are sorted by (objectid, type, offset) and
> 108 > 42.
>
> The correct previous key types would be: XATTR_ITEM, INODE_ITEM,
> FSCRYPT_INODE_CTX_KEY, or another FSCRYPT_CTX_KEY.

Spot on! The comment is wrong. I realized that later but never fixed it here.
This is because of the redesign. In v5 the crypt context was embedded
in the extent data item, so they could have been next to each other.
This should look better:

--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -220,10 +220,9 @@ static int check_fscrypt_context(struct
extent_buffer *leaf,
     }

     /*
-     * Previous key must have the same key->objectid (ino).
-     * It can be XATTR_ITEM, INODE_ITEM or just another EXTENT_DATA.
-     * But if objectids mismatch, it means we have a missing
-     * INODE_ITEM.
+     * Previous key must have the same key->objectid (ino).  It can be
+     * XATTR_ITEM, INODE_ITEM, FSCRYPT_INODE_CTX_KEY, or another
FSCRYPT_CTX_KEY.
+     * But if objectids mismatch, it means we have a missing INODE_ITEM.
      */
     if (unlikely(!check_prev_ino(leaf, key, slot, prev_key)))
         return -EUCLEAN;

> > @@ -214,6 +248,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
> >       u32 item_size = btrfs_item_size(leaf, slot);
> >       u64 extent_end;
> >       u8 policy;
> > +     u8 fe_type;
> >
> >       if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
> >               file_extent_err(leaf, slot,
>
> [ ... ]
>
> > @@ -298,6 +333,19 @@ static int check_extent_data_item(struct extent_buffer *leaf,
> >               return 0;
> >       }
> >
> > +     if (policy == BTRFS_ENCRYPTION_FSCRYPT) {
> > +             /*
> > +              * Only regular and prealloc extents should have an encryption
> > +              * context.
> > +              */
> > +             if (unlikely(fe_type != BTRFS_FILE_EXTENT_REG &&
> > +                          fe_type != BTRFS_FILE_EXTENT_PREALLOC)) {
> > +                     file_extent_err(leaf, slot,
> > +             "invalid type for encrypted file extent, have %u", fe_type);
> > +                     return -EUCLEAN;
> > +             }
> > +     }
>
> Can this validation check detect encrypted inline extents? Looking at
> the function flow, inline extents (BTRFS_FILE_EXTENT_INLINE) are handled
> at lines 310-333 and return before reaching this check.
>
> If a corrupted filesystem has an encrypted inline extent, it would pass
> tree-checker validation. Should the encryption check be moved to also
> cover the inline extent path, or should inline extents explicitly reject
> BTRFS_ENCRYPTION_FSCRYPT?

Inline extents are not encrypted.

Thanks.

--nX

On Sun, 8 Feb 2026 at 16:17, Chris Mason <clm@meta.com> wrote:
>
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > The fscrypt encryption context will be stored as a new tree item type.
> > This gives us flexibility to include different things in the future.
> >
> > Also update the tree-checker to validate the new item type.
>
> Hi everyone,
>
> I'm running the btrfs for-next branch, along with the encryption patch set
> through my AI review prompts:
>
> https://github.com/masoncl/review-prompts
>
> I'm working on some btrfs specific instructions, but hopefully these reviews
> are already useful.  I've kept the headers to make it easier to double check
> that I'm actually replying to the right email, but please let me know if any
> parts of this are incorrect:
>
> commit 203bfb91a4db9c826fa7f72034c13a1810a1b605
> Author: Josef Bacik <josef@toxicpanda.com>
>
> btrfs: add extent encryption context tree item type
>
> The fscrypt encryption context will be stored as a new tree item type.
> This gives us flexibility to include different things in the future.
> Also update the tree-checker to validate the new item type.
>
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 3c0db279f592e..639462164d089 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
>
> [ ... ]
>
> > @@ -496,6 +503,60 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
> >               args->extent_inserted = true;
> >       }
> >
> > +     if (first_ctx <= last_ctx) {
> > +             int slot, nritems;
> > +
> > +             btrfs_release_path(path);
> > +
> > +             key.objectid = ino;
> > +             key.type = BTRFS_FSCRYPT_CTX_KEY;
> > +             key.offset = first_ctx;
> > +
> > +             ret = btrfs_search_slot(trans, root, &key, path, modify_tree, !!modify_tree);
> > +             if (ret < 0)
> > +                     goto out_ctx;
>
> [ ... ]
>
> > +out_ctx:
> > +             if (args->path && args->extent_inserted) {
> > +                     btrfs_release_path(path);
> > +
> > +                     key.objectid = ino;
> > +                     key.type = BTRFS_EXTENT_DATA_KEY;
> > +                     key.offset = args->start;
> > +                     ret = btrfs_search_slot(trans, root, &key, path, 0, 0);
> > +             }
> > +     }
> > +
>
> Can btrfs_search_slot() at line 556 overwrite an error that occurred
> earlier in the out_ctx path?
>
> If btrfs_search_slot() at line 515 fails and execution jumps to out_ctx,
> but args->path and args->extent_inserted are both true, the second
> btrfs_search_slot() call will overwrite the original error stored in ret.
>
> If this second search succeeds (returns 0 or >0), the function returns
> success to the caller despite the fscrypt context cleanup having failed.
> This could lead to inconsistent filesystem state where extent data was
> inserted but the corresponding fscrypt context items were not properly
> cleaned up.
>
> > diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> > index 9675dbcd78a3b..776901f297fea 100644
> > --- a/fs/btrfs/tree-checker.c
> > +++ b/fs/btrfs/tree-checker.c
>
> [ ... ]
>
> > +static int check_fscrypt_context(struct extent_buffer *leaf,
> > +                              struct btrfs_key *key, int slot,
> > +                              struct btrfs_key *prev_key)
> > +{
> > +     u32 sectorsize = leaf->fs_info->sectorsize;
> > +     u32 item_size = btrfs_item_size(leaf, slot);
> > +
> > +     if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
> > +             file_extent_err(leaf, slot,
> > +"unaligned file_offset for encryption context, have %llu should be aligned to %u",
> > +                     key->offset, sectorsize);
> > +             return -EUCLEAN;
> > +     }
> > +
> > +     /*
> > +      * Previous key must have the same key->objectid (ino).
> > +      * It can be XATTR_ITEM, INODE_ITEM or just another EXTENT_DATA.
> > +      * But if objectids mismatch, it means we have a missing
> > +      * INODE_ITEM.
> > +      */
>
> This isn't a bug, but the comment says "It can be XATTR_ITEM, INODE_ITEM
> or just another EXTENT_DATA" - can EXTENT_DATA actually be the previous
> key type?
>
> For BTRFS_FSCRYPT_CTX_KEY (type=42), EXTENT_DATA (type=108) cannot be a
> previous key because keys are sorted by (objectid, type, offset) and
> 108 > 42.
>
> The correct previous key types would be: XATTR_ITEM, INODE_ITEM,
> FSCRYPT_INODE_CTX_KEY, or another FSCRYPT_CTX_KEY.
>
> > @@ -214,6 +248,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
> >       u32 item_size = btrfs_item_size(leaf, slot);
> >       u64 extent_end;
> >       u8 policy;
> > +     u8 fe_type;
> >
> >       if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
> >               file_extent_err(leaf, slot,
>
> [ ... ]
>
> > @@ -298,6 +333,19 @@ static int check_extent_data_item(struct extent_buffer *leaf,
> >               return 0;
> >       }
> >
> > +     if (policy == BTRFS_ENCRYPTION_FSCRYPT) {
> > +             /*
> > +              * Only regular and prealloc extents should have an encryption
> > +              * context.
> > +              */
> > +             if (unlikely(fe_type != BTRFS_FILE_EXTENT_REG &&
> > +                          fe_type != BTRFS_FILE_EXTENT_PREALLOC)) {
> > +                     file_extent_err(leaf, slot,
> > +             "invalid type for encrypted file extent, have %u", fe_type);
> > +                     return -EUCLEAN;
> > +             }
> > +     }
>
> Can this validation check detect encrypted inline extents? Looking at
> the function flow, inline extents (BTRFS_FILE_EXTENT_INLINE) are handled
> at lines 310-333 and return before reaching this check.
>
> If a corrupted filesystem has an encrypted inline extent, it would pass
> tree-checker validation. Should the encryption check be moved to also
> cover the inline extent path, or should inline extents explicitly reject
> BTRFS_ENCRYPTION_FSCRYPT?
>

