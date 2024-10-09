Return-Path: <linux-btrfs+bounces-8734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3429970F3
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 18:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E318286C67
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1BB1E7C11;
	Wed,  9 Oct 2024 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CwY9DfNA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EC1374CC
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489438; cv=none; b=OiJ2YeosXQnyYcZrV3/KuDSu9NSZGsu9mwRWyebM8R+jUb51J1U7L4EP1Xjxi6KkMKfsj4DyqE9RvFoczIq4DszCtBD90OP8dq5qCFTV8KciKXI6Ogm2aaQVU9JZV4KjwGlv42+GBgRv9Oezd+VEF/lWuNH+gt7Cqsw19oF3DZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489438; c=relaxed/simple;
	bh=hXjO4Ng4nPV741mslJ80xb5yHWbLk8sBB60pHqc/scw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EzoiCqGDe3nlOuQ5/sNOAIjbTQcFBRLv3ZqUoolY0R5hUogkZdkFjZGgwtO+WlfP+NV4LM8KjIv7iG22lGXTXO+d8IRD4P0XMg0nWZQuRElA2pdRqt/waJDEBK7828V4TXIlK8YYIPctNyezg9ayhaADhJejSPsB+WWWpGGXmhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CwY9DfNA; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fabfc06c26so61839721fa.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728489435; x=1729094235; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hXjO4Ng4nPV741mslJ80xb5yHWbLk8sBB60pHqc/scw=;
        b=CwY9DfNAmxKwaAbH0lEBvx4dzeaeEKv0+7HStEn76+47fe+CDwrOMYIq1CfldwE/kC
         GuiBUUsSbY7eWQpVsxrCUS/JwxiFKW98cOXtbXpM4mnMthA0HsTQToeDZyMNbsacoSki
         x9PeI24QgGsISTw9f0Q8PSYQT/f+wlFRfn/vz7nMZkxYDXhvhPi4OVcvSxbAAa6z/dcu
         H+bZ2M1SmQwhfxNlhVAu/kIa6HOoLxJIQVLtcr1pUmck761qHtsxIgKv6E96VJ8G7a8e
         Ag2kKgSJFqGdemVYS/q2+N8kbVVo2+YCl9srkxKlIJCXmYuMaE4/+lZC+75hUYxU6A/d
         +pnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489435; x=1729094235;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXjO4Ng4nPV741mslJ80xb5yHWbLk8sBB60pHqc/scw=;
        b=dDTV+xaKgIt607IZRUHGXtKmn2BouBkbqg3VFNAkbQI1tQ9MPzPW7DqmjBojG+ksUS
         tPhv1+fcFX6otHLHEwk/gQ6p5AxJjNa6TS+PfRNPO2U74ye3Tyf4kTv8SJzz9xgLAhLo
         MXkQbFL0T3DWF4fSbHHRxptkY2YK2/1bJgGPQqrk7Io8o2iqmtPD7fWcteITWnUNk9A9
         89lNlI8Qelj0gnemVM6f5Tzllx7gYBAUCkIYy1oOipxsHA2iJC4NSS3RpxFvItpxyqrU
         KDjcXqSaB1HjD+B9eEl/bXU+kNrY40/xKPDq+hbqAJj3pno4o4249kRB29tq6a2WdCH2
         ZMdg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Kff2e3+wNPU952F+uK03XHET/iMXZIroitMiIiX6tPWP5CZ4CBWm/VdA342a/VvQYIcTjDrVnAtpBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPz/B+yTEhoMtJovrrOwl+xVD1RbIFe654stsowoic5xvKw5B/
	6cnjgHEZvkSf5IcHj6kkbDZznLFA2KO8QkRiS3On2WxBFK7btCaHUY+ELmxA2nDyHV3t3uXnwN3
	E/l8=
X-Google-Smtp-Source: AGHT+IGXjJcYeckvcavAH4ijm92H0J3akZe0hJ/el/RKL3nkizP1yzl1+xCbwWJebbIfPgJaSZ25vA==
X-Received: by 2002:a2e:a585:0:b0:2f1:a30c:cd15 with SMTP id 38308e7fff4ca-2fb187f44famr18885711fa.36.1728489434626;
        Wed, 09 Oct 2024 08:57:14 -0700 (PDT)
Received: from [10.202.80.134] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1396d995sm72515175ad.230.2024.10.09.08.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:57:12 -0700 (PDT)
Message-ID: <8d56f1b4eedbeb8891f83f916c216858b779db00.camel@suse.com>
Subject: Re: [PATCH] generic/746: install two necessary files
From: An Long <lan@suse.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Date: Wed, 09 Oct 2024 23:57:17 +0800
In-Reply-To: <20241009144644.GK21840@frogsfrogsfrogs>
References: <9d7ef6a9de1cdd2bbb6d91a407905254c4784c68.camel@suse.com>
	 <20241009144644.GK21840@frogsfrogsfrogs>
Autocrypt: addr=lan@suse.com; prefer-encrypt=mutual; keydata=mQENBFvqfKcBCADKdcrLxNKpkBPfxZwVu1Q3ADpyWdnXZfyQOIO+1Z/WSDeXgr70HUhk/zu81WoO5WyXMK3N1dcS4KrOdNOmDp0H4G5hR+BIkgbIJpo4ekYWVdrAMT8oJgX5EgSIeuDdn2ZJ7K0EDLX9M7969gaw2nHWgBzj/ALGFdCE8zYkZAfPrwN80M5Xl+NBvOrTMypW78WOg5NdGd3E4jjgbKreHFdc9/Bmp2XKQKhjClelfM5aThhsM9wljzWdX1frN2AoAomHKuxKJGvZf30eHoXAs/ikHM4cvoUcY/8H8VgJO3mQMYEFWJR6qSbnfdy3T9Ns/Xy5QGj/XmATwhDg3BMBwvEZABEBAAG0FkFuIExvbmcgPGxhbkBzdXNlLmNvbT6JAU4EEwEIADgWIQSGtWkd+xUNZVZsuhNmwA3KtD5SBgUCW+p8pwIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRBmwA3KtD5SBuAwCACDifSf/raZ05H/0l2xAjZo9JFrWib391QLNbDYFi+Nm7nJ3ATse33ibLheOP0hJ07bsZo7uKNio8DIHDZ5CsTMd21ZvvJlNGT+l9BQV/OLRExCTcK9CpLcHoEI3M1niqL42QjVZPkKcjSwbTCa8mySNmIl64K0YTq1HnuWxShTHNlLBBkId9OMEnztgp9Ke4g+SxcU2+058v8ZTnM5wUp6fMsQelsfigJJfRqHbpy6Fap3XIY+1gKuNVIdyKWXovxtwd++fADyZVh/Zh5IKgp/1HyWE9g0MG6TUzJ+LV57jOrIJJbzl39HUp+5mFBI+RSHiJjoBZAQ7diUzT7+ns+0uQENBFvqfKcBCADCPC4telre7E8pAZITzcVsl1BP3PoMAaow4gh1SOO44J34GHJS7CRqpt4YfbPBEVmFZQiJEhb0GL2KH
 qg7J8hO7J9fmpEiCe1Vv+cK8DSxygXXL0fltVkQlgOjFlzYks+tv g58qti7uykoyavLPSu7yuGvDtzIxB3lXwUnvmS0X8MTBFIdK0s4vJOu/2cDIAnYCNdypZ8H44XtYZVDdB9r4E253y35Nd1QDjJFu/8BQxQXK5sReIYl5fRtz+4TzZQPxWt3/j62RmjY5elPEBTd2q4K6reqRuIwDBXjTWjEKylx9yw47nMH7TzIrXpSWLG08+F8Cb9KhUJysBN4tJY1ABEBAAGJATYEGAEIACAWIQSGtWkd+xUNZVZsuhNmwA3KtD5SBgUCW+p8pwIbDAAKCRBmwA3KtD5SBlJuCACzhZDj5+zuuqYMl07AiV5BqOkGmjghybACLtHjMZDbFOmxnvt7GOfTdf7ug1YguQQI6xIssqzGvXTJVgIfTP38dOSAssrYp78VyFtcAZMiN25GxOOqYlpwhKH1PAr04Ylizz/EZlbfCQ8XCFuTziZ7HwEyjTkvs5XUYJObEhj2Sv9ebhwm3vTZv0VTb8+BpxyQuuGYYakbH94D5Ne5gAC6FaCevXdeqjSCTzV6NZ5seldc3FogQ+TB+riX4G4SA4Nq36Xt4hpAoDoZhh25KsH/9Kq65+eyYKsCnpY+N3f4SAEf5NEODmGF9eKC0K8XcjhXGcpDmnae2tUnjWnjLBXO
Organization: SUSE QE LSG, QE 2, Beijing
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 07:46 -0700, Darrick J. Wong wrote:
> On Wed, Oct 09, 2024 at 04:45:37PM +0800, An Long wrote:
> > parse-dev-tree.awk and parse-extent-tree.awk are used by
> > generic/746.
> > We need to make sure them are installed, otherwise generic/746 will
> > have problems if fstests is installed via "make install".
> > ---
> > =C2=A0src/Makefile | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/src/Makefile b/src/Makefile
> > index 3097c29e..a0396332 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -38,7 +38,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize
> > preallo_rw_pattern_reader \
> >=20
> > =C2=A0EXTRA_EXECS =3D dmerror fill2attr fill2fs fill2fs_check scaleread=
.sh
> > \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 soak_duration.awk
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 soak_duration.awk parse-dev-tree.awk parse-extent-
> > tree.awk
>=20
> ^^ I think this is a broken line wrapping here, but otherwise the
> change
> seems sensible.
>=20
> With that fixed,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Thanks your comments! I've sent a v2 patch without wrapping.
>=20
> --D
>=20
> >=20
> > =C2=A0SUBDIRS =3D log-writes perf
> >=20
> > --=20
> > 2.43.0
> >=20
> >=20


