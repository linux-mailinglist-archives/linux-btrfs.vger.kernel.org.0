Return-Path: <linux-btrfs+bounces-19135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3EBC6DD2A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 10:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3448E3499FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1160D342CB3;
	Wed, 19 Nov 2025 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VFt9EcQX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA2306B3F
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545749; cv=none; b=UGVr3D2l7pyI/ckMhsyX694/gIb6x764aS6dq9hGp2APvp+PDrw7ysL82KQ+iECqZGY4UtrHUvQimL35tD/oIOuR0LS0HxDx5D/kjXhVk6rmvk3/LvKE1XUyTZlVvCQZoQuJzIaAAhhsu3WJtu4qrPMhCgwR0HUVy3HfarS/abc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545749; c=relaxed/simple;
	bh=JMiWcAH5LqXeQgYuMFCdjV5fMaE2K90n734ciD7CSgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qh4N5zpSfT2xWGQy6WKMvMuR9LV8+9b7LyCQcebZt0Je+DvnixBtdJ4FjyBfPW2hQH6QwldAdIjtYaNqWCj7EEEOppvAzXcrOwVcL7nhhK6c6iNzNYuy4dP3+u7GdppXxfAEmXkVs8a2uwRmx5TasagO+0D5kLbxjbvlV9WMMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VFt9EcQX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b566859ecso5051912f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 01:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763545744; x=1764150544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aZZBLqSfRk/wJ8tBleGW4P6yx6hVZmbjqnv9gZokgi4=;
        b=VFt9EcQX+3BKrYr68QOjU5hFgBBGP0n7RfA77LhHwXQgRiPX0ZjnZFNWGUk5ieXFjM
         cIj8Y8wCaNzvuyqKyDIweTeryxepSdMbBmOQ9VW/IVgwpV9r+ljU18nvxDAS5qmqQuKU
         KoXR7zR8yLmWEZpZqYkDkYcw1JwpNhyh+zqPjBH+2Q0UIbmOgbQzgk38p+DgCknXoqXJ
         ZcGL/3CBRXygQYxlA+KFhYImfYXWn6dqyu0w0BfgdhJuheD+pYkSbs+e5yX2Pgl58UV5
         ys3I7wMgzXVF5sp7CFsXbbHpBDt3v+0ZsqT6aFCvQJD0lc9TjCkQqzgoQbdYhq+0OyRK
         GV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763545744; x=1764150544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZZBLqSfRk/wJ8tBleGW4P6yx6hVZmbjqnv9gZokgi4=;
        b=Hrcf94/7tOTLX9bjPxZD+YqDrXEIIkTFyPnxPNTRE1gU2PsYUBbjgDObxaR6FpoE3Z
         jh/ebIzzI0xN7hUA7ccY/534R2TQX+8EAvOARN+F4FLo+JVcE4Y3xtCQ6EtnQD5SEj7T
         rKe9Q/9f3jmIqSltPV2YYU7S7Z8kwcKCUUsx0SD+kEABQHxyETm9TFHTp0cVK3UX3yW9
         XctOhvH/I0DFBVg81Q71S5avviY42zaPIB73ZuJFfKhKLlRdur/OlaSG7kS/UcUgLKT/
         Df5z0+5LnK496cEcp/fshyJNvBcUnOeEpc4ASkZpl4ND9Xvc9pV+weORDDYyiVhHIVJG
         jjVw==
X-Forwarded-Encrypted: i=1; AJvYcCUZxdjkg3diGBS5Ad1HMYqTlA6RgJ997VwN+kW4yRB4Z+iUG27xt4mjJHphAbcyLab7OvEN+5z9su16Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV3KOjkIpGU/uXulfFBswMGeW4Xr3LUG87NEElrEb/oPoSkK04
	6GTEV0UZhPaFM0y0DvQyewe4RUPlCJBOFyAl+glVEwCliqun4/dxO4LG6jEOurFRIlyxiPyUI4G
	TzDfo7TVuQkdjJ9fu65bnXwj7lk1PH31Lz0eR3nVEVw==
X-Gm-Gg: ASbGncuzCdB+orOFt6QkwDPa6YvabDSf7vd+jOD11f5kT/Stp5DCxd2Q4ssl+cETWX3
	b+9QCzJy0vht8NIaDFO3Rc21zj/gMHOUYsObZtwzHwbywIhGTImS8rULs6Ub/gNxrookqSUp6Vt
	3khmgcJo2TAGuCEIMRbzNTCtPHoD2SAH+K4bCEREQ/ILL6WnHsDAn8gIYltUHJiJgQISZe2km5K
	2M2fN0YjEegTXUxep60yj2OmVFA2IzbYDtEMzguPeQv/NxeSvvOEx103dSC7zyvZPHm4dQcVTXE
	BVAfvMwNRlyeZvTKnULx14Xl3Q3DVAUH9Rc9/75xLsyEKJ+S2Gh+cdIL8bRdBYcGLwUR
X-Google-Smtp-Source: AGHT+IFJsryu0g/7XUTXngTlZsUwqStV1WRxsqaWlxf8mSumLT/1wp/ObrVW+3wx6a0PDLV3UGFJThc4ogsjkpXBStA=
X-Received: by 2002:a5d:64e3:0:b0:42b:3c25:ccea with SMTP id
 ffacd0b85a97d-42b59394964mr19231140f8f.42.1763545744432; Wed, 19 Nov 2025
 01:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112193611.2536093-1-neelx@suse.com> <20251112193611.2536093-4-neelx@suse.com>
 <7de34b24-f189-402a-98f9-83e595b53244@suse.com> <CAPjX3FfMaOWtCZ8mjVTbBQ9yt0O-mAistyDsVq7Q1aR-65R_hA@mail.gmail.com>
 <492ac26f-5eb4-49bf-855a-11f021d9e937@suse.com> <CAPjX3Fec=qAtWjPNvszKdww=giCUEgoMULc1Zvd37k03VUaUmw@mail.gmail.com>
 <84128576-17f4-460a-9d2f-9e40f43f2ef7@gmx.com> <CAPjX3FedNEUeGr3sROdHaT0iKhHDfsi4V=GQHcmvhx6wEJqUcg@mail.gmail.com>
 <aR1-TxfczR-Q6ao9@infradead.org> <CAPjX3FeGgDbX_JSWN8tf3Aicx2ZSYt5Rwwa+p+WRGN7cQk13sQ@mail.gmail.com>
 <aR2OmdwuISWNRkN2@infradead.org>
In-Reply-To: <aR2OmdwuISWNRkN2@infradead.org>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 19 Nov 2025 10:48:53 +0100
X-Gm-Features: AWmQ_bmlHudT51I1xUPDDRU2ik4lDZs3f7GFOWthmJsobgZbpOL7Ih3u6iOcE7g
Message-ID: <CAPjX3FdudZ3CXZX+KkxwsZHQLt6jEW0V-xVJmKciFp-AarjNLg@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] btrfs: add a bio argument to btrfs_csum_one_bio
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Nov 2025 at 10:32, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Nov 19, 2025 at 10:28:55AM +0100, Daniel Vacek wrote:
> > On Wed, 19 Nov 2025 at 09:22, Christoph Hellwig <hch@infradead.org> wrote:
> > > On Wed, Nov 19, 2025 at 08:34:13AM +0100, Daniel Vacek wrote:
> > > > That's the case. The bounce bio is created when you submit the
> > > > original one. The data is encrypted by fscrypt, then the csum hook is
> > > > called and the new bio submitted instead of the original one. Later
> > > > the endio frees the new one and calls endio on the original bio. This
> > > > means we don't have control over the bounce bio and cannot use it
> > > > asynchronously at the moment. The csum needs to be finished directly
> > > > in the hook.
> > >
> > > And as I told you that can be changed.  Please get your entire series
> > > out of review to allow people to try to review what you're trying to
> > > do.
> >
> > It's coming. Stay tuned! I'm just finishing a bit of re-design to
> > btrfs crypt context metadata storing which was suggested in code
> > review of matching changes in btrfs-progs. The fscrypt part is mostly
> > without any changes to the old v5 series from Josef.
>
> The point is that anything directly related should be presented
> together.  Patches 1-3 don't make sense without the rest.  And
> especially for patch 3 I'm really doubtful it is a good idea to
> start with, but that can only be argued when the reset is shown.

Oh, sorry I didn't say that out loud. Maybe you missed it, I already
dropped this patch (and another one) from v7 yesterday.

The patch itself is still the same as it was in v4 or v5 where you did
not object. I'd say let's discuss it again when I'll send out the rest
of the series so that we have the full picture. Maybe the refactoring
you mentioned could provide us with a better way for checksumming.

About patches 1 and 2, it's really up to Dave. He picked them and
asked me to send them ahead. I'm perfectly fine either way.

--nX

