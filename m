Return-Path: <linux-btrfs+bounces-16530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E43B3C56D
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 00:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F34EA2492E
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 22:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A62DAFC4;
	Fri, 29 Aug 2025 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QdyGURhJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A0B263F36
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756508324; cv=none; b=pgvbr0x9gvNwVlG1iRBAfg4Ji2Fa2jH8uiGsrJJy4q5nwE1nm04cHDTGVnoqVOj/F6x16rVmD/Xp/518t/i3NHz7I92RKK2zCQirgm17MvG9/PBVxRkjwyfKTBljyukMZe5j09mUpwwy0B46daJu5+DKyryTlUq9ftKLDo8omBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756508324; c=relaxed/simple;
	bh=GtwPm44oi9ab/mJl35NeeNlZkFAAhaMqpC3rTWrab3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Epg2N7XNnG5v8ECRrlN3v8qS+UwTdAVMnDKdl9etq7OL0xnIHYKkE0gLk1HURlw75cWKF5fi/EQbBqMEXuDoIUQTl+YQdoGGg2HCxwheiANxwTGJ4R3SpPAhtbdSpTwGjcxOFuhwhuvfRaltLD7qZhODRM5nk9SqJfaTzp8zb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QdyGURhJ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756508309; x=1757113109; i=quwenruo.btrfs@gmx.com;
	bh=XL2OnF+3d8checX2i5GSFDV3uPQzBY1sLU3lXGJ8AmI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QdyGURhJIhXQKZoLL+eEEWWvzfcis45T8IrEmJTPWS//AOfMm+7KqvgG0z5NZLtV
	 MRIIjMxCvZFofOFxqB5ILy3iP1f14AI5SQrQLNDZa+kH4Qc2q4RCEzZfgAYDliK9e
	 9DFoq8AGo2b6iJg4GrhedpUvIKJJeph/tT9UHEYejdG6MwIjE7x5bBREM0nKnoPV4
	 /VPnr209uHRE+M8z31oOlzr/7JHz8QU1AXsl6LI+XIv5DmmPkWCE7t1Bai/ZAdXVM
	 RgCZJe3F2CyLlyFnMehmngWHYKzsMpKRHc2vzWR/TP+K1bRzTyMS6H108dj6bgLpP
	 ++JCN4FwS+oxnVmswg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpUYu-1u98802sf6-00c5Hw; Sat, 30
 Aug 2025 00:58:29 +0200
Message-ID: <635a25a0-c8cb-4a48-bf8b-c81dac1c1260@gmx.com>
Date: Sat, 30 Aug 2025 08:28:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mysterious disappearing corruption and how to diagnose
To: Andy Smith <andy@strugglers.net>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <aLIRfvDUohR/2mnv@mail.bitfolk.com>
 <a48ac216-38f1-4a69-970e-f2ddee2ae8f2@suse.com>
 <aLIm5djb6Ee4T1ot@mail.bitfolk.com>
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
In-Reply-To: <aLIm5djb6Ee4T1ot@mail.bitfolk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cvt3jrHoumGDhL3eMJrPwil/iPjhC2mUs7lH3kk7M1a+d5/sYhM
 uEYqz0mWoOqMWYvvVfy6zvMUJQ0gAeFbsgDcP4ObjEPCgFcMgS5jN7RX9YEvtzaiEiaK5Db
 oMGYIMtilRFNcDbjJWgkSHiKLOgq/pRgtkSBtOtYAye96IAnrIlCMIUL+XzRPsHRsK3RkP7
 BByUsYSO0NVJ2vvr9ezmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W5RefcKe98M=;cjmbUpNK5hLhreall5bBL97x9JG
 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



=E5=9C=A8 2025/8/30 07:47, Andy Smith =E5=86=99=E9=81=93:
> Hi Qu,
>=20
> Thanks for your reply.
>=20
> On Sat, Aug 30, 2025 at 06:45:15AM +0930, Qu Wenruo wrote:
>> =E5=9C=A8 2025/8/30 06:15, Andy Smith =E5=86=99=E9=81=93:
>>> After the second of the new SSDs was added in I started receiving logs
>>> about corruption on the newest added device (sdh):
>>
>> Is this during dev replace/add/remove?
>=20
> I have been mistaken about the order of operations. The one that
> introduced sdh was:
>=20
> 2025-08-25T00:13:22.804904+00:00 strangebrew sudo:     andy : TTY=3Dpts/=
9 ; PWD=3D/home/andy ; USER=3Droot ; COMMAND=3D/usr/bin/btrfs replace star=
t /dev/sdb /dev/sdh /srv/tank
>=20
>> Would it be possible to provide more context/full dmesg for the inciden=
t?
>=20
> There's just thousands of the message I gave and nothing else, but for
> context:
>=20
> 2025-08-25T00:16:13.551484+00:00 strangebrew kernel: [15845362.486304] B=
TRFS info (device sdh): dev_replace from /dev/sdb (devid 9) to /dev/sdh st=
arted
>=20
> 2025-08-25T02:31:55.547470+00:00 strangebrew kernel: [15853504.586725] B=
TRFS info (device sdh): dev_replace from /dev/sdb (devid 9) to /dev/sdh fi=
nished
>=20
> So actually these errors appear not during the replace that introduced
> sdh but later on. I guess that makes sense since sdh is not being read
> from when it's empty!
>=20
> Let me see what other operations were done after this=E2=80=A6
>=20
> 2025-08-25T02:58:36.452870+00:00 strangebrew sudo:     andy : TTY=3Dpts/=
9 ; PWD=3D/home/andy ; USER=3Droot ; COMMAND=3D/usr/bin/btrfs replace star=
t /dev/sdf /dev/sdb /srv/tank
> 2025-08-25T03:01:29.103489+00:00 strangebrew kernel: [15855278.164899] B=
TRFS info (device sdh): dev_replace from /dev/sdf (devid 12) to /dev/sdb s=
tarted
> 2025-08-25T04:52:36.719565+00:00 strangebrew kernel: [15861945.864876] B=
TRFS error (device sdh): bad tree block start, mirror 1 want 1852617198796=
8 have 0
> 2025-08-25T04:52:36.719578+00:00 strangebrew kernel: [15861945.867728] B=
TRFS info (device sdh): read error corrected: ino 0 off 18526171987968 (de=
v /dev/sdh sector 238168896)
> 2025-08-25T05:44:42.139479+00:00 strangebrew kernel: [15865071.325433] B=
TRFS error (device sdh): bad tree block start, mirror 1 want 1852617936486=
4 have 0
> 2025-08-25T05:44:42.139493+00:00 strangebrew kernel: [15865071.328345] B=
TRFS info (device sdh): read error corrected: ino 0 off 18526179364864 (de=
v /dev/sdh sector 238183304)
> 2025-08-25T11:34:15.115468+00:00 strangebrew kernel: [15886044.574930] B=
TRFS info (device sdh): dev_replace from /dev/sdf (devid 12) to /dev/sdb f=
inished
>=20
> I have not omitted any "read error corrected" messages between these
> times so during replace of sdf with sdb in fact only two of the
> corrupted reads occurred.
>=20
> The vast majority of the "read error corrected" messages happen later
> between:
>=20
> 2025-08-26T01:15:18.179736+00:00 strangebrew kernel: [15935308.276936] B=
TRFS info (device sdh): read error corrected: ino 0 off 18526369787904 (de=
v /dev/sdh sector 238555224)
>=20
> and
>=20
> 2025-08-27T04:37:04.973808+00:00 strangebrew kernel: [ 6683.406728] BTRF=
S info (device sdb): read error corrected: ino 450 off 981975040 (dev /dev=
/sdh sector 56445920)
>=20
> (last one ever)
>=20
> There was also a reboot in between those times.
>=20
> After seeing the read errors I had made a drive bay available and
> re-attached one of the old devices:
>=20
> 2025-08-26T20:52:58.644481+00:00 strangebrew sudo:     andy : TTY=3Dpts/=
9 ; PWD=3D/home/andy ; USER=3Droot ; COMMAND=3D/usr/bin/btrfs dev add /dev=
/sdf /srv/tank
>=20
> I then removed sdh:
>=20
> 2025-08-26T21:03:32.781261+00:00 strangebrew sudo:     andy : TTY=3Dpts/=
9 ; PWD=3D/home/andy ; USER=3Droot ; COMMAND=3D/usr/bin/btrfs dev remove /=
dev/sdh /srv/tank
>=20
> 2025-08-27T04:50:16.085385+00:00 strangebrew kernel: [ 7474.522398] BTRF=
S info (device sdb): device deleted: /dev/sdh
>=20
> Except for a scrub no further management is done of the btrfs filesystem
> at /srv/tank after this. After this is only my investigations of what is
> going on with sdh.
>=20
> So thousands of the corrected read errors happen after
> 2025-08-26T01:15:18.179736+00:00 but there was no btrfs management
> operation happening until 2025-08-26T20:52:58.644481+00:00 therefore a
> large number of them happened during normal operation of the filesystem,
> long after the replacement in of both sdh and sdb.
>=20
> These look slightly different in that the number after "ino" isn't 0:
>=20
> 2025-08-26T01:15:18.823475+00:00 strangebrew kernel: [15935308.917636] B=
TRFS warning (device sdh): csum failed root 534 ino 17578 off 524288 csum =
0x8941f998 expected csum 0xec2689f0 mirror 1
> 2025-08-26T01:15:18.823486+00:00 strangebrew kernel: [15935308.917652] B=
TRFS warning (device sdh): csum failed root 534 ino 17578 off 655360 csum =
0x8941f998 expected csum 0xf3ada24a mirror 1
> 2025-08-26T01:15:18.823487+00:00 strangebrew kernel: [15935308.918200] B=
TRFS error (device sdh): bdev /dev/sdh errs: wr 0, rd 0, flush 0, corrupt =
1, gen 0
> 2025-08-26T01:15:18.823488+00:00 strangebrew kernel: [15935308.918928] B=
TRFS error (device sdh): bdev /dev/sdh errs: wr 0, rd 0, flush 0, corrupt =
2, gen 0
>=20
>> And what's the raid profile?
>=20
> It is RAID1 profile for data, metadata and system.

So it means no RAID56 write holes, and any error really means error.

And it's really RAID1 saving the day, or you will lose both metadata and=
=20
data.

My concern is, it may be that something wrong related to device replace,=
=20
that duplicated writes (write into both old and new devices) only reach=20
the older device.

Thus the metadata are all zero.

Furthermore the data csum 0x8941f998 is a special, it's the result of=20
CRC32C of a 4K block with all zero.


So this means, either btrfs is doing something wrong replacing the disk,=
=20
thus the old data is not properly written into sdh.

Or the disk has something quirks missing certain writes.

>=20
> Sorry, I realised just after sending that I did not give that
> information.
>=20
>>> Debian 12, kernel 6.1.0-38-amd64, btrfs-progs v6.2 (all from Debian
>>> packages).
>>
>> And the kernel version is not that ideal, it's still supported and rece=
iving
>> backports, but I'm not really sure how many big refactor/rework/fixes a=
re
>> missing on that LTS kernel.
>=20
> Okay. Yes it is still supported by Debian so they are still publishing
> updates for the related LTS kernel but I am relying here on fixes going
> in to LTS kernel in the first place.

In v6.4 we reworked the scrub code (and of course introduced some=20
regression), but overall it should make the error reporting more consisten=
t.

I didn't remember the old behavior, but the newer behavior will still=20
report errors on recoverable errors.


I know you have ran scrub and it should have fixed all the missing=20
writes, but mind to use some liveUSB or newer LTS kernel (6.12=20
recommended) and re-run the scrub to see if any error reported?


It looks like minor missing errors, nor fully losing all writes, but it=20
still looks a little worrying.

Thanks,
Qu

>=20
> Thanks,
> Andy
>=20


