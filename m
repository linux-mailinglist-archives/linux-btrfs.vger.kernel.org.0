Return-Path: <linux-btrfs+bounces-11212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85444A250FD
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 01:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044263A433F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 00:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FF21EA90;
	Mon,  3 Feb 2025 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="C/p0Sbod"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AB7B673
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 00:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738543489; cv=none; b=HoBfRs9L3J6gHZcBTZY3IVPmEzVITJPngLOgEjSAUowtymynkJAty68Eybk0W15eCfYUSeSL1W3W1hRCZJm0CMDFbvDpmLtgFIcZ5dFiF+HoeZ8MjRQzZJtV5QfeTQrAizjD6XZbXCOIfzZ31lO9FkGZdI3cm4jxlCoovDIOx3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738543489; c=relaxed/simple;
	bh=Kii09fXTHnvypIdE/bUD+GAXS48AEuSmgbffXKLahVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YKFxkr0FCK8Y4COJs2G50iyVi+x7IIdV4+6WFwySBDwt/Z09NNBCWHLULx2SfYjJ8vbkOT2bOF5W3Rt3WUdA7fyyjTCp+hsu9OoPDbvwpu9odvc+qCcd/1ZVN+EgKxTd6WujKAJ4v20bmugY8csfbqBhk6hFBeyjyZdJU4AP97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=C/p0Sbod; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738543484; x=1739148284; i=quwenruo.btrfs@gmx.com;
	bh=Kii09fXTHnvypIdE/bUD+GAXS48AEuSmgbffXKLahVg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C/p0SbodMdH/jpvDhJFA0Dy/uv3ACPiC+wWoGJpoiVbaNV5rvJB6D8OqP6jkcTrK
	 /AWgyk5WOwTdDlh1G7vRHgk4TOrdNgQpp+O9XlQYBzUZUczVNH943sCY4nFjOAKmB
	 n/vGAu0wpXLvt2LWQ3PJb4F2sLON261dyjAL8YZ0+JoFocsc/Yxr15ShC/rf6fm3j
	 xRLQj99HF9mnyuEuV3VDPuf8LK86osre/sP6Grag3PA7eQrCB0qAnADplyTDbmxno
	 2UscUDiNI4Deimp2QmaYiF5si5TP1OW5s+/ZYAaqJdtwrryBay4KQx8KVHQpQLgEv
	 jb7VD1bLRtSWT9ImHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTzfG-1toCkA19DW-00SMOl; Mon, 03
 Feb 2025 01:44:44 +0100
Message-ID: <d300d923-ed8c-4671-9694-6850d8c9b572@gmx.com>
Date: Mon, 3 Feb 2025 11:14:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Converting RAID1 to single fails if RAID1 is missing device
To: Jeff Siddall <news@siddall.name>, linux-btrfs@vger.kernel.org
References: <2cb1d81e-12a8-4fb1-b3fc-e7e83d31e059@siddall.name>
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
In-Reply-To: <2cb1d81e-12a8-4fb1-b3fc-e7e83d31e059@siddall.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jyQ/W/AuILDfc7M5Qv0gPU2sz24+Eu9YIaJEG5g2RyhNH7LU0o/
 Vw5wFS26VCLeDMcPmTtOysjQPDJ8jraZoPII+Cl8NCikIvvryCt717UPhKkwtr/4DUbtdIg
 ctIkgDfQeJI8Rjxj55G3b+kW7NpqDqf281MXbT0xw/JJ+nACWuZjQrhminl8SIlbcJmidB2
 RJhspOuOEbnic9CfOZbPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oxubtdH3JAU=;o628yo6H3ExK/K+pHX+kIJUg9Wt
 59c5c5svvtwxLrU+KtvVpiMW4v35BksCrqKzqLLa7mRllkRhurXsbnlKzU98IZWhv7orUcDUx
 r4yLSGNrvsmLfcilIsqmzeDoGYin5wn80MwoXQozpNVAW+6zVCNa+qAx3ObjjL1Sk2mpzDaYh
 q9/Aw1dQtQgKflLIdhie77510EMyKLcir+z+b6t8pv202xfhIqbYMjeEKnpRED0LtKx9yWfI3
 oEBYh87D3u6sJYWg38lBMg9jD0yo8EKR6fx6Oh+wScWStTvhTJ8lWFh/5NgP5k387Ga7Ca6By
 69ldYCbaMe6O6GJj9WaRaLQgkuQwtvpbOQ63hsIw7FcQhXcs88TAXAml4izeZv4btpBy+yQEb
 pYLcJvxeKG9wKCTnKD9fpIeBUZK8m2DLr6KZb/th0YbCIEmiDjH1f1V2zEcJa6bbrcPRxF4Mp
 oAxc+eQ/kEKBfx/NiHzvJOSYiyobEXnkbb7AkLNMe84vkld4GapeNR15P3gRLW2akQFwg3wYE
 gMA4vL/sG9jEi6dOdnF/qTs7kQsFNyAdocMD5Lk9BiyUO2lyIFpTskajqOslVFzZTPOQ53ywH
 lsx1GaocbhWe14b5e2fAtQEoBdJ/yhVKS9mdAFlTGMV0ACTx7YX4yPfY7Pjl+5B8v1atFCaXV
 TQH2H+6vS9nakMwshBQI9/xws4qjPbd7gpN53dpTyCcO/+bkJpy9T9Yf1H04OLKetfYxY2dmy
 NnzNjwJxQKWuOYC1B9rzjpN/S+ELve2NJHbQPcqnafQkMa1I1A/x/7jGSqH28Qp1ICyI9Mewt
 ZQ8+LqXrbPE2vY951BpuaIrep5QfbnYJQOwPlqxq08EJ3b4VRx1OO+lMBd6/Txb5O6mZJgala
 YvJLdSfemnMrl3cW2h9annlqR+H2qR4IHpE406pm80ZZb4AYFGK9zzFKvMftEJY8WTODzOJEw
 tZ6rAhUpXWiBFUd0gESMTGsasCqXkWsdZ1Yh5nwmVTa37/T897+9nts+nQaI3+HmP2LN1ddQh
 8rtTrTB8Ou2Aw6Sf8eUoGGxLci04M5VakCxrK5f8qutjqs41EzM23lIyckcMxgIiQnzjK2LSA
 7CXe+4sJzZ1gv5OQRweyufs+LDNYrIAxDhOdJonqC/cpC7mnLuwSveZYKRTrOGk8fxaj6zsvJ
 C9GpIEriFa5/Mi04aP5tJtHFeK+1IboHGfHW+CW92uNrif6c+nQMwdqvNVMGRklOhGkgihD63
 K5TVYCr4EEZXdcv8kqVWnWU7wza4lgunQB9sDl+ILnLLUzE/6XYHsjGXsOsZhoQAAnnB+kkh9
 jYxNNZE5N/jGqmtBqWCAtmzAw==



=E5=9C=A8 2025/2/3 09:13, Jeff Siddall =E5=86=99=E9=81=93:
> After a device failed on RAID1 filesystem, an attempt to convert the
> online filesystem from RAID1 to single failed.=C2=A0 This isn't an uncom=
mon
> use case if the failed device isn't readily replaceable.
>
> The command ran was:
>
> btrfs balance start -f -sconvert=3Dsingle -mconvert=3Dsingle -
> dconvert=3Dsingle /mountpoint
>
> and the kernel logs were:
>
> kernel: BTRFS info (device nvme0n1p3): balance: start -dconvert=3Dsingle=
 -
> mconvert=3Ddup -sconvert=3Ddup
> kernel: BTRFS info (device nvme0n1p3): relocating block group
> 1222049267712 flags data|raid1
> kernel: BTRFS warning (device nvme0n1p3): chunk 1223123009536 missing 1
> devices, max tolerance is 0 for writable mount

This is not the chunk to be relocated. Considering the tolerance is only
0, meaning it's the newly created single chunk.

I tried locally, but failed to reproduce the same problem.

Mind to provide the following info:

- Kernel version
- Btrfs fi usage output
- Mount option of the fs

My major concern is, the failing devices is still considered online, but
will fail all read/write/flush commands.
(Btrfs only has read time repair, not failing device detection)

In that case, converting to single is the worst thing you can do, as it
will write metadata chunks into that failing devices, and lost everything.

The proper solution is to unmount the fs (if possible), remove the
failing device, then mount the fs in degraded mode, add replace the
missing device with a newer one.

Thanks,
Qu

> kernel: BTRFS: error (device nvme0n1p3) in write_all_supers:4370:
> errno=3D-5 IO failure (errors while submitting device barriers.)
> kernel: BTRFS info (device nvme0n1p3: state E): forced readonly
> kernel: BTRFS warning (device nvme0n1p3: state E): Skipping commit of
> aborted transaction.
> kernel: BTRFS: error (device nvme0n1p3: state EA) in
> cleanup_transaction:1992: errno=3D-5 IO failure
> kernel: BTRFS info (device nvme0n1p3: state EA): balance: ended with
> status: -5
>
> Either it should be made possible to convert a RAID1 device with a
> missing device to a single device filesystem without errors, or the
> command should return a message stating that it is not supported to
> convert RAID1 array with missing devices to a single.=C2=A0 Having the
> process fail and then going forced readonly is a significant failure on
> an otherwise working system.
>
>
>


