Return-Path: <linux-btrfs+bounces-5745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7A3909FE8
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jun 2024 23:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F37AB20FDF
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jun 2024 21:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16BB6A33D;
	Sun, 16 Jun 2024 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sivR/Y3R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C72575A
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Jun 2024 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718573070; cv=none; b=cO3eW7iyPzTdps3e/W6Gc7uPLosJtEGkAfcC81mkWEZBtFPURF4oWF/mr/QxYVSIHXQz2Ph9CSxdNOkPIQMxL31oiR5HeEN/YUp55Sgq/5d9O9EEoxnt7BGcm3XEaObtchJ0IvHIP20tT7Xh5AwEpUXXu52XtgvsiB2ty8E3qfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718573070; c=relaxed/simple;
	bh=pBShJzDJr3tLN+W0zYkyU+/WoFpvGqRYa/2CH3MDdxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLzP6F8LaGDyoRIVJ3PVeyrwBn4h8o4bqo5P3yNHj/A6EeOSuZcdOujnCyeZFzSTPkss62Qf8/sydpowWkfQsb2tML3do1lAHGBUma+T5t+ig7X5Uw00qQeWWnV/5BUS7s0FyGkVal3GvRXl7ypIhRMLB97aDThf1vTbhX1QLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sivR/Y3R; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718573063; x=1719177863; i=quwenruo.btrfs@gmx.com;
	bh=MTEudpEiLkOdxnPPQ4w4MHAsyEgBxDeNc11IeNRFUjM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sivR/Y3RsU05l9wZO1ZioBBCZngSawjFFNwvKoNcLlj2LNQnmzIoTf5hqv6Z2CdX
	 e1GBCOv6CI2Kfrw6plIvo3X1U3clnHhZiaebpkze3LH+E9NV9ZrxeENyAyZSL/mIv
	 2vi4730k3r160ZG3RnWy8YTi/hNpgu89O/Af76HUHvWXx4w8AzTWZ2iR7iDzR7V1N
	 4WEFJeaN3w319uQcaTGlTyzTKPjNPusXWX2kbtTkbmB3xim0sMj8MVSODnvu1WVqG
	 L1CMCsT1FnRrLP9G8+vsUFLRbBIVfmevtsh3a048gW981ELcjYpfCXxigw0Ne4JHt
	 rQqcuz1hBeK/a2VXgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGhuU-1sE1gq1sgs-00Fvql; Sun, 16
 Jun 2024 23:24:23 +0200
Message-ID: <d203bdcb-606f-4505-8250-f47646157404@gmx.com>
Date: Mon, 17 Jun 2024 06:54:18 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] btrfs: introduce new "rescue=ignoremetacsums" mount
 option
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1718082585.git.wqu@suse.com>
 <f6b9b9037ee7912ed2081da9c4b05fd367c9e8f8.1718082585.git.wqu@suse.com>
 <20240612193821.GK18508@twin.jikos.cz>
 <ffa354b9-4315-4e29-af2a-124a697d0eef@gmx.com>
 <20240616181724.GD25756@suse.cz>
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
In-Reply-To: <20240616181724.GD25756@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:adn9+9qG8Qe6bz+oAt44OIYKJKlqSkH0hb9vcOV8bL1IH1K1cHc
 Fq8pEb6TQygKAw4VPw7Bi64yE/WDAeb3o0I1zAsV/SQ1VxAnKbCdzb7FGEADSWzQ/KUz+rk
 nzGIB0hXqTnN90BA2+XwPfTyv9CRswlBHFSiJtAJVnhCpDVYyIFB51cIXBeBBVFMlWfrlhX
 QJJBJE8LTto21XKR7jyvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4OjBXqlThrY=;YJy7UwsCeJoiKgVheSWp5ad4WZJ
 YpN5g3mtXEvVa5T19PYjxVODoxSwdeV6pP8La91RBvsLc+EE2DxCBGAVBTpJr0AWhQpxBegOl
 xUmrIt+BgBaQxiGQpLr8CB+tWjUw0JzNpkWZFWcUXyabU+Xf/XG3kaTExTpCnt4CjoZP/8YnC
 wj98sZDsTbQ6LX1I18aSFJhnyhCB8N3JrJW8vi00Hq5hh2V2Rb42avmEjA5QJC1a5pLLY5kOV
 9kw7tg4j72eD0k1bIFGR/ETtI66VFQmxNfCQGDEgij5FtmcYgOtQ3G0wzaU9HGf9giPYGg4Zc
 KtrOkiOB9GyVjKDsQebFrXY0Lix7UMt/ChOkrH32ZQ6pJMIqmLgDw8K82nNKm2/BfDNpxHY9w
 xTNDMJ2VfhTPHSjYFKlodz8TJ2Z6ct1E2w6VSkSo5Ns1Z79p4ocs1v5TOb0Ox0dHWq98TtDfL
 2oKXKbt1HMVqqz40uRyr3l3V8RrvcsNhcAFEIuBnF5TAja2slHSpsJoG/3fkMAiNzzs1hR1sI
 SZFzDbqJxtdTAwXm0ikE4h4szKLOw1ThElT26KFF70mId16NKLvx/Ts2xspSt9Dg+bTxTR8St
 7Ht7tkvjdIRPdNLN4u0ugfntcpvGotw+IqxRNOSfYz+/slF9vtb85JcBLROA0kGtbEmQdQCnz
 oKXBi4ODXencFYWPfztKeX7sfgMheTJUhMC/lOYxLs0fca66tMdY9LhHTzsEQkeSwV1mIU6Ha
 g+uMjJpTnCdlEfDuN8ih1UZiurILd3jzM8WF+yhLLxHjHIuUxjrv9oo6WG+nYfaPf4oz0FhlD
 8LcK1jAQ2njphmgcFEtYxoyySojFacG2seRlRKWRaIsts=



=E5=9C=A8 2024/6/17 03:47, David Sterba =E5=86=99=E9=81=93:
> On Fri, Jun 14, 2024 at 06:58:20AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/6/13 05:08, David Sterba =E5=86=99=E9=81=93:
>>> On Tue, Jun 11, 2024 at 02:51:37PM +0930, Qu Wenruo wrote:
>>>> This patch introduces "rescue=3Dignoremetacsums" to ignore metadata c=
sums,
>>>> meanwhile all the other metadata sanity checks are still kept as is.
>>>>
>>>> This new mount option is mostly to allow the kernel to mount an
>>>> interrupted checksum conversion (at the metadata csum overwrite stage=
).
>>>>
>>>> And since the main part of metadata sanity checks is inside
>>>> tree-checker, we shouldn't lose much safety, and the new mount option=
 is
>>>> rescue mount option it requires full read-only mount.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>>> --- a/fs/btrfs/disk-io.c
>>>> +++ b/fs/btrfs/disk-io.c
>>>> @@ -367,6 +367,7 @@ int btrfs_validate_extent_buffer(struct extent_bu=
ffer *eb,
>>>>    	u8 result[BTRFS_CSUM_SIZE];
>>>>    	const u8 *header_csum;
>>>>    	int ret =3D 0;
>>>> +	bool ignore_csum =3D btrfs_test_opt(fs_info, IGNOREMETACSUMS);
>>>
>>> const
>>>
>>>> --- a/fs/btrfs/messages.c
>>>> +++ b/fs/btrfs/messages.c
>>>> @@ -20,7 +20,7 @@ static const char fs_state_chars[] =3D {
>>>>    	[BTRFS_FS_STATE_TRANS_ABORTED]		=3D 'A',
>>>>    	[BTRFS_FS_STATE_DEV_REPLACING]		=3D 'R',
>>>>    	[BTRFS_FS_STATE_DUMMY_FS_INFO]		=3D 0,
>>>> -	[BTRFS_FS_STATE_NO_CSUMS]		=3D 'C',
>>>> +	[BTRFS_FS_STATE_NO_DATA_CSUMS]		=3D 'C',
>>>
>>> There should be the status also when the metadata checksums are not
>>> validated, the letters are arbitrary but should reflect the state if
>>> possible, I'd suggest to use 'S' here.
>>
>> I'd prefer to change the NO_DATA_CSUMS one to use 'D' or 'd' (for data)=
,
>> meanwhile for metadata we go 'M' or 'm'.
>
> Changing would break backward compatibility, now it's part of user
> visible interface. It's not an ABI or API but at least we should do such
> changes without considering the consequences.
>
>> But on the other hand, I do not think data/meta csum ignoring really
>> deserves a dedicated state char.
>>
>> It's not really that special compared to trans aborted or dummy fs.
>> (The same for dev-replacing)
>
> The idea of the descriptors is to make it visible that the filesystem is
> in some unusual state, skipping checksum verification can make a
> difference when reading blocks that would normally not pass the check.

On the other hand, I have already changed the metadata csum mismatch outpu=
t.
It should be enough to know if we're in a skipping-metadata-csum state.

Furthermore, all of these are in rescue mode with forced RO, which
should already be a thing to mention during report/debugging.

That's why I do not think skipping data/metadata csums really needs such
dedicated handling.

Thanks,
Qu

