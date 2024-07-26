Return-Path: <linux-btrfs+bounces-6708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF0793CC72
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 03:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC7B1C2127C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 01:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E89184F;
	Fri, 26 Jul 2024 01:30:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332FC812
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 01:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721957426; cv=none; b=Sh2SPBP3Y5Fx4y2tIsErAQZpfwOqrt2DGu0RKL97KzoUG6VQXLizYL1FQhW6jA+NJEIa4rzGVrxVWioYWYa00yhFytqqIejdxmXQjATxJz8zpQpTTszeE974nvD0U1r+MRKvCLj2fKFnJIR1Qcmng/sCrPjLxEoNrvHXl3FCJGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721957426; c=relaxed/simple;
	bh=he4Mdps0w//9/4Isl/DzBDnUFRjBqzH2/Rdah5CY0iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGhENAovB2CKQJ186rwtcY9Y9vCiTd7jh6QBtcz5N9JYYkkKoS8ERuvXizdXXG5b8yTHC3TLocA1UkQK5V9DqlDvRyXmHkT9lUDeDs637H0ckQQImdPt6+unysESdFBUHEkoTaT72aUdIQUSLCe85EVmmUbPJSweSrxfkPKtqIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a728f74c23dso151350566b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 18:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721957422; x=1722562222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he4Mdps0w//9/4Isl/DzBDnUFRjBqzH2/Rdah5CY0iA=;
        b=RhN02ndORdgSiqb9Xaq16dtOL/nYZvqbqebGHlrzYmoADD5Ql5rOSTikmIIsIWo+is
         r6BfRXWGCWmg5oI4bMlaTrNqXboMSdqL5oyOdwjdVfUzh29D1XA0mWxaqWzlKLUAv41W
         2N3lNqNsE4jo5pH9oRkADklfAdigFEH2Vl33TgDvryLjWkJ4rSvAp6A/AxI+s5wlKKRE
         ZIGXQO+tasuytY+E7bqBnzHoNnXr0Asx5rR7Vg9trT58iQl2ISBE2/JEXBTu2VS2Y1jW
         GHdmn/tLk4WWp8Jah6WHAVsMR77JvXz+/2JaUw3d4PQeTzgYLEWqoKXTGLi+klgyj1Ev
         IGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+IbagzkqNqa21gZo7055eKchcnrh6SgQJDGLMbf7I5wAxrkfnd7qALKXG66xX9vRvy/rEqmjOrN4WzrGgUYDpQsctdK1Frkmc6ZU=
X-Gm-Message-State: AOJu0Yx+8ofcuI+4VN6mJ+Rf39dspar6EgfUsjZt3p+HzFKm79UWsvK/
	KD7+BvDxCCqZ/gp6agcPR2hJoKrSkbthJmXOt5GqesDXVicuUssIsUs9kmIP
X-Google-Smtp-Source: AGHT+IEuN0CTcW1PLbtZL+kaKlsVXOnCi6lWv3E73nVLIjc8rjQAzPF/5QEF2W9ZmdxfsPA8AsXgCg==
X-Received: by 2002:a17:907:d17:b0:a7a:9e11:e87c with SMTP id a640c23a62f3a-a7ac5129dccmr328495566b.9.1721957421845;
        Thu, 25 Jul 2024 18:30:21 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb98dbsm121677166b.216.2024.07.25.18.30.21
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 18:30:21 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso2132021a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 18:30:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0SOw4KLvWsyWpUydoMyolrft/LhjCzy0jgK0A1onhNjjlZLnDCj9SyR5uoJkc+Q+fYLQ0xsi4rLkUOY+uAsR9pE3+B/HMqiyd3Mc=
X-Received: by 2002:a05:6402:2356:b0:5a1:aa6d:9469 with SMTP id
 4fb4d7f45d1cf-5ac2ca7a600mr2994215a12.38.1721957421490; Thu, 25 Jul 2024
 18:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fbbb792fa299bfdfa818f6e0790fa545297dc1cf.1721949827.git.osandov@fb.com>
 <20240726011224.GE17473@twin.jikos.cz>
In-Reply-To: <20240726011224.GE17473@twin.jikos.cz>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 25 Jul 2024 21:29:44 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_7OeESAbQ0zBD=fuvY_WHE05vk0iR=Vv4Bq5vAc_qCJw@mail.gmail.com>
Message-ID: <CAEg-Je_7OeESAbQ0zBD=fuvY_WHE05vk0iR=Vv4Bq5vAc_qCJw@mail.gmail.com>
Subject: Re: [PATCH] libbtrfsutil: python: fix build on Python 3.13
To: dsterba@suse.cz
Cc: Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 9:12=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Thu, Jul 25, 2024 at 04:28:35PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> >
> > Python 3.13, currently in beta, removed the internal
> > _PyObject_LookupSpecial function. The libbtrfsutil Python bindings use
> > it in the path_converter() function because it was based on internal
> > path_converter() function in CPython [1]. This is causing build failure=
s
> > on Fedora Rawhide [2] and Gentoo [3]. Replace path_converter() with a
> > version that only uses public functions based on the one in drgn [4].
> >
> > 1: https://github.com/python/cpython/blob/d9efa45d7457b0dfea467bb1c2d22=
c69056ffc73/Modules/posixmodule.c#L1253
> > 2: https://bugzilla.redhat.com/show_bug.cgi?id=3D2245650
> > 3: https://github.com/kdave/btrfs-progs/issues/838
> > 4: https://github.com/osandov/drgn/blob/9ad29fd86499eb32847473e928b6540=
872d3d59a/libdrgn/python/util.c#L81
> >
> > Reported-by: Neal Gompa <neal@gompa.dev>
> > Reported-by: Sam James <sam@gentoo.org>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
>
> Thanks, this is more convoluted than I expected. Does this work on other
> python versions, like 3.8 and above? I'd have to check what's the lowest
> expected python version derived from the base line for distro support so
> 3.6 is just a guess.

Well, I can't build it on AlmaLinux 8 with Python 3.6 because
libgcrypt is too old, but it builds and works fine on CentOS Stream 9
(which has Python 3.9).


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

