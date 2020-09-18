Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CAF26F7D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 10:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIRISi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 04:18:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:36727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgIRISi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 04:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600417111;
        bh=025Sla+JCQXdrZfRThdqteXXZRzB2f6NbKNwLRLuaSk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lnOyI3Tz4S3RKWcZZKFBVmscJgoSQCPpy4Cx4NC7SUhyCxhK6kOLlwGloTgYtLuhX
         H6hHZ7LyvDtktmWgy04D6dxolBi5GQ1MFQLS3wxxljy1NxdKSpdjkdHH7XWCWtH5+e
         gY90H1f+nMQIyk27/TBcF5/LG9FcbNK7mYD5XNy0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgvrL-1kyIdn1L1J-00hNQk; Fri, 18
 Sep 2020 10:18:31 +0200
Subject: Re: [PATCH v2 14/19] btrfs: make btree inode io_tree has its special
 owner
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-15-wqu@suse.com> <20200916160612.GO1791@twin.jikos.cz>
 <9ea58668-b6e5-6471-01fe-d4bf8ae8b310@suse.com>
 <20200917125031.GS1791@twin.jikos.cz>
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
Message-ID: <08592bd0-0336-7170-3f3e-0d730d002aaa@gmx.com>
Date:   Fri, 18 Sep 2020 16:18:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917125031.GS1791@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9m8U8h6N02547znKPIcs87y3WUaKhSBGB"
X-Provags-ID: V03:K1:5Y1NuurModSWhOw8o/5a5QV8/XDjrfkATBnklypI6cIikUEsGkd
 /JiT3MDi3zI321sRuFbfV8O2KcVlZKxrLGDxsB07orOa3ohw21Rw3KW9W7bpFZJAWD8D402
 geWJ021NSSnM7OfoCt3UcMrCngNA3VmOU4nMQ+3CYoQpqRBeWBKtQ/2y3oOJkf5T5u+M0ul
 8x7+3HZd8KI1AgAoF1i0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:adDZBic3m3Q=:2FDGPtZwwz2780ll+bTAqz
 LQ4KbC5dlz3TIL5knjMevARFvXxcD3U8IUU9+C9A9YuflkLOd0JgbdtDkEZboKQ2/MulH4EVJ
 NTKN+zWSJPNacpipSdY/HDXD5rTxEImfeSkkD9IaScfUNO+1fKw+HSGNDgfEk06QsvmE0qgu9
 udXJ6FdnD1cMx/4+CqIgLQIXoq/MuE4BmaFMjffIatWOM3EL/VXWJY7V8aql/YxYBfU580Cd2
 AGDk1/EqolhW6hvxkYbxYiUsby8VSkg1EurImRv/T9hSiAMT/w2NEnN4o9g9EEvQrgni+aD6J
 200g6kTQumA3QCf7ldVdxEjcTZXAOoTzOP6QMZlEOsBFq1jafhWYF8GRhNw+1qKKOoEyqXuRW
 1TvgsVUg82Dh9HHtPnu6OH/Y/9ZwD8UFox+1PM3jpqMiJ/vn9SbplbSaI4b5S++BE45LIiRSB
 4zjeDOb7hR5ofVRtQ6qjOaYCGy719+M04mdGdTLAg0pNMZRyR8AByql3SLSwkol8IWL9j+ZzZ
 eoHgqMIPRj5lWaPmNCKXqYi/zSQdoDYZ9x+2nd0J4oQSmInw7mmCVHxDSeX1Z2abn3qJuetw7
 zbKE5NgZU26H/vWsTSfPmbxQRXCDprEX6ye4I/rs34rjeTfxToB2PAVfO1dMXvJxl9ZM9xQ6+
 GB998ih+cKgbqpgwJfYHzmrSAAI+FiWIBbRi7A84nmpuqLEnyzqWWckEjszbTzKTAQ3o2YNYK
 f6ggnrSsHrzJgI2lbZdBDvBUAtqT+On2lD386GvPwnOQYvhYtTFG5w0IzRBgXaLoZtNfTUhIL
 F1j/BnLJIqnqr6rCreruaXxoOHtoLJ5Pzc05crxUu9XJ1SvAuhOpvBwIpFa1sPaMe53Ju2bhR
 njMqWYBIwd2F9j9IcEcBLu3WvFmjL26Wk5cL1p8QFVGAxTQRXvl4MAT9j4Q/9MGSaR/v17feb
 MdiPukHOzbQ6ts50RchHe7IgdqqNiyntRGmsF/l2OULv4ZjfsXlKNapmSe0Xb29g6kau6M5Ku
 3NsgSFRDGwTRCuTc48EozTAqREA2NPFmACvYsB9gSuH4xb77DMrHsyaCrtczcDlK5jEiGnnUW
 eVBKp7/O/LYOTz5wvFoz85gBrzUdNznG725ONC8U9UaokyIARsQpVGm9H9lDVLOiS5xKg5fGy
 huygz4W69Qvi5HvW//Q9mGXnh8BCYhoASUO8ZvPjR/8KeH0278Uag9K+u7wY+g9a4ZglF1jXM
 50zJKZEiMOYgequFqVPoxoBBEjE1eqrvMWt2nyA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9m8U8h6N02547znKPIcs87y3WUaKhSBGB
Content-Type: multipart/mixed; boundary="9Ni8iPPthDUwiNNFryq9lK2OBWhWmLmKh"

--9Ni8iPPthDUwiNNFryq9lK2OBWhWmLmKh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/17 =E4=B8=8B=E5=8D=888:50, David Sterba wrote:
> On Thu, Sep 17, 2020 at 08:02:05AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/9/17 =E4=B8=8A=E5=8D=8812:06, David Sterba wrote:
>>> On Tue, Sep 15, 2020 at 01:35:27PM +0800, Qu Wenruo wrote:
>>>> Btree inode is pretty special compared to all other inode extent io
>>>> tree, although it has a btrfs inode, it doesn't have the track_uptod=
ate
>>>> bit at all.
>>>>
>>>> This means a lot of things like extent locking doesn't even need to =
be
>>>> applied to btree io tree.
>>>>
>>>> Since it's so special, adds a new owner value for it to make debugin=
g a
>>>> little easier.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>  fs/btrfs/disk-io.c        | 2 +-
>>>>  fs/btrfs/extent-io-tree.h | 1 +
>>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>>> index 1ba16951ccaa..82a841bd0702 100644
>>>> --- a/fs/btrfs/disk-io.c
>>>> +++ b/fs/btrfs/disk-io.c
>>>> @@ -2126,7 +2126,7 @@ static void btrfs_init_btree_inode(struct btrf=
s_fs_info *fs_info)
>>>> =20
>>>>  	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
>>>>  	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
>>>> -			    IO_TREE_INODE_IO, inode);
>>>> +			    IO_TREE_BTREE_IO, inode);
>>>
>>> This looks like an independent patch, so it could be taken separately=
=2E
>>>
>> Errr, why?
>>
>> We added a new owner for btree inode io tree, and utilize that new own=
er
>> in the same patch looks completely sane to me.
>>
>> Or did I miss something?
>=20
> The IO_TREE_* ids are only for debugging and IO_TREE_INODE_IO is
> supposed to be used for data inodes. But the btree_inode has that too,
> which does not seem to follow the purpose of the tree id, you fix that
> in this patch and it applies to current code too.
>=20
Oh, I didn't see it as a fix. But your point still stands, and makes sens=
e.

And this patch would be the base stone for later btree io tree specific
re-mapping bits.
So if this patch can be applied to current code, it would only be a good
thing.

Thanks,
Qu


--9Ni8iPPthDUwiNNFryq9lK2OBWhWmLmKh--

--9m8U8h6N02547znKPIcs87y3WUaKhSBGB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9kbVMACgkQwj2R86El
/qhedQf/VfdXpjc5yofW3FncM7cH2qsNqkkyqK16auZX8jBtyRjdy69yk7haDUi+
GfGPOgiAhUzI2mcy2iTbYpXrBwblCYqSSzbuXpkga571ocNWM5kPVyHJq35HObCY
M/JNsCpzh8IVOuul3jgnL4k/Mw0IppNzLiF/GmBzB5CdpCTC5SErlmK5hkDRujHd
5v7kPUMpR9JfRT///IrSdoxKDXmZRzjIYPUKn6h+4fG6YFFTTUF/wn8DQ14F4ElS
4h3ODp59gIs5MQZceuDG1g/gC8xQ7py3m6KYpX1jhUkzTuymcNoeS5S9AoYshd7B
CkZ+5NQE6FmYerwpipOBPuyFPfP1Yw==
=G1R1
-----END PGP SIGNATURE-----

--9m8U8h6N02547znKPIcs87y3WUaKhSBGB--
