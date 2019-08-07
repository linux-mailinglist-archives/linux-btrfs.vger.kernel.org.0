Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 281E684448
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 08:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfHGGI1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 02:08:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:35105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfHGGI0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Aug 2019 02:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565158097;
        bh=rfqJeeuyIJjfzvuxuLb9VUtjv+SLTqGc7ArzDK9Fwog=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kjDPTBlQINtRV5wojIKTwK9uVENChC8vA2Aqy6lHayu6XZsY9MNDRMLA2TASW8rWw
         y8Yg7LmvfoIqrzEAHi0JEopgBrq3i5uK/RtjNATFWcHP5jFusetV24O2M2l7gLKavo
         tyT3cSFh+mswcMal5RK9qj/8z8znJAImXP7kvoDE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LaooK-1ib8OG19Ee-00kR1N; Wed, 07
 Aug 2019 08:08:17 +0200
Subject: Re: [PATCH v2 3/5] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190725061222.9581-1-wqu@suse.com>
 <20190725061222.9581-4-wqu@suse.com> <20190806135818.GK28208@twin.jikos.cz>
 <1ee4b55b-8453-e07f-70dc-fa56eb15e0ad@gmx.com>
 <20190806174733.GP28208@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <91f3b08c-ab2d-1b7f-16b3-239083aa6da0@gmx.com>
Date:   Wed, 7 Aug 2019 14:08:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806174733.GP28208@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Q5Gz27ILuJ2MmxFQGjTp6MisfxAYjkOY9"
X-Provags-ID: V03:K1:JPAr8Of41TpBJHUgdVjbqqs8+wfWV2/98fjTXTNFY/ENU3iCHD/
 eHWbQ9AoojQrKPTqMy6BRx6btx0+ThZSfJEvE+rJlp+L9P9kVmpzgSsKfVEAQdnTNEBFsdg
 Sh38wJMsRwXgmDUryLwDSRgbOrIcOIzfiJSDJDMUkgiQ6Q98ZtbbddaJZ8xRwj26v7GgIeA
 Zz2JkuP9Y4+O5f7CTjrWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NyaJIhEWJzM=:Xbpw0jp1pqv4T1wCVQ51Oh
 2bI1tNyOl9/esrJ49u88IQqgd3hkmG9NasBQmFDtl3kKuUrvts9NKn7FmIvZJmAOz5MvW9EYT
 uyF+H9gqKqfeoJ9DtqFfBOXvFxdaYM51EzQeh7ednbf/tnoOAwYhB+4KTtW9gwEpCY1pXAfUZ
 AF0NLe2cfa5WjxAb0cUnxHGD0qJIIV5It7jP05AagkbAyX8AzWpjrXXn2eO8g5SQLzzWkufMf
 SI57qVFIrLchDpoa6S+/Yn7T2uiJFlFrMTkoP7BNe3exS+u/Vd9AeFMiH/k7X46a5XDBYsiIi
 rO7voWtgdzNIFhtnt2Ls9sPBXV0E5jX3mGaM2E9As21yPLyMKAmE9yyE4Ljyn349ThU6PP9bl
 G7Yac7ktwg8uAT4NDcG7YZ9Uzhg4tJtCnBEzcJrIIFnpgWhplFSbnLQO1WT/AHsCKTE1L7B9t
 sAbu0ftolOHhpXoZLSoa24JjqrgKTSI0oe/HD2RCyi3S3LbIRxBLl8XDMJf2cl71OijcscI09
 JYPY3bBGWjkmqGQJ0jlWK9Mram2U5q4/x5bPbRsy5/ON7pzcm6cVIYPdbdZdQSXfEwnq0IgkE
 cACKGjTbrvgvis4sM6GBQNlcp5mnwNcMUIeA/sVielH9FdOqAKP1T+4+0A0x0zVTmzRUnwLBX
 hbdlinn86itSiQ0hFMJF669nVpUzjvBhQiDqECOOwEnsqWeA9e47Luq0Kp6GRljH1MumV1uHn
 DZiNwH9M9jTslAxui0GExeYgQ7eDMsLqrCBp+64RdctvQmpO7jAczjZAfj4YrVf8icEh/xV7/
 FTfYY6zYtw4lg5XxhRlS1XWdO2eVx/lGt81BWKxJcRw9T39BX4LFCXbjIoJPlJ88IvS0t+dLD
 76YU87DstWUb23xkk2CeHe1DY4S9jEq4US1iKfWKxD5HUthU+xokqjC2VigW8P/XupdzLUFBg
 FSzd10lyp9aRoDkCD4mYkjnfO8TczZ553DEBlwCP/qXGEvqyhzdHujpi4hPg2klKjrHgA6Zf2
 vByOaZITQy1wzQZ85DuOcNVctkEYy7TRZKHNl4De5uG8VbZLqeyuSgFmciJUaDscs/R9RA2M2
 rZG5Y6oK48ltub0/WV4E6BaCXKimlRGmlAQ8Keiqzkbiw4Cvp5VMWFyBg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q5Gz27ILuJ2MmxFQGjTp6MisfxAYjkOY9
Content-Type: multipart/mixed; boundary="TT0fT0gi6TgMRSqJB4oO1XSux5Kjlgard";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <91f3b08c-ab2d-1b7f-16b3-239083aa6da0@gmx.com>
Subject: Re: [PATCH v2 3/5] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
References: <20190725061222.9581-1-wqu@suse.com>
 <20190725061222.9581-4-wqu@suse.com> <20190806135818.GK28208@twin.jikos.cz>
 <1ee4b55b-8453-e07f-70dc-fa56eb15e0ad@gmx.com>
 <20190806174733.GP28208@twin.jikos.cz>
In-Reply-To: <20190806174733.GP28208@twin.jikos.cz>

--TT0fT0gi6TgMRSqJB4oO1XSux5Kjlgard
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/7 =E4=B8=8A=E5=8D=881:47, David Sterba wrote:
> On Tue, Aug 06, 2019 at 10:04:51PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/8/6 =E4=B8=8B=E5=8D=889:58, David Sterba wrote:
>>> On Thu, Jul 25, 2019 at 02:12:20PM +0800, Qu Wenruo wrote:
>>>> =20
>>>>  	if (!first_key)
>>>>  		return 0;
>>>> +	/* We have @first_key, so this @eb must have at least one item */
>>>> +	if (btrfs_header_nritems(eb) =3D=3D 0) {
>>>> +		btrfs_err(fs_info,
>>>> +		"invalid tree nritems, bytenr=3D%llu nritems=3D0 expect >0",
>>>> +			  eb->start);
>>>> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>>>> +		return -EUCLEAN;
>>>> +	}
>>>
>>> generic/015 complains:
>>>
>>> generic/015             [13:51:40][ 5949.416657] run fstests generic/=
015 at 2019-08-06 13:51:40
>>
>> I hit this once, but not this test case.
>> The same backtrace for csum tree.
>>
>> Have you ever hit it again?
>=20
> Yes I found a few more occurences, the last one seems to be interesting=
 so it's
> pasted as-is.
>=20
> generic/449
>=20
> [21423.875017]  read_block_for_search+0x144/0x380 [btrfs]
> [21423.876433]  btrfs_search_slot+0x297/0xfc0 [btrfs]
> [21423.877830]  ? btrfs_update_delayed_refs_rsv+0x59/0x70 [btrfs]
> [21423.880038]  btrfs_lookup_csum+0xa9/0x210 [btrfs]
> [21423.881304]  btrfs_csum_file_blocks+0x205/0x800 [btrfs]
> [21423.882674]  ? unpin_extent_cache+0x27/0xc0 [btrfs]
> [21423.884050]  add_pending_csums+0x50/0x70 [btrfs]
> [21423.885285]  btrfs_finish_ordered_io+0x403/0x7b0 [btrfs]
> [21423.886781]  ? _raw_spin_unlock_bh+0x30/0x40
> [21423.888164]  normal_work_helper+0xe2/0x520 [btrfs]
> [21423.889521]  process_one_work+0x22f/0x5b0
> [21423.890332]  worker_thread+0x50/0x3b0
> [21423.891001]  ? process_one_work+0x5b0/0x5b0
> [21423.892025]  kthread+0x11a/0x130

Haven't yet triggered it again, but indeed looks like a race.

I have only triggered it once on my old host, while now migrated to a
new system, it looks my new setup is sometimes too fast to trigger the
race window, sometimes even too fast to allow btrfs replace cancel to be
executed before replace finishes.

Would you please try the following diff you could trigger it more reliabl=
y?
(Which moves the nritems check after the generation check)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a843c21f3060..787ebe4af55d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -414,6 +414,15 @@ int btrfs_verify_level_key(struct extent_buffer
*eb, int level,

        if (!first_key)
                return 0;
+       /*
+        * For live tree block (new tree blocks in current transaction),
+        * we need proper lock context to avoid race, which is
impossible here.
+        * So we only checks tree blocks which is read from disk, whose
+        * generation <=3D fs_info->last_trans_committed.
+        */
+       if (btrfs_header_generation(eb) > fs_info->last_trans_committed)
+               return 0;
+
        /* We have @first_key, so this @eb must have at least one item */=

        if (btrfs_header_nritems(eb) =3D=3D 0) {
                btrfs_err(fs_info,
@@ -423,14 +432,6 @@ int btrfs_verify_level_key(struct extent_buffer
*eb, int level,
                return -EUCLEAN;
        }

-       /*
-        * For live tree block (new tree blocks in current transaction),
-        * we need proper lock context to avoid race, which is
impossible here.
-        * So we only checks tree blocks which is read from disk, whose
-        * generation <=3D fs_info->last_trans_committed.
-        */
-       if (btrfs_header_generation(eb) > fs_info->last_trans_committed)
-               return 0;
        if (found_level)
                btrfs_node_key_to_cpu(eb, &found_key, 0);
        else


--TT0fT0gi6TgMRSqJB4oO1XSux5Kjlgard--

--Q5Gz27ILuJ2MmxFQGjTp6MisfxAYjkOY9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1KasoACgkQwj2R86El
/qgV5ggAo5sfbqTLn/qEHzIgvSVvpS8t9hI8VOyy3eZB3mzQHmzsEOJSUfAqs3L7
KttbHNn4Ps1cLT/cKTKl9o2ifdYgGqkU998oqxe1jPJ5oJeP68NcXdh6xK42SIs7
iOgRgrn3yaThQBO4vPafqDa2UY5GRlKGrnMuyOah4wQZ/NqcD6NPc2ARN8D0tEkH
DpBFnsDJHL6N6uN0s+yy6Wmu4NRv0l3Unl8Q8k0dz7ewnF3e0uAek3SgpA3XC6LA
jbX6gy7U5oMhg7f9YazBgpQQJW5+Lu/Ju+pRyW9Z26KVj7R8WZ2ndwxoQDWErUxy
RufqFgCF/uyq2Z4P/z16GrBtJgiDIg==
=NmX4
-----END PGP SIGNATURE-----

--Q5Gz27ILuJ2MmxFQGjTp6MisfxAYjkOY9--
