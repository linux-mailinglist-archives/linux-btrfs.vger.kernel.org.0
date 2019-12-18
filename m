Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0ADD123D00
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 03:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfLRCRf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 21:17:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:47075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfLRCRf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 21:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576635447;
        bh=0M8JQImztcxSqTC55DdhTOkhvqtzNipWe3bFuCXEVEA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VQ9H7PUgkXD/hCdlA9OAu8kwieaFz49bw5p/wZsLWx5yfrL3pVexqNqZL4p81OkLU
         9FSnSzMgUcTwAl0s1P/ycBUqHdX5+n8jKk4X/VgZl7e3gY5+HgtoljWBHCcFxeSLME
         3rJUEG3/ohyp65FnEU4ZwAYo/aIQuIK89Pg6mE28=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHXBj-1iTykx21kP-00DXfx; Wed, 18
 Dec 2019 03:17:27 +0100
Subject: Re: [PATCH 2/6] btrfs-progs: check/original: Do extra verification on
 file extent item
To:     Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191218011942.9830-1-wqu@suse.com>
 <20191218011942.9830-3-wqu@suse.com>
 <be25f8ed-996a-5fc5-6bad-348441868761@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b46a5e36-46f2-f330-695b-2e1e60c2c343@gmx.com>
Date:   Wed, 18 Dec 2019 10:17:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <be25f8ed-996a-5fc5-6bad-348441868761@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NX5GwZauU00aOSg6W9B1Efr0CBX069nxQ"
X-Provags-ID: V03:K1:sGsB5AFBC0TmhfOpn1mAOdCNIyyK+83bjbXekPvBwe6OUwpmRiS
 KOAR3Jc+JToNbW1uYu2L6ch7qxyOs/1yukyucnFDFH9zYH2ufRZYooxhE5Nq3tkN3MJ5e3e
 p4Vu12xtqEViBiKqWx0+Qq7gA2+tEQWbdIAqRKYEf53vW++P32u9EuAjBo0syeSapIWE2KE
 NTq92UFH3zARX7xZbFmNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c2W2Hne5OEs=:uRSY2bRgiCMS+2m5ZgVk+a
 CdXTjkQoQsk8OH9LNCoFmp5sZS6XV0CFnFHduf7ktaxyNkl2gsSLBf/XW9BkWTq1ZhJADN9TC
 ThYoIuLPPIY/MolFMG35cPmfhzAuF6vvgFeIiVO9xsFVPcrus+fmABrN6bMGm9CCtH7QhnYWo
 N+3ZLdXrSDGrr9tOfS9+o3ON0Q17T0SWRbmvxsOKwkUQ7bwrYoOYTrodggpUSjvUYGsW2fsLc
 iDGSCpCo1YIs9GSHXdhBdR/O3nvWI2tFrcjc1RfFhuEtzAMeG3vADmcW33rpvChmBGRynFgA+
 DDgR356NWj2OlOJroz3+7mIwfbL7l0bPeQjIGIw3LCz6G+irXsQ3INUxIM0uddQ7BTw4Ntb1y
 fpZdLOX55kzQtoC2rVivM4cZb67DfCbVuplBalAQdb2SOYMVYVcmrVAeHaMKNfIhhXbNVrS2F
 32pIBsagFsvx2y3jSq5XatII6io95N08+Jzg29pCle2ICgW49X8/1xgio59DJNRr6ZGfYXLN7
 NuEzIyQHnJwYgtA1UCulOHu9yqrRFVOHqxXbdiacacd+8wT68FNNsvWTJU4LVQM92gpgs/4GK
 sd4ps+zQURBuGoV3G8YSF0ndA3/fFGsEU57PNGCoOQx/DYDnPorc6tZNbqTb4xtNpddlSJ4Lg
 D30BjdNJmxb2plNCOKfa8m1BcqbOglqM+TjXFpieic9pQ4Tk1wt0V7fOkS3Zt6KQuy3Ns6XKl
 Eq6mmvidMGoCi8/PjbPKyJ96bmBFbi8QYoCG1xC1VoA+EbkRMmhuA51t212i8E8huaXCoLoSl
 5Utfi6UQjFutPWGpMJvuxFSh33g+hJD0IAt5NG9qC9yxw0B3ntVYlRPWUDJT8PBvUPiBYX/25
 M4sjGWrry7EXRsXsZNqk5BldRhtOvLN3Oqt4i087p8sG3fWmG9N2RiEDl/KoXa/p7vgaScUCN
 QrPTT42/k5Gx/pOPeicbKOgk4TKNMzLDvmWkBNKw2r3l5cYXTinCrLo8ItmCShVBcL04N/ehL
 h0E9EOT2EvbB/eznt0Hm8+e3DWc+PJiE5No+OBNAeFp79m9/mdkXzXJ4YQKvjZ6Zdf12e+w8S
 aDK0ocQPDAC4oGaHO1OP48B4iT7pvWyFyqJvnjz3L57jX2W/j683VlvJ6ZXZBejOTL9Y3Fjsh
 lG9ApvZEXqJRS+n5CX4RZK7XorKltiumB2sesdlqA6vi3WGda2zC2RTI95moqBvBCDEZsmrX9
 Z/ghfw5XU2ptFZ93mAn/J+EYFy7Vrz+t7mJJm4ACtjP8Suyfz8uT22FX1v94=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NX5GwZauU00aOSg6W9B1Efr0CBX069nxQ
Content-Type: multipart/mixed; boundary="acVUiKv4CYjq0ZiwIBLQagAwAyDjA3fSz"

--acVUiKv4CYjq0ZiwIBLQagAwAyDjA3fSz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/18 =E4=B8=8A=E5=8D=8810:09, Su Yue wrote:
> On 2019/12/18 9:19 AM, Qu Wenruo wrote:
>> [BUG]
>> For certain fuzzed image, `btrfs check` will fail with the following
>> call trace:
>> =C2=A0=C2=A0 Checking filesystem on issue_213.raw
>> =C2=A0=C2=A0 UUID: 99e50868-0bda-4d89-b0e4-7e8560312ef9
>> =C2=A0=C2=A0 [1/7] checking root items
>> =C2=A0=C2=A0 [2/7] checking extents
>> =C2=A0=C2=A0 Program received signal SIGABRT, Aborted.
>> =C2=A0=C2=A0 0x00007ffff7c88f25 in raise () from /usr/lib/libc.so.6
>> =C2=A0=C2=A0 (gdb) bt
>> =C2=A0=C2=A0 #0=C2=A0 0x00007ffff7c88f25 in raise () from /usr/lib/lib=
c.so.6
>> =C2=A0=C2=A0 #1=C2=A0 0x00007ffff7c72897 in abort () from /usr/lib/lib=
c.so.6
>> =C2=A0=C2=A0 #2=C2=A0 0x00005555555abc3e in run_next_block (...) at ch=
eck/main.c:6398
>> =C2=A0=C2=A0 #3=C2=A0 0x00005555555b0f36 in deal_root_from_list (...) =
at
>> check/main.c:8408
>> =C2=A0=C2=A0 #4=C2=A0 0x00005555555b1a3d in check_chunks_and_extents
>> (fs_info=3D0x5555556a1e30) at check/main.c:8690
>> =C2=A0=C2=A0 #5=C2=A0 0x00005555555b1e3e in do_check_chunks_and_extent=
s
>> (fs_info=3D0x5555556a1e30) a
>> =C2=A0=C2=A0 #6=C2=A0 0x00005555555b5710 in cmd_check (cmd=3D0x5555556=
96920
>> <cmd_struct_check>, argc
>> =C2=A0=C2=A0 #7=C2=A0 0x0000555555568dc7 in cmd_execute (cmd=3D0x55555=
5696920
>> <cmd_struct_check>, ar
>> =C2=A0=C2=A0 #8=C2=A0 0x0000555555569713 in main (argc=3D2, argv=3D0x7=
fffffffde70) at
>> btrfs.c:386
>>
>> [CAUSE]
>> This fuzzed images has a corrupted EXTENT_DATA item in data reloc tree=
:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 1 key (256 EXTEN=
T_DATA 256) itemoff 16111 itemsize 12
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 generation 0 type 2 (prealloc)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 prealloc data disk byte 16777216 nr 0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 prealloc data offset 0 nr 0
>>
>> There are several problems with the item:
>> - Bad item size
>> =C2=A0=C2=A0 12 is too small.
>> - Bad key offset
>> =C2=A0=C2=A0 offset of EXTENT_DATA type key represents file offset, wh=
ich should
>> =C2=A0=C2=A0 always be aligned to sector size (4K in this particular c=
ase).
>>
>> [FIX]
>> Do extra item size and key offset check for original mode, and remove
>> the abort() call in run_next_block().
>>
>> And to show off how robust lowmem mode is, lowmem can handle it withou=
t
>> any hiccup.
>>
>> With this fix, original mode can detect the problem properly:
>> =C2=A0=C2=A0 Checking filesystem on issue_213.raw
>> =C2=A0=C2=A0 UUID: 99e50868-0bda-4d89-b0e4-7e8560312ef9
>> =C2=A0=C2=A0 [1/7] checking root items
>> =C2=A0=C2=A0 [2/7] checking extents
>> =C2=A0=C2=A0 ERROR: invalid file extent item size, have 12 expect (21,=
 16283]
>> =C2=A0=C2=A0 ERROR: errors found in extent allocation tree or chunk al=
location
>> =C2=A0=C2=A0 [3/7] checking free space cache
>> =C2=A0=C2=A0 [4/7] checking fs roots
>> =C2=A0=C2=A0 root 18446744073709551607 root dir 256 error
>> =C2=A0=C2=A0 root 18446744073709551607 inode 256 errors 62, no orphan =
item, odd
>> file extent, bad file extent
>> =C2=A0=C2=A0 ERROR: errors found in fs roots
>> =C2=A0=C2=A0 found 131072 bytes used, error(s) found
>> =C2=A0=C2=A0 total csum bytes: 0
>> =C2=A0=C2=A0 total tree bytes: 131072
>> =C2=A0=C2=A0 total fs tree bytes: 32768
>> =C2=A0=C2=A0 total extent tree bytes: 16384
>> =C2=A0=C2=A0 btree space waste bytes: 124774
>> =C2=A0=C2=A0 file data blocks allocated: 0
>> =C2=A0=C2=A0=C2=A0 referenced 0
>>
>> Issue: #213
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Almost fine. Two nitpicks below.
> I guess that they could be fixed when merging.
>=20
>> ---
>> =C2=A0 check/main.c | 34 ++++++++++++++++++++++++++++++++--
>> =C2=A0 1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/check/main.c b/check/main.c
>> index 08dc9e66..91752dce 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -6268,7 +6268,10 @@ static int run_next_block(struct btrfs_root *ro=
ot,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btree_space_was=
te +=3D btrfs_leaf_free_space(buf);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i=
 < nritems; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct btrfs_file_extent_item *fi;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 un=
signed long inline_offset;
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
line_offset =3D offsetof(struct btrfs_file_extent_item,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 disk_bytenr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 btrfs_item_key_to_cpu(buf, &key, i);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * Check key type against the leaf owner.
>> @@ -6384,18 +6387,45 @@ static int run_next_block(struct btrfs_root
>> *root,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (key.type !=3D BTRFS_EXTENT_DATA_KEY)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Check itemsize before we continue*/
>=20
> One more space at the tail.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (btrfs_item_size_nr(buf, i) < inline_offset) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -EUCLEAN;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "invalid file extent item =
size, have %u expect (%lu, %lu]",
>=20
> should it be "[%llu, %lu)"?

If the file extent size matches inline_offset, then it's an empty inline
file extent, which is not valid.
So left side must be '('.

For the right side, it can take the whole leaf, e.g. for 4K nodesize.

So it's (%llu, %lu].

Thanks,
Qu
>=20
> Thanks.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_size_nr(buf, i),=

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inline_offset,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_LEAF_DATA_SIZE(fs_inf=
o));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fi =3D btrfs_item_ptr(buf, i,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct btrfs_file_extent_item);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (btrfs_file_extent_type(buf, fi) =3D=3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_FILE_EXTENT_INLINE)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Prealloc/regular extent must have fixed item size */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (btrfs_item_size_nr(buf, i) !=3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 sizeof(struct btrfs_file_extent_item)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -EUCLEAN;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "i=
nvalid file extent item size, have %u expect %zu",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_size_nr(buf, i),=

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct btrfs_file_ex=
tent_item));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 key.offset (file offset) must be aligned */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (!IS_ALIGNED(key.offset, fs_info->sectorsize)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -EUCLEAN;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "i=
nvalid file offset, have %llu expect aligned to %u",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.offset, fs_info->sector=
size);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (btrfs_file_extent_disk_bytenr(buf, fi) =3D=3D 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 data_bytes_allocated +=3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_file_extent_disk_num_bytes(buf, fi);=

>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (data_bytes_allocated < root->fs_info->sectorsize)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 abort();
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 data_bytes_referenced +=3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_file_extent_num_bytes(buf, fi);
>>
>=20


--acVUiKv4CYjq0ZiwIBLQagAwAyDjA3fSz--

--NX5GwZauU00aOSg6W9B1Efr0CBX069nxQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl35jDMXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qg++AgAql72LSdbUC0YpyXBB+3H4cdx
ITUktl8ehKCRD2cQ64LKBwPYt5h9A9qCvPPZVURzfUllqyymDB1h2G3QtoylHtAF
uqFhKiSEScqVZSz0cl6oKxReC7eZeM+mfkLXpYTAD95lbXxdee9gUR+4dmc31Qaa
m1H94p0EPwEJ3c38txPF3Uv4JNCe/WxbPv9ufLRE3Ozw1Ji7BAFlU1hjpKM+JCzB
Q7UGpt4bgeT6ocosZOnmtbEOU3ie+M659zb2F68z+yEq/nUMd/jQR1M5Zk3VYnND
NIT40gkLMcLUNpWbcVP4oJm2E8taVKX6PWzdc2AqiO1g8JTq1KVDFHbtsWeHGQ==
=tIh6
-----END PGP SIGNATURE-----

--NX5GwZauU00aOSg6W9B1Efr0CBX069nxQ--
