Return-Path: <linux-btrfs+bounces-1944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2878434D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 05:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FFF1C256E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 04:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599B31B7E9;
	Wed, 31 Jan 2024 04:30:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA517C8B
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 04:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706675418; cv=none; b=XJy+XjJ069VTOeKdWFhKO2bcPF9dKZneD1uba9TSdn+lCu1k6bsGM61QjCi+vYvaFJVs3atExxTkEMlUngf8V73z3D02czWeJfvQ3gX1wzXwAcdhDNn9hoMLZGBkbUtEM4RdKXFr93px0STC0mMUc2f/qzEzGAqbWYUgoQdGq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706675418; c=relaxed/simple;
	bh=8HMP/KjFBx/VlXqYZPbok4cIhCr6SSfIhr+OC3U+PT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eniqb1sshjw+1qV+1qHEEwXkvlwqCi6F+OIzt2P1lyg4pwrMqnv+iR+GQsc4H3olC8TvnK1CqjMK4h/S8vuSNRIzJ16OdB0o8K7TAcz8VOMzPMtRXgbg0KpI/u0k1okngX82oJFoa/mXvNGbBClFrZ00EB4UxBfK8bm4ScB93og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-511206d1c89so1363876e87.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jan 2024 20:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706675414; x=1707280214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JA5wBAqOYI5aMC8WWd4j+Vir7nbk5D37PgKH91X5Gc=;
        b=LV5iOI3+uC6OdpLd9xJlCYmjC6SrqvmEaxG0c3d1nzledcRBbuVeQNOIeTPL9rXIQP
         eDavsa1KHUdWbpHOaWVjDNYrRDOKDz0eDUhHsZIMrRKOOGGh0gg6TdqwwsNVD5H/EN3/
         lVEm5T06tYGiFQstf1rQwTM0QgNKNfafvvRq46ZddP+LEVO5hinkDwilTB6SMCYfj4hG
         V2VvlBeTqc021xy1QTxUqEBSn1oCTH/iArqyetqxrnL7VByuB4zut+5/3DVIRejCVy2Q
         F5b8sLzUQ+bXY+/Vk2i3MD/iCeOzc1XSEUIRBu6L8bzwY06jzBfZeWMzyiVH8UYAapOr
         WzBw==
X-Gm-Message-State: AOJu0YwiNhSWshX1C8usHriPnZqa/Il0VltSdVRcmKGSOCuuRz+YI9Fi
	IdwOsYYxVjFJvJsSW4GJYrp+h/gt5z/aChJComEkroj5j9ziC6QPi9SbpKyo0Tdbog==
X-Google-Smtp-Source: AGHT+IErW7hbjEdvWndi25yHuNddgFYXGXpTaDkF+QXpzipKY779uTC4fanTGH9oc7GAIzKo7gvZCA==
X-Received: by 2002:ac2:5159:0:b0:510:15aa:ef16 with SMTP id q25-20020ac25159000000b0051015aaef16mr353948lfd.58.1706675414172;
        Tue, 30 Jan 2024 20:30:14 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id og16-20020a1709071dd000b00a28aba1f56fsm5732004ejc.210.2024.01.30.20.30.14
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 20:30:14 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55790581457so5720316a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jan 2024 20:30:14 -0800 (PST)
X-Received: by 2002:a05:6402:64f:b0:55e:d46b:7d82 with SMTP id
 u15-20020a056402064f00b0055ed46b7d82mr233973edx.28.1706675413903; Tue, 30 Jan
 2024 20:30:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706037337.git.rgoldwyn@suse.com> <20240129080442.GV31555@twin.jikos.cz>
In-Reply-To: <20240129080442.GV31555@twin.jikos.cz>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 31 Jan 2024 04:29:36 +0000
X-Gmail-Original-Message-ID: <CAEg-Je8L1B0JHmmcir5GpThPqACpLXm13sT6v2yS4pV_4Ty+0g@mail.gmail.com>
Message-ID: <CAEg-Je8L1B0JHmmcir5GpThPqACpLXm13sT6v2yS4pV_4Ty+0g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] page to folio conversion
To: David Sterba <dsterba@suse.cz>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org, 
	Goldwyn Rodrigues <rgoldwyn@suse.com>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 8:05=E2=80=AFAM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Tue, Jan 23, 2024 at 01:28:04PM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >
> > These patches transform some page usage to folio. All references and da=
ta
> > of page/folio is within the scope of the function changed.
> >
> > Changes since v1:
> > Review comments -
> >   * Added WARN_ON(folio_order(folio)) to ensure future development know=
s
> >     this code assumes folio_size(folio) =3D=3D PAGE_SIZE
> >   * namespace restoration: prefix variable names with folio_
> >   * Line adjustments
> >
> > Goldwyn Rodrigues (3):
> >   btrfs: page to folio conversion: prealloc_file_extent_cluster()
> >   btrfs: convert relocate_one_page() to relocate_one_folio()
> >   btrfs: page to folio conversion in put_file_data()
>
> The conversion looks straightforward like we've been doing elsewhere,
> however the CI is still not in a shape to validate arm + subpage, I've
> seen the hosts not pass with various sets of patches (removed potential
> breakage and keeping potential fixes).
>
> There are more folio conversions coming so I'd like to get them all in
> so we can switch to the big folios eventually but without the CI
> verification of subpage it's a bit risky.
>

Wait, we don't? I thought Josef had specifically added Fedora Asahi
runners specifically for subpage testing[1]?

[1]: https://josefbacik.github.io/kernel/2023/07/18/btrfs-github-ci.html



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

