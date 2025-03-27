Return-Path: <linux-btrfs+bounces-12629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A871A73FE1
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 22:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA0C173297
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 21:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA9A13633F;
	Thu, 27 Mar 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NMy7Jins"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166351624C2;
	Thu, 27 Mar 2025 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109492; cv=none; b=UAAtbkY3b6otSSiMPldtfHBMEL/zbFqDDlERyJUoIvQ1hwVWdkKhkyoThqB2WuIPQ3R4gGjXsI4WNUov7onsXybJ5GCxZAhXssKaAWvyl/KOKe/tXvekbom2So5afcWAHpE6lbtYiYMzRrdEmSNmRXWU23FsPwbwhR9pVWQRHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109492; c=relaxed/simple;
	bh=+DfBO+DlwozTIflZlMwt7fPbk6Jer43rnAoX7Jzwlx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJXGOHc7KcpHhVZioQbk4R75vakywo0PU4Nalo8IcpbbT3dRqYjUl+3vF5FEYSLPyKsJ8KsW2zNDFbm1r5qz7OswlRLjlbUnl4aRLDnIhhfAzw2/klG3mmiBw3XCxAA97PZWHivdnIcjcu0deNs/94vJme3/z6bPKu9djFTjL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NMy7Jins; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743109487; x=1743714287; i=quwenruo.btrfs@gmx.com;
	bh=NfrI/BXuwiYzulKEjM2UaHTMLn4bAOCk0pAFwibUo+0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NMy7JinsSu75EBl/fWMIFRafnz8u8BPKwNsShtNEcQ4FcTHNE+7E9BLEee0G8AII
	 8qFftFZxdkV2yXiJC7Cei3wYED0vubr0sRPueOa1PHTkmnEBV8/mm5QqMjIhhroT0
	 GQKAC1DNeH4wtt8fpD9L27n57n32478CEvQNNRYExDDLLnM8eCIb8itx9cUNzk6rF
	 Y3QdsWk32ZtlSUEXd82oKy8jVDJ2yMnc2lJ7EwP1EXN/0snvSFmddWhGNirv3xfR0
	 nZky/TaXJ7atUexeTY5i+oTQ6cIpdScOwFFvP2kMzcNnTSN8j8HZNiIYmAev3UE2x
	 yEAG4ZpGoqWuOjzIyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5VD8-1t5Ks90Wd8-012ca3; Thu, 27
 Mar 2025 22:04:47 +0100
Message-ID: <b3cf4210-273f-4967-b544-39c47cb0ec96@gmx.com>
Date: Fri, 28 Mar 2025 07:34:42 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] kernel BUG in write_all_supers
To: dsterba@suse.cz,
 syzbot <syzbot+34122898a11ab689518a@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67e5799e.050a0220.2f068f.0032.GAE@google.com>
 <20250327162525.GU32661@twin.jikos.cz>
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
In-Reply-To: <20250327162525.GU32661@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BfyImzBfWpTI0hKdexisgGy9Gggga+AuJxpIOwwCNnxUmHC32KN
 nXHrSceuP/6uK6EMz2bsO+5HKt5+MhwxI6RomXuEybVglrY9ZFa3KNpNsk8QbpebRr/5PLF
 7lPC4Tkoi2cs2/rgEntyWjs/XpCcycNUoQxJQF2xoHiT528N4n+kNSkGDUHQ1l/nAinw1uJ
 orckCNIX4sg6W2jarp4kA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:op/kzATTi+0=;p+Oy6YnvArC/tnKPC0VVgmp6Y7G
 8l+In+vm55/yFxzdX+mDVKls+mdaXKlFDFefbrTB9sCN4p80+GJkIqbs5PP5/CJNDI/jEOa7N
 NQb49JG7GH9O4J2ps8VMA0u4ochNRsycx1+UyJKuHpntl1j5YJ4/D9TukMnaQTLXzUajaDE7O
 GuaY4YtXZP10RXPWaIKDiaeZYFvoDDtWOC01ql3sJ8OGiv5xepCSbCw3TlMM53SZeYk4F36dv
 NIFU0uOgYiX+xELcFQbX3iNUsf4G8qjuL/v322+0wDIYP2rNw42qRVKWesmaWVSlw2nO6Ddx8
 H9s71rSM0FLXfANIm+LpOV5Yg5z4+tW4C7fnqOy1PFWsUH/tNsUESk3Lc3hbqhsknbX456LVJ
 NZ8RyV+DeSK0S8MIrOv1Pf3Q6ybJ3l+HX+0cbY1AgCTIZy2SRwrB0wRNqZVCSF4Ua+HzEWIef
 SFsUynXTAORfAx5ALhrHyZq0/yUn/PjZojvrtih9lJVllWpixdxvEmlQierb1R5D1NF75Zw6E
 a/goh8lM2g/LWIAnuCYfoXYAsZkiOyA/iWqPEq9Mx/yNOPvkXLqrI5I0R7QjEPcs8kvbLAEhM
 dcVGFhahalnAFB20S0w+Ahvi5IAZwHt8hpJ16nBRj7PAFzBHAR6oX0zdthJezPSId+tyftGX9
 MY2DeoYPzqwIFI6R8tH2WBnbzWU1lV0W6x3dkArvZfChDeEvn2HwDVaLT+0ZFsiL5R9hsaIBl
 kdwo/E7u6h2obWMAA9f3lPerxetzdrn1fUwpophCnstnv9X8PsCw9r+glYsdZPbiDAa8DWb9C
 +m1xv0FqT6mzHKucdzHEQ6GIIQ4t8ny/SJl0y3nQBu/0G00IQSfuktRv0EZT1iFIvuYLqk/Tn
 4tTSJcKKYEQJKvdVrkdkOMF3tdhjvtI2KZh8FOaD1Z7ZSK2yjFPkkQHJFOU5SRE3MTMh9xBoy
 EFTj7AN5lyxFGW448EykJQ/G9iwhfx6KFOAL2XYubDtzrF3jQMUzpsscN4xZQ6iI0MaxmxneN
 teYFdrhDG0K9xtRVGncZ0gKHeEx8OaMglF2w5Gri31vzXzs0fMDDnv6eBJQXwx6BSqpHHLnZx
 akiI5RSUKpjEE8M5VU0JRwNsDKoBw71bkbzRlh/WKL9Iju0JlOJWKusaRmYpwEA82FZ2USS6w
 A9GvGuk//pU6pp2+mFKkuIXNxa7pJ6/asRNkCJlJbu3uhnR3lwBIDgI9al2YZfYhmfvy2muWp
 3omSG2vFnSjhF1Jn0Q+s1IHT6SC2w3C/9C6JzVtz32zF2YC8JwU2xnK+GEP7oWE3uNSf2uikj
 fVNyhPKDLBwNIfGkNNry5l8vM+VEizkAFMWIGKJRYUuirbFWL+8Vhc6OPLiMNMAGElouBUE+K
 wMtySAImnHqdUeQADu++kAkk7ga5lBzT1U5QI6f0x96RoegKfoQrKjWWP3HhHiYF53PV8bioU
 lFWkTBkOylTP265brMl6juObBKg8=



=E5=9C=A8 2025/3/28 02:55, David Sterba =E5=86=99=E9=81=93:
> On Thu, Mar 27, 2025 at 09:15:26AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    f6e0150b2003 Merge tag 'mtd/for-6.15' of git://git.kern=
el...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1405d804580=
000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D46a07195688=
b794b
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D34122898a11ab=
689518a
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10d7abb05=
80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15d76198580=
000
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/7feb34a89c2a/non_bootable_disk-f6e0150b.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/7ade4c34c9b1/vmli=
nux-f6e0150b.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/1fe37b97ec9d=
/bzImage-f6e0150b.xz
>> mounted in repro: https://storage.googleapis.com/syzbot-assets/1f4c759f=
e772/mount_0.gz
>>    fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=3D1=
757abb0580000)
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
>> Reported-by: syzbot+34122898a11ab689518a@syzkaller.appspotmail.com
>>
>> BTRFS info (device loop0): using sha256 (sha256-avx2) checksum algorith=
m
>> BTRFS info (device loop0): using free-space-tree
>> assertion failed: folio_order(folio) =3D=3D 0, in fs/btrfs/disk-io.c:38=
58
>
> This is
>
> ASSERT(folio_order(folio) =3D=3D 0);
>
> and the folio is from device->bdev->bd_mapping.
>

And the bdev folios are out of our control, so it's possible the bdev
mapping is utilizing larger folios.

I'll give it a check on the involved function and if everything else
supports large folios, just remove that ASSERT() line.

Thanks,
Qu

