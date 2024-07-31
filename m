Return-Path: <linux-btrfs+bounces-6932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC5394391E
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 00:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D1AB237F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 22:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E5C16D4DF;
	Wed, 31 Jul 2024 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lecsG2QC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166549625
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722466543; cv=none; b=nFlasFJggOamoSqA2KVYZdiWZwZuuiD/YLEq8T+w5zwACWDPS6QmItKDeMFhckC+7fkxkzYQA7Wh5zGa2kbP4k7wthqHwL0NHjsmtARQTa/dFa/MlfqbIx3DuHgrBBCnHoHjEBU4RVL+mmMg9qZhJVGI98enk4G0eOUM4xAnZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722466543; c=relaxed/simple;
	bh=W1Ni9HasrFrVvTpxqfWsXTqdwGRpVd+ENxL9ODJpZuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1gtUK/Oyk9RfGz7ZFmz19ZBdkrpI02NDtDpoKiRvHqQxELujN9+yxOluqADSAv9sL/gAnwFMSPUwL/aivW0auhqWadzLMLaop8OzZtATY1s7f5nfd42Q9/tVwg42wc8pj5dkUKy2DtebtEOOGyskymmQhCvYbeeYaMWgXGV39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lecsG2QC; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722466533; x=1723071333; i=quwenruo.btrfs@gmx.com;
	bh=st2/Lh5Mgk9tWiG7nFbguOl0uvO5jm6mgfGu+R338yM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lecsG2QCEc65EjUgHoTC/PgdoV8702m6b/wweY6kOuTrnrdqRt8vpMl/k/pmeWqZ
	 WCjVIL2n7AzKXDKQhx/kXj79k+29+HaJj6JCcwlKl2g79el5ktN2c3gbrL8SEbm0e
	 /BVKukPJxx0Q2fiFSoy/K/DJo6bY4m/ZKdEkczn2cdNTYqRc+AV0OyEZ3T+rfMmpe
	 3gZqntFH9Kt5c6QcqvD/fYN3W6YdKvZkkxecHm/4I0wIUgIjDJxtLdu4c9APe1ntC
	 lBFSYDpBSdBBmgVwLlncDpi49BjMYCXREK9VMzpUtfyhtI6flYLi8jPW03cswJHMj
	 lyRF4NjWVvATXhm4cA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7zFZ-1sCrp81fcZ-00yVvV; Thu, 01
 Aug 2024 00:55:33 +0200
Message-ID: <91358b99-104e-4069-8fd2-1d8af77bd65b@gmx.com>
Date: Thu, 1 Aug 2024 08:25:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs-progs: rootdir: reject hard links
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1722418505.git.wqu@suse.com>
 <7984ff20beeb81268f786234d30d3c24d90a9a5b.1722418505.git.wqu@suse.com>
 <20240731221739.GA3808023@zen.localdomain>
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
In-Reply-To: <20240731221739.GA3808023@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j6hVtOdECMemHLW2aTd8sLrnJ8DGCN7TXwWdEehTazaU4m5aZZR
 Ouza5AShH/O0RqZzN/R2pDl8/ccBU73fadT0xR9iQWwTu9hL8TUHSq2e5F/xSHHAmhKcjUV
 LTVzVxKhD1ZjYxlVJWkMDrVLo0hFoE3XKmMtcmNOjtAOjwVJKWdVxtwTyboSEdMoBJeSgVp
 N7iGfx/2mz6ZcjPAXQcTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BG6OaDs3aIQ=;VbV44psz5SVDtSJ1WVup4i0F0Bc
 hCdSmvp+2rp1YpcmIroOBEOJ+xgQQj52xwu063qGKRUcmjc47e8+eOFyi7mK3eE+/VPp4uyxk
 BaqIO74CKLIS9kF61DDfodaoygc130Jj8o1fgO83VAARfyfObCNkTkNEr6cK6jWtWI1cJeeti
 XCSqbY4hxko1kamS6mVx72w2N5DnOmMyv9sX6KGLmrAIEgp16M7E5e4oMQXqi/8Lv7+geC2XG
 zVOeP4PJ2gwl5sP7E1wOzNQkD+/MxlRZrVKJGyd5lrFESYcB/2eWsi5RRnwHv7KbkN8WRspNk
 GU+yV3DcONzY+0Yotx32uiB+cWmGFPKfoSm5brd57WgqI6SVNAf1fzDENgS6MgiLsoaMbKzJp
 LxBPs91CxBIEyEtNUMVB8Hdr9fb7pCV8lhzdPWohLGcIaR2c6wEbrN0vJTjNL3MaIYkUD7B1i
 FCxbiBDh7JLmJIeJn060fRvGKEFw2SNyV7z3HGSEt3vKBamM3GsEEGjyG/sBsY+jjkrSLyGVM
 WFyPcq+Ylris6HpEy8/a6FPyagLEMTggxLwz+tpusVKsPlDToZA/IKuwJ8vQCjJrIlecGcNek
 gp3SphzVoNqH+GFuMYgk1GxS8UOSkOiAu4kceV7ANE9ZmaL6KXa6w8aMespBAoGj4Rn8SGouB
 RCaRZGKHbUpeYOJHcuNBE2jpu93lNEDoS98vaUyVc+eY1s6zMayN+6FM+CMF79ZdsUiAv6Zx6
 1k4b0EQebNwfztSrsPPeJVcyvS4/iACUObOPbUvPF6NdTf9ZASHRk6Cmn7PfiNR+3rBHBBASd
 eqybffc/v00G2baVhSElutBw==



=E5=9C=A8 2024/8/1 07:47, Boris Burkov =E5=86=99=E9=81=93:
> On Wed, Jul 31, 2024 at 07:08:48PM +0930, Qu Wenruo wrote:
>> Hard link detection needs extra memory to save all the inodes hits with
>> extra nlinks.
>>
>> There is no such support from the very beginning, and our code will jus=
t
>> create two different inodes, ignoring the extra links completely.
>
> I don't understand exactly what this means.

I mean, if we have the following layout as source root dir

rootdir
|- dir1
|  |- file1 (ino 1024)
|- dir2
    |- file2 (ino 1024)

Then the resulted btrfs would looks like this:

.
|- dir1
|  |- file 1 (ino 257)
|- dir2
    |- file 2 (ino 259)

Making them different inodes.

>
> How does the code you are replacing handle hardlinks? As far as I can
> tell (far from an expert...) it looks like it does handle them, so
> explicitly rejecting them now is a regression?

Sorry, the new code doesn't handle hardlinks, they are treated as
different inodes.

As the new code always grab a new ino number for each file.

Although things like btrfs_add_link() can handle extra hard links, we
always treat every inode we hit as a new one.


And yes, it is a regression. The old code skips the ino number detection
by reusing the old ino from the host fs, which introduced two bugs (that
we didn't notice until now):

- If rootdir crosses mount points, we can have conflicting ino
   And screw up things easily

- If rootdir has an inode with hardlinks out of rootdir
   Then the resulted fs will have the same nlink number, mismatching
   the correct number.

   Just like this:

   # mkfs rootfs
   # touch rootfs/file1
   # ln rootfs/file1 file1
   # mkfs.btrfs -f --rootdir rootfs $dev
   # btrfs check #dev
   ...
   [4/7] checking fs roots
   root 5 inode 88347536 errors 2000, link count wrong
	unresolved ref dir 256 index 2 namelen 5 name file1 filetype 1 errors 0
   ERROR: errors found in fs roots
   found 147456 bytes used, error(s) found

So for now, I'll go with the more robust and correct code, with the cost
of buggy hard links support.

>
>>
>> Considering the most common use case (populating a rootfs), there is no=
t
>> much distro doing hard links intentionally, it should be pretty safe.
>>
>> Just error out if we hit such hard links.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   mkfs/rootdir.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
>> index d8bd2ce29d5a..babb9d102d6a 100644
>> --- a/mkfs/rootdir.c
>> +++ b/mkfs/rootdir.c
>> @@ -418,6 +418,18 @@ static int ftw_add_inode(const char *full_path, co=
nst struct stat *st,
>>   	u64 ino;
>>   	int ret;
>>
>> +	/*
>> +	 * Hard link need extra detection code, not support for now.
>> +	 *
>> +	 * st_nlink on directories is fs specific, so only check it on
>> +	 * non-directory inodes.
>> +	 */
>> +	if (unlikely(!S_ISDIR(st->st_mode) && st->st_nlink > 1)) {
>> +		error("'%s' has extra hard links, not supported for now",
>> +			full_path);
>
> I would change the message to something like:
> "inodes with hard links are not supported"

Thanks for the advice, I'll go with this new message, along with some
new test cases for the existing hardlink and mount point bugs.

Thanks,
Qu

>
> Thanks,
> Boris
>
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>>   	/* The rootdir itself. */
>>   	if (unlikely(ftwbuf->level =3D=3D 0)) {
>>   		u64 root_ino =3D btrfs_root_dirid(&root->root_item);
>> --
>> 2.45.2
>>
>

