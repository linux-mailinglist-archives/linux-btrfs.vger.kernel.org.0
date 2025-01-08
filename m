Return-Path: <linux-btrfs+bounces-10793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94100A0600A
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 16:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7173A79DF
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2C51FECAC;
	Wed,  8 Jan 2025 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fQ2z7ZmD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21341A9B34
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2025 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349875; cv=none; b=n0gyGwWv9RXfiUT+pRxBlyMopm6pNkfyRvBt56Bk2s5i+JGrUXZUAE5y18weu5fz5ta5UOYXJXyDKs2v6x3JgHgTl2M3OyBUCIuUg556ZVdhTIVYbukTc9ve2/y1H1Ox1mN0ZGysBodjgna+CQHQDb9xA2lmutNgOKCqaYgSxoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349875; c=relaxed/simple;
	bh=w4UOw7Nf2Dw6uvzGWYQjY9EdcIWTeAAnFTgT3BDzQcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkVHrYNKzWAIulmDlTH/omZQk04cpGCt+NtsPPtk20Jx+WGr70nSoQnIMAJUBao+roPX1ETrcha8p09RCBegAUp32EaMN84Vz86VQ2xg0tzyLQfqyQ1+Vgfz/GlmQhMYuLYv1a+xBYY25A1He+FJQ9QOZ921RMyl8kiH1DpxpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fQ2z7ZmD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa69107179cso2813369266b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jan 2025 07:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736349870; x=1736954670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N/gSsZSi5JKdnXR2e/t3wvsXD6L9KLAKSh3ix6dcUFo=;
        b=fQ2z7ZmDDNv5By1eASIVh3rNaAuPjknLqG8N/MFJfBp7q9MjJnFb0akDDQeQE41UAB
         UU4xFutmtt0RCOEyF7c6ONpbddPDfpmNBycSqcoJjWm01prafZxQ6lEjLGpeGKTZ27Zt
         xQO1tjfNX59iA03Q4cQhdwBWbwM9itEvHTx4MUUCC156a16lQ5C3bkPlEms32yPkjvee
         RIPpIvaHcd36ml54k0N3lyHUCy2jDNAXLqMhRQZmDpvZpcFqI6HpGNh1DZlILW9YoUNw
         lIJ6Kset8RmcuomWSl7FxR05sxl7dQvHPYIX4klR85lyxetJgQKYAUk4jugXm2yPFl2k
         WAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736349870; x=1736954670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/gSsZSi5JKdnXR2e/t3wvsXD6L9KLAKSh3ix6dcUFo=;
        b=mNz7NZDCCz7rzFNPsxTlBhgR8Dnn7vTWlZ35zhT0YjqwseL/+FteXRIBLCVwwnLDBn
         SkuDIVCG5/JMj4pivMklroOeWaPsuretpRNTelohcN0WrbkSIJSsPVx/w4Be+ZCtfFCh
         pHdPEzpRlkfwO0v+sWFX7L4mzObZN4gCMS+gPf5+bxeAfJroYhuSwLb6xZq6g7k+aOmd
         lRZENII4iJ5SadyNDfFekE3kwYsVpn9BBEmRdFNDmk6xU0IDIODf8NBM4XMP/QrChgDX
         UBS+7PoEM+ouIPPwyGiKHA8f4gRfQRYBL9Zuvjg/46exG8whTZnN23O0TIl3X5FhSdzg
         e2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoTSzUoO1nLEqqucTiTSNJXatSi0eiXP61iuyhrWFcHP6amyXk7dQMGEMGWxKZ2W7PmaZz+fE583eI6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5tSbVnu6/PJbaVoU736ETMuLypqkIOWFBwM5RRnFNItDLxLF
	IRwrG4eBURg0hDIQ/DLfT6m/1QETIMXpAi16cjgiQV2666OVjadDMKmt75yAMdEfttq/wRarV1D
	VWdWwlMabnpmfFKQmKHivt7zzWJOkflcDNgXwzg==
X-Gm-Gg: ASbGncthVK/RlSDDjFg/K04+ohym/pRgSdlPEqskUkDZlStyLWKtTJ1cNEnirrpPCsY
	Ozv29kBbAgpMJ4NlZRS5knKRurl/IVlEEfRQTcqOoWcORNybJRqOXiy4WAfRwX1XEh7Cjlvw=
X-Google-Smtp-Source: AGHT+IFJuPZu3YAY6JAU4e57J2LHXnODfX9zHpu9Ldk4keDODus8wpDzwDxnHBmdoyRRVM9E9W5uKJJw8rDpIGbZLwQ=
X-Received: by 2002:a17:907:3f8c:b0:aa6:5603:e03d with SMTP id
 a640c23a62f3a-ab2abc922b8mr203583066b.59.1736349869937; Wed, 08 Jan 2025
 07:24:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108114326.1729250-1-neelx@suse.com> <9cca57da-3361-470d-83e5-0d78deffb673@wdc.com>
In-Reply-To: <9cca57da-3361-470d-83e5-0d78deffb673@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 8 Jan 2025 16:24:19 +0100
X-Gm-Features: AbW1kvZRGfnX-rDi1J99552u-W05EsSTu-cZBD8XBAfymmYRCdiktt_4YrMGXXk
Message-ID: <CAPjX3Feomu-=eBot9WRf3k3U+4BmbA0szH8cKHF6GdbKRBNZ1w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: keep `priv` struct on stack for sync reads in `btrfs_encoded_read_regular_fill_pages()`
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 13:42, Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 08.01.25 12:44, Daniel Vacek wrote:
> > Only allocate the `priv` struct from slab for asynchronous mode.
> >
> > There's no need to allocate an object from slab in the synchronous mode. In
> > such a case stack can be happily used as it used to be before 68d3b27e05c7
> > ("btrfs: move priv off stack in btrfs_encoded_read_regular_fill_pages()")
> > which was a preparation for the async mode.
> >
> > While at it, fix the comment to reflect the atomic => refcount change in
> > d29662695ed7 ("btrfs: fix use-after-free waiting for encoded read endios").
>
>
> Generally I'm not a huge fan of conditional allocation/freeing. It just
> complicates matters. I get it in case of the bio's bi_inline_vecs where
> it's a optimization, but I fail to see why it would make a difference in
> this case.
>
> If we're really going down that route, there should at least be a
> justification other than "no need" to.

Well the main motivation was not to needlessly exercise the slab
allocator when IO uring is not used. It is a bit of an overhead,
though the object is not really big so I guess it's not a big deal
after all (the slab should manage just fine even under low memory
conditions).

68d3b27e05c7 added the allocation for the async mode but also changed
the original behavior of the sync mode which was using stack before.
The async mode indeed requires the allocation as the object's lifetime
extends over the function's one. The sync mode is perfectly contained
within as it always was.

Simply, I tend not to do any allocations which are not strictly
needed. If you prefer to simply allocate the object unconditionally,
we can just drop this patch.

> >   struct btrfs_encoded_read_private {
> > -     struct completion done;
> > +     struct completion *sync_reads;
> >       void *uring_ctx;
> > -     refcount_t pending_refs;
> > +     refcount_t pending_reads;
> >       blk_status_t status;
> >   };
>
> These renames just make the diff harder to read (and yes I shouldn't
> have renamed pending to pending_refs but that at least also changed the
> type).

I see. But also the completion is changed to a pointer here for a
reason and I tried to make it clear it's only used for sync reads,
hence the rename.

> > -     if (refcount_dec_and_test(&priv->pending_refs)) {
> > -             int err = blk_status_to_errno(READ_ONCE(priv->status));
> > -
> > +     if (refcount_dec_and_test(&priv->pending_reads)) {
> >               if (priv->uring_ctx) {
> > +                     int err = blk_status_to_errno(READ_ONCE(priv->status));
>
> Missing newline after the declaration.

Right. Clearly I did not run checkpatch before sending. Sorry.
I was just trying to match this block to the same one later, which did
not have the newline. (But it also did not have the declaration
before.)

> >       unsigned long i = 0;
> >       struct btrfs_bio *bbio;
> > -     int ret;
>
> That seems unrelated.

It's only used in the async branch. I prefer to have it local to that
branch for readability. Also it matches the same block from the
previous function.

> > @@ -9155,25 +9159,23 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
> >               disk_io_size -= bytes;
> >       } while (disk_io_size);
> >
> > -     refcount_inc(&priv->pending_refs);
> > +     refcount_inc(&priv->pending_reads);
> >       btrfs_submit_bbio(bbio, 0);
> >
> >       if (uring_ctx) {
> > -             if (refcount_dec_and_test(&priv->pending_refs)) {
> > -                     ret = blk_status_to_errno(READ_ONCE(priv->status));
> > -                     btrfs_uring_read_extent_endio(uring_ctx, ret);
> > +             if (refcount_dec_and_test(&priv->pending_reads)) {
> > +                     int err = blk_status_to_errno(READ_ONCE(priv->status));
> > +                     btrfs_uring_read_extent_endio(uring_ctx, err);
> >                       kfree(priv);
>
> Missing newline after the declaration, but still why can't we just keep ret?

The new line was not there before. But back then it was not a
declaration, right?

The rename to `err` just happened as I copied this block from
`btrfs_encoded_read_endio()`. It's a matching code, we could even
factor it out eventually. Again, it's just a bit more descriptive that
the returned value is an error code. It's a matter of preference. I
was just polishing the code a bit while already touching it.

--nX

