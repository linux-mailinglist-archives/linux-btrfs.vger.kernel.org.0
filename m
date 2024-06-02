Return-Path: <linux-btrfs+bounces-5406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7168D78EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 00:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41F91F211C7
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 22:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA0A55880;
	Sun,  2 Jun 2024 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QhVxKiBy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C95A21
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717369048; cv=none; b=pLKIT2mE1Indg5rqGJpUxd0YYvHliqPavpKjMoyyrQZ0ZFoFVieMvkjQV/dAdkj1nZYpw0f8DRAdP/aPekF8R1A99gf2ZNT8q0zWJEEZhI/h3u/pcqfWEtX6aixwCJdoAq6O7XDzlhQE/WLoAveE5yBhVQCj402KIYxApwNy00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717369048; c=relaxed/simple;
	bh=EiaLHBODJuYrDX6BIt3QTSlA7ft24fZ6bGFXe53J1Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u3aI6u3pzaJmRAZT/BBs/+3F7oBp+ZmvhCHo/dqB4N1qQXV8DoYQzQA0+1X2lBwh0asispompWlv95fsjga6O6R8htHMO9NmQKr6oyTxIXN+ipPimXa1o4l/H9Jxx4QWyuk8Nhcl/TccRS9MxsG9dcUe7jvP/yyuN3lqBgeg8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QhVxKiBy; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717369042; x=1717973842; i=quwenruo.btrfs@gmx.com;
	bh=s5/IizPWL6tKqQqH+5G3A2kBiUJ2hfnvRv/DuU5Et2Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QhVxKiByyvKv0oq5aepH4b2O/wuMJHv/D20AsG9OcGQjMS2t2E0Rx6umi6zViK2T
	 zcG/x8fEV8I3d9Tn1yxmRNPXOIhKPlOdLd13A+EvPQBhxlVBigIAxZeg7Mx4sybJX
	 YalvzyoxKd4/Fwrjckj8UR8AV1It63XgbgOfCahvLX8k0njlL6PVhkUndXabJ4S3P
	 S6FUhyGNE2qzpu9RKuefMkxPhvZ18YzSzwSk8ZIGFeCIjoi2WLWTu6WkSpXe8VNf7
	 bor5o8MARLD392l08ow+rV0Zdw+RTu4CdPcNEL37WIjMLvqycoUL/hRXUgvwW3mea
	 7BHtkqEaysqnw0zgEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhU9Z-1sjNKr0MkN-00hwAs; Mon, 03
 Jun 2024 00:57:22 +0200
Message-ID: <fc0ae1a1-7459-46e7-a34d-43b27ce0c7ca@gmx.com>
Date: Mon, 3 Jun 2024 08:27:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: several GB freespace missing
To: Bhasker C V <bhasker@unixindia.com>, linux-btrfs@vger.kernel.org
References: <CAPLCSGAAUMp4-xhcJ3hdFU1HCR-Uf+9q_i7OMr7Zpb+ybTRg0Q@mail.gmail.com>
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
In-Reply-To: <CAPLCSGAAUMp4-xhcJ3hdFU1HCR-Uf+9q_i7OMr7Zpb+ybTRg0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KT+NZY95b29xQpaGP8wd5oAPldsEUHAbYOaPY15gkZ8jI0uK7/B
 HiiDN3npHaJTcqxXGSZ5FVLimrKtj4VjAMSxCfSbVhAWWBjLTvMzMDMO3vSoF34fDGXuerR
 9YRg1IZasv3mZdGZnLGHQKu8F3tsJ9vCFDEkOqFVrUlBwG9WYuG8BjVcei0hjNQhyQEaXa0
 ukeRvey06UGuuBAAMUXBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KRfv0lBL3E4=;B418vphkwBuM39moXMVghsSiIGk
 vlLV2KwRxs65HrfYj6KlWNbjqX8S6Z4G0bniMCefdiaM8CO5eMp+7elXNTRCJBZF7XxXDUbQk
 CjAgCI9ELed3l/xALy4dBSPKwRfFDMUEtgvoZMtYPqHAGtZkKQFdCdan3qlI1p1WeSzp0xkm7
 aL+0J306QN1FcGwMcvFkco/lx8RSqfwNN7Rg1dtrYjPTh8OKRofjaYtx9WROXpoj1opUxXhGI
 aIBXX83adMi4cABE90FqRYiBO/2vTLS5nK43yxuRd0C1GXQNHXh3pM+RQzM3XsqmDP4/nUjUP
 aHGLl1oJRIPgr/vGhcN+xmFyUqH/n2+ibt6qGIFR6mx2KLUsomsVrBdH5QWVaK36kK3RdNxxX
 w52DKMCcCdoIbm1Zmokk8+xIH6cASzF5bb3VvofbCO3vBn015WpLzWegI3rAcK+z/1L9n9vgH
 LVO6/dCK0OZ9q2TcxaaQwW1sJ0v0HTO7PDSSLfc8o4JVnRUF1/TU/4A8WBVDAT6TQWxwTUiKM
 1XrbrDHJg9PyqcPCTDeMEaKuA44Vbi1rbb1fNxoQVRrguAAF0WIFJhWc0l6JR83T3X/AS4I0g
 ESb6rB1vrGOSmv78DLqLaGyyrrg025CE6U7oZnKvUYaXlfJ79DqxaJc7zYNadxY05WxZ1hpai
 o90CVLCk/3x4tcPrWdqQm3jHrIatMqC/GlpMUqA2MFm1Z0ZWimQQKkf5Ibu18YjxwGejCvSCe
 ylhX8miEd64rne8dzH1VmgrRJHQ2K7z+YZs+I39GRSeVnhgC1Sk0WRTFLlKyj+Kyp1T/N4RFz
 ghYN3Yi9BSfCrj6fWUgZA9oTVPa34ArwKAe0HjK0hwfeU=



=E5=9C=A8 2024/6/3 03:53, Bhasker C V =E5=86=99=E9=81=93:
> Below is the status
>
>
> $ sudo btrfs fi df .
> Data, single: total=3D139.01GiB, used=3D136.63GiB
> System, DUP: total=3D32.00MiB, used=3D48.00KiB
> Metadata, DUP: total=3D1.00GiB, used=3D191.61MiB
> GlobalReserve, single: total=3D169.20MiB, used=3D0.00B
> $ sudo df -h .
> Filesystem                Size  Used Avail Use% Mounted on
> /dev/mapper/datafs        160G  138G   22G  87% /tmp/user/1000/data
> $ sudo du -hs .
> 90G     .
> $ sudo btrfs su li .

Please try "btrfs subvolume list -a" to list all subvolumes.

> $
>
> I have tried a btrfs balance with --dusage=3D90
> I have scrubbed the data
> I have done a full csum
>
> I am not sure how to recover from the 48GB discrepancy
>
> Please could someone tell me what is happening and how i can get back
> my disk space ?

Another possibility is related to the btrfs extent bookend behavior, can
waste a lot of space if the workload involves a lot of random small writes=
.

In that case you may want to defrag the fs.

Thanks,
Qu

>

