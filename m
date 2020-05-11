Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAF41CD385
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 10:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgEKIKB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 04:10:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:51237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgEKIKA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 04:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589184592;
        bh=MX8OuKTBug6TJV5XFipirflhPJ5ekZn/KLkgh3jjzBM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lVGKJQXE6zi7m0bcmdYbVzc2b3RrQYNoCJVeK9+4ygjuaBriIVGAhCwDB2oOJAZtl
         OtjvXbpRsYWBgTG6NHFKVIA4PqeVf4hK1MoqzIfidAozaKoq05EOBRmb4rmJwDmqz5
         qIqO5ReqQK4Bk1fBPpmyvgM/MeHvJ8RfHOyZawbk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MybKf-1jAu1K3HFF-00yxz4; Mon, 11
 May 2020 10:09:52 +0200
Subject: Re: [PATCH] btrfs: Add comment for BTRFS_ROOT_REF_COWS
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200212074651.33008-1-wqu@suse.com>
 <20200214165334.GC2902@twin.jikos.cz>
 <54ffe5f9-19d1-f916-04fa-3eceedc5aca7@gmx.com>
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
Message-ID: <6a71630c-8a50-ce72-9379-72b95de733a9@gmx.com>
Date:   Mon, 11 May 2020 16:09:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <54ffe5f9-19d1-f916-04fa-3eceedc5aca7@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zJHRVdJCcTw12Ow7RH4nj0xzpkMu4jGrM"
X-Provags-ID: V03:K1:UpoOOiQ48ZUBeTaDajGxeXfUJezjhMvrZDVrVpmAK1HBrT/68RX
 pX+simeY6xSLpS29yxIgvV7qaPnThnuHUTIuhlteDRb2UcDbBiJNQ/wqyEFQ8s6tgCOLDN1
 USq2PGAHDMn2ybyb5Xk/GmjujuSj7km1/+AzUhGjcTfPGZJ/DDBjLNizQY84oEZYgBBHiv7
 FHXU2Ovt0NThqab1UxjOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dXy6pzma1NE=:by62piQdimm/jqwvyXCkFi
 cKo4DDLtJfFXr4DNgSivE+g4S8LmUBXR0hd9D49l0xpwaguTowz5Ne/nlm6eDlwyFVckZEpNb
 FOFYhTMNVvrSVNI0guqxCxRTxsuU0ROb0BzHmLMfu/vePvuhbkR60ccCRggClSbddCrBFK/nk
 mvcpoTyRRzXAXttUaf/BZoK42azDuqUx+7GKx3NbaKqhQ2cg2PLhDgTLluHxITlYoO6SdMMf0
 u9BUftX3AaM9L/+0I8EF6GezeQQssknnVxOkzHLmKvqonVStdKYbAlD7UJdkXwPyG4hE2qQnb
 QiOx/O93eKt7t0x5+F8CKxdk2fusDAsF58czhlSSS45tyaN7MbJGatHxEMzyOU/GJsPpeDQIT
 efK0zOq//irEYOVAJMGygNtbup2fjj0q7prKVxGbi7+QkVbYK40XygAzQZydvcjhewFj0ig/y
 y4WvR1lPV521zAoI0vGdm2V+fc1K0vSZTssezp7OJKe9dNTRyJ+ce5S6nz6lqzE/q86CtzsTa
 cYe5CPrXl/tL9I/Ls8eybRvz+EUaF9cpWzTqVAty/j45WcauQs1qmPwWHwe9+T+YmTXMpJOHJ
 ls/B6DZKu56pPTyIV4qjpG03afVa2Z2oU1OrcCf6I/vCoDhamhlKetQyqbJJuksOd461lduiV
 FQ4iorrnJA3da/dMq1oq8PXQB9t1rwNsQtLClvRzIP46r2HwAutmA2JOtZ06zQ0tngmIhk9+J
 zqLTYpFJXfQk6k+5CdxybXG2JeP53DKBf50YQsldRSaLCBiP41N03KgjBbfyg95DbwLStHaZI
 BHSI4YQUe3p5RPfyHJXliyZik+fU5PSUpSui4knpOBd5w+FfPHwx7pgdJvAISk202sgGa6LY3
 TLHOFbp5sEqzoy15DvjL+DIVqqOXS7J2X9+hbSss8ykEcRD6mbYiNNRJGw2aoCxcrSt6RhGGN
 JuqtNZbNS3L7HzL9PVKd+38OQI4lrGLvWjBt4et7LVEvg1w7ttGzo/sxVRqepXvfOPV7w4rfC
 2lYTaEjwnWAPxQr63CZUuwupTxu3HYNpJ0BeLkgVLjuh5O5SliqbmeRooYvdd8rjD2PctH+JE
 xdu2Gj7r1VpGECi+NcWITgmJ6NQMBpVyGllcv1A6lc+6h/6dguyBIMqmligl4UQeTiEVFynnt
 3NduIDPkTF5WPl9m/0tdkysdVVNqAkMrwvNTr0672jddH6Ei10VtSbpuu+v8ow/SYndZvQED0
 qJtQZrsuMV41EWHLN
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zJHRVdJCcTw12Ow7RH4nj0xzpkMu4jGrM
Content-Type: multipart/mixed; boundary="blXOef58qE7XgEaF63C9ZxxoUUyGX9SWG"

--blXOef58qE7XgEaF63C9ZxxoUUyGX9SWG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi David,

Any extra comment on this?

=46rom my recent dig into relocation code, the REF_COW really only means
if the tree blocks of one tree can be shared by multiple roots.
(Just like subvolume trees).

It mostly affects:
- How the root is updated at commit transaction
  This bit is conflicting with TRACK_DIRTY, thus we need to manually
  call record_root_in_trans() to mark one REF_COW root dirty.

- How relocation handles its tree blocks
  For non-REF_COW trees, relocation just uses COW to do the relocation,
  while for tree with such bit, it goes the path replace way.


Finally maybe a little off-topic, tree without REF_COW bit can still
contain inodes/extent data, like root tree and data reloc tree.
Root tree is the only exception where we have no REF_COW bit but still
allow file extents to be created in it.
(And I'm working on clear the REF_COW bit for data reloc tree, as we
can't create snapshot for that root).


Any more comment?

Thanks,
Qu

On 2020/2/17 =E4=B8=8B=E5=8D=883:06, Qu Wenruo wrote:
>=20
>=20
> On 2020/2/15 =E4=B8=8A=E5=8D=8812:53, David Sterba wrote:
>> On Wed, Feb 12, 2020 at 03:46:51PM +0800, Qu Wenruo wrote:
>>> This bit is being used in too many locations while there is still no
>>> good enough explaination for how this bit is used.
>>>
>>> Not to mention its name really doesn't make much sense.
>>>
>>> So this patch will add my explanation on this bit, considering only
>>> subvolume trees, along with its reloc trees have this bit, to me it
>>> looks like this bit shows whether tree blocks of a root can be shared=
=2E
>>
>> I think there's more tan just sharing, it should say something about
>> reference counted sharing. See eg. btrfs_block_can_be_shared:
>>
>>  864         /*
>>  865          * Tree blocks not in reference counted trees and tree ro=
ots
>>  866          * are never shared. If a block was allocated after the l=
ast
>>  867          * snapshot and the block was not allocated by tree reloc=
ation,
>>  868          * we know the block is not shared.
>>  869          */
>>
>> And there can be more specialities found when grepping for REF_COWS. T=
he
>> comment explaination should be complete or at least mention what's not=

>> documenting. The I find the suggested version insufficient but don't
>> have a concrete suggestions for improvement. By reading the comment an=
d
>> going through code I don't feel any wiser.
>>
>=20
> I see nothing extra conflicting the "shared tree blocks" part from
> btrfs_block_can_be_shared().
>=20
> In fact, reloc tree can only be created for trees with REF_COW bit.
>=20
> For tree without that bit, we go a completely different way to relocate=

> them, by just cowing the path (aka the cowonly bit in build_backref_tre=
e()).
>=20
> 	if (root) {
> 		if (test_bit(BTRFS_ROOT_REF_COWS, &root->state)) {
> 			BUG_ON(node->new_bytenr);
> 			BUG_ON(!list_empty(&node->list));
> 			btrfs_record_root_in_trans(trans, root);
> 			root =3D root->reloc_root;
> 			node->new_bytenr =3D root->node->start;
> 			node->root =3D root;
> 			list_add_tail(&node->list, &rc->backref_cache.changed);
> 		} else {
> 			path->lowest_level =3D node->level;
> 			ret =3D btrfs_search_slot(trans, root, key, path, 0, 1);  <<<
> 			btrfs_release_path(path);
> 			if (ret > 0)
> 				ret =3D 0;
> 		}
>=20
> So the "REF_COW means tree blocks can be shared" still looks pretty
> valid to me.
>=20
> Thanks,
> Qu
>=20


--blXOef58qE7XgEaF63C9ZxxoUUyGX9SWG--

--zJHRVdJCcTw12Ow7RH4nj0xzpkMu4jGrM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl65CEsACgkQwj2R86El
/qienwf+IapBGelTrN9xnbdrX6vy0jHhzH8XYAqi+1pJ5PRFwlzRdSEcZIuLaAUE
bgT4bQigEa27Cmn2ZTqBDyj67NGnN61A2PvO4jCb6lU8Cl29PS/YUVNni0Hbs4vx
9Lml7NTnOiaftMJ9G25Hxq2VTRN/ONMcIcPfCKYModeu9Ogh95fl30RHPa+L4X/0
6RONnowzlhe14azQ59M1gBATJbBp6JtcI/IizAc8MDMU3WEVPO56IPCrq52G85Ro
NbFf+aUnT6yWckFsewZ95d4fSK2kiYZG8m/3Y0BWA7gX2ODT9XursJK2XH6DIyhn
Axone108jRuc6qnSgk+SJd8KeQL+bA==
=70QK
-----END PGP SIGNATURE-----

--zJHRVdJCcTw12Ow7RH4nj0xzpkMu4jGrM--
