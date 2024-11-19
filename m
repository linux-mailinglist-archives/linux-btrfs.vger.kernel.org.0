Return-Path: <linux-btrfs+bounces-9766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B5F9D3118
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 00:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAE11F2348D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 23:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2FD1C578C;
	Tue, 19 Nov 2024 23:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ATn/j60g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CA1BD9F3
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732060483; cv=none; b=RQSDjW9MyWMffwx5vVuicSKRiVWyUoMA0+pLQIzsFXioig9bxNPW/GxRx3Ge4dLcTFrTf6FHvbEUIJGMWG6hbmmr1x1vbWgu5Zr6P8a+r2RQ5pXa3Szfex2sWCAcg3bn9sJvVajyLcpzPUXnATBhrvXYsKPQOlpx5lWmMJbzQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732060483; c=relaxed/simple;
	bh=WbNaxmQJJ0VumEyIK/0LDeDEXkVsI2w9B0/kVxI/7mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sFdhtLFYuS4KV0HLx1n7IC/ezAT5Y3H96x5CseQE2w3/vfCgpQjvfyBnmp2K450zdk5y6JJ630lGkTwki+n7Tomwgl0jQJ8fWTlCzz7SJ+5fGd0SYAVotvTtlMGlpMvZlvPuznQB+bznDWcwN9qSE5hxOY2HrGCFq041OfY9G0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ATn/j60g; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1732060430; x=1732665230; i=quwenruo.btrfs@gmx.com;
	bh=W6oZUr4JxkU2vQWW0ixz1csS+MZx1jFi1Zz1Lq3XqP0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ATn/j60g1/WcDd1UrnqHD94f5+3Se2lTenI0hri0gvsn1yK8bXsNAnRPhM4SBo/7
	 WbxwxY2h0Nus3xAJ9awWLR6i9pAx3DBmBScTNTc3aA8b9u+t3DS6pKWimjyP6DBan
	 bYX0AO1gRKqk+ACF/rQI+dNiXCUjLk0GdRZdMIXkQ41dikRt14dAOM6rHvcD5PJRs
	 JUKuJhrzNea08zc5BfjFekeNG33BOAWcK5sAoeBkPqRJQO7GdowzHqwKRPIAlO4WU
	 D+chC9sjJGd8M9GUH23QQnE4pKKN2n/jM2FqyZMBFaTUl9mMYFgG3OdFwLukFZZgA
	 rl8EPHOO2N3KpIj6Yw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2wGi-1tAFiT1sse-009tIa; Wed, 20
 Nov 2024 00:53:50 +0100
Message-ID: <3fc3f378-b241-4f34-9101-542ddb4e1a27@gmx.com>
Date: Wed, 20 Nov 2024 10:23:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mount forced read only
To: Matthew Jurgens <btrfs@edcint.co.nz>, linux-btrfs@vger.kernel.org
References: <e011fe62-5ac4-46d5-82fc-bc9e508f546a@edcint.co.nz>
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
In-Reply-To: <e011fe62-5ac4-46d5-82fc-bc9e508f546a@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DmhPp1pyxlLcaj8aprolKrJ33uX9j5rgJ/uiv/AcImW+J9LqkG3
 TX5TxzIuG/IE8tjIlupaJ+C+RV9WtWK0dqm5lGjL9FCtrloxA6VMsPDX++lxe8+FST5atis
 55qjKaZCkkFHfGLnPgWwMHM+QcvWOGV8z+t5G5tactyRDzT5q3tE5g97hSZkDzTK3W3ad3n
 X55XhOLiDZMP9xOPCuwlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jxVq3WS7Ggg=;l/dRkiNyMx5M5o80BA+EKc16W4v
 Wsv281DWj+jNrsjlRpBK/SM7LwLJxqPrEQjJENlxWwIDPOgNqb2LuTNGk5UOZFPXkSRFogqmE
 jdqlpsHi0QI4wImWCIaQdlxwenyT3Mc5TMZgG6zFt/xBbQFEtWbaYCAoD4YPkBUjW8MSq9Cvm
 X5s0DEyvdSXsL/jYeEwM2Ke3PFcTW2q4b93M+ZgB6CFpcBoQWft/8sTqLTaANM2a+ICaCStty
 2Bbjt6UvoB4NlmYc9nNkWzjdQWJmvhJud5putY4LfSAYuD49Ym1HgGAjBhOqLZt4oW0XHBOqd
 wEWxIbYt2RdHA+w2UD3/GEFVvqsFYE3lsNw6OD2LkJJHFbleNO7BUXSU6bY/OT12z2eWghzLA
 CrGxiXUY7yP3xfJSJBOkCci740KJY78vjYi8vNm/i3/5LIcEmLwsZtYQQb6dTCTp6NbEVKmlR
 xRUguBCcJ5qVKLQgsRYTngCtBXJ4LrpyCf3jxOHhuC4Nrt+CguVSsPtN/PqW8YP4c9uRwJBOd
 zhJpkjQ9Hzkk9bMBbUsaIuUo0ayzggTUK3dzOF+k3zGDfLh16MJAcaraYfhyKOiiXg+b6RgYQ
 d33uJpbuXcUW+4OvfXIIp2ZJskgzSffWS6w3miSddIGD9lojYqbD0VcFLnJB69Nu4jYWph0Z2
 cE+uT1qhQjccCaWDCtaCeehwb+/S+RiSYBlV7bLA7o4ohG8xbKnT/jHrd7LFwbk25AxOTWVO9
 zTF5+J+zhTtHHyo4qOrlfc7QI/HzyvsfHVLR8C9TIoz/Kj7Ms1r5dkg8Lqi0iffPr3msFy+La
 0yjoiFhGPXgk8E4N8jb0xJrO0zChBTVHFkDki7odS+2rZaJf9CnSg7NFzDXy2evmq+uPzRSf9
 1+o3G5UR1dsjK1jNmlRSUfgHCtxS3zQFDNFGtk7obyfqYa3C0H0wLmKBv



=E5=9C=A8 2024/11/20 09:48, Matthew Jurgens =E5=86=99=E9=81=93:
> I just got this log entry:
>
> Nov 19 23:18:52 gw kernel: BTRFS info (device sda state E): forced reado=
nly
>
> More log details at the bottom of this email.
>
> I ran a btrfs check /dev/sda
> Opening filesystem to check...
> Checking filesystem on /dev/sda
> UUID: 3adb6756-7cab-4a7a-a7d8-9ff119032ee5
> [1/8] checking log skipped (none written)
> [2/8] checking root items
> [3/8] checking extents
> [4/8] checking free space tree
> [5/8] checking fs roots
> [6/8] checking only csums items (without verifying data)
> [7/8] checking root refs
> [8/8] checking quota groups skipped (not enabled on this FS)
> found 6646243958784 bytes used, no error found
> total csum bytes: 6455962568
> total tree bytes: 35338289152
> total fs tree bytes: 27183267840
> total extent tree bytes: 1067270144
> btree space waste bytes: 4735375062
> file data blocks allocated: 6666601234432
>  =C2=A0referenced 6784612802560
>
> So I don't have an error on my filesystem?

Yes, your on-disk fs is fine

>
> Is there a likely cause for the error?

So far it looks like random memory corruption.

What's your kernel version? And more specific, is this an AMD laptop?
Recently there is a known regression of amd_sfh module that corrupts
random memory ranges:

https://bugzilla.redhat.com/show_bug.cgi?id=3D2314331

If so, please either blacklist that module or just update the kernel (I
guess you're also using Fedora?)


>
> Thanks
>
>
> More Log Details
> ------------------------------------------------------------------------=
----------------------------------
>
> Nov 19 23:18:50 gw kernel: page: refcount:4 mapcount:0
> mapping:0000000010f3e149 index:0x1386bc414 pfn:0xd6a020
> Nov 19 23:18:50 gw kernel: memcg:ffff8b4a32568000
> Nov 19 23:18:50 gw kernel: aops:btree_aops ino:1
> Nov 19 23:18:50 gw kernel: flags: 0x17ffffd000402e(referenced|uptodate|
> lru|private|writeback|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> Nov 19 23:18:50 gw kernel: raw: 0017ffffd000402e ffffe380f5a80708
> ffffe380f5a7f508 ffff8b48393b2338
> Nov 19 23:18:50 gw kernel: raw: 00000001386bc414 ffff8b5406396b40
> 00000004ffffffff ffff8b4a32568000
> Nov 19 23:18:50 gw kernel: page dumped because: eb page dump
> Nov 19 23:18:50 gw kernel: BTRFS critical (device sda): corrupt leaf:
> block=3D21469404938240 slot=3D85 extent bytenr=3D23657765560320 len=3D36=
864
> invalid data ref offset, have 48914611 expect aligned to 4096

The invavlid value 48914611 (0x2ea60b3) seems randomly corrupted for
several bytes.

> Nov 19 23:18:50 gw kernel: BTRFS info (device sda): leaf 21469404938240
> gen 1596849 total ptrs 176 free space 2555 owner 2
> Nov 19 23:18:50 gw kernel: #011item 0 key (23657762000896 168 12288)
> itemoff 16230 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1574104 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 276935019 offset 267468800 count 1
> Nov 19 23:18:50 gw kernel: #011item 1 key (23657762013184 168 32768)
> itemoff 16177 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1569938 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 272764156 offset 16515072 count 1
> Nov 19 23:18:50 gw kernel: #011item 2 key (23657762045952 168 36864)
> itemoff 16124 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1569938 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 272764156 offset 16646144 count 1
> Nov 19 23:18:50 gw kernel: #011item 3 key (23657762082816 168 32768)
> itemoff 16071 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1569938 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 272764156 offset 18481152 count 1
> Nov 19 23:18:50 gw kernel: #011item 4 key (23657762115584 168 36864)
> itemoff 16018 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1569938 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 272764156 offset 18612224 count 1
> Nov 19 23:18:50 gw kernel: #011item 5 key (23657762152448 168 36864)
> itemoff 15965 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1569938 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 272764156 offset 18743296 count 1
> Nov 19 23:18:50 gw kernel: #011item 6 key (23657762189312 168 32768)
> itemoff 15912 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1569938 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 272764156 offset 19529728 count 1
> Nov 19 23:18:50 gw kernel: #011item 7 key (23657762222080 168 77824)
> itemoff 15859 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287782138 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 8 key (23657762299904 168 77824)
> itemoff 15806 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287782201 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 9 key (23657762377728 168 73728)
> itemoff 15753 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287782327 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 10 key (23657762451456 168 77824)
> itemoff 15700 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287782390 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 11 key (23657762529280 168 77824)
> itemoff 15647 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287782451 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 12 key (23657762607104 168 73728)
> itemoff 15594 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287782609 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 13 key (23657762680832 168 90112)
> itemoff 15541 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287782808 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 14 key (23657762770944 168 94208)
> itemoff 15488 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287783009 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 15 key (23657762865152 168 45056)
> itemoff 15435 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287783334 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 16 key (23657762910208 168 36864)
> itemoff 15382 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287783539 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 17 key (23657762947072 168 65536)
> itemoff 15329 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287783750 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 18 key (23657763012608 168 53248)
> itemoff 15276 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287783969 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 19 key (23657763065856 168 49152)
> itemoff 15223 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287784082 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 20 key (23657763115008 168 45056)
> itemoff 15170 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287784280 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 21 key (23657763160064 168 65536)
> itemoff 15117 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287784434 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 22 key (23657763225600 168 32768)
> itemoff 15064 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287784749 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 23 key (23657763258368 168 69632)
> itemoff 15011 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287784890 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 24 key (23657763328000 168 32768)
> itemoff 14958 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287785098 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 25 key (23657763360768 168 28672)
> itemoff 14905 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287785208 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 26 key (23657763389440 168 90112)
> itemoff 14852 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287785291 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 27 key (23657763479552 168 81920)
> itemoff 14799 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287785512 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 28 key (23657763561472 168 86016)
> itemoff 14746 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586595 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287785726 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 29 key (23657763647488 168 32768)
> itemoff 14693 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287785973 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 30 key (23657763680256 168 28672)
> itemoff 14640 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287786085 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 31 key (23657763708928 168 32768)
> itemoff 14587 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287786140 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 32 key (23657763741696 168 86016)
> itemoff 14534 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287786250 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 33 key (23657763827712 168 94208)
> itemoff 14481 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287786487 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 34 key (23657763921920 168 90112)
> itemoff 14428 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287786752 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 35 key (23657764012032 168 77824)
> itemoff 14375 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287787031 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 36 key (23657764089856 168 32768)
> itemoff 14322 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287787557 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 37 key (23657764122624 168 28672)
> itemoff 14269 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1586596 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 287789874 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 38 key (23657764151296 168 4096)
> itemoff 14216 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1574563 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 277549110 offset 19316736 count 1
> Nov 19 23:18:50 gw kernel: #011item 39 key (23657764155392 168 8192)
> itemoff 14163 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1570122 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 273112727 offset 182415360 count 1
> Nov 19 23:18:50 gw kernel: #011item 40 key (23657764163584 168 32768)
> itemoff 14110 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1569938 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 272764156 offset 19660800 count 1
> Nov 19 23:18:50 gw kernel: #011item 41 key (23657764196352 168 4096)
> itemoff 14057 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1574563 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 277549110 offset 20819968 count 1
> Nov 19 23:18:50 gw kernel: #011item 42 key (23657764200448 168 4096)
> itemoff 14004 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567638 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271044871 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 43 key (23657764204544 168 4096)
> itemoff 13951 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567638 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271044887 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 44 key (23657764208640 168 4096)
> itemoff 13898 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567638 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271044907 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 45 key (23657764212736 168 20480)
> itemoff 13845 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567638 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271045046 offset 131072 count 1
> Nov 19 23:18:50 gw kernel: #011item 46 key (23657764233216 168 4096)
> itemoff 13792 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568067 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271899587 offset 0 count 1
> Nov 19 23:18:50 gw kernel: #011item 47 key (23657764237312 168 36864)
> itemoff 13739 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271904370 offset 524288 count 1
> Nov 19 23:18:50 gw kernel: #011item 48 key (23657764274176 168 36864)
> itemoff 13686 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271904370 offset 655360 count 1
> Nov 19 23:18:50 gw kernel: #011item 49 key (23657764311040 168 36864)
> itemoff 13633 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271904370 offset 786432 count 1
> Nov 19 23:18:50 gw kernel: #011item 50 key (23657764347904 168 36864)
> itemoff 13580 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271904370 offset 917504 count 1
> Nov 19 23:18:50 gw kernel: #011item 51 key (23657764384768 168 36864)
> itemoff 13527 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271904370 offset 6422528 count 1
> Nov 19 23:18:50 gw kernel: #011item 52 key (23657764421632 168 36864)
> itemoff 13474 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271904370 offset 6553600 count 1
> Nov 19 23:18:50 gw kernel: #011item 53 key (23657764458496 168 36864)
> itemoff 13421 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271904370 offset 6684672 count 1
> Nov 19 23:18:50 gw kernel: #011item 54 key (23657764495360 168 36864)
> itemoff 13368 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271904370 offset 9043968 count 1
> Nov 19 23:18:50 gw kernel: #011item 55 key (23657764532224 168 28672)
> itemoff 13315 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1568069 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271904370 offset 75894784 count 1
> Nov 19 23:18:50 gw kernel: #011item 56 key (23657764560896 168 36864)
> itemoff 13262 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 9043968 count 1
> Nov 19 23:18:50 gw kernel: #011item 57 key (23657764597760 168 32768)
> itemoff 13209 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 9175040 count 1
> Nov 19 23:18:50 gw kernel: #011item 58 key (23657764630528 168 32768)
> itemoff 13156 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 9306112 count 1
> Nov 19 23:18:50 gw kernel: #011item 59 key (23657764663296 168 32768)
> itemoff 13103 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 12271616 count 1
> Nov 19 23:18:50 gw kernel: #011item 60 key (23657764696064 168 36864)
> itemoff 13050 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 12402688 count 1
> Nov 19 23:18:50 gw kernel: #011item 61 key (23657764732928 168 36864)
> itemoff 12997 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 12533760 count 1
> Nov 19 23:18:50 gw kernel: #011item 62 key (23657764769792 168 36864)
> itemoff 12944 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 15417344 count 1
> Nov 19 23:18:50 gw kernel: #011item 63 key (23657764806656 168 36864)
> itemoff 12891 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 15548416 count 1
> Nov 19 23:18:50 gw kernel: #011item 64 key (23657764843520 168 32768)
> itemoff 12838 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 15679488 count 1
> Nov 19 23:18:50 gw kernel: #011item 65 key (23657764876288 168 32768)
> itemoff 12785 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 20135936 count 1
> Nov 19 23:18:50 gw kernel: #011item 66 key (23657764909056 168 36864)
> itemoff 12732 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 20267008 count 1
> Nov 19 23:18:50 gw kernel: #011item 67 key (23657764945920 168 36864)
> itemoff 12679 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 20398080 count 1
> Nov 19 23:18:50 gw kernel: #011item 68 key (23657764982784 168 36864)
> itemoff 12626 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 23547904 count 1
> Nov 19 23:18:50 gw kernel: #011item 69 key (23657765019648 168 32768)
> itemoff 12573 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 23678976 count 1
> Nov 19 23:18:50 gw kernel: #011item 70 key (23657765052416 168 32768)
> itemoff 12520 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 23810048 count 1
> Nov 19 23:18:50 gw kernel: #011item 71 key (23657765085184 168 36864)
> itemoff 12467 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 26693632 count 1
> Nov 19 23:18:50 gw kernel: #011item 72 key (23657765122048 168 32768)
> itemoff 12414 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 26824704 count 1
> Nov 19 23:18:50 gw kernel: #011item 73 key (23657765154816 168 32768)
> itemoff 12361 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 26955776 count 1
> Nov 19 23:18:50 gw kernel: #011item 74 key (23657765187584 168 36864)
> itemoff 12308 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 30363648 count 1
> Nov 19 23:18:50 gw kernel: #011item 75 key (23657765224448 168 32768)
> itemoff 12255 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 30494720 count 1
> Nov 19 23:18:50 gw kernel: #011item 76 key (23657765257216 168 32768)
> itemoff 12202 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 30625792 count 1
> Nov 19 23:18:50 gw kernel: #011item 77 key (23657765289984 168 32768)
> itemoff 12149 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 34557952 count 1
> Nov 19 23:18:50 gw kernel: #011item 78 key (23657765322752 168 36864)
> itemoff 12096 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 34689024 count 1
> Nov 19 23:18:50 gw kernel: #011item 79 key (23657765359616 168 32768)
> itemoff 12043 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 34820096 count 1
> Nov 19 23:18:50 gw kernel: #011item 80 key (23657765392384 168 36864)
> itemoff 11990 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 37703680 count 1
> Nov 19 23:18:50 gw kernel: #011item 81 key (23657765429248 168 32768)
> itemoff 11937 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 37834752 count 1
> Nov 19 23:18:50 gw kernel: #011item 82 key (23657765462016 168 32768)
> itemoff 11884 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 37965824 count 1
> Nov 19 23:18:50 gw kernel: #011item 83 key (23657765494784 168 32768)
> itemoff 11831 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 44589056 count 1
> Nov 19 23:18:50 gw kernel: #011item 84 key (23657765527552 168 32768)
> itemoff 11778 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 271067522 offset 48783360 count 1
> Nov 19 23:18:50 gw kernel: #011item 85 key (23657765560320 168 36864)
> itemoff 11725 itemsize 53
> Nov 19 23:18:50 gw kernel: #011#011extent refs 1 gen 1567646 flags 1
> Nov 19 23:18:50 gw kernel: #011#011ref#0: extent data backref root 5
> objectid 2017612633333049730 offset 48914611 count 1

Furthermore, the objectid is also too large for its higher bits.

Considering both the lower bits of offset and the higher bits of the
obejctid is corrupted, it looks like the corruption range is covering them=
.

And none of them is the typical bitflips, thus I'm wondering if it's the
amd_sfh driver screwing up things.

And thankfully btrfs' tree-checker sanity checks are catching such
errors before writing them to the disk, thus your fs is still fine.

But still I'd recommend a scrub or "btrfs check --check-data-csum" to
also verify the data checksum, just in case.

Thanks,
Qu


