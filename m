Return-Path: <linux-btrfs+bounces-12964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E630A86A80
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 05:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 098677B6E0C
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 03:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5DA1494D8;
	Sat, 12 Apr 2025 03:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tj2gjaCR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B303F195
	for <linux-btrfs@vger.kernel.org>; Sat, 12 Apr 2025 03:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744427757; cv=none; b=nvtTl9fbgDQh6Ta2z/Ib0AJ3P73GZa4uSzb7e4kV3HJvs/5WWSpNk0UtfEQPYZEQTNaCGnT83VyMigEwQOQ1onHesy/PNjSrhzRbv300sDlLCEfuLpuujrTUYdrKoFiSgBvx+bSGffFYYN5DYn3V/Ui1Lm+EPdl/OdZhGligOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744427757; c=relaxed/simple;
	bh=ZKEi4yoved58Eq7wnCaUuWidFHfSPjr0BiSS02q4ZII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOphE1eM/uSePNAjAZeBDvo0BRW3znDR3yCXafcxbro9Bhue3ZnbueprWQaH5hzv4eD4h4SyUWb4YLnl6V7aTg1ZjkIuYih5y8UNwmBURltOVgfwp6IKS0YGaxdHd2frB1vt6YpJbX9aeSHdmsUsn4c0Kw0sYxQCSswQj3IC3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tj2gjaCR; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744427752; x=1745032552; i=quwenruo.btrfs@gmx.com;
	bh=ZKEi4yoved58Eq7wnCaUuWidFHfSPjr0BiSS02q4ZII=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tj2gjaCRWcot4GdbYPkFxGk6hjvoh2YiIw1z+GgSYDJJvcOM8Kf0p0rhvqliUrKQ
	 iWSanoBn7JkGzdhBtGP2jBVsFtVSxt9rsMZX4ahEynxe2LCMVputequa8OuDq8Frv
	 03w75WR6yjyjMp0d7cVeLLjwnYPi5lUBImJXbP+WFJMd2B8PSAnTJQKVEONnVj28a
	 fXNEXtfsH8zsVLS/cyFsjgml8iyE5nlI6N0ZVjTD5mKwibqLS8iNRstBIZjItqNES
	 /e2xwyO7CvIOKCVs2AIJ54aV7AUcG5NBmJlMu2cTCFcWnPQViuVr//5V02xmdKQlA
	 oS2kR5kaZQao3QT6+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XU1-1syyqn11jF-014KI2; Sat, 12
 Apr 2025 05:15:52 +0200
Message-ID: <c15e6edd-0bbb-4670-a4de-db500080601e@gmx.com>
Date: Sat, 12 Apr 2025 12:45:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to fix "BTRFS error (device dm-3): error writing primary
 super block to device 1"?
To: Kai Stian Olstad <btrfs+list@olstad.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <n2evrtemnyldsra4jh3442h36v2tgi4pem5p7ramknkkabkooe@fre6ayihkaie>
 <084ef89e-7988-4d0a-9d63-cf0a5e0ef2af@suse.com>
 <8783cfb2978ada01ae68d7ae4f9f7c06@olstad.com>
 <3d2074dc-a36b-4fc2-8e20-52cf40584b38@gmx.com>
 <b669450cfb7690e99cc4d9c63daa0680@olstad.com>
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
In-Reply-To: <b669450cfb7690e99cc4d9c63daa0680@olstad.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C1KdyZSj97VHrALEU0Wh7FhVpFdYCHvFJodTxps51pIbXCslTHI
 7PHUvgtDBjcjU9ZfivV4C40BrlPubpisOM7kCydo9VMJaUSI6XcCYQrclU/YalgQmb9NYB6
 Rc9j3QJygC4BYu7bCDeh59NfhQluCLGTTsJRT+Ll0OuRx6Aby2G25HBjK7GMc2QqGCGx378
 bhtGX5GGFwyIcCcY36ODQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bycSuXPNNCg=;AVuVsSt6u3t6P+JgkNCmubZWTn+
 QGff3vAsmdJ6xCKZrhPO6Z+kR+Z0uJ7FU47HbDzv8bdI6woCOFayRULLRQzBdnJb1NFOYUD9r
 eCRiM/++HElx+FNDkacSpg3U1cBt5l3W8+c++SIBSvUZc6Tgz7yxyih7TxD2cFROtruKjfn3p
 bGXWvWbt0nQ5Ys7RNk1p66TxyQqIwcf8Ua9G0LCjrJ2jQvjHf2z7mlfPQfRzgavZjXLVD8uea
 6RsncilBC1/0OMgZ21twZPOq60NjEKx44mYBBzwq/cD6aMieIuauiwLmFg9T89DTMXjaFeP9Q
 x8jDRVnZrSNDBHZ8Nz2ppBNWJw6Hfx/FUPgexEZbatIl5Ta2QHrVHSz3nXyofwlLTbD8Yalq3
 AAmLY8ytGcMNQy0Her/qSmfwCecFpfW+Ru3W/Ch7RuzFJZ9qvrmYaKBrlthdXdYa34kjTcObF
 64mt7p94ZeIJmgANFTr6o4byP5X6CfsEkV2NUQiFGwfxlGBk5QzSji0GLCK0btM6nfmkl3HYJ
 IHWZni78FcvxDcd9JcbRl11Tru+ethcAMr7NHn0Fv8RNIKwXQ2GuVeXrtuP+9s0IopzoZQv5h
 uhxcBMwwcMSYTpdhvMWFdP4VYHDxy7R1U5STv75FoysTA2kfG7KB22dahkkmbiCSa2TIwg0Vq
 TeibVb5C8ggnTSvpF0beUWtx+2JWMTFkecdp59uEwP/kxRcCBeyDc9MHNarEmZ+7BYmXeVeks
 sanojJHQxenlqRr29BD9lk0zllwTCT+pCc7r3oSEEspOaX3Ap9ZDGh8d6uWS556lxs1oh/sN+
 blXr/Dw19sQcHeFUkOZC3Xxy8i4skzAF6pFhTLzzRKdg5rdfPmfDEbGWUellH4wlGRmv5RRwf
 b5ijQ4EWE+Foul8UL6vTQecGNJ4MWDZb9zQy0V2T5l0k2FH6kdvx3FIH/T35LNSvqraCbB8u2
 Veu9kqHvQw0IzeITgPeX50uxFOodm5k5lrO06qChKxzQfVQ04WjvSuB/zsKfQ8GSY9rvtShZ9
 PSW5G0kGaIVdyNGRMfvr6MAbzg5n6tVzT38RclUVrSBXLj5HRDrXrndpBGcqXFU9Fbedu20Es
 Rs01VBnQO+gSRFeVUHeYe1XrR+hby5Ke+7cuLDyIegk0cFB0aOOHszPplfACfB6K6Lqbwz6t1
 X0aVwUTbBjiRPsQX302yeXHC/5ZlD+XJgzvfppUtWqfZrzp2GG31Irr2oPEsfDpibZU1qClzf
 asRBPQs1G7jJnBSTQhkJDGhKguZRzYUUxgLiyjiRi54aupQQG5xu3Rks02vHENuB2P0fzPewp
 yvcSA0oq8gzx7pV0NCxTps/LF1B2B9L5CROoGhuh71EJTWTTiDCgRCkAqt9SbM6wy9dQb8B10
 +UUEMmmIsxdguxB6WX6aT1AcWhVclXTpB480v28VpM/6Rbd2VtTEqvPdznoe2iWuwgAZsRKp8
 TdX9hgA==



=E5=9C=A8 2025/4/12 10:32, Kai Stian Olstad =E5=86=99=E9=81=93:
> On 12.04.2025 02:43, Qu Wenruo wrote:
>> =E5=9C=A8 2025/4/12 09:59, Kai Stian Olstad =E5=86=99=E9=81=93:
>>> On 12.04.2025 00:10, Qu Wenruo wrote:
>>>> =E5=9C=A8 2025/4/12 01:18, Kai Stian Olstad =E5=86=99=E9=81=93:
>>>>> Kubuntu 24.04
>>>>> Kernel 6.8.0-57-generic
>>>>>
>>>>> 2 day ago I got a sector error on one of the BTRFS disk
>>>>>
>>>>> $ journalctl -k -S 2025-04-09 | grep -A 20 mpt3sas_cm0
>>>>> Apr 09 03:16:26 cb kernel: mpt3sas_cm0: log_info(0x31080000):
>>>>> originator(PL), code(0x08), sub_code(0x0000)
>>>>> Apr 09 03:16:26 cb kernel: mpt3sas_cm0: log_info(0x31080000):
>>>>> originator(PL), code(0x08), sub_code(0x0000)
>>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 FAILED Result:
>>>>> hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D6s
>>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Sense Key :
>>>>> Illegal Request [current]
>>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Add. Sense:
>>>>> Logical block address out of range
>>>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 CDB: Write(16)
>>>>> 8a 08 00 00 00 00 00 00 10 80 00 00 00 08 00 00
>>>>> Apr 09 03:16:26 cb kernel: critical target error, dev sdd, sector
>>>>> 4224 op 0x1:(WRITE) flags 0x23800 phys_seg 1 prio class 0
>>>>
>>>> This error is completely from the lower layer (the block device).
>>>>
>>>> Btrfs nor the LUKS upon the disk can do anything to it.
>>>
>>> Thank you for the response.
>>>
>>> This disk support scterc
>>>
>>> $ sudo smartctl -l scterc /dev/sdd
>>> SCT Error Recovery Control:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Rea=
d:=C2=A0=C2=A0=C2=A0=C2=A0 70 (7.0 seconds)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Write:=C2=
=A0=C2=A0=C2=A0=C2=A0 70 (7.0 seconds)
>>>
>>> Doesn't that mean that the disk gives up after 7 seconds, and then the
>>> sector i mapped to a spare.
>>> So if Btrfs does a write to the sector again it will be written to the
>>> spare?
>>>
>>> I've experienced numerous sector errors throughout the years with mdad=
m
>>> and they have been fixed with a check.
>>> Also a few with Btrfs I think, but they have been fixed automatically.
>>
>> Whatever the feature is, it's block device driver's behavior.
>>
>> Btrfs only errors out because the disk reported the write failed.
>>
>> For the detailed reason you should check these lines:
>>
>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 FAILED Result:
>> hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D6s
>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Sense Key :
>> Illegal Request [current]
>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Add. Sense:
>> Logical block address out of range
>
> I'll check them but this is what I usually sees when a disk have a
> sector error.
>
>
>>> So why not this time?
>>> To me this looks like an ordinary faulty sector that can be "fixed" wi=
th
>>> a write?
>>>
>> I'm not sure what ever the "SCT Error recovery control" feature is, but
>> if it is designed to re-map a write, it should not return -EIO for the
>> initial write failure, but OK as long as eventually the write succeeded=
.
>>
>> It should not require any upper layer to do any extra work.
>>
>> But since the write eventually failed, there is nothing upper layer can
>> do, unless the dm or fs layer has some extra recovery mechanism.
>
> Now I'm confused, I'm running RAID1 an only one disk has/had 1 sector
> failure.
> Shouldn't Btrfs manage to to write this data, it should exist on one of
> the other drives because of RAID1?
> And shouldn't a scrub fix it?

Sorry, I finally got your concern that, it's not about the initial write
failure, but the future errors messages.

It turns out to be a bug in the older kernels, that after one super
block write back error, the folio keeps its error flag without clearing
it up, thus it always shows an error message.

And since it's RAID1, btrfs continues the fs (thus your fs is still
running, not flipping into read-only).

Scrub won't solve it because there is nothing to resolve, everything is
fine, except the false warning messages.


In upstream it's fixed by a rework patch, upstream commit bc00965dbff7
("btrfs: count super block write errors in device instead of tracking
folio error state") fixes the bug by going a completely different path
counting the super block write back errors.

Unfortunately that commit is only in v6.10, and since it's not
explicitly marked as a bug fix (even it indeed fixes a hidden bug), it's
not backported to any older kernel. (BTW, 6.8 kernel is already EOL)

Please update to v6.12 or newer LTS kernels.

Or just unmount and remount the fs and pray no more super block
writeback errors happen again...

Thanks,
Qu

>
> Since I don't get any other error from the block layer, the sector is
> either fixed/remapped or Btrfs doesn't try to fix the data in scrub?
> If it had tried and the sector is still bad I should get sector error
> from the disk multiple time.
> But this error is only in the logs that one time.
>
> What is the purpose of Btrfs RAID1 if it doesn't try to fix this, by
> writing the data again from the good copy?
>


