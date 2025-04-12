Return-Path: <linux-btrfs+bounces-12962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C977A869E0
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 02:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84FD24A312B
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 00:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE645BAF0;
	Sat, 12 Apr 2025 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="m1oX9QuI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FDB481CD
	for <linux-btrfs@vger.kernel.org>; Sat, 12 Apr 2025 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744418612; cv=none; b=e1pptNi3Ju1Pe/0TMPfUC68SkoInQbdy8nFrr6Ei634Fde7vU1pNNb1+f6xGVe5gil+feZmg+heWdmn65znpne1PBrsfnv1skwsm2knoETJtR4ZpIFCIRy4RL6CHXQrbF9tkVFLudgRQN/49RfFHBhN+Il4pPz3sq8xoGSmfxwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744418612; c=relaxed/simple;
	bh=hS3Ixu21LnIkhGbLTChFZUrAqhfSzfxPt6eBnbbLeNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKZeR4wgAkR6geIeEIj/OgOnTjUv6FDbnXC1YZ33UzCd+WFwvxghCbuXb+7y455XbWTOG+dQKGz7hlSLoq8Wq3DumAxjavKy6KjLBBHCUaMUy6Rhs0LMg4fc9OjOYKq2irbcad1hmu+A3LW2Rh9eTQ3u8mhOBB5DdBNOLcR8xR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=m1oX9QuI; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744418608; x=1745023408; i=quwenruo.btrfs@gmx.com;
	bh=XM0dv84p4rpfSoskxgjC1WKl6uJ0zztldbmUIUIeBwQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=m1oX9QuIDrY/CgBsJMTBSxDPSfZCVoxHR+XlyNiiyvBq6BwTsAn0OhBZzq18EKQg
	 mF10I7BuU0Dg92pYhwtel63CBaRTwssjZ2rYACait8R3z8RHRFps3K5m9KUO3o7b4
	 CPGsZKFw3aE/kdrL5XNgkwTAM5ttRSJ0NcJkOgIM96/YjpRtttUk0DBdtcT7xHeZz
	 WoCtL4TKShu1fb9BA1m7V5twXBcNGYnDaukoCYQdG7HRjrCDBiS8cEWiE1mWnI9JT
	 0iVJgnDDp6txk6X9D7ZiQigmfj5zKZHOoRCtQjCjzEpfJxAGylcYnlEFSQf8yrneZ
	 PIsV5AdcoiCBIxuF8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfpOT-1tNBOY2SoT-00e3g1; Sat, 12
 Apr 2025 02:43:28 +0200
Message-ID: <3d2074dc-a36b-4fc2-8e20-52cf40584b38@gmx.com>
Date: Sat, 12 Apr 2025 10:13:24 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to fix "BTRFS error (device dm-3): error writing primary
 super block to device 1"?
To: Kai Stian Olstad <btrfs+list@olstad.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <n2evrtemnyldsra4jh3442h36v2tgi4pem5p7ramknkkabkooe@fre6ayihkaie>
 <084ef89e-7988-4d0a-9d63-cf0a5e0ef2af@suse.com>
 <8783cfb2978ada01ae68d7ae4f9f7c06@olstad.com>
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
In-Reply-To: <8783cfb2978ada01ae68d7ae4f9f7c06@olstad.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yRvQNuKf0USI/WqtEy7loUcQ+MztO6YqzKixPi+TNCAAuRIcPxE
 vXoeiFs+xEJ9Nh2MPgVraczeiHquan3RoLzFrrf50zeTeC8UTpb4BUgERBbmmNbZwYiaPkm
 VUkAKP038/XAOJ+IQNqRgqKpzdnNgDzOcfJU38a1F7+9u3Omwqmjqc+iQ38l951vBcS5Ubh
 oTgLDJCU19I741BqoirZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wm51g0ocMKw=;zXq6jYM7o4pHrckreKA1TijtIz/
 kQc9mPqyzIUNmKgrKVhL1mMnsOID78vHSgqiRR+aD/6sOYXrQxua2fm1F8sE/VAuCwjcaT+qF
 su81obRvqrgS6qyt/4o56uOg2K/eR6P3R/CRh4JG+RcQ4smFFiaQ8ey/e4DraqxCw8KNwWbSv
 E5R2FBuOb0I0Ky88cRvmpnrkpHy/AaPgtKHal7L7iadVBihcgQkAxF6GqPYN0uEU/9N1pZRKx
 G4pBkw88sJxZsfyOz8iXfmFtObcYc8p8XUq+m0UIhBDtJGJeWZEU/Ll+vsKcfUSfgzOaq0QVW
 JVooFOIq422j7OpfX7t4fplwXsX7qenvcW6SxKGu7SHSWDyL3rY8IrU2NdiHC/7AS1eHqfQ5r
 TuiQ25k4s5sJMbOVdftFgDka5AOGsQWzDFw8pgKxhh2QR9uoQw7cXgx/6MwM2miZMDHorybiD
 P7lOkj7+Uxa92fXLqUVc4n7JWlK1bIfN+zL+ez2bgrAXreakIzyFxF/6kllLbq/RKCiHCyO/H
 fH2eWK2DAsPvEW5PpCDNZqsFdgqKXrgCO6wB84mkdRX2ERQcnjgAiimeeUO4pzLSc9MHTPbf/
 m1jAFZUVu79oUbjGw/wfjfT2EC2AxZ4m3NZU3u3OAuUORtWBlIwQWUm6B0XlsJT+2jhUYo4Ln
 TFZsTubDja7ivfoaTt6H4u+oBgnaY680xkL040lg8K6Lmgho5VJeSy8MFmQs48Q7d6r2iMM/K
 nmeZrUX9vam+VqHmknUjSvEKeffjraDFZMne6j7Z24ho7uqFjeGJm1he3uCxEJ/Z0e+TNGcVi
 72LajCaZZ4tGc715TSeTxa8RYMCxdxnfrdNnSjdJQZ7bnJfTVwnRvsGa6cfyrNfi5tC3mx49/
 o6fpP/CpxxgDzaDNY2kb0XjD/SciEiZjJRQJotXDr4f7BOUWveYK2upPtgMhTLl1WdlCtsH08
 ek/R3nhuS3t7AzFXLvk5L25zG+l30u/wzLAra45GOsM25ESPc5SI40eTROpg3ykQHOY8KxGbs
 tnGE3u0whfxJwYyYP1WAot+eBkPcrizjz9sENY2dcfKdDCchRylvAo/GwFGEQvdmWNN1ehgXd
 65dKpIs9NRQDClAfD+4H0CvN3C7jM6O4cWejDZxB8OlZgB65Pjfy3Dn+4upH3x/Qf9tYUq/tD
 LzH+Nc1EI60bUHkdbhM2rcLjb8tBexnrwgbsFC7kl528nf7i60QvukO0eScZJ20u1LDGKJ2k2
 yaaCDG+rXiEXbyTYfMt92ZbvNJX7pjUQE37uPv8K8FMXn8JDTyAJ143jr67Hqqu7Of4X0HIxg
 16JbNgh0lbYnrSaFc1l8zbfWP12V+YJgYaP3GUrrjHsxSOURlwh7x+Wust82Y2xwpWRTGeyF9
 nfKb/lWV6lGZhj9+VWRA+TqT3gYReCYMFBYmcKi/DUXHelPvlVwm8nE/pYcHqSNXOO/fNgY8u
 EA3n9bA==



=E5=9C=A8 2025/4/12 09:59, Kai Stian Olstad =E5=86=99=E9=81=93:
> On 12.04.2025 00:10, Qu Wenruo wrote:
>> =E5=9C=A8 2025/4/12 01:18, Kai Stian Olstad =E5=86=99=E9=81=93:
>>> Kubuntu 24.04
>>> Kernel 6.8.0-57-generic
>>>
>>> 2 day ago I got a sector error on one of the BTRFS disk
>>>
>>> $ journalctl -k -S 2025-04-09 | grep -A 20 mpt3sas_cm0
>>> Apr 09 03:16:26 cb kernel: mpt3sas_cm0: log_info(0x31080000):
>>> originator(PL), code(0x08), sub_code(0x0000)
>>> Apr 09 03:16:26 cb kernel: mpt3sas_cm0: log_info(0x31080000):
>>> originator(PL), code(0x08), sub_code(0x0000)
>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 FAILED Result:
>>> hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D6s
>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Sense Key :
>>> Illegal Request [current]
>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Add. Sense:
>>> Logical block address out of range
>>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 CDB: Write(16)
>>> 8a 08 00 00 00 00 00 00 10 80 00 00 00 08 00 00
>>> Apr 09 03:16:26 cb kernel: critical target error, dev sdd, sector
>>> 4224 op 0x1:(WRITE) flags 0x23800 phys_seg 1 prio class 0
>>
>> This error is completely from the lower layer (the block device).
>>
>> Btrfs nor the LUKS upon the disk can do anything to it.
>
> Thank you for the response.
>
> This disk support scterc
>
> $ sudo smartctl -l scterc /dev/sdd
> SCT Error Recovery Control:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Read:=C2=
=A0=C2=A0=C2=A0=C2=A0 70 (7.0 seconds)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Write:=C2=A0=C2=
=A0=C2=A0=C2=A0 70 (7.0 seconds)
>
> Doesn't that mean that the disk gives up after 7 seconds, and then the
> sector i mapped to a spare.
> So if Btrfs does a write to the sector again it will be written to the
> spare?
>
> I've experienced numerous sector errors throughout the years with mdadm
> and they have been fixed with a check.
> Also a few with Btrfs I think, but they have been fixed automatically.

Whatever the feature is, it's block device driver's behavior.

Btrfs only errors out because the disk reported the write failed.

For the detailed reason you should check these lines:

 > Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 FAILED Result:
hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D6s
 > Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Sense Key :
Illegal Request [current]
 > Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Add. Sense:
Logical block address out of range

>
> So why not this time?
> To me this looks like an ordinary faulty sector that can be "fixed" with
> a write?
>
I'm not sure what ever the "SCT Error recovery control" feature is, but
if it is designed to re-map a write, it should not return -EIO for the
initial write failure, but OK as long as eventually the write succeeded.

It should not require any upper layer to do any extra work.

But since the write eventually failed, there is nothing upper layer can
do, unless the dm or fs layer has some extra recovery mechanism.

Thanks,
Qu


