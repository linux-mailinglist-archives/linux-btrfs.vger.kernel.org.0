Return-Path: <linux-btrfs+bounces-17235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1E5BA6A33
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 09:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4FF17B1E7
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 07:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCB42343C0;
	Sun, 28 Sep 2025 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mOkhFm0h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382DA824BD;
	Sun, 28 Sep 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759045067; cv=none; b=MUeFE+LlH1ETUULJZjW6H9dBxNimKnqOqsssrsnDiSPEA+uJKTopDkXlFK2WZHEIB6lM45xjRWBnSxMURKzJPn4WlwNPBO2E4dvxabBf38GwEffXcnvLu6kghU3s+BD61TEUUyiIXgIHu5Vp0r/CU5EGKTvQC7W8pkKVO7BSZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759045067; c=relaxed/simple;
	bh=hWJ+XFf6xDGI2pfJpEyZM0CZHB95mL6gM8iov9bfYbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JShu2Op+diqlFXo77smt6G41JCNaYALG+k/o+ECM50v0uU0R9AiSIsycheERqcC4jeOHPy2Ue3Hc5wk82ob0+p1yQZ3o73kvJ9nnhiy3drILbFQmxIWgab5hcaN3zDPSx/jsnNyk8OZnrnAIrEXQGjGFq+YbK8VuIBk+c8R1chU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mOkhFm0h; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759045033; x=1759649833; i=quwenruo.btrfs@gmx.com;
	bh=uhGgrKPmnodgBZ4XtNPmhsA3dYr7hcOU6o2dCs0gCmI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mOkhFm0hdfhKlkAeKLOE0uGcfJIOfQFEzU14U418BdWpJ2tNAmJV8a2rzpWJ0NSj
	 jDye9R8Xfiu2YpxNLK9LFSZq0V5BGrv9Qf/vgXz+47RSAXPpmgPc9NYrc3pUvThjs
	 n/O0VyVEP2w1ZCHlZ8YZXAbJHEG2mjrEkrQBHJBJDd4OWAtA4SAwBCcvjOXiQNbhU
	 U5ESHWI3YQ0MvWkUCY93pqBD4ULTY7y2US3qVbsHquSSnwzK915pjoGsiWL64JY4q
	 dyoU9x69iWOqgveHGJbnFSh3ODcFfEPFCGU7G4j4Av5dMoINZ4QzbKWUTSJkxJ5jZ
	 S+pgV7dvEnbDCVUWVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVHU-1uiujf2y9w-00KQJG; Sun, 28
 Sep 2025 09:37:13 +0200
Message-ID: <d788b939-7191-426d-b2eb-944fd1c6b9ed@gmx.com>
Date: Sun, 28 Sep 2025 17:07:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Add the nlink annotation in btrfs_inode_item
To: Youling Tang <youling.tang@linux.dev>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250926074543.585249-1-youling.tang@linux.dev>
 <adda6065-26a2-4d31-b4f0-ccb20e0fadeb@gmx.com>
 <bda4b547-4dea-4c05-8679-1cf021bbe340@linux.dev>
 <b431fe00-43f3-49c2-a58b-8f79cb2134dc@gmx.com>
 <bc7a7e81-8e71-44ee-af4c-96193c9cb8e8@linux.dev>
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
In-Reply-To: <bc7a7e81-8e71-44ee-af4c-96193c9cb8e8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ya00iraCaay0ySfh1/DsNVSIlnR0kg0CQzGv/8WgwNTvK3W9uI4
 8sIjSYbE0VB0v0GBqEOJrYW38Cyya+r7tLY/RExVwpkOFk63iSa1GpxtTfvhVhvofh3vfXw
 P1u+9Mf+lMvEit1T8sapbwo0yTjq5zY46C6kyBusnwgFfajxDm/B+IkMkmr+k+k9swWl3Vn
 q1BovY4vuXy6+GhTnq9sA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NA6SQzrfgwg=;gtT6Z45idZfwEqyDdmoerTJ+fA3
 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
 et+uxOLM0CrHBX4w75bsqmSr+xuWuQ35EYw=



=E5=9C=A8 2025/9/28 16:39, Youling Tang =E5=86=99=E9=81=93:
> On 9/28/25 13:16, Qu Wenruo wrote:
>=20
>>
>>
>> =E5=9C=A8 2025/9/28 11:44, Youling Tang =E5=86=99=E9=81=93:
>>> Hi, Wenruo
>>>
>>> On 9/26/25 16:34, Qu Wenruo wrote:
>>>>
>>>>
>>>> =E5=9C=A8 2025/9/26 17:15, Youling Tang =E5=86=99=E9=81=93:
>>>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>>>
>>>>> When I created a directory, I found that its hard link count was
>>>>> 1 (unlike other file system phenomena, including the "." directory,
>>>>> which defaults to an initial count of 2).
>>>>>
>>>>> By analyzing the code, it is found that the nlink of the directory
>>>>> in btrfs has always been kept at 1, which is a deliberate design.
>>>>>
>>>>> Adding its comments can prevent it from being mistakenly regarded
>>>>> as a BUG.
>>>>>
>>>>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>>>>> ---
>>>>> =C2=A0 include/uapi/linux/btrfs_tree.h | 1 +
>>>>> =C2=A0 1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/=
=20
>>>>> btrfs_tree.h
>>>>> index fc29d273845d..b4f7da90fd0e 100644
>>>>> --- a/include/uapi/linux/btrfs_tree.h
>>>>> +++ b/include/uapi/linux/btrfs_tree.h
>>>>> @@ -876,6 +876,7 @@ struct btrfs_inode_item {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le64 size;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le64 nbytes;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le64 block_group;
>>>>> +=C2=A0=C2=A0=C2=A0 /* nlink in directories is fixed at 1 */
>>>>
>>>> nlink of what?
>>>>
>>>> Shouldn't be "nlink of directories" or "nlink of directory inodes"?
>>>>
>>>>
>>>> There are better location like btrfs-progs/Documentation/dev/On-=20
>>>> disk- format.rst for this.
>>>>
>>>> And you're only adding one single comment for a single member?
>>>> Even this is a different behavior compared to other fses, why not=20
>>>> explain what the impact of the change?
>>>>
>>>>
>>>> If you really want to add proper comments, spend more time and=20
>>>> effort like commit 9c6b1c4de1c6 ("btrfs: document device locking")=20
>>>> to do it correctly.
>>>
>>> My understanding of nlink is as follows, please correct me if I'm wron=
g,
>>>
>>> /*
>>> =C2=A0=C2=A0* nlink represents the hard link count (corresponds to ino=
de-=20
>>> >i_nlink value).
>>> =C2=A0=C2=A0* For directories, this value is always 1, which differs f=
rom other=20
>>> filesystems
>>> =C2=A0=C2=A0* where a newly created directory has an inode->i_nlink va=
lue of 2=20
>>> (including
>>> =C2=A0=C2=A0* the "." entry pointing to itself).
>>
>> Have you checked what's the meaning of the nlink number for other fses=
=20
>> and why other fses go like that?
>>
> I have examined ext4, XFS, and bcachefs. In these filesystems,
> when performing the following operations:
> ```
>  =C2=A0# mkdir -p a/b
>  =C2=A0# cd a/b
>  =C2=A0# ls -la
>  =C2=A0drwxr-xr-x 2 root root=C2=A0 6 Sep 28 14:45 .
>  =C2=A0drwxr-xr-x 3 root root 15 Sep 28 14:45 ..
> ```
>=20
> In btrfs:
> ```
>  =C2=A0# ls -la
>  =C2=A0drwxr-xr-x 1 root root 0 Sep 28 14:48 .
>  =C2=A0drwxr-xr-x 1 root root 2 Sep 28 14:48 ..
> ```
>=20
> In filesystems like ext4, we can see that the link counts for
> directory 'a' and 'b' are 3 and 2 respectively:
> a: The directory itself + "." pointing to itself + ".." from directory b=
=20
> pointing to it
> b: The directory itself + "." pointing to itself
>=20
>=20
> nlink changes during directory creation in ext4:
> ```
> ext4_mkdir
>  =C2=A0 =C2=A0 ext4_init_new_dir
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_nlink(inode, 2) //Initial inode->i_nlin=
k value for new=20
> directory
>  =C2=A0 =C2=A0 ext4_inc_count(dir) //Increase parent directory's nlink b=
y 1 (for=20
> "..")
> ```
>=20
> In ext4, when the DIR_NLINK feature is enabled, if a directory's link
> count exceeds EXT4_LINK_MAX, it will be permanently set to 1.
>=20
>=20
> nlink changes during directory creation in bcachefs:
> ```
> bch2_mkdir
>  =C2=A0 =C2=A0 bch2_mknod
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 __bch2_create
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bch2_create_trans
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dir_u->bi_nlink=
++ //If creating a directory, increase=20
> parent's nlink
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bch2_inode_update_after_write
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_nlink(&inod=
e->v, bch2_inode_nlink_get(bi))
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b=
ch2_inode_nlink_get //If directory, nlink=20
> increased by 2
> ```
>=20
>=20
> In XFS, the xfs_create function contains the following comment:
> /*
>  =C2=A0* A newly created regular or special file just has one directory
>  =C2=A0* entry pointing to them, but a directory also the "." entry
>  =C2=A0* pointing to itself.
>  =C2=A0*/

You didn't even understand what the nlink represents on these filesystems.

If you even bother to check the code of find, it exactly shows the=20
meaning of nlinks for directory:

gl/lib/fts.c:

```
/* Minimum link count of a traditional Unix directory.  When leaf
    optimization is OK and a directory's st_nlink =3D=3D MIN_DIR_NLINK,
    then the directory has no subdirectories.  */
enum { MIN_DIR_NLINK =3D 2 };

/* Whether leaf optimization is OK for a directory.  */
enum leaf_optimization
   {
     /* st_nlink is not reliable for this directory's subdirectories.  */
     NO_LEAF_OPTIMIZATION,

     /* st_nlink =3D=3D 2 means the directory lacks subdirectories.  */
     OK_LEAF_OPTIMIZATION
   };
```


For filesystems returning nlinks >=3D 2, it means they implemented the=20
optimization to indicate the number of sub-directories of it.

If you didn't even get this correct, all your words are just words=20
salad, no better than AI slops.

>=20
> Thanks,
> Youling.
>=20
>> Especially the impact to user space tools like find?
>>
>>> =C2=A0=C2=A0*
>>> =C2=A0=C2=A0* BTRFS maintains parent-child relationships through expli=
cit back=20
>>> references
>>> =C2=A0=C2=A0* (BTRFS_INODE_REF_KEY items) rather than link count accou=
nting.

This has nothing to do with the nlink implementation of btrfs.

>>> =C2=A0=C2=A0*
>>> =C2=A0=C2=A0* This design simplifies metadata management in the copy-o=
n-write=20
>>> environment
>>> =C2=A0=C2=A0* and enables more reliable consistency checking.

All these make no sense.

>>> Directory link count
>>> =C2=A0=C2=A0* verification is performed during tree checking in=20
>>> check_inode_item(), where
>>> =C2=A0=C2=A0* values greater than 1 are treated as corruption.
>>> =C2=A0=C2=A0*
>>> =C2=A0=C2=A0* For regular files, nlink behaves traditionally and repre=
sents the=20
>>> actual
>>> =C2=A0=C2=A0* hard link count of the file.
>>> =C2=A0=C2=A0*/
>>>
>>> Thanks,
>>> Youling.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le32 nlink;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le32 uid;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le32 gid;
>>>>
>>
>=20


