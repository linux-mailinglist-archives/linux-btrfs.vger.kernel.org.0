Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D51E1DA4C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 06:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407766AbfJQEeC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 00:34:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:43647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404613AbfJQEeC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 00:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571286821;
        bh=x7UJHrUVGzds+DcBnLlo9oD6Ax70RpNY2Gqo6vaEaC0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=K3YV/VGBz3IfKjaqW0FmqfenQWqAq1kOD7Rj4oRa5LHSnMeSzqlMO3E/eT8LlIign
         seG2E3LZXlbX10sxb7IyUybegu/xMvECAsMKt7pE+62HdI8LgyBy5bRc3uIXUko3MX
         3/ksxiGwq6JEjyFCqWokv5y2+uIiSxABAuAZu8kg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wPb-1iQjqZ3Oqx-007WWJ; Thu, 17
 Oct 2019 06:33:41 +0200
Subject: Re: [PATCH v2 2/7] btrfs-progs: Refactor btrfs_read_block_groups()
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191008044936.157873-1-wqu@suse.com>
 <20191008044936.157873-3-wqu@suse.com>
 <fd4f3e1c-fd98-6550-6284-f1456e0332ba@oracle.com>
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
Message-ID: <566f2d81-8454-d4f5-6e73-adbd0ddedf28@gmx.com>
Date:   Thu, 17 Oct 2019 12:33:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <fd4f3e1c-fd98-6550-6284-f1456e0332ba@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DdnbfQVb281Q90zvA79JLfFRqPbOYbTVk"
X-Provags-ID: V03:K1:isFcxjMdvO0B+KuupjwmgUrqPMLNvb2ZYr3x7DfUy8I8qVSzGwi
 CtiLKrdPDdG9YlNAcYZ2PVFW80V7ODJcIndMFXbghUjgWJOM0dnNPS5GTNpBkER643vXQ63
 1EWuFrRyF83Hq2Dw+5oIWsLdtH4TpyvDsZV2anpBfIyU8bTmHtEghE5/jdpwCda5+eumeNe
 dQjlQKn+Lvb02RJraw6kg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hXXlJH0X6dc=:zHBV93IkUD9JA4IK4PD1Kg
 WytkBCfS3M3Mz4PZaD3rPjH+KljSgyY9ZD1T1RdSlgIn7mqWt03UycQTDFgF//Ww3rYlmPIK1
 SbPDWKvfG+Mbfhat6llf2+PwVa6Tx1FIIB1ZwRsNglj6LDyDWYB8Rkv+GsoCqvRyoIas4KH7x
 d9oIBuFREiG133MCypcKY2q2u4vNYcov1CeGrn8rUUzuz+pM60xZDg9AF9/V2lTrVs7NilmDq
 q4aosKiNNW3HBlJIlb9BaqTNpPRXcXk6QTqFqVTh43jhbP9gY5TCz3ybRdNgDDVdUsKFZ6262
 RtNn9mCnudJPMgN05d+8JAbR8p87umVDtvo27PP7qRTlyDljnMw4zloa6ehF0VVpTNlmzB1wv
 +DaOoZVPm+AVGm9mB2lY36iDEAmFS6JABPDlBgmBH/BYDFy8pQjvvbkrflpHeDYJRtTM0te1k
 eP4jSx6s9PkAC6MeoH1gtMLrdneF08sco76z1gDmG6W1Z99FZ6q9U5ma/L1TZN72utI7hrPNa
 5uvpB8jjwKiJq1yaQ6YCo+qnw+t7+KcSDVKFmDdWxL7xzaxG7O39//o465ePG6yAI7ncZB5wr
 HrIHDd7DqUcZIgcJ9tYuqTTer2g9mOZgb6CIoJfWPRo89EKlP/5/XvbIZAx2bri6MVw1AKP6d
 vFjGNoSeF7vDEVuANAxs0FqgCgTeWnQYk0sFTVvogkv/CbYpYyjdjYzxHejeg+R21zsxW12Gg
 1bWO+LpBf5+PzYrn7kFPEJBx4Wc6hVrFEv09wCAvob7wiPOyXZpQKFjefI3bFu/HeaGll/PvW
 Xeko3MVpuDjei0qYluIqLhhoeDcl5kquVzkU+cLVmLX9YsJx+ex3z/QQVo1hZStSb7DYeYVJh
 1ajWecqmwdcHEK3lm9zpYNH+Z0PsjPhIKr4rdzIqrZWCDqYGyRH2FCRKVocoEGXATZyAgWQFN
 S12vwy7JMnyCL7kcqiap8csbRp702cBEscnTwOIyAZCO9f/VLqMceGKDRthOIwQkamklPyP8/
 ++NvXNh6ASEBWmTEgBhGCSj8AnS13FD+61bL5oeggfIA2LbP5biVMDJizhOsNHO1VVvfQ4c09
 RQrqJgqj0Uw6nOB702lr9aGnj8bS6X3a7DgMoGQDsg3wUwlMJ/cY6C04pbvpYaeYvapJ70xbI
 utU5d91EA3ZMqPytD3qlLYWJlhl/lcMz82YMB/HhSSfpv4xGzSd+BFBBqMLOIpn384shjraPH
 T+08zzWJAc+OaoYX+G8tEWmOtNj3G7B1FokZ08D9xTtsF86aDJ4hx3XGJrhM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DdnbfQVb281Q90zvA79JLfFRqPbOYbTVk
Content-Type: multipart/mixed; boundary="ngSZ5YJXqaeyTy1oJ0Mr9QzTuXvknAUlh"

--ngSZ5YJXqaeyTy1oJ0Mr9QzTuXvknAUlh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/17 =E4=B8=8A=E5=8D=8811:23, Anand Jain wrote:
> On 10/8/19 12:49 PM, Qu Wenruo wrote:
>> This patch does the following refactor:
>> - Refactor parameter from @root to @fs_info
>>
>> - Refactor the large loop body into another function
>> =C2=A0=C2=A0 Now we have a helper function, read_one_block_group(), to=
 handle
>> =C2=A0=C2=A0 block group cache and space info related routine.
>>
>> - Refactor the return value
>> =C2=A0=C2=A0 Even we have the code handling ret > 0 from find_first_bl=
ock_group(),
>> =C2=A0=C2=A0 it never works, as when there is no more block group,
>> =C2=A0=C2=A0 find_first_block_group() just return -ENOENT other than 1=
=2E
>=20
>=20
> =C2=A0Can it be separated into patches? My concern is as it alters the =
return
> =C2=A0value of the rescue command. So we shall have clarity of a discre=
te
> =C2=A0patch to blame. Otherwise I agree its a good change.

No problem.

What about 3 patches split by the mentioned 3 refactors?
>=20
>=20
>> =C2=A0=C2=A0 This is super confusing, it's almost a mircle it even wor=
ks.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 ctree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 disk-io.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 ++-
>> =C2=A0 extent-tree.c | 160 ++++++++++++++++++++++++++++---------------=
-------
>> =C2=A0 3 files changed, 97 insertions(+), 74 deletions(-)
>>
>> diff --git a/ctree.h b/ctree.h
>> index 8c7b3cb40151..2899de358613 100644
>> --- a/ctree.h
>> +++ b/ctree.h
>> @@ -2550,7 +2550,7 @@ int update_space_info(struct btrfs_fs_info
>> *info, u64 flags,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 u64 total_bytes, u64 bytes_used,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct btrfs_space_info **space_info);
>> =C2=A0 int btrfs_free_block_groups(struct btrfs_fs_info *info);
>> -int btrfs_read_block_groups(struct btrfs_root *root);
>> +int btrfs_read_block_groups(struct btrfs_fs_info *info);
>> =C2=A0 struct btrfs_block_group_cache *
>> =C2=A0 btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_=
used,
>> u64 type,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 u64 chunk_offset, u64 size);
>> diff --git a/disk-io.c b/disk-io.c
>> index be44eead5cef..8978f0cb60c7 100644
>> --- a/disk-io.c
>> +++ b/disk-io.c
>> @@ -983,14 +983,17 @@ int btrfs_setup_all_roots(struct btrfs_fs_info
>> *fs_info, u64 root_tree_bytenr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->last_trans_committed =3D gener=
ation;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (extent_buffer_uptodate(fs_info->ext=
ent_root->node) &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(flags & OPEN_=
CTREE_NO_BLOCK_GROUPS)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_read_block_g=
roups(fs_info->tree_root);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_read_block_g=
roups(fs_info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If we d=
on't find any blockgroups (ENOENT) we're either
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * restori=
ng or creating the filesystem, where it's expected,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * anythin=
g else is error
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D -ENOENT)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0 && ret !=3D -E=
NOENT) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
rno =3D -ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror("failed to read block groups: %m");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
>=20
> As mentioned this alters the rescue command semantics as show below.
> Earlier we had only -EIO as error now its much more and accurate
> which is good. fstests is fine but anything else?
>=20
> cmd_rescue_chunk_recover()
> =C2=A0 btrfs_recover_chunk_tree()
> =C2=A0=C2=A0=C2=A0 open_ctree_with_broken_chunk()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_setup_all_roots()

I'm not sure if I got the point.

Although btrfs_setup_all_roots() get called in above call chain, it
doesn't have any special handling of -EIO or others.

It just reads the extent tree root.

Would you mind to explain a little more?

Thanks,
Qu


>=20
> Thanks, Anand
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.objectid =3D BTRFS_FS_TREE_OBJECTID=
;
>> diff --git a/extent-tree.c b/extent-tree.c
>> index 19d1ea0df570..9713d627764c 100644
>> --- a/extent-tree.c
>> +++ b/extent-tree.c
>> @@ -2607,6 +2607,13 @@ int btrfs_free_block_groups(struct
>> btrfs_fs_info *info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +/*
>> + * Find a block group which starts >=3D @key->objectid in extent tree=
=2E
>> + *
>> + * Return 0 for found
>> + * Retrun >0 for not found
>> + * Return <0 for error
>> + */
>> =C2=A0 static int find_first_block_group(struct btrfs_root *root,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_pa=
th *path, struct btrfs_key *key)
>> =C2=A0 {
>> @@ -2636,36 +2643,95 @@ static int find_first_block_group(struct
>> btrfs_root *root,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path->slots[0]+=
+;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 ret =3D -ENOENT;
>> +=C2=A0=C2=A0=C2=A0 ret =3D 1;
>> =C2=A0 error:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 -int btrfs_read_block_groups(struct btrfs_root *root)
>> +/*
>> + * Helper function to read out one BLOCK_GROUP_ITEM and insert it int=
o
>> + * block group cache.
>> + *
>> + * Return 0 if nothing wrong (either insert the bg cache or skip 0
>> sized bg)
>> + * Return <0 for error.
>> + */
>> +static int read_one_block_group(struct btrfs_fs_info *fs_info,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_path *path)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_path *path;
>> -=C2=A0=C2=A0=C2=A0 int ret;
>> -=C2=A0=C2=A0=C2=A0 int bit;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_block_group_cache *cache;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *info =3D root->fs_info;
>> +=C2=A0=C2=A0=C2=A0 struct extent_io_tree *block_group_cache =3D
>> &fs_info->block_group_cache;
>> +=C2=A0=C2=A0=C2=A0 struct extent_buffer *leaf =3D path->nodes[0];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_space_info *space_info;
>> -=C2=A0=C2=A0=C2=A0 struct extent_io_tree *block_group_cache;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_block_group_cache *cache;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>> -=C2=A0=C2=A0=C2=A0 struct btrfs_key found_key;
>> -=C2=A0=C2=A0=C2=A0 struct extent_buffer *leaf;
>> +=C2=A0=C2=A0=C2=A0 int slot =3D path->slots[0];
>> +=C2=A0=C2=A0=C2=A0 int bit =3D 0;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 block_group_cache =3D &info->block_group_ca=
che;
>> +=C2=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(leaf, &key, slot);
>> +=C2=A0=C2=A0=C2=A0 ASSERT(key.type =3D=3D BTRFS_BLOCK_GROUP_ITEM_KEY)=
;
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Skip 0 sized block group, don't insert the=
m into block
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * group cache tree, as its length is 0, it w=
on't get
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * freed at close_ctree() time.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (key.offset =3D=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 cache =3D kzalloc(sizeof(*cache), GFP_NOFS);
>> +=C2=A0=C2=A0=C2=A0 if (!cache)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0 read_extent_buffer(leaf, &cache->item,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 btrfs_item_ptr_offset(leaf, slot),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sizeof(cache->item));
>> +=C2=A0=C2=A0=C2=A0 memcpy(&cache->key, &key, sizeof(key));
>> +=C2=A0=C2=A0=C2=A0 cache->cached =3D 0;
>> +=C2=A0=C2=A0=C2=A0 cache->pinned =3D 0;
>> +=C2=A0=C2=A0=C2=A0 cache->flags =3D btrfs_block_group_flags(&cache->i=
tem);
>> +=C2=A0=C2=A0=C2=A0 if (cache->flags & BTRFS_BLOCK_GROUP_DATA) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit =3D BLOCK_GROUP_DATA;
>> +=C2=A0=C2=A0=C2=A0 } else if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM=
) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit =3D BLOCK_GROUP_SYSTEM=
;
>> +=C2=A0=C2=A0=C2=A0 } else if (cache->flags & BTRFS_BLOCK_GROUP_METADA=
TA) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit =3D BLOCK_GROUP_METADA=
TA;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 set_avail_alloc_bits(fs_info, cache->flags);
>> +=C2=A0=C2=A0=C2=A0 if (btrfs_chunk_readonly(fs_info, cache->key.objec=
tid))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->ro =3D 1;
>> +=C2=A0=C2=A0=C2=A0 exclude_super_stripes(fs_info, cache);
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D update_space_info(fs_info, cache->flags, c=
ache->key.offset,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 btrfs_block_group_used(&cache->item),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &space_info);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(cache);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 cache->space_info =3D space_info;
>> +
>> +=C2=A0=C2=A0=C2=A0 set_extent_bits(block_group_cache, cache->key.obje=
ctid,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ca=
che->key.objectid + cache->key.offset - 1,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bi=
t | EXTENT_LOCKED);
>> +=C2=A0=C2=A0=C2=A0 set_state_private(block_group_cache, cache->key.ob=
jectid,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (unsigned long)cache);
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 root =3D info->extent_root;
>> +int btrfs_read_block_groups(struct btrfs_fs_info *fs_info)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_path path;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_root *root;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>> +
>> +=C2=A0=C2=A0=C2=A0 root =3D fs_info->extent_root;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.objectid =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.offset =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY=
;
>> -=C2=A0=C2=A0=C2=A0 path =3D btrfs_alloc_path();
>> -=C2=A0=C2=A0=C2=A0 if (!path)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0 btrfs_init_path(&path);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while(1) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D find_first_block_g=
roup(root, path, &key);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D find_first_block_g=
roup(root, &path, &key);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret > 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto error;
>> @@ -2673,67 +2739,21 @@ int btrfs_read_block_groups(struct btrfs_root
>> *root)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D 0)=
 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto error;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf =3D path->nodes[0];
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(leaf=
, &found_key, path->slots[0]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(path=
=2Enodes[0], &key, path.slots[0]);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache =3D kzalloc(s=
izeof(*cache), GFP_NOFS);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cache) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D read_one_block_gro=
up(fs_info, &path);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto error;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read_extent_buffer(=
leaf, &cache->item,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_ptr_offset(leaf, path-=
>slots[0]),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(cache->item));
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(&cache->key, &found=
_key, sizeof(found_key));
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->cached =3D 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->pinned =3D 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.objectid =3D found_key=
=2Eobjectid + found_key.offset;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (found_key.offset =3D=3D=
 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (key.offset =3D=3D 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 key.objectid++;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_path(path);
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Skip 0 sized block=
 group, don't insert them into block
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * group cache tree, =
as its length is 0, it won't get
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * freed at close_ctr=
ee() time.
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (found_key.offset =3D=3D=
 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fr=
ee(cache);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
ntinue;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->flags =3D btrfs_blo=
ck_group_flags(&cache->item);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit =3D 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache->flags & BTRFS_B=
LOCK_GROUP_DATA) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bi=
t =3D BLOCK_GROUP_DATA;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (cache->flags & =
BTRFS_BLOCK_GROUP_SYSTEM) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bi=
t =3D BLOCK_GROUP_SYSTEM;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (cache->flags & =
BTRFS_BLOCK_GROUP_METADATA) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bi=
t =3D BLOCK_GROUP_METADATA;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_avail_alloc_bits(info,=
 cache->flags);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_chunk_readonly(i=
nfo, cache->key.objectid))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ca=
che->ro =3D 1;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exclude_super_stripes(info=
, cache);
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D update_space_info(=
info, cache->flags, found_key.offset,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_block_group_used(&cac=
he->item),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &space_info);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(ret);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->space_info =3D spac=
e_info;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* use EXTENT_LOCKED to pr=
event merging */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_extent_bits(block_grou=
p_cache, found_key.objectid,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 found_key.objectid + found_key.offset - 1,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bit | EXTENT_LOCKED);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_state_private(block_gr=
oup_cache, found_key.objectid,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (unsigned long)cache);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ke=
y.objectid =3D key.objectid + key.offset;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);=

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>> =C2=A0 error:
>> -=C2=A0=C2=A0=C2=A0 btrfs_free_path(path);
>> +=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0
>=20


--ngSZ5YJXqaeyTy1oJ0Mr9QzTuXvknAUlh--

--DdnbfQVb281Q90zvA79JLfFRqPbOYbTVk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2n7yAACgkQwj2R86El
/qhHOwgAjFcNCYD43h8WVu5hAtGbQ1Q5gszLAanQTREUXxNHK1Sr5AZ3p6tkid6O
RaBaxivKHvGsuEh5MSiX+LBpEYXAn9Z6fuOKGzyen0Dps/Nm9I3SU58CCzB5mtbY
sf4bkJDWYDQ0mlHub/ZsYGmPfZvmbtEMNXkN8VFzMj/YSc2ay/cujFU3NrBDle1s
S7I7Rlkbww5oTd0/y9kQFE/1L13ONnyM39FawR3Dk0tl5hscEIdvy/HAUkEaJVFP
Jw9x7VMgSRijCw/0NVlBPru5rZf8EXi5nkC8vkCdsVv6mVY3EJk6u636vbOu3pmw
OFOeUOY8llAVKCsgsp9k8Xr4y9dQVQ==
=cuhP
-----END PGP SIGNATURE-----

--DdnbfQVb281Q90zvA79JLfFRqPbOYbTVk--
