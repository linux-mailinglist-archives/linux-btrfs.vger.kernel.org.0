Return-Path: <linux-btrfs+bounces-6487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3275B931D37
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 00:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEED52829C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 22:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B480013D63D;
	Mon, 15 Jul 2024 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="CtmsPjdc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3269E1CA80
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721083269; cv=none; b=cCa7M/5mM0DXhTnhhJTlSMqTD7m0d/HnrGIhexf/2WiQijI6FnmifAJRs3WsLRU8YEgyXnCocwD7ZGm+Jmef+NTDB5c+GuhUqwCWR3JUoAbqSbeNVFqdK26jQcvSFxf97UQbjvToi4ev5BccdUP3eOWm9S6Q51Gm2YyLKCYF3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721083269; c=relaxed/simple;
	bh=k5PVglJ+oWUdj0zpcCgFsv5Wj8AV3MHHDDf8O8ZoKWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FD6z7Ystf/xawxe91JHaanxfvcScEquIczaM3uqNob0mCo6aTCrsVP1zpXqxcfaj2RwRCRvOL2bWVVo0ZJDo02TngT/QNx/orZI+nfyrNed0Ubkk99rPFNL01Gcl0mCTzeryXoMWj7FuzeKH9XOipK7Kq18O883WMDH6URAZ6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=CtmsPjdc; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721083264; x=1721688064; i=quwenruo.btrfs@gmx.com;
	bh=k5PVglJ+oWUdj0zpcCgFsv5Wj8AV3MHHDDf8O8ZoKWY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CtmsPjdcTGrvGDeXvVvMw1Af8VkeOLndeHdX6zxHIY/Zi9kvaTsd2Ld8kGIJ40MO
	 A3vlyw3andGHtFG4su2dh4o2++ETras9zzudaGlhswUSxrXPrXdy7RvM/SneVG97i
	 DhO+q+ZokKb2ZAakhBjIwRk0hvU+rZobuXShOVZhDwwL0fK5I1qBxcEJ/3ryofI1P
	 YPc1yTDpWWOtVsPtXyZL5v/nYobioJlNE9AYNhMyJcs26cxIwBXJCj119qN9W6Ghj
	 Dr2kM2UFO2U/GiWd7aCxcuVHMInd904UdKJW+TIUYQGD6ocbd6rmXUqdftokW5Ju1
	 5/H6sSqJsb7rm/Wv4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mv2xU-1sBp0B1uam-011RdK; Tue, 16
 Jul 2024 00:41:03 +0200
Message-ID: <f5b82cac-b1b2-41f5-8917-e236d682bd02@gmx.com>
Date: Tue, 16 Jul 2024 08:11:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: change BTRFS_MOUNT_* flags to 64bits
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <0955d2c5675a7fe3146292aaa766755f22bcd94b.1720865683.git.wqu@suse.com>
 <20240715123155.GD8022@twin.jikos.cz>
 <b3c459ff-d168-48a1-bff5-95bcb983f8fe@gmx.com>
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
In-Reply-To: <b3c459ff-d168-48a1-bff5-95bcb983f8fe@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HGfCCSNR/Pmy8jTPV2MQE/yHcfeSj62TeJ0XTK3yeSdUS2jVvH5
 fROx6O+LvB6BoKtn0ORW4mQ2SjU055iwUBF3C1YssQh+TMSHb4qPc9jyBpnNuGqqH7lPmXI
 JuakPahaV8y4j2TtYi0Rd/Py0gpkiclgcdH7l8Xt2F93JlCA/X1EqE5oZm4sAdMKXoctNGy
 5oE0GKXUfJ16029jBl9UA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0X4/iZHgyLA=;lX7gp+i+ws5Qs/koS+yHkKkMk/9
 cFw84kzK+BnTYgUsQ8Xhy6R8e9HxWmBSFqpQOp/ri31BdMjqU5GUBrUa2Cr8pFFO5oZnSkZcq
 1FqKtlr67QpsH7HasWrSCIF3nDvRRDLdpcTCkr0vBFUWAGxgQWikCsIZWAy8yzu1QmkLsI6Bc
 2FiFXimO6OMAvY1AvcMFBAUZi3FBahXCNZcOSGfemk07mLnbQOGJsU/dmQ9Q4KsVeGHKE6c0X
 yf6ffvm8UuzdvOwRZc8guBwD9hf8v0hZq3jkIPm59SXEu2TROPn+DNusO6bHS3xCIlF4Xr47C
 VoYZbef4eBG5/RQQq98xrcF0sVlJyzv/5/7ubcMlbbBpjwOyFpM7IhsKlWl0LxT/2n9Sss0es
 sEi3UDwxWdbBaf2sVqqmAq5rpMuFFB8oNT+Yw0r9Hv/MPJJuzElpzakMFGdOVSHC8Iwoj5yYB
 F6n7hdIkS7CLl1kGzERIXxZft6AhNjvnOAzAiUKZPGJpvGqZiQDuwcNftGqPzPynUu83nSQ6L
 hZHU3jiPLjv5HNzA/RJ/0u+eNQZzL+BMLJ75x4ArrJBJr1VSZtLQ4CaE2AtjtaInjmJY+gU/m
 bFNelAFNidtzi950eoYXO3zL4sfOKOh7rq+wlJIHyGf92UX0V1Wq+edU6v5Gd8EZCXPqceSB6
 VdFBCJNKH/12IZVhKJT8VKNWiphRD4EvBZ0WJpg49LfLK8gPIGJMxYhF/5H0C1ApkeDZsPJ8Z
 8clhFRB7L4Nz5YaRQl/AvWqkS3GjEV1rqNzXS7bGTnsj2JVoyMy8l3vYNZiUgwIEMBGCAUi+k
 6S+LU+xtZdi+IFc27doYyC/wn7NPvjbJe6LAw6K1I9g3Q=



=E5=9C=A8 2024/7/16 07:41, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/7/15 22:01, David Sterba =E5=86=99=E9=81=93:
>> On Sat, Jul 13, 2024 at 07:45:08PM +0930, Qu Wenruo wrote:
>>> Currently the BTRFS_MOUNT_* flags is already reaching 32 bits, and wit=
h
>>> the incoming new rescue options, we're going beyond the width of 32
>>> bits.
>>>
>>> This is going to cause problems as for quite some 32 bit systems,
>>> 1ULL << 32 would overflow the width of unsigned long.
>>>
>>> Fix the problem by:
>>>
>>> - Migrate all existing BTRFS_MOUNT_* flags to unsigned long long
>>> - Migrate all mount option related variables to unsigned long long
>>> =C2=A0=C2=A0 * btrfs_fs_info::mount_opt
>>> =C2=A0=C2=A0 * btrfs_fs_context::mount_opt
>>> =C2=A0=C2=A0 * mount_opt parameter of btrfs_check_options()
>>> =C2=A0=C2=A0 * old_opts parameter of btrfs_remount_begin()
>>> =C2=A0=C2=A0 * old_opts parameter of btrfs_remount_cleanup()
>>> =C2=A0=C2=A0 * mount_opt parameter of btrfs_check_mountopts_zoned()
>>> =C2=A0=C2=A0 * mount_opt and opt parameters of check_ro_option()
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> The current patch is still based on the latest for-next branch.
>>>
>>> But during merge time I will move this before the new rescue options.
>>
>> You konw you can't do that right? The branch for 6.11 can't be changed
>> anymore and it was late last week already. I've forked the changes at
>> 8e7860543a94784d744c7ce34b7 so far it's still subset of for-next if you
>> change anything below that then it'll cause merge conflicts or would
>> need manual resolution in another way. Until rc1 it's probably safest t=
o
>> just append to our for-next.
>>
>
> I guess it's impossible to drop all the new rescue mount option patches
> from 6.11 queue?

My bad, just see the git pull, so it's not possible anymore.

Then I just hope the patch can be merged as a bug fixes sooner, or we're
going to be flooded by tons of compiling failures.

Thanks,
Qu
>
> If still possible, I'd prefer to drop them first instead of hugely
> breaking 32bit systems.
>
> Thanks,
> Qu
>

