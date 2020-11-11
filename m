Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95042AE496
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 01:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbgKKAFM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 19:05:12 -0500
Received: from mout.gmx.net ([212.227.17.20]:36187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732194AbgKKAFL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 19:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605053107;
        bh=UfkhApbqtTyKbeQiID8OsIti/i6qf7OaVnznVmuWH0Q=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=k6mKr2lmo6dDS/d7M0T9oo/SX2YTrnslUBi4dziHVsi7qT7gJaVovfpfZRwQURAtf
         DrQy44EWISNzEWyKw7huFggF/GOxwiEGpaJbycatfvVQlrNMS/3oexjUnvvTVk3tA3
         +lvV78k/Hg6bB1Wwzvmi7Dlhaga8brYBfQcDX/YM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHGCu-1kYDly2X32-00DE94; Wed, 11
 Nov 2020 01:05:07 +0100
Subject: Re: [PATCH v2 2/2] btrfs: pass disk_bytenr directly for
 check_data_csum()
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201110020909.23438-1-wqu@suse.com>
 <20201110020909.23438-3-wqu@suse.com>
 <19a1507a-2a9e-805d-3b0d-66609f07decb@toxicpanda.com>
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
Message-ID: <03ee7def-b743-249c-bbf0-3db350b1bd2e@gmx.com>
Date:   Wed, 11 Nov 2020 08:05:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <19a1507a-2a9e-805d-3b0d-66609f07decb@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ctyUqletjC3LxyjvLsJFUJ1TsLIOi9omi"
X-Provags-ID: V03:K1:GUrMeeikOe2gPXe8/ly5VNDEasuHnPPaTTcPZlQJNBof8qQZMyy
 LcsKmBDeqQ4j1L+ZggFRCq2xXYq46L36dOrCggy4VFUcxYoLZTp2stj79XkurCX4DoNTlYn
 w3A5ZbblrD1Q6Yq0GxGMyWgirvyZB2rQiGBYssjvY0M9O0o6HrHXoIJXeus4ZFx7jbsdLMu
 Ji3fde35M/qboaxiXJZ8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Jo1OLkwK5E=:IJ0L2Pk2KDkhHHGHivOtcU
 m/LzWLX62b+JPmAnSzoa0VBlpzpwE/KTnMZVVnI1fBwfvrspX2f1ZkAs2EUG3iPY08NKievje
 VCbD7FyFcSS0hzjVodRcRx7+bm41gL7VLvl042wr+KRrjfBlZcLHNJ2NucpuXswWe0o6umlT8
 WsSrowEhmNpux5ZVR9a5o73G7EJKECVREG94s/V5WsA7cwYIRnaehu7Ahc/Sd3hiPEujB6X+o
 y2s9BpYsv/a7a2zSNLpJCwgPXbEPmi0RPnvHzLdjJBLA990DG/CqIekFekng3oAGjbQFIjiOe
 b2nJFk5UxZSD4Hl+DI0e4AcFZIbk1dc4QUhrSb8AHYhS4OgCRBBYGojyIwJM3doE7DyCaOduN
 JmD1Mh5NkAX0r8DRJXB2H6kfIjSuVdWKQ7KW7wa+yfvHc2aJChDJxsfguBiPGES6SHdUu5EC5
 Ch/mI6WxwGlPxypVdaXzoXYlZJw4JcFvuYj3+UqX89fpISZGrjiEpOmCozUwOuRLQFUAXNwBT
 6PdtL4TrCd2d9Ec7BmVN5fInc+u1h4LFGJKAsHDJxo3V15wJmKEPSenx/yNRtq7IDdaE8VSW6
 LGgfa4VN5OPJMl9V24d/IkpHplsNQUn7uDdOhgyWn5YGd7z7y5OPjdocdDP/zZlqZJfsg427x
 FCZzW2Sq/tvQJxQH8fRkuH4XZs7OzeHNcBSqHD1gtT95Do0H0X34/oj1zAmiiKjnONYijDALH
 ZoQUZWcRHLqvFa0wpfXFPp+yScJkkJF5i4DR1tixSKlNTBUWUnUJG5TSHT95sV1+68rvLGhMw
 SozoT5zzI/SfkuhHiejXGlkjwPIdFz9+M9GW3/RWF37JKkDfj8ueRVubfP1P7qhOkbwIDoBh8
 K7y2k4Gkx1nbvgBEnMcQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ctyUqletjC3LxyjvLsJFUJ1TsLIOi9omi
Content-Type: multipart/mixed; boundary="4XxIXVaEv6IdZOg4Kp81aDWgrVvoi3qhw"

--4XxIXVaEv6IdZOg4Kp81aDWgrVvoi3qhw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/10 =E4=B8=8B=E5=8D=8811:30, Josef Bacik wrote:
> On 11/9/20 9:09 PM, Qu Wenruo wrote:
>> Parameter @icsum for check_data_csum() is a little hard to understand.=

>> So is the @phy_offset for btrfs_verify_data_csum().
>>
>> Both parameters are calculated values for csum lookup.
>>
>> Instead of some calculated value, just pass @disk_bytenr and let the
>> final and only user, check_data_csum(), to calculate whatever it needs=
=2E
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/extent_io.c | 14 ++++++++------
>> =C2=A0 fs/btrfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0 | 26 +++++++++++++++++=
---------
>> =C2=A0 2 files changed, 25 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index bd5a22bfee68..f8b5d3d4e5b0 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -2878,7 +2878,7 @@ static void end_bio_extent_readpage(struct bio
>> *bio)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_io_bio *io_bio =3D btrfs_i=
o_bio(bio);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_io_tree *tree, *failure_t=
ree;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct processed_extent processed =3D {=
 0 };
>> -=C2=A0=C2=A0=C2=A0 u64 offset =3D 0;
>> +=C2=A0=C2=A0=C2=A0 u64 disk_bytenr =3D (bio->bi_iter.bi_sector << 9);=

>=20
> This doesn't work, bi_sector can be remapped based on the underlying
> device, and thus can be different between submit and endio.=C2=A0 To
> illustrate this point, make 2 partitions on a single device, mkfs the
> second partition, and then run xfstests with this patch applied, all
> sorts of fun will happen.

Then it still doesn't matter.

The important thing is, we only use that "disk_bytenr" to calculate the
offset against the beginning of the bio.

Thus the result is the same.

Although the new naming would be a little confusing then, it's not
really disk_bytenr used by btrfs.

In that case, if we want (and I believe we want) real disk_bytenr,
btrfs_io_bio would be the correct location to add this member.

>=20
> In fact we should probably add such a test to xfstests to catch anybody=

> relying on bi_sector to stay the same.=C2=A0 Thanks,

Thankfully, not for this patch.

Thanks,
Qu

>=20
> Josef


--4XxIXVaEv6IdZOg4Kp81aDWgrVvoi3qhw--

--ctyUqletjC3LxyjvLsJFUJ1TsLIOi9omi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+rKq8ACgkQwj2R86El
/qgnRgf/SNq1yg32xq9AbFhUvddi7Pu/BQiL8G6xLdmJKBGJW2KWUb4FmgSOj1mM
S3ec4D8Kt7/NA+vgUH6P8QrEGyWpYqMGfmSOV2g8EsBUGMVLmLUwp49XEVhQp2eM
b2dzsGu/dTRvEMSaMfZqshQFopzFB4QDAs92uGBO66vKfpwpz868M7wOzPSB52xv
Xw7e2ghkZLDB/BKOCnEbGqTc4rv7S3nQkDHict0lBJYNbifVjicVAR+hL9ihZ0/l
uSAK9SVfrZCXDVdaKHVXJS8YP9Nzd59WOQiMXdmmxi4XEX0ORHdbSYuwaw5l9Pmy
7NOf0GRd0O2mMuJK22szL0hRvNR/Ag==
=2hp/
-----END PGP SIGNATURE-----

--ctyUqletjC3LxyjvLsJFUJ1TsLIOi9omi--
