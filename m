Return-Path: <linux-btrfs+bounces-1813-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D18583D05A
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 00:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B051F259C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 23:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764E212B60;
	Thu, 25 Jan 2024 23:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HMqTQ0sH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4AB125BD;
	Thu, 25 Jan 2024 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224003; cv=none; b=afXnG/SZxhbrcSULa3roREk626iXnIucRcC5Y011m62OfOxrvq1VWWIjO8kNTdyfuSr98itxXtrCfiT2LGjPcqXU/Jn706uxRVXSc1JOw2wOYhTYsDTF+OLJVA3roh2BOvz+GluG+L7YsaouKrgqhy2r9dsGOqY29ObgOAD14sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224003; c=relaxed/simple;
	bh=riRnX9JhFPBJnJ//4NYqMHYnf3osPQwHaQwtysR1g1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zrl7phVyWWfvBqYQUmyBXLo1KeKD3sNiELpwGOMCco3oBIwkiJmxpnw7Kr8IsT2oxu5YAsWRfTqq/w8eqQAcKXpdI+aRf4/EyxD90yzHiBFoO6gxHsMlc6W8N99M0gV1D/NtMePH8GEP5JeL5DzYDGqU5MWdAFQ/Hc3nW7DYcEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HMqTQ0sH; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706223992; x=1706828792; i=quwenruo.btrfs@gmx.com;
	bh=riRnX9JhFPBJnJ//4NYqMHYnf3osPQwHaQwtysR1g1I=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=HMqTQ0sHeKkzcI2RA4aMGshPf/9wfVP6AAc5pZd2RNkGaQD5pioAsJqqIfEgej0v
	 RNxvueMwkIO+vKlhEuTIZT2zsg8W7wGNguIuWhicTA1bH6rlvjkiWqdQt3Fcq8X0k
	 QlCgSzNbOaUf3qsirup6sxBDOoicLyk1G7NNC2cdTfkAlVgK4ETr6RWYq1xgG5NeF
	 0BIf8wEJe5a52iNMEcVTqK9OAJOeBTRJnr2JaMkdChm0MpQIb83MZ7KY7HJaRExQm
	 QVMDkPIbYbF/xJT67EIr9KpgioEJI8j50bVdYf7ss2bI9/Y9Fs0x53w8EKmIihqOY
	 hfIJzK+H4a+T37bzBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4QsY-1r33h30INC-011PLx; Fri, 26
 Jan 2024 00:06:31 +0100
Message-ID: <d52c41e0-1f82-4936-bfd4-e6e989560edf@gmx.com>
Date: Fri, 26 Jan 2024 09:36:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix infinite directory reads
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, erosca@de.adit-jv.com,
 Filipe Manana <fdmanana@suse.com>, Rob Landley <rob@landley.net>,
 stable@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <1ae6e30a71112e07c727f9e93ff32032051bbce7.1706176168.git.wqu@suse.com>
 <CAL3q7H77i3kv7C352k2R6nr-m-cgh_cdCCeTkXna+v1yjpMuoA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H77i3kv7C352k2R6nr-m-cgh_cdCCeTkXna+v1yjpMuoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xar7NUNckt0zS12hjJhq+Dgf+6sHKTagbxq2i1yWYeLNDZqTnwl
 DRMkpkWh0UIT9t9LvFDCDLp+L00O+JYGpT1dj9bxF5p63u8yofPhUfU8EsYMsnoEYThoVAD
 e2+7t0TH4y46pRFEBHDu4h8moy9njfgqIbVGq6aAznkW5NqyjS+gTumM/QZ/5a0PxyRBKIQ
 JtaAlOhgsLjAZCmdlnwMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KCKE/8ys1sA=;ap9I1rW+THQXCgzhejNoT4hjLjP
 RFx12ydToxEkvOaNzpnugd4/4fHwUYt4ERCobTcANpSlFmxyxWVWuB9wSG7v+bQEQm/0T5WYM
 9IuDWJvQBerKrBKcp8mdrpazn7cs4A/9bj2aeM2rJiTs9Vpi1eyHsDFQpQ0gXpxAbNLp5Gnrt
 qnZZ9l5VRnqFN7tPintTXKNKc/47MEF0Oy+voQQn36aiD6hneF8s9zSbM1v+DktC9KeX1n6Ww
 i2fK5fmvjJUunjyKA5UAIw31qD3zk1ZzE3bvSbXQ27zLiu6a6XAhdIXohnxAune9nxVcHQgrL
 NEtOd26jwS/Yc8qBKKLojGue7XNpMwHABDCs+/H3xbBLIzWnIbLxXGe6Ia1VNp8KkkTzRHAz3
 0cDLoKtECS67y0T3kJoFf6GHIIzKNINJweVJgw7Q61FV3JqadgPw7fuuAVz5XsdOBNwbVcddg
 piyguZF+rU7hU+giDEWkL10cOmOlsGKo2+iFRWmSgc7FR0+wf/XipmNK/uysB0zTltImEX90e
 s5GzLjmYOCk6wSX5BwxDYrXXz2BvIwyNcTFcZ03ev3hXqUxC5IHFnA0MuqEkoXOYLsLe69CDi
 IavSZMOhRqxb4HNGp7q1KXrJg2r0WKHYRONBgrJF41eiafXsHPC4SqMuvaKC2i1lp+EhxoaDE
 KbkAeqhSd+6tRb2Om0eMWBIK4nDmG9QGHrINofZp+1m8XFjTC8EVrT8tJooGlxb6YBOU5Os5i
 BBbZxIDPhvQOvahC9ittR36i6/cqwWa6tFTRvEd0YWjOgZDQ5KGcyPWTj9iD6v2VfRoLcFJDh
 i/2BbSRvF03MsMTB/MqsJiv/MBC39Ps/4xIZgAk5UoxMs6EkEQv09dbNv6v/SrqPvyFPAP4ad
 32n/7aN8KWccEtLieJaQKKeRSUZYf1KLv7fzISVOHQNAnYCbQteNmRS1nXFozZZ3udJV4oTy6
 JqhRVuoCd0zZO/nEFBKSzVfmbKw=



On 2024/1/25 20:32, Filipe Manana wrote:
> On Thu, Jan 25, 2024 at 9:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> [ Upstream commit 9b378f6ad48cfa195ed868db9123c09ee7ec5ea2 ]
>>
>> The readdir implementation currently processes always up to the last in=
dex
>> it finds. This however can result in an infinite loop if the directory =
has
>> a large number of entries such that they won't all fit in the given buf=
fer
>> passed to the readdir callback, that is, dir_emit() returns a non-zero
>> value. Because in that case readdir() will be called again and if in th=
e
>> meanwhile new directory entries were added and we still can't put all t=
he
>> remaining entries in the buffer, we keep repeating this over and over.
>>
>> The following C program and test script reproduce the problem:
>>
>>    $ cat /mnt/readdir_prog.c
>>    #include <sys/types.h>
>>    #include <dirent.h>
>>    #include <stdio.h>
>>
>>    int main(int argc, char *argv[])
>>    {
>>      DIR *dir =3D opendir(".");
>>      struct dirent *dd;
>>
>>      while ((dd =3D readdir(dir))) {
>>        printf("%s\n", dd->d_name);
>>        rename(dd->d_name, "TEMPFILE");
>>        rename("TEMPFILE", dd->d_name);
>>      }
>>      closedir(dir);
>>    }
>>
>>    $ gcc -o /mnt/readdir_prog /mnt/readdir_prog.c
>>
>>    $ cat test.sh
>>    #!/bin/bash
>>
>>    DEV=3D/dev/sdi
>>    MNT=3D/mnt/sdi
>>
>>    mkfs.btrfs -f $DEV &> /dev/null
>>    #mkfs.xfs -f $DEV &> /dev/null
>>    #mkfs.ext4 -F $DEV &> /dev/null
>>
>>    mount $DEV $MNT
>>
>>    mkdir $MNT/testdir
>>    for ((i =3D 1; i <=3D 2000; i++)); do
>>        echo -n > $MNT/testdir/file_$i
>>    done
>>
>>    cd $MNT/testdir
>>    /mnt/readdir_prog
>>
>>    cd /mnt
>>
>>    umount $MNT
>>
>> This behaviour is surprising to applications and it's unlike ext4, xfs,
>> tmpfs, vfat and other filesystems, which always finish. In this case wh=
ere
>> new entries were added due to renames, some file names may be reported
>> more than once, but this varies according to each filesystem - for exam=
ple
>> ext4 never reported the same file more than once while xfs reports the
>> first 13 file names twice.
>>
>> So change our readdir implementation to track the last index number whe=
n
>> opendir() is called and then make readdir() never process beyond that
>> index number. This gives the same behaviour as ext4.
>>
>> Reported-by: Rob Landley <rob@landley.net>
>> Link: https://lore.kernel.org/linux-btrfs/2c8c55ec-04c6-e0dc-9c5c-8c792=
4778c35@landley.net/
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217681
>> CC: stable@vger.kernel.org # 5.15
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> [ Resolve a conflict due to member changes in 96d89923fa94 ]
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>
> Thanks for the backport, and running the corresponding test case from
> fstests to verify it's working.
>
> However when backporting a commit, one should also check if there are
> fixes for that commit, as they
> often introduce regressions or have some other bug - and that's the
> case here. We also need to backport
> the following 3 commits:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D357950361cbc6d54fb68ed878265c647384684ae
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3De60aa5da14d01fed8411202dbe4adf6c44bd2a57
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D8e7f82deb0c0386a03b62e30082574347f8b57d5
>
> One regression, the one regarding rewinddir(3), even has a test case
> in fstests too (generic/471) and would have been caught
> when running the "dir" group tests in fstests:

My bad, I get used to be informed by our internal building system about
missing fixes.

And obviously there is no such automatic systems checking missing fixes
here...
>
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3Dfor-n=
ext&id=3D68b958f5dc4ab13cfd86f7fb82621f9f022b7626
>
> I'll work on making backports of those 3 other patches on top of your
> backport, and then send all of them in a series,
> including your patch, to make it easier to follow and apply all at once.

Thanks a lot, that's much appreciated.

Thanks,
Qu
>
> Thanks.
>
>
>>   fs/btrfs/ctree.h         |   1 +
>>   fs/btrfs/delayed-inode.c |   5 +-
>>   fs/btrfs/delayed-inode.h |   1 +
>>   fs/btrfs/inode.c         | 131 +++++++++++++++++++++++---------------=
-
>>   4 files changed, 84 insertions(+), 54 deletions(-)
>> ---
>> Changelog:
>> v2:
>> - Fix the upstream commit hash
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 1467bf439cb4..7905f178efa3 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -1361,6 +1361,7 @@ struct btrfs_drop_extents_args {
>>
>>   struct btrfs_file_private {
>>          void *filldir_buf;
>> +       u64 last_index;
>>   };
>>
>>
>> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
>> index fd951aeaeac5..5a98c5da1225 100644
>> --- a/fs/btrfs/delayed-inode.c
>> +++ b/fs/btrfs/delayed-inode.c
>> @@ -1513,6 +1513,7 @@ int btrfs_inode_delayed_dir_index_count(struct bt=
rfs_inode *inode)
>>   }
>>
>>   bool btrfs_readdir_get_delayed_items(struct inode *inode,
>> +                                    u64 last_index,
>>                                       struct list_head *ins_list,
>>                                       struct list_head *del_list)
>>   {
>> @@ -1532,14 +1533,14 @@ bool btrfs_readdir_get_delayed_items(struct ino=
de *inode,
>>
>>          mutex_lock(&delayed_node->mutex);
>>          item =3D __btrfs_first_delayed_insertion_item(delayed_node);
>> -       while (item) {
>> +       while (item && item->key.offset <=3D last_index) {
>>                  refcount_inc(&item->refs);
>>                  list_add_tail(&item->readdir_list, ins_list);
>>                  item =3D __btrfs_next_delayed_item(item);
>>          }
>>
>>          item =3D __btrfs_first_delayed_deletion_item(delayed_node);
>> -       while (item) {
>> +       while (item && item->key.offset <=3D last_index) {
>>                  refcount_inc(&item->refs);
>>                  list_add_tail(&item->readdir_list, del_list);
>>                  item =3D __btrfs_next_delayed_item(item);
>> diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
>> index b2412160c5bc..a9cfce856d2e 100644
>> --- a/fs/btrfs/delayed-inode.h
>> +++ b/fs/btrfs/delayed-inode.h
>> @@ -123,6 +123,7 @@ void btrfs_destroy_delayed_inodes(struct btrfs_fs_i=
nfo *fs_info);
>>
>>   /* Used for readdir() */
>>   bool btrfs_readdir_get_delayed_items(struct inode *inode,
>> +                                    u64 last_index,
>>                                       struct list_head *ins_list,
>>                                       struct list_head *del_list);
>>   void btrfs_readdir_put_delayed_items(struct inode *inode,
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 95af29634e55..1df374ce829b 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -6121,6 +6121,74 @@ static struct dentry *btrfs_lookup(struct inode =
*dir, struct dentry *dentry,
>>          return d_splice_alias(inode, dentry);
>>   }
>>
>> +/*
>> + * Find the highest existing sequence number in a directory and then s=
et the
>> + * in-memory index_cnt variable to the first free sequence number.
>> + */
>> +static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
>> +{
>> +       struct btrfs_root *root =3D inode->root;
>> +       struct btrfs_key key, found_key;
>> +       struct btrfs_path *path;
>> +       struct extent_buffer *leaf;
>> +       int ret;
>> +
>> +       key.objectid =3D btrfs_ino(inode);
>> +       key.type =3D BTRFS_DIR_INDEX_KEY;
>> +       key.offset =3D (u64)-1;
>> +
>> +       path =3D btrfs_alloc_path();
>> +       if (!path)
>> +               return -ENOMEM;
>> +
>> +       ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
>> +       if (ret < 0)
>> +               goto out;
>> +       /* FIXME: we should be able to handle this */
>> +       if (ret =3D=3D 0)
>> +               goto out;
>> +       ret =3D 0;
>> +
>> +       if (path->slots[0] =3D=3D 0) {
>> +               inode->index_cnt =3D BTRFS_DIR_START_INDEX;
>> +               goto out;
>> +       }
>> +
>> +       path->slots[0]--;
>> +
>> +       leaf =3D path->nodes[0];
>> +       btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>> +
>> +       if (found_key.objectid !=3D btrfs_ino(inode) ||
>> +           found_key.type !=3D BTRFS_DIR_INDEX_KEY) {
>> +               inode->index_cnt =3D BTRFS_DIR_START_INDEX;
>> +               goto out;
>> +       }
>> +
>> +       inode->index_cnt =3D found_key.offset + 1;
>> +out:
>> +       btrfs_free_path(path);
>> +       return ret;
>> +}
>> +
>> +static int btrfs_get_dir_last_index(struct btrfs_inode *dir, u64 *inde=
x)
>> +{
>> +       if (dir->index_cnt =3D=3D (u64)-1) {
>> +               int ret;
>> +
>> +               ret =3D btrfs_inode_delayed_dir_index_count(dir);
>> +               if (ret) {
>> +                       ret =3D btrfs_set_inode_index_count(dir);
>> +                       if (ret)
>> +                               return ret;
>> +               }
>> +       }
>> +
>> +       *index =3D dir->index_cnt;
>> +
>> +       return 0;
>> +}
>> +
>>   /*
>>    * All this infrastructure exists because dir_emit can fault, and we =
are holding
>>    * the tree lock when doing readdir.  For now just allocate a buffer =
and copy
>> @@ -6133,10 +6201,17 @@ static struct dentry *btrfs_lookup(struct inode=
 *dir, struct dentry *dentry,
>>   static int btrfs_opendir(struct inode *inode, struct file *file)
>>   {
>>          struct btrfs_file_private *private;
>> +       u64 last_index;
>> +       int ret;
>> +
>> +       ret =3D btrfs_get_dir_last_index(BTRFS_I(inode), &last_index);
>> +       if (ret)
>> +               return ret;
>>
>>          private =3D kzalloc(sizeof(struct btrfs_file_private), GFP_KER=
NEL);
>>          if (!private)
>>                  return -ENOMEM;
>> +       private->last_index =3D last_index;
>>          private->filldir_buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
>>          if (!private->filldir_buf) {
>>                  kfree(private);
>> @@ -6205,7 +6280,8 @@ static int btrfs_real_readdir(struct file *file, =
struct dir_context *ctx)
>>
>>          INIT_LIST_HEAD(&ins_list);
>>          INIT_LIST_HEAD(&del_list);
>> -       put =3D btrfs_readdir_get_delayed_items(inode, &ins_list, &del_=
list);
>> +       put =3D btrfs_readdir_get_delayed_items(inode, private->last_in=
dex,
>> +                                             &ins_list, &del_list);
>>
>>   again:
>>          key.type =3D BTRFS_DIR_INDEX_KEY;
>> @@ -6238,6 +6314,8 @@ static int btrfs_real_readdir(struct file *file, =
struct dir_context *ctx)
>>                          break;
>>                  if (found_key.offset < ctx->pos)
>>                          goto next;
>> +               if (found_key.offset > private->last_index)
>> +                       break;
>>                  if (btrfs_should_delete_dir_index(&del_list, found_key=
.offset))
>>                          goto next;
>>                  di =3D btrfs_item_ptr(leaf, slot, struct btrfs_dir_ite=
m);
>> @@ -6371,57 +6449,6 @@ static int btrfs_update_time(struct inode *inode=
, struct timespec64 *now,
>>          return dirty ? btrfs_dirty_inode(inode) : 0;
>>   }
>>
>> -/*
>> - * find the highest existing sequence number in a directory
>> - * and then set the in-memory index_cnt variable to reflect
>> - * free sequence numbers
>> - */
>> -static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
>> -{
>> -       struct btrfs_root *root =3D inode->root;
>> -       struct btrfs_key key, found_key;
>> -       struct btrfs_path *path;
>> -       struct extent_buffer *leaf;
>> -       int ret;
>> -
>> -       key.objectid =3D btrfs_ino(inode);
>> -       key.type =3D BTRFS_DIR_INDEX_KEY;
>> -       key.offset =3D (u64)-1;
>> -
>> -       path =3D btrfs_alloc_path();
>> -       if (!path)
>> -               return -ENOMEM;
>> -
>> -       ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
>> -       if (ret < 0)
>> -               goto out;
>> -       /* FIXME: we should be able to handle this */
>> -       if (ret =3D=3D 0)
>> -               goto out;
>> -       ret =3D 0;
>> -
>> -       if (path->slots[0] =3D=3D 0) {
>> -               inode->index_cnt =3D BTRFS_DIR_START_INDEX;
>> -               goto out;
>> -       }
>> -
>> -       path->slots[0]--;
>> -
>> -       leaf =3D path->nodes[0];
>> -       btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>> -
>> -       if (found_key.objectid !=3D btrfs_ino(inode) ||
>> -           found_key.type !=3D BTRFS_DIR_INDEX_KEY) {
>> -               inode->index_cnt =3D BTRFS_DIR_START_INDEX;
>> -               goto out;
>> -       }
>> -
>> -       inode->index_cnt =3D found_key.offset + 1;
>> -out:
>> -       btrfs_free_path(path);
>> -       return ret;
>> -}
>> -
>>   /*
>>    * helper to find a free sequence number in a given directory.  This =
current
>>    * code is very simple, later versions will do smarter things in the =
btree
>> --
>> 2.43.0
>>
>>
>

