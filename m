Return-Path: <linux-btrfs+bounces-10813-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470EDA07019
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 09:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C7F1679CC
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E4E215168;
	Thu,  9 Jan 2025 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Od4CWA8j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD891FDA
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411507; cv=none; b=m6c935xOACcqQVbiDs6dD6FatHB515MWUighuCWjsJqbdMJ5KAbSbLh6ufagYVLFBCnsjkFHbGg2zJQ1/AlaP4PmkHNf/WeONT2p7zFQueohJ0nOUU2xiztnWG1CnBgcwSxsvL2E+Zr9lfy/bhf7cwQ4Dv6o6+c1pmWnIbttNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411507; c=relaxed/simple;
	bh=HwyJPSl/PubqFN3c254apdbGGBkSgtnxbOgDAL0Avvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8IWTxn59WhXmQ97kqqkpCkQWFIja8UaCGy2ImcsQ9IBX/HKl0SvqY1EHxUF3qnTMpkLYFN22Wq2UkEDTLif2UtkQ6xluI3FJW8uFNbMKIHR3p10EnhqnDKi404upNJw+cI6CkAFythPaXEaY8g3o7+Z9hjdkSy8hDPpiZ5YcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Od4CWA8j; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso120227966b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jan 2025 00:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736411504; x=1737016304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uvT+G1gE7CcRwx7VsI0GAoJoEwmotiFD7x61nG6NIow=;
        b=Od4CWA8j08avAzdoHZT7dLhzACfclzIZvWfXw/INQoYsoSdIlS2hIjf6hJtg0ErKXH
         vHGodF1cKzrYCuRKMJDHluML7NlpS9YX5LBq3qmNN3j3ympNpLgvVzUcehAAuHgEGzdP
         XxMRSB06R0P9YfkoUeVRoqWihHn41ppo8rcjWA+F89XnnzUl5vvsng09f6tWwJ8eZPfE
         vsfxcDftjXWcD12xfxsSzlrawz3IdPunsyVGFUrS/8KtN7dIEf/LiCqUDDX6Tjp8aq6z
         AT+otS6WL54UHoNOfziDcBVnq1C3Nx4NP83zNJBpcJghxS+aYBaJyLWOgSX/LUNGUhrX
         LhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736411504; x=1737016304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvT+G1gE7CcRwx7VsI0GAoJoEwmotiFD7x61nG6NIow=;
        b=gGtrEKyM1sFbgwbH/AeQfR9HAhPL4imaoZLjHu+X9p3q+/Myqd+79CtAmdBdEmAMW3
         4P0mwR3VNSCj6gSYSCwxJb3kTCEAfRcmUcgs7WBlOdG/FPOxnHynvYkLqFYx83ExdjPg
         MYRabSjZ7zr7PW8M7ONal8nc6oMJYRcBklPNKKwF5KlapagqqVVEDaaDU99nJzTj+fB/
         7gp6Y2EprUFbUAp8lNpn3Rry5LTgjbzOGV0+6J1nw1ryTiMvfgGY7Wn4i8sGx8MJq0Q7
         TsNtPW4ZW1V0bM2DsECJcNNb4YQ1Eg/gSoHWvkChXuKwTFv1n5GIB2xKa94lgFOT0fwt
         TRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTaOb4nEneEFfGyz944VA2AfjpACZ2Vb1k5hWdAH2FQ2GatUII1jLNfZbR1x0tGTnDuOVEiuH74s2X5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj2/ikx24PVVYLgP+IJdX7kyTUTu2C6dFvsmX+/qwY628/EKU0
	9zDNkeSS1D66zidO3o5EmgALalUqW0S0wA451O2HKuArhtLRb7tn6zIrCy0e5YGXHR6LpQ9fdZn
	7pLVb4bhobWwKp7Vjbedrqa9K4aj1INRnmnMUug==
X-Gm-Gg: ASbGncucbn8C/0uvwCxRY71Lw451yfUvDWmJuzi7/YilL5ACrlEVzPhZ1tjFPk1FjHG
	1cM15HOSUAbv53T61GmJTzC7P1DXhcTWiQwkm
X-Google-Smtp-Source: AGHT+IFsbj7KBm1v7fS0ZvRDc4p/q8c6757EFt0LXoo4TUmaIBFvuCEk4wkFZ7SgKaQ34jaT4Vm72EcLeqiLt2ciBqU=
X-Received: by 2002:a17:907:6d20:b0:aa6:800a:1291 with SMTP id
 a640c23a62f3a-ab2ab167fb7mr481251866b.7.1736411503838; Thu, 09 Jan 2025
 00:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108114326.1729250-1-neelx@suse.com> <9cca57da-3361-470d-83e5-0d78deffb673@wdc.com>
 <CAPjX3Feomu-=eBot9WRf3k3U+4BmbA0szH8cKHF6GdbKRBNZ1w@mail.gmail.com> <20250108182315.GH31418@twin.jikos.cz>
In-Reply-To: <20250108182315.GH31418@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 9 Jan 2025 09:31:33 +0100
X-Gm-Features: AbW1kvY5-pjuYmZB9bCxT9SkUQULBEIxhoGsqlB2zCHPiuGt4X8dYo6HB5yrEZo
Message-ID: <CAPjX3FcbZwFbMLhnayEDxegesJ-3qBE3T1yk5eBA6dE+Y4p7CA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: keep `priv` struct on stack for sync reads in `btrfs_encoded_read_regular_fill_pages()`
To: dsterba@suse.cz
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 19:27, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Jan 08, 2025 at 04:24:19PM +0100, Daniel Vacek wrote:
> > On Wed, 8 Jan 2025 at 13:42, Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> > > On 08.01.25 12:44, Daniel Vacek wrote:
> > > > Only allocate the `priv` struct from slab for asynchronous mode.
> > > >
> > > > There's no need to allocate an object from slab in the synchronous mode. In
> > > > such a case stack can be happily used as it used to be before 68d3b27e05c7
> > > > ("btrfs: move priv off stack in btrfs_encoded_read_regular_fill_pages()")
> > > > which was a preparation for the async mode.
> > > >
> > > > While at it, fix the comment to reflect the atomic => refcount change in
> > > > d29662695ed7 ("btrfs: fix use-after-free waiting for encoded read endios").
> > >
> > > Generally I'm not a huge fan of conditional allocation/freeing. It just
> > > complicates matters. I get it in case of the bio's bi_inline_vecs where
> > > it's a optimization, but I fail to see why it would make a difference in
> > > this case.
> > >
> > > If we're really going down that route, there should at least be a
> > > justification other than "no need" to.
> >
> > Well the main motivation was not to needlessly exercise the slab
> > allocator when IO uring is not used. It is a bit of an overhead,
> > though the object is not really big so I guess it's not a big deal
> > after all (the slab should manage just fine even under low memory
> > conditions).
> >
> > 68d3b27e05c7 added the allocation for the async mode but also changed
> > the original behavior of the sync mode which was using stack before.
> > The async mode indeed requires the allocation as the object's lifetime
> > extends over the function's one. The sync mode is perfectly contained
> > within as it always was.
> >
> > Simply, I tend not to do any allocations which are not strictly
> > needed.
>
> Nothing wrong about that and I think in kernel it's preferred to avoid
> allocations in such cases. The sync case is calling the ioctl and
> repeatedly too, so reducing the allocator overhead makes sense, at the
> slight cost of code complexity. The worst case is when allocator has to
> free memory by flushing or blocking the tasks, so we're actively
> avoiding and reducing the chances for that.
>
> > If you prefer to simply allocate the object unconditionally,
> > we can just drop this patch.
> >
> > > >   struct btrfs_encoded_read_private {
> > > > -     struct completion done;
> > > > +     struct completion *sync_reads;
> > > >       void *uring_ctx;
> > > > -     refcount_t pending_refs;
> > > > +     refcount_t pending_reads;
> > > >       blk_status_t status;
> > > >   };
> > >
> > > These renames just make the diff harder to read (and yes I shouldn't
> > > have renamed pending to pending_refs but that at least also changed the
> > > type).
> >
> > I see. But also the completion is changed to a pointer here for a
> > reason and I tried to make it clear it's only used for sync reads,
> > hence the rename.
>
> Functional and cleanup/cosmetic changes are better kept separate. It's
> keeping the scope of changes minimal and usually the fixes can get
> backported so the cleanup changes are not wanted.

Right, I see. Noted.

Though in this case there is no fix and I don't see a reason for
backporting this one.
But I guess you were talking about eventual other possible fixes in the area.

> > > > -     if (refcount_dec_and_test(&priv->pending_refs)) {
> > > > -             int err = blk_status_to_errno(READ_ONCE(priv->status));
> > > > -
> > > > +     if (refcount_dec_and_test(&priv->pending_reads)) {
> > > >               if (priv->uring_ctx) {
> > > > +                     int err = blk_status_to_errno(READ_ONCE(priv->status));
> > >
> > > Missing newline after the declaration.
> >
> > Right. Clearly I did not run checkpatch before sending. Sorry.
> > I was just trying to match this block to the same one later, which did
> > not have the newline. (But it also did not have the declaration
> > before.)
>
> We don't stick to what checkpatch reports, I'm fixing a lot of coding
> style when merging patches that would not pass checkpatch, the general
> CodingStyle applies but we have a local fs/btrfs style too, loosely
> documented at https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html .

Bookmarked, thanks.

--nX

On Wed, 8 Jan 2025 at 19:27, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Jan 08, 2025 at 04:24:19PM +0100, Daniel Vacek wrote:
> > On Wed, 8 Jan 2025 at 13:42, Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> > > On 08.01.25 12:44, Daniel Vacek wrote:
> > > > Only allocate the `priv` struct from slab for asynchronous mode.
> > > >
> > > > There's no need to allocate an object from slab in the synchronous mode. In
> > > > such a case stack can be happily used as it used to be before 68d3b27e05c7
> > > > ("btrfs: move priv off stack in btrfs_encoded_read_regular_fill_pages()")
> > > > which was a preparation for the async mode.
> > > >
> > > > While at it, fix the comment to reflect the atomic => refcount change in
> > > > d29662695ed7 ("btrfs: fix use-after-free waiting for encoded read endios").
> > >
> > > Generally I'm not a huge fan of conditional allocation/freeing. It just
> > > complicates matters. I get it in case of the bio's bi_inline_vecs where
> > > it's a optimization, but I fail to see why it would make a difference in
> > > this case.
> > >
> > > If we're really going down that route, there should at least be a
> > > justification other than "no need" to.
> >
> > Well the main motivation was not to needlessly exercise the slab
> > allocator when IO uring is not used. It is a bit of an overhead,
> > though the object is not really big so I guess it's not a big deal
> > after all (the slab should manage just fine even under low memory
> > conditions).
> >
> > 68d3b27e05c7 added the allocation for the async mode but also changed
> > the original behavior of the sync mode which was using stack before.
> > The async mode indeed requires the allocation as the object's lifetime
> > extends over the function's one. The sync mode is perfectly contained
> > within as it always was.
> >
> > Simply, I tend not to do any allocations which are not strictly
> > needed.
>
> Nothing wrong about that and I think in kernel it's preferred to avoid
> allocations in such cases. The sync case is calling the ioctl and
> repeatedly too, so reducing the allocator overhead makes sense, at the
> slight cost of code complexity. The worst case is when allocator has to
> free memory by flushing or blocking the tasks, so we're actively
> avoiding and reducing the chances for that.
>
> > If you prefer to simply allocate the object unconditionally,
> > we can just drop this patch.
> >
> > > >   struct btrfs_encoded_read_private {
> > > > -     struct completion done;
> > > > +     struct completion *sync_reads;
> > > >       void *uring_ctx;
> > > > -     refcount_t pending_refs;
> > > > +     refcount_t pending_reads;
> > > >       blk_status_t status;
> > > >   };
> > >
> > > These renames just make the diff harder to read (and yes I shouldn't
> > > have renamed pending to pending_refs but that at least also changed the
> > > type).
> >
> > I see. But also the completion is changed to a pointer here for a
> > reason and I tried to make it clear it's only used for sync reads,
> > hence the rename.
>
> Functional and cleanup/cosmetic changes are better kept separate. It's
> keeping the scope of changes minimal and usually the fixes can get
> backported so the cleanup changes are not wanted.
>
> > > > -     if (refcount_dec_and_test(&priv->pending_refs)) {
> > > > -             int err = blk_status_to_errno(READ_ONCE(priv->status));
> > > > -
> > > > +     if (refcount_dec_and_test(&priv->pending_reads)) {
> > > >               if (priv->uring_ctx) {
> > > > +                     int err = blk_status_to_errno(READ_ONCE(priv->status));
> > >
> > > Missing newline after the declaration.
> >
> > Right. Clearly I did not run checkpatch before sending. Sorry.
> > I was just trying to match this block to the same one later, which did
> > not have the newline. (But it also did not have the declaration
> > before.)
>
> We don't stick to what checkpatch reports, I'm fixing a lot of coding
> style when merging patches that would not pass checkpatch, the general
> CodingStyle applies but we have a local fs/btrfs style too, loosely
> documented at https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html .

