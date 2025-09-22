Return-Path: <linux-btrfs+bounces-17082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 790FEB90739
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 13:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD9916BEB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 11:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713BF30649E;
	Mon, 22 Sep 2025 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nde1+5mw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DA23054C3
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541261; cv=none; b=WUuSGv95ldvh77cjv+4tYTJFX6qtGijMG+MQHQCTMFdwydlFkgeZIWppGhrOhzbQUvpflgPITnmjFQHs+BAda1deIQXa1bz/sgomlR57vkL6NEhe45011/yIZ0fW5pE55nIEcfJljunSbpS8m0JMaq5h/pYsvrG/X82zMnDOhqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541261; c=relaxed/simple;
	bh=aPaErGgmbXGqvACGGtV+sP5/Bp1RbgbPMv/32zN9vRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6EWlji8sGvyDs1oapHiSxu8pp2+EvJra9Ui7y+UWCvqF9LndDE1V1Q5iMVoFAmn2OobnNxQfAR0c/YSZzl1pJ48z9p0voNY8Aix4MhmKTXWb2pJH3DGfiYpb+X3a5KTWTHH2dyeM6uq2u2/JIKyXmvWgzapN5g62bdXcZPFqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nde1+5mw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b2bddecc51aso150727366b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758541257; x=1759146057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04z74R98bM0sfCQNq5YpIGFCni5y/NEJwPjehOYmg60=;
        b=nde1+5mwA9i16f8YMaGTfUf+63P3a0mKZJua8cfOlUxscN2meoJY/GNU1yVjdWfbcC
         nbsXm+eEIh2jC70c50Lph1jI0q1AQttD6XvMGZR3RrcvsVk4sMzLCqwauomoJNpHN58m
         wWhbi9CxbaQV2kmd+AK48dmDhaXvCW4FGsIDUUg33cIaQ6k1LeLc3Z5sPZMpFshJ1f68
         9VmE4hEpEr0tmZnnY5SbSOuIRGh2Ior6rrG61Gaa92lXkTW6DXcrOVDbAAhfhFZJt8CP
         zFXnOtaDdVEHjSOGpdi9JaQt5n9DM1aPMIQN0wM5K5GwZbuszoAyYs4QjRI5ByNjw2Yn
         Hd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758541257; x=1759146057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04z74R98bM0sfCQNq5YpIGFCni5y/NEJwPjehOYmg60=;
        b=KKX85i1/4+ZXyr3iIhHTM0BlLXYtqo2n1WTarbwwUtjMJ1DmTMIlUbIhyyl2cmAaZU
         9eOyFilk7geU7UOAXbK14LxWe8lSN/gpBsX18kYwoBi4gSlWmd5ubHE4+asfdeQ6OU/D
         sp7wKnBtUfWPqClLJs/GxxcNqDAssICtnWextb+cvbwVVw7UienJCsABcYyK16jsBy9E
         Si11Oo4tZ0Dsl45Mp1Nw+io+bv7HVai/mPIbhH5OyDDune7w3nCB0b+TFUGqKvQzPEGe
         m/FlFbmPYvkXC4LypoJl0AQ00R6XvTg+rPI0liXB1+ArmGaRxo5td/emJnItrh2FFNxL
         UUww==
X-Forwarded-Encrypted: i=1; AJvYcCWuNfbnvsgCi0EtQ2pd12AJFdNgracVTs9ZFDjnS0wSxMlLDAym6yOGvk7cv3pccSZvmebTRbS8xf0sFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpVsYFhMXZROQApJ0OGYMEqLiCWGlTdxwWSd60Dnbxgs717/k5
	OOeKhvMq3JU7XmaGWIWQeYP466DQlMYk2KTuqrGaA9SISZhGs5ALSbOjLqUdjS2SmbW+hLnqZT6
	H5beERkCoD5HTfyY4M/3w3l2jZFFawzk=
X-Gm-Gg: ASbGncuUCmElnEPHI53igeiy2DqliAxX8JCqKViISoS+crdH6duv5NavlAZaAnagF8n
	FJhImQknQAwYeqSqD9a+FQ3+TqR7CKYuP/FAHIvSHAcO9UyePPjVKEerqhQcPMzJAyVAW37COXG
	3Pqg9VpRvMf7aF82PY6PoDkpS7OTBjPu2x4Ko3FQkVmqYu2LaSOYcxVcbZABAT50REt5vGgcsHT
	Bk2HVpfcDnqBMz5yetQPZVoEFFB/kGeGr1RZQ==
X-Google-Smtp-Source: AGHT+IEoKYUb2hbctltECTBx23lnPTYILMgFVvmf1VmhRMku/GTeHmhyoKuTLZiEJXJZ8X/9p7bnSfuwpO8pk23TruE=
X-Received: by 2002:a17:907:84d:b0:b04:2452:e267 with SMTP id
 a640c23a62f3a-b24f4ebfebemr1319468866b.56.1758541256657; Mon, 22 Sep 2025
 04:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919154905.2592318-1-mjguzik@gmail.com> <73885a08-f255-4638-8a53-f136537f4b4c@gmail.com>
 <CAGudoHHnhej-jxkSBG5im+QXh5GZfp1KsO40EV=PPDxuGbco8Q@mail.gmail.com> <ui5ek5me3j56y5iw3lyckwmf7lag4du5w2axfomy73wwijnf4n@rudaeiphf5oi>
In-Reply-To: <ui5ek5me3j56y5iw3lyckwmf7lag4du5w2axfomy73wwijnf4n@rudaeiphf5oi>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 22 Sep 2025 13:40:43 +0200
X-Gm-Features: AS18NWBmMTL4ZSFEbiLsT0UBRmQh6SVMkgEq3_7KbEv4DQ9iOTcUeAUpn_jz6r0
Message-ID: <CAGudoHG6HgXThjeaeDWfngiNCWdikczgN_3Z_T8sKJt4CaR-ow@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] hide ->i_state behind accessors
To: Jan Kara <jack@suse.cz>
Cc: Russell Haley <yumpusamongus@gmail.com>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:36=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 20-09-25 07:47:46, Mateusz Guzik wrote:
> > On Sat, Sep 20, 2025 at 6:31=E2=80=AFAM Russell Haley <yumpusamongus@gm=
ail.com> wrote:
> > >
> > > On 9/19/25 10:49 AM, Mateusz Guzik wrote:
> > > > This is generated against:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/=
?h=3Dvfs-6.18.inode.refcount.preliminaries
> > > >
> > > > First commit message quoted verbatim with rationable + API:
> > > >
> > > > [quote]
> > > > Open-coded accesses prevent asserting they are done correctly. One
> > > > obvious aspect is locking, but significantly more can checked. For
> > > > example it can be detected when the code is clearing flags which ar=
e
> > > > already missing, or is setting flags when it is illegal (e.g., I_FR=
EEING
> > > > when ->i_count > 0).
> > > >
> > > > Given the late stage of the release cycle this patchset only aims t=
o
> > > > hide access, it does not provide any of the checks.
> > > >
> > > > Consumers can be trivially converted. Suppose flags I_A and I_B are=
 to
> > > > be handled, then:
> > > >
> > > > state =3D inode->i_state        =3D> state =3D inode_state_read(ino=
de)
> > > > inode->i_state |=3D (I_A | I_B)         =3D> inode_state_add(inode,=
 I_A | I_B)
> > > > inode->i_state &=3D ~(I_A | I_B)        =3D> inode_state_del(inode,=
 I_A | I_B)
> > > > inode->i_state =3D I_A | I_B    =3D> inode_state_set(inode, I_A | I=
_B)
> > > > [/quote]
> > >
> > > Drive-by bikeshedding: s/set/replace/g
> > >
> > > "replace" removes ambiguity with the concept of setting a bit ( |=3D =
). An
> > > alternative would be "set_only".
> > >
> >
> > I agree _set may be ambiguous here. I was considering something like
> > _assign or _set_value instead.
>
> I agree _assign might be a better option. In fact my favorite variant wou=
ld
> be:
>
> inode_state_set() - setting bit in state
> inode_state_clear() - clearing bit in state
> inode_state_assign() - assigning value to state
>
> But if you just rename inode_state_set() to inode_state_assign() that wou=
ld
> be already good.

well renaming is just a matter of sed, so rolling with 3 or 1 does not
make material difference
that said, the set/clear/assign trio sgtm, i should have proposed it
after assign :P

