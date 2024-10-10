Return-Path: <linux-btrfs+bounces-8769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8880A997C09
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 06:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484D528219D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 04:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C0119E99F;
	Thu, 10 Oct 2024 04:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gHvFXCqB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6E4A07;
	Thu, 10 Oct 2024 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728536114; cv=none; b=rh0GXQuPCWj/dZQpFUOx6f2MqYrmSYWL8ncu3t+bsY08MFcJi7ubRcQd7tJpWfHYYs959ghngEw69VUwYmJBT0rF0vjcfMMKsGxvaaC08u/YWPEReWEZZBetrDwXe1JF6rKMkUdVVQXkmb2/3gu3yBh917YYaaixjwNJdyiudqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728536114; c=relaxed/simple;
	bh=0ycgFzG6NNlDKM6WDRbJLQ+YWe0b79oOxBvU7BFicQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rZby6YNW1Ar/vlRKt2/JuzOrmoBaqEJP2YfH6OA6Uxh1a16j4qTsjn+FfMXzRnO268srFpGXzBU/f4It483yn8N7mQHHgfs1N4xX6W/dJLDmo2P5TY3i4MefYwfBXiNF8XBmkC60xscTM0aRXrguxvBwHvOS/aOLa3uGJVQ+rLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gHvFXCqB; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728536100; x=1729140900; i=quwenruo.btrfs@gmx.com;
	bh=BVYYFj9qlqzs1UPIhYcWcNgGL3VMosA7qloiuo0GmHQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gHvFXCqBgOevz742iAehGE35vdbjr5xFbDv8TK15omamecPmeBzWRE+yHVmToG9F
	 s7ivhzRzC2i2mXYGKoC4z1y0c7IY8syMxHI/13zooSiLjr8SH0SlqBpN/u37/q9cI
	 11pLETAW9VbNKeEyn2UBWSONntAvuAUTGRFHg21w5371wWbKI4vvWR4c31XIc8z7R
	 F2lrC19uup0aaBg7HaC+pukBxuWG1d+SZSlioxzLOa9syrTX6eMwolLe4nTiPRfc2
	 sNcXLDtxejpAFj/SlMrwmuXu0XOwkNrDPPwNAE4G0x2omGj1e76tnnWFZFsacLXRl
	 6RKhKX7lObXKrT/JxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1Ycr-1t07qa3JaV-0074vp; Thu, 10
 Oct 2024 06:55:00 +0200
Message-ID: <e60dc0b7-4288-4f8a-9307-9020ab663170@gmx.com>
Date: Thu, 10 Oct 2024 15:24:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] general protection fault in getname_kernel (2)
To: syzbot <syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com>,
 clm@fb.com, dsterba@suse.com, eadavis@qq.com, fdmanana@suse.com,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, wqu@suse.com
References: <6707584b.050a0220.67064.0059.GAE@google.com>
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
In-Reply-To: <6707584b.050a0220.67064.0059.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fZ/lA9ujWxCZTkY0+gLwwnLwdAHQkrFMs5mg4JvRid0sIHsCvsN
 dCXLvEg4bdhCwKWdEYIKIascA2UsmAnXWEPOESaUEU2VK4wpO8cLZ/5j2yCdZ3hXlG05dHQ
 fDAjovaG4NIbK27hl2ccTg8r+JuLwEIndCzOg66gf4hewz73RR9Hv/FEt4lhHink+vo8njY
 wnFXSE5Me2fdmVKIR9fDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gJZTiGUB0mE=;y7/47/b8ES6/Y1kzzsHZ/TVIXJO
 r3GCk9ZWFDiYnpQ3HV0JlwvOSPYo6HICoP/gqfuHX92f1QhoRfcPZHcDw0R90I6qgDC0rO39U
 FKxrsUsegcbgn41u+9IsQsiWg68jQwc6X4/QZJYo8hqQNfFxZxsLSGskNFfgEuLewEGXhCOxy
 8gRdTz+FYCaLkylWoWdAkTRf5ceafKuOtfMirhMXRe0FJNX3oX2NV/7mCdTMY7pzZ8gEFXfek
 PFwpbz7t5cvSYAC6VmeNSyviEqYeZwOhJiTQQgV9UofFqPJodc5kT2AHzvFF7eeE7zKJSQXOy
 LbURN4xVSWq0ytunTZascSJvMTjeOwql+sZBjIvD8+rdzynwsH1KKYKtbtFO1oyuvlCvo6O47
 v2UG6o68itf4mudQl+2fGZbwhc12hPIGoXUdLQG+GznigiXcS/lflf9BgOBXI33Brpjt3OFqD
 ZWXogJx9H5Y+zDjaL9/SE3ivOwebvn8ojoLZ4kSJOYwvG1XqSYPGo8AzboPnVURQMqiAFbCof
 G/PlLz/Cz8PVPd6rHgLY6s+IC98XTRfjiTy0JNOsT7TuLD4rOnpg8YQSJNJvvyQWmXRZFq1GW
 UnKXUiIco39GNy/fql59Sg0I8g7CYT1fJaS1mhTp40b5wLSV8PR6009vAPJp81UkpkDsrfdmh
 dwSrmBCki7JuHSRah1LT+dlLpKa4SxIZKH1aJHeZERIuIs8wbSPpMaU3o2h703EHvyjcL+iPE
 SOhDgWb0RclietxomcGGGp1uotX0L6/gnVYvxiB2ljUGXTgmS5M79LsnhYgcq8Z57VG/lqOgY
 NVGjwH680TX6KpfTBfGDgRleCRIit0KilIRN64UhnY9Gk=

#syz test: https://github.com/adam900710/linux.git subpage_read


=E5=9C=A8 2024/10/10 15:00, syzbot =E5=86=99=E9=81=93:
> syzbot has bisected this issue to:
>
> commit b4b3fb6c00f37a9da91022adcd83555bc339e044
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Tue Sep 24 04:57:07 2024 +0000
>
>      btrfs: canonicalize the device path before adding it
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15744f079=
80000
> start commit:   33ce24234fca Add linux-next specific files for 20241008
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D17744f079=
80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13744f079800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4750ca93740b=
938d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dcee29f5a48caf1=
0cd475
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D160ce32798=
0000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15ea77079800=
00
>
> Reported-by: syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com
> Fixes: b4b3fb6c00f3 ("btrfs: canonicalize the device path before adding =
it")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisec=
tion
>


