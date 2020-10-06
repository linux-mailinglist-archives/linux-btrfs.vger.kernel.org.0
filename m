Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2077A284347
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 02:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgJFATI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 20:19:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:35063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgJFATI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Oct 2020 20:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601943544;
        bh=7YKU6dYdCIRhf7+bS4cV0tyya+t/y/wVKb4DROgR0io=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KfcvaB7gO92PkSm9ZcWrCgWDI2mSHZLX8+EFVpdNWr2VZLAbVIH0kivq1wy8KoBZu
         rkYshjGipSXp13D2RDxfbLlN98RUOqAz2yvv5pWy6Bv8rPaZl2iLUPDgow+XT5J5k5
         FZf+z1AsC0rHSdd8ZznqEvbSS57mMxTtrJ+trq3E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTAFb-1jxIpU159r-00UdLp; Tue, 06
 Oct 2020 02:19:03 +0200
Subject: Re: [PATCH] btrfs: fix false alert caused by legacy btrfs root item
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20200922023701.32654-1-wqu@suse.com> <1786699.e55IGcOCre@merkaba>
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
Message-ID: <cc82efa0-4f13-d22d-7fc0-bddc4d61a869@gmx.com>
Date:   Tue, 6 Oct 2020 08:19:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1786699.e55IGcOCre@merkaba>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tCUBQq1PQ0xvVnp75WMvxE5w3KHwJ6VTN"
X-Provags-ID: V03:K1:cL6ZZjw5zzystFTPKzPdMSQOYwinCnwx5R7DqJ1+VIREKLKLf4K
 2f6hpaXdSkkEDm47orueDsLL6YLVEHKtuPIKYe10sDISj0IX4AxdTxQhjTUm18U6H7TcaIs
 NI/LKYpBqOL/TCM4BIuG4axahQLmoBqNbO3qln66XFU4N6bPE0vbZu6Pv1+C2xktjLCNajl
 ptKs3Bg+g1o8NDCqC76Vg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xgGxfihCKw4=:MZmdRHqdQfGnidUhxL4djg
 WnQ3i6JrLfaCm1/PwvR3GCc8U8NvyjOajlY5QLP0hkvqbZVINrhk43bGxOEiVoivYPCGP9DL1
 ss8iHSfNpeOU0o6zkU8+FHIvn1gq5Pz7zuuxcx2GmDVlOKxTo8k6jt8Zfg0nrQvt7lcx+Xyu1
 qv8t556f9efK9eysqfoDNhsSMW+Z8Z7ewCw/OgqZs6f7fy80tl2+DgybeN6DCMxFOfm5PMgSk
 A690vH7fxe8xXJJLvJwQhIOsotYXlY/E7QcVauIPG6ccWW8JIjjorwMfuOa2elAzQkK1rzK4M
 FXMDwVfcpc9sHnpEY/cpNpWJ/Cq0n0TFPcIhq5y7D5SUgIy6MrxZO/urDCK5MwXpcsbDabNW0
 SugWPgSGxkniw5pD4yAFVUr3zX0Ibznju46DRM946DF+uSVyUib2aJlg2hHTtSf7M/HoGBAjq
 jhnGFlNKSpgDJ4EByY11sLJ24Ji8GjKr0WbZvocBBXrUBAhxp9EDjtQN69z7gGK+Gm58Pn2tu
 tNDNESkRGMqV2q7CwaQtLDJn70x5UtQAfTv0HPCqq3ht7tB451u+4Kt5Se7zQd/EijNFJLLcc
 VyOWf5CnDyu4AcwWefp22j2cUpM/LT+YWupcL2D3VOjGE2ejh7B0pxb8pfTdwpb6Q8NrwIdwf
 cy88henf1A3brn1jpGVdjIibGZyxPEi2ibNdEcqvVSQ9XexpTlDMRQU9HvY0M8ET557c3sqia
 0/wx5EQpd1HeB9R9iWAhXPg+TPCF5roOJNmTFis8HDmnNfmgQt9GRlx5vJMGeaMID3KNwx5/9
 m/rQpXrkJUtocziKKsBHf6w/oORH1cG/m1d3fLq8p2YpfVzMHuvlHLVow+QXztQ0Bm1haZmWO
 W+OhKZKo74KZYJ4cdzDvJ9ESyh69IAJvZ2JR5jYh8vrHm2yMa76YWtY0tXJo+T/gyI6ZRzml5
 LF1YAqNFPmIN6wtLl6Jc7ncr0c8pdcSUt7RbPG3Dja2W9jR2aL8MWlPXRvocE3EeQFsy0f3CL
 3pcPMjV+BOt3KABKVp3ex4bfiaDJX+COpJ+bpkzYIXDD6q3dv1prGqYU3gyhUs+Us1Cl7gfXd
 3HCdnUf2pXJrEys6qhonmjfNmGVMLQjZK+mg+3MuhW/Y+9yvX39zm7zZiY+NIn9ryJdtItGjH
 adYDThZ+kZBs7eWyUckskycB5Lf/OdPyQiTxlAGzSe+TVwGch+0NaJdTxEvCjtGPy6YQ+8pGf
 Kv4wt0mxC4xw/zU5quWnOIatRoL2H/dj6DLib1A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tCUBQq1PQ0xvVnp75WMvxE5w3KHwJ6VTN
Content-Type: multipart/mixed; boundary="wqvZnh1zElW1SbyJ69rrzkye4HeSVRzca"

--wqvZnh1zElW1SbyJ69rrzkye4HeSVRzca
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/5 =E4=B8=8B=E5=8D=8811:29, Martin Steigerwald wrote:
> Hi Qu!
>=20
> Qu Wenruo - 22.09.20, 04:37:01 CEST:
>> Commit 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
>> introduced btrfs root item size check, however btrfs root item has two=

>> format, the legacy one which just ends before generation_v2 member,
>> is smaller than current btrfs root item size.
>>
>> This caused btrfs kernel to reject valid but old tree root leaves.
>>
>> Fix this problem by also allowing legacy root item, since kernel can
>> already handle them pretty well and upgrade to newer root item format
>> when needed.
>=20
> Is this going into 5.9? Asking cause it is not in 5.9-rc8.

David has the final say on whether to go into a late rc.

But it's already in David's misc-next branch, which means v5.10 would
have it at least.

>=20
> Of course I can keep the patch and as the external disk has been fixed,=
 I=20
> would not even need it anymore.

That's true, so you don't need to bother the problem any more.

Thanks,
Qu

>=20
> Best,
> Martin
>=20
>> Reported-by: Martin Steigerwald <martin@lichtvoll.de>
>> Fixes: 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/tree-checker.c         | 17 ++++++++++++-----
>>  include/uapi/linux/btrfs_tree.h |  9 +++++++++
>>  2 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index 7b1fee630f97..6f794aca48d3 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -1035,7 +1035,7 @@ static int check_root_item(struct extent_buffer
>> *leaf, struct btrfs_key *key, int slot)
>>  {
>>  	struct btrfs_fs_info *fs_info =3D leaf->fs_info;
>> -	struct btrfs_root_item ri;
>> +	struct btrfs_root_item ri =3D { 0 };
>>  	const u64 valid_root_flags =3D BTRFS_ROOT_SUBVOL_RDONLY |
>>  				     BTRFS_ROOT_SUBVOL_DEAD;
>>  	int ret;
>> @@ -1044,14 +1044,21 @@ static int check_root_item(struct
>> extent_buffer *leaf, struct btrfs_key *key, if (ret < 0)
>>  		return ret;
>>
>> -	if (btrfs_item_size_nr(leaf, slot) !=3D sizeof(ri)) {
>> +	if (btrfs_item_size_nr(leaf, slot) !=3D sizeof(ri) &&
>> +	    btrfs_item_size_nr(leaf, slot) !=3D=20
> btrfs_legacy_root_item_size())
>> { generic_err(leaf, slot,
>> -			    "invalid root item size, have %u expect %zu",
>> -			    btrfs_item_size_nr(leaf, slot), sizeof(ri));
>> +			    "invalid root item size, have %u expect %zu or=20
> %zu",
>> +			    btrfs_item_size_nr(leaf, slot), sizeof(ri),
>> +			    btrfs_legacy_root_item_size());
>>  	}
>>
>> +	/*
>> +	 * For legacy root item, the members starting at generation_v2=20
> will
>> be +	 * all filled with 0.
>> +	 * And since we allow geneartion_v2 as 0, it will still pass the
>> check. +	 */
>>  	read_extent_buffer(leaf, &ri, btrfs_item_ptr_offset(leaf, slot),
>> -			   sizeof(ri));
>> +			   btrfs_item_size_nr(leaf, slot));
>>
>>  	/* Generation related */
>>  	if (btrfs_root_generation(&ri) >
>> diff --git a/include/uapi/linux/btrfs_tree.h
>> b/include/uapi/linux/btrfs_tree.h index 9ba64ca6b4ac..464095a28b18
>> 100644
>> --- a/include/uapi/linux/btrfs_tree.h
>> +++ b/include/uapi/linux/btrfs_tree.h
>> @@ -644,6 +644,15 @@ struct btrfs_root_item {
>>  	__le64 reserved[8]; /* for future */
>>  } __attribute__ ((__packed__));
>>
>> +/*
>> + * Btrfs root item used to be smaller than current size.
>> + * The old format ends at where member generation_v2 is.
>> + */
>> +static inline size_t btrfs_legacy_root_item_size(void)
>> +{
>> +	return offsetof(struct btrfs_root_item, generation_v2);
>> +}
>> +
>>  /*
>>   * this is used for both forward and backward root refs
>>   */
>=20
>=20


--wqvZnh1zElW1SbyJ69rrzkye4HeSVRzca--

--tCUBQq1PQ0xvVnp75WMvxE5w3KHwJ6VTN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl97t/QACgkQwj2R86El
/qiCiwf/b9H3fGBN3VWxg+swhLRFvaQ1Ja5RZgQdtx8nx5YYPlx1yloXRMRuz9vW
DXuLfS+SuAlySOaBm5Jnbk/UgeC95bNOk4tIBbUKbxt4NKX93423PZQL9TvbfmGL
2pCQeKJ4QMQzoujNMKSTmmD788nxE1mvCSAOC0V0l/z3O0sMw4N5OvNvOTolFz4r
j7U/MjhYXj3LhmWDTFvWif1I7Mbk91CG16u9v+GXyPUqL9KWu1xyfmCECZZk5HP1
HN5dc10GN42yU2yselr19sSYmpW6GCIGt8ZUBrWOkOtDp1aKK8CdjgPsuKwv40w0
S3iVPLB8tv3u2svGr7j6EklSiwstHg==
=B2Jg
-----END PGP SIGNATURE-----

--tCUBQq1PQ0xvVnp75WMvxE5w3KHwJ6VTN--
