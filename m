Return-Path: <linux-btrfs+bounces-11187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ED7A2356A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 21:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E15C7A0F7B
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 20:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E1F1EF09C;
	Thu, 30 Jan 2025 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Z/QgEHRY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC661AF0C3
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738270520; cv=none; b=fyCW+raUWPXZd5TAmSYVTuGWRI+7E9J4drBX5o6iemlgGMKD/aDKFV0nN1vx2pn3W6O2Mog6XzyL+nLUZB+XdklNq6L31JRvsuqLzrElEgcJ79N3R3N1AkKP4Lsa3ZajxTaOF+sW5fr+dOd7J2mT7YJVGuvqO731eqM0DY72IdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738270520; c=relaxed/simple;
	bh=yCNNbRSSd10H6H+M/w+BUM61fa8e7VcSsh0AwJdXo8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QxxkTxM+EqH3COTRkw68YLdVf5Tu6Drc3LT9vxtj4fbW6OVmEtTcy5udLBWQf3qQ8ApWUrzjQC57XArJf6+FFp1BBSn07bp3DNmvvjYzYVoo/gFqu1vWC1l45Pk5HsEwNypJ8gXxNaGtXfR/jx94uB0JKIc5PHKjj4OpwYuS4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Z/QgEHRY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738270514; x=1738875314; i=quwenruo.btrfs@gmx.com;
	bh=yCNNbRSSd10H6H+M/w+BUM61fa8e7VcSsh0AwJdXo8w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z/QgEHRYjC5soQOVU5O/x2V+ZhJMm3v5eSPUYt2+WVoICckxLGZgHhO8GUI4DzDB
	 ZFBE1qKTWLNWVgtP6QAQMO1T0wYRBgDZqQ+ua02bemmJLbwNbLeWPmrG4HgYDkYtQ
	 m0PzJSCw9C+JkKcdwVauEhAHYM2I9c67FGNqK3Jg1R8WOBEkmfoeTa6egu/mGifYO
	 xeUG9KMd3U8o9Yz/pxdW0jGLOWc7Z0zFxmKLefFBOYXSqkLd1z65f/Xuqli0ZRFEN
	 M6MqFjm06SqebKQQjuZXLx0HgiIRIO8ShNg3Y3dmkWFVtt/OIXZiMSvwcnu6k90Of
	 621ZtCsm9PCgWtEEbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4axq-1te9GW18as-00F6S5; Thu, 30
 Jan 2025 21:55:14 +0100
Message-ID: <04248af3-125f-4914-86a0-834db4c7f4e6@gmx.com>
Date: Fri, 31 Jan 2025 07:25:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bacik's recommendations on parallel FS modification?
To: Han-Wen Nienhuys <hanwen@engflow.com>, linux-btrfs@vger.kernel.org
References: <CAOjC7oMrMRy4jemm+910qwPHSTVM2evWSDi3xi9sh5+n=Qf4Qw@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <CAOjC7oMrMRy4jemm+910qwPHSTVM2evWSDi3xi9sh5+n=Qf4Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RqzjkNKSDWGcRRfzcWoOK5ccF0LZ+PKYfJYS99aJyM7LNzD5r1z
 8ys9NU1SyQzMN45qI8P2s+Pv6bGRt0m/Rccm0a2PNUEvyoA91JK6DT9l41s84YMj32+BgCF
 o/cN/9/1BFfXRRB91cH5JkblSAQcFbh+w7A61c/Qr88yi4ahNAY2fGHM+5KfacROP6KknOs
 5BFzic1tU4TCJaP5nehvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H/wp3cIfAtA=;n0YWfjJGTEtgiv+NdyUHMVqvPAu
 IwB8CTXYCFPEZFe31dsxNaaG33UakxpSe4L9kxT+o1BqZlblaQs0FDJynpZjG1lqN48uv0nn0
 Es1tRK3KhhPPuOsLYigxxDr6Oi6fYxKzjt701ZvpykGaO9UT2VG181RBA9eiM8S2EuKEN3hrj
 DVDORT+KPQtkoZOjETqIhRNOMFe5J6jApOLS2jncX4VqRYwCTKq4oImGj5zQ0Aqjpe2gd0aKc
 2cl5YZ+uSQpk9PcgLuAxo6BW3WpZ0i9YnwANKZA4HuFLtglF9mqRI9Wqdrs2SO3uq6BFFIB/7
 QTdLZUzGFAZReg06J9QmcJA4282ru8MqCpzkEBLk87d3sYjGNabb2X6lnDxbqBCu7HaKYFO0X
 hVkXZ5ckg2uBuALNDvKzhTheYxvEkGRFYaFYu69Dv4uDBOluXE1fi16gquoCNRRFTkntXbL1G
 JpeisrYqSOPRiVRmoLkopeJPauaX3IYxnkGzvIBf3FCYNBv6f6tNzlE2aOnvwp/eDLIOyV/XE
 3MBmoMv6fSijnC11MHNPUQfqe5vquoUAXCmZ2GPoWP0K9E83apzU2Wp0dyWPrn1NLAwjS+b1o
 SEGRHMh37y8ia+2j7S/hbmftm9QVzQDjxlLEHU8+mCxJ0LnJ6pJYmdZ+drStnowSX+XMWbSKf
 Hs41YGyy0dqL7H27rFEw+PEvl34JsQlYoTIbizcX6Fe3fB1ad+HIGDyH/RkhpvIPoQN2d7tWC
 U1j0kNkBFIbrHwMejPkAGIDaz69PGI6SYsa82rM2RRCQraIraAOjW3c4bSdOwMPNo7TX9e4xu
 6zNOt+dHqKZrRDRZpIwFBTxsCP4IAbkCRhgpiVfgKFR/P2yZ4R0Cl+3Hk/YYZeO26/ZbcRXbk
 YXhfGskZMPwMHUTNkVtTaPnyIEL7L5vkKmtFO00lvqEfRQeT4Bkh/BGfVc8UyotKHrD6Cq2dd
 WNyQBxFi0h65NsInZlEdSFJ2IMUjTd1fxVzQA8dOVZsB+tjJvqxLdObESs+X8eyqtSRTITY1Z
 j6mrU9xhzsvocraSQ98dufOkCxWzy0E8wGX4u1k5Ox5QNYYcbiaNh1GaGQyKfeeWkJbJJCIg1
 8w9mKMuFMhFlPjDSbFFIf7DAQ+BR8EHgm3mukEOGIS/dCctOvbuT8VIugGVTyD0g92D7NvNZA
 LgwdwCLV71uvMIMaESMhtIJBtPBxRfjcJgBZziTAVtyR7zLEcX1eF2K/OlSOKOhMObk+yaUQ0
 TYDK07Rl82i3TAvFAOwZMZ/xCyY4M93Wft23hK3PHo0H3xFeahzOf/HhyVbl+i0MoJWnHoGko
 LSTorQwRyfP6/Ynbx4+9ncKqA==



=E5=9C=A8 2025/1/31 00:21, Han-Wen Nienhuys =E5=86=99=E9=81=93:
> Hi there,
>
> at $DAYJOB, we are considering whether to use XFS or BTRFS for an
> application that needs reflink functionality. I was reading up on
> BTRFS, and came across this bit on Josef Bacik's blog,
>
> "For heavy applications that modify the file system in a
> multi-threaded way we=E2=80=99ll often advise making subvolumes for the
> directories that are being modified."
>
> (https://josefbacik.github.io/kernel/btrfs/extent-tree-v2/2021/11/10/btr=
fs-global-roots.html)
>
> Is this advice still relevant, and is there any documentation that
> explains best practices in more detail?

Still true.

A subvolume is can be considered as a separate fs, it has its own inode
space.

Thus different subvolumes do not need to race for the same tree blocks,
and will have a much better concurrency.

Thanks,
Qu
>
> I looked over the docs at https://btrfs.readthedocs.io/ but couldn't
> find anything of the sort.
>
> thanks!
>


