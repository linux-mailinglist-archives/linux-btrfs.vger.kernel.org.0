Return-Path: <linux-btrfs+bounces-21760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF+jGOHalWn3VQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21760-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 16:29:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2F51576CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 16:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68FD13019913
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 15:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7754D341057;
	Wed, 18 Feb 2026 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OTCZI03x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E11D33BBC4
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771428559; cv=pass; b=sT7HZ15Fm6u3gPR3YpJ2qjjGHtbLKWzhzCbq3OAyLPWlMpPVnVvOuD1IeZK188a7lnnB7IZF9Ir7bq20i4n5jAAu4QPUeKFzS23M59rN6i/uX++MOw1amY4VHQww1l9zJtBrUBFEyIZRiJF+Xxro6hxwda0hkkiqkRcBbMIehzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771428559; c=relaxed/simple;
	bh=Xw6XgmdIpQZDlm085QhR4rp5zC/ULWblnm5MmRiePL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzrAyRzSAgP39qpy0zdpkgUQsQJocaxsByChSj1ovGCSqLxwbD8dwlCkFepAfdfHfRXlvBK8pjC1sSxZIbHtkMcSP8VDzgxUQKN9xfgSHUdG9IqOPZMQTM4H6hPFn2j3J4+qWZg2BDz+QhWlMaR6KcXIjo6S394K9U3uWeA8gvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OTCZI03x; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so4462048f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 07:29:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771428555; cv=none;
        d=google.com; s=arc-20240605;
        b=KUk2oJ+UyF2yMxBfMzTpWhRyjYl/aJ/gJ25NXgPMWJfd+7YrTTVqy3M5fjST9PsHWf
         arkxTy1HalC+3gFFIbcUk0rZVEo0nGloeia91QtxbeHo6cL7BO65t+Sdyq2lWsmaRJwe
         YrSTE3k7nJ0/O2Z8k0Z4RLb6NBtdaekeZ9NkT6tvKAip3RaSxWOExMtPnIEO5sxKiys5
         7A/z4hYfnp/eZFLnL6M26ChlxXRFvBCZUF0a0e5Hfg70jl+TD0vzzdGkjNl/KBelEfvD
         Duenpsop3mRTVqEcMef+FdbmqvkJlmW65gNbvkD3YS2WA32vee3lmDAJaQEs+qP692MY
         L+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IfnkV8+TTocY722rADKQN5PafR7KaeSPS4WRdn+Mx7I=;
        fh=67pECqIb8NaN7wOM3qJ7ZYUd4Yvlx89m2qnnPeX1EX4=;
        b=TN4KABdHYZLYLqBtmiuw87B7SxcZx0hCJRkEvsV5bYqhmxNTn2dK0e5qZ2Vg8ViMmn
         fGADO8d25tZvybiI3GdcOyzQjlo20gYNKQ6GZgNnUmzmN3yjGAShik1eaO2nhUTy4szh
         MRZRBBwpo+o9+HhzVyX0+SI4HFEIA1sDzeVojPpP2HhHwxfVFIvniSNPqvnzDe1YiEmb
         zLjOLRKcXr0XhpAgbhnNDEX5Ng4dFaPiU+5VgMtXHyIPA69BXgmBxAxsXwDjS+YTWQhp
         BkqyLZqYWXaH0azMIa+zRHK86JMo5q20QxjN9+4BObVUoCaaOyg6aQvfdFfb2xsW3uE7
         zD3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771428555; x=1772033355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IfnkV8+TTocY722rADKQN5PafR7KaeSPS4WRdn+Mx7I=;
        b=OTCZI03xtwImN3PgfzkrArAbcmpXovUOREuBZW7tfsNKznt39oFPIjB0O288sSUEv7
         xgBXFkMvFpyd1gnrqo2KBt+TSPHYDRpJDxSbRnWxs7U0U0u/Jbju9+3s91KATLsYWd1i
         1ZEz2utoNdS8S8f/bLWkCUwOENNDXQRwCJu0WZWmfy0IUH4taQQfOndR929xwzzrPoaN
         3SOObtxMWJj+nlytWlIM1bHUrY/vz373nx6gSkklLI14DEx1fW9EagtiL0IgXpIqgWmL
         RDhU3xM6p9d7pX0nrG/AtaUXHhDPfH2blrziBSUlumIYWlIU7HY74JhGlVK+dA22FzmV
         sqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771428555; x=1772033355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfnkV8+TTocY722rADKQN5PafR7KaeSPS4WRdn+Mx7I=;
        b=uu5RxX4+nLDdMmvN2xtEiK8V93qCS7f/PtbQ0+dGJTbw8gLBdNuXiIWy33MXquaGhm
         ecHw7+xFRPxPYRDItaCcOCF+Gz3++xzgPewkCH3mEuKzc5X5cEbtl2tQJWnd2LMdJb1u
         ZXyHlC6DMSYEEe77HFVTcZaMP/mwq90EBwE5m8lhghbKCRP2zMnRbNhF++h0t02i5xKz
         LfTTbNzNbhszYvi4+ezoHn1Hrzd9Ny25J5ooyjOwQBLUp6rb5YBXt6P69S6xYc0Y+c7/
         zScrbCB8i9KxXu+9yiA/2U5a6vdoGIHfCi2lDSjoFCZ9xiXWyrxEsFZ9/E7ZuNJaUIfe
         /i9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6FcvEEqpqG8xUOCi3RW+/BDTaMABl4U6MjuB2S3ArPpRZDxCE1cr3ww4dmmeSuuEV0kobdTRe6aZSAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxna9MnXoUfFLQbyelYSzJ/hlqlJP4g6rBIsw0iPMCh5FRK9fv2
	MYwMI+93kho54Mtn0sPWqCvYGnz8++GOF2m8rQtf9puxI60K1oMor+4Coc8GVkeR33ugzdlvayg
	G+op/mds9+pZz+v3G8VLQ/Wu1Uo/6fCzZGb6rXQh/yQ==
X-Gm-Gg: AZuq6aIRNyLgA4q74k/c9QA3avbaxU3W9ezsbBax6DVVOmx032+yd8lZxksD4AMiBM5
	Gd+3BYYSjBzUdz3DboLylYqwpDVf33u7AUeUCSswalLRiy7leA1sTDNt3rBpMYQKkppcj6xkfn9
	E+eW5OLYa4wdvmIlgV2RaJh35iZsim3Mv+bvbB9ITZjxpnYPBi+3t4oa1haKwzsaSuYqjOlnQkh
	wEib1eQZ8B5su2w29HgseWybjzxcw1CD4O0P1acjJ9UXiuQbHYVYlhD4ie4kjZjeHQcAFR+fb+P
	FY3Xu1cmyp7RoDwcJjLFKxm2pfhpDOyAJ5mmZmhYeADUHXQkJtRXPHrQcfXXhUMEuk87om8bvK7
	RhUo1
X-Received: by 2002:a05:6000:184e:b0:436:1a4b:de36 with SMTP id
 ffacd0b85a97d-43958e0314amr3758228f8f.22.1771428555325; Wed, 18 Feb 2026
 07:29:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-21-neelx@suse.com>
 <20260208151928.3245396-1-clm@meta.com>
In-Reply-To: <20260208151928.3245396-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Feb 2026 16:29:04 +0100
X-Gm-Features: AaiRm50zFeoPQy5g-1sCqoWhFtnHsBpdcK0A8x2pR40ySP5fMnh-3gELSlgrEnw
Message-ID: <CAPjX3FdiskLiELriX5gE2YEDMMwz5QQbNDnkAuFVov1a=WL_jQ@mail.gmail.com>
Subject: Re: [PATCH v6 20/43] btrfs: add fscrypt_info and encryption_type to ordered_extent
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,linux-btrfs@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,mail.gmail.com:mid,suse.com:email,suse.com:dkim,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21760-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: BE2F51576CF
X-Rspamd-Action: no action

On Sun, 8 Feb 2026 at 16:20, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > We're going to need these to update the file extent items once the
> > writes are complete.  Add them and add the pieces necessary to assign
> > them and free everything.
> >
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
> commit 61cd57301840de69a3f6573374d41ad4b4bcf348
> Author: Josef Bacik <josef@toxicpanda.com>
>
> btrfs: add fscrypt_info and encryption_type to ordered_extent
>
> This commit adds encryption-related fields (encryption_type and
> fscrypt_info) to struct btrfs_ordered_extent to support fscrypt
> integration in btrfs.
>
> > diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > index 5df02c707aee6..7a5701937184e 100644
> > --- a/fs/btrfs/ordered-data.c
> > +++ b/fs/btrfs/ordered-data.c
> > @@ -192,6 +192,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
> >       }
> >       entry->inode = inode;
> >       entry->compress_type = compress_type;
> > +     entry->encryption_type = BTRFS_ENCRYPTION_NONE;
> >       entry->truncated_len = (u64)-1;
> >       entry->qgroup_rsv = qgroup_rsv;
>
> This isn't a bug, but the fscrypt_info field isn't explicitly initialized
> to NULL here. While kmem_cache_zalloc() at line 175 does zero the memory,
> all the other important fields in this function are explicitly initialized
> (compress_type, encryption_type, truncated_len, qgroup_rsv, refs). Would
> adding an explicit 'entry->fscrypt_info = NULL;' improve consistency?

`entry->fscrypt_info` is set in the very next patch "[21/43] btrfs:
plumb through setting the fscrypt_info for ordered extents". The
series is meant to be applied as a whole. It's just factored into
implementation steps.

> >       entry->flags = flags;
> > @@ -630,6 +631,7 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
> >               btrfs_add_delayed_iput(entry->inode);
> >               list_for_each_entry_safe(sum, tmp, &entry->list, list)
> >                       kvfree(sum);
> > +             fscrypt_put_extent_info(entry->fscrypt_info);
> >               kmem_cache_free(btrfs_ordered_extent_cache, entry);
> >       }
> >  }
> > diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> > index 1e6b0b182b295..ce19198e7f844 100644
> > --- a/fs/btrfs/ordered-data.h
> > +++ b/fs/btrfs/ordered-data.h
> > @@ -124,6 +124,9 @@ struct btrfs_ordered_extent {
> >       /* compression algorithm */
> >       int compress_type;
> >
> > +     /* encryption mode */
> > +     u8 encryption_type;
> > +
>
> This isn't a bug, but placing the u8 encryption_type field between two int
> fields creates 3 bytes of padding. This is minor, but in a filesystem with
> many ordered extents, it could add up. The current placement does have the
> advantage of grouping encryption-related fields together logically, though.

This was actually changed from int (as Dave suggested, IIRC). But I
did not move it.
I guess we can do this:

--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -127,18 +127,18 @@ struct btrfs_ordered_extent {
     /* flags (described above) */
     unsigned long flags;

-    /* compression algorithm */
-    int compress_type;
-
-    /* encryption mode */
-    u8 encryption_type;
-
     /* Qgroup reserved space */
     int qgroup_rsv;

     /* reference count */
     refcount_t refs;

+    /* compression algorithm */
+    int compress_type;
+
+    /* encryption mode */
+    u8 encryption_type;
+
     /* the inode we belong to */
     struct btrfs_inode *inode;


> >       /* Qgroup reserved space */
> >       int qgroup_rsv;
> >
> > @@ -133,6 +136,9 @@ struct btrfs_ordered_extent {
> >       /* the inode we belong to */
> >       struct btrfs_inode *inode;
> >
> > +     /* the fscrypt_info for this extent, if necessary */
> > +     struct fscrypt_extent_info *fscrypt_info;
> > +
> >       /* list of checksums for insertion when the extent io is done */
> >       struct list_head list;
>
> How does btrfs_split_ordered_extent() handle the new fscrypt_info field?
> Looking at that function in ordered-data.c, it calls alloc_ordered_extent()
> which initializes encryption_type to BTRFS_ENCRYPTION_NONE and fscrypt_info
> to NULL. If the original ordered extent has encryption_type set to

Ditto. This is changed in the next patch [21/43].
alloc_ordered_extent() correctly sets these fields.

Thanks.

--nX

> BTRFS_ENCRYPTION_FSCRYPT with a non-NULL fscrypt_info pointer, the split
> creates an inconsistency where the two extents representing parts of the
> same encrypted data have different encryption metadata.
>
> The function already has an assertion preventing splits of compressed
> extents at line 1244:
>
>     ASSERT(!(flags & (1U << BTRFS_ORDERED_COMPRESSED)))
>
> Should there be similar protection for encrypted extents, or if splits must
> be supported, should the function call fscrypt_get_extent_info() to
> properly handle the reference count and copy the encryption_type to the new
> extent?
>

