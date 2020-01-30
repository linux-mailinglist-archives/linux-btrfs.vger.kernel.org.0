Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7A14D91F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 11:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgA3Kgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 05:36:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:54983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgA3Kgs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 05:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580380595;
        bh=p+0ruuqsNSkzQMCJhBasyKVjSaJEEgu82FThEy4AfNA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VPoJ33S0Vfhqgf3K7tx2RpBQ+z4Ntx2X60yG2u7Tlv7myRT113fFHZDzPTgtRCp0C
         KHOnpfOZgjZg+YsDvbA8ZcHaOJl+cXzNS1ZhlEKejmyiKG9fQx9xsvsEtvSNkxyCYo
         SQ+v/TmcHfAMV0X5OSUXXvMIcQ06Inq34qLJvyHY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McpNo-1jVcvL1l7S-00ZvUz; Thu, 30
 Jan 2020 11:36:34 +0100
Subject: Re: [PATCH] btrfs: Allow btrfs_truncate_block() to fallback to nocow
 for data space reservation
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Martin Doucha <martin.doucha@suse.com>,
        Anand Jain <anand.jain@oracle.com>
References: <20200130052822.11765-1-wqu@suse.com>
 <CAL3q7H4ODcwn7LVm=P3BBL7zd3wGRB_Vtr_KNk_2MysNNwgqcQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <8341b76f-bcbe-f2b9-d8b0-cfcd0006a47c@gmx.com>
Date:   Thu, 30 Jan 2020 18:36:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4ODcwn7LVm=P3BBL7zd3wGRB_Vtr_KNk_2MysNNwgqcQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YFBI5Zb8nnF1ULXDE8727RIgmB2lYqcUM"
X-Provags-ID: V03:K1:RTD/o9kuWJ+Dpif8jtu5x/RF972prXVjoATyZxrcouqsPbjO//n
 c689qfi5lCN0ye6CWoDeH5/YNl/FdFHRdml5a33loTkZU8esVZ19Ndt43Tn4FQGi0hdFMGH
 SPxEeNYbtErcVrNHEN6bSK/S5qSyLZXu6ORhOXwNsTGF9QypA1fvRVB8AYtdUEd72FeZuBe
 mxaq2nZW2q4Rb5NT5z4iQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h2ePyScS0qU=:hILgv87X9I8OGc/ArvyF8s
 yQHxRlSBk9zKcKNm+plYjE59UxQiJV3KyP4MpsYtQ1Y/kjnqzPbyi9Z/rJ2Yhjato1GntJdys
 5i03iD4q4KMnhewokgZnjJXWY62913Qv3CHC28yzlTPq3UeHFXkQQEkXd0Ywtb4eWQ0/g7rzy
 uzP3vSJxDjV5OerxA6Ox8IpKq/9gZt5Xjnts8qFWBerBKMddL2GdWKqmA3tm4v1iIn84JGkbz
 99bBCxRKhFy6EzHNieIU9WJgBfUkASYe782Y96ADolyM4KsUKleaGjjbI1De928WP+IgbL91W
 PFmQkPRxoaoWjtc0cED+NyNx09zk0Odeyjtlj26HFscj7xXcDgJnESNpdV1t91J/BMIM/wBQ4
 EXBBhZgNVDYGa7V15n/vqWJD2P42c/FKcUHAMNYir3OBGa8ok4ljH/8GL3FyTJRWYeDIqNgha
 T2Z2ZaicEz2b8kJ/+j/6s3Y21PBW0Xd1Y5h2yZPsMP2oasYAdcrgRM/VQu9+5CtN4YmGitBBx
 kx3xZo2SRLogqyVgs4VXQKMflGBCX9w45A09ILBu/YHhCWDQrAGZHRkavPxG6krB8RTnpNyN6
 s6uwkYNInqLay1bFLyadrooEgYlmqus5GnvTe+O/VaMzbuXcAIXyoiMRQUz3d7Ea3bYn8bIA4
 AvhAAqeGpAu+fzlkthOtMPKdMCcg0xsQw9ILcs+K9TbdXPckxH2HJk2pGwZlS19wEK2ShaWux
 KKQNIXixz95BTFpQoij8qc8QH7E1+6z1x1vTeSP1OtW+yuG+t7rKJsUFiepcfbAWcguwYWkvK
 OxMbI5Rb9IbjlzR66KZNSOfirrORK8yFCzt+UTiVVEcmb0Ow/2uSfW6O5JRWab9FdndcwUq5U
 tiJOle2BeSk/Tj3yxLV95o8IWN67+0PYUpjdXeDLB/Gt6+uiatXHVYJ6rDJw3i3kOZPm9tBNA
 KUdcnd+GimB9bB3ubxpbCc+So03bnFwgNekcGlYNLR4yF7XHp4/ebw2uZ79NbXmdG2ghpxgof
 tZ5tFQYzs5aiEDLsOE+icWNXiPTPhnP/JNqMM5o8z2Vg3mh8cQenb0jxfokFC0XnxKSW+uq4b
 YjcODx+7/BdU9D4IsADQxAd093o0/Il4wgmjuM9wimyn3S00JMFErLM/AMCRH5GgtEIPUdKSw
 P5QAhUcZeJBrNVWoqDsQ2OTXbJNNvI1yO0WisCqiBVZDyNgFv/s+UBZPA3qfiFHXdc+J/33GV
 ZJ/JXWfmHAQQiG6cA
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YFBI5Zb8nnF1ULXDE8727RIgmB2lYqcUM
Content-Type: multipart/mixed; boundary="pZ5zqempqwBU8tfid6Hku2PMedmFRgxCW"

--pZ5zqempqwBU8tfid6Hku2PMedmFRgxCW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/30 =E4=B8=8B=E5=8D=886:02, Filipe Manana wrote:
> On Thu, Jan 30, 2020 at 5:30 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> When the data space is exhausted, even the inode has NOCOW attribute,
>> btrfs will still refuse to truncate unaligned range due to ENOSPC.
>>
>> The following script can reproduce it pretty easily:
>>   #!/bin/bash
>>
>>   dev=3D/dev/test/test
>>   mnt=3D/mnt/btrfs
>>
>>   umount $dev &> /dev/null
>>   umount $mnt&> /dev/null
>>
>>   mkfs.btrfs -f $dev -b 1G
>>   mount -o nospace_cache $dev $mnt
>>   touch $mnt/foobar
>>   chattr +C $mnt/foobar
>>
>>   xfs_io -f -c "pwrite -b 4k 0 4k" $mnt/foobar > /dev/null
>>   xfs_io -f -c "pwrite -b 4k 0 1G" $mnt/padding &> /dev/null
>>   sync
>>
>>   xfs_io -c "fpunch 0 2k" $mnt/foobar
>>   umount $mnt
>>
>> Current btrfs will fail at the fpunch part.
>>
>> [CAUSE]
>> Because btrfs_truncate_block() always reserve space without checking t=
he
>> NOCOW attribute.
>>
>> Since the writeback path follows NOCOW bit, we only need to bother the=

>> space reservation code in btrfs_truncate_block().
>>
>> [FIX]
>> Make btrfs_truncate_block() to follow btrfs_buffered_write() to try to=

>> reserve data space first, and falls back to NOCOW check only when we
>> don't have enough space.
>>
>> Such always-try-reserve is an optimization introduced in
>> btrfs_buffered_write(), to avoid expensive btrfs_check_can_nocow() cal=
l.
>>
>> Since now check_can_nocow() is needed outside of inode.c, also export =
it
>> and rename it to btrfs_check_can_nocow().
>>
>> Reported-by: Martin Doucha <martin.doucha@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Test case will be submitted to fstests by the reporter.
>=20
> Well, this is a sudden change of mind, isn't it? :)
>=20
> We had btrfs/172, which you removed very recently, that precisely teste=
d this:
>=20
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=3D538=
d8a4bcc782258f8f95fae815d5e859dee9126

I didn't notice the nodatacow mount option. Super duper big facepalm.

All my bad, especially feel sorry for Anand.

With nodatacow mount option there, that test case in fact makes a lot of
sense.
Sorry again for that.

Anand, mind to resubmit it to generic group?

Thanks,
Qu

>=20
> Even though there are several reasons why this can still fail (at
> writeback time), like regular buffered writes through the family of
> write() syscalls can, I think it's perfectly fine to have this
> behaviour.
>=20
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>=20
> So I think we can just resurrect btrfs/172 now...
>=20
>> ---
>>  fs/btrfs/ctree.h |  2 ++
>>  fs/btrfs/file.c  | 10 +++++-----
>>  fs/btrfs/inode.c | 41 ++++++++++++++++++++++++++++++++++-------
>>  3 files changed, 41 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 54efb21c2727..b5639f3461e4 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -2954,6 +2954,8 @@ int btrfs_fdatawrite_range(struct inode *inode, =
loff_t start, loff_t end);
>>  loff_t btrfs_remap_file_range(struct file *file_in, loff_t pos_in,
>>                               struct file *file_out, loff_t pos_out,
>>                               loff_t len, unsigned int remap_flags);
>> +int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
>> +                         size_t *write_bytes);
>>
>>  /* tree-defrag.c */
>>  int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index 8d47c76b7bd1..8dc084600f4e 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -1544,8 +1544,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_ino=
de *inode, struct page **pages,
>>         return ret;
>>  }
>>
>> -static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t=
 pos,
>> -                                   size_t *write_bytes)
>> +int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
>> +                         size_t *write_bytes)
>>  {
>>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>         struct btrfs_root *root =3D inode->root;
>> @@ -1645,8 +1645,8 @@ static noinline ssize_t btrfs_buffered_write(str=
uct kiocb *iocb,
>>                 if (ret < 0) {
>>                         if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODA=
TACOW |
>>                                                       BTRFS_INODE_PREA=
LLOC)) &&
>> -                           check_can_nocow(BTRFS_I(inode), pos,
>> -                                       &write_bytes) > 0) {
>> +                           btrfs_check_can_nocow(BTRFS_I(inode), pos,=

>> +                                                 &write_bytes) > 0) {=

>>                                 /*
>>                                  * For nodata cow case, no need to res=
erve
>>                                  * data space.
>> @@ -1923,7 +1923,7 @@ static ssize_t btrfs_file_write_iter(struct kioc=
b *iocb,
>>                  */
>>                 if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |=

>>                                               BTRFS_INODE_PREALLOC)) |=
|
>> -                   check_can_nocow(BTRFS_I(inode), pos, &count) <=3D =
0) {
>> +                   btrfs_check_can_nocow(BTRFS_I(inode), pos, &count)=
 <=3D 0) {
>>                         inode_unlock(inode);
>>                         return -EAGAIN;
>>                 }
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 5509c41a4f43..b5ae4bbf1ad4 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -4974,11 +4974,13 @@ int btrfs_truncate_block(struct inode *inode, =
loff_t from, loff_t len,
>>         struct extent_state *cached_state =3D NULL;
>>         struct extent_changeset *data_reserved =3D NULL;
>>         char *kaddr;
>> +       bool only_release_metadata =3D false;
>>         u32 blocksize =3D fs_info->sectorsize;
>>         pgoff_t index =3D from >> PAGE_SHIFT;
>>         unsigned offset =3D from & (blocksize - 1);
>>         struct page *page;
>>         gfp_t mask =3D btrfs_alloc_write_mask(mapping);
>> +       size_t write_bytes =3D blocksize;
>>         int ret =3D 0;
>>         u64 block_start;
>>         u64 block_end;
>> @@ -4990,11 +4992,26 @@ int btrfs_truncate_block(struct inode *inode, =
loff_t from, loff_t len,
>>         block_start =3D round_down(from, blocksize);
>>         block_end =3D block_start + blocksize - 1;
>>
>> -       ret =3D btrfs_delalloc_reserve_space(inode, &data_reserved,
>> -                                          block_start, blocksize);
>> -       if (ret)
>> +       ret =3D btrfs_check_data_free_space(inode, &data_reserved, blo=
ck_start,
>> +                                         blocksize);
>> +       if (ret < 0) {
>> +               if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
>> +                                             BTRFS_INODE_PREALLOC)) &=
&
>> +                   btrfs_check_can_nocow(BTRFS_I(inode), block_start,=

>> +                                         &write_bytes) > 0) {
>> +                       /* For nocow case, no need to reserve data spa=
ce. */
>> +                       only_release_metadata =3D true;
>> +               } else {
>> +                       goto out;
>> +               }
>> +       }
>> +       ret =3D btrfs_delalloc_reserve_metadata(BTRFS_I(inode), blocks=
ize);
>> +       if (ret < 0) {
>> +               if (!only_release_metadata)
>> +                       btrfs_free_reserved_data_space(inode, data_res=
erved,
>> +                                       block_start, blocksize);
>>                 goto out;
>> -
>> +       }
>>  again:
>>         page =3D find_or_create_page(mapping, index, mask);
>>         if (!page) {
>> @@ -5063,10 +5080,20 @@ int btrfs_truncate_block(struct inode *inode, =
loff_t from, loff_t len,
>>         set_page_dirty(page);
>>         unlock_extent_cached(io_tree, block_start, block_end, &cached_=
state);
>>
>> +       if (only_release_metadata)
>> +               set_extent_bit(&BTRFS_I(inode)->io_tree, block_start,
>> +                               block_end, EXTENT_NORESERVE, NULL, NUL=
L,
>> +                               GFP_NOFS);
>> +
>>  out_unlock:
>> -       if (ret)
>> -               btrfs_delalloc_release_space(inode, data_reserved, blo=
ck_start,
>> -                                            blocksize, true);
>> +       if (ret) {
>> +               if (!only_release_metadata)
>> +                       btrfs_delalloc_release_space(inode, data_reser=
ved,
>> +                                       block_start, blocksize, true);=

>> +               else
>> +                       btrfs_delalloc_release_metadata(BTRFS_I(inode)=
,
>> +                                       blocksize, true);
>=20
> I usually find it more intuitive to have it the other way around:
>=20
> if (only_release_metadata)
>   ...
> else
>   ...
>=20
> E.g., positive case first, negative in the else branch. But that's
> likely too much of a personal preference.
>=20
> Thanks.
>=20
>> +       }
>>         btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize);
>>         unlock_page(page);
>>         put_page(page);
>> --
>> 2.25.0
>>
>=20
>=20


--pZ5zqempqwBU8tfid6Hku2PMedmFRgxCW--

--YFBI5Zb8nnF1ULXDE8727RIgmB2lYqcUM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4ysawACgkQwj2R86El
/qhq/Qf/dneY5q7+DmR3Jw2V0QcGqP5l/fgNvFtDI0Yj75XCAuM1Wyfvk6DUnBIH
yEfByTcKsyKYDHXrBZLM2ZnmjiMqpqaMhrSsdyKlpeQfclJs7pLVYhWt+GjVyRRx
/1ciZqDDIw8dHu8glhTVS31H5F2q/vIJ4Bz9RXRlAP/1gqzY6gH/R5ibnYsO10Bk
YJ4uYj/KffLafLChaC9b3KmDB/8ncP9LRhIKOkeIw0dXaC4fE/xvuBZCzzoKs+lZ
N2znHovWGpLb74BiXu3OjmngPSQhvoTraZQ10iSYuIiygco6d/HPwhUSsJvqUDs8
m6dXa1c9pxpPx4rUrjvizdLmpK6ijQ==
=pKcL
-----END PGP SIGNATURE-----

--YFBI5Zb8nnF1ULXDE8727RIgmB2lYqcUM--
