Return-Path: <linux-btrfs+bounces-18946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9670C577B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 13:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 895384E3D90
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADC834F491;
	Thu, 13 Nov 2025 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JUhuZbL5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC6A10F1
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038105; cv=none; b=EuEL9LIfcdyvM8T7TW3nOz8XjanYmkgSL7wZ+zmEtrdZbxlfzgd69S3xxCJjRJGloSUbqdfnXtTXjMO2mcESMy1Tok4IEthEim9WmJ59am54sE72+ov0z90TmGf1dCKCRNq2VOn5JitjaA6A4KwGjSPNCJoAqSDbAkY2dlliaQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038105; c=relaxed/simple;
	bh=0WAjlQlYd7TRhzy9CdLhI5NpDR8tBXFa7yz4Q+j/n/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAWWT+evh0Ddoe9J36XxAmB6A885eRPP7WjX1xlEw5zQH0ruegmd0GRo9fv91869uk1L+H3+8SyS7uWxMNiyTCzKIW+g9DBKb3yKjAFlWh5WYq6/aLlczH/bPl2zZL+o6PwUK45Ka97x8ENqJSR/lNz58D+47GTEyDHva7Qj4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JUhuZbL5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b32a5494dso412302f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 04:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763038102; x=1763642902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9KdbGIqeaFLzm3aG4RneLOSJzVNfE/rTf15PS18ARmI=;
        b=JUhuZbL5noPKEQYrE8nvrYih7GrzMAnbXt4ls8613BU16dxxr/27Q4k/NLxwPy3up8
         zcqOxfaz7UXNEpPqWZO4EhD0IghhwaExVYERhgTo9h4qm1ghLE0as8xoHMBl91fp5nue
         0AhXBbKoaTGk1JA6SkFb5Pmfrk0MkyeWPTkpnRw/LLFpOTM74xxCBr228v6+ja9oGARj
         aPAS09JSPAT1DAWObtFqQzu6NYoDDzpDtSPGz2OEy87bzr482xKEv790eu9lCkInLqN6
         ntFPpaMy6eR4RI4ZeyjgvLwzo/8w5ZrFGPSXcwkt6pO6lLCqyzVfzdfhEnCK3j5Kf+sd
         W+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763038102; x=1763642902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KdbGIqeaFLzm3aG4RneLOSJzVNfE/rTf15PS18ARmI=;
        b=g2IWhhykePmPRZB3rzpBPw+31Jl6iMtcTZe8pbUQ0tTbgZRXRfRr5ep87vg6wBxhNb
         16vyFOhwAdvHtxI9Ip0Q/TMDPN0VXSH8tP/YL1hAfsiNvBl4dvQFD3RxzKo1NfkI4avp
         2ov7nDDSun1BzXYiSwoWCuox0cZd378DbGJ8A92N0B8+zlPD46ms9BgbkH4OoLJTEtsS
         gNXPHqG1t9kgTcy3NjnpH8Jb0AbYYU6S5LZpPIkz+BFhgVVsqoCrBvIj6ANit9pqbCJF
         dyXtyoPAHhhJNVmCB2zdd4VZMouFjuNT+Q6YA/v/Po1dDzX4tL91P4JlfqLvH+OGCVJj
         UjiA==
X-Forwarded-Encrypted: i=1; AJvYcCWh64gUwsetUZtItai+QG1KrUYkIuRUBNG+47YoipDa/7v79ZD0hnmoiPv4BYXhmWG8s4xsaRgWtVolHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2mkiH36Ch/7HeYm00chVdKYsvyL9bhGOb4vOaraOJ8NAJajW6
	vQUwUdlfBTyCcCosAh+by+THmUx0J4cBytUJGv8JOggFlXF6pN1LM0pSbk6k3RmoVjsC8ZfUdxW
	MsbQoyD8R4o0nSi0M9Eh8DvHoRwYuun8Sht3IsCpOSg==
X-Gm-Gg: ASbGncuzxejT+Ap9zOUgRN1JXCMlmZsYqiyF8ThE1LA+k5Bp9ppkfVYaq8gPbrtvBhj
	aPE6mzX5qLSzgrrL/W43I0dc26Cr+g/2U9zvLiRmVc1+1ZxhKDDoos/MUt0ymTHs+jdFjzX2NXW
	SUGhclvzBLPBQkrMl6mWsUCaYVUEnRG9/Mx14VNozla3LU/QUQCFfHCzFi7f5V1U+9cac9UrFZf
	TglsIAx6E9BLrffUY//3YuEmVNNsY7Bv7M6/XhBcZlhk2dmADLYfjS0GqylHROI9OUYjpeFWsUd
	4Bd7R4MI0A++SFUbvIl/yxr1B5tVCnhPrGVIhDy4g5Uj+xUS/ygRYwmF4EHyCT1JY1dV
X-Google-Smtp-Source: AGHT+IHKmx9M6WBv+Hyb+0Z08254rZnAw2KSTYKn4pRIYlIFATqmMcfv5MK4qXd/zptuAkq3icKcnKyA1oTq2TZ3w8Y=
X-Received: by 2002:a05:6000:230d:b0:42b:3afa:5e1d with SMTP id
 ffacd0b85a97d-42b4bb94f93mr6600961f8f.20.1763038101809; Thu, 13 Nov 2025
 04:48:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762972845.git.foxido@foxido.dev> <5bfb05436ed8f80bc060a745805d54309cdba59c.1762972845.git.foxido@foxido.dev>
 <0a31cf84-ccfe-4da4-b922-85da570c6e3b@gmx.com> <20251113085403.GI13846@twin.jikos.cz>
In-Reply-To: <20251113085403.GI13846@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 13 Nov 2025 13:48:10 +0100
X-Gm-Features: AWmQ_blM8P4UEnEduwT6zsPb4XIz6qGyFcaQirwGNuBT5XDZ9lpihdZeuC9h5AQ
Message-ID: <CAPjX3FcAE--WHP78jvpXy-aBUEmX9e3FK=F68v-f8sPJbi+CTw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/8] btrfs: simplify return path via cleanup.h
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Gladyshev Ilya <foxido@foxido.dev>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Nov 2025 at 09:59, David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Nov 13, 2025 at 07:20:01AM +1030, Qu Wenruo wrote:
> > > --- a/fs/btrfs/extent-tree.c
> > > +++ b/fs/btrfs/extent-tree.c
> > > @@ -1878,16 +1878,14 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
> > >      * and then re-check to make sure nobody got added.
> > >      */
> > >     spin_unlock(&head->lock);
> > > -   spin_lock(&delayed_refs->lock);
> > > -   spin_lock(&head->lock);
> > > -   if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root) || head->extent_op) {
> > > -           spin_unlock(&head->lock);
> > > -           spin_unlock(&delayed_refs->lock);
> > > -           return 1;
> > > +   {
> >
> > There are some internal discussion about such anonymous code block usage.
> >
> > Although I support such usage, especially when it can reduce the
> > lifespan of local variables, it's not a commonly accepted pattern yet.
>
> And the discussion is going great, I think we wont't find a consensus
> without somebody either missing a coding pattern (you) or suffering to
> look at such code each time (me). Others have similar mixed feelings
> about the guards use.

And yet I can imagine even wilder creativity like:

> +     scoped_guard(spinlock, &delayed_refs->lock)
> +     scoped_guard(spinlock, &head->lock) {
> +             if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root) || head->extent_op)
> +                     return 1;
> +             btrfs_delete_ref_head(fs_info, delayed_refs, head);
>       }

Here the indentation is irregular, but still looks kind of just. Would
we be happy with such exceptions?

Otherwise this could end up rather mixed and that does not look
preferable, at least to me:

> +     scoped_guard(spinlock, &delayed_refs->lock) {
> +             guard(spinlock)(&head->lock)
> +             if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root) || head->extent_op)
> +                     return 1;
> +             btrfs_delete_ref_head(fs_info, delayed_refs, head);
>       }

