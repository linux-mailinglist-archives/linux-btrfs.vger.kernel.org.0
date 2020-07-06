Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A051F2153FD
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 10:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgGFI3G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 04:29:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:35561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgGFI3F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 04:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594024136;
        bh=rsMGuvcyXyhveHQfRd7SRo5N9SH4tu4bQvmnSamvUFI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kD/L3id5zdmi1iSXfSrDj7y9GxHnE81HxRDjypap4VCaILgxoZvX19YdjPw/ho7n4
         BYXAhtLUiAEtd4F+LSWuaAw+6P913Kk5GlMbu/XfZKmjUqE8dhoYbILfiF/nostfU1
         I0vrGB3Mwxy3ftUvhwiMMHski5LmB63qbKBg1WaI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma20q-1kOB6J1V48-00W1v9; Mon, 06
 Jul 2020 10:28:56 +0200
Subject: Re: [PATCH] btrfs: speedup mount time with force readahead chunk tree
To:     Robbie Ko <robbieko@synology.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz
References: <20200701092957.20870-1-robbieko@synology.com>
 <aeb651c8-0739-100b-90ad-9f36ecdc26e6@synology.com>
 <7da55a96-131c-b987-edfb-97375a940cd2@gmx.com>
 <375407fc-3c3c-6628-3e80-a5300a897e4e@synology.com>
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
Message-ID: <497f7ba0-4efb-b1a2-79a1-62ed2621c743@gmx.com>
Date:   Mon, 6 Jul 2020 16:28:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <375407fc-3c3c-6628-3e80-a5300a897e4e@synology.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jVoSpC6PkSVbGjHKdVm6QQ8FXLZu5vjzx"
X-Provags-ID: V03:K1:wTMh2BppuQUfceMKDZmtPbS+i95RW9krztJJ306hRRmz6/nxQwQ
 SKMbsr7p3xY5kAYZIL6Izn09c9ZFjFNHArwacuF3JPY4hILmMDACx8DmmUSV68NTsolvQWd
 ZQ+l2lwWMnJssGRn0naJ4wAPnnldtWboQgJpC9Aa/NV85fsKvk4G89rqU/yMwiUS3TtJRw7
 LLxUBy1znFnNWuh1hu2VQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZcMU4FzHHrw=:XvxUPzNusS2FjNmD/CYw0r
 emVWkekbU0NP9+ki1pyT3e+/rHT/sGWNBKXmYpba12JQayJqWkSyOehO4qpC1zcsyRaQ4/Nrr
 cRLhn0OiQ6loqsOugz6CRhPlG4mvJMAiNCro0TsgMDrfXyj8KkcGnhwuKg/HvMgnHMzMNZrJx
 +tzfXjw5PzC95Gv/NAZUuUJKu34kxSYempKls8piKIG3MrXyOill5NlhpoOmUhwC5XidjWjSR
 C06vWciMvC/KD/TUnt3vffE+79mCh0Ili8n5PI+uHtdN5W2a2/tvsp4cr5Q/4p1LhgXGsiHv6
 ha7Fs9uNlSSWXqulfDLncZdJkgdNnVeXZegKTkTj2k/vxemIPjgeqbs2Q23M1y6N5rqYa61A8
 Q/3S1XJQcvNacrHmFWdK1ytWLDiNGTz4cFEtHO38R/Ce3jsr/LLrVOK0MCyPaNhgbIJmGZlBc
 Yld0/rZA9gj9rUtEeZnvk41envKTpI7wnjhVNdAsbt+tMbDtGTpSngtyVEGRblUL6fUsqUiB/
 iviWHdt1MS/yoleI9IzfQA26MVFluNBJzMAK2oiF//5zXRWSdujSku4OWvDuv5FucS2HHihWp
 hh6RpQCM8PvsBZTWjJiV75bstwucRmvGctuiR5MmoYkoofPpVLemGBiDbzC7NIckJjC8nWZ9E
 FxAENyfKCbpJOczr2PaaqsEVlKx27lEkXR036P0GSJp0WoMMbLj7//IyBgEA0daIdHTofvRv0
 Vr4RpjIGf3zSGWUB7bjXExw8mb6+rIoPx4DqftLAAehGioLbcTPBH0wzaPfOBaMoNXHuRcZza
 y8veBVQ/UTZLHlMG/CAjwzCwPFTYKh4ASqOaUE6o+4HsHQLN2XfiurVF/qfmHG41kXc3rmy6I
 ll/cBywv2cqIaMlDdEQxfTqKL/d7mEwRYfz2mikQFtu5mjbp+oC201DMG+k5pj9NrIf8mFgRL
 Q9UVqr2OuuTbE7u7wiI6WWtrjyr9FA2w9ag3N8ejSvRMZRoJSJXXgACDvtENv6UY6SEnkdHE8
 Xukz0z1K+ReBJW3pNBTttDBwSvhzXIXTCT4zQqRUUSyWGSQ3vbG4DY0Iff+1UItAcZIc0Do/g
 bzHCba203O3YTvXxBOnhZhwD1USqHKz113PzEVvtRLZxsZFHucRBjWyBZ70RhQxZhnPunu7dF
 xL61ffnRxyxsheW78XGr4vhhD2ytgzVLrWt8Op5j2BikY0dKFYkNUKx/ClYDmunaJLizemqkk
 j1wD5HIG5JpC072r7HK3r0mttISmXErH5tfQQVA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jVoSpC6PkSVbGjHKdVm6QQ8FXLZu5vjzx
Content-Type: multipart/mixed; boundary="kAv0vavNJuvUcrP55AogvFbCSwHtkTznX"

--kAv0vavNJuvUcrP55AogvFbCSwHtkTznX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/6 =E4=B8=8B=E5=8D=884:05, Robbie Ko wrote:
>=20
> I've known btrfs_read_block_groups for a long time,
>=20
> we can use BG_TREE freature to speed up btrfs_read_block_groups.
>=20
> https://lwn.net/Articles/801990/
>=20
>=20
> But reading the chunk tree also takes some time,
>=20
> we can speed up the chunk tree by using the readahead mechanism.
>=20
> Why we not just use regular forward readahead?
> - Because the regular forward readahead ,
> =C2=A0 reads only the logical address adjacent to the 64k,
> =C2=A0 but the logical address of the next leaf may not be in 64k.

Great, please add these into the changelog for the need of
READA_FORWARD_FORCE.

But on the other hand, it looks like we could change READA_FORWARD
without introducing the _FORCE version,
as _FORCE variant is what we really want.


That logical bytenr limit looks not reasonable to me, which makes that
READA_FORWARD near useless to me.

Although in that direction, we also need to verify all existing
READA_FORWARD are really correctly.

Personally I tend to prefer change existing READA_FORWARD and review all
existing callers.

>=20
> I have a test environment as follows:
>=20
> 200TB btrfs volume: used 192TB
>=20
> Data, single: total=3D192.00TiB, used=3D192.00TiB
> System, DUP: total=3D40.00MiB, used=3D19.91MiB
> Metadata, DUP: total=3D63.00GiB, used=3D46.46GiB
> GlobalReserve, single: total=3D2.00GiB, used=3D0.00B
>=20
> chunk tree level : 2
> chunk tree tree:
> =C2=A0 nodes: 4
> =C2=A0 leaves: 1270
> =C2=A0 total: 1274
> chunk tree size: 19.9 MB
> SYSTEM chunks count : 2 (8MB, 32MB)
>=20
> btrfs_read_chunk_tree spends the following time :
>=20
> before: 1.89s
>=20
> patch: 0.27s

That's great, although 2s is already fast enough to me :)

Thanks,
Qu

>=20
> Speed increase of about 85%.
>=20
> Between the chunk tree leaves, there will be a different SYSTEM chunk,
>=20
> when the The more frequent the chunk allocate/remove, the larger the ga=
p
> between the leaves.
>=20
> e.g. chunk tree node :
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 85020014280704) blo=
ck
> 79866020003840 (4874635010) gen 12963
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 85185370521600) blo=
ck 28999680
> (1770) gen 12964
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 85351800504320) blo=
ck
> 79866020347904 (4874635031) gen 12964
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 85518230487040) blo=
ck
> 79866020102144 (4874635016) gen 12964
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 85684660469760) blo=
ck
> 79866020118528 (4874635017) gen 12964
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 85851090452480) blo=
ck
> 79866020134912 (4874635018) gen 12964
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 86017520435200) blo=
ck 29261824
> (1786) gen 12964
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 86183950417920) blo=
ck
> 79866020397056 (4874635034) gen 12965
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 86350380400640) blo=
ck
> 79866020151296 (4874635019) gen 12965
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 86516810383360) blo=
ck
> 79866020167680 (4874635020) gen 12965
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 86683240366080) blo=
ck
> 79866020184064 (4874635021) gen 12965
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 86849670348800) blo=
ck
> 79866020200448 (4874635022) gen 12965
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 87016100331520) blo=
ck 29065216
> (1774) gen 12966
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 87182530314240) blo=
ck
> 79866020315136 (4874635029) gen 12966
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 87348960296960) blo=
ck
> 79866020331520 (4874635030) gen 12966
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 87515390279680) blo=
ck
> 79866020413440 (4874635035) gen 12966
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 87681820262400) blo=
ck
> 79866020429824 (4874635036) gen 12966
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 87848250245120) blo=
ck 29294592
> (1788) gen 12968
> =C2=A0=C2=A0=C2=A0 key (FIRST_CHUNK_TREE CHUNK_ITEM 88014680227840) blo=
ck
> 79866020544512 (4874635043) gen 12968
>=20
>=20
> With 1PB of btrfs volume, we will have more SYSTEM CHUNK,
>=20
> and each chunk tree leaf will be more fragmented,
>=20
> and the time difference will be larger.
>=20
>=20
> Qu Wenruo =E6=96=BC 2020/7/6 =E4=B8=8B=E5=8D=882:16 =E5=AF=AB=E9=81=93:=

>>
>> On 2020/7/6 =E4=B8=8B=E5=8D=882:13, Robbie Ko wrote:
>>> Does anyone have any suggestions?
>> I believe David's suggestion on using regular readahead is already goo=
d
>> enough for chunk tree.
>>
>> Especially since chunk tree is not really the main cause for slow moun=
t.
>>
>> Thanks,
>> Qu
>>
>>> robbieko =E6=96=BC 2020/7/1 =E4=B8=8B=E5=8D=885:29 =E5=AF=AB=E9=81=93=
:
>>>> From: Robbie Ko <robbieko@synology.com>
>>>>
>>>> When mounting, we always need to read the whole chunk tree,
>>>> when there are too many chunk items, most of the time is
>>>> spent on btrfs_read_chunk_tree, because we only read one
>>>> leaf at a time.
>>>>
>>>> We fix this by adding a new readahead mode READA_FORWARD_FORCE,
>>>> which reads all the leaves after the key in the node when
>>>> reading a level 1 node.
>>>>
>>>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>>>> ---
>>>> =C2=A0=C2=A0 fs/btrfs/ctree.c=C2=A0=C2=A0 | 7 +++++--
>>>> =C2=A0=C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0 | 2 +-
>>>> =C2=A0=C2=A0 fs/btrfs/volumes.c | 1 +
>>>> =C2=A0=C2=A0 3 files changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>>>> index 3a7648bff42c..abb9108e2d7d 100644
>>>> --- a/fs/btrfs/ctree.c
>>>> +++ b/fs/btrfs/ctree.c
>>>> @@ -2194,7 +2194,7 @@ static void reada_for_search(struct
>>>> btrfs_fs_info *fs_info,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (nr =3D=3D 0)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 nr--;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (path->reada =3D=
=3D READA_FORWARD) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (path->reada =3D=
=3D READA_FORWARD || path->reada =3D=3D
>>>> READA_FORWARD_FORCE) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 nr++;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (nr >=3D nritems)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> @@ -2205,12 +2205,15 @@ static void reada_for_search(struct
>>>> btrfs_fs_info *fs_info,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 search =
=3D btrfs_node_blockptr(node, nr);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((search <=3D target =
&& target - search <=3D 65536) ||
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((path->reada =3D=3D =
READA_FORWARD_FORCE) ||
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
(search <=3D target && target - search <=3D 65536) ||
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (search > target && search - target <=3D 65536)) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 readahead_tree_block(fs_info, search);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 nread +=3D blocksize;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nscan++=
;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (path->reada =3D=3D R=
EADA_FORWARD_FORCE)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
continue;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((nr=
ead > 65536 || nscan > 32))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>>> index d404cce8ae40..808bcbdc9530 100644
>>>> --- a/fs/btrfs/ctree.h
>>>> +++ b/fs/btrfs/ctree.h
>>>> @@ -353,7 +353,7 @@ struct btrfs_node {
>>>> =C2=A0=C2=A0=C2=A0 * The slots array records the index of the item o=
r block pointer
>>>> =C2=A0=C2=A0=C2=A0 * used while walking the tree.
>>>> =C2=A0=C2=A0=C2=A0 */
>>>> -enum { READA_NONE, READA_BACK, READA_FORWARD };
>>>> +enum { READA_NONE, READA_BACK, READA_FORWARD, READA_FORWARD_FORCE }=
;
>>>> =C2=A0=C2=A0 struct btrfs_path {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *nodes[BTR=
FS_MAX_LEVEL];
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int slots[BTRFS_MAX_LEVEL];
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index 0d6e785bcb98..78fd65abff69 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -7043,6 +7043,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info=

>>>> *fs_info)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path =3D btrfs_alloc_path();
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!path)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
-ENOMEM;
>>>> +=C2=A0=C2=A0=C2=A0 path->reada =3D READA_FORWARD_FORCE;
>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * uuid_mutex is needed on=
ly if we are mounting a sprout FS


--kAv0vavNJuvUcrP55AogvFbCSwHtkTznX--

--jVoSpC6PkSVbGjHKdVm6QQ8FXLZu5vjzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8C4MMACgkQwj2R86El
/qjppwf+L1udc6/+zIJWNZYeSfq9t7H3sTefTQP9Gs1tyBR1NvyeFVj/FY0mVc7r
255pp0J4edOIGI6v1Tijt8TGnCkwoGQNWsGvrQKmMY1VQ/8HVWZbvQB/ZJJny2FK
6+wiz5g8lJ7vxPP5/LQZv6avjXu44RRXUjM4dZAQkS30h5tol6yvWYhc1mMcj/hn
7wyX6JSV3YyS858h6yhtrdkMBwc+r9hn/74hO/WTQR/9PRlOyAVP8S/oW1jj/D37
8ta9h0PW6lOP/icORzX/UsVAiyPRm9h0CYLWOukob+jssKBAVcAq/ORwVzvex5LA
ZGVAv5g+aeXeirJfEMVhDJakFFpjHQ==
=0Lif
-----END PGP SIGNATURE-----

--jVoSpC6PkSVbGjHKdVm6QQ8FXLZu5vjzx--
