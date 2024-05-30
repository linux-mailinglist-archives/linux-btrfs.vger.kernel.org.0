Return-Path: <linux-btrfs+bounces-5360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6438D4461
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 05:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66F62856AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 03:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D171D142E70;
	Thu, 30 May 2024 03:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYSdVtw/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45926AF3
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 03:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717041379; cv=none; b=Wjv677NZhHtKnzABM7v5w+7d1Tfp0TN1V76toi5MabdaKrEkZsd5Ree0wi5qToQKziQp2yxXNdhc/QvgEfUKfjwCXVXDiskPcR9UhHmb91gwDJzt34CnXpkwP5z5NzeISCKfZTD7QDVg9vsYnhhvZ3Fltg6zvETmXyL+8Qf2ITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717041379; c=relaxed/simple;
	bh=DRqM24DPS2CEQLq0AsMI/64rRD2hwW5OWAZVVoGdqBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMyfNhIGZy07zOMDQtlJ4XYDWPd1XcNi99sjW8rIjj1WP4MM6Gp10gQEHklRaYsheKAjA/ZIMlvtjiomMgZxjZlXnGAKRYRTAAiECHB2NV21z1ldQWv/Xz2GMa1fF62HDYFjPJgPjOcsBLmW0joEopLsz4kUw3kiKvpC+NKyk7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYSdVtw/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a183ad429so340321a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 20:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717041376; x=1717646176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KidVi8YArQCn6EjuNNDOTiMAu76Fq3UCDQIOzjDJLk=;
        b=YYSdVtw/j1JtBBDFlemV11Lli65bm1TSmcKcEV/OkjRObnJeCH8vKHzw55k6GZh78H
         oc3TE2TxS41X0/ZQfP2PEr9+m7eMmRZZDXJq2FiNeM0HWBDVozuxCblvewagMVJXZWnX
         mupuDHkBNtV410gTF3I+SSt/IVhudn/q9ShHJ+UZzBqWxU1hpogXFD6s9NXes2O9Z5EK
         cpDQvcj/lfO6P6QkgAIIFMIdUN7Pd7V28I4FJm5dF3KeVYSfXjIvp7a+66twXpF6r9KP
         whWUgJfU/fIkzzkw5FeTuc/4e/5ja1C217O2zuBTEDgFp4/sydOb8mD9nzH4lwbhJUaS
         841w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717041376; x=1717646176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KidVi8YArQCn6EjuNNDOTiMAu76Fq3UCDQIOzjDJLk=;
        b=ANDNNoRBqqUOwBRg3nTc6nUROhZSQ01PO6zIOcDuyDdqqVMGCBjMnfvqbJngcrQYzX
         H3vABbX2qdiYu4Dlq5POuHpfamH6LYFCGL0MUoLXHczl9T7alEukWSmOfBszqmz5BmIF
         3DvWe4IRUKQbgXxfvsDs4YljBHwuHm1CzTKdpucgHuG1LoyPQsDc2wcsb2JCbrbMZ9tF
         og4jPSarOueAyEZs0wcO9KOC332cNUGNCF9RayLeGZWT65Sq4OvkN3IbIkCK2MqFStxv
         gfxe5gw40Wg3hp212QsyWrghW5TnNxjWsU8NNs5aLrTcDi3zjCLP3C8IFxC9+wVP6zSe
         yIZQ==
X-Gm-Message-State: AOJu0YxvQlUBoQy43wK8v3a0Y4BBMVnjOYU2bODqZlwCNpPmZj/lg9r2
	0vEq/pUYtA5dfdRAYw28J3S/n7uBDNosBiTifX/dWAjmrm4WCLWNskjF9z6KsciQ/L0qLQ2HBWb
	nanUX7gR6fQMOlaHfMPgTwOwOPaCH6qwEmek=
X-Google-Smtp-Source: AGHT+IGb/5pe3ng4Ep0QxNrz8xYkn/uM5v0Gzlz8xWAvS49EV2yWPpvm/PuhhdveGEDLX3N2CR5JlLTMZSeMYLhHOQU=
X-Received: by 2002:a50:cdce:0:b0:578:6322:234a with SMTP id
 4fb4d7f45d1cf-57a1780e638mr513469a12.10.1717041375480; Wed, 29 May 2024
 20:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528062343.795139-1-sunjunchao2870@gmail.com>
 <42631f4d-97ca-4f7b-a851-c06383b35065@gmx.com> <CAHB1NaidZ1WjkpshMC3zWwX1_3nL3AULG46fc4gmygb9TAa82A@mail.gmail.com>
 <932eb368-ce1c-4301-87a6-325458c29541@gmx.com>
In-Reply-To: <932eb368-ce1c-4301-87a6-325458c29541@gmx.com>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Thu, 30 May 2024 11:56:04 +0800
Message-ID: <CAHB1Naho4uw3S=PKB=c2eA0Fs-WgTS5sxpZKx+u2PjLNfHQw5Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: delete a todo about using kmem cache to
 alloc structure
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=8830=E6=97=
=A5=E5=91=A8=E5=9B=9B 05:55=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> =E5=9C=A8 2024/5/29 22:41, JunChao Sun =E5=86=99=E9=81=93:
> > Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=8C 14:42=E5=86=99=E9=81=93=EF=BC=9A
> [...]
> >>
> >> Reviewed-by: Qu Wenruo <wqu@suse.com>
> >>
> >> My bad, at the time of writing I didn't notice that qgroup is not alwa=
ys
> >> enabled.
> >>
> >>> Furthermore nowadays squota won't utilize that structure either, maki=
ng
> >>> it less meaningful to go kmemcache.
> > Thank you for your further explanation. By the way, is there anything
> > meaningful todo? I saw some in code, but I can't ensure if they are
> > still meaningful. I'd like to try contributing to btrfs and improve my
> > understanding of it.
>
>
> > In fact I'm considering converting btrfs_qgroup_extent_record::node to
> > XArray, inspired by the recent conversion by Filipe for btrfs_root::ino=
des.
> >
> > Which should reduce the memory usage for btrfs_qgroup_extent_record.
Thanks for your suggestion. I saw the patch, it's really great. Maybe
I can try to do same thing for btrfs_qgroup_extent_record::node.
>
>
> > Also, is it a meaningful to view the contents of snapshots without
> > rolling them back? The company I work for is considering implementing
> > it recently...
>
> What do you mean by rolling back?
>
>
> > IIRC one can always access the snapshot from parent subvolume, or just
> > mount the snapshot.
yeh, I realized it now.
>
> Thanks,
> Qu
>
> >>
> >> Thanks,
> >> Qu
> >>> ---
> >>>    fs/btrfs/qgroup.h | 1 -
> >>>    1 file changed, 1 deletion(-)
> >>>
> >>> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> >>> index 706640be0ec2..7874c972029c 100644
> >>> --- a/fs/btrfs/qgroup.h
> >>> +++ b/fs/btrfs/qgroup.h
> >>> @@ -123,7 +123,6 @@ struct btrfs_inode;
> >>>
> >>>    /*
> >>>     * Record a dirty extent, and info qgroup to update quota on it
> >>> - * TODO: Use kmem cache to alloc it.
> >>>     */
> >>>    struct btrfs_qgroup_extent_record {
> >>>        struct rb_node node;
> >

