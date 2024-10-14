Return-Path: <linux-btrfs+bounces-8890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E743899BE56
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 05:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF341F22C57
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 03:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925E186252;
	Mon, 14 Oct 2024 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z8d7kvM4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3B34CC4
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 03:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728877901; cv=none; b=EqcAJrBoA0C/DmYBXvShNyCb748dvRJqiFOCqIxqNnm8xPbmA2xVUcqgWTt14ArOOF2nAPICkj9AFYY6twGRQemeuW0wDQpd8xGi2Qw6OSHunw2AJqCSPzwoff4r/BikGtI69f2UZe0GrOBKpCwEIBRDTRIDmZqr+11Wwk4N5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728877901; c=relaxed/simple;
	bh=qU6d0goyumrNEAj1O0GEK8w2N/WAV7PbyXYTB+PjMFQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8UIpP18LuWPMAFCLzwNqG53saSpp0WsXe/E0xCPZB+liEWrGh7ebdktVvJemHXJwp7nh7iozjH/HtMGRAp33ch0eRa/g+KBu4juHha4NwweAw91Zd3aVLpG/wYQ5/Mq216FtyRS6DS9fNPaJI7R0fSx3P7Rwk5De2C6DRmqeoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z8d7kvM4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0f198d38so82040166b.1
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Oct 2024 20:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728877898; x=1729482698; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qU6d0goyumrNEAj1O0GEK8w2N/WAV7PbyXYTB+PjMFQ=;
        b=Z8d7kvM4fP+DYDzyXtIJGbdc8gXKUqwwPT8oTPJ/RyVgpJes9gBXpRm2isCtH2SoWm
         lq7XHj4FqH9Eze8sBUIQSUrWdCuxRWeyVzDnfmASzLFEzL++hWyO7vcWcFPzy7o50qFE
         6fZckiGn0ZT8tOgx4vXzVEMpfWRTs2dZkPHZQURWY2TDQgoJE/jhYvyMXkbZKg+L5M+V
         bBHS8gedaMN21tu3+v8oQ55Wc1g1zXcn4wjAtrgtTQX51ySI1enF1o25ai2A94NFrLup
         ggnqkmA0jLmcfHC2vtm3QwIimVO6ne8V+QamlzttlX0Y2gdWUzbWc9RoPDiLRshainz1
         xmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728877898; x=1729482698;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qU6d0goyumrNEAj1O0GEK8w2N/WAV7PbyXYTB+PjMFQ=;
        b=m3kkt/VbugPf8+9Oqk4Ib6JZCcz/U0CXJa77lFU1OTPgZUUeaqYHP1k2KSkSCaC6nT
         LE746PewxLEtz1ZPJWfhHceMMbdJoLFc9SJQC3uHpm2H56WPnpP5C5iXG8vN38hPPQvT
         AakIeynqG7rmmtyhd6+ji673ynMHB/Qt+slRc7Bc4+1CGsCtKZiCnZt+i6Tt+LT7fM9t
         8RwMfExVmK0jcbybJIR9vD+Jj5Ejoo3Q/d2ETocXDt4jEK0y3hU5OkKzhlzuVIWI2Vkb
         PFiSYfRBZIswfKf6B1R2KXBYyXUbbOw7MNikXWELZw1ALmFDlCl+P+enCqldCClbTIO4
         l8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWzJvEjywCrB4X7v06D7onNGs8CsMTSFIINoRFIA1AOUjUpOscyKBcrvLeX/4DTfUD6xWstzTDa8WdfxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrTCfBaPVfHAkx0yiaTp85aREUdneLYTonwc/ZlkhocejvT05L
	vKBxiMRZn5uChoaZjoQdpza2Z35kQGHDNCbtTUzSuw+2n4WwDyBiwkQREj+8FCY=
X-Google-Smtp-Source: AGHT+IFIVMRLD9QPpzQxScW3nLvm8ALYtadIHFqyfSLvt4210X0ZOhPSiU/CcLEDX8r4x6MKCDXc/A==
X-Received: by 2002:a17:907:a0e:b0:a90:b6e8:6919 with SMTP id a640c23a62f3a-a99e3e435c5mr594926466b.48.1728877897671;
        Sun, 13 Oct 2024 20:51:37 -0700 (PDT)
Received: from [10.202.112.42] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4495aa80sm5998180a12.75.2024.10.13.20.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 20:51:37 -0700 (PDT)
Message-ID: <b7213475a4296e3600b7fd7862bfc0715c1b0c6a.camel@suse.com>
Subject: Re: [PATCH v2] btrfs/315: update filter to match mount cmd
From: An Long <lan@suse.com>
To: Zorro Lang <zlang@redhat.com>, Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Date: Mon, 14 Oct 2024 11:51:43 +0800
In-Reply-To: <20241011060338.amcgqjgz37ju54fi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <29dc7fdf9dd8cfb05ece7d5eb07858529517022f.camel@suse.com>
	 <20240923133011.cmv63zpd3yg37yw2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
	 <CAL3q7H4f4-3=0OUwYQiFC3hDY=k3SDUsGEJm1S7iro5+pD9yyw@mail.gmail.com>
	 <20241011060338.amcgqjgz37ju54fi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

On Fri, 2024-10-11 at 14:03 +0800, Zorro Lang wrote:
> On Mon, Oct 07, 2024 at 01:11:35PM +0100, Filipe Manana wrote:
> > On Mon, Sep 23, 2024 at 2:30=E2=80=AFPM Zorro Lang <zlang@redhat.com>
> > wrote:
> > >=20
> > > On Mon, Sep 23, 2024 at 03:57:13PM +0800, An Long wrote:
> > > > Mount error info changed since util-linux v2.40
> > > > (91ea38e libmount: report failed syscall name).
> > > > So update _filter_mount_error() to match it.
> > > >=20
> > > > Signed-off-by: An Long <lan@suse.com>
> > > > ---
> > > > =C2=A0tests/btrfs/315 | 6 +++++-
> > > > =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/tests/btrfs/315 b/tests/btrfs/315
> > > > index 5852afad..5101a9a3 100755
> > > > --- a/tests/btrfs/315
> > > > +++ b/tests/btrfs/315
> > > > @@ -39,7 +39,11 @@ _filter_mount_error()
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # mount: <mnt-point>: fs=
config system call failed: File
> > > > exists.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # dmesg(1) may have more=
 information after failed mount
> > > > system
> > > > call.
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 grep -v dmesg | _filter_test_=
dir | sed -e
> > > > "s/mount(2)\|fsconfig//g"
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # For util-linux v2.4 and lat=
er:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # mount: <mountpoint>: mount =
system call failed: File
> > > > exists.
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 grep -v dmesg | _filter_test_=
dir | sed -e
> > > > "s/mount(2)\|fsconfig//g" | \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sed -E "s/mount( system=
 call failed:)/\1/"
> > >=20
> > > Oh, there's a local _filter_mount_error() in btrfs/315. I thought
> > > you can
> > > change the common helper _filter_error_mount() in common/filter.
> > > So maybe
> > > you can merge this _filter_mount_error into that common helper in
> > > another
> > > patch, then other test cases can use it.
> >=20
> > This patch missed the last update.
> > Was the cleanup to use the filter from common/filter required
> > before
> > merging this?
>=20
> Thanks Filipe, I'll merge this patch at first.
>=20
> Hi An, this patch has same issue with the other one you sent
> recently:
>=20
> =C2=A0 $ git am -s
> ./v2_20240923_lan_btrfs_315_update_filter_to_match_mount_cmd.mbx
> =C2=A0 Applying: btrfs/315: update filter to match mount cmd
> =C2=A0 error: corrupt patch at line 12
> =C2=A0 Patch failed at 0001 btrfs/315: update filter to match mount cmd
> =C2=A0 ...
>=20
> They all have "corrupt" data, maybe you can check the way you
> generate and
> send patches, better to not change the .patch file manually before
> sending.
> I'll merge this patch manually to catch up the release of this week,
> so
> don't need one more version :)
Thank you so much!
I've fixed this problem and it won't happen again ^_^
>=20
> Reviewed-by: Zorro Lang <zlang@redhat.com>
>=20
> >=20
> > Thanks.
> >=20
> > >=20
> > > Thanks,
> > > Zorro
> > >=20
> > >=20
> > > > =C2=A0}
> > > >=20
> > > > =C2=A0seed_device_must_fail()
> > > > --
> > > > 2.43.0
> > > >=20
> > > >=20
> > >=20
> > >=20
> >=20
>=20

--=20
An Long <lan@suse.com>
SUSE QE LSG, QE 2, Beijing

