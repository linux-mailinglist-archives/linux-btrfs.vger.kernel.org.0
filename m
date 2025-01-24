Return-Path: <linux-btrfs+bounces-11057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4920A1B192
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 09:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E967A258B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 08:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51CA218AD7;
	Fri, 24 Jan 2025 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CSGiwF7S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1E218ABA
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737706930; cv=none; b=m03NTevs9TnbLyII8SGcfFMCoeLQxQi5YEId9F3Di2weX1KrkHyFlxHEuT3OusEq/vAxaTkzDeLjNXf867W4/f3drY9I/LtlBxJKgRi1/Yn+uHo8KJEvi9hu0KocYzc2ZLJaOH4DB/G0KsNSr4Tpt/6sD5gEL5LKDLVltB1JlXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737706930; c=relaxed/simple;
	bh=SBuKn5yg4seHRowyQhiXTwedaX+5v0bZvmrACz4o/zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMA1wgKbSKAgHss99V/BFqzZyeinJI0VuBfZQIoat06k0vzWht5Mphh1Foc+Ne0WHLmKRmO1qQCRKarROjbRTJrgzKN518Ji+ZtVcKcFwwMpEmprGrsU0SPeCt95l5ugg51eaQwfSiY9E9C0KB6f1kNJs29oaqcrIIpYqL6tIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CSGiwF7S; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa689a37dd4so376481466b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 00:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737706926; x=1738311726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWTOaBlgT6Ai9RMdru/oKDWgPx9aCIA6pSuyD6NK93E=;
        b=CSGiwF7SLzLEecc4I0DpFjqeX3JGTso1XRfJfH/p05gzF89bdBCKNXhDjRCyZTuv6Y
         eIGQOqfuKttP98V32qCXkjkayjDHBZ6ypKIXZOmMYyjIhqsQr9kSFjZvVfsyKcPcTWt3
         W2D++sOSD6Ip0cSG5hdUpXAjx/5sDhv1MqHGhkFxGewJ18nOyz0vAtz7U8y1/niTjkbY
         FH4deTNq10ib1jzT0weEzC+Tg3timQLfbJIMNQxSc2J1cWmIB9Y0HEKDMdPDJHeaa50s
         jrIzRpmXKujLWgDOem2JyXdHPeWIZbpGL0lg1Uawf8DeIAs0G18qBo0220C4dW0D4ZnP
         KbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737706926; x=1738311726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWTOaBlgT6Ai9RMdru/oKDWgPx9aCIA6pSuyD6NK93E=;
        b=dAHZ/5uWQzMv5z+KVELkM7HPaqQpqThSMJqVRO78056x2z96S2xkhEjdi0DdKigJU4
         IP4HcbGvSQRlstrhZPEgvBvhrzun4zBxDNXQ/iJUz9Qi/zv8QriBx6kJVe9Dggoi6q4+
         8ujNLB2LjIdlNntpGNsuTTwV0HR06q0vA6W7FGtJim4z6RLzk9BD7ZTGK8dTSxctODl7
         qA0+sntXf7gUlTOWay5sB027rYA8wmdkLslwX/rFClVmkeuzcQwvhjxkGUbzes0qNCpZ
         S9/a52DYCfNV6Cc90mkitzRf49QnMfWiYSxflne0cnG8dQJBTrBVizyOR1RHabASkDve
         L1pA==
X-Forwarded-Encrypted: i=1; AJvYcCXtw8a+l9HTdxLra5T6jUuLL4DocxtI7WKs3J59DEh518y4KA0r4vbqkpzDjPnYICKe/CcWZjgi9Xj9vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZulGt5DKXKJilrp/iuGdmaR4N+7OTI18h3G9W42DLqCq3fNcp
	tIK8RctXofPxWbydrY7XGko12ROW7DiJuQUW1ismw0e20WQHPTE62FYtFeSBFsDr63ix1eMNI2J
	NmtFkqDxtEIEt+Alq/abb+7bO+tImvTC8wNWHTQ==
X-Gm-Gg: ASbGnct4oRk1AfYoyyb/Ehwh1ZV45xA7igramKLWI5IzVC5KXnU2AQ43/m57qEp8l4D
	H3+0Lub/GlnLUX2n5K4RQKYBi2jyNr8TaqmaYAPqUI/vQ7OMr4hIqIjpLrpgp
X-Google-Smtp-Source: AGHT+IG5r4TXxU2ncZOVPqOPMhdnepn4x0/2CQUyTFT3zpMGBu3D8DzvpXoEDFnSiaaKyVMH+91mJEvqoYDyGiJYD9E=
X-Received: by 2002:a17:907:7ba8:b0:aa6:7c8e:8087 with SMTP id
 a640c23a62f3a-ab38b1b4669mr2684719866b.12.1737706925936; Fri, 24 Jan 2025
 00:22:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122122459.1148668-1-maharmstone@fb.com> <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
 <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com> <20250123215955.GN5777@twin.jikos.cz>
In-Reply-To: <20250123215955.GN5777@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 24 Jan 2025 09:21:55 +0100
X-Gm-Features: AWEUYZkgoOSf1hlLfl6BN_hreyRwwZGsmZE5LrHVbjorPMAZwPH7p9hvZcfLDE4
Message-ID: <CAPjX3Ffb2sz9aiWoyx73Bp7cFSDu3+d5WM-9PWW9UBRaHp0yzg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
To: dsterba@suse.cz
Cc: Filipe Manana <fdmanana@kernel.org>, Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jan 2025 at 23:00, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Jan 22, 2025 at 02:51:10PM +0100, Daniel Vacek wrote:
> > On Wed, 22 Jan 2025 at 13:40, Filipe Manana <fdmanana@kernel.org> wrote:
> > > > -       if (unlikely(root->free_objectid >= BTRFS_LAST_FREE_OBJECTID)) {
> > > > +       if (unlikely(val >= BTRFS_LAST_FREE_OBJECTID)) {
> > > >                 btrfs_warn(root->fs_info,
> > > >                            "the objectid of root %llu reaches its highest value",
> > > >                            btrfs_root_id(root));
> > > > -               ret = -ENOSPC;
> > > > -               goto out;
> > > > +               return -ENOSPC;
> > > >         }
> > > >
> > > > -       *objectid = root->free_objectid++;
> > > > -       ret = 0;
> > >
> > > So this gives different semantics now.
> > >
> > > Before we increment free_objectid only if it's less than
> > > BTRFS_LAST_FREE_OBJECTID, so once we reach that value we can't assign
> > > more object IDs and must return -ENOSPC.
> > >
> > > But now we always increment and then do the check, so after some calls
> > > to btrfs_get_free_objectid() we wrap around the counter due to
> > > overflow and eventually allow reusing already assigned object IDs.
> > >
> > > I'm afraid the lock is still needed because of that. To make it more
> > > lightweight maybe switch the mutex to a spinlock.
> >
> > How about this?
> >
> > ```
> > retry:  val = atomic64_read(&root->free_objectid);
> >         ....;
> >         if (atomic64_cmpxchg(&root->free_objectid, val, val+1) != val)
> >                 goto retry;
> >         *objectid = val;
> >         return 0;
> > ```
>
> Doesn't this waste some ids when there are many concurrent requests?

Quite the opposite, it's meant to prevent that. That's why I suggested
it as the original patch was wasting them and that's what Filipe
pointed out.

It will only retry precisely when more concurrent requests race here.
And thanks to cmpxchg only one of them wins and increments. The others
retry in another iteration of the loop.

I think this way no lock is needed and the previous behavior is preserved.

