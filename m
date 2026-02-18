Return-Path: <linux-btrfs+bounces-21763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGYMK8/klWneVwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21763-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 17:11:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5D9157A05
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 17:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7027301ABB8
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 16:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5404C33A9C5;
	Wed, 18 Feb 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PfZdcMqY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C12DC352
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431088; cv=pass; b=vCRbeRScKMFHwelrATHbgVSnniN0aGDcoBgtwU4InhX5cTmaHYKQTPeNnsKd0P+oTOCV6MnRZ/9xy35BuuoBIJQYeeh1c2HNgGe0XxyqZVa4UHopk0AaJkQFwyq3djEJVWMaQP+rUVzOANH9W7Rs0G1pA8vfyXf5/tVK2x/LEmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431088; c=relaxed/simple;
	bh=Dnfw3O7yWCnVIQEgDYrdHlr08rz6PxDdK3ndz6QSILY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ry65adXxixAsJwjHjf8syfL5f2i8YNuPuxN3zQBWdmX3Ex+s7tp1mDZVlq3D9TMXefeZp8fFicnJcWBiz4J3bvfF61F405HCVauEWu4r3UcuHKyC4cLI0iN6ohf+Az/b2AWUEbBty/oiU/Uv3lAcSOHHmotY0AZVnEwtb/g9FEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PfZdcMqY; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4362c635319so5389806f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 08:11:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771431084; cv=none;
        d=google.com; s=arc-20240605;
        b=c7YcmiCV/Ien9HkKNVRBKcMxPRw03xsRe/yJ/wGhWzC2sz0vzjVgWpu3TlCdyvo6DG
         JEr7Ok84FAsuCO4JCpnD6jFdYDA6SUX5PAF1BEZUotF2uXMDHxX+OLuqT4KGPXyhzfMz
         RyOa4hF7QQsk2Oyz1pRi4cn/QESzLifn3dnRPAr23TC1XeDgse6b+0uljJm/y7HuWIzG
         TtKu+aO0IKKeg5QMlZd3XTl9uaEACPzGmUDVD7lQWtIw6uO5XCO9aEOACsY5PN/wsfyV
         fiJ/pnzrlqPsGhVF/CY8jFtZoR8l7+31Poj0cexkJbc1oGn8KO36tMeJQHMC12ikl6iv
         T+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=npZADHZ7rRxwkGy8riawRonufvbdSCewmEnndlsCQtE=;
        fh=FW7hVxjMLrQ0ckyxhZSyABkXCkN4g++cK6BCLPpD1WU=;
        b=f/JUEOXrlgPPQ7oAhD4vwRro5PjjyrpowCmx9uYuEPGDfHHXhuscAmMcq7A/E4KMkL
         xuL0L2HpHYAAAJkLhCeAnjQx7yLGqnuSQlClu/2b8cRwX3gm3CAUnwtE8KwgN94FcrrD
         chYb0hGXJSU+y8L1vrgeLPq4tIJQW4VQMeovUJdqLg7qfejm5QNMsIPVUoItIf7IIAHX
         O4ayY9U6OS+/LuZX270BuZYrjRaBx83+em6MW6Q7CyV6+D7ThwdKo5MMxXbPlK/sLXI+
         xgWb2n6lMAkJK6DTe637Q2Xcu/OKvk9e7keW5hB5ZP0MQMOlgsI3zmNLfvYkCKipn3Oi
         UAKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771431084; x=1772035884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=npZADHZ7rRxwkGy8riawRonufvbdSCewmEnndlsCQtE=;
        b=PfZdcMqYwNT7onik+41pV0XW615Gz/ybTHKwKGbSkAOd6Mos1WFO7LFtssv3KsJMAR
         XO1TRVb6Qo9qvBRRnOAWBFni1s0Zr1eQu98HHdBJLIqTgYGHCQqJovzdZJXq5RY7WgBA
         KbyJMtBcWCKZLenWtLsvG4qStEZNU8jXJeRMurhR7RdIDttjb3aOAftogUIVGiwTD2ZU
         nRghyuIC+NU7OcJgVdDcGZ5i7lez+7EHPkSZypqLabQ+eMSL1t2/DOfNeqwydh729w4J
         vA4ZP+FZ3IjJp+guVfb6qPNiGwFesSdjS0Ey9sQ8kUrOWMHj0hurPFY7lF2535atr29C
         kOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771431084; x=1772035884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npZADHZ7rRxwkGy8riawRonufvbdSCewmEnndlsCQtE=;
        b=DhSIaJd7vh2LrhTvDOcbuaDyPAYkEdNhifQxhSCjf6s2CUixmnWAqz/bfbSHPKeGrM
         BN0gxkYFe3xJGrHFt4m67WloFxCdzL0wHin7WtQQEGiXMWhTL8mmPzqEjcVtJlyBlqvX
         J7fnx95U+uhdADFrY4TH8hWEHKIT3+0Iy7iLgbZgzqPouFphb3AF3vBGjGA8q5OG7xCH
         eZbm1ef03+e6CDnDY7YWIjpLSKeQB6REWPlfrMtl6lHpE+y80QYza20rZ9cMdw1eLvGf
         VkBmbTmZ93Nb787RtcaWwJnOZ7flwZJu62Ia06R8EMcNeAJbVfN0Zhnc2fzFZh8QTZxw
         XDKg==
X-Forwarded-Encrypted: i=1; AJvYcCU4x1V+M2JJE4zQfTGKz1rYgaou8bc0LJgoN3tIhkPgHyB9veeS/Q+LyTysc7vzFHnIeDgBESKoA0pGyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdL9Jk2IbtP7ZyLHFD/LCMplm4PG8nRTfm5og4+oMYHAF7zNm5
	dk2zcfePFCJr30qRE6OJYH4YbrVx1cAXb+y4PtkEVoCFaEfb9xsjCSAHR1GdhuAxTMV+dCAZza+
	mGp29BJ/PH2/fCC3A8V++V62K2rHX7qYPqr3GGExFTw==
X-Gm-Gg: AZuq6aImnx9WrHSaDsTtQFMd/lYLJ6fQB/lXm4QbbLRqn6zdus6UsM92/VMm2pC3zlr
	63p/6l/70SFEm3XgHh05fFEOkclMqMHzRMNl9gx+HGCX1hoh93h898WPm8pJ0umk6e02wf5DlAM
	qDvdBJsfX6i5WhxEuKXWGw9xK4dGltGJqJR4ZsSOIy+gZP8S1+t9SSHnsnrnKjqYLtEtAbNQplJ
	SGmq9tFqcG4E9yWWyLcUeb89UF59nby1xORwuLcJF4f5kkTTE5dq/Mh7GljNFfvB7x/j84dYSMP
	j8UVlumFDzf8lsyXfnkVh+uRlL0f+E8OxdF+up6M/prq9x5FRTviNqJOf82c+Df3Kh71OKZvyzk
	7fTu0
X-Received: by 2002:a05:6000:2dca:b0:437:6e63:9172 with SMTP id
 ffacd0b85a97d-43958df3516mr4465105f8f.4.1771431084459; Wed, 18 Feb 2026
 08:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-21-neelx@suse.com>
 <20260208151928.3245396-1-clm@meta.com> <CAPjX3FdiskLiELriX5gE2YEDMMwz5QQbNDnkAuFVov1a=WL_jQ@mail.gmail.com>
 <989433cb-4ab6-4a79-8dfc-9f5f542e2647@meta.com>
In-Reply-To: <989433cb-4ab6-4a79-8dfc-9f5f542e2647@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Feb 2026 17:11:13 +0100
X-Gm-Features: AaiRm52H6a8Dx1S_J50i9RFK-wqtAs4pqoNkIHGApsZEVneSHeR9ZFaJMuu2lQI
Message-ID: <CAPjX3Ff3qBoBxWzZ+Tg5HgSSEPGrbmmGMmf5MtiE4iU8PtHUMw@mail.gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21763-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 0D5D9157A05
X-Rspamd-Action: no action

On Wed, 18 Feb 2026 at 16:50, Chris Mason <clm@meta.com> wrote:
> On 2/18/26 10:29 AM, Daniel Vacek wrote:
> > On Sun, 8 Feb 2026 at 16:20, Chris Mason <clm@meta.com> wrote:
> >> Daniel Vacek <neelx@suse.com> wrote:
> >>> From: Josef Bacik <josef@toxicpanda.com>
> >>>
> >>> We're going to need these to update the file extent items once the
> >>> writes are complete.  Add them and add the pieces necessary to assign
> >>> them and free everything.
> >>>
> >>
> >> Hi everyone,
> >>
> >> I'm running the btrfs for-next branch, along with the encryption patch set
> >> through my AI review prompts:
> >>
> >> https://github.com/masoncl/review-prompts
> >>
> >> I'm working on some btrfs specific instructions, but hopefully these reviews
> >> are already useful.  I've kept the headers to make it easier to double check
> >> that I'm actually replying to the right email, but please let me know if any
> >> parts of this are incorrect:
> >>
> >> commit 61cd57301840de69a3f6573374d41ad4b4bcf348
> >> Author: Josef Bacik <josef@toxicpanda.com>
> >>
> >> btrfs: add fscrypt_info and encryption_type to ordered_extent
> >>
> >> This commit adds encryption-related fields (encryption_type and
> >> fscrypt_info) to struct btrfs_ordered_extent to support fscrypt
> >> integration in btrfs.
> >>
> >>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> >>> index 5df02c707aee6..7a5701937184e 100644
> >>> --- a/fs/btrfs/ordered-data.c
> >>> +++ b/fs/btrfs/ordered-data.c
> >>> @@ -192,6 +192,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
> >>>       }
> >>>       entry->inode = inode;
> >>>       entry->compress_type = compress_type;
> >>> +     entry->encryption_type = BTRFS_ENCRYPTION_NONE;
> >>>       entry->truncated_len = (u64)-1;
> >>>       entry->qgroup_rsv = qgroup_rsv;
> >>
> >> This isn't a bug, but the fscrypt_info field isn't explicitly initialized
> >> to NULL here. While kmem_cache_zalloc() at line 175 does zero the memory,
> >> all the other important fields in this function are explicitly initialized
> >> (compress_type, encryption_type, truncated_len, qgroup_rsv, refs). Would
> >> adding an explicit 'entry->fscrypt_info = NULL;' improve consistency?
> >
> > `entry->fscrypt_info` is set in the very next patch "[21/43] btrfs:
> > plumb through setting the fscrypt_info for ordered extents". The
> > series is meant to be applied as a whole. It's just factored into
> > implementation steps.
>
> The prompts try to flag any patch series that don't follow best
> practices around bisectability.  There isn't a ton of instruction about
> what those best practices are beyond if commit A makes bug and then
> commit B fixes the bug, flag it.
>
> This patch set is pretty unusual because you're trying to preserve
> authorship for a number of people, and so there are a lot of small
> judgement calls about when to change patches and when to fix them up
> later.  I sent claude's comments to help highlight places we want to
> decide things, but I don't think there's really a wrong decision.

I understand that. I was checking every commit to ensure it builds
correctly. But not really testing for bugs or regressions.

> >
> >>>       entry->flags = flags;
> >>> @@ -630,6 +631,7 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
> >>>               btrfs_add_delayed_iput(entry->inode);
> >>>               list_for_each_entry_safe(sum, tmp, &entry->list, list)
> >>>                       kvfree(sum);
> >>> +             fscrypt_put_extent_info(entry->fscrypt_info);
> >>>               kmem_cache_free(btrfs_ordered_extent_cache, entry);
> >>>       }
> >>>  }
> >>> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> >>> index 1e6b0b182b295..ce19198e7f844 100644
> >>> --- a/fs/btrfs/ordered-data.h
> >>> +++ b/fs/btrfs/ordered-data.h
> >>> @@ -124,6 +124,9 @@ struct btrfs_ordered_extent {
> >>>       /* compression algorithm */
> >>>       int compress_type;
> >>>
> >>> +     /* encryption mode */
> >>> +     u8 encryption_type;
> >>> +
> >>
> >> This isn't a bug, but placing the u8 encryption_type field between two int
> >> fields creates 3 bytes of padding. This is minor, but in a filesystem with
> >> many ordered extents, it could add up. The current placement does have the
> >> advantage of grouping encryption-related fields together logically, though.
> >
> > This was actually changed from int (as Dave suggested, IIRC). But I
> > did not move it.
> > I guess we can do this:
> >
> > --- a/fs/btrfs/ordered-data.h
> > +++ b/fs/btrfs/ordered-data.h
> > @@ -127,18 +127,18 @@ struct btrfs_ordered_extent {
> >      /* flags (described above) */
> >      unsigned long flags;
> >
> > -    /* compression algorithm */
> > -    int compress_type;
> > -
> > -    /* encryption mode */
> > -    u8 encryption_type;
> > -
> >      /* Qgroup reserved space */
> >      int qgroup_rsv;
> >
> >      /* reference count */
> >      refcount_t refs;
> >
> > +    /* compression algorithm */
> > +    int compress_type;
> > +
> > +    /* encryption mode */
> > +    u8 encryption_type;
> > +
>
> Seems mostly the same?  I'd suggest paholing things to find a good spot.

Hmm, that's what I did. There was a 4 bytes hole.
Nah, I see. I just moved it. It's not a big deal then. The structure's
size remains unchanged in either case. Still plugging a hole. Or am I
missing something?

> >      /* the inode we belong to */
> >      struct btrfs_inode *inode;
> >
> >
> >>>       /* Qgroup reserved space */
> >>>       int qgroup_rsv;
> >>>
> >>> @@ -133,6 +136,9 @@ struct btrfs_ordered_extent {
> >>>       /* the inode we belong to */
> >>>       struct btrfs_inode *inode;
> >>>
> >>> +     /* the fscrypt_info for this extent, if necessary */
> >>> +     struct fscrypt_extent_info *fscrypt_info;
> >>> +
> >>>       /* list of checksums for insertion when the extent io is done */
> >>>       struct list_head list;
> >>
> >> How does btrfs_split_ordered_extent() handle the new fscrypt_info field?
> >> Looking at that function in ordered-data.c, it calls alloc_ordered_extent()
> >> which initializes encryption_type to BTRFS_ENCRYPTION_NONE and fscrypt_info
> >> to NULL. If the original ordered extent has encryption_type set to
> >
> > Ditto. This is changed in the next patch [21/43].
> > alloc_ordered_extent() correctly sets these fields.
>
> It seems unlikely that we're really going to maintain bisectability for
> encryption being on in the middle of this patchset.  So this seems fine
> to me as long as the bug doesn't impact encryption being off.

Yeah, I think it should not. (Famous last words...)

Thanks.

--nX

> -chris
>

