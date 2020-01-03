Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2140212F24D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 01:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgACAmX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 19:42:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:35715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgACAmW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 19:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578012136;
        bh=uOGF/efggYtqMhlc326Gz+LThZbY7xB1CmemSiPwtOE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=E8kSHAGcvZ8PfyRHCNLOlfEEPf/zQTnSFS0M4owCijqqux1ZdsW8Jew0pzltSamUA
         xxCuKSS4/GTimfLqUcQvpIn8lHHSDHXHET9wfGtdsIIB6qAb79LTiXj32P4XYNzLhf
         0J2kGK9KNoUMgH8v1F4CDaXt5fTlvmLzDYsNAw9c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1fis-1jkWsx1r0S-011wkX; Fri, 03
 Jan 2020 01:42:16 +0100
Subject: Re: [PATCH 6/6] btrfs-progs: extent-tree: Fix a by-one error in
 exclude_super_stripes()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191218011942.9830-1-wqu@suse.com>
 <20191218011942.9830-7-wqu@suse.com> <20200102165603.GL3929@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <eb9033f0-c390-0d83-07a6-63e89cb2020b@gmx.com>
Date:   Fri, 3 Jan 2020 08:42:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200102165603.GL3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EBPk8AQYfVHqEqoMdW97lJMuBKAST4qMD"
X-Provags-ID: V03:K1:bkVs8h3v3e2veJrZ0/gxVUMIH/JpmE4KAZEfr+Wrp1NcOqiC9Gc
 cCUDhot5w6wGnGBP2eVENmWOXp77KFMwLbdsi/h3theLdlAl5lzOCKwn2Ka+Itr9N1cjzk3
 8l+YVCNcFW6UEYp74Z/u2s4z+ia65XH6f9jh/CvtDT9FTofxj1X/gwVAVQQg1x281QhIUEO
 /kQx4jmZFao3PN3jS/qGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f5My50pM6BI=:WC0KHm2Gqct7XZ0am40d7x
 hOM6ZMuA6m91O0g9LpmySlSjPyhCO2tODwFRH8U3jNAiAVNgroskxOa5jQ+4MsmY4UhJ30jOT
 PHB3Iedyzhbmk7JGbbksR8Dde+DveTTUWeI3Ab+GRZ9Zoq6jVcpqcLjKVQZs2DNs4O3W6wE5i
 CVe0dzTywfVTYV5jwBpvKEztTIVVfaDroVXmz6AmCKVQ7KQl5LMNl4vRFcfjnWiN2M54P1ob+
 J3J/dPEKHADOSxPcRfoifoSNDi2Dl1kJ+aZZ9ZT64ogytE4RnjFiWJNVRhrnaIH3TIN7TDyl5
 /mS996swLdN7UZsV/6A47fCQUSDuGGwEwp/ImNQAJMgz4Eqeb3KIjB2VY/Pj+64ooczM5tt1h
 MlX3+R42x5A0xVyalgudbAMu0FYwsTqUgSfw6Qy1bJiksSv6WijaVAyEkZyXNaek19ibvAMmr
 9M+z9Hzn0NP7VcsWLj85knX7yOX1j5sojNMDywlXObtoag7z+hYH76RR/mLpgNUhkCPCteSYC
 XLDjHGAoSKHy/4WX5+lUvmyZEeW1R6cz3LiWZQ6oWns+dOfSOr91eZw6s4Cx2imERX84PYreq
 ovrlfT1nhO2tJgC+zbBogq3sH/LSQUZCL/H5Ls8Es/x01GT8moJ6ELrPt4erajb4bfMDFui+t
 Wp7e1JmkzmOKCi7XASA7bH1CpkgKhxG00n/QOC4k1PrVYqDXq5lqtC4R7Lg05E/+ILkihLfNV
 UCwBTVGH5sO0+80Y3OeerPygIrs8eStR0oMNZ7Ze8jwekkeROD5xu0hHEMW+Ie244dfhAcjE7
 nhGy4u/GrHdKQVuZ5CQnTzwSRyFsEqIZp391FtBrkFysNx9J6BU7/mzcGgGnJdf6ray9fqnM/
 oSDKxssJNkvsdytFAOgb8G3mdgWyitxwT+bUwudR5K/nhQifo/CTApHtp19GPj/9uOJ8HBdyf
 mBnWAfRWm+OtBO2Niw1TCqhuAisILE6FkPeANqXFDwz6V95v+82BM7au9ssi5Avb7owlTWgKS
 jBbERyMmsF5Dmv1B2YJ18KfAWMveRM9xXITxlf8ERnQ+dWzaIgzID71hiMNtdYmvZl+iE5zZo
 aivO/ZtRJEni6b9wpr2gCzt87aFbiT/Gfz2PYo36ZiQ+LatytathCOeNAc6E6PsTS7TQGnCIh
 FBsBVeWIczyH5UhI7JfLP5y4GN8443ZZFpQEd4y+JAMYS1dPVmKaVth7XLD9EN0+EqCd5uXXg
 siD0QdXBFG4s3l/pBtsyf6DmPDwWfLIqR6dVd09vPoN/UzQuJgE0wu9U4TAw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EBPk8AQYfVHqEqoMdW97lJMuBKAST4qMD
Content-Type: multipart/mixed; boundary="lgRsT7DoQkZcJ7eCSMY7HOaQZocqaOHmA"

--lgRsT7DoQkZcJ7eCSMY7HOaQZocqaOHmA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/3 =E4=B8=8A=E5=8D=8812:56, David Sterba wrote:
> On Wed, Dec 18, 2019 at 09:19:42AM +0800, Qu Wenruo wrote:
>> [BUG]
>> For certain btrfs images, a BUG_ON() can be triggered at open_ctree()
>> time:
>>   Opening filesystem to check...
>>   extent_io.c:158: insert_state: BUG_ON `end < start` triggered, value=
 1
>>   btrfs(+0x2de57)[0x560c4d7cfe57]
>>   btrfs(+0x2e210)[0x560c4d7d0210]
>>   btrfs(set_extent_bits+0x254)[0x560c4d7d0854]
>>   btrfs(exclude_super_stripes+0xbf)[0x560c4d7c65ff]
>>   btrfs(btrfs_read_block_groups+0x29d)[0x560c4d7c698d]
>>   btrfs(btrfs_setup_all_roots+0x3f3)[0x560c4d7c0b23]
>>   btrfs(+0x1ef53)[0x560c4d7c0f53]
>>   btrfs(open_ctree_fs_info+0x90)[0x560c4d7c11a0]
>>   btrfs(+0x6d3f9)[0x560c4d80f3f9]
>>   btrfs(main+0x94)[0x560c4d7b60c4]
>>   /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7fd189773ee3]
>>   btrfs(_start+0x2e)[0x560c4d7b635e]
>>
>> [CAUSE]
>> This is caused by passing @len =3D=3D 0 to add_excluded_extent(), whic=
h
>> means one revsere mapped range is just out of the block group range,
>> normally means a by-one error.
>>
>> [FIX]
>> Fix the boundary check on the reserve mapped range against block group=

>> range.
>> If a reverse mapped super block starts at the end of the block group, =
it
>> doesn't cover so we don't need to bother the case.
>>
>> Issue: #210
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  extent-tree.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/extent-tree.c b/extent-tree.c
>> index 6288c8a3..7ba80375 100644
>> --- a/extent-tree.c
>> +++ b/extent-tree.c
>> @@ -3640,7 +3640,7 @@ int exclude_super_stripes(struct btrfs_fs_info *=
fs_info,
>>  		while (nr--) {
>>  			u64 start, len;
>> =20
>> -			if (logical[nr] > cache->key.objectid +
>> +			if (logical[nr] >=3D cache->key.objectid +
>>  			    cache->key.offset)
>=20
> Do we have the same problem in kernel? The code does ">".
>=20
Oh, kernel looks to have the same problem.

Time to fix it.

Thanks,
Qu


--lgRsT7DoQkZcJ7eCSMY7HOaQZocqaOHmA--

--EBPk8AQYfVHqEqoMdW97lJMuBKAST4qMD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4OjeQXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgokQf+Odvz4h6wubBazArZVdTSPqZ6
SmqDK0BfUormAPSNuEN7kbneiqTxdWjVXY4QIY85Nt7JhxdCiKCs/9EoEJpT8IWs
ncHMNVdhoi7Htrmh/Dhq8fixdFhD4vmfZRi4NqnAQzqT4zTY/YTpu2UKiksD/TFT
C8HAM8p/WOIcn0xCrAO52VCWBhzO3r7QcXTco3DMlT+7tpBmMvPjEp/YQitDKNCx
hrMJmaAjAisvGTV06mnw9lt7YUMxRtJVcbofgg8bNd4zmuJppreLHLZuCVkpYb27
ddRo9w2JAixKnGS1N2rcGT0rm+yii/sOmHBC9CK10vZXbftFTaWXK1h104LKxw==
=s1PC
-----END PGP SIGNATURE-----

--EBPk8AQYfVHqEqoMdW97lJMuBKAST4qMD--
