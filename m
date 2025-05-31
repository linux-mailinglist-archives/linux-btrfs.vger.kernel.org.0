Return-Path: <linux-btrfs+bounces-14349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7E7AC9D1B
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Jun 2025 00:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B79F1895989
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 May 2025 22:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57221DF757;
	Sat, 31 May 2025 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="o446DwA4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C9418D63A
	for <linux-btrfs@vger.kernel.org>; Sat, 31 May 2025 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748729287; cv=none; b=fB5gUxAb7xKOxiXVhXKUqpsRIaKtNqbD4vyYilVFpbD45I1DxDBd5qVxOrj4oZaAiVBLUkUVWe2GxjhvY38de2SanjostVeDf0US8pmR8M7WSHJ+7PQsIjcJoB0nzv8jY7xUQjjXQ1ce0ftdOTOh00B+kKTdxQ5Unt6S3jyKUcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748729287; c=relaxed/simple;
	bh=NOuR0Cz++Y5ShXlO5OaqGZvLsFuGzGSmE6FVuy9hy88=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZoKlr4j2GZ6TkSbxgp0hWVO2ZTLtEkd8GVBw0g2TgGEU907y6pbRS4a2tWn0E5x9ZzsoEoHO4FttPVkZcEUYmepZm/NHSj4hlr+2aF/5QS/AwvqSzVRdRV5YQk2cCpbiMhF70ExzhS4vxHH+3yDKnwxQPaVKT/thRgyc0NDWnDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=o446DwA4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1748729281; x=1749334081; i=quwenruo.btrfs@gmx.com;
	bh=NOuR0Cz++Y5ShXlO5OaqGZvLsFuGzGSmE6FVuy9hy88=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=o446DwA4MVSWEe+7iLKkfpJK+tb61zWYfTXBYvuJRxgTY+CVRjPEBL34CtcXKOnv
	 6rv+C6rJY1GkkQmw7z9U5bjgkSTLemLICDcLw96KcJ6G/Uy0ujkYT8uc0X1M+wiZH
	 e5oZJYwqkvfEMR+wJ+T0/9Q3fzYi8XBYwz65tfwGMBrNzy8TMuIpra24KMybuOuAQ
	 F1cEwWmHeemIWw2e6J5pQWEyKzUPLs5hvVtPohVrvkqkRVE7qV2xwC2pEV0bmtW9o
	 dB3vXKBjO3PT+mYlU80S/V1XtfSVvb1Uz/Sq60jZjrkHvgo+vKpk1Kcg/8Q4M+W5b
	 /otJ6L9uUoSG9Ha20w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6sn1-1uxAMx1HNn-011TNR; Sun, 01
 Jun 2025 00:08:00 +0200
Message-ID: <e156fb78-928b-4fea-b29d-c06f70744fdf@gmx.com>
Date: Sun, 1 Jun 2025 07:37:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] btrfs-progs: introduce "btrfs rescue
 fix-data-checksum"
To: kreijack@inwind.it, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1747295965.git.wqu@suse.com>
 <828702dd-33e8-48c0-85f8-455763e34ed2@libero.it>
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
In-Reply-To: <828702dd-33e8-48c0-85f8-455763e34ed2@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cnRPHi8/dLSj86Ib+tT1gcsJ6tjFAAhGmbnQovr9y+igJKXAcQs
 BD1uoak4kZrsNJ/x9H+kTtx3BWvWPzSHGgUToqOwVJQmZu21wYeqmPHwRAE2jXnTJ0WUdU6
 C3uwRqU9tt2S2uAc3ZBMkV26RQFZ/cBLEuCP1bLSu384bWLmWO7ZhdWvmq+AY6K14T4VTmQ
 UYZhPvM+Z+8VRyFnHjgVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i12LdFxs6MQ=;73KrhvfX8sWXqnKIxMNLWoarRO+
 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



=E5=9C=A8 2025/6/1 02:28, Goffredo Baroncelli =E5=86=99=E9=81=93:
> On 15/05/2025 10.00, Qu Wenruo wrote:
>> [CHANGELOG]
>> v2:
>> - Rename the subcommand to "fix-data-checksum"
>> =C2=A0=C2=A0 It's better to use full name in the command name
>>
>> - Remove unused members inside corrupted_block
>> =C2=A0=C2=A0 The old @extent_bytenr and @extent_len is no longer needed=
, even for
>> =C2=A0=C2=A0 the future file-deletion action.
>>
>> - Fix the bitmap size off-by-1 bug
>> =C2=A0=C2=A0 We must use the bit 0 to represent mirror 1, or the bitmap=
 size will
>> =C2=A0=C2=A0 exceed num_mirrors.
>>
>> - Introduce -i|--interactive mode
>> =C2=A0=C2=A0 Will ask the user for the action on the corrupted block, i=
ncluding:
>>
>> =C2=A0=C2=A0 * Ignore
>> =C2=A0=C2=A0=C2=A0=C2=A0 The default behavior if no command is provided
>>
>> =C2=A0=C2=A0 * Use specified mirror to update the data checksum item
>> =C2=A0=C2=A0=C2=A0=C2=A0 The user must input a number inside range [1, =
num_mirrors].
>>
>> - Introduce -m|--mirror <num> mode
>> =C2=A0=C2=A0 Use specified mirror for all corrupted blocks.
>> =C2=A0=C2=A0 The value <num> must be >=3D 1. And if the value is larger=
 than the
>> =C2=A0=C2=A0 actual max mirror number, the real mirror number will be
>> =C2=A0=C2=A0 `num % (num_mirror + 1)`.
>>
>> We have a long history of data csum mismatch, caused by direct IO and
>> buffered being modified during writeback.
>>
> What about having an ioctl (on a mounted fs) which allow us to read data=
=20
> from a file even
> if the csum doesn't match ?

The problem is again with mirrors.

Unless you ask the end user to provide a mirror number, for a with=20
multiple mirrors, and the mirrors doesn't match each other, the behavior=
=20
will be a mess.

That's why I'm planning to add something like a mirror priority, with a=20
new mirror "best" to try use the mirror with the most matches.


Despite the mirror number problem (we need to ask the end user for=20
mirror number), I think it's possible to implement the feature (mostly)=20
in user space.

E.g. combine fiemap result with btrfs-map-logical, then read from the=20
disk directly.

> I asked that because the problem usually=20
> happen on a specific file
> and not to an entire filesystem. In this case I think that it would be=
=20
> more practical to read the block
> using the IOCTL, and then rewrite the block, at the specific offset (to=
=20
> update the checksum).

I'm fine with the idea of reading from raw data idea (although prefer to=
=20
implement it in user space), but not a huge fan to simply re-write with CO=
W.

E.g. the bad csum is still there, can still be exposed by scrub, even=20
it's not referred by any file anymore.

>=20
> Of course there are several tradeoff: the "unmounted" version, doesn't=
=20
> duplicate a shared block,
> where my approach (read the data using an ioctl to avoid the CSUM=20
> mismatch and rewrite it) make
> a fork if the block is shared. However, as told before, the problem is=
=20
> related to specifics file and it seems
> a waste of resource reading an entire filesystem to correct few files.=
=20
> No to mention that the IOCTL
> can be done on a "live" filesystem.

I do not think we should treat the csum error so easily, it's still a=20
big problem.

Even it's known that direct IO with buffer modified halfway can lead to=20
corruption, the csum mismatch is still a huge problem.
The end user should check if their problem is properly written, or use=20
the latest kernel with proper backport.

If it's really caused by hardware (memory or disk or whatever), it's a=20
huge deal and definitely needs proper inspection and verification.

So overall, if one hits a csum mismatch, especially after the direct IO=20
fix, then it should not be treated as "something that can be easily=20
fixed online", it should be something huge, at least needs some tool to=20
handle it offline.

Thanks,
Qu

>=20
> Said that, of course "btrfs rescue fix-data-checksum" is better than=20
> nothing.
>=20
> BR
> G.Baroncelli
>=20
>> Although the problem is worked around in v6.15 (and being backported),
>> for the affected fs there is no good way to fix them, other than comple=
x
>> manually find out which files are affected and delete them.
>>
>> This series introduce the initial implementation of "btrfs rescue
>> fix-data-checksum", which is designed to fix such problem by either:
>>
>> - Update the csum items using the data from specified copy
>>
>> The subcommand has 3 modes so far:
>>
>> - Readonly mode
>> =C2=A0=C2=A0 Only report all corrupted blocks and affected files, no re=
pair is
>> =C2=A0=C2=A0 done.
>>
>> - Interactive mode
>> =C2=A0=C2=A0 Ask for what to do, including
>>
>> =C2=A0=C2=A0 * Ignore (the default)
>> =C2=A0=C2=A0 * Use certain mirror to update the checksum item
>>
>> - Mirror mode
>> =C2=A0=C2=A0 Use specified mirror to update the checksum item, the batc=
h mode of
>> =C2=A0=C2=A0 the interactive one.
>>
>> In the future, there will be one more mode:
>>
>> - Delete mode
>> =C2=A0=C2=A0 Delete all involved files.
>>
>> =C2=A0=C2=A0 There are still some points to address before implementing=
 this mode.
>>
>> Qu Wenruo (6):
>> =C2=A0=C2=A0 btrfs-progs: introduce "btrfs rescue fix-data-checksum"
>> =C2=A0=C2=A0 btrfs-progs: fix a bug in btrfs_find_item()
>> =C2=A0=C2=A0 btrfs-progs: fix-data-checksum: show affected files
>> =C2=A0=C2=A0 btrfs-progs: fix-data-checksum: introduce interactive mode
>> =C2=A0=C2=A0 btrfs-progs: fix-data-checksum: update csum items to fix c=
sum mismatch
>> =C2=A0=C2=A0 btrfs-progs: fix-data-checksum: introduce -m|--mirror opti=
on
>>
>> =C2=A0 Documentation/btrfs-rescue.rst=C2=A0 |=C2=A0 28 ++
>> =C2=A0 Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 cmds/rescue-fix-data-checksum.c | 511 ++++++++++++++++++++++++++=
++++++
>> =C2=A0 cmds/rescue.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 65 ++++
>> =C2=A0 cmds/rescue.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +
>> =C2=A0 kernel-shared/ctree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 17 +-
>> =C2=A0 kernel-shared/file-item.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 2 +-
>> =C2=A0 kernel-shared/file-item.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 5 +
>> =C2=A0 8 files changed, 635 insertions(+), 5 deletions(-)
>> =C2=A0 create mode 100644 cmds/rescue-fix-data-checksum.c
>>
>> --=20
>> 2.49.0
>>
>>
>=20
>=20


