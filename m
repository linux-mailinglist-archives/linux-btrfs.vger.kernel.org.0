Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD7CB6341
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 14:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfIRMbd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Sep 2019 08:31:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:51507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfIRMbd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Sep 2019 08:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568809888;
        bh=TiMYuIUkC6uLu1ukU8EQMrGTSkB1f14jo3fNnNJZmYQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VTjSNCnBXa02ODu1NVqMfjMWp8oDQP17pgisrMCygII0EfFNNswb30Cg2jNcoImt2
         C/btj4MCLOlhpDmzPnBJCY/vfHK68K0bqE2kfEf+G+QIPLHc8Y/UfL8QqUPrQRyizY
         tsx2w8d54vUJ7aXeV3dybBxlLeiZA2n7D3QWkS3Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWAOW-1ih4VB2rNa-00XdOH; Wed, 18
 Sep 2019 14:31:28 +0200
Subject: Re: [PATCH] Btrfs: fix selftests failure due to uninitialized i_mode
 in test inodes
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190918120852.764-1-fdmanana@kernel.org>
 <35dbd7db-ab20-111b-3ba4-01a0cd947f58@gmx.com>
 <CAL3q7H44rF04QKQni_Su1O1wBm=2kkDjdE6oqTA0oB6bzT6Ubw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <f3765129-96f4-54e2-9255-bfc5c8c8df88@gmx.com>
Date:   Wed, 18 Sep 2019 20:31:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H44rF04QKQni_Su1O1wBm=2kkDjdE6oqTA0oB6bzT6Ubw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NF0DMStqly69ITagGmlJJc4nj2WAExCbu"
X-Provags-ID: V03:K1:41gIHBnlGx+rKAIM9on4Bn57oSOi0OLybIPIvooyL9UX9LjBKVG
 oBsE0M9BeIG/xlOdynSAGf7QphKEPmskvt4LLNUlKhNw2tlnks9scgjKNmiYTbECBRJWm9y
 sakE5VwN6iTf+dwBpf1n1GQcbzy/V/yNvDY5+r0EZ3A7SigUZNJ2XRsp+mZhrX1LNRmY/1V
 j1VvzYsViTeVH1yPdWJJQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WYthiIupJVo=:KrtLYPK/M7s9NKzcY7v/t8
 Nb7GYixFDyJYmFWjXZS4rZZJwQ8MchK8MEaqk6M6hxvAhUlqwc4y23N4u12LHHzlaCQtHU8dR
 MABTHrLYBy7/n2jq7rxEuFLkpLPBzwszI5iRGeiVD7bpTtvuwYwpfSWPizxYXJMr+O0qy4IQP
 ETdnwFmr5cNrtqOpka8pNgNzrf3h+yh6IoxTYUiyd77+QA4EzAGTMB3dfx2jiWLsCrqc4spT2
 8mwDjvpuYgNt0LG2RoSfe57B5e/diosEa3IFVbHJtxeepmr32UkxgMjxv9waWwtHQ/dak94Wa
 F7AgWP8dp1xyUdoXqwra8GpLGUHbMNQ91UiUsTdI+oQLsQvleL3+VtoSjxKexmTQrVbJkoPFS
 RbyW6y12axbl74Xd08eYnHnZh+6dZWZLaCdjbvX6JtFagUUDigiAM5uOACWZmEo7B+tvy9oqW
 0TEr+A8CyJiyj7s1feluz8utKn+6IJ+8lY1rjy2dJPtEovs8lyVznC/d8fNw0tcIniSHxk6Ao
 16PHReyhaTO2LroptaDy/cQHqODvSjdjy9HNhuHdeWdCuoO4WVYKexwETYqdou/gzq/5O8m1N
 J5Sqnz/K90luWCA9B3MU2H8onHNKzbRctZUJAmAOUCYNh0Gruig02fwg9d61tIJdUpF6alPVH
 cJ2NSwgKdZoL/yYlLK8qfSOFFX999p7rtkY7faAejZOM/g72laibBDTYzR0ON4f/6cIurvjBX
 /ofnD+Fb4wFnRoMcB33H4XpovzTz+gnLKH8v4p1gKU/sKvFXQpEsfFvxH3Ha2fWKj2gydL1Qr
 k+4kPeN5TAyOEJ88NLpy35uumhzvDuLInhnsLWVJ+ObcsWmz9ep49iAaeFPa4u1zjR2INMo4b
 HzpawNxfH51P0MnRHznfioRpgbYgC2AyBQ419t/BjMIUx5Zks/1aesDrrWv/NsMn6kdpzusEg
 HWc1E7hHAK4jgkIzzX5QychMhJL7mopUso1ikijXAwF4tMPQG/Gppthzc/UXQswtxDKMQ0024
 QYkz7uI2HzjzZhvefKOWZYylFkXF2DMj+Q5cApOiyKYCF1d2KDtODe4zWLqkekQgEv3j/BJK8
 xi5ixQbplLQ8DB22p94pCwagGx8W65InSFspQqbrT9EBNSS3eQnCwZSxtFS+cYN5JRiFs3mjY
 xErfI5Z1aD4Pc4UbTYef+NmkMM4JsEEs9lJ3ywcS2P7q6rCUWAhzwzA728dUWfosnDUi8UYzn
 ZggTt+PTqP6we+FruQ9AmBcuaX769jMFeGLJCQYnR058Wdq8artGab5p9XNY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NF0DMStqly69ITagGmlJJc4nj2WAExCbu
Content-Type: multipart/mixed; boundary="TubVE2GP0l2eFH7zqTxHsVyzgIZsZVzWg"

--TubVE2GP0l2eFH7zqTxHsVyzgIZsZVzWg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/18 =E4=B8=8B=E5=8D=888:27, Filipe Manana wrote:
> On Wed, Sep 18, 2019 at 1:22 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2019/9/18 =E4=B8=8B=E5=8D=888:08, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Some of the self tests create a test inode, setup some extents and th=
en do
>>> calls to btrfs_get_extent() to test that the corresponding extent map=
s
>>> exist and are correct. However btrfs_get_extent(), since the 5.2 merg=
e
>>> window, now errors out when it finds a regular or prealloc extent for=
 an
>>> inode that does not correspond to a regular file (its ->i_mode is not=

>>> S_IFREG). This causes the self tests to fail sometimes, specially whe=
n
>>> KASAN, slub_debug and page poisoning are enabled:
>>>
>>>   $ modprobe btrfs
>>>   modprobe: ERROR: could not insert 'btrfs': Invalid argument
>>>
>>>   $ dmesg
>>>   [ 9414.691648] Btrfs loaded, crc32c=3Dcrc32c-intel, debug=3Don, ass=
ert=3Don, integrity-checker=3Don, ref-verify=3Don
>>>   [ 9414.692655] BTRFS: selftest: sectorsize: 4096  nodesize: 4096
>>>   [ 9414.692658] BTRFS: selftest: running btrfs free space cache test=
s
>>>   [ 9414.692918] BTRFS: selftest: running extent only tests
>>>   [ 9414.693061] BTRFS: selftest: running bitmap only tests
>>>   [ 9414.693366] BTRFS: selftest: running bitmap and extent tests
>>>   [ 9414.696455] BTRFS: selftest: running space stealing from bitmap =
to extent tests
>>>   [ 9414.697131] BTRFS: selftest: running extent buffer operation tes=
ts
>>>   [ 9414.697133] BTRFS: selftest: running btrfs_split_item tests
>>>   [ 9414.697564] BTRFS: selftest: running extent I/O tests
>>>   [ 9414.697583] BTRFS: selftest: running find delalloc tests
>>>   [ 9415.081125] BTRFS: selftest: running find_first_clear_extent_bit=
 test
>>>   [ 9415.081278] BTRFS: selftest: running extent buffer bitmap tests
>>>   [ 9415.124192] BTRFS: selftest: running inode tests
>>>   [ 9415.124195] BTRFS: selftest: running btrfs_get_extent tests
>>>   [ 9415.127909] BTRFS: selftest: running hole first btrfs_get_extent=
 test
>>>   [ 9415.128343] BTRFS critical (device (efault)): regular/prealloc e=
xtent found for non-regular inode 256
>>>   [ 9415.131428] BTRFS: selftest: fs/btrfs/tests/inode-tests.c:904 ex=
pected a real extent, got 0
>>>
>>> This happens because the test inodes are created without ever initial=
izing
>>> the i_mode field of the inode, and neither VFS's new_inode() nor the =
btrfs
>>> callback btrfs_alloc_inode() initialize the i_mode. Initialization of=
 the
>>> i_mode is done through the various callbacks used by the VFS to creat=
e
>>> new inodes (regular files, directories, symlinks, tmpfiles, etc), whi=
ch
>>> all call btrfs_new_inode() which in turn calls inode_init_owner(), wh=
ich
>>> sets the inode's i_mode. Since the tests only uses new_inode() to cre=
ate
>>> the test inodes, the i_mode was never initialized.
>>>
>>> This always happens on a VM I used with kasan, slub_debug and many ot=
her
>>> debug facilities enabled. It also happened to someone who reported th=
is
>>> on bugzilla (on a 5.3-rc).
>>>
>>> Fix this by setting i_mode to S_IFREG at btrfs_new_test_inode().
>>>
>>> Fixes: 6bf9e4bd6a2778 ("btrfs: inode: Verify inode mode to avoid NULL=
 pointer dereference")
>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D204397
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> However I'm interested why it doesn't get triggered reliably.
>> As I have selftest compiled in everytime.
>>
>> Is there anything racy caused the bug?
>=20
> Nop (otherwise I would have noted that in the changelog).
>=20
> It's just garbage due to uninitialized memory.
> In this case, btrfs is a module and only used for testing, since a
> btrfs inode was never allocated before attempting to load the module
> and run the selftests, we get the garbage.

That makes sense.

Thanks for the fix!
Qu

> If we had a non-testing
> inode allocated and freed before running the tests, the i_mode of the
> test inode would match the one from previously freed inode.
>=20
>>
>> Thanks,
>> Qu
>>
>>> ---
>>>  fs/btrfs/tests/btrfs-tests.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-test=
s.c
>>> index b5e80563efaa..99fe9bf3fdac 100644
>>> --- a/fs/btrfs/tests/btrfs-tests.c
>>> +++ b/fs/btrfs/tests/btrfs-tests.c
>>> @@ -52,7 +52,13 @@ static struct file_system_type test_type =3D {
>>>
>>>  struct inode *btrfs_new_test_inode(void)
>>>  {
>>> -     return new_inode(test_mnt->mnt_sb);
>>> +     struct inode *inode;
>>> +
>>> +     inode =3D new_inode(test_mnt->mnt_sb);
>>> +     if (inode)
>>> +             inode_init_owner(inode, NULL, S_IFREG);
>>> +
>>> +     return inode;
>>>  }
>>>
>>>  static int btrfs_init_test_fs(void)
>>>
>>


--TubVE2GP0l2eFH7zqTxHsVyzgIZsZVzWg--

--NF0DMStqly69ITagGmlJJc4nj2WAExCbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2CI5sACgkQwj2R86El
/qjMDQf/cEtZsrs7hnrJAL85FG4DFjLy2ZtyEovCJpcc8j1sJKIJAJFFNhWkc5k1
El4WgGJBljwrPtIjO/Dad2+wI2EEikOCGajVmbkmkDRnFJk45sXl8alIYix3T3fZ
DhYxNntD2vdybTUf1edRh4tqDNC8q6Fl2aY0nK2ttmpCji8MIGDVTGAWChDOGejA
mYA3RTK3oDyN7akXnH0LzFiS64VmzWBbncgB4P0FOoCl5h+0ZzSrephqJSysYE5h
lijzOuDFIVzL6sc/oyP2ShgHYb4o3BRarftKQM1Isr6sYU8nHQmsoMDjHTvrD2OV
RvQjafeA8FERyu5T3bedryEtzkTv8A==
=omvP
-----END PGP SIGNATURE-----

--NF0DMStqly69ITagGmlJJc4nj2WAExCbu--
