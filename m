Return-Path: <linux-btrfs+bounces-7913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27079744CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 23:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA7F1F26D70
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 21:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ADC1AB521;
	Tue, 10 Sep 2024 21:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GYA0FicY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2C23774
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726003728; cv=none; b=ib8DYQFctQEgL/OvKpETj9jkQZHi1JeouZgypDWNuC/R7giFxzinJlZJmkkk6ckV2xQGQr1f2QHnZDEaFQg5mFmX3QJW/5XnBcRUOnFSCGTIOGeI9w2SGTu2+nb8NRnJfEJhvkUprya6c/TCYQaMkDcL87FT1KkNY2zWaPEYIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726003728; c=relaxed/simple;
	bh=7ldcY+E/By176xYEyW1SmjhU8B4F4sZo7rmMVbY/qU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MztctpByMBeLuyKchWVg4Ra7HyhXEbAEabPme8VCzrbbmU1KOo1VPazChUomQdTVIRsJK6wEKlX9UEB2y005sYWuiElFbqhn7Gg1UDl8vVjdGTA/8nkkoBQvBJIWjsOFD+pc/utFYID2AXPc2pYpnXRZ+YRqfY8Es+fr2K2z+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GYA0FicY; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726003722; x=1726608522; i=quwenruo.btrfs@gmx.com;
	bh=7ldcY+E/By176xYEyW1SmjhU8B4F4sZo7rmMVbY/qU8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GYA0FicYcBnCI4ZT+jNYFx6JVE+bboorXKZJ4+4aXRUrUSt0+ilWT+vaLBB59ImV
	 PtMRo93ELhXtVVcE2H+5XdsaFqlu2PLaDu0CSkoNKrMpoZ56gk8YLDOqL/nh1JXHR
	 9x5Yc9MEix+kC3vizRNcnKZ4oFtQROcnmitrJ7ijPCxLDyrJgDACBWkN4bTD2EbN5
	 UJgo9OYwLbF6JPUOdRg8UgR1PDo99wKJgp0wacgSYAJjqI2HMK0hqr+2StjkBynxW
	 +LrnIYXg6Mj4AhcvrcVa4Xuf+OAaIq3cqQFku6WmMBJNMs+4KKgzPJNh229dPWXzR
	 MGOL/j93nmWXURroPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7sDq-1st46F2pQA-0052zQ; Tue, 10
 Sep 2024 23:28:42 +0200
Message-ID: <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
Date: Wed, 11 Sep 2024 06:58:38 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Critical error from Tree-checker
To: Archange <archange@archlinux.org>, linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hCa0AIjwX7p/gV+eso41ANltoKeNQH0v1Tg5Lcx2w2xj7rqh06r
 Q8fWALgMz0L/uVp8Szy4ScVXX2bq3brwKxVl+vsppMfMJ1QMktOWD3gK+UuEB0E+5mQ2fzn
 VgL+EOfPny1xex4NJDFwpYcr1lD/qpP9+TnB8P7GYPHHEuhw67WjgygXVszS1lwBCPWYfOc
 3pfl6k3p1lFVet5gtNDcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KpVauw0xDe0=;kCDtUQhEASKN5Rw1lW1KUFCKLkD
 aaTN2fq4/bso8XDiWS/fN6Epi1dNbxF9ppjcpZqebwpiHRz0FtS38dyTslHcPVJ0j+kXHjgr5
 ++YACaHWaEsBSeNAWkd4nTxNcl3x4YU4IplmW8fcISl6HCJLn4VEn7m4faizx9AjfP1JPPRXb
 xN8qrzVPcSgfcZkqio5FmF2gf59Bq/F0B0h35D+f2wo9wdrIEbqGxQlk0NzFNKA/VNrrXQrfq
 zkBdtWyocxhnEI37A2Nx4qLSG+Nh+Zmln5RKRdnBjVepJeC5aPPYpuplNiwwp55sLcqdL0B+M
 M3MHFDMCt7w6Vkh3zzTpikCgqEdoP8u1SnH4G3md8tZ9PCRh8vITcfEhYiM9SsaBwPoikjFQ9
 WDp13w+XPyGf4aJc1WnWUXZ0fHnL2HJDoT2+0Alznengv9atX4M9WB+bm9pU8D3r0Q4DutM0c
 zHsOTLOyy60ZPSqIvBMPX/NmzUOt+5AzHqPtuOYSxmvvlzuzdecHR5XgAYw99rUvhdUHkAq/T
 nGIqfGtgLWt4zmq3uaOrCEdA189mWjjgeQ83paAvOeV+hLq+fc8pvAee+mmo4wRhYNQjz5eJo
 AVOElXz6QEM2euFNraESzR8WZqdWyuT67VX2GBxeZNdlUjTPnmPztC8SLCGRTDbsawQLKzNKc
 vFqQsVWpEENI+JJU7T0aJbYbkwAmPfyYuS5heqifxRaOf9ewfk3T80luUnQ85Efn7m+MV/8zl
 Z2X9sCRbjQNnMKgINwvRwg/y87yLbOhN+/Q6IObrw71DCcWg/H2lT9Goh4w4ESRH9rohdyYi2
 bAF1PdmsmEcOLukKaszEeFXw==



=E5=9C=A8 2024/9/11 06:35, Archange =E5=86=99=E9=81=93:
> Hi there,
>
> Since today, my system started randomly becoming read-only. At that
> point I can still run dmesg in an open terminal, so I=E2=80=99ve seen it=
 was
> related to a btrfs error, but did not try anything since I could not
> open a web browser anymore. But I=E2=80=99ve seen the error to be =E2=80=
=9CBTRFS
> critical=E2=80=9D and related to a =E2=80=9Ccorrupt leaf=E2=80=9D.
>
> I=E2=80=99ve tried to run `btrfs scrub` on the device after rebooting, a=
nd in
> fact it aborted almost right away triggering the same error in dmesg
> (but not turning the system read-only, so I can copy paste it here):
>
> [=C2=A0 365.268769] BTRFS info (device dm-0): scrub: started on devid 1
> [=C2=A0 385.788000] page: refcount:3 mapcount:0 mapping:00000000d0054cae
> index:0x9678888 pfn:0x11ce15
> [=C2=A0 385.788015] memcg:ffff9fc94db8f000
> [=C2=A0 385.788021] aops:btree_aops [btrfs] ino:1
> [=C2=A0 385.788235] flags:
> 0x2ffffa000004020(lru|private|node=3D0|zone=3D2|lastcpupid=3D0x1ffff)
> [=C2=A0 385.788248] raw: 02ffffa000004020 ffffea9a8574ff88 ffffea9a84738=
5c8
> ffff9fc95b8365b0
> [=C2=A0 385.788255] raw: 0000000009678888 ffff9fc9ae554000 00000003fffff=
fff
> ffff9fc94db8f000
> [=C2=A0 385.788259] page dumped because: eb page dump
> [=C2=A0 385.788264] BTRFS critical (device dm-0): corrupt leaf:
> block=3D646267305984 slot=3D92 extent bytenr=3D1182031872 len=3D106496 i=
nvalid
> data ref objectid value 257

Full dmesg please.

Normally it should dump the full content of the tree block, to help
debugging the problem.

Thanks,
Qu
> [=C2=A0 385.788283] BTRFS error (device dm-0): read time tree block
> corruption detected on logical 646267305984 mirror 1
> [=C2=A0 385.796803] BTRFS info (device dm-0): scrub: not finished on dev=
id 1
> with status: -5
>
> According to https://btrfs.readthedocs.io/en/latest/Tree-checker.html
> this is not really expected, and the last paragraph says to report
> troubles here. So here I am, in the search for advice about this error
> (web searches returned nothing with this specific error except the
> commit/ml messages that added the code for it) and how to fix my random
> lockups.
>
> Regards.
>
> P.S.: I=E2=80=99m not subscribed to the list, so please keep me in copy =
when
> answering.
>
>

