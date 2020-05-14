Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00101D3155
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 15:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgENNce (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 May 2020 09:32:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:60287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgENNcd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 09:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589463138;
        bh=fsORfaWbya9UVJ5HfxhEuLh3oBDRyGXlxFs0uI7t4NU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kL5LtujOvZO0QFKR/JnKLxZvCcqqyTa0cntmSWPXiT2o0ZA2fgsHfnyGU/FWD8F0q
         OFnS5geRVuj37nPzzMZa6D9J3ktqFOyraang6wIvKkeublq8rnBo9ztg3VsPCFYxra
         DKPmZaeBhXLGtGPgpCYexhEu+5O8dgERdkoFo4hU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSc1L-1jfVTU1vEf-00SzXZ; Thu, 14
 May 2020 15:32:18 +0200
Subject: Re: [PATCH v2 2/3] btrfs: inode: Cleanup the log tree exceptions in
 btrfs_truncate_inode_items()
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200514073325.33343-1-wqu@suse.com>
 <20200514073325.33343-3-wqu@suse.com>
 <CAL3q7H701a1eK9rfuZHnRitPNae4vG0DzXK-s86GUMQX0QwQQQ@mail.gmail.com>
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
Message-ID: <11680d1a-9dcf-0f50-968f-01763c16ea21@gmx.com>
Date:   Thu, 14 May 2020 21:32:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H701a1eK9rfuZHnRitPNae4vG0DzXK-s86GUMQX0QwQQQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="U7QPob0XjWdfVXy6ArzIqCsTNZnathSi7"
X-Provags-ID: V03:K1:GpUX7TgR6Ko9rsUPT9eALzzE3+iioRTbU1W7d0x+HRj+RVWJahx
 iFCcvsIeSB0XRi4qyxIUKn+qPCvBBlq+xKUQZGDWAL/LZAyqE4QkxvrsuOkEgSpTi64XzEh
 MSkvcK55tfmDwNuWKnKvGQMAK2F5nX7taslrG7y/eeRb7aLX2FaL2jAt+R6TyBw/cUSe6j4
 4cTZdozFOhjFZBcvpHeAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Q8U9HMCWec=:p62r24RwgB5qvSKaE6B+Bc
 dm5X1tEo+grBqiGlZ9un4SI1bgaGoxYYQ/5Yw6mnDNJEJtFE3NHID/8He0FVuJpfIcMIIBp16
 T6iLHNBAWhz3rC0G3p4XmYQtJtykZTWg1kp7prDXN+dCrSoflOZ9/cAaxWyU5iF+WpFNn5P/o
 WqBtNYsQ0Ron4R6UwIg5Oac30L+zv+giIpbz/r3Xnb7AUOlsHhr4BlMhpwVJEbW7jTiYm2LP/
 8vDxT3eAvHWx2IbJgsLlAYwQOmOCEStyWB3dXxsPoTxaLMSScFo7qxMH+COXo41AEJWvloS8A
 K3So8Xtbej8BNwi3oOq98QDo2M33M9RN34q7NSeU7j+1M1SewzhBcflGiypQQ9bsBPVWQSj6X
 zNSFQ5uqU7yss8IXOJiOyVU89OE9smZ5OP3rtDAgTuPMFOpIBG3fNOxeleGlXCLNYKIm+t6SO
 IA4euzhrdPgIctpwRmeWcgyO96RU/D4OYJJ8o72K2BAkqgU1IE7aL1t/iD/NeqlYtn2hMZH7g
 WAB5OdzrypDi0KVR38QxY4SB/aY9Kq8MBg+kbpKZerrZ2ZKynxEZrYorZT9qMioBAxmnbzZCu
 OPP49SeASFC8gFJk6WRY6ifD7KBMIhuv6W+jurH7IzsuD3hssd2iKaZouz6eOsx4Tg+BGuPjo
 Gwj+vOybZoxctyPFvVRtdVrCLD8qSRW2pXi9Ufg6iPLka53Ye9AKuQXFRurcyY2Einhimv5Vp
 26qLLGJ9i/PSpOz5eu1hWvhPj5MWDqo0RpxXTHRi04bPQY83Olc8G39hz6kaTHCmnZ5Y41Tg5
 Bcyg6yxIf1KxbIW35yRGODhhC/I6daQTO8wiEbdwibtWKtJq3TzAs3gwlUbJkQIqsWadONslz
 28+KxkgnxT+RvpV2ks4/o7BYrLuKxwJQ4qP92GZFCQrUbjIW8svkdPGiAqqvJyLNRZlugwPaY
 OIu3H4BGmBgxFBwAUgvbNsUQafWmBPOZPE8hB5kV/jBtf6s9lX47ef7v2tWwjlM6tUWtySibJ
 CGy9h+8k0Lg3LnXOREtJ4WUCzQ12c5iW6QgDzmVsJMY6iNK2kAhxJ+1skWB/ni/YdsqzDEFC7
 nAC3uJru+SiLXQym/YnaRJJMAwnNAXBkeLZnPfF5lmg0PBv/qySUnpgh+YoOwuGSudwNPM9QK
 oq/O07SQF3M3thWrJ9sDzltNr8lE3vJTdI4uKX7HBadr8YViydgGq+l7ozhEnUNV7kdAvSukF
 Kxa3Y4kwvfL7GWOYs
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U7QPob0XjWdfVXy6ArzIqCsTNZnathSi7
Content-Type: multipart/mixed; boundary="hlhxlMSTrUZ7Z0nYEL6AhZiMSdQkzfqSJ"

--hlhxlMSTrUZ7Z0nYEL6AhZiMSdQkzfqSJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/14 =E4=B8=8B=E5=8D=889:20, Filipe Manana wrote:
> On Thu, May 14, 2020 at 8:35 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> There are a lot of root owner check in btrfs_truncate_inode_items()
>> like:
>>
>>         if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
>>             root =3D=3D fs_info->tree_root)
>>
>> But considering that, there are only those trees can have INODE_ITEMs:=

>> - tree root (For v1 space cache)
>> - subvolume trees
>> - tree reloc trees
>> - data reloc tree
>> - log trees
>>
>> And since subvolume/tree reloc/data reloc trees all have SHAREABLE bit=
,
>> and we're checking tree root manually, so above check is just excludin=
g
>> log trees.
>>
>> This patch will replace two of such checks to a much simpler one:
>>
>>         if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID)
>>
>> This would merge btrfs_drop_extent_cache() and lock_extent_bits() call=

>> into the same if branch.
>>
>> Also since we're here, add one comment explaining why we don't want to=

>> call lock_extent_bits()/drop_extent_cache() on log trees.
>>
>> Finally replace ALIGN()/ALIGN_DOWN() to round_up()/round_down(), as I'=
m
>> always bad at determing the alignement direction.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/inode.c | 27 ++++++++++++++-------------
>>  1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index a6c26c10ffc5..771af55038bf 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -4101,7 +4101,7 @@ int btrfs_truncate_inode_items(struct btrfs_tran=
s_handle *trans,
>>         u64 bytes_deleted =3D 0;
>>         bool be_nice =3D false;
>>         bool should_throttle =3D false;
>> -       const u64 lock_start =3D ALIGN_DOWN(new_size, fs_info->sectors=
ize);
>> +       const u64 lock_start =3D round_down(new_size, fs_info->sectors=
ize);
>=20
> Hum, seriously? Why does ALIGN_DOWN confuses you? ALIGN, means to
> align, and the DOWN part is very explicit about the direction.

ALIGN_DOWN() doesn't, but the later ALIGN() needs to check if it's
ceiling or floor.
So I unify them to round_up/round_down().

>=20
>>         struct extent_state *cached_state =3D NULL;
>>
>>         BUG_ON(new_size > 0 && min_type !=3D BTRFS_EXTENT_DATA_KEY);
>> @@ -4121,20 +4121,22 @@ int btrfs_truncate_inode_items(struct btrfs_tr=
ans_handle *trans,
>>                 return -ENOMEM;
>>         path->reada =3D READA_BACK;
>>
>> -       if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID)
>> -               lock_extent_bits(&BTRFS_I(inode)->io_tree, lock_start,=
 (u64)-1,
>> -                                &cached_state);
>> -
>>         /*
>> -        * We want to drop from the next block forward in case this ne=
w size is
>> -        * not block aligned since we will be keeping the last block o=
f the
>> -        * extent just the way it is.
>> +        * There will be a lot of exceptions for log trees, as log ino=
des are
>> +        * not real inodes, but an anchor for logged inodes.
>=20
> This is a very confusing sentence, you're saying logged inodes are an
> "anchor" (whatever that means) to themselves.
> Either leave nothing as it was, or just say log tree operations aren't
> supposed to change anything on the inodes.

OK, I'll not add such confusing comment then.

Thanks,
Qu

>=20
> Thanks.
>=20
>>          */
>> -       if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
>> -           root =3D=3D fs_info->tree_root)
>> -               btrfs_drop_extent_cache(BTRFS_I(inode), ALIGN(new_size=
,
>> +       if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID) {
>> +               /*
>> +                * We want to drop from the next block forward in case=
 this
>> +                * new size is not block aligned since we will be keep=
ing the
>> +                * last block of the extent just the way it is.
>> +                */
>> +               lock_extent_bits(&BTRFS_I(inode)->io_tree, lock_start,=
 (u64)-1,
>> +                                &cached_state);
>> +               btrfs_drop_extent_cache(BTRFS_I(inode), round_up(new_s=
ize,
>>                                         fs_info->sectorsize),
>>                                         (u64)-1, 0);
>> +       }
>>
>>         /*
>>          * This function is also used to drop the items in the log tre=
e before
>> @@ -4335,8 +4337,7 @@ int btrfs_truncate_inode_items(struct btrfs_tran=
s_handle *trans,
>>                 should_throttle =3D false;
>>
>>                 if (found_extent &&
>> -                   (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
>> -                    root =3D=3D fs_info->tree_root)) {
>> +                   root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECT=
ID) {
>>                         struct btrfs_ref ref =3D { 0 };
>>
>>                         bytes_deleted +=3D extent_num_bytes;
>> --
>> 2.26.2
>>
>=20
>=20


--hlhxlMSTrUZ7Z0nYEL6AhZiMSdQkzfqSJ--

--U7QPob0XjWdfVXy6ArzIqCsTNZnathSi7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl69SFwACgkQwj2R86El
/qioDggAoN0DnHL/nFvZ8iVvreQl8bneSoQOHfH2Q6oAmkWBD1o4mroxqIT8EnRs
ZJNdnxJ/vIJEYm2nnN11d6pUYLtoPBEe6HgXcarZmPs13hLcLwH0b3f+4voFBFK/
CgV31+n4IfU0sWpNjHsTfIqnFChVbVRQu8wFZYxJfZQqeIotelF1iyhpmFgiS3u7
0C6AyrttpS6bVPuupnfeRlfb6GkyoTS7ru0Mf2ed7/2tLH4Dj3a/yEiWHR1hpEF+
VSdlKDQFliN64QwbsVwCHRMLuJkHeaYAg0wCZQ1vvfFy47cS8gZpCVOLeX3ednFV
DIvB+7lAP2xIoDC4PGSyCf2z6xbN2w==
=31Fu
-----END PGP SIGNATURE-----

--U7QPob0XjWdfVXy6ArzIqCsTNZnathSi7--
