Return-Path: <linux-btrfs+bounces-18809-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1958C4247A
	for <lists+linux-btrfs@lfdr.de>; Sat, 08 Nov 2025 03:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E7CE4E5CD8
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Nov 2025 02:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64212279334;
	Sat,  8 Nov 2025 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrven5Y5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364E41F0E25
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Nov 2025 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762567840; cv=none; b=P5RKRA8AfO5LmRknpCRbB7RHG6pmuFabbLHw9jwanETWrWf1c0jeMl8nvc80oUaDD3pXwI35ZsIadUTv1TuBnvs/VXwh4MU8ns6h+0TPiI65LdIbl5OUd8QKWv2+OUmkkr120Jkdwt3bXU4Ob/EH6m/oosS+blZavwptUKMuK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762567840; c=relaxed/simple;
	bh=EggKEcmHBVTr5JdZJ+jhWGt5+M1lwD271GrbwqiNacg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dQsPLNfDYwFNHcaW9c1HcGgWHrohEOgGyVfSQx9V7dEBDx0Bb3lHvJEC5W5tL8b3PdcTSIUHdrKsQrmC32aO9aXTdep77KjweHpxXTOv1elRUkm1T6cjbHSbinPBXJ9DmHFWpUh3EmDHj6PDlUm8ldF48IkSFEGhfaWEJypZVSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrven5Y5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-87a092251eeso15730126d6.0
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Nov 2025 18:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762567838; x=1763172638; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6RgXlQcH8fh4YS7+jQpKXbK579dAZ3J7H/Q2G64Klo=;
        b=mrven5Y5Dy19HfSmIHEXsG3OoarI7zgyd2vSLuXFKqX+eLIWPFpqcSgNkKLastyW7S
         Ig9DD6fg5ov+hzdrXiQdRJnl8aSMzEfWlUSeR+vv6XpPVi5mEDHGnNAnDENpbOqVGyc7
         OoktlteZEwUglL5rdV9Z9FCVFHkPnSr8ztdgGJm1scw1pbkCxZKywLyx6WxavupFTtba
         cSyS3gS1YpYXawlkZEfd+HxRfB4j2QmZuJvkcwj2W2+OMX7JjawLIuk7gdx+r7w8I1Sg
         7JHQfSEyW5qUxKcHWFX4VeHmi/zHusxBa65Ys5fA2S/hDVotIV8Y4Jqrj1WXYROnV4ow
         TS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762567838; x=1763172638;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6RgXlQcH8fh4YS7+jQpKXbK579dAZ3J7H/Q2G64Klo=;
        b=ER6Fz3jUiUFPW+QG1HPAhcKjPcWRaufIbCsUbi5EWF/M0l8Yw8ySAXTyVI4V6SV+al
         d8Qd6pM9S4WqsOrUXuyc6n6eDJ9M1I5h+unHt9T4RcifFYwVSCrh2eUfEru0yjVOsPAJ
         +BQMYZk9lpuR/VMUSLVQG+ooZwNV4c90iIm3MIK6ysYKZ+wKKcAZALW3X77x32UTiUeE
         Z2ywNvquZyo1bhXizQjveG2ferXylsKda2E2BOIJXDZQFlOHFnQpfIKLSYgapBuoCe4c
         mxiEkOuC6n5JhucKcg1xMRCPYcTPgJsQHvs3UhoVXFkrB1wSfm5E/sKjIfw5gwgQIG4o
         Yk5g==
X-Forwarded-Encrypted: i=1; AJvYcCX+5iS3igSAb+qLYoGQQiY/lVJcrZwlPlwC6KGgH4cbEV4YjQlgiBfig/VsAD5kyD8TM+bg1H7+nQan1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUQVLEFItiPrrNkWyyFd/xSlQhI+Ue1Te3UPpPrYTSzJyZP4nn
	TehhCFD7R1nqUDCk3Puy+nsTDWNqKVA6fEYRuQBZFFUZIsz2sToVvOiG
X-Gm-Gg: ASbGncuixYU+E9TTXkgUG2+eGQno+yQcgG5zk8EysaSz5wzLa2C21uL7qpaR7AlgzNg
	OurhZx24+LssW+spBhP1jRe96Nl43QLkpOFvBkckztMTamWNa6/ZOE47Iwd1J3m19nDkU6hwCGM
	WVbB1RgFNO/nZDY6nw20Kr0wRWTt1GoblkRnYMUh7JumifYEw4ry60rpuKD2OqT3XrjKNLvxc2C
	EuL/xR8A62e8Xs76saKszkCvAdwA9BZ1uTThku0sZGLty5LDU2IimKp1N4lmxrtybQeYLvphsni
	MBXOvju5bjQ+xsNNNrd/H9Ml+xmdp/4IOCA0FC1eP649MIO5vrT60XYen+LbD6+VulDFd9RTBTj
	sc1B0LeKWUah216ZA+qMZGSFPXUIi8uRV8KaIF+EqUzc60+8CWRrm0cxMyTSQn6teDI107FNtWn
	brs7w14UeK+qa8N/Eh9M/V0HicbUCcLlUGgw==
X-Google-Smtp-Source: AGHT+IEWKGgpG4bygNpHIXXHS+drqrBajcU0YO04sRLqgN88XMqQXO1fNHypxUPYrJHwXVPVd6DfFA==
X-Received: by 2002:a05:6214:5183:b0:880:50dd:16fc with SMTP id 6a1803df08f44-8823795a980mr17441996d6.7.1762567837861;
        Fri, 07 Nov 2025 18:10:37 -0800 (PST)
Received: from localhost (69-171-146-205.rdns.distributel.net. [69.171.146.205])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-882389916d4sm7346726d6.22.2025.11.07.18.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 18:10:37 -0800 (PST)
From: Nicholas D Steeves <nsteeves@gmail.com>
To: Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: RAID1 vs RAID10
In-Reply-To: <CAA91j0Wfg2uZptchB-aeaB44C+=igPMP-mZg6ovidmLs_dW4hg@mail.gmail.com>
References: <20251020122115.GA1461277@tik.uni-stuttgart.de>
 <CAA91j0Wfg2uZptchB-aeaB44C+=igPMP-mZg6ovidmLs_dW4hg@mail.gmail.com>
Date: Fri, 07 Nov 2025 21:10:34 -0500
Message-ID: <87cy5txoit.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrei Borzenkov <arvidjaar@gmail.com> writes:

> On Mon, Oct 20, 2025 at 3:23=E2=80=AFPM Ulli Horlacher
> <framstag@rus.uni-stuttgart.de> wrote:
>>
>>
>> I have just discovered, that RAID1 is possible with more than 2 devices:
>>
>> https://btrfs.readthedocs.io/en/latest/mkfs.btrfs.html#profiles
>>
>> What is the difference to RAID10?
>>
>
> In RAID1 each chunk (copy) is located on a single disk. In RAID10 each
> chunk (copy) is striped across multiple disks.
>
> https://lore.kernel.org/linux-btrfs/87v8qokryt.fsf@vps.thesusis.net/T/

Does the RAID10 profile still have equivalent read-speed to RAID1
profile on recent (>=3D6.12) kernels?  Last I looked into it both were
still limited to the speed of a single-device.

Regards,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmkOppsTHG5zdGVldmVz
QGdtYWlsLmNvbQAKCRBaiDBHX30QYYdGD/4iPf+MJQvxZBS7+78B1uaUSl4Ip4bC
XCXivgOjf0mVYa0n//rDyRTddLlpmd1hjMNZ4yi65iTipJT6Ns5N9vl1L1Z7NNf4
05RGSWfVHqx0QykxjEV4qn3HLlKbNx8UT2rYKz43EhexbdnkokLWp4iFEiiEc7rZ
a/2/7mAGtRxsScy4DVqJS7nEN6JLoEcE3U7SOf/2V+kr5mAGUC5BwBO8lJNmcVPo
/AH91zWiRly92JSbeud0Fgiwy7au4Fh/zwkq/ZiuhXspa9XK5ATlSXjVZMcTnH3n
YXjiji+RjnlywbbFA3pYuFYHg++uv0wSCShr+Bd6Sv+wNajnb9leazvaQ/VbsdiS
gjwM6IztVzE7+OOEEHb38HYg753k10h1vwPbm1Iq2M9kOkF+nPYCpWRno/c8G/LW
j3HQ+Y3zrxPbONED0y8/LZ9GmlAEpylyGUYQWO9nGMldCJa6jkbRYqTJx23NY38Q
quI4Crk2y1TA6RD2a+ksT7a/d7kEM6EV/krHAQDa8dwkkHEaZohoh2GQF1FCKcaW
hUSFLUKcu6BMTY6Tfly24b4LCjXhEDg5ZgEr9RlTbNn/g4nX7QF5/PX4hSkjJJd4
TV2WxrbUFTLPmYiLWvBTOIrvWwOxou8EjncJPaJHZbjJL49S9tLgI1P0clnO9Esy
OBOJs4OrMSzu1g==
=AU5S
-----END PGP SIGNATURE-----
--=-=-=--

