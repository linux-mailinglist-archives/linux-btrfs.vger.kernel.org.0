Return-Path: <linux-btrfs+bounces-15653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 762B5B0FFCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 07:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005A37A6323
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 05:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC171FCFE7;
	Thu, 24 Jul 2025 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="b3JIO2l7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6DA1863E
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Jul 2025 05:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753333832; cv=none; b=f5yOFoLwjhtXJJ4/i0EK18E8GSGWBxK9JhYmUfdmJPc6pArUHx6RnHVU96fGi4Ca5rzgLbNA4wcdG4InR25uGFKgneLV2v95cq2KyYpA4guNxLmjSDKMhozdt1IUywz1g2NhKHnw6E5C9b7cX/7olF1DmoMM64EAtuDShL8ZPzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753333832; c=relaxed/simple;
	bh=Jwa8kSc5Gq4GFveC2CHuSHEli5Y4L3dbe6J47pSxYiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yxj6IwWMlZWmpTh58ORyIaxJi8Wrwf8fuvXuYq3OYcCZpd8iX24Ygc5wHalbf9qp4Z5h8xECLQ3cABUqWcRPd0AKrsAH599jIHts24j1VWR6IrXtHLrf/BP57aAMkoYr82qtdcGOhg1MhFOP5o/CCZsSgI06VFZYNsT1i1UgLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=b3JIO2l7; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1753333827; x=1753938627; i=quwenruo.btrfs@gmx.com;
	bh=sTrZB93puF4iLKDV58mOE0t14mNeSJ/7HvYXNAuT6OA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b3JIO2l7+kk+QI3kHB32ouPVBDHLrpqgfi8hD5wXhpY2PFs1U+9sZ2kmTKDmjyMu
	 IvLuPOUUEz0zVLbDBAvnP7+Ww2AWtfaVDvQwyyfiuTNhwHBt8wJEgw1cRDEmYtSU+
	 IPPXU9unnfNs371BKvbRhupnNsjWeQfgR+hVeIiMKZT7UdYlOutQZn5oAtU3VTduC
	 Th0ZPtrxQjRe7P3K0s+rxBMXljayBxuRihON+FM1fi7Qj5crG15q2Z60y/dbaAzvm
	 vNOJFbAA1Xxot0VN2oXdhdBZg5OEePfpRW1TLr1t0u70PEk7r/nq2GWW43JHU1/PU
	 hEkOaT4ufMvyBkfEdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTAFh-1v8lPp3223-00PYtv; Thu, 24
 Jul 2025 07:10:27 +0200
Message-ID: <c781524c-dbb4-4f0b-947f-e781952b4c4f@gmx.com>
Date: Thu, 24 Jul 2025 14:40:24 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Null deref during attempted replay of corrupt TREE_LOG in newer
 kernel
To: Russell Haley <yumpusamongus@gmail.com>, linux-btrfs@vger.kernel.org
References: <598ecc75-eb80-41b3-83c2-f2317fbb9864@gmail.com>
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
In-Reply-To: <598ecc75-eb80-41b3-83c2-f2317fbb9864@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jzVdiDPm5RQyK1kDxLWtNtooHDpMj9cAzM9p9aINC4Euv0yNoAU
 vNbg5dhUQ+SXW9RQLwQajkNM1eld3XAWui4vtusI2EIOkq2MM3/puuHdL21rfr6/66y2b/b
 rumQsFvttfYNH3pE74ioDEH+5FLBt/8p69/370I568g12d0GDvo74PLGObohZDHMTB9Uu4G
 V2UqS/lyOcLLilM7oOYcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E/cqtPLQY90=;d+q8fFeuHW7je6oUDtd+s+n+//N
 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
 gg==



=E5=9C=A8 2025/7/14 02:32, Russell Haley =E5=86=99=E9=81=93:
> Howdy,
>=20
> After a power outage, my computer booted into emergency mode, apparently
> due to a corrupt log tree on the root SSD (WD Blue, WDC
> WDS500G2B0C-00PXH0). Symptoms basically identical to [1], and I was
> eventually able to fix it the same way, with btrfs rescue zero-log.
>=20
> *However*, troubleshooting was complicated by the fact that, on kernel
> 6.15.4, attempting to mount the corrupt FS even once OOPSed the kernel
> and locked the device, making it impossible to run btrfs commands
> against it or try different mount options.  This would've been a
> showstopper if I didn't have Fedora's backup kernels to try and see that
> the dmesg error was different. That led me to boot into a live USB with
> kernel 6.14.0, from which I was able to investigate.  I then booted into
> backup kernel 6.14.9 (the newest non-problematic) and zeroed the log.
[..]
> Corrupt tree log dump collected with btrfs-tools 6.15 on live USB:
>=20
>> # btrfs inspect-internal dump-tree -t TREE_LOG /dev/mapper/hogwarts-roo=
t
>> btrfs-progs v6.15
>> log root tree
>> leaf 202650910720 items 2 free space 15355 generation 456818 owner TREE=
_LOG
>> leaf 202650910720 flags 0x1(WRITTEN) backref revision 1
>> fs uuid a6999502-9362-4fa7-b7b4-28095790217d
>> chunk uuid 710679da-fb76-4a51-9c84-8600a6e58c43
>>          item 0 key (TREE_LOG ROOT_ITEM 256) itemoff 15844 itemsize 439
>>                  generation 456818 root_dirid 0 bytenr 202645028864 byt=
e_limit 0 bytes_used 0
>>                  last_snapshot 0 flags 0x0(none) refs 0
>>                  drop_progress key (0 UNKNOWN.0 0) drop_level 0
>>                  level 0 generation_v2 456818
>>                  uuid 00000000-0000-0000-0000-000000000000
>>                  parent_uuid 00000000-0000-0000-0000-000000000000
>>                  received_uuid 00000000-0000-0000-0000-000000000000
>>                  ctransid 0 otransid 0 stransid 0 rtransid 0
>>                  ctime 0.0 (1970-01-01 00:00:00)
>>                  otime 0.0 (1970-01-01 00:00:00)
>>                  stime 0.0 (1970-01-01 00:00:00)
>>                  rtime 0.0 (1970-01-01 00:00:00)
>>          item 1 key (TREE_LOG ROOT_ITEM 258) itemoff 15405 itemsize 439
>>                  generation 456818 root_dirid 0 bytenr 202650877952 byt=
e_limit 0 bytes_used 65536
>>                  last_snapshot 0 flags 0x0(none) refs 0
>>                  drop_progress key (0 UNKNOWN.0 0) drop_level 0
>>                  level 1 generation_v2 456818
>>                  uuid 00000000-0000-0000-0000-000000000000
>>                  parent_uuid 00000000-0000-0000-0000-000000000000
>>                  received_uuid 00000000-0000-0000-0000-000000000000
>>                  ctransid 0 otransid 0 stransid 0 rtransid 0
>>                  ctime 0.0 (1970-01-01 00:00:00)
>>                  otime 0.0 (1970-01-01 00:00:00)
>>                  stime 0.0 (1970-01-01 00:00:00)
>>                  rtime 0.0 (1970-01-01 00:00:00)
>=20
> If I'm interpreting correctly, the corrupt tree log is zeroed, so that
> kind of gestures in the direction of what the log replay code might be
> mishandling.

Hope you still have the fs at hand.

In that case, I believe the following dump would help Filipe to pin down=
=20
the problem:

# btrfs ins dump-tree -b 202645028864 --follow <device>
# btrfs ins dump-tree -b 202650877952 --follow <device>
# btrfs ins dump-tree -t 256 <device>
# btrfs ins dump-tree -t 258 <device>

Log tree replay is a very complex mechanism, it records changes into the=
=20
log tree (dumped by the first two commands).
And replaying the log means we need to use the difference (the log tree)=
=20
to update the target subvolumes (dumped by the last two commands).

Problems in either tree can cause replay failure, thus you need to dump=20
both the log trees (not only the log tree root, but the real log tree=20
for each subvolume) and the source subvolumes.

Thanks,
Qu

>   [1]
> https://discussion.fedoraproject.org/t/btrfs-error-emergency-mode-entere=
d-every-time-i-boot/141179
>=20
> Thanks,
>=20
> Russell
>=20


