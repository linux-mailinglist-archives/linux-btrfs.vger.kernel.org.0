Return-Path: <linux-btrfs+bounces-15629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6837BB0D72E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 12:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C654A7B6C55
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CF82E0917;
	Tue, 22 Jul 2025 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="uE2Tycqy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BB02DFA3A
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179298; cv=none; b=rfiP/LkGcMhiiZ/eaUmOFUjn+W/JgX6GDOdD/Wm85InGdp2Wmn6RhhxB4u6pNYbnlTHO2bKpq9jGx0X135u5zKNgMsTP/0P4o/LHsLIx1PEmJfmGG1zI0yFLUbIJ7OmLqaxqQj5ly8Nf5cgeYmvExO+ECzoOMsri3Ssgok9u/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179298; c=relaxed/simple;
	bh=A5L3/nvakSJx1NRvjLoPSdXsXmUW6wXFLGEe4f7FfLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMNFkmwprOIR1P+u/cs4wgdzAWEjpxUMM+o6r37fA2sH9sIKuBpJ+7Iqr1teMpZ0VFaomqJXT8L7luzCdLFbblQa3bwZtIqEEyRCtQtSMNKBEip9NrvQv2fPjQ+F8kVrDvYnaNg8WU0NT8yCtKlRBYRs4/45BFtsWPv3cd0Ix/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=uE2Tycqy; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1753179287; x=1753784087; i=quwenruo.btrfs@gmx.com;
	bh=lBv+UydbOaM3ffGiV7hQOhxscfOfmV5lywV2h2qI2Og=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uE2Tycqy85ubU+fEKOy71QHw6WpKux7Ye4A3t2bHe0Frznn0nYqt6W8YmATrVeYm
	 /tAGA0LTwq71Cv0ukBVSPk3S35R4bimVbwzPTZbaH9VEBl2Ry8tvp+iwUl/bQaCCX
	 p4UbWW7dy/Wti9hvr9FNNPqZuxUyWn+7NNE0ZB7rBkeUb+HFKjZdqexCJsh9Lxxc8
	 7ZnpOPuBDFV2m+ZFBTQytp9bffMYJkMFap4/ks1y/0W/8sP/S2Rz6ClOV4OekmPpM
	 fJfmOQx/RW0fCYf//WctA0A7fm8LMNbWqFuF1l4Y9SlWQTydZr5EhYTdE8ajlGon2
	 fzDdbguUUUJQgRrTeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbivG-1v9eUD00ZK-00eUXt; Tue, 22
 Jul 2025 12:14:47 +0200
Message-ID: <75ff2587-8368-4dc2-bae7-8df09cc89e65@gmx.com>
Date: Tue, 22 Jul 2025 19:44:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] btrfs: improve error reporting for log tree replay
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1753117707.git.fdmanana@suse.com>
 <63f83bf0-e5d0-44a6-8a7b-0ab32b2c64ee@suse.com>
 <CAL3q7H5=0ucPEW3EbRGkaF1xgQaRM0S7ocTEYpsNxYWkgTfJ5A@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5=0ucPEW3EbRGkaF1xgQaRM0S7ocTEYpsNxYWkgTfJ5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eHAx4/Y987F9/IoB7Ge8lmBL219IzDB1lbasOETak1KOtLMELUP
 DUr9FvgnlaQQ4I0qatm0/xl5yHIXMKwhEC707sucfomxbEw2AK2ii/saiqdIwgc5kZjblJi
 2gEV0TwJjRhZGOEPZ+Z3ebJQtF3oAWV1rHW8mRpIhw7/03D8wCyHQVPMzspC257zWDwWy/x
 t/fJsHtUC2rxdfGPGZ4Bg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cgmayQm0b+E=;50NblAHOczYwwH6gRRcGFHraCdo
 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



=E5=9C=A8 2025/7/22 19:34, Filipe Manana =E5=86=99=E9=81=93:
> On Tue, Jul 22, 2025 at 1:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2025/7/22 02:46, fdmanana@kernel.org =E5=86=99=E9=81=93:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Most errors that happen during log replay or destroying a log tree are=
 hard
>>> to figure out where they come from, since typically deep in the call c=
hain
>>> of log tree walking we return errors and propagate them up to the call=
er of
>>> the main log tree walk function, which then aborts the transaction or =
turns
>>> the filesystem into error state (btrfs_handle_fs_error()). This means =
any
>>> stack trace and message provided by a transaction abort or turning fs =
into
>>> error state, doesn't provide information where exactly in the deep cal=
l
>>> chain the error comes from.
>>>
>>> These changes mostly make transacton aborts and btrfs_handle_fs_error(=
)
>>> calls where errors happen, so that we get much more useful information
>>> which sometimes is enough to understand issues. The rest are just some
>>> cleanups.
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Although I believe we may further enhance the output by dumping the log
>> tree when replay_one_buffer() function failed.
>>
>> Especially considering we don't have a simple way to dump the log tree
>> for a subvolume (always needs to go through the log tree root, then int=
o
>> the log tree of a subvolume).
>=20
> Dumping the log tree alone is not as useful as you might think.
>=20
> Unless there's an actual IO error due to some extent buffer not
> getting persisted, problems during log replay happen because:
>=20
> 1) There are items we didn't log - you can only figure that out by
> checking the subvolume tree as well;
>=20
> 2) There are items we logged but should have been removed from a log
> tree after events such as unlinks and renames for example - again,
> that can figured out only by checking the subvolume tree as well;
>=20
> So most, if not all problems during log replay, that I remember ever
> fixing, and there were lots of them, boiled down to that.
> And most times we also need to have an idea of what file/dir
> operations happened besides checking the log and subvolume trees.
>=20
> Also dumping an entire log tree is too much, as it can reach 3 levels
> (root at level 2) during the lifetime of a transaction.
>=20
> There are other things I want to do on top of these changes, but
> dumping an entire log tree is not of them.

My bad, since we're at replay_one_buffer() the more sane one is to dump=20
that log tree leaf.

And the subvolume leaf is also at reach, e.g. dump path->nodes[0] if=20
there is an error and we have path->nodes[0] populated inside various=20
replay_*() functions.

Thanks,
Qu

>=20
>=20
>>
>> Thanks,
>> Qu
>>
>>
>>>
>>> Filipe Manana (10):
>>>     btrfs: error on missing block group when unaccounting log tree ext=
ent buffers
>>>     btrfs: abort transaction on specific error places when walking log=
 tree
>>>     btrfs: abort transaction in the process_one_buffer() log tree walk=
 callback
>>>     btrfs: use local variable for the transaction handle in replay_one=
_buffer()
>>>     btrfs: return real error from read_alloc_one_name() in drop_one_di=
r_item()
>>>     btrfs: abort transaction where errors happen during log tree repla=
y
>>>     btrfs: exit early when replaying hole file extent item from a log =
tree
>>>     btrfs: process inline extent earlier in replay_one_extent()
>>>     btrfs: use local key variable to pass arguments in replay_one_exte=
nt()
>>>     btrfs: collapse unaccount_log_buffer() into clean_log_buffer()
>>>
>>>    fs/btrfs/tree-log.c | 659 +++++++++++++++++++++++++++--------------=
=2D--
>>>    1 file changed, 401 insertions(+), 258 deletions(-)
>>>
>>
>>
>=20


