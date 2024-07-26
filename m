Return-Path: <linux-btrfs+bounces-6789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 589F993DAB1
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2024 00:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E7B283B7F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 22:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F202A14A4F5;
	Fri, 26 Jul 2024 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gm3L2so1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3FD6026A
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033212; cv=none; b=XZfyFF9mGndRLBVK4H4N2q9rYiIMnRjeVb3oJl8v1OTE7gRYrrJdQOpBcp6RIvquDGrxCioz2LhC+VOQnK3Y4MGL+eyoiamv8DfbFmnzBoh9/llG/ONiG7GCc6kpG7QIzHacGQl/b+xN3T56LanZGMBEns10tGFxA8skKvkOiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033212; c=relaxed/simple;
	bh=GaxyiBDY+qoI8kA/THAYjqiUkAGq6DKrRvKEF+9YUFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oG9DQvAWAFfyXJHWyzD1Gy7DmLxFD3MvOUAiDpBFKcNFLWqmOqGPu2g7c5j5BqRxAKVpz4SEg80Z9nJjG/NzYdUC1dRgb6ZrAnBdE7wn6Pq3viLzkr5jAoSzQNw41Ebw6xiHTfpsX2frMbctAOZRgru5V4EqNEOdiDBrPOXCJUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gm3L2so1; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722033206; x=1722638006; i=quwenruo.btrfs@gmx.com;
	bh=09NGAesj/FandeN3OT2Z6tQXTlD8Pxy5b22JXeYsgiw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gm3L2so1Np1/Zne2CH0Q41gx6HtO9HylCxU43QMISekrBIcFjUv3jrdnnhBy+hFg
	 wAYnL5oB7aW6prRzLshpAqt8iSKnDKu90S3VdZoKYjJutJA2FpIb40/6B2/5p2o6S
	 ehjnaPhKSZ5GDN3riE00mP1/8wdCEZXPX3SChIT7WW4y4lPb3sm61Ie4ytNjGg72D
	 PSPiVTu19Rw1EzYCXkxMqHlIkWHapU7lms5ApMfel6Ku2Vr/gc7oJ4R2N/7UExHTN
	 A7hGXot/TNaWthRbWVvUKHtXW1nuSIZZJkeIan0Ok2iRDVzvnAojS8QVZEpvOUbiP
	 KwIplJN54DqnTu+IWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1ps8-1sZgQY1Jqi-00Bxdq; Sat, 27
 Jul 2024 00:33:26 +0200
Message-ID: <2a103477-428f-4145-94c0-5d2352c9a926@gmx.com>
Date: Sat, 27 Jul 2024 08:03:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs-progs: introduce btrfs_rebuild_uuid_tree() for
 mkfs and btrfs-convert
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1721987605.git.wqu@suse.com>
 <8e33931a4d078d1e1aa620aa5fe717f35146ef31.1721987605.git.wqu@suse.com>
 <20240726153515.GI17473@twin.jikos.cz>
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
In-Reply-To: <20240726153515.GI17473@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HRzsYYTMx5+6X1dKa311uU94Avqq/cvRMuRlhBh4PvCE+J7I/Ai
 /FnRniStB0aMpCa7X7v1yIZhmsg6wuEhTmsAeH59PfHer27bLTgpnOwSu/FYtpmbkvQ5H/T
 B9RrIrdMNR7IE8m1gkR4vM92jQY9yLLLww7u2Jf4EA6x7CpziK3eOtW0p4SfKe5z6Bz4HJ3
 QY98iMDSxCV49XHRSwdvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:izNVYyBba/s=;hsKAvDoQi4bHx40AZ4mCY9kkpFN
 KmZQCKCfik+Psp/XP5Y4hcNFXKdFQtVj6RIRVpZOHMg6wCRCm0Yc/rtKCbUEX29/j1ZfkXi2A
 0LhigVIVi4bbKGVC6cTbcdYF7MP7yuDCjdEazHDK5SBNSny2BvL9W06EVSTaldkZfzeWaCgWu
 Qr7Diq5BCpvoaSwu4RSv6xtWQgxb/Hz7ZQTS+p7n3KxBLuqZeAY8HM4loLJtJTjViTD1GHrT2
 3U6aBiqZ4pzUwLfQdnwvPOAat3QYqoU+Ia23vPIVvn/gNt7gpEBpq0bEHMoNacb5UjrKk38oO
 yoaw3bxopFI13ssWXIFX/RBHW3i2OpA+Ab869SapLCAzp6yJ7sl4GaACj1+g0JAyr9LDBwDvC
 27ay7luKT3UIThozf3yh1tC4PUtasCnvdNv7G60fOk4HmlngrEwbHApuD3887s6qNfX3Xymhr
 ocRMTGt+CNcRJaRidGFcmk5YjMZTBsN4cat178fOmbsiPopkzFKj579rUhGmvoiYVVKiBgsjz
 OO23BOEbCPibcO8+IHkAgW9Nfd5fryq0tLX6Zhx1/COG8DG5OfAANkWPyprqBE2/EXVpJ5KT/
 FErZycGvec3vkbx7Ufpr6ne/p+6jfPFoqATc5exh+U5FqZ+XWv4cZumBeTIkFIdq5V7qCjSRW
 YKbeYv0RLGyTW7bSs4/IdtTjX9oXYlrp0JWmHS8RqCRYRXfJxeO03vuQUnO2uJk/3jvGSHNtr
 F/sahFSIKCZj3/pZC8elG/UXUcEYcJwhnGu4plHG/2VRCmta6y8UXkOO9Ebi+KiodR3iKlOor
 laBLbU1X+cJquFMngdp0OZ7w==



=E5=9C=A8 2024/7/27 01:05, David Sterba =E5=86=99=E9=81=93:
> On Fri, Jul 26, 2024 at 07:29:55PM +0930, Qu Wenruo wrote:
>> Currently mkfs uses its own create_uuid_tree(), but that function is
>> only handling FS_TREE.
>>
>> This means for btrfs-convert, we do not generate the uuid tree, nor
>> add the UUID of the image subvolume.
>>
>> This can be a problem if we're going to support multiple subvolumes
>> during mkfs time.
>>
>> To address this inconvenience, this patch introduces a new helper,
>> btrfs_rebuild_uuid_tree(), which will:
>>
>> - Create a new uuid tree if there is not one
>>
>> - Empty the existing uuid tree
>>
>> - Iterate through all subvolumes
>>    * If the subvolume has no valid UUID, regenerate one
>>    * Add the uuid entry for the subvolume UUID
>>    * If the subvolume has received UUID, also add it to UUID tree
>>
>> By this, this new helper can handle all the uuid tree generation needs =
for:
>>
>> - Current mkfs
>>    Only one uuid entry for FS_TREE
>>
>> - Current btrfs-convert
>>    Only FS_TREE and the image subvolume
>>
>> - Future multi-subvolume mkfs
>>    As we do the scan for all subvolumes.
>>
>> - Future "btrfs rescue rebuild-uuid-tree"
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   common/root-tree-utils.c | 265 ++++++++++++++++++++++++++++++++++++++=
+
>>   common/root-tree-utils.h |   1 +
>>   convert/main.c           |   5 +
>>   mkfs/main.c              |  37 +-----
>>   4 files changed, 274 insertions(+), 34 deletions(-)
>>
>> diff --git a/common/root-tree-utils.c b/common/root-tree-utils.c
>> index 6a57c51a8a74..13f89dbd5293 100644
>> --- a/common/root-tree-utils.c
>> +++ b/common/root-tree-utils.c
>> @@ -15,9 +15,11 @@
>>    */
>>
>>   #include <time.h>
>> +#include <uuid/uuid.h>
>>   #include "common/root-tree-utils.h"
>>   #include "common/messages.h"
>>   #include "kernel-shared/disk-io.h"
>> +#include "kernel-shared/uuid-tree.h"
>>
>>   int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
>>   			struct btrfs_root *root, u64 objectid)
>> @@ -212,3 +214,266 @@ abort:
>>   	btrfs_abort_transaction(trans, ret);
>>   	return ret;
>>   }
>> +
>> +static int empty_tree(struct btrfs_root *root)
>
> Please rename this, it's confusing as empty can be a noun and verb so
> it's not clear if it's a meant as a predicate or action.
>
Any recommendation? clear_tree()?

Thanks,
Qu

