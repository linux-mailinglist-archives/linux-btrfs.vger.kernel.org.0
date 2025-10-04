Return-Path: <linux-btrfs+bounces-17437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A466FBB9285
	for <lists+linux-btrfs@lfdr.de>; Sun, 05 Oct 2025 00:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 468834E7CA1
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Oct 2025 22:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0544D244685;
	Sat,  4 Oct 2025 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="d72Di+T/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3427B2222C8
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Oct 2025 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759617727; cv=none; b=M+nBqq/pI18850vgx4J6/GipBwCBTJdr1zyk793l11pYnvZgbOOc2M6xmjedF6RIsSfLbulmkmJj6oAMxSsF5UIQft536JKaGpz3CBZRsuckJl+Sxfa7PFLpgTWUJhy8YkmB8xWV/mXe0cdj4dEwBIRM8lGApnAW4bvGwy4PkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759617727; c=relaxed/simple;
	bh=mHn8OtMZoWGliP+qVBSZy5hko2cqbPRHn7o1u2P2JcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Chf6qt0GvAJbRrJfrPGMS2jio/wf8+KmnL9Tr8WGTTDF4Bf1oW03jgx1c7GKLxFBz8rgC/rI+L6c0gRxbVLp01Wmh62U821dLaGN1yRNdz+FwjIUjBPgOOkJGUtd0kSI5qTi5x+pyZ19Vm5/tHlMfkJ6JVhlTkPn+7dL30RKIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=d72Di+T/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759617720; x=1760222520; i=quwenruo.btrfs@gmx.com;
	bh=mHn8OtMZoWGliP+qVBSZy5hko2cqbPRHn7o1u2P2JcY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=d72Di+T/HcjlbAqCqF+AJEfbwB2BpW3C76s+Cn419jM/IT1un9srUqx5Z5755wK4
	 37GsIRQcP21WxkZFIJGMQ2cF/G5hQzQIdEOWVMl0OO+sENS3Vt0x1g+VK1Gwkpg6M
	 ppJimx2Lj0KvC3cKPUC3mYVcxcDo1bTD7s0xGa5K9VoSbwFLR8HjwjAH4tktgPzbW
	 ExwaqA2lzlTjv0TIETii6jmQ5QjKH4iQ/ZU5EqEHpMKsatZc4pSmY+q8mux1kI/K/
	 peLsT2/5P4wk2L6QtGnE3+ktK5RCdPNjKZHXuhTNKc/QNm0Lb/30bWBkWVnCUm2TH
	 WLoQ0RFb929LJ2OwMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzjt-1ulABK0eef-00IfyQ; Sun, 05
 Oct 2025 00:42:00 +0200
Message-ID: <2836fb95-a819-43fd-913e-a7c7f7741665@gmx.com>
Date: Sun, 5 Oct 2025 09:11:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to remove an unremovable file and directory?
To: =?UTF-8?Q?Henri_Hyyryl=C3=A4inen?= <henri.hyyrylainen@gmail.com>,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <33570321-604e-4830-843a-4ed839dfbe83@gmail.com>
 <e7aefcaf-ecb5-492d-9ced-a9b846813bd6@suse.com>
 <5d0cde2f-441e-4007-a6b6-e2aa951befa2@gmail.com>
 <b6273125-86fb-443b-9b2d-3430594f0152@suse.com>
 <f2b72e44-9134-4cc5-99b0-fb51c2673cde@suse.com>
 <afea5a6c-96a6-4928-aa63-275a6c8f8030@gmail.com>
 <4cda86a1-6012-4200-91a0-9087eb9472da@suse.com>
 <09f5019c-650f-4839-8fea-a3c9eb6a9889@gmail.com>
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
In-Reply-To: <09f5019c-650f-4839-8fea-a3c9eb6a9889@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ROg00rjfdvXhBVVBvOiEqRfy9Q4Ewtc2lmGAWYYNOwODnCisnkm
 ZdgmC+gOGhA3k12jsBqubWfEj24OK+HxH74LtZXPHKprBbIyjt1fGGLI0US+irNVHzqeStl
 giNi+iTOVmR6c03ubqIlTvUYYLZSHu1Ap1WERxRnTrmZjdvE+cSBlZJgFkTIl6oS0DXgGeh
 oYDCQ98PU8vEVGgNe+3/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Md+RKfwi6gI=;CoDcR7EBZTKIyqW1AzpL805pqol
 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
 lvCBttHeJepsINtLI=



=E5=9C=A8 2025/10/5 09:06, Henri Hyyryl=C3=A4inen =E5=86=99=E9=81=93:
> Thanks for the command.
>=20
> I tried reading through the data but I could not determine if there was=
=20
> any information related to scrub or balance status.

It's fine. No persistent item for balance/dev-replace. So it's not involve=
d.

Waiting for the readonly check result.

And meanwhile, please prepare an environment to compile btrfs-progs.

If there is only one stray dev extent, I'll create a simple dirty fix so=
=20
that you can mount the fs again.

Thanks,
Qu

>=20
> Here's the full output I got:
>=20
>> btrfs-progs v6.16.1
>> root tree
>> leaf 227587769614336 items 61 free space 3547 generation 2035509 owner=
=20
>> ROOT_TREE
>> leaf 227587769614336 flags 0x1(WRITTEN) backref revision 1
>> fs uuid 2b4ad16d-e456-4adf-960b-dca43560b98b
>> chunk uuid 0e317678-73cc-4485-ab6b-987285e19681
>> =C2=A0 =C2=A0 item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsi=
ze 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2035509 root_dirid 0 bytenr 2275=
87769630720=20
>> byte_limit 0 bytes_used 3319316480
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 0 flags 0x0(none) refs 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2035509
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 00000000-0000-0000-0000-000000000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid 00000000-0000-0000-0000-0000000=
00000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 0 otransid 0 stransid 0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15405 itemsize =
439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025974 root_dirid 0 bytenr 2275=
94196631552=20
>> byte_limit 0 bytes_used 21889024
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 0 flags 0x0(none) refs 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 2 generation_v2 2025974
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 00000000-0000-0000-0000-000000000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid 00000000-0000-0000-0000-0000000=
00000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 0 otransid 0 stransid 0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 2 key (FS_TREE INODE_REF 6) itemoff 15388 itemsize 1=
7
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 index 0 namelen 7 name: default
>> =C2=A0 =C2=A0 item 3 key (FS_TREE ROOT_ITEM 0) itemoff 14949 itemsize 4=
39
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025975 root_dirid 256 bytenr 22=
7573939142656=20
>> byte_limit 0 bytes_used 6603997184
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025951 flags 0x0(none) refs =
1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025975
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid 00000000-0000-0000-0000-0000000=
00000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025953 otransid 0 stransid 0 rtra=
nsid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759258850.523837328 (2025-09-30 22:0=
0:50)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1679586168.0 (2023-03-23 17:42:48)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 4 key (FS_TREE ROOT_REF 256) itemoff 14921 itemsize =
28
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 256 sequence 6 name .sna=
pshots
>> =C2=A0 =C2=A0 item 5 key (ROOT_TREE_DIR INODE_ITEM 0) itemoff 14761 ite=
msize 160
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 3 transid 0 size 0 nbytes 16384
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 block group 0 mode 40755 links 1 uid 0 gid =
0 rdev 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 sequence 0 flags 0x0(none)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 atime 1679586169.0 (2023-03-23 17:42:49)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1679586169.0 (2023-03-23 17:42:49)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 mtime 1679586169.0 (2023-03-23 17:42:49)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1679586169.0 (2023-03-23 17:42:49)
>> =C2=A0 =C2=A0 item 6 key (ROOT_TREE_DIR INODE_REF 6) itemoff 14749 item=
size 12
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 index 0 namelen 2 name: ..
>> =C2=A0 =C2=A0 item 7 key (ROOT_TREE_DIR DIR_ITEM 2378154706) itemoff 14=
712=20
>> itemsize 37
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 location key (FS_TREE ROOT_ITEM 18446744073=
709551615) type DIR
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 transid 0 data_len 0 name_len 7
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: default
>> =C2=A0 =C2=A0 item 8 key (CSUM_TREE ROOT_ITEM 0) itemoff 14273 itemsize=
 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025954 root_dirid 0 bytenr 2275=
88044062720=20
>> byte_limit 0 bytes_used 49791238144
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 0 flags 0x0(none) refs 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025954
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 00000000-0000-0000-0000-000000000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid 00000000-0000-0000-0000-0000000=
00000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 0 otransid 0 stransid 0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 9 key (UUID_TREE ROOT_ITEM 0) itemoff 13834 itemsize=
 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025954 root_dirid 0 bytenr 2275=
87802447872=20
>> byte_limit 0 bytes_used 16384
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 0 flags 0x0(none) refs 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 0 generation_v2 2025954
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 00000000-0000-0000-0000-000000000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid 00000000-0000-0000-0000-0000000=
00000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 0 otransid 0 stransid 0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 10 key (256 ROOT_ITEM 0) itemoff 13395 itemsize 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025954 root_dirid 256 bytenr 22=
7587802316800=20
>> byte_limit 0 bytes_used 49152
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2015386 flags 0x0(none) refs =
1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 1 generation_v2 2025954
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 56f85f76-1eb8-1245-a35b-8a9307d5c68f
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid 00000000-0000-0000-0000-0000000=
00000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025954 otransid 31 stransid 0 rtr=
ansid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759260258.238143629 (2025-09-30 22:2=
4:18)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1679588253.995834574 (2023-03-23 18:1=
7:33)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 11 key (256 ROOT_BACKREF 5) itemoff 13367 itemsize 2=
8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 256 sequence 6 name =
.snapshots
>> =C2=A0 =C2=A0 item 12 key (256 ROOT_REF 14428) itemoff 13341 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28589 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 13 key (256 ROOT_REF 14451) itemoff 13315 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28635 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 14 key (256 ROOT_REF 14475) itemoff 13289 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28683 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 15 key (256 ROOT_REF 14499) itemoff 13263 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28731 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 16 key (256 ROOT_REF 14523) itemoff 13237 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28779 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 17 key (256 ROOT_REF 14547) itemoff 13211 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28827 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 18 key (256 ROOT_REF 14559) itemoff 13185 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28851 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 19 key (256 ROOT_REF 14583) itemoff 13159 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28899 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 20 key (256 ROOT_REF 14607) itemoff 13133 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28947 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 21 key (256 ROOT_REF 14631) itemoff 13107 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28995 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 22 key (256 ROOT_REF 14640) itemoff 13081 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 29013 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 23 key (256 ROOT_REF 14641) itemoff 13055 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 29015 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 24 key (256 ROOT_REF 14642) itemoff 13029 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 29017 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 25 key (256 ROOT_REF 14643) itemoff 13003 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 29019 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 26 key (256 ROOT_REF 14644) itemoff 12977 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 29021 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 27 key (256 ROOT_REF 14645) itemoff 12951 itemsize 2=
6
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 29023 sequence 2 name sn=
apshot
>> =C2=A0 =C2=A0 item 28 key (14428 ROOT_ITEM 1849346) itemoff 12512 items=
ize 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025978 root_dirid 256 bytenr 71=
398781173760=20
>> byte_limit 0 bytes_used 8815476736
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2018745 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025978
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 97cd122d-c519-8746-bdfe-13479bfefb9d
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 1849346 otransid 1849346 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1758406304.841464812 (2025-09-21 01:1=
1:44)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1758406304.840394467 (2025-09-21 01:1=
1:44)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 29 key (14428 ROOT_BACKREF 256) itemoff 12486 itemsi=
ze 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28589 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 30 key (14451 ROOT_ITEM 1899154) itemoff 12047 items=
ize 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025981 root_dirid 256 bytenr 71=
398809468928=20
>> byte_limit 0 bytes_used 6747799552
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2018745 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025981
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid c5e2ba38-c982-8a4f-99e5-bb9ff8c5f7cd
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 1897416 otransid 1899154 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1758484800.817458724 (2025-09-21 23:0=
0:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1758488400.101635440 (2025-09-22 00:0=
0:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 31 key (14451 ROOT_BACKREF 256) itemoff 12021 itemsi=
ze 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28635 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 32 key (14475 ROOT_ITEM 1942246) itemoff 11582 items=
ize 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025984 root_dirid 256 bytenr 71=
398831259648=20
>> byte_limit 0 bytes_used 6755549184
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2018745 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025984
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 38b9ea09-54ef-5140-bddc-83dc884c31b3
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 1940067 otransid 1942246 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1758570000.151997903 (2025-09-22 22:4=
0:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1758574800.777676964 (2025-09-23 00:0=
0:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 33 key (14475 ROOT_BACKREF 256) itemoff 11556 itemsi=
ze 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28683 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 34 key (14499 ROOT_ITEM 1977241) itemoff 11117 items=
ize 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025986 root_dirid 256 bytenr 71=
398873153536=20
>> byte_limit 0 bytes_used 6538182656
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2018745 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025986
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 703f0298-831b-1e4d-b1f1-fc37ff582770
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 1977241 otransid 1977241 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1758661201.518446292 (2025-09-24 00:0=
0:01)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1758661204.161207119 (2025-09-24 00:0=
0:04)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 35 key (14499 ROOT_BACKREF 256) itemoff 11091 itemsi=
ze 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28731 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 36 key (14523 ROOT_ITEM 2001507) itemoff 10652 items=
ize 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025988 root_dirid 256 bytenr 71=
398873497600=20
>> byte_limit 0 bytes_used 6561398784
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2018745 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025988
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 9672abd0-7e7b-ab4f-9e0f-7183e58bb6c4
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2001507 otransid 2001507 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1758747600.712874426 (2025-09-25 00:0=
0:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1758747600.840460363 (2025-09-25 00:0=
0:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 37 key (14523 ROOT_BACKREF 256) itemoff 10626 itemsi=
ze 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28779 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 38 key (14547 ROOT_ITEM 2017206) itemoff 10187 items=
ize 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025990 root_dirid 256 bytenr 71=
398872924160=20
>> byte_limit 0 bytes_used 6570868736
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2018745 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025990
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 671b4b4f-fd99-e140-8535-fce0a16babfb
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2017206 otransid 2017206 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1758834001.88320469 (2025-09-26 00:00=
:01)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1758834001.271433540 (2025-09-26 00:0=
0:01)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 39 key (14547 ROOT_BACKREF 256) itemoff 10161 itemsi=
ze 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28827 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 40 key (14559 ROOT_ITEM 2019735) itemoff 9722 itemsi=
ze 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025992 root_dirid 256 bytenr 75=
423231606784=20
>> byte_limit 0 bytes_used 6576078848
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2019735 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025992
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 3ff52125-57ee-6140-87a5-4fb848ec4638
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2019711 otransid 2019735 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1758919659.690576855 (2025-09-26 23:4=
7:39)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1758920400.700930626 (2025-09-27 00:0=
0:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 41 key (14559 ROOT_BACKREF 256) itemoff 9696 itemsiz=
e 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28851 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 42 key (14583 ROOT_ITEM 2022097) itemoff 9257 itemsi=
ze 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025994 root_dirid 256 bytenr 65=
812067024896=20
>> byte_limit 0 bytes_used 6557646848
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2022097 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025994
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 860f0635-f296-a04b-9fc5-bd85d480799c
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2022097 otransid 2022097 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759006819.37527411 (2025-09-28 00:00=
:19)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759006820.861182212 (2025-09-28 00:0=
0:20)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 43 key (14583 ROOT_BACKREF 256) itemoff 9231 itemsiz=
e 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28899 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 44 key (14607 ROOT_ITEM 2024585) itemoff 8792 itemsi=
ze 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025996 root_dirid 256 bytenr 22=
7573944696832=20
>> byte_limit 0 bytes_used 6583533568
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2024585 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025996
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid af3524d0-8a9a-894c-b5b7-705b10114326
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2024474 otransid 2024585 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759089642.387498362 (2025-09-28 23:0=
0:42)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759093200.412309185 (2025-09-29 00:0=
0:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 45 key (14607 ROOT_BACKREF 256) itemoff 8766 itemsiz=
e 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28947 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 46 key (14631 ROOT_ITEM 2025813) itemoff 8327 itemsi=
ze 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025998 root_dirid 256 bytenr 17=
8141351657472=20
>> byte_limit 0 bytes_used 6602981376
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025813 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025998
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 6f085114-93b0-d146-8997-9a41ff62f8db
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025812 otransid 2025813 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759177902.175859896 (2025-09-29 23:3=
1:42)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759210423.120386595 (2025-09-30 08:3=
3:43)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 47 key (14631 ROOT_BACKREF 256) itemoff 8301 itemsiz=
e 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28995 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 48 key (14640 ROOT_ITEM 2025865) itemoff 7862 itemsi=
ze 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2026000 root_dirid 256 bytenr 19=
4611771719680=20
>> byte_limit 0 bytes_used 6603735040
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025865 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2026000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid a48f03d9-4847-654a-af1d-5e0eaf6ecd0c
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025863 otransid 2025865 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759237252.139079795 (2025-09-30 16:0=
0:52)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759240800.56609287 (2025-09-30 17:00=
:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 49 key (14640 ROOT_BACKREF 256) itemoff 7836 itemsiz=
e 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 29013 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 50 key (14641 ROOT_ITEM 2025870) itemoff 7397 itemsi=
ze 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2026002 root_dirid 256 bytenr 65=
801342844928=20
>> byte_limit 0 bytes_used 6603292672
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025870 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2026002
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 56e7aa4e-e166-504d-9a55-8c8b074c0fd9
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025868 otransid 2025870 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759241717.101400473 (2025-09-30 17:1=
5:17)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759244400.232224532 (2025-09-30 18:0=
0:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 51 key (14641 ROOT_BACKREF 256) itemoff 7371 itemsiz=
e 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 29015 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 52 key (14642 ROOT_ITEM 2025874) itemoff 6932 itemsi=
ze 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2026004 root_dirid 256 bytenr 18=
7252895498240=20
>> byte_limit 0 bytes_used 6603341824
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025874 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2026004
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid f1761dfd-ec60-724a-9af0-dea952cc6771
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025872 otransid 2025874 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759244441.841998010 (2025-09-30 18:0=
0:41)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759248000.122051877 (2025-09-30 19:0=
0:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 53 key (14642 ROOT_BACKREF 256) itemoff 6906 itemsiz=
e 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 29017 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 54 key (14643 ROOT_ITEM 2025904) itemoff 6467 itemsi=
ze 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2026006 root_dirid 256 bytenr 22=
7587769647104=20
>> byte_limit 0 bytes_used 6603587584
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025904 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2026006
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 68fd5037-6c8a-c74e-b08f-cff4cdccf752
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025904 otransid 2025904 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759251597.815452999 (2025-09-30 19:5=
9:57)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759251600.884521740 (2025-09-30 20:0=
0:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 55 key (14643 ROOT_BACKREF 256) itemoff 6441 itemsiz=
e 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 29019 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 56 key (14644 ROOT_ITEM 2025922) itemoff 6002 itemsi=
ze 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2026008 root_dirid 256 bytenr 22=
7594191208448=20
>> byte_limit 0 bytes_used 6603653120
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025922 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2026008
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 07ccd2ae-f51d-2c46-82df-05e16964b2e5
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025921 otransid 2025922 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759254975.20573006 (2025-09-30 20:56=
:15)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759255200.196692319 (2025-09-30 21:0=
0:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 57 key (14644 ROOT_BACKREF 256) itemoff 5976 itemsiz=
e 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 29021 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 58 key (14645 ROOT_ITEM 2025951) itemoff 5537 itemsi=
ze 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2026010 root_dirid 256 bytenr 19=
3309358817280=20
>> byte_limit 0 bytes_used 6603964416
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025951 flags 0x1(RDONLY) ref=
s 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2026010
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid b46ce558-2c39-3944-91d4-b2b229f04a16
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600f2=
db6a8
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025950 otransid 2025951 stransid =
0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759257514.988583086 (2025-09-30 21:3=
8:34)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759258800.482340435 (2025-09-30 22:0=
0:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 item 59 key (14645 ROOT_BACKREF 256) itemoff 5511 itemsiz=
e 26
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 29023 sequence 2 nam=
e snapshot
>> =C2=A0 =C2=A0 item 60 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 5072 it=
emsize 439
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2018764 root_dirid 256 bytenr 71=
399055278080=20
>> byte_limit 0 bytes_used 16384
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 0 flags 0x0(none) refs 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_leve=
l 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 0 generation_v2 2018764
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 00000000-0000-0000-0000-000000000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid 00000000-0000-0000-0000-0000000=
00000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-00000=
0000000
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 0 otransid 0 stransid 0 rtransid 0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>=20
> Qu Wenruo kirjoitti 5.10.2025 klo 1.07:
>>
>>
>> =E5=9C=A8 2025/10/5 08:23, Henri Hyyryl=C3=A4inen =E5=86=99=E9=81=93:
>>>> One extra thing, at the time of the initial "btrfs check --repair",=
=20
>>>> there is no running dev-replace/balance or whatever running?
>>>>
>>>> Although those operations will be automatically paused by unmount,
>>>> btrfs check is not going to be able to handle some of those paused=20
>>>> operations.=20
>>>
>>> Is there a way for me to check that without mounting the filesystem?=
=20
>>> As far as I could find, none of the balance / scrub commands allow=20
>>> working on an unmounted filesystem. So I couldn't find out if I had=20
>>> any in canceled state.
>>
>> # btrfs ins dump-tree -t root <device>
>>>
>>> Though, I'm pretty sure I let the last scrub and balance operation I=
=20
>>> tried to fully complete before starting using the check and repair=20
>>> commands. But I'm not absolutely certain that I didn't try one of=20
>>> those a last time and didn't let it fully complete.
>>>
>>> I'll start that "btrfs check --readonly" command now. And I'll report=
=20
>>> back once it is done (hopefully by the morning in my timezone).
>>>
>>> - Henri Hyyryl=C3=A4inen
>>>
>>> Qu Wenruo kirjoitti 4.10.2025 klo 23.55:
>>>>
>>>>
>>>> =E5=9C=A8 2025/10/5 07:14, Qu Wenruo =E5=86=99=E9=81=93:
>>>>>
>>>>>
>>>>> =E5=9C=A8 2025/10/5 04:13, Henri Hyyryl=C3=A4inen =E5=86=99=E9=81=93=
:
>>>>>> Hello again.
>>>>>>
>>>>>> It took over 3 days, but the btrfs check --repair has now=20
>>>>>> completed seemingly successfully. I mostly saw output about the=20
>>>>>> file being placed in lost+found and and directory size being=20
>>>>>> corrected. However, there were some messages about mismatch of=20
>>>>>> used bytes.
>>>>>>
>>>>>> Unfortunately it seems like the situation has gotten worse since=20
>>>>>> the repair, because now I cannot mount the filesystem at all.=20
>>>>>> Instead I get an error like this:
>>>>>>
>>>>>>> BTRFS error (device sdc): dev extent physical offset=20
>>>>>>> 19977638903808 on devid 4 doesn't have corresponding chunk
>>>>>>> BTRFS error (device sdc): failed to verify dev extents against=20
>>>>>>> chunks: -117
>>>>>>> BTRFS error (device sdc): open_ctree failed: -117
>>>>>> Even if I remove that one problematic device physically from my=20
>>>>>> computer, the filesystem still refuses to mount with the same=20
>>>>>> error. Maybe the problems with the device replace are again=20
>>>>>> showing up with the actual size of the hard drive not being used=20
>>>>>> correctly? I cannot try to remove the device slack as I cannot=20
>>>>>> mount the filesystem.
>>>>>
>>>>> Nope, this is a different problem, and not related to dev replace.
>>>>>
>>>>> Unfortunately btrfs check has not implemented any repair for that.
>>>>>
>>>>> Overall if the dev extent is found but not corresponding chunk, it=
=20
>>>>> should still be fine but some space unavailable.
>>>>>
>>>>> But the kernel is overly cautious on chunk tree, as it's a very=20
>>>>> important and basic functionality.
>>>>>
>>>>> Please provide the full "btrfs check --readonly" output so that we=
=20
>>>>> can evaluate and add the missing repair functionality.
>>>>
>>>> One extra thing, at the time of the initial "btrfs check --repair",=
=20
>>>> there is no running dev-replace/balance or whatever running?
>>>>
>>>> Although those operations will be automatically paused by unmount,
>>>> btrfs check is not going to be able to handle some of those paused=20
>>>> operations.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> I did try to run a repair again, and this time I got a bunch of=20
>>>>>> messages like:
>>>>>>
>>>>>>> repair deleting extent record: key [65795546775552,169,0]
>>>>>>> adding new tree backref on start 65795546775552 len 16384 parent=
=20
>>>>>>> 65811674234880 root 65811674234880
>>>>>>> adding new tree backref on start 65795546775552 len 16384 parent=
=20
>>>>>>> 0 root 14499
>>>>>>> adding new tree backref on start 65795546775552 len 16384 parent=
=20
>>>>>>> 65791012274176 root 65791012274176
>>>>>>> adding new tree backref on start 65795546775552 len 16384 parent=
=20
>>>>>>> 65806385807360 root 65806385807360
>>>>>>> Repaired extent references for 65795546775552
>>>>>>> ref mismatch on [65795548233728 16384] extent item 5, found 4
>>>>>
>>>>> That's fixing some backref mismatch, which you can ignore unless=20
>>>>> "btrfs check --reaonly" later reports new problems.
>>>>>
>>>>>> But the filesystem still refuses to mount with the exact same=20
>>>>>> error. I did not let the repair run entirely as it would have=20
>>>>>> likely taken another 3 days. What should I do? This time I'm not=20
>>>>>> finding any good information on what to do. For now, I've started=
=20
>>>>>> the repair again, but it doesn't exactly sound like it is even=20
>>>>>> fixing anything now. Still, I'll let it continue. The output so=20
>>>>>> far is:
>>>>>>
>>>>>>> [1/8] checking log skipped (none written)
>>>>>>> [2/8] checking root items
>>>>>>> Fixed 0 roots.
>>>>>>> [3/8] checking extents
>>>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the=20
>>>>>>> relative chunk.
>>>>>>> super bytes used 49454738989056 mismatches actual used=20
>>>>>>> 49454738923520
>>>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the=20
>>>>>>> relative chunk.
>>>>>>> super bytes used 49454739005440 mismatches actual used=20
>>>>>>> 49454738956288
>>>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the=20
>>>>>>> relative chunk.
>>>>>>> super bytes used 49454739021824 mismatches actual used=20
>>>>>>> 49454738972672
>>>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the=20
>>>>>>> relative chunk.
>>>>>>> super bytes used 49454739005440 mismatches actual used=20
>>>>>>> 49454738972672
>>>>>>
>>>>>>
>>>>>> If I was able to somehow remove that one logically corrupt devid=20
>>>>>> from the filesystem, or somehow correct the size, that would=20
>>>>>> hopefully allow me to rebuild from the raid10 data then, but I=20
>>>>>> can't do those with the unmountable filesystem.
>>>>>>
>>>>>>
>>>>>> - Henri Hyyryl=C3=A4inen
>>>>>>
>>>>>> Qu Wenruo kirjoitti 30.9.2025 klo 0.52:
>>>>>>>
>>>>>>>
>>>>>>> =E5=9C=A8 2025/9/30 02:41, Henri Hyyryl=C3=A4inen =E5=86=99=E9=81=
=93:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> I hope this is the right place to ask about a filesystem=20
>>>>>>>> problem. Really shortly put, I have a file that both exists and=
=20
>>>>>>>> doesn't and prevents the containing directory from being=20
>>>>>>>> deleted. No matter what variant of rm and inode based deletion I=
=20
>>>>>>>> try I get an error about the file not existing, and I also=20
>>>>>>>> cannot try to read the file, but if I try to delete the=20
>>>>>>>> directory I get an error that it is not empty (so the file kind=
=20
>>>>>>>> of exists). Trying to ls the directory also gives a file doesn't=
=20
>>>>>>>> exist error.
>>>>>>>>
>>>>>>>> Here's what btrfs check found, which I hope does better in=20
>>>>>>>> illustrating the problem:
>>>>>>>>
>>>>>>>>> root 5 inode 25953213 errors 200, dir isize wrong
>>>>>>>>> root 5 inode 27166085 errors 2000, link count wrong
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 25=
953213 index 7 namelen 33 name=20
>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir it=
em
>>>>>>>>
>>>>>>>> I've tried everything I've found suggested including a full=20
>>>>>>>> scrub, balance with -dusage=3D75 -musage=3D75, resetting file=20
>>>>>>>> attributes, deleting through the find command, and even some=20
>>>>>>>> repair mount flags that don't seem to exist for btrfs.
>>>>>>>
>>>>>>> The fs is corrupted, thus none of those will help.
>>>>>>> I'm more interested in how the corruption happened.
>>>>>>>
>>>>>>> Did you use some tools other than btrfs kernel module and btrfs-=
=20
>>>>>>> progs?
>>>>>>> Like ntfs2btrfs or winbtrfs?
>>>>>>>
>>>>>>> IIRC certain versions have some bugs related to extent tree, but=
=20
>>>>>>> should not cause this problem.
>>>>>>>
>>>>>>>
>>>>>>> The other possibility is hardware memory bitflip, which is more=20
>>>>>>> common than you thought (almostly one report per month)
>>>>>>>
>>>>>>> In that case, a full memtest is always recommended, or you will=20
>>>>>>> hit all kinds of weird corruptions in the future anyway.
>>>>>>>
>>>>>>>
>>>>>>> With a full memtest proving the memory hardware is fine, then=20
>>>>>>> "btrfs check --repair" should be able to fix it.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>
>>>>>>>
>>>>>>>> What I haven't tried is a full rebalance with no filters, but I=
=20
>>>>>>>> did not try that yet as it would take quite a long time and if=20
>>>>>>>> it only moves data blocks around without recomputing directory=20
>>>>>>>> items, it doesn't seem like the right tool to fix my problem. So=
=20
>>>>>>>> I'm pretty much stuck and to me it seems like my only option is=
=20
>>>>>>>> to run btrfs check with the repair flag, but as that has big=20
>>>>>>>> warnings on it I thought I would try asking here first (sorry if=
=20
>>>>>>>> this is not the right experts group to ask). So is there still=20
>>>>>>>> something I can try or am I finally "allowed" to use the repair=
=20
>>>>>>>> command? Here's the full output I got from btrfs check:
>>>>>>>>
>>>>>>>>> Opening filesystem to check...
>>>>>>>>> Checking filesystem on /dev/sdc
>>>>>>>>> UUID: 2b4ad16d-e456-4adf-960b-dca43560b98b
>>>>>>>>> [1/8] checking log skipped (none written)
>>>>>>>>> [2/8] checking root items
>>>>>>>>> [3/8] checking extents
>>>>>>>>> [4/8] checking free space tree
>>>>>>>>> We have a space info key for a block group that doesn't exist
>>>>>>>>> [5/8] checking fs roots
>>>>>>>>> root 5 inode 25953213 errors 200, dir isize wrong
>>>>>>>>> root 5 inode 27166085 errors 2000, link count wrong
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 25=
953213 index 7 namelen 33 name=20
>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir it=
em
>>>>>>>>> root 14428 inode 25953213 errors 200, dir isize wrong
>>>>>>>>> root 14428 inode 27166085 errors 2000, link count wrong
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 25=
953213 index 7 namelen 33 name=20
>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir it=
em
>>>>>>>>> root 14451 inode 25953213 errors 200, dir isize wrong
>>>>>>>>> root 14451 inode 27166085 errors 2000, link count wrong
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 25=
953213 index 7 namelen 33 name=20
>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir it=
em
>>>>>>>>> root 14475 inode 25953213 errors 200, dir isize wrong
>>>>>>>>> root 14475 inode 27166085 errors 2000, link count wrong
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 25=
953213 index 7 namelen 33 name=20
>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir it=
em
>>>>>>>>> root 14499 inode 25953213 errors 200, dir isize wrong
>>>>>>>>> root 14499 inode 27166085 errors 2000, link count wrong
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 25=
953213 index 7 namelen 33 name=20
>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir it=
em
>>>>>>>>> root 14523 inode 25953213 errors 200, dir isize wrong
>>>>>>>>> root 14523 inode 27166085 errors 2000, link count wrong
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 25=
953213 index 7 namelen 33 name=20
>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir it=
em
>>>>>>>>> root 14544 inode 25953213 errors 200, dir isize wrong
>>>>>>>>> root 14544 inode 27166085 errors 2000, link count wrong
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 25=
953213 index 7 namelen 33 name=20
>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir it=
em
>>>>>>>>> root 14545 inode 25953213 errors 200, dir isize wrong
>>>>>>>>> root 14545 inode 27166085 errors 2000, link count wrong
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 25=
953213 index 7 namelen 33 name=20
>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir it=
em
>>>>>>>>> root 14546 inode 25953213 errors 200, dir isize wrong
>>>>>>>>> root 14546 inode 27166085 errors 2000, link count wrong
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 25=
953213 index 7 namelen 33 name=20
>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir it=
em
>>>>>>>>> root 14547 inode 25953213 errors 200, dir isize wrong
>>>>>>>>> root 14547 inode 27166085 errors 2000, link count wrong
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 25=
953213 index 7 namelen 33 name=20
>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir it=
em
>>>>>>>>> root 14548 inode 25953213 errors 200, dir isize wrong
>>>>>>>>> root 14548 inode 27166085 errors 2000, link count wrong
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 25=
953213 index 7 namelen 33 name=20
>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir it=
em
>>>>>>>>> root 14549 inode 25953213 errors 200, dir isize wrong
>>>>>>>>> root 14549 inode 27166085 errors 2000, link count wrong
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 25=
953213 index 7 namelen 33 name=20
>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir it=
em
>>>>>>>>> root 14550 inode 25953213 errors 200, dir isize wrong
>>>>>>>>> root 14550 inode 27166085 errors 2000, link count wrong
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 25=
953213 index 7 namelen 33 name=20
>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir it=
em
>>>>>>>>> ERROR: errors found in fs roots
>>>>>>>>> found 49400296812544 bytes used, error(s) found
>>>>>>>>> total csum bytes: 48179330432
>>>>>>>>> total tree bytes: 65067483136
>>>>>>>>> total fs tree bytes: 12107431936
>>>>>>>>> total extent tree bytes: 3194437632
>>>>>>>>> btree space waste bytes: 4558984171
>>>>>>>>> file data blocks allocated: 76487982252032
>>>>>>>>> =C2=A0referenced 60030799097856
>>>>>>>>
>>>>>>>> So hopefully if I'm reading things right, running a repair would=
=20
>>>>>>>> delete just that one file and directory (which itself is a=20
>>>>>>>> backup so I will not miss that file at all)?
>>>>>>>>
>>>>>>>> I do not have enough disk space to copy off the entire=20
>>>>>>>> filesystem and rebuild from scratch, without doing something=20
>>>>>>>> like rebalancing all data from raid10 to single and then=20
>>>>>>>> removing half the disks, but I assume that would take at least 4=
=20
>>>>>>>> weeks to process (as I just replaced a disk which took like a=20
>>>>>>>> week).
>>>>>>>>
>>>>>>>> As to what originally caused the corruption, I think it was=20
>>>>>>>> probably faulty RAM, because up to to like 3 weeks ago I had one=
=20
>>>>>>>> really bad RAM stick in my computer where a certain memory=20
>>>>>>>> region always had incorrectly reading bytes. I had seen=20
>>>>>>>> intermittent quite high csum errors in monthly scrubs pretty=20
>>>>>>>> randomly, which thankfully could almost always be corrected so I=
=20
>>>>>>>> didn't have any major problems even though I had like totally=20
>>>>>>>> broken RAM in my computer for who knows how long. So btrfs was=20
>>>>>>>> able to protect my data quite impressively from bad RAM.
>>>>>>>>
>>>>>>>> Sorry for getting a bit sidetracked there, but what should I do=
=20
>>>>>>>> in this situation?
>>>>>>>>
>>>>>>>> - Henri Hyyryl=C3=A4inen
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>
>>>>>
>>>>
>>
>=20


