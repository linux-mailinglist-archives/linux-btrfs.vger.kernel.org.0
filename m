Return-Path: <linux-btrfs+bounces-8097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D6B97B512
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 23:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 907A8B26759
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844DD1922CB;
	Tue, 17 Sep 2024 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ILi5DPLY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD11891BB
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726607798; cv=none; b=f7yt3Prc2JuBLJ4hy0EXcDeC1fFw7Q+yufLUg70vIux2f3U52VVk2Je32O0LuuVYeTdNyqYS1s6Gusk9gmqCWqlOflSasYvKx9GwffX9pIcbybFFfPQKpRPD/kGEpaBBGOfPOWWnqugXnUvO12XhJsBjBe6jwmlaSAcpAD2/eo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726607798; c=relaxed/simple;
	bh=3Jvahh2zx0mXt/HapHfQM65FrCUBvy7xFyuM+xZd2aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZt42AVkyqpZd3WgOlLE3nbif+/m29cx37dNi4QVPWm4jIw00CBtPKuuQ4UiCY97BxMYYVcyqq7tAg/4DRm5hp176DGUb/b1l7fzdmCWR775wMz06+LXHo7ixbm2wxWTMGK/K6Os8PV0cH0E90C32blSqgg21dIXSALR45jmwUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ILi5DPLY; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726607793; x=1727212593; i=quwenruo.btrfs@gmx.com;
	bh=RcNzGqXKu7DHQ/5aPaIhXZ8zuDRPv2sYuV+Xh02wGDs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ILi5DPLYPTczdsmPTaGrUV2bDqHzpfdP03NEGJij1VYjVdRnANAWa7o0S7atzLMo
	 ny57ryL5AWsAyPRh6kZwz2yHyf6gh0ew22ECijQNqyXuyfKfJPEYhK4Cf4Doz/1i2
	 lcDu21qhcBNAjDdDJe32thw6AvOzz2Z1ymEjiXyE2jS39bIRKlY+lLWjtAwsbPn9L
	 dV87/GgdtL2fAt3zV55muHI4lEz0qqC/sXWH8Aw6L70PnShFv22LZ/V82QNRqcsZq
	 ODvBs/rsCZZ2JGKYFdkbJo9Syv8QbvF53DuLfKAXV3ZoSvd1Noi3MjYCzkyIvP5uF
	 vhDJ3CwILUk1LSH3IA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6llE-1suW6w1oMA-009RL8; Tue, 17
 Sep 2024 23:16:32 +0200
Message-ID: <a72c9f34-cbab-477e-9c7e-9c4c2a994213@gmx.com>
Date: Wed, 18 Sep 2024 06:46:29 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: wait for writeback if sector size is smaller than
 page size
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <39b20c5e65df079ad99aa06ec7f70f164a541c09.1726011483.git.wqu@suse.com>
 <20240917164543.GG2920@twin.jikos.cz>
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
In-Reply-To: <20240917164543.GG2920@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:duwJsLTDaeOP++sg8ribjYGyzb2NnD+1UrBKZmLYZY3SAowIQE0
 FsrovkewVW1gOnLTt+q7TzhRFtD2XOwHxUG/4gWXeRBsDFC9yHS+UswgmMEXHHMxzzmB23r
 hDccETv5bR4I7velX/SpvB2hVWOIxJeN4its4kJDeWqLmr0NWZ5CcanjmsSj9KVkWuB2F3m
 Z2HAk8IZaE8GziKLGierA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gDa2hhut7x0=;owyr3GxwTeBm/nYYh9l2RMSH9sJ
 k1CSYBAQj7DqPPbiPVnK8sG1XN3vK4yhOaPCju5pWqnuc4Blyhzze7o+tR+h99pbCwozCsCMK
 ZPZOu+D5IwUnwN78ScACZEWx5vbm68VCJbnU4TtL8OOV04oUgLVKX7VlOE8CDLLOSPgM8ZZmu
 JgMa86ONF2sXnc8SjlmtiH+RMzXdn9730mMuoN7PHQJZaewBHguqrf+HIhCVeJlcNWsvHQTS+
 W7rL3LeliddwAlNHsy3uyQG01bIDjWaYgPA/Hb3J8BkBihHa50RLJ1uCC7eNWst/vHquJ/7g7
 Rym8u8v78ATtbL2wDjT0w0Fidj/8sg85j9tEfFbTYbGmXm4BfqbKBkqPItqiscAweIGLv3Bzf
 fovLeBr2VCQkUyKQyKotQTnTUl9GQddK9KMGe3sud+ET+4Dx9E7KHonzGmhffxEFDSgg1gwym
 fHgIWvu9mPgv0E/syRJ4abZFM5APD2Me0NLKg2UiLuAwPTD/UaWwoZTth35BxMDMVfrIPhILR
 qFinxHeN5fmcU7OQ9Nkl1b+9Va/zwJgVLfKNFH+dnUWqqCgM4QmVjkG+haWutTMDPBMPFii7x
 60gQoOuPJSy69S3gzhkXE07+RHOIINcT7Ax7HoCsF73kkK4JdHM/ewYyI7kkIhhtfnaGovGXX
 lbrGgZaPaZjU7YONpYty2amlYxq+D26qhtMoqWZtQ6/y9C1W4F/TuSWnykGEZR/iCdGW9uqt/
 3dZkH736nEQmlZdtmpRh0P4eusulYQ6uloFX/X0mxxdwOaKOXbEHy2juvQQCmLdnzFouPmw7b
 10s5u8yKFuF1cyb57RW1c0cOTyhq4SxYeV3myKYf+4xR0=



=E5=9C=A8 2024/9/18 02:15, David Sterba =E5=86=99=E9=81=93:
> On Wed, Sep 11, 2024 at 09:09:05AM +0930, Qu Wenruo wrote:
>> [PROBLEM]
>> If sector perfect compression is enabled for sector size < page size
>> case, the following case can lead dirty ranges not being written back:
>>
>>       0     32K     64K     96K     128K
>>       |     |///////||//////|     |/|
>>                                   124K
>>
>> In above example, the page size is 64K, and we need to write back above
>> two pages.
>>
>> - Submit for page 0 (main thread)
>>    We found delalloc range [32K, 96K), which can be compressed.
>>    So we queue an async range for [32K, 96K).
>>    This means, the page unlock/clearing dirty/setting writeback will
>>    all happen in a workqueue context.
>>
>> - The compression is done, and compressed range is submitted (workqueue=
)
>>    Since the compression is done in asynchronously, the compression can
>>    be done before the main thread to submit for page 64K.
>>
>>    Now the whole range [32K, 96K), involving two pages, will be marked
>>    writeback.
>>
>> - Submit for page 64K (main thread)
>>    extent_write_cache_pages() got its wbc->sync_mode is WB_SYNC_NONE,
>>    so it skips the writeback wait.
>>
>>    And unlock the page and exit. This means the dirty range [124K, 128K=
)
>>    will never be submitted, until next writeback happens for page 64K.
>>
>> This will never happen for previous kernels because:
>>
>> - For sector size =3D=3D page size case
>>    Since one page is one sector, if a page is marked writeback it will
>>    not have dirty flags.
>>    So this corner case will never hit.
>>
>> - For sector size < page size case
>>    We never do subpage compression, a range can only be submitted for
>>    compression if the range is fully page aligned.
>>    This change makes the subpage behavior mostly the same as non-subpag=
e
>>    cases.
>>
>> [ENHANCEMENT]
>> Instead of relying WB_SYNC_NONE check only, if it's a subpage case, the=
n
>> always wait for writeback flags.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 385e88b7fcf5..644e00d5b0f8 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -2116,7 +2116,27 @@ static int extent_write_cache_pages(struct addre=
ss_space *mapping,
>>   				continue;
>>   			}
>>
>> -			if (wbc->sync_mode !=3D WB_SYNC_NONE) {
>> +			/*
>> +			 * For subpage case, compression can lead to mixed
>> +			 * writeback and dirty flags, e.g:
>> +			 * 0     32K    64K    96K    128K
>> +			 * |     |//////||/////|   |//|
>> +			 *
>> +			 * In above case, [32K, 96K) is asynchronously submitted
>> +			 * for compression, and [124K, 128K) needs to be written back.
>> +			 *
>> +			 * If we didn't wait wrtiteback for page 64K, [128K, 128K)
>
> Should this be referring to the page from offset 64K, ie [64K, 128K)?
> Otherwise the range in the comment does not make sense.

My bad, I mean [124K, 128K).

>
>> +			 * won't be submitted as the page still has writeback flag
>> +			 * and will be skipped in the next check.
>> +			 *
>> +			 * This mixed writeback and dirty case is only possible for
>> +			 * subpage case.
>> +			 *
>> +			 * TODO: Remove this check after migrating compression to
>> +			 * regular submission.
>
> Please don't add the TODOs, keep a note or add an assertion instead.

OK.

Thanks,
Qu

>
>> +			 */
>> +			if (wbc->sync_mode !=3D WB_SYNC_NONE ||
>> +			    btrfs_is_subpage(inode_to_fs_info(inode), mapping)) {
>>   				if (folio_test_writeback(folio))
>>   					submit_write_bio(bio_ctrl, 0);
>>   				folio_wait_writeback(folio);
>> --
>> 2.46.0
>>
>

