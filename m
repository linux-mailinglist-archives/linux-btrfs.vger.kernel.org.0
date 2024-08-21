Return-Path: <linux-btrfs+bounces-7354-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D75959417
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 07:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C831F241E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 05:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E808167DA8;
	Wed, 21 Aug 2024 05:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LNtwBUVO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09679D1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 05:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724218454; cv=none; b=BB3UtYl2ik8Hqp6TSIZIlbid25WC/Fh53YdiO8vtaZEII0LeFC3pFSDwhDLjZBqkFO0uoyed+lpr/ANMty5TIz4vz/WaINujxwDSBccuzEEhTyup+KR0sGuVADyHFI7eNX7+AK/mHmVf9XULql/rzxnWtDjE5chQb9LrmQUr2rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724218454; c=relaxed/simple;
	bh=q3nstQUk7dVP+U02IdDBUwHHbZyqC7YaiiDVkjHbQOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oRIeNazFmGx05O2SKA6+ZPQNccrlyk9pKeL1NsqwnvutqJRm34wiqw1YdYFPNPzJ2FIQyueDiVFFL030jelQEZYhKiK0WR/6W98FmM19riw5U75iy839Ziq1bN2gD1oP3WZX2AzAQ3pPFz1j0LeQrPIt7Nix746BU2qnrn+YYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LNtwBUVO; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724218449; x=1724823249; i=quwenruo.btrfs@gmx.com;
	bh=lEqDAOuVpWGWD+xBVenzd4d/+jYWfhXRN1GUJ12Idk0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LNtwBUVOcpGlJwAyr/YHTIEFeUFJN6fM9MJ1NGCdvwXKtJkr+fS6K2JdRIWiF0Re
	 s3uJGZIOzqLuRTJcJk5Gv3Jj804Rb2rSH6U8GOgxCV6xt7F17mMUA3PIfkMbfdY+L
	 OeL609MvGcvacKnNgLpS2+zKGZFTTvZsirrAFaFL/R4NOH8YjCYXjML0j679Gp8p+
	 GXb/WCUZiFcVy7P0YgafYY+yeLMa4L3xwvWSLdIYDK0ZeK/4It+l0zVIjh1VA+9jz
	 St1dtnM+L7KwJRUVoLnte2g70iia+39fPDR6M8RMUtOGJ8nxcpzFOWenXKBSGOJeK
	 w8h5WgH+yl877c17fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M89L1-1slIwd2OmZ-007Aia; Wed, 21
 Aug 2024 07:34:09 +0200
Message-ID: <07e39275-8bcc-4656-9458-d05d0d68aa9c@gmx.com>
Date: Wed, 21 Aug 2024 15:04:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: File system errors causing read-only lock
To: Emily May <revsys413@gmail.com>, linux-btrfs@vger.kernel.org
References: <CABxKzfCEney-J_tE1yBVDaHAZTYKZXSqVd8deeBtwFx=RNCXNA@mail.gmail.com>
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
In-Reply-To: <CABxKzfCEney-J_tE1yBVDaHAZTYKZXSqVd8deeBtwFx=RNCXNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6F1prVvlddYTOoKG+wNS/xzLpfdQtPCVanvge85KFKRMbmIuyR1
 FgyK0xuLIbUg7amUXR8+zfG/LcSKddiWJ6C4rkkzPsU60JkZYwChVHFk2FF/UUL33+O5LtI
 fyQl5ghm5eLvRHdOzs/cOFSX3pqg1U2aP7b3RLnMOtbDM6jLHdfQvlmBKa91UwxFLkFUPxj
 i61i7twKOunK5FZE0lz9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qeZXRSAqVUc=;xws6UKogNTvmp5JlHItOUaVvQIA
 bzBY8U7ozX/wWZ/aTzWGtbGQGygVmfqpNZGRXDL/usP41VnVQDLEE4Pz61kwiKHpdFdX0wXhl
 i4T1mBPoTv/t9BMVSgVqVH6CZuMyxv+/RlaPMD5CP6raquJg4baFmZ1GgY3ngZEKYTuVQSzOv
 OrtqE9Wreg/IZYOpaHdon7DxBM3f+JfAiiweQP3u6wqIxDnR9EOKaYsk0SOuJaSXW4wSLDurB
 RoZj/B69E/qAxj8MGOTj8cQv6rITrgaXZt03GdO4/0xMOnG6efJX9UCPPMjWxHmBGxDXVDsBG
 mPBoFzFi1E4nQfIFGI/lKDk0c9S0+uXy1qDz7e7sZJ+V3qsxnASsA7KVm1dlheBJYgFrncT2H
 P2nWRb0/PesGv6dUVEdOR5b54qUFoiqzfXtTxJu9l2usTR8mp3fB2okij+DQWDxIi3oEyKyPD
 XyshpdFSqG7OOrnLK/F9Im9C14k2osnY3inZkfaDS4NyHdmZGvywqXrOxAzeH1DMm5+nx1ra/
 TOwZXc58E0IzpNtpd0Jc9IguiXgQQSshVl/XSoQw0HRVSK5VRTli0DESAbIXLsEILpMIxkwdP
 OeWuxMF1XfWh0COQc7GbmWBDSo9FTDRkrJsbhxe07FV+R89c79XraAmagmxprRzx/ffDQMsZj
 QXP7MLIiUI1fJKQY+eT05MUBEo8mLPHzceBGnxQHqfE98UsHiMXAJFljTYkwrhhwiRR7HqZg/
 8JPKPW5b/sk2woVWp+43GxzuimzsaUQgU9Jncwj/0BhCbjw8snYWMVBjxmumLltXAa9ccLVGA
 Clg2A1mGeePyU/F5jlwCGUHA==



=E5=9C=A8 2024/8/21 14:55, Emily May =E5=86=99=E9=81=93:
> Hello,
>
> I've been having an issue with my PC suddenly going read-only after a
> short amount of uptime. Before panicking about SSD failure or something
> like that, I was told it would be prudent to check for brtfs errors and
> ask the mailing group for support. Though I don't really understand what
> the log is saying, from what I can see it does indeed seem like there
> are errors with the file system.
>
> I've attached the text from sudo btrfs check --readonly /dev/nvme0n1p3
> to this message along with the dmesg.log. Here are the other commands
> needed for support requests:
>
> mint@mint:~$ uname -a
> Linux mint 5.15.0-76-generic #83-Ubuntu SMP Thu Jun 15 19:16:32 UTC 2023
> x86_64 x86_64 x86_64 GNU/Linux
> mint@mint:~$ btrfs --version
> btrfs-progs v5.16.2

Since you're using a liveUSB, please use a much newer distro.
With at least v6.0 progs.

And when dumping the output of "btrfs check", please also dump the
stderr and stdout, e.g.

  $ sudo btrfs check --read-only /dev/nvme0n1p3 &> /tmp/output


Furthermore, you should check the dmesg immediately after the fs flips
read-only, that can provide the most direct reason, especially we may
hit some sanity checks triggered by something like hardware memory
bitflip (in that case, btrfs flips RO to prevent the corruption reaching
the disk, but won't be detected by btrfs-check afterwards).

The attached dmesg provides nothing useful instead...

Thanks,
Qu
> mint@mint:~$ btrfs fi show
> mint@mint:~$ btrfs fi df /media/mint/6c2c7d51-04aa-4be3-bdc6-86d30b1119f=
9
> Data, single: total=3D1.76TiB, used=3D1.67TiB
> System, DUP: total=3D40.00MiB, used=3D240.00KiB
> Metadata, DUP: total=3D9.00GiB, used=3D5.11GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> Note: This is obviously from a live USB, not my main system, so any
> system information may not necessarily be correct. However, it is the
> same LTS version of Linux Mint as is installed on the problematic file
> system.
>
> Please let me know where to go from here.
>
> Thanks for your time,
> Emily

