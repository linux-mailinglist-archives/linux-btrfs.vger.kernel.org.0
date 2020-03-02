Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A901752C9
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 05:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgCBEpv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 23:45:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:57179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgCBEpu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Mar 2020 23:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583124343;
        bh=2N7sL/Tf3xieCCMpe2h0/IO5fwNPYD3Wr3Gsl+LPPLw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SCNH9hJxzAM9mLqGj9jV2FXeanl/El/FBzLGZqBj+rOUkaS81BfrvR5uu7bJuSD0W
         0W2UNT0Fw1NUVux0u+mh+ZR5ytyjJyiVlquEvc6JBMaDlespgxhzISZ30WeGKkr+fM
         lGjgbNLpNGSeU7vU0g3HT9dMDZRDD6BGdCHrj9Ag=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mzyya-1jLDcm3KEw-00x0T2; Mon, 02
 Mar 2020 05:45:43 +0100
Subject: Re: [PATCH] btrfs: disk-io: Kill the BUG_ON()s in write_and_map_eb()
To:     Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20200302014153.33122-1-wqu@suse.com> <m2r1ybctt9.fsf@gmx.com>
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
Message-ID: <f4f1e8da-8a3d-2413-1c83-6657d86170eb@gmx.com>
Date:   Mon, 2 Mar 2020 12:45:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <m2r1ybctt9.fsf@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="owcKkZC8ufUk7R2Bv8IlcG1tBdOwBh8Bm"
X-Provags-ID: V03:K1:OJnbrRXc4hysp24pDq5ayBcYoj+fprvkDD1/OfpZ86YkTgdBeNG
 YKrJXfkkmGMtPktOIcGdj3A9OsgCnEPW4WyZFdZd62d70t0U6D/JJ/hK0w5JMUBpThWqGSD
 OI+RMaZaGLEGs/EqescoG7ZXCXQgy4/2ODiQWxfKcQXalRi9qlsASlujEAPFdF7j4SquDQ5
 lVv2EdsNny299XBIV0PdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PAwQYtChR2c=:CIgDzOcUXVB4r9m5kPWAEs
 n8JubUEBKjn82U7ofh07kQk1vF8CYXcEZi6RqtG/8AZPHXqviRO49HSn0zn4sqPNTSi2PPA5r
 JBdHyLCQiegqFF3eGVVkIen80nlOtFlxRImR526gqVtB6TxHEVY4LSQA/Qb/q5P45A3COvXku
 1afCuiMLdQO8evj73FzIKeYEmLAl/E4hHfqvwM8HL10kSiLgoHPN9mhMzySUTZ7bAI0YsoDpO
 o/b26W8i2M55uzIgMtvjCANy9vplWQ9Y0H8RYWLgNvOfrG36TtHrjuJRkSgMY/834jVdqQWvg
 OivryeqVED8J74xAGIMubflI1Wq2zdOsiRzxHoQ6Sec0bsdvRLbf70JDst1uwBIBM/bOFTpzl
 DgMFoZcnX5t5LWOYvtsfkllXJP+s5+bu0Kf8+5gP5DFZg444DXWWZXevNL9Q3ZHqQn2OaWqjT
 /pEcNR6C9d4xn8qm6yixutbTaQO3bC34S8QLmmvjhn9i640unCnrpotBiZOJYkX7VNJi4y7Gk
 cfnKxH3x79XAGAtSZoyI7+IP+1IVXK4QRYw7YvoNm7N4ggtpBVi9w6Zzu5p9sVJn0kL1qLJ9o
 JFLaYX1AbekvRf+XK16veduhBiCov2aOFsDK5yde8pKLLLwb2UWRoxmiYL+j4CBEnHHIan10R
 0omDxOcym50tBLY7ice4U4y3AeZgpazPcEVr/K/LGSW4j09OFd7KKYV8/fMjgGm4uOQXSsbnr
 fofPhR7ENiTnl36l3TdItsstmRGCl0qmUzb+22aEYUUXOK4oX36cBjfqm3wtsY2zfP04n11xO
 8jbQX428gUjBOhUkXI2PoIuP0Z0tVZuLij5NFZs1smr3m7oK+RIIi6S9rnMxlFOHwSgWwf9pm
 BXuW+Pi2Yw+4jkwzYjUHH/w645DcA9S0ak9pGTf7UZm00Nj1Ec+ztc0RRyLsKTIfSPfxWR3oE
 TcY0zEVgNtNzBNUuFciDDWsLRadXGpbchJEAzAjbyXlV77P+U6EI21Z3LmxsrqeOqnCeXj7Cd
 MVe40B5OhxJZnbOivNQp5DyelmnO8XkAqwpwozmsnmsXioRAjIehY1EFplR79H2CmetXD8SQC
 tENa7N5sO1LSgtN+hwuskqgnzDp+pAvW12TdRpnR5zDPqLN+10xlY3g+2VNBuzs9DJwASVJ+P
 +U61pkVrhK9neF4zRp24GbYeovawvuGdHTn8ED9M9iMTeh8FzhWlh6EuhOaQi8wuBlbFW9iab
 a9ettU5dTVyN0+GDS
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--owcKkZC8ufUk7R2Bv8IlcG1tBdOwBh8Bm
Content-Type: multipart/mixed; boundary="fqZvWMFfMUZ3P1L5IUGqwFbFX048j4D0q"

--fqZvWMFfMUZ3P1L5IUGqwFbFX048j4D0q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/2 =E4=B8=8A=E5=8D=8811:35, Su Yue wrote:
>=20
> On Mon 02 Mar 2020 at 09:41, Qu Wenruo <wqu@suse.com> wrote:
>=20
>> All callers of write_and_map_eb(), except btrfs-corrupt-block,
>> have handled error, but inside write_and_map_eb() itself, the
>> only error handling is BUG_ON().
>>
>> This patch will kill all the BUG_ON()s inside
>> write_and_map_eb(), and enhance the the caller in
>> btrfs-corrupt-block() to handle the error.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com> ---
>> =C2=A0btrfs-corrupt-block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 9 ++++++++-
>> =C2=A0cmds/rescue-super-recover.c |=C2=A0 3 ++-
>=20
> So may the subject be prefixed with "btrfs-progs"?
>=20
>> =C2=A0disk-io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++=
+++++++--- 3
>> =C2=A0files changed, 33 insertions(+), 5 deletions(-)
>>
>> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c index
>> 95df871a7822..3c236e146176 100644 --- a/btrfs-corrupt-block.c
>> +++ b/btrfs-corrupt-block.c @@ -771,8 +771,15 @@ static int
>> corrupt_metadata_block(struct btrfs_fs_info *fs_info, u64 block,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 bogus =3D generat=
e_u64(orig);
>> =C2=A0btrfs_set_header_generation(eb, bogus);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_and_map_eb(fs_info, =
eb); +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D
>> write_and_map_eb(fs_info, eb);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_extent_buffer(eb=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) { +=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errno =3D -ret; +
>> fprintf(stderr, +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "failed to write extent buffer at
>> %llu: %m", +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->start); +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret; +
>> }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break; } case BTRFS_M=
ETADATA_BLOCK_SHIFT_ITEMS:
>> diff --git a/cmds/rescue-super-recover.c
>> b/cmds/rescue-super-recover.c index 5d6bea836c8b..62f4f7754720
>> 100644 --- a/cmds/rescue-super-recover.c +++
>> b/cmds/rescue-super-recover.c @@ -276,7 +276,8 @@ int
>> btrfs_recover_superblocks(const char *dname,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct super_block_record, list);=C2=
=A0 root =3D
>> =C2=A0open_ctree(record->device_name, record->bytenr,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 OPEN_CTREE_RECOVER_SUPER | OPEN_CTREE_WRITES); +
>> OPEN_CTREE_RECOVER_SUPER | OPEN_CTREE_WRITES | +
>> OPEN_CTREE_EXCLUSIVE);
>=20
> Any explanation about this change?

My bad, unclean base.

I'll resend the patch.

Thanks,
Qu
>=20
> Thanks
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (!root) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 3;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto no_recover;
>> diff --git a/disk-io.c b/disk-io.c
>> index e8a2e4afa93a..9ff62fcd54d1 100644
>> --- a/disk-io.c
>> +++ b/disk-io.c
>> @@ -487,20 +487,40 @@ int write_and_map_eb(struct btrfs_fs_info
>> *fs_info, struct extent_buffer *eb)
>> =C2=A0=C2=A0=C2=A0=C2=A0 length =3D eb->len;
>> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_map_block(fs_info, WRITE, eb->s=
tart, &length,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &multi, 0, &raid_map);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errno =3D -ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed to map byten=
r %llu length %u: %m",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb=
->start, eb->len);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (raid_map) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D write_raid56_=
with_parity(fs_info, eb, multi,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 length, raid_map);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(ret);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
rno =3D -ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "failed to write raid56 st=
ripe for bytenr %llu length %llu: %m",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 eb->start, length);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0 } else while (dev_nr < multi->num_stripes) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(ret);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->fd =3D multi->str=
ipes[dev_nr].dev->fd;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->dev_bytenr =3D mu=
lti->stripes[dev_nr].physical;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multi->stripes[dev_nr=
].dev->total_ios++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_nr++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D write_extent_=
to_disk(eb);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(ret);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
rno =3D -ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror(
>> +"failed to write bytenr %llu length %u devid %llu dev_bytenr %llu: %m=
",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 eb->start, eb->len,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 multi->stripes[dev_nr].dev->devid,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 eb->dev_bytenr);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>> +out:
>> =C2=A0=C2=A0=C2=A0=C2=A0 kfree(raid_map);
>> =C2=A0=C2=A0=C2=A0=C2=A0 kfree(multi);
>> =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>=20


--fqZvWMFfMUZ3P1L5IUGqwFbFX048j4D0q--

--owcKkZC8ufUk7R2Bv8IlcG1tBdOwBh8Bm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5cj3MACgkQwj2R86El
/qjDQgf/Trm2xOmXs8EoCBVUdwadZkFT0Hnxoj99xkGqC26w2OLNpzhR7/FSo6hR
hQaD71/C0q6f1iPTPVFmDXTB7IdM66EWnZZ5MzyNSgitdrqDmbx8ctCe1JF1haAD
nrYFrxXmOwcNWczV/cmy4tfKLVl1+28HRIqxpYC8QvWM4/rncD4k1v1XQGfuQdzs
9bu5tBC7mgmMh7asCzeCgTCgRB0I2WZ4DCsrOzR1WjkphFFwTeqhYkWnkyeGhcVh
98CuqeJ1ovBRgTkG/N2h8y58LfGeZd2c13/Z8JtlS4S5MJQrOQ6cOVFK2gnblqS1
dosMrw/+kVE1M1mpjgv2CZAg29IZgQ==
=o1it
-----END PGP SIGNATURE-----

--owcKkZC8ufUk7R2Bv8IlcG1tBdOwBh8Bm--
