Return-Path: <linux-btrfs+bounces-10023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A60D9E15D5
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 09:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78BDB29E8F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 08:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1899E1B6CE5;
	Tue,  3 Dec 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Hy3t6I1D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F913156F45
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733213793; cv=none; b=Yz3H5xvaaLbIdYon0qOEU8pDP6NJOpHmyJPL1G2OCEze0Non+M1YtLHXX81Nm9yKzS+w1yhtABblmyLJ44q/jIjmq9DhYc6w6ipPzm0DJVPiJxSk8mU8G7Pr5mrIKc2jDgd+kYwjpHRy+Ir3C6CGRNN79dizIZAHuc3BD2tuiAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733213793; c=relaxed/simple;
	bh=dZuEIUD170RTWzgOJjtLzeY1Qta4rd3iPRvV7LZaYjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EQLCviTmHIK1NOAZTi4O5khAO9BHUvSVGOcJ8RwPcYdLevOc4/hl4zihLjr2gNJ9I34gId8Dd3G3pIplrBq/irElvIp5M9dHEINyqe9u3mw2NX8ajyXguApNJ9dlR3LaDruuC8sTHWt63R8kiRTMVLfayqFZNUc9edv0513p5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Hy3t6I1D; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733213788; x=1733818588; i=quwenruo.btrfs@gmx.com;
	bh=Piw0tfq+RXk80+/a5FgrQ1V8LByxXDKOk935G47Z24k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Hy3t6I1DfEL70TJA+PjZxDLdEpjMg39grCqRBXdx47/ZZb0fTAYWPDa9vmtfiZMm
	 AIn7+EeB0Wia8qY+wyn42B2QUenwa53TlANAd7a0UkoBQt4zqmY94eHdNplCvweeS
	 tYfI94JfknrNifeVLctXWQq+Oskt4WLgbG85iNu/0e06GOHWol3NGS0pJkhdu6LTv
	 0RXpkIg70NoOoc0I7onELm9b3+VEeId4ufK0V7sMre7N0OpAD7RUoCu10lCbMGkgk
	 6b+V9VQ3U3I+BzT42qOoxLgDaSzg9PemiXE+rPV0ImV3jn7wLHqyTOWl4hjuDn4TE
	 0yzfQst5PxxdIrvGZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBDjA-1tNHu60Sa6-002oQ2; Tue, 03
 Dec 2024 09:16:28 +0100
Message-ID: <8276d833-d4f2-42dd-8190-c98265896ee3@gmx.com>
Date: Tue, 3 Dec 2024 18:46:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Balance failed with tree block error
To: Neil Parton <njparton@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAAYHqBbMeLYXdhNondp8JwQCsp-n1cCvnAubS3f2FxD6PBOEsQ@mail.gmail.com>
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
In-Reply-To: <CAAYHqBbMeLYXdhNondp8JwQCsp-n1cCvnAubS3f2FxD6PBOEsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AXhPZLXOtZrN9n40L40lM4mo87B33nGNIqd1LmG3qK4eIUlrzMb
 1Nmdt7I0RuI4wQ81LvJVlIfDuHctU9VdZMhuW9cTAs2otO69Pib00kv59S7iulfO5r1cp4G
 zbrDIvJmA5yR6BgTNJr2PhuoqFXYO081jp/1S0Df3u28xhFtHeBuDxKd8rINqO/yx15mCxt
 jY2lishKGd847Coa3kNXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+mNAyuOEfWI=;RA35qf7dcd3FtatzRY0/DaqeXLA
 /4qy62DfO/8UdOQn4Yp5OV1hBhXl2DquKsFmdf3va7bCuVzOjQ6cPuO3XfBuuiz+M+H4edu6r
 Z96LQnUAe2SxeDhmUiFzAuFXx4PNIetB3TGtYeIeMW5zFk0vjRfqEvkXXiGMLi+PRQ7N6GIdX
 djQgtr7pJs/aH3S2mrdmiqVNx7aYxd8AJMfhtRyo+HMxb486czEq3MyiAJgDqRZA9OlMVVkyW
 /oHnupxj9GY9j3qAS3eb+k/OkIWAS84IkpgFnUWgpikjuI6uXk41Be3Hz4D644WDs+fySu7hB
 DsSmuXFDuCHcfXZK4TxXb8Y/L+V21Amxfs5dA2pPIKROhB/Gxl3ci497atDygagCHWWYRAk6S
 jLrC4FHq3tjrfCmmjLctMkLTnBH/1LHLAjzrAsdGlnETfRa9CxorPo1fnz+hoChx/XUHIeRuh
 O7On3n9Vw+IH6CX6vQAxy2YOgS7Os/1Gvw+zOysN1Tu/VqO2y9Ia6Kxv9glBYojtm6o5V/mjX
 g8xsCuRE1TzvXJQ0KED+Yp0FvF2r1b5hKgnGuu1XFPDuTtcNNXWJHk8lAojUo6csS50lVWrig
 WkJecTAoW9qMusLlLYiqbr+ZNb7bDn/VQownAP/jVh0xIgy0H1oWoPWA9BtQUubPXJswminUe
 jMx98aXeXf+bsQJk5mwR40AbVT++8Qj2rK5s1rFteFHV+uZgBi2gcdVS+Sl4jknLGsqog+qnf
 0Kh1DhI45R+eHpDbxvYbHb+eySY7NpPFEi6PLcC5ArSqpA2jeHZANLmkZwcUyGC76UfdvZqBB
 Cq+oK5r2jsnXnhfnEK3mKjP2LPAlhcBN6gSZZIwyc3TTagXhAJellj/yYhUZB3vsyMxxeFx1/
 eCaKLJf11tHmTSfr3PO9rxF/uSsji5NTBGZJt+Tj0kmh1NVCiYvkBlQf1rBPokazWMHl/QLCq
 hTstPmel64zu2wVMXg7QeFU9vf8w1Npq7B4drjp2ey4K0SLiwruvGzMicFKdkusXExt8vopwj
 Y/9VQv1trtac0JHNm0YFIa75ItiM+zx1mzDgectTr9vTDfwxV1ufJwPLIjNC9qaBP7WEOGGjw
 4nKaWnjq0JY3lBU0uSUI4CS5DYuQPx



=E5=9C=A8 2024/12/3 18:41, Neil Parton =E5=86=99=E9=81=93:
> Arch Linux kernel 6.6.63-1-lts, btrfs-progs 6.12-1
>
> Yesterday I added a 5th drive to an existing raid 1 array (raid1c3
> metadata) and overnight it failed after a few percent complete.  btrfs
> stats are all zero and there are no SMART errors on any of the 5
> drives.
>
> dmesg shows the following:
>
> $ sudo dmesg | grep btrfs
> [16181.905236] WARNING: CPU: 0 PID: 23336 at
> fs/btrfs/relocation.c:3286 add_data_references+0x4f8/0x550 [btrfs]
> [16181.905347]  spi_intel xhci_pci_renesas drm_display_helper video
> cec wmi btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel
> xor raid6_pq
> [16181.905354] CPU: 0 PID: 23336 Comm: btrfs Tainted: G     U
>     6.6.63-1-lts #1 1935f30fe99b63e43ea69e5a59d364f11de63a00
> [16181.905358] RIP: 0010:add_data_references+0x4f8/0x550 [btrfs]
> [16181.905431]  ? add_data_references+0x4f8/0x550 [btrfs
> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> [16181.905488]  ? add_data_references+0x4f8/0x550 [btrfs
> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> [16181.905551]  ? add_data_references+0x4f8/0x550 [btrfs
> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> [16181.905601]  ? add_data_references+0x4f8/0x550 [btrfs
> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> [16181.905654]  relocate_block_group+0x336/0x500 [btrfs
> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> [16181.905705]  btrfs_relocate_block_group+0x27c/0x440 [btrfs
> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> [16181.905755]  btrfs_relocate_chunk+0x3f/0x170 [btrfs
> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> [16181.905811]  btrfs_balance+0x942/0x1340 [btrfs
> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> [16181.905866]  btrfs_ioctl+0x2388/0x2640 [btrfs
> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>
> and
>
> $ sudo dmesg | grep BTRFS
> <deleted lots of repetitive lines for brevity>
> [16162.080878] BTRFS info (device sdd): relocating block group
> 338737521229824 flags data|raid1
> [16175.051355] BTRFS info (device sdd): found 5 extents, stage: move
> data extents
> [16180.023748] BTRFS info (device sdd): found 5 extents, stage: update
> data pointers
> [16181.904523] BTRFS info (device sdd): leaf 328610877177856 gen
> 12982316 total ptrs 206 free space 627 owner 2
> [16181.905206] BTRFS error (device sdd): tree block extent item
> (332886134538240) is not found in extent tree

There is a leaf dump, please paste the full dmesg, or we can not be sure
what the cause is.

Although I guess it may be a memory bitflip, considering all the past
experience.

So after pasting the full dmesg, you may also want to do a full memtest
just in case.

Thanks,
Qu

> [16183.091659] BTRFS info (device sdd): balance: ended with status: -22
>
> What course of action should I take so that the balance completes next t=
ime?
>
> Many thanks
>
> Neil
>


