Return-Path: <linux-btrfs+bounces-6121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E6791ED68
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 05:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23E51C21463
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 03:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8001CF8F;
	Tue,  2 Jul 2024 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="A9+mGh6v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117514293
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719890338; cv=none; b=YJeVDR9XJsZRu8jjPanfgrNsY2kRXtg+jDQt793084tLaQ82ayxqcFa0Cw+IQZzVARRNk8fCOF7lfhoOmbR8YCgjuR0H9QDgxsfETC6GXd0o0vb7ka4OsRpqAJL+s+V5TcIs19FPxq0a1Qf7Ose6gtL8y0qmz+Bi+nSkkxapzLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719890338; c=relaxed/simple;
	bh=hCTh1dAlaJ73hV+QFhyRF1j0YgFA9eFJoBY5pB9kXOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UBPY75dGo9OJgHXlnBM6h3QwNyMrD97Mo4gQaynLHMQFcfXH5n3clu2w5SSDzZIr2Kv5yKwwpthyowmZ1yOYdL2c2zal8kaxSDLivxjc8LVbUrTVkgfYr7ATRgQipGDuiDtSGYPY4FyW2g/6yV0TqwJ7zCTx1ZZPezLrYUfL8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=A9+mGh6v; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719890331; x=1720495131; i=quwenruo.btrfs@gmx.com;
	bh=G1P4GARtKxd7Idm/Bo9EBVSh6nqvGREKYN0d/TG26ks=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A9+mGh6vx7tlAEHmXmhHfTpYDkTBJZOqdPUVh4rUPNyYV62doS0U1yE+aql9hx6F
	 DXmlLA0GMPv9dbwPcVTGFAdJTtwZ5ER0z6Xt2A0A7W6UUO42hDPrxWUmcZ8Iq9mN3
	 GEEQAfUqI+rl2aijlOocVm9VXKTHLl29EJPes8i0m5/XmFmh0IcgSyvzPLin626Lj
	 S7IQAtyWT+D92ezG9gZM1+If50MD1Imy4uNGCthmFDAzHaBTrrB57ZBOYV2sv2Zh3
	 CPc8lWKDyTTknRI872lB6JQl+sIpMP/NLFFsPFP1vFWA4nYv5PuOEE9z+BFugjy6L
	 GFJIPQWRUyrnTjJMGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3lc9-1sNexd3Pyl-001cEF; Tue, 02
 Jul 2024 05:18:51 +0200
Message-ID: <7365a3fb-1445-42cb-842e-a17507568d61@gmx.com>
Date: Tue, 2 Jul 2024 12:48:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: add --subvol option to mkfs.btrfs
To: Mark Harmstone <maharmstone@meta.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20240627095455.315620-1-maharmstone@fb.com>
 <847fb295-1a0e-429d-8d04-67948240fa5c@gmx.com>
 <SJ2PR15MB5669263312ED115369A4E6BFD1D02@SJ2PR15MB5669.namprd15.prod.outlook.com>
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
In-Reply-To: <SJ2PR15MB5669263312ED115369A4E6BFD1D02@SJ2PR15MB5669.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KNPu5gAhV7DIjfPIDwtx3tOVCtKuHNx+/CkXmspP/mKRg7SS9rl
 Sb42fd/56PuOP4rJT/aJvMgAFiOY8FAy6LeM//Z0zoGiIcQ2tS5XW6zG0UaNDi8hNx9H7b1
 oG90z98RnFp1gAhTJn07uyhJjgYMZjdYpNHu4gqpHzuVi/M829XQihO8XIgmao8nY/AWGB1
 /zdfC2QIWDpbhecS1J7ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vEI0tiyMYaY=;IhvsejLGbojcvhQKasfAf2hO9wY
 oEcrKbLSQm29Ug+5B6cmxMvkw/7gQHdTjl6momXc/Aqc5/NAmGAyhQAFA3lAvV83MTlE2gdE+
 JHLXY9RBWxvNGOikqDZBT8MAa9QjO5/pJ4jHxdsaJW6zE/ayysILqZKRe0VtCg6b7HB/D4esL
 w7cVwX6vMBfrLGldxMmsnxgGInoIhjnqmYMdSf5TJwSHoXgTuyla1syxn9iSumist23eilN1V
 hK9jdSn8D1XghCg9QaPcHbnsw+kKkmVt+35uBvNGOL3kWWRNJYBe67QXXSE5rLF4jMuXOEc/I
 GCu49uvayqmu3kmBYKm8XtVyoIiXA+sZL3gsZgatv63aEJX09eQTMpdXVNVRXptPgESG9BTXr
 /Fpl0EgbN4q3yftFCFGPc10iFVrXvPi/0vvbLUDWVCgAhuCMPUCzejFYwGFP+QHuvCYq1ESWm
 HFrX1567hzYIR+lX9br7ADk1u4BbQCiFUOXRXjBdXGyv3z7iXvuUrkAR4igZocI/x2wLWhffU
 8D2YVnfCbswO+g6CdoF00v9kLitoRWGTtR9SfK4vliajeya3VJLdnWCyriqgttR8v8Y0LyQH5
 /3Ot8B7Ia2kBu7SW4kuXvXmUFJaj/AAa9Obf1WZ7YdWP9ClNifDaKgYoR930yzzWBfxYAEFNN
 ylBGZS/YW/wEkahXqM9uu6yhscqAGdgwJ+lEc5JkWzlCqWySVjAI4BPYxHe4P25Qc2P8xwLA/
 GSHLe/a2OMJuzukrZ6Enn7VFmynNv3t1oUAf7nsBwpzQ3MSwlcHL+/psYuz5eRLn5eMIDiY56
 kJRiqxNhOWyMnNwBAKIbPnTczJ+I8/rAZdfyuHNCfdEZk=



=E5=9C=A8 2024/6/28 19:17, Mark Harmstone =E5=86=99=E9=81=93:
> Thanks Qu.
>
>>>    struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
>>>    				  const char *base, u64 root_objectid,
>>> -				  bool convert)
>>> +				  bool convert, u64 dirid,
>>> +				  bool dont_change_size)
>>
>> Any reason why adding this new parameter?
>>
>> Normally it's pretty nature that we increase the directory inode's size=
 with new
>> entries.
>> Just like btrfs_add_link().
>
> Because btrfs_mkfs_fill_dir calculates the inode size as normal, but ski=
ps any
> directories that are going to be subvols - so we'd be double-counting ot=
herwise.

That would be another reason why creating subvolumes at directory
traversal time makes more sense.

In that case, btrfs_add_link() would address the inode size change.

Although currently btrfs_add_link() won't handle linking to a subvolume
yet, thus either a new btrfs_add_link_subvolume() or new parameters
would be needed.

>
> Another way to do it would have been to pass the subvol list to
> calculate_dir_inode_size, but this would have meant a lot more recursing=
,
> and writing the parent dir inode item more than once.
>
>>> +	ret =3D btrfs_copy_root(trans, root, root->node, &tmp,
>>> +			      root_objectid);
>>
>> I'm not a super big fan of copying root just to skip the initialization=
 of some
>> members.
>>
>> Can't we just use btrfs_create_root() instead?
>
> I was copying what we do in convert.c here. It's something I can look in=
to in
> a later patch, if necessary.

I'd prefer to do the cleanup/refactor, then the proper implementation.

Or it would be pretty easy for us to forget the needed cleanup/refactor,
and lowering our code quality in the long run.

There is not much hurry to implement this new feature immediately, thus
we can afford properly cleanup/refactor first.

>
>> Would it be possible to do the subvolume creation during regular direct=
ory
>> traversal?
>>
>> By that we can just treat a target subvolume as a slightly different di=
rectory
>> creation.
>> The biggest problem here is, we only insert the root items without any =
backref,
>> and immediately commits the transaction, and would need special handlin=
g for
>> target subvolumes anyway.
>
> I think the issue was that btrfs_mksubvol does its own transaction, so c=
an't
> be called from within btrfs_mkfs_fill_dir. Quite possibly it could be do=
ne with
> some refactoring, but I've tried to keep the code changes to a minimum..=
.

Again, there is no need for such minimum modification right now.

>
>> If by somehow the mkfs is interrupted, what we got is a corrupted fs wi=
th a lot
>> of subvolume which can not be accessed.
>> (Well, not a huge problem since the mkfs is not done, its super magic i=
s not a
>> valid one, kernel won't be able to mount them anyway)
>
> Yes, I don't think transactions are all that important when it comes to =
mkfs,
> as you either have a valid filesystem or unmountable nonsense.

In fact, I'm wondering how hard it would be if we do the subvolume
creation during directory traversal.

Mind me to try implementing the same functionality as an experimental?
With all the proper cleanup/refactor, you can still benefit from it if
the experimental proves infeasible.

Thanks,
Qu

>
> Thanks
>
> Mark

