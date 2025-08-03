Return-Path: <linux-btrfs+bounces-15816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A502B19575
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 23:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FFF18903BD
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 21:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8518A1F561D;
	Sun,  3 Aug 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k1pVzd+N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327BA7E792
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754255816; cv=none; b=mV9PYmEQ1YUTmpRWk3M4RjcbGNSM215z27f8dyM/rv64TgSEC+mPv+1OiueDWjRqwcWYkEdpw1r5pmZDxCZn9+U4kSPI9YwtgoQtXUERJmOUFN9Ui3JN0V452TSVBasyavLEZzSDat0sj9M5WwM+i579kWdjEO4B+3QsnDq6bo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754255816; c=relaxed/simple;
	bh=gIrv9mD1ZZ3/XmT2VJYhddO3PO+qsBCSQlM9eOsfvag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0PFR9NyDKdDkvBAeudVKKY1M4RGzS+d44D0rEiwWAOxhCF8vzRejp+NdTqnKZ33FH5U8x7lE+vGRsWADUd179Wtddt7vfDu+5Qwtxs77jcmG28fY6ogkbQQd5Uhuq0h6G7tyUQDa8AGgQYlSJdSQY6mnEq2QL5M6i9kuePH3f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=k1pVzd+N; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754255809; x=1754860609; i=quwenruo.btrfs@gmx.com;
	bh=gIrv9mD1ZZ3/XmT2VJYhddO3PO+qsBCSQlM9eOsfvag=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k1pVzd+NwAsIy4GdTL4RyCPeZEgNLP+wD2G9Bx3h97iewcb4uttfHCcw+FQ6zGeI
	 fMK5w83tkszVhaZ1J74/bDbBLG/nmSwOY0VuZmFvaJGiAAQbohqDbor6pMEWaxK6A
	 eMoDdLHLJQIS0sP/oT58aMTrUHvv55yLdwzq91f78iv3O1OZ0LgCI/z84fhinInzw
	 k/5nyt843DxL85ezzxquRuLglHIXoU3h51lxujKTuRzaOztIrBytZiK9emWLjB70D
	 It2SZ8YPkE0u3NkKrY5U/vWYqRj+1s6x4clCpOqeoyzwJIkXijJY1uvXLHjQi7mKz
	 BIsnVNdBhrhsdxK+2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1Ygt-1uff8V2XRD-007LCB; Sun, 03
 Aug 2025 23:16:49 +0200
Message-ID: <1f1544c5-6aaa-402c-8899-71e45acacf90@gmx.com>
Date: Mon, 4 Aug 2025 06:46:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should seed device be allowed to be mounted multiple times?
To: Dave T <davestechshop@gmail.com>, Qu Wenruo <wqu@suse.de>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <aef03da8-853a-4c9f-b77b-30cf050ec1a5@suse.de>
 <CAGdWbB5PUw1gGy9PaOdYn14OfKH8NhO3WOMt_2axg1589t8OJQ@mail.gmail.com>
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
In-Reply-To: <CAGdWbB5PUw1gGy9PaOdYn14OfKH8NhO3WOMt_2axg1589t8OJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZphhDEcozQ7oMU5PcHek/j2rZ3hteqzMEmswkFSUprsNonPHrGB
 qVGZhLyZNDYIMg+xfWEZPgAEBpdYt4HM+/m71ZVGFgKnZarVXwb3rwj7E9uPaMJERea0yqP
 fUcoExQvwybnXpQbO/ieXKcTAYdOmysc4Pu/4UGGEuyNOxMrW3y8Oh470xIr9kYdAEB/7i7
 QgMb5w3tsDF+QymILZb6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6HUqY0M9eVw=;geIrt6h8wvBmTz9zOxXyLqHc3BA
 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
 zA==



=E5=9C=A8 2025/8/4 05:08, Dave T =E5=86=99=E9=81=93:
> Hi Qu,
>=20
> First of all, thanks for your work on BTRFS. I also want to thank the
> entire team. Regarding the device opening restrictions from commit
> e04bf5d6da76, I wanted to check on potential impacts for btrbk, a
> commonly used BTRFS backup tool.
>=20
> btrbk's documentation recommends mounting BTRFS filesystems with
> "subvolid=3D5" for backup operations (see
> https://digint.ch/btrbk/doc/readme.html). Many users following this
> guidance mount the top-level subvolume specifically for btrbk while
> also having other subvolumes mounted for regular use.

It's completely unrelated.

The "mounted multiple times" is not mounting a subvolume on to different=
=20
location.

It's about the same seed device mounted belonging to different filesystems=
.

E.g. a sprouted fs mounted using the seed device, meanwhile the seed=20
device itself also mounted somewhere else.

Such seed device usage should not affect most users.
>=20
> While I believe typical single-filesystem scenarios should be
> unaffected (multiple subvolume mounts from the same device), I wanted
> to confirm that common btrbk use cases won't be impacted by the new
> restrictions. This includes:
>=20
> Mounting subvolid=3D5 alongside other subvolumes from the same filesyste=
m
> Multiple BTRFS filesystems being backed up on the same system
> Any network backup scenarios where device access patterns might differ
>=20
> Could you clarify whether btrbk's recommended mounting patterns are
> compatible with the changes being considered now?
>=20
> Thanks for considering the broader ecosystem impact. Have a great day!
>=20
> Dave
>=20
>=20
> On Sat, Aug 2, 2025 at 3:12=E2=80=AFAM Qu Wenruo <wqu@suse.de> wrote:
>>
>> Hi,
>>
>> There is the test case misc/046 from btrfs-progs, that the same seed
>> device is mounted multiple times while a sprouted fs already being moun=
ted.
>>
>> However after kernel commit e04bf5d6da76 ("btrfs: restrict writes to
>> opened btrfs devices"), every device can only be opened once.
>>
>> Thus the same read-only seed device can not be mounted multiple times
>> anymore.
>>
>> I'm wondering what is the proper way to handle it.
>>
>> Should we revert the patch and lose the extra protection, or change the
>> docs to drop the "seed multiple filesystems, at the same time" part?
>>
>> Personally speaking, I'd prefer the latter solution for the sake of
>> safety (no one can write our block devices when it's mounted).
>>
>> Thanks,
>> Qu
>>
>=20


