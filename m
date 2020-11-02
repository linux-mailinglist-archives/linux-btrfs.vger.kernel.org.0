Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCA62A2C61
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgKBOPp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:15:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:59651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKBOOq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604326481;
        bh=IzjcC4kATq0IqMT8QpSmgAh4+mP7mYyICjfdZT/vgb0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Twok+SRFzRZj3uL1WN2lTJ/INvEC5uaB0H6xwX+8MU1poFVVhPFbf3jbAFwxySvLS
         qV8FVWuLnI/yc/oHgNRTya307mTZ7JF1vJdYy7tPVdCGSXjc2LsA6/cmwSiOQsDWit
         2jTZ5Z8pg/4wIJNtMWJ8YTkagUMeqpT/iyDnCWEU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFKGP-1kXgvw0Peb-00Fh4A; Mon, 02
 Nov 2020 15:14:41 +0100
Subject: Re: [PATCH] btrfs: fix build warning due to u64 devided by u32 for
 32bit arch
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201102073114.66750-1-wqu@suse.com>
 <20201102135409.GA6756@twin.jikos.cz>
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
Message-ID: <e2a5dd5b-a77c-1de5-08b1-67574beba5f0@gmx.com>
Date:   Mon, 2 Nov 2020 22:14:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102135409.GA6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ruClRrklmMnEy1oSFL6nvaHH2u8ZWrX0V"
X-Provags-ID: V03:K1:OkY9iEA2m0BPtdk9g0BZvk6Wkm9ZjjlPwW6pIlog88RNa4NtguR
 rsELymyc96Cs89/J7Wu5SW3JmZa+yzsKfT66ffsG3FXioF8DUG5uHqeo7HGuni73EKxtc5I
 bx9VFLi9KzjvJykgzOksm9tBnFDDIcWPbG+KU3xka8KxvNK6YslcsZZ7WqsjQH17LuYNXwq
 UhaHAZFGgMlZ4djsnZMAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FnTgFdFJPL8=:pjuzbtUgVI2HeTl2mnv4fs
 eB+a68I6EYXUh8/+kUhQ89mdUEH0a4pbm11h/MI+fdNmPNiVQCzK+wZiBTBSdrhuiOpvsDNee
 Hh8lnqmF6maRbgTxydlwhnLvJgbHigx0RCOGqngub7ZLeuJHhyiZBSJ8NwtHyN4bdIKEEomqS
 3nTUWcAX++rMLizjCkcL2cANWTcRd7pGtcRnGxIxaJNXeGDPzwQB6mt64/7mp6kvLaSZi/ihQ
 VmI9fg/SgZHuuyPygU3VUdvnaIulYSsbGrvoerIR3yuOpik58Jym07cKZ+ueXpTyxlb3XWPYw
 WLGfQ0rRuo97PNPQKT8CKzG1EGl4zP+oBi9GJg0nfOb8MK9AFBeTSQi8jLMvFiXJGln7bgUgL
 EdTDEAXmYRNYMPEzZGOmXiELFHk51qCFsJXLLdq+8CLs8mQOwXXj14AM0CjbLpcS3o7a81FxA
 lfw7EgBOHzLVZyWu3yn7HxjLintCIqWSdBaifXLP0w67lYj+qULnpcH/QVPNJnZdVxDw6MBm1
 aIH0pAKxrKMfo2r5qFgQiDs8r2QVAm0oMWzZ0tRyfO2s7J7dkcZPva23bLMQBo7Mx8R0PdALV
 kfw2iPmwQ4mwECT06tVhGjFQrhBeWuR7SOGAQmijMRjyORfXM1my68wghH9lpNG88imzUpir7
 y/VhiHpGY18PvL/bQn0gv5ynR9kl8e7LJvNYZkkgy9abj2FLxw5rNioTcKEJichWOcbnJrO9c
 /crjxu55zCp3tge4FsYfPSpRloZhv5eRolgOniPZH+nH47bntCuArCAg75KjEDEgRVBo+oR3+
 AzGwrh4P95KhpUhtA5QYbN7H0Bj6k907AUkjwsvkzj4LtLUXF1BQB9NYCsE1FzIKBS/9dnB23
 2MeVgi4NMaeHJYBSLiBw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ruClRrklmMnEy1oSFL6nvaHH2u8ZWrX0V
Content-Type: multipart/mixed; boundary="DRIAMAMRzYiAkLvRwvYbb8v3Jy0QHi2m6"

--DRIAMAMRzYiAkLvRwvYbb8v3Jy0QHi2m6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/2 =E4=B8=8B=E5=8D=889:54, David Sterba wrote:
> On Mon, Nov 02, 2020 at 03:31:14PM +0800, Qu Wenruo wrote:
>> [BUG]
>> When building the kernel with subpage preparation patches, 32bit arche=
s
>> will complain about the following linking error:
>>
>>    ld: fs/btrfs/extent_io.o: in function `release_extent_buffer':
>>    fs/btrfs/extent_io.c:5340: undefined reference to `__udivdi3'
>>
>> [CAUSE]
>> For 32bits, dividing u64 with u32 need to call div_u64(), not directly=

>> call u64 / u32.
>>
>> [FIX]
>> Instead of calling the div_u64() macros, here we introduce a helper,
>> btrfs_sector_shift(), to calculate the sector shift, and we just do bi=
t
>> shift to avoid executing the expensive division instruction.
>=20
> Division is expensive but ilog2 does not come without a cost either.
> It's implemented as bsrl+cmov, which can be also considered expensive
> for frequent use.

You're right, ilog2() is also expensive.
For our usage, what we really want is ffs(), which can be done with
hardware support to reduce the cost.

Thanks,
Qu
>=20
>> The sector_shift may be better cached in btrfs_fs_info, but so far the=
re
>> are only very limited callers for that, thus the fs_info::sector_shift=

>> can be there for further cleanup.
>>
>> David, can this patch be folded into the offending commit?
>> The patch is small enough, and doesn't change btrfs_fs_info.
>> Thus should be OK to fold.
>=20
> I have sent my series cleaning up the simple shifts, for the sectorsize=

> shift in particular see
>=20
> https://lore.kernel.org/linux-btrfs/b38721840b8d703a29807b71460464134b9=
ca7e1.1603981453.git.dsterba@suse.com/
>=20
>> Fixes: ef57afc454fb ("btrfs: extent_io: make btrfs_fs_info::buffer_rad=
ix to take sector size devided values")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/ctree.h     |  5 +++++
>>  fs/btrfs/extent_io.c | 14 +++++++++-----
>>  2 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 8a83bce3225c..eb282af985f5 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -3489,6 +3489,11 @@ static inline int __btrfs_fs_compat_ro(struct b=
trfs_fs_info *fs_info, u64 flag)
>>  	return !!(btrfs_super_compat_ro_flags(disk_super) & flag);
>>  }
>> =20
>> +static inline u8 btrfs_sector_shift(struct btrfs_fs_info *fs_info)
>> +{
>> +	return ilog2(fs_info->sectorsize);
>=20
> This has a runtime cost of calculating the the ilog2 each time we use
> it.
>=20
>> +}
>> +
>>  /* acl.c */
>>  #ifdef CONFIG_BTRFS_FS_POSIX_ACL
>>  struct posix_acl *btrfs_get_acl(struct inode *inode, int type);
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 80b35885004a..3452019aef79 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -5129,10 +5129,10 @@ struct extent_buffer *find_extent_buffer(struc=
t btrfs_fs_info *fs_info,
>>  					 u64 start)
>>  {
>>  	struct extent_buffer *eb;
>> +	u8 sector_shift =3D btrfs_sector_shift(fs_info);
>=20
> And each use needs a temporary variable, where u8 generates worse
> assembly and also potentially needs stack space.
>=20


--DRIAMAMRzYiAkLvRwvYbb8v3Jy0QHi2m6--

--ruClRrklmMnEy1oSFL6nvaHH2u8ZWrX0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+gFEsACgkQwj2R86El
/qhaFQf/fpka+fZlR0noOYzBdFLVva/QaK6vn7D/xE8GECObVM2MmsSBfsv9SdY8
ESiXwjtq5u95tF+8Ks5Ltsxq/swnngrNMM5AFpuQdf9xjiDe2GPJEWxSxtAh6xFf
rgfIr5DxWWLTLrwv6xDDzqA/Oweic7qSip63+f9uDwPx+3VGXkhVgDodylwBnNfT
+WaXDfW4SfPECUdHDARWDssdIGWQj8MTjORD8kgXtxFrW5usJQCqClItMZ53NNbO
kqdaA82XFjK3eqTpc837bwrdmdRntkhNk/hJpoYqbhjd51BUfFNdJ269UDgrOIeB
QXUZ6hCCIYvwT3wwgilFBq8/kNpZJQ==
=YlQd
-----END PGP SIGNATURE-----

--ruClRrklmMnEy1oSFL6nvaHH2u8ZWrX0V--
