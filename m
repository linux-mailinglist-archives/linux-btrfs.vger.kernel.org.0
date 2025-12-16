Return-Path: <linux-btrfs+bounces-19786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B816CC22BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 12:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FAC830836D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 11:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A4E33D6CC;
	Tue, 16 Dec 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/SUlIF3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdQ/gxxi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387533D6DC
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884023; cv=none; b=Lx9x6sX+awzXH5O/T6HvSL9mpYBIeAxFnebk2pcKOgT5iziG3GuLAxJit3PTW7H+VyjqnNX7d2Qz3J/fuMLz06DSJ1qE5E19EsWfAvn3XvAv0iHu2G7KE0+stTwOtpgxL++cu0QMErMm8eIk2VG7sqnJoStl0NvSW0LUiI6n8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884023; c=relaxed/simple;
	bh=Ir34V/AA4/Kn53Xt2wU7m430i1aPoGLugyeX+Sg5NA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVIsSMeHKAc4HPjl9SFXsHo4QImpDbkS+8R7WaCVRyjFayIeMIrZX9pW3ZrYAAWn/SrQLp0KPkyGSEzp5ChGfg6Rr4y5CjF/TO8LuYMi5bhb9RGu7bMrvsvVfqXeJJECzZ2JmWnGwSxJiT8ewPGDeo8Cj/pfSZ1QI6MYhZw1tfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/SUlIF3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdQ/gxxi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765884020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWRZ0JhI9nv9UkoCkjiIAGd+WxbLXiOF8HjIaXhWnLA=;
	b=Y/SUlIF3xZtgfWnV+nd8PsBUXGzc1qvXwum9v4WxfmIlMV6UZyruB3Jcsx7u5ywHzRQfdl
	QL7sSlkJyF8GXpTYdTUhNLESg48fX5j9qmbUOAOd7UOHEn4waj4tWICfTonDme9RlYjPQN
	wEucxWW393E3DnzU4KBzthBrIJ1SPms=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-lxz8mzURNlu5aRKJ5_E0NQ-1; Tue, 16 Dec 2025 06:20:19 -0500
X-MC-Unique: lxz8mzURNlu5aRKJ5_E0NQ-1
X-Mimecast-MFC-AGG-ID: lxz8mzURNlu5aRKJ5_E0NQ_1765884018
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-644721f9e80so6390089d50.1
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 03:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765884018; x=1766488818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWRZ0JhI9nv9UkoCkjiIAGd+WxbLXiOF8HjIaXhWnLA=;
        b=DdQ/gxxiM4Q4+mxpMmDf0BNn0HUobvKwTPeLKuTLP3nIL2dVN9LPiwN9cttrOvM98R
         8FuQ/TEdOXvM866VsORzsMktkaFzRgijcmY+6fgUZscV8t/+E7+2D3j9s4K8JXdUI8tB
         rWc3opUwh659zS+Tmzld3uOYxsSFnoEvFXdurSYoJIhGNM66WRphPfHeee1Vm5xyGi+J
         lUt3gsO34maU2lsY+khRBqyljf82AsQMgLa4MjGQD9pUoQSlCyAtqTDHRqS6YM3ry++v
         ELq0i8kb7e69vPyMnWCzwjZa+SqIVuCrR+LV2KOuwIaP2n+dT3RGdv2SzXcQklQMNBTh
         msMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765884018; x=1766488818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWRZ0JhI9nv9UkoCkjiIAGd+WxbLXiOF8HjIaXhWnLA=;
        b=HzvvXDOSavddYqcHDqW4joBSk/hHlzFaISbi9+ITlfInQBFn88bAezf3MOmXIQgsqd
         MHXHJPUiXBUwPenK69v8ssF5qH40vN9xmuENV6kQxlcuAkSq3hw60tvN+2HnzqtGP6Tj
         ACNBYIjI5BnJipeeTQdEQ+9HreMs+2Ot7KlDsyuOAHouoRK5cP8fWoZkEq0tP780g9lD
         5uXfSHIZNVuH2zckBWZ15z7MTal1wplvQSQno3GXo0ZdZx3iUmcy1Lfv54dpsH8jPys+
         IIzQ/yNQxizRXpLcDvTgaWoERNMrVR/2VCNHmcuZKRX6DjtimFlX7julLU9u9jfYc8Ax
         92uw==
X-Forwarded-Encrypted: i=1; AJvYcCX0LPKWWwfiGtcjJmzkmLfWeADma9gricPORKmDiu50O0wWHkr74tV4nZhTrqxrG7VnrDyjTGXpCkc+AA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAmo5ORicUXWqjJ9hhbl8G5L5SZeW7BGoEg6EQQTaW8L3KbKwC
	hUGClcwKOA6QeQJrvE6/IUot4Msf8TTAOe8CCisiNafLDr/lD+7YEA17uFzO7OpBEAQFOtwmfsM
	uACHqBX/i2wN8u+mdp0fROIIzPriPqOv3EKTHm294L9SE7th0N96lfzQdZDXtCFZvudVzjub3LQ
	qc3+gxyLEmeZNLApMNWJVSOjDCM0kBHa6Ofb+b6gY=
X-Gm-Gg: AY/fxX5Cb2MdLCJ5AsVn3MgInBBOsm5PY/ESnM0WJskAxiS7P+27Bl2PaV2vn1Bd81V
	yJfmvkYqkLx1ax//+Gb6iszaWBbRoACWEoXbekNGWzYE1+m8cxjInIyNJGM4ah/uav7+WkfORlG
	sjF74q08Q5xhCM47VgZhlFzBs4iDBuNTjMJ+XqZaNU5v5l8djbFNQ6KRxjyD+VtvDw
X-Received: by 2002:a05:690e:118a:b0:641:f5bc:695c with SMTP id 956f58d0204a3-64555661ec4mr12407309d50.72.1765884018380;
        Tue, 16 Dec 2025 03:20:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE1hRYagai5ZNpwc4wQBEIkmKE4t8Gn5ugUaYPF0w5F6afO5UP4qTUeJlKU6zAyLz8ccdYL4yR/SJoQvAZlXU=
X-Received: by 2002:a05:690e:118a:b0:641:f5bc:695c with SMTP id
 956f58d0204a3-64555661ec4mr12407292d50.72.1765884018076; Tue, 16 Dec 2025
 03:20:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208121020.1780402-1-agruenba@redhat.com> <20251208121020.1780402-7-agruenba@redhat.com>
 <aUERRp7S1A5YXCm4@infradead.org> <CAHc6FU6QCfqTM9zCREdp3o0UzFX99q2QqXgOiNkN8OtnhWYZVQ@mail.gmail.com>
 <aUE3_ubz172iThdl@infradead.org>
In-Reply-To: <aUE3_ubz172iThdl@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 16 Dec 2025 12:20:07 +0100
X-Gm-Features: AQt7F2q5uYepYK7esYO29pN2NRPzWpk3ITk8uPFpAWNLoGj4HZrc4JFHmQEXPKs
Message-ID: <CAHc6FU4OeAYgvXGE+QZrAJPqERLS3v7q64uSoVtxJjG0AdZvCA@mail.gmail.com>
Subject: Re: [RFC 06/12] bio: don't check target->bi_status on error
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 11:44=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> On Tue, Dec 16, 2025 at 09:41:49AM +0100, Andreas Gruenbacher wrote:
> > On Tue, Dec 16, 2025 at 8:59=E2=80=AFAM Christoph Hellwig <hch@infradea=
d.org> wrote:
> > > On Mon, Dec 08, 2025 at 12:10:13PM +0000, Andreas Gruenbacher wrote:
> > > > In a few places, target->bi_status is set to source->bi_status only=
 if
> > > > source->bi_status is not 0 and target->bi_status is (still) 0.  Her=
e,
> > > > checking the value of target->bi_status before setting it is an
> > > > unnecessary micro optimization because we are already on an error p=
ath.
> > >
> > > What is source and target here?  I have a hard time trying to follow
> > > what this is trying to do.
> >
> > Not sure, what would you suggest instead?
>
> I still don't understand what you're saying here at all, or what this is
> trying to fix or optimize.

When we have this construct in the code and we know that status is not 0:

  if (!bio->bi_status)
    bio->bi_status =3D status;

we can just do this instead:

  bio>bi_status =3D status;

Andreas


