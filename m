Return-Path: <linux-btrfs+bounces-17242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD45EBA77CB
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 22:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB18A18917F4
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Sep 2025 20:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8028028F948;
	Sun, 28 Sep 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="BnnwPgqt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC169198E91
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Sep 2025 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759092693; cv=none; b=ln/LAjBWMENpliHn9snHSn1AxOALfvWriOjGSzQZr9XgdZvj0i91oMUE76EOr6fpiI2w91TBeyY4r24UrWB5kHqDwT2qdVNqaQ+wqMpql/Bz44LL7sorm3yaFyahKXYWQu2HNYyQAHaIPbAW4DP6X4q0hZ0yK8ooMWGgFqLSeAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759092693; c=relaxed/simple;
	bh=er0r0ZXjOsfx/v8XP6ZsQr6yMH7wVSjrTZjL0q0Do+w=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=I1HE6zh6jMpAV4UM6qcgISXNkrP4hJy30kj9+LXwYp64+5t4FOrJ8XzpRcUfLLAs9Qh4UeLDqMDHDdI1WRjrlYZ+jOFVgvacPyR6Gua6h0EUSXZxVBcS9GBJl1KTQThBNwd8w3VVedfb6EdyagzUs1787HNOK9yOu6Tgcd+oEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=BnnwPgqt; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759092689; x=1759697489; i=quwenruo.btrfs@gmx.com;
	bh=qrY8mMoN+aApNAZqiOfkV68an0+05uZbNIlnwbfniKU=;
	h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
	 Subject:To:Cc:References:From:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BnnwPgqtlWd2YkvtvJX/C/UWvFApBMrOqUMD9jfnx6lkIljHx0Gy3YqkSAhzQMKR
	 Y1tiS/NV4HxMzHILsAuTr+kE/3jO5ltXx+nQMwAgZLb/WZTGFIV5mqjP0CSiepQN5
	 enpftGf45gJ3AAZhihhmgBtAJJhRk8m0rOtKz2YO40aH3iUruCCZPL26j+LRX4jp+
	 O6fSADMCYJC0A6lf6mVZU0qZCZwPGGXZN0w14YbgM0Gzun5yFnQgOSVWFVjofLwkx
	 P9MftXvH5Rt1fcxsq1+gORnmoV9MN9PyjmoGziOP4QbpyKIgF7bDdMM8G1yPdI23z
	 hSFsg8Lnm7vZL9mq/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MI5QF-1v8kzv0ZNP-00EdbV; Sun, 28
 Sep 2025 22:51:28 +0200
Content-Type: multipart/mixed; boundary="------------jXHDz5NzX0hsVbqz7wJjnZ4r"
Message-ID: <c54510bb-601f-4180-bc36-62e494fea9bf@gmx.com>
Date: Mon, 29 Sep 2025 06:21:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: remove btrfs_fs_info::leaf_data_size
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <635a605be3627ff476d47620f195a74fe5d634a2.1758934058.git.wqu@suse.com>
 <CABXGCsObwh8TfAAYhoFSrgKsC4EKdi5tryThQgTgWPG8irwf8A@mail.gmail.com>
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
In-Reply-To: <CABXGCsObwh8TfAAYhoFSrgKsC4EKdi5tryThQgTgWPG8irwf8A@mail.gmail.com>
X-Provags-ID: V03:K1:xau7btal94NMzHgHTZWlwAjb8toj5TzkSggadRPbtuX3buE0fFD
 83sjp7wzVF6nJ64da91Zfu7hCpEIa2ADFvj9oT86n+ivUnPRq44pcXDRhKkWAZFsIbFhj8d
 dx3daPfddob1zLAJ8XoUurr9dLhn9dCtcjIkQnzYqdhoVX4+3ppoCAqAgcv6ikTVldpLxXc
 tHkRfX87+nvFrT8ErZSfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ib7GDtCH8vE=;BP57LXojA0/qgZmplru65ZdX+tJ
 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
 V+k3c24n1FG8OnlDWEzYxPXq7VuBD

This is a multi-part message in MIME format.
--------------jXHDz5NzX0hsVbqz7wJjnZ4r
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2025/9/28 20:43, Mikhail Gavrilov =E5=86=99=E9=81=93:
> On Sat, Sep 27, 2025 at 5:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> There is a bug report that legacy code of "btrfs rescue chunk-recover"
>> is triggering false alerts from tree-checker, and refuse to work:
>>
>>    # btrfs rescue chunk-recover /dev/nvme1n1p1
>>    Scanning: DONE in dev0
>>    corrupt leaf: root=3D1 block=3D13924671995904 slot=3D0, unexpected i=
tem end, have 16283 expect 0 <<< Note the "expect 0"
>>    leaf 13924671995904 items 11 free space 12709 generation 1589644 own=
er ROOT_TREE
>>    leaf 13924671995904 flags 0x1(WRITTEN) backref revision 1
>>    [...]
>>    Couldn't read tree root
>>    open with broken chunk error
>>
>> [CAUSE]
>> The item end checks is from __btrfs_check_leaf() from tree-checker,
>> and for the first slot of a leaf, the expected end should be
>> BTRFS_LEAF_DATA_SIZE(), which is fetched from fs_info->leaf_data_size.
>>
>> However for the fs_info opened by chunk recover, it's not going through
>> the regular open_ctree(), but open_ctree_with_broken_chunk(), which
>> doesn't populate that member and resulting BTRFS_LEAF_DATA_SIZE() to
>> return 0.
>>
>> [FIX]
>> There is no need to cache leaf_data_size, as it can be easily calulated
>> using nodesize.
>>
>> And kernel is already doing that, so follow the kernel to remove
>> btrfs_fs_info::leaf_data_size, and use a simple inline function to do
>> the calculation instead.
>>
>> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>> Link: https://lore.kernel.org/linux-btrfs/CABXGCsOug_bxVZ5CN1EM0sd9U4JA=
z=3DJf5EB2TQe8gs9=3DKZvWEA@mail.gmail.com/
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   kernel-shared/ctree.h   | 8 +++++---
>>   kernel-shared/disk-io.c | 1 -
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
>> index b08e078b5a16..07334208abdf 100644
>> --- a/kernel-shared/ctree.h
>> +++ b/kernel-shared/ctree.h
>> @@ -69,8 +69,6 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize=
)
>>   #define BTRFS_MIN_BLOCKSIZE    (SZ_4K)
>>   #endif
>>
>> -#define BTRFS_LEAF_DATA_SIZE(fs_info) (fs_info->leaf_data_size)
>> -
>>   #define BTRFS_SUPER_INFO_OFFSET                        (65536)
>>   #define BTRFS_SUPER_INFO_SIZE                  (4096)
>>
>> @@ -401,7 +399,6 @@ struct btrfs_fs_info {
>>          u32 nodesize;
>>          u32 sectorsize;
>>          u32 stripesize;
>> -       u32 leaf_data_size;
>>
>>          /*
>>           * For open_ctree_fs_info() to hold the initial fd until close=
.
>> @@ -426,6 +423,11 @@ struct btrfs_fs_info {
>>          struct super_block *sb;
>>   };
>>
>> +static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *fs_=
info)
>> +{
>> +       return __BTRFS_LEAF_DATA_SIZE(fs_info->nodesize);
>> +}
>> +
>>   static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info=
)
>>   {
>>          return fs_info->zoned !=3D 0;
>> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
>> index e8fbc1f986ee..dff800f55a74 100644
>> --- a/kernel-shared/disk-io.c
>> +++ b/kernel-shared/disk-io.c
>> @@ -1604,7 +1604,6 @@ static struct btrfs_fs_info *__open_ctree_fd(int =
fp, struct open_ctree_args *oca
>>          fs_info->stripesize =3D btrfs_super_stripesize(disk_super);
>>          fs_info->csum_type =3D btrfs_super_csum_type(disk_super);
>>          fs_info->csum_size =3D btrfs_super_csum_size(disk_super);
>> -       fs_info->leaf_data_size =3D __BTRFS_LEAF_DATA_SIZE(fs_info->nod=
esize);
>>
>>          ret =3D btrfs_check_fs_compatibility(fs_info->super_copy, flag=
s);
>>          if (ret)
>> --
>> 2.50.1
>>
>=20
> Hi Qu,
>=20
> thanks for working on this. I tried btrfs-progs with your patch
> (=E2=80=9Cremove leaf_data_size and compute from nodesize=E2=80=9D), and=
 btrfs rescue
> chunk-recover now aborts with a BUG_ON.
>=20
> # btrfs rescue chunk-recover /dev/nvme1n1p1
> Scanning: DONE in dev0
> We are going to rebuild the chunk tree on disk, it might destroy the
> old metadata on the disk, Are you sure? [y/N]: y
> corrupt leaf: root=3D3 block=3D22020096 slot=3D0, invalid root, root 3 m=
ust
> never be empty

This is weird, just as the error message shows, chunk tree leaf should=20
never be empty.

Even during mkfs, the initial temporary fs never writes an empty chunk lea=
f.

Mind to dump the super block by:

  # btrfs ins dump-super /dev/nvme1n1p1


But still, this is not a big deal, and you can ignore that.
Tree-checker just rejected such empty leaf, and the chunk-recovery can=20
still continue without extra problems.

> leaf 22020096 items 0 free space 16283 generation 1589645 owner CHUNK_TR=
EE
> leaf 22020096 flags 0x0() backref revision 1
> fs uuid 95e074d1-833a-4d5e-bc62-66897be15556
> chunk uuid deabd921-0650-4625-9707-e363129fb9c1
> cmds/rescue-chunk-recover.c:2409: btrfs_recover_chunk_tree: BUG_ON
> `ret` triggered, value -1

Since this is very old code, it lacks the standard proper error handling=
=20
nor error messages to indicate what went wrong.


Mind to try the attached patch and rerun?

Thanks,
Qu

> btrfs(+0x47ac) [0x55b8046287ac]
> btrfs(btrfs_recover_chunk_tree+0x2439) [0x55b8046e17c9]
> btrfs(+0xb7954) [0x55b8046db954]
> btrfs(main+0x9b) [0x55b80462534b]
> /lib64/libc.so.6(+0x35b5) [0x7f037c5e05b5]
> /lib64/libc.so.6(__libc_start_main+0x88) [0x7f037c5e0668]
> btrfs(_start+0x25) [0x55b804626b95]
> Aborted                    (core dumped) btrfs rescue chunk-recover
> /dev/nvme1n1p1
>=20
>=20
> # gdb btrfs
> GNU gdb (Fedora Linux) 16.3-6.fc44
> Copyright (C) 2024 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.=
html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> Type "show copying" and "show warranty" for details.
> This GDB was configured as "x86_64-redhat-linux-gnu".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <https://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
>      <http://www.gnu.org/software/gdb/documentation/>.
>=20
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from btrfs...
> Reading symbols from /usr/lib/debug/usr/bin/btrfs-6.16.1-2.fc44.x86_64.d=
ebug...
> (gdb) r rescue chunk-recover /dev/nvme1n1p1
> Starting program: /usr/bin/btrfs rescue chunk-recover /dev/nvme1n1p1
>=20
> This GDB supports auto-downloading debuginfo from the following URLs:
>    <ima:enforcing>
>    <https://debuginfod.fedoraproject.org/>
>    <ima:ignore>
> Enable debuginfod for this session? (y or [n]) y
> Debuginfod has been enabled.
> To make this setting permanent, add 'set debuginfod enabled on' to .gdbi=
nit.
> Downloading separate debug info for system-supplied DSO at 0x7ffff7fc300=
0
> Downloading 74.76 K separate debug info for /lib64/libuuid.so.1
> Downloading 243.90 K separate debug info for
> /root/.cache/debuginfod_client/b491e87a2de54e730ca53cc8b40a7ab0553c4140/=
debuginfo
> Downloading 923.54 K separate debug info for /lib64/libblkid.so.1
> Downloading 1.53 M separate debug info for /lib64/libudev.so.1
> Downloading 4.58 M separate debug info for
> /root/.cache/debuginfod_client/53ec97ce69262294cc4162a31ec135e47fca54b1/=
debuginfo
> Downloading 4.05 M separate debug info for /lib64/libgcrypt.so.20
> Downloading 24.23 K separate debug info for
> /root/.cache/debuginfod_client/50638c3c126d99b831e230592e4f362ac70ac716/=
debuginfo
> Downloading 522.10 K separate debug info for /lib64/libz.so.1
> Downloading 76.79 K separate debug info for
> /root/.cache/debuginfod_client/14252b88876df8e502d0576d2933fc3a35eeeb15/=
debuginfo
> Downloading 455.94 K separate debug info for /lib64/liblzo2.so.2
> Downloading 5.75 M separate debug info for /lib64/libzstd.so.1
> Downloading 6.67 M separate debug info for /lib64/libc.so.6
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> Downloading 103.23 K separate debug info for /lib64/libcap.so.2
> Downloading 16.13 K separate debug info for
> /root/.cache/debuginfod_client/40d136ecfe35fe4b9539136c7798905d4513cb94/=
debuginfo
> Downloading 649.02 K separate debug info for /lib64/libgcc_s.so.1
> Downloading 10.25 M separate debug info for
> /root/.cache/debuginfod_client/1f70e857321c645c543ed9dcfaa0268ba6a48c14/=
debuginfo
> Downloading 591.57 K separate debug info for /lib64/libgpg-error.so.0
> Downloading separate debug info for
> /root/.cache/debuginfod_client/6d8969b5fac072c0bf86a70d1ff7bef5e53e2f5c/=
debuginfo
> [New Thread 0x7ffff7a166c0 (LWP 15224)]
> Scanning: 30725970595840 in dev0[Thread 0x7ffff7a166c0 (LWP 15224) exite=
d]
> Scanning: DONE in dev0
> We are going to rebuild the chunk tree on disk, it might destroy the
> old metadata on the disk, Are you sure? [y/N]: y
> corrupt leaf: root=3D3 block=3D22020096 slot=3D0, invalid root, root 3 m=
ust
> never be empty
> leaf 22020096 items 0 free space 16283 generation 1589645 owner CHUNK_TR=
EE
> leaf 22020096 flags 0x0() backref revision 1
> fs uuid 95e074d1-833a-4d5e-bc62-66897be15556
> chunk uuid deabd921-0650-4625-9707-e363129fb9c1
> cmds/rescue-chunk-recover.c:2409: btrfs_recover_chunk_tree: BUG_ON
> `ret` triggered, value -1
> /usr/bin/btrfs(+0x47ac) [0x5555555587ac]
> /usr/bin/btrfs(btrfs_recover_chunk_tree+0x2439) [0x5555556117c9]
> /usr/bin/btrfs(+0xb7954) [0x55555560b954]
> /usr/bin/btrfs(main+0x9b) [0x55555555534b]
> /lib64/libc.so.6(+0x35b5) [0x7ffff7a825b5]
> /lib64/libc.so.6(__libc_start_main+0x88) [0x7ffff7a82668]
> /usr/bin/btrfs(_start+0x25) [0x555555556b95]
>=20
> Thread 1 "btrfs" received signal SIGABRT, Aborted.
> Downloading source file
> /usr/src/debug/glibc-2.42.9000-5.fc44.x86_64/nptl/pthread_kill.c
> __pthread_kill_implementation (threadid=3D<optimized out>,
> signo=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
> 44       return INTERNAL_SYSCALL_ERROR_P (ret) ?
> INTERNAL_SYSCALL_ERRNO (ret) : 0;
> (gdb) bt full
> #0  __pthread_kill_implementation (threadid=3D<optimized out>,
> signo=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
>          tid =3D <optimized out>
>          ret =3D 0
>          pd =3D <optimized out>
>          old_mask =3D {__val =3D {140737488348266}}
>          ret =3D <optimized out>
> #1  0x00007ffff7af3383 in __pthread_kill_internal (threadid=3D<optimized
> out>, signo=3D6) at pthread_kill.c:89
> No locals.
> #2  0x00007ffff7a9918e in __GI_raise (sig=3Dsig@entry=3D6) at
> ../sysdeps/posix/raise.c:26
>          ret =3D <optimized out>
> #3  0x00007ffff7a806d0 in __GI_abort () at abort.c:77
>          act =3D {__sigaction_handler =3D {sa_handler =3D 0x7ffff7c34638=
,
> sa_sigaction =3D 0x7ffff7c34638}, sa_mask =3D {__val =3D {2,
> 140737350157883, 3, 140737488345748, 12, 140737350157887, 2,
> 3834029161070891568,
>                3835204542643123509, 140737488345840,
> 3833184727661539229, 140737488345856, 13820465504488253184,
> 140737488347496, 140737488346608, 93824993610128}}, sa_flags =3D
> 1433035184,
>            sa_restorer =3D 0x55555c1e9230}
> #4  0x00005555555587c4 in bugon_trace.part.0.lto_priv.0.lto_priv.0
> (assertion=3D<optimized out>, filename=3D<optimized out>, func=3D<optimi=
zed
> out>, line=3D<optimized out>, val=3D<optimized out>)
>      at ./include/kerncompat.h:172
> No locals.
> #5  0x00005555556117c9 in bugon_trace (assertion=3D0x55555566df49 "ret",
> filename=3D0x55555566d0f7 "cmds/rescue-chunk-recover.c",
> func=3D0x555555681c60 <__func__.7> "btrfs_recover_chunk_tree",
> line=3D2409,
>      val=3D<optimized out>) at ./include/kerncompat.h:166
> No locals.
> #6  btrfs_recover_chunk_tree (path=3D<optimized out>, yes=3D<optimized
> out>) at cmds/rescue-chunk-recover.c:2409
>          ret =3D <optimized out>
>          root =3D 0x5555556a6670
>          trans =3D 0x55555c1e9230
>          rc =3D {verbose =3D 0, yes =3D 0, csum_size =3D 4, csum_type =
=3D 0,
> sectorsize =3D 4096, nodesize =3D 16384, generation =3D 1589644,
> chunk_root_generation =3D 1588108, fs_devices =3D 0x5555556a4930, chunk =
=3D
> {root =3D {
>                rb_node =3D 0x7ffff0043200}}, bg =3D {tree =3D {root =3D
> {rb_node =3D 0x7ffff04ec660}}, pending_extents =3D {state =3D {rb_node =
=3D
> 0x0}, fs_info =3D 0x0, inode =3D 0x0, owner =3D 0 '\000', lock =3D {lock=
 =3D
> 0}},
>              block_groups =3D {next =3D 0x7fffffffded8, prev =3D
> 0x7fffffffded8}}, devext =3D {tree =3D {root =3D {rb_node =3D
> 0x7ffff16a02a0}}, no_chunk_orphans =3D {next =3D 0x7fffffffdef0, prev =
=3D
> 0x7fffffffdef0},
>              no_device_orphans =3D {next =3D 0x7ffff03d1480, prev =3D
> 0x7fffdaf41f70}}, eb_cache =3D {root =3D {rb_node =3D 0x7ffff2cf2230}},
> good_chunks =3D {next =3D 0x7ffff02e1f50, prev =3D 0x7ffff013b0b0},
> bad_chunks =3D {
>              next =3D 0x7ffff02afcf0, prev =3D 0x7ffff02b0310},
> rebuild_chunks =3D {next =3D 0x7fffffffdf38, prev =3D 0x7fffffffdf38},
> unrepaired_chunks =3D {next =3D 0x7fffffffdf48, prev =3D 0x7fffffffdf48}=
,
> rc_lock =3D {
>              __data =3D {__lock =3D 0, __count =3D 0, __owner =3D 0, __n=
users =3D
> 0, __kind =3D 0, __spins =3D 0, __elision =3D 0, __list =3D {__prev =3D =
0x0,
> __next =3D 0x0}}, __size =3D '\000' <repeats 39 times>, __align =3D 0}}
>          __func__ =3D "btrfs_recover_chunk_tree"
> #7  0x000055555560b954 in cmd_rescue_chunk_recover (cmd=3D0x555555697100
> <cmd_struct_rescue_chunk_recover>, argc=3D<optimized out>,
> argv=3D<optimized out>) at cmds/rescue.c:103
>          ret =3D 0
>          file =3D 0x7fffffffe48e "/dev/nvme1n1p1"
>          yes =3D <optimized out>
> #8  0x000055555555534b in cmd_execute (cmd=3D0x55555569b180
> <cmd_struct_rescue>, argc=3D<optimized out>, argv=3D<optimized out>) at
> cmds/commands.h:126
> No locals.
> #9  main (argc=3D<optimized out>, argv=3D<optimized out>) at
> /usr/src/debug/btrfs-progs-6.16.1-2.fc44.x86_64/btrfs.c:469
>          cmd =3D 0x55555569b180 <cmd_struct_rescue>
>          bname =3D <optimized out>
>          ret =3D <optimized out>
> (gdb)
>=20
>=20
> --
> Best Regards,
> Mike Gavrilov.
>=20

--------------jXHDz5NzX0hsVbqz7wJjnZ4r
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-progs-rescue-chunk-recovery-extra-error-and-de.patch"
Content-Disposition: attachment;
 filename*0="0001-btrfs-progs-rescue-chunk-recovery-extra-error-and-de.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2ZDI0ODM1MzZhZmJjZmFhZWM0YjAyNzQzNTE0OGI3MjUwYTE4ODI5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlEOiA8NmQyNDgzNTM2YWZiY2ZhYWVjNGIwMjc0
MzUxNDhiNzI1MGExODgyOS4xNzU5MDkyNjEyLmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1
IFdlbnJ1byA8d3F1QHN1c2UuY29tPgpEYXRlOiBNb24sIDI5IFNlcCAyMDI1IDA2OjE4OjQ1
ICswOTMwClN1YmplY3Q6IFtQQVRDSF0gYnRyZnMtcHJvZ3M6IHJlc2N1ZS9jaHVuay1yZWNv
dmVyeTogZXh0cmEgZXJyb3IgYW5kIGRlYnVnCiBtZXNzYWdlcwoKSSBiZWxpZXZlIHRoZSBl
cnJvciBpcyB0aGF0IGR1cmluZyByZWJ1aWx0IHdlIGhhdmUgdHdvIGlkZW50aWNhbCBjaHVu
a3MsCm9uZSBmcm9tIHRoZSBleGlzdGluZyBnb29kIG9uZSwgb25lIGZyb20gcmVidWlsdC4K
CkFkZCBzb21lIHByb3BlciBleHRyYSBlcnJvciBtZXNzYWdlcywgYWxvbmcgd2l0aCBhIGRl
YnVnIG9uZSB0byBoZWxwCmRlYnVnLgoKU2lnbmVkLW9mZi1ieTogUXUgV2VucnVvIDx3cXVA
c3VzZS5jb20+Ci0tLQogY21kcy9yZXNjdWUtY2h1bmstcmVjb3Zlci5jIHwgMjcgKysrKysr
KysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9jbWRzL3Jlc2N1ZS1jaHVuay1yZWNv
dmVyLmMgYi9jbWRzL3Jlc2N1ZS1jaHVuay1yZWNvdmVyLmMKaW5kZXggOTg0NmMxNDVmMjQ1
Li43NWJmNTU2MDg5NjYgMTAwNjQ0Ci0tLSBhL2NtZHMvcmVzY3VlLWNodW5rLXJlY292ZXIu
YworKysgYi9jbWRzL3Jlc2N1ZS1jaHVuay1yZWNvdmVyLmMKQEAgLTExOTAsNiArMTE5MCwx
MyBAQCBzdGF0aWMgaW50IF9fcmVidWlsZF9jaHVua19yb290KHN0cnVjdCBidHJmc190cmFu
c19oYW5kbGUgKnRyYW5zLAogCiAJY293ID0gYnRyZnNfYWxsb2NfdHJlZV9ibG9jayh0cmFu
cywgcm9vdCwgMCwgQlRSRlNfQ0hVTktfVFJFRV9PQkpFQ1RJRCwKIAkJCQkgICAgICZkaXNr
X2tleSwgMCwgMCwgMCwgQlRSRlNfTkVTVElOR19OT1JNQUwpOworCWlmIChJU19FUlIoY293
KSkgeworCQlyZXQgPSBQVFJfRVJSKGNvdyk7CisJCWVycm5vID0gLXJldDsKKwkJZXJyb3Io
ImZhaWxlZCB0byBjcmVhdGUgYSBuZXcgdHJlZSBibG9jayBmb3Igcm9vdCAlbGx1OiAlbSIs
CisJCQlCVFJGU19DSFVOS19UUkVFX09CSkVDVElEKTsKKwkJcmV0dXJuIHJldDsKKwl9CiAJ
YnRyZnNfc2V0X2hlYWRlcl9ieXRlbnIoY293LCBjb3ctPnN0YXJ0KTsKIAlidHJmc19zZXRf
aGVhZGVyX2dlbmVyYXRpb24oY293LCB0cmFucy0+dHJhbnNpZCk7CiAJYnRyZnNfc2V0X2hl
YWRlcl9ucml0ZW1zKGNvdywgMCk7CkBAIC0xMjM4LDYgKzEyNDUsMTIgQEAgc3RhdGljIGlu
dCBfX3JlYnVpbGRfZGV2aWNlX2l0ZW1zKHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUgKnRy
YW5zLAogCiAJCXJldCA9IGJ0cmZzX2luc2VydF9pdGVtKHRyYW5zLCByb290LCAma2V5LAog
CQkJCQlkZXZfaXRlbSwgc2l6ZW9mKCpkZXZfaXRlbSkpOworCQlpZiAocmV0IDwgMCkgewor
CQkJZXJybm8gPSAtcmV0OworCQkJZXJyb3IoImZhaWxlZCB0byBpbnNlcnQgZGV2aWNlIGl0
ZW0gZm9yIGRldmlkICVsbHU6ICVtIiwKKwkJCSAgICAgIGRldi0+ZGV2aWQpOworCQkJcmV0
dXJuIHJldDsKKwkJfQogCX0KIAogCXJldHVybiByZXQ7CkBAIC0xMjU4LDkgKzEyNzEsMTUg
QEAgc3RhdGljIGludCBfX2luc2VydF9jaHVua19pdGVtKHN0cnVjdCBidHJmc190cmFuc19o
YW5kbGUgKnRyYW5zLAogCWtleS50eXBlID0gQlRSRlNfQ0hVTktfSVRFTV9LRVk7CiAJa2V5
Lm9mZnNldCA9IGNodW5rX3JlYy0+b2Zmc2V0OwogCisJcHJpbnRmKCJERUJVRzogaW5zZXJ0
aW5nIGNodW5rIGl0ZW0gZm9yIGxvZ2ljYWwgJWxsdVxuIiwgY2h1bmtfcmVjLT5vZmZzZXQp
OwogCXJldCA9IGJ0cmZzX2luc2VydF9pdGVtKHRyYW5zLCBjaHVua19yb290LCAma2V5LCBj
aHVuaywKIAkJCQlidHJmc19jaHVua19pdGVtX3NpemUoY2h1bmtfcmVjLT5udW1fc3RyaXBl
cykpOwogCWZyZWUoY2h1bmspOworCWlmIChyZXQgPCAwKSB7CisJCWVycm5vID0gLXJldDsK
KwkJZXJyb3IoImZhaWxlZCB0byBpbnNlcnQgY2h1bmsgaXRlbSBmb3IgbG9naWNhbCAlbGx1
OiAlbSIsCisJCQljaHVua19yZWMtPm9mZnNldCk7CisJfQogCXJldHVybiByZXQ7CiB9CiAK
QEAgLTEyNzYsMTMgKzEyOTUsMTcgQEAgc3RhdGljIGludCBfX3JlYnVpbGRfY2h1bmtfaXRl
bXMoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsCiAKIAlsaXN0X2Zvcl9lYWNo
X2VudHJ5KGNodW5rX3JlYywgJnJjLT5nb29kX2NodW5rcywgbGlzdCkgewogCQlyZXQgPSBf
X2luc2VydF9jaHVua19pdGVtKHRyYW5zLCBjaHVua19yZWMsIGNodW5rX3Jvb3QpOwotCQlp
ZiAocmV0KQorCQlpZiAocmV0KSB7CisJCQllcnJvcigiZmFpbGVkIHRvIGluc2VydCBjaHVu
ayBpdGVtcyBmb3IgZ29vZCBjaHVua3MiKTsKIAkJCXJldHVybiByZXQ7CisJCX0KIAl9CiAJ
bGlzdF9mb3JfZWFjaF9lbnRyeShjaHVua19yZWMsICZyYy0+cmVidWlsZF9jaHVua3MsIGxp
c3QpIHsKIAkJcmV0ID0gX19pbnNlcnRfY2h1bmtfaXRlbSh0cmFucywgY2h1bmtfcmVjLCBj
aHVua19yb290KTsKLQkJaWYgKHJldCkKKwkJaWYgKHJldCkgeworCQkJZXJyb3IoImZhaWxl
ZCB0byBpbnNlcnQgY2h1bmsgaXRlbXMgZm9yIHJlYnVpbHQgY2h1bmtzIik7CiAJCQlyZXR1
cm4gcmV0OworCQl9CiAJfQogCXJldHVybiAwOwogfQotLSAKMi41MC4xCgo=

--------------jXHDz5NzX0hsVbqz7wJjnZ4r--

