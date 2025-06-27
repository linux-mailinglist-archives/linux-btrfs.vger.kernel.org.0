Return-Path: <linux-btrfs+bounces-15013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A909EAEAB8F
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 02:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F3618850A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 00:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A749208A7;
	Fri, 27 Jun 2025 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mSGJbFF3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6073FC2;
	Fri, 27 Jun 2025 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750982509; cv=none; b=inw7z+SveqTdJIWOrKIDvw8BuOLGI5WsIp1LlX29H2nzDZx6HncI4h1gmmluBpcAa34qlKMchqzqz0VTIC2KoWqLPdZaHsksnySvdCScixgXF2XIFz1w5h0i/6YAf8Nxs2vuz2nA0m+sKyv9ESJFybUQAHq2l/BZBLtgTZPaqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750982509; c=relaxed/simple;
	bh=rvn7BfMhgKqcfauBZYrXSIVwFzqP63Hmd/6XqkQPOZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qW4jqhS3RT8jwUNumXq1w2DlvuVJe+UBDZ6jKbwSQLB01gtm+uOIJQr4PfdCdz4HRtBPg7u/2GyCq1SPVCBjkBWpgJjWIFKviA9VarbEPtNXqgU68phqbicdzAKvIj+SSRX9nU5q2KIDqHJZBE4HO1lc3FdpeSlv3gU/sRlxbr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mSGJbFF3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750982499; x=1751587299; i=quwenruo.btrfs@gmx.com;
	bh=Nw9Tl2xRhN9LkrrotgXG51hCtFmruE8LIxuUTDSdP4Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mSGJbFF3pCiROGcTAl4J0tc0AjyMoQ9wbWdL6l/qKuF7PNLStNg9K8w7MmNWYuU9
	 SFBWZIDAYlTsh3HayKzx37KqvTqtWGaKnNIkgOpMWT/WTE4uH9+QOwkBWfb1/RFIi
	 0+mIhbF24HOLX8s+LAtj0foN3CdZveSdUNYl3tHckgv/mSowTzY/iaQWBPD2tb1ad
	 DUrsHVEkVypmHMu+tquQjgVb93dWxXV7uzYSvozgqlZ9gvADI0XshE1LZIo2zEwfP
	 LiL0C9Ue/egEr3uIY750mTw2Ym+kf+TidbVJ4AWN24yT+bsZWl/iX2qmd7vCMrEGZ
	 0JyNI62WXx8Wa6XfJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCbIx-1ue34T2oIF-0024ml; Fri, 27
 Jun 2025 02:01:39 +0200
Message-ID: <bfb89482-8c38-4e40-adb1-a7c60a335679@gmx.com>
Date: Fri, 27 Jun 2025 09:31:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in
 close_fs_devices
To: syzbot <syzbot+772bdfe41846e057fa83@syzkaller.appspotmail.com>,
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <685d84e6.a00a0220.2e5631.02e4.GAE@google.com>
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
In-Reply-To: <685d84e6.a00a0220.2e5631.02e4.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cX9EFz0JK/1PuKb+mHEA5t2pcsC+m3rbr83yzyoJL5fvuR5Y7Lk
 ZzrvlZg7fDU02qqmcNi5wmz20NUUW2hxACqPaIDe2OwDk9JqzWNyVnu2uENWPn6i4pj6QzY
 d5GgQHzmvA30xuATVEFPhcj3IvRATc1o6i/Jan7vScVX34eYp0GjavO2c+mr3/SyYdzuJud
 ZhpwNh7Pfgu/ATe+ovMgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LyRb5zSvDc4=;cJBE12dSQRo0sOaXA2T2JzQHf5I
 9LhakKySfXbpr34BVrsEf0idoc84J0isVn2kua8fIIYnzNQhq19QTSTjgrLcZ6gnuCo3+G7ON
 AonRy3XN/+Ike8ZcA4F43+gF94z8TcIhYgUCs/mcYbTj/9GaalIb+tyFURLTCiGOWjf0yS8DH
 Rwl2a/hYqAO7Clw3O3MFVnljWrXLEjZaHvXz5cJD/o2mvqLO6NQ7reRVK+yWdPVUK1iaP9QSS
 Ukc2xDdbiHoqpL5H8Rh6r8yxWryfgLFqAJz+6h4LALRF9whSxtL/wjCahrqTaQdpiS98lQKRN
 xsQkoo+yKNueRzwSl2chwxe5tOLExmrrRPYFE3Lqp2QCDVGVz82kkMHWHa4u/Lee0FhjpxBvN
 57JZYht7xNBHQJ9qj4Hg22dH+XAsBsAIvOaX08OIIZ5T0IgNxgZLURZ27X1jxST3nNaFlNLoI
 pjhSyJd5dN/WzBTPvuWXvRdPK/I+/OgYquepKrbNzPpsK4UTFixmkJh0fEm8ni/m3vOE4qqm+
 W2DcFIYJo1hqu71+j35+thhWf/ebCRI+gAsBcJOYsmilaz7d74TD0vqsKsZ7JEUvPcwLNZk80
 atlOxQabCoES8X6dgu9CPzjQHGuGqnDwOHde/kF2vELP3LvNPEykG3r0m4QmUGWtxlS4hmSPG
 3DVZjRakw0KxiolYhxT2I6sO46v2KZZFgYQ2g6hwhPieoYDTmYcT0ildcK/EIkXKujr6E5sJB
 fCpFi5rB2/jAeGcPn/uPUDF0VSz5eL9pC31ffwwOWNldqzsPT05NKphYP9N7hudAmsbdFFclS
 GXy6o4WQrVV1hvHHVNnR8EZTdAdJ5cQI21HTWisP+nubWg2WtAnQmcOwWHlgU7Xv54RqI/TLt
 MdOY1TDWYuNRveRK/lZ04W6k9+Ihlu3ZjMhnukMAvDo+tuChPp7DWMs8vl9VHqFgAEEJRcr8n
 5Q9ulJTZc7uTjJI7k5e3rRTUrxnAX5e5pIGfZFXkP7/b+V/0bShcGfMA5TXSUt6D7S4B7JkyG
 QwEIw9yJW7Fxvb66D/L/6HGbCRCbCI4vor9POy092Aij+7o0PmWqBZ37KoQgXXeiC+3sN8XMw
 AG32N+g9kdmOZZAcJ3KqOgCefode0I5oITH108gayEgz94+t0xSzTDKeA+4VDix5CTRSQGp5Z
 NflzJb1/xJgk2A7q5bdKitmBAELXhO7rv5mq1be2+GcsXZGQSUM2BnZg6eg2q/kqYjy+JN/8t
 wSWQXnswdzWJYP0sevyNNjxpRpK2+qcZeSfi1poC3SczRpF8X3ggusNiYVyC9odw6DnG60pcd
 GHUlznt6wJPI6jKXqt9FP2RrlaE5/O20DGG0XiUx+/uaOAdoEgT99LwB+0hN6dyap4C4gz3D9
 w1gIHHT3zBb/VWTU2MuJKO8ZHFO/jz2sQmTYAD17ndFj0GKeWWN+Nb5bdvdqlFitu2Q4b0nob
 kRZQ+hVE73KXvhJus1cKEt/Q4HcBOlvjVapD/8YdJlVRQL9/48RQiA9GIxZBChhfxy+X851W0
 HuzhWatkLLzR36qHLlUIw4a1Jt7OvTYoRvM+m4O1dT1Vyj+1GpjPuDdj1YsJ18+37cC4gmbQI
 OiH6pApooHbN9IgUN0mQYmFfXx8qh2dUtSlIFp7e9AW/Yol5Pp1wRZsHmLGN2YqL35j2grW8f
 6a7RhodpEBF544OhEKAFUl35/BVoHcnxmRscHm/S7OPnr42rxUeJAgeD1g0LXwL6rkn/giU02
 5Z4U2Hrm1fLjF0jRKx7CTW9AWc/RoZ1jDaD+q9c7eGt016j3Li6iU4huesGYsHAMskX4w/KVx
 F4XYKBKSImtx1Z3KqE3ad3wrKIxZGdXjZekBaayEEDn6DxuSD9iMobtO/29L7aE3Rs6aaOUQL
 IyRH8zWYZjXXYc66nsPYmaclbqRGgDzxbWl77sUEc2utoDQ0vO76huIeTXJ+/dUDJa8EvGlJ4
 yV0oipNXn+eUouhE9Uuc35aBIYtndABhizF4VXes2bKw8WQjpwsZ8+8wyfazPqf0XMi8e2QCy
 MG5FziuwlX+R3EzOU7mUcaUP1SzQ2T5KL2Gf7dvmpmTkMzLPQv1Qk+NgvgBLg0hHJ9KWChmLB
 zNM3qLvYo2LwtmgBMteqd8W6Ip9cf2vh7JKEt3tOO1fd+09f42NE062hrOY+OLmr3wOtaxrR6
 DJyTk+/epmapuAfC8qKf5jEs/b4DJsX3yvy1NsGsZ4nD/VofxH9xcWlPmec6AvXtVcqlKasqe
 Ja+JKTjaS8Mwu8uX5fW3Vi9JRimtrrM2QjUbJfIZe54gvSvi/Sy8K2HN31yz1CMq68DszCtPY
 kNURmi1kbydkg1sXyMx/uwAlH7+XfzkhBRHpxX5JFvncAC6mMRtH+8zobF7zCytmDL3UowjPg
 j0rtSrQiSpP2Qf+43x1qFcJ8FqnUJeCIY48vUivqPx+SkmMjqHOX3W1EF/WbMkUM3evW4X38q
 Eu20PfCCZQ50yF8U/G6E15HDrLP+EhaGDExC5UpFKjYfZWEI5qFrpDQkPa1QywCMWGe6l1XCx
 BFL0sQ3ocuR8yUUXsI8bM9YUeFlvrvEGXKBMZzTmfotw2LNhUP/zbtW/UXJ4PHxCNOMeO50U5
 O3r9/sqeRRtOsZQs3rjWRdmXwHZcGKV/10qBSKUVWVKG/1hNOBAyg9pXwyyiPLIFh+YBaJAa8
 yCQwFp1iBf57VzQvI/6qdrUhjgsSeI3MMRIck7uJJNb77mj5l7+6t+q7G3aud2ROoJBMlT5R6
 MC0VYSl9TSHE6lRubg3oMVT5wRPYfj4Ukv6osCbQ9EwBEfx5/AdUROZwxscvEY/r6141FLCg2
 rOUZQNJkmPpKvD816cZM31dV3K2shxXlIiThuCu3dVkHEYFM5hJ+HV2Ys/v8U7+hFgzTbzC0g
 mw+4MJ3DcMAWOdisg4nGJLCxihiWazZrOKyWun7Ydfl1ejTWKcx7VOWok9ZMIrbPm735kW26K
 M+vnDmENdAsQPmrH9e/douyVvMM20fam7H5ZRUhFVxS2Mnx4npVhAKS/6o1DHSaDm7AaLKY6s
 bvJWiJf1DHNAz/F+aZ35Q06aWqJ0QpcVoR/JZ0jUZl467UmZ52VNz47PTuAWjkT8Yb8Bo+dDz
 5hccjXt4gAzPtoAC7TeyuiD5nvsINL5+jzDvv8dhJ05yUSlBwGJ3ZLabv9vmk7niy3sZ8IoDU
 i31jIOtuPWyVOZRNwV4BMfKWYdvWRQP7LQVi5OsBDqpHteFW89LEI0BRthL3jYqo+tLgsvnd6
 kiwpGTBdQs+W9LHYnm+6f6v6rm+RzfAWboBKIJEIcvXw29AsJWDfhD/ZgUiMq/FFqykLnHdwr
 Pp4njiLi4JB9eDXL6cjfupNgtsbY9PwXr3gg+Y6ZfG7f7X2OIRAOTCoVeEV7yXMsafO3PRBjE
 XyVre3B/CJIB0wpzDqUI0XCONysymzGnODWSz+FRaB3S88d14eTgB7lqxgG25NwXkcO64MzAa
 TSWPlG7WlHvSaLXS2hSWmBKB1E2VZKZ4QTcePegRsAuvXZ0d2ZKOH6TZbF0Xgbb8AijM84uxA
 kA==



=E5=9C=A8 2025/6/27 03:05, syzbot =E5=86=99=E9=81=93:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    ecb259c4f70d Add linux-next specific files for 20250626

This head already includes the latest v5 update, so it's not a goode=20
news to me.

> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D111471825800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df0c48ed70f20=
d0d2
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D772bdfe41846e0=
57fa83
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e077=
57-1~exp1~20250514183223.118), Debian LLD 20.1.6
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a6a71f1563ce/di=
sk-ecb259c4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/914a0673e6a0/vmlin=
ux-ecb259c4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/87f7194e2a0e/=
bzImage-ecb259c4.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> Reported-by: syzbot+772bdfe41846e057fa83@syzkaller.appspotmail.com
>=20
> BTRFS: device fsid a6a605fc-d5f1-4e66-8595-3726e2b761d6 devid 1 transid =
8 /dev/loop4 (7:4) scanned by syz.4.616 (8589)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in close_fs_devices+0x81f/0x870 fs/btrfs=
/volumes.c:1182
> Read of size 4 at addr ffff88802fe14930 by task syz.4.616/8589
>=20
> CPU: 0 UID: 0 PID: 8589 Comm: syz.4.616 Not tainted 6.16.0-rc3-next-2025=
0626-syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 05/07/2025
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:408 [inline]
>   print_report+0xd2/0x2b0 mm/kasan/report.c:521
>   kasan_report+0x118/0x150 mm/kasan/report.c:634
>   close_fs_devices+0x81f/0x870 fs/btrfs/volumes.c:1182
>   btrfs_close_devices+0xc5/0x560 fs/btrfs/volumes.c:1201
>   btrfs_free_fs_info+0x4f/0x3c0 fs/btrfs/disk-io.c:1250
>   deactivate_locked_super+0xbc/0x130 fs/super.c:474
>   btrfs_get_tree_super fs/btrfs/super.c:-1 [inline]

If syzbot can provide a better line number for inlined function, it will=
=20
be very helpful.

But so far it looks that btrfs_open_devices() failed, thus=20
deactive_locked_super() is called to free the whole fs_devices.

However since btrfs_open_fs_devices() failed, we are not holding the=20
fs_devices opened, and after we release uuid_mutex, the fs_devices can=20
be freed by someone else.

I believe we need extra error handling for this particular case.

Thanks a lot for catching this rare error path.

Thanks,
Qu


