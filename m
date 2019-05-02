Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E4B11490
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2019 09:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfEBHvV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 May 2019 03:51:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:55839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfEBHvV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 May 2019 03:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556783478;
        bh=fk3q0SD7ZYNA87G/Dcrxl2X5N5jP3w6Eef1FaSutJgU=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=V4klSZR9MQOoIdIDPALMV93dEG7tHobTfb6cNKXc9TUbDn8vz7tEjvZ9+wm4YWYgS
         6q4FDN+6acoZzX7bVS6GevF3mMwZjGRhGgnejkjVHsf1hpbEoG9IjG70Bh0rkmVHAv
         9h/wbDuzJdkUJB7/paEo5n1svZZKq/OPwZ9TxdNM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbAcs-1gkZtE0wyO-00bXCd for
 <linux-btrfs@vger.kernel.org>; Thu, 02 May 2019 09:51:18 +0200
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Unreliable btrfs_cross_ref_exist() check for self cloned inode due to
 lack of sub-extent level check
Openpgp: preference=signencrypt
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
Message-ID: <3dbf26b9-e975-4304-7129-0c7a1f864aac@gmx.com>
Date:   Thu, 2 May 2019 15:51:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WHhrpF3nlbdfu4SDOVjuPPBaC1aw0HWGh"
X-Provags-ID: V03:K1:m0n8xyp7Go3kd2t6QXmpoS/agp1jKxe1MTUjTdogG/hCF6JUOQI
 L6rsFGG9iXtv9PHYZVxtP2/l9H2yJ9fftldTAPT2q74oHLd9UOKVy889aCLAkzibr39gHk2
 ucVHqaIi2DjgwZc0bS+PpVgDA0ED/5YZnKkcU43fXofuHi2hrc7A22odlDSA/P/OTfzyjb/
 zNqkiaeAEuGJ+JZEaqGPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZTFAi37qQAI=:Nowb2870Bjp4iA5REOF2vq
 Ez70oAoIe3mwU8JFOoThAbrq+XYhHUWAHDgfnIOMTNXASsKFpUDKdZng6DjTZc25tkWeqNu84
 8r88uYDn2EllGCNnb+bChTbMR/+6UP3+G+lrFL8ehO2w37krGcqggj3mCxuy+mLzewLw1jCme
 8fSqFVo0GzTxeuUvp43RgWktZsfgK0xvg7rir9/BWFO0SCpkG9Ro6nV6YPmIAqhKJK15ljGZR
 k4AMInngsJdIVXyOBfyrD0vjH73BbsblQbQaox1LtBSs8AOsCUQA6dJw5K7tEVRUHqCzY3JBW
 8sRWca3K7A+AVwHa/stl5XuS23tkN0MZuvCq3m0loWrotO/T+sAzRMCT6LuF0CtxOTAaTfPak
 ldtSm4jd+qHzKSl9fln1TjCSej99rX7HEWZ2SgwewaiBisapHQF/CDVgUIAQ/IJtSUt2pwwYI
 4chkJTp/+w52LWjIUmJOvSvcLN71KiAlP+I8hWLQhneOhv5E97CmuhEXWgnpikwUggYIiseux
 D39qbSu5OZcih0J+JcO4Brsz/dTZyW/v2PbdOZL0paGm1WMxnIQjiVRybUwbdj3AfOaye2Y6n
 TErpU9uHI1AHjFdjtUqFScV+/N0YwExdGMpt/THzV5csRNIV3lKtIi+wkK7Tb0M1a7bbG/6NG
 EI1Ixjdri3NUpmSLMasOnQ0IeqEqnyei9dNH7RBldoyDcTKSsNOGGvDk3D5Zgr3AHs+7M90Rr
 11p87CEL1QMKnVVLa9wCbz/UKb2w7UiQWvHaHXo45KcMDs1LFSYZLMB6egRmhmIkVXRTXP2iX
 +eOqJ/4nhB3XeRfca0B54kSKwniYCcKZL33xH/ies6pum977WYx2jKR7cFiC6upt2hh6tk8On
 mkIsE1VRVcpSmO3cgPoSV/8xPfZj7UcuGB+cBAu83eFGy6kOAsuoekBsOgT2BW
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WHhrpF3nlbdfu4SDOVjuPPBaC1aw0HWGh
Content-Type: multipart/mixed; boundary="JA4jNCitYEXCjiToajI8OS6UUNOsitFaq";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <3dbf26b9-e975-4304-7129-0c7a1f864aac@gmx.com>
Subject: Unreliable btrfs_cross_ref_exist() check for self cloned inode due to
 lack of sub-extent level check

--JA4jNCitYEXCjiToajI8OS6UUNOsitFaq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

[BUG]
During the dig into the nodatacow miss cases, I find the following
operations can lead to unexpected CoW.

  mkfs.btrfs -f $dev -b 1G > /dev/null
  mount $dev $mnt -o nospace_cache

  xfs_io -f -c "falloc 8k 24k" -c "pwrite 12k 8k" $mnt/file1
  xfs_io -c "reflink $mnt/file1 8k 0 4k" $mnt/file1
  umount $dev

The result is the [12k, 20k) range get CoWed.

	item 7 key (257 EXTENT_DATA 4096) itemoff 15760 itemsize 53
		generation 6 type 2 (prealloc)
		prealloc data disk byte 13631488 nr 28672
	item 8 key (257 EXTENT_DATA 12288) itemoff 15707 itemsize 53
		generation 6 type 1 (regular)
		extent data disk byte 13660160 nr 12288 <<< not 13631488
	item 9 key (257 EXTENT_DATA 24576) itemoff 15654 itemsize 53
		generation 6 type 2 (prealloc)
		prealloc data disk byte 13631488 nr 28672

[Why this matters]
Some guy may just ignore this problem and call me overreacting, as long
as data is CoWed, there is no data loss.

But I could argue that:
- This breaks the fallocate behavior
  Without snapshot or shared, we should always be able to write into
  preallocated extents.
  But we get CoWed, means we are forced to allocate new extent, this can
  even fail at delalloc time and leads to trans abort.

- This behavior only happens after that self-clone.
  If remove that reflink call, everything goes expected:

    xfs_io -f -c "falloc 8k 24k" -c "pwrite 12k 8k" $mnt/file1
    umount

  Then we got:
    	item 7 key (257 EXTENT_DATA 8192) itemoff 15760 itemsize 53
		generation 6 type 2 (prealloc)
		prealloc data disk byte 13631488 nr 24576
	item 8 key (257 EXTENT_DATA 12288) itemoff 15707 itemsize 53
		generation 6 type 1 (regular)
		extent data disk byte 13631488 nr 24576
	item 9 key (257 EXTENT_DATA 20480) itemoff 15654 itemsize 53
		generation 6 type 2 (prealloc)
		prealloc data disk byte 13631488 nr 24576


[Cause]
It's directly caused by check_delayed_ref().

At delalloc time, also we goes into run_delalloc_nocow(), it still
causes btrfs_cross_ref_exist() to verify we're not writing into
shared/hole extent.

Then it calls check_delayed_ref() for extent 13631488.

Due to the last reflink, we increased one ref on extent 13631488.
The backref offset of that data ref is file_offset (0) - extent_offset (0=
).

So in delayed ref, 13631488 have two different refs, one with offset
8192 (at file offset 20K and 8K), and one with offset 0 (the reflinked
one at file offset 0).

Now in check_delayed_ref(), we will verify all the references to that
data extent has the same backref offset.
But we have one ref with backref offset 0, not the 8K we're expected.

Then check_delayed_ref() thinks we're writing into a shared extent, then
falls back to CoW.

[Fix?]
For this problem, we need sub-extent level shared check.
The current delayed ref with on-disk extent tree can't provide such
facility.
Any idea on this problem is welcomed.

Or nodatacow is always a second-class citizen in the btrfs world?

Thanks,
Qu


--JA4jNCitYEXCjiToajI8OS6UUNOsitFaq--

--WHhrpF3nlbdfu4SDOVjuPPBaC1aw0HWGh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzKoXAACgkQwj2R86El
/qiNdggAn6VfP/HQ67vzHOPd34H59X8yjbO2rY6buixDA70Ok1i5WWDmvCJVB9uL
3TDy+YWjDFOW/ji5AuLSj3nAPuovUl4VEIm/yMS9E9MoBH8Oh6hI8twkNfTsq4sE
98nKLTje8L0dScRU2vkzUuIdRczDlqTo9o1xE2ufoBdCVU45Zsb675xurLEeMPA+
XyB6EN7yGgg05LZ/WGAgLjA3rod7TYrnUfur6Kf0kp7EfbGCGlyHw8FIzCaeZ+B5
Pu2Tf90QAvc9VunPEf9xVfYlp6hJnfoYbHwIUtevjZZVNL8/51isAU2k2BAV0Uye
twcDtf0jl4Cwwyk3VOQtqr+cd6dhBw==
=/B73
-----END PGP SIGNATURE-----

--WHhrpF3nlbdfu4SDOVjuPPBaC1aw0HWGh--
