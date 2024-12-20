Return-Path: <linux-btrfs+bounces-10621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAC09F8E7F
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2024 10:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EC016C3F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2024 09:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D235D1A83FC;
	Fri, 20 Dec 2024 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lrzL69b5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BDD197A8F
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685285; cv=none; b=DSqXEmkzex5C7kFRucHMDdGAmJ1pC1jXXRkzQe3/pC+QhNDnPDbqHhH+HYgpA3X9VFDaeqAIA7HdGD0MDTpjwjzrICFW3+UcwpCAsQzYBWCkKYJgKt/5KyWH23oybHTbcHMaKSE8U0mnFElQC5Hk3G8wtOWRN1j8JZL/h2vwBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685285; c=relaxed/simple;
	bh=z5yAFMypVtc/qM9ZSuXGyVobzSrP2SMBVJQAcNAg15o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=exIuPs/arEP5lxVfSkKLBnaJin/eLNoanUJlWQWP4Emi8+yhIPZgpfxC81GLEMJKRLhz22lRGwSm3p36/mscGoZj9/+Ckui2REUdg/mRTfCYvz7MkFRuLUIRfMFsXtD4r6/jLi97KSfdFUncUTFUVVF+oYuNoBhpf/nK9Xuh2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lrzL69b5; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734685280; x=1735290080; i=quwenruo.btrfs@gmx.com;
	bh=z5yAFMypVtc/qM9ZSuXGyVobzSrP2SMBVJQAcNAg15o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lrzL69b5baDJXp0xSupvkCUaF/XKIMpY+E0r3fwyk2aGA4WKImS3xVhjDlrFyV6H
	 ag7hEP7ooAHc2RE9zaps5NrpF47TFsaEfIBab18NsXxZo+RqEdezPjvjgqOh0NL2q
	 dKyxxJScxl1C/d74a79j7eKGs70jR8B0HUXuIyUnJBi8RXP16MU55XM9QAaFFs4V3
	 xmrvkmoJkrlTpuUhgRxQVFwH8TzRZcGRXLZDT0ot8mKBUfQL45tO6p+o6Q0edC6o0
	 O67xT81DiGpRVZNRGd93zM3KKE6la7/mLJ5B0j8dkXb0BL70ko+ayUlT7fPwIH9wa
	 GOGZwq+Ci9NL9lVBhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHru-1tj7hd3Y1S-00vBQT; Fri, 20
 Dec 2024 10:01:20 +0100
Message-ID: <11441698-92d9-420e-bb32-4b868656da5b@gmx.com>
Date: Fri, 20 Dec 2024 19:31:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs check reports backpointer mismatch / owner ref check failed
To: Clemens Eisserer <linuxhippy@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAFvQSYTmpGK3w_07RinTWXzgsnkLr5TA4me40mi-evYqgkBQZg@mail.gmail.com>
 <77fd84f1-9012-482e-8f72-5d7de752d5c1@gmx.com>
 <CAFvQSYQVS7TJDQ19JAHm5Dw_Qonq_qZuevuGPwDnVay8-kUFew@mail.gmail.com>
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
In-Reply-To: <CAFvQSYQVS7TJDQ19JAHm5Dw_Qonq_qZuevuGPwDnVay8-kUFew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6AjZkcHnGNbK0cWLMcFVZSye893Gk2M+Sw6FXweCt0RUFIlHcpP
 1DcqwwZFQQUpFQ6fAR5iVrw0UJcDfK9PusCAKhddd6xNo7t3kNRGHl2QkqKGGjtHwDszrH4
 bx3bAxcVrGpTDBXlXMmPA4z5V1kcXZ2wtoJb5oy7snMeKfd+A8mHvpjmPr4p8kuDqgOpUGo
 gKkW8KsOP+P2cMiifwmtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LsKoOaj5lKY=;y4L11qITbWde0eggHYzzWlARpS4
 OU0eQlh4UEl//+c1tsMX5rlBI6I89xFAZqNMvuGHYeDCLNfPt0ZKe5KEoQqCR2EpHOxQpQo8A
 XgbEawHlFfF2eEZALr47Kz6Ct1KkHdK5jFCLAupihKHas3Er+lp/AEb9kgnUvP6VCMXN17Lsq
 txX2VGatj3LgWAngnLdy1mawMnO/NeVyUyPaaRz/TjQqznxD3azOlfkImn1QzwVdbAJkgATqd
 PosspTwunpGfkh5S/qZ7JyG82gyVlsDjQojHdxxaCZ9xAyM8Wb0Yio27dI7LWbGpnvJTUz3NE
 s8tmNdT4tmGoXn8vZ0BLQjM2z9plgbr9yZHpecr0mvwAfUh+wQOOhUt3H04qt+ptQ1FWuiRPs
 YbhxwduqaJq1eVa64d0eNPTgS2TPvcmk6u2DhgP7u3oeFzwtoUQMA4di5za+tWS6sIwSs8bSA
 483fsiuXkLeUxlpi6jcb3ACOOk6Ob1KPY1TLUYnee49zvfgTO59Lvebxgu3nCHuENfVKQ3g6u
 2AXEwmx78qcA0C0rjyvs7WVAxEZmWrSohKJQERLrFEg4O+htS+4327ipLKkF0VXqOGs5wjxlY
 kFxxEmXmKroofIFdnPA7J9gOCklc6X3SHChq2YkXvsXLvpmVHUyFzYx1M/2b/mfPjO80jyh82
 VkS4xXWJKp9//hwiE5VusTnG/2AhEuIEchmtFp4GQeT+APsjh4Mr5voZcJErHVwK9YheBn4oo
 FPRvOhQeLSYCT+kBMfWf1+GjzyeGE8Op1PHPf6POW6a2gSpo8VjBdaH8R0ddhy/0e6lWfMmDK
 teYFIWkfrBWsURF30lk93aZNC0jFZnRsW9UqT6EjgDm5ZDSx+AoQyI6gC9QgGZnfY+tcA3y/3
 SMgyu+wBFX3AvgFzV8QIHWpf6dzN7Y8AtgG2lNEABxkxxwkaiU61d+YLz7E1TWycMNuH2CPpn
 b/LhYGeHqPi+zY9lLgxBKysNWYVp0vj/hTL9Xh/XHrrqNba/yrrxAR/NmDydiStSFbvIerr+X
 W4HucziHWQJRhRuEQOUYizCw9kXFogkPcbv1VqJFfteYYMx7qpCFXKIyvvfXmbW9OBt54xCnN
 kVtCep7lcSjtvEyj++rHkhBosttI5u



=E5=9C=A8 2024/12/20 19:03, Clemens Eisserer =E5=86=99=E9=81=93:
> Hi Qu,
>
> Thanks (again!) for taking a look at this.
>
>> Full output please, along with "btrfs check --mode=3Dlowmem" output.
>
> Quite strange things happen - all I did was to execute my sync-scripts
> a few more times and now the original errors are gone.
> Instead another error class showed up "shared extent lost its parent"
> - interestingly the same applies to both the internal and the external
> usb drive.
> Excluding the possibility these errors can propagate via send/receive,
> I don't its hardware related - two different disks which were almost
> exclusivly used in different systems - the only commonality they share
> is both have been kept been kept in sync via send/receive via the same
> sequence of commands. However, if those errors can propagate via
> send/receive the previous conclusion does not hold.
> Memtest ran on both systems over night without any errors.
>
> btrfs check --mode=3Dlowmem output of external usb drive:
> https://pastebin.com/w5hWYCnL
> scrub result of external usb drive: https://pastebin.com/aYEXM1ps
>
> btrfs check --mode=3Dlowmem output of internal nvme drive:
> https://pastebin.com/NcQvgMpr
> scrub result of internal nvme drive: https://pastebin.com/0qDWxA5e

So those errors are definitely not simple bitflip, the subvolume tree
block seems to be lost, without other orphan tree blocks.

I'm afraid it may be a kernel bug.

But the receive itself is not that easy to fully reproduce completely
the same layout, so I guess something else is involved.

Have you balanced both filesystems?

IIRC Josef is looking into some bug related to balance, maybe that's the
cause.

Unfortunately I have no idea nor advice on this situation, except
backing up your data (in fact, your data should be completely fine just
reading them).

Thanks,
Qu

>
> Currently I am on kernel 6.11.11-300.fc41.x86_64.
>
> Both partitions (on usb and nvme) are encrypted via luks with
> discard/trim disabled.
> They haven't given me a single issue over the last year of use, I also
> don't remember any errors/warnings in kernel logs regarding devices or
> FS.
>
> Best regards, Clemens
>
> PS:
> All the sync-scripts do is to create/delete snapshots and perform
> send/receive between them (in this case extern/usb is synced to
> internal drive):
>
> btrfs sub snap -r extern/root-rw extern/root-ro-new
> btrfs send -p extern/root-ro extern/root-ro-new | btrfs receive intern/
> btrfs sub del extern/root-ro-new
> btrfs sub del extern/root-rw
> btrfs send -p intern/root-ro intern/root-ro-new | btrfs receive extern/
> btrfs sub del extern/root-ro
> mv extern/root-ro-new extern/root-ro
> btrfs sub del intern/root-ro
> mv intern/root-ro-new intern/root-ro
> btrfs sub snap intern/root-ro intern/root-rw
>
>
>
>>
>>
>> Nowadays as a usual precautious step, please run memtest (memtester in
>> user space, or memtest86+ as UEFI payload) just in case, after taking
>> the lowmem check output.
>>
>> Extent tree is the hardest tree to verify, and since it involves a lot
>> of cross-references, tree-checker is not really able to catch all those
>> problems, especially when hardware memory is faulty.
>>
>>>
>>> Should I be worried?
>>
>> Yes. Although these problems should be able to be fixed by "btrfs check
>> --repair", it's still recommended to start backing up your important
>> data on the fs.
>>
>> Thanks,
>> Qu
>>
>>> Those file systems have never given me any
>>> trouble, I was quite suprised to see all those errors when checking.
>>> Could this be some bug triggered by all those snapshotting? What kind
>>> of additional information would be helpful to pinpoint this?
>>>
>>> Thanks & best regards, Clemens
>>>
>>
>


