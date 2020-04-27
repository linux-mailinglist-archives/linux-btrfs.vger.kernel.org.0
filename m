Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BB71BB1F6
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 01:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgD0XWr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 19:22:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:46535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgD0XWr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 19:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588029760;
        bh=idoPdixk8qsxsZcm5Igzq2cVSbq7tEvuH/N5OXDQwNQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UpT6o093DQTDpMHt2Jno/fZ8d1R08m4lu7weCRjDV0npq0UI4+bgdlxswBzC2iPpi
         S/dRW1TYAlcOxpvy+/rg6Sp/nAqLq8tSeE8T+i2dfr0AKIM67KiAamkHspfAGYM8OT
         r4/uHvSwEt1pls0d1Vgj9EJYu0moWfNgBChnQcKg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mt75H-1jDb0Q4BiL-00tSRl; Tue, 28
 Apr 2020 01:22:40 +0200
Subject: Re: [PATCH] btrfs: transaction: Avoid deadlock due to bad
 initialization timing of fs_info::journal_info
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200427065014.46502-1-wqu@suse.com>
 <20200427152934.GD18421@twin.jikos.cz>
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
Message-ID: <9b12de1f-2346-6a52-78cb-9658aa60dc1d@gmx.com>
Date:   Tue, 28 Apr 2020 07:22:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427152934.GD18421@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VHDFcxykKagu3QaaW7dRBfitrwkZ9vQA5"
X-Provags-ID: V03:K1:h1dtZeXKUgSJZ2dHMTwKKyYONKjT4eCX7ACbQ5N0WK08HtKtCTs
 LCdPQZSj1eyV3f0hv5fgu0DkQHkGB0lPAdNkDeV8i/AI7grHccRU5OriAPvpGJmeOD6CMNg
 TB0W5CSDscJVANLQspr/DU6jPuUVnppaEoYDdGBzM9hMvk3Id7t6ypRrf0GvPIKGE/nfDHc
 sWNSE9TANeHIJTZM03tdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OiRCcG5jQ2w=:FEokRi5GBVu57sniSyHUTp
 qf3sApqL5SQaVa32z0BX48uoWatWnshOu/N9HQulpBK2FjkPg+R5wKqS0sdffA/mBgEdLlEHE
 Ij5v780qbQeTMFj6XcD6LAtXuL8GqBLSkd8uk04PU4+Uf3iTIQOPEnhTA4PQ7RlM4NTK8+9dn
 QqJ7xCst4P+lM/4O+BwQieuJqm5XcV5eFIwSJ3TQ5kkg/Unyx6EVvoMgTaaff177c1a/UOGEj
 ni4hJbU5FDQCQlzfvNQMz0e3ZWVUwRbtb/TKPAp0TRCsNkgnotmohws7ifRtp2wYceHA0TR5g
 6XVY3LTowoJj1J926Q5JKIMGawKieH2EDXhqFulCl5m5QidNKmJJd5AoOt9xAsvPjfC5SX5gf
 5XHCGjXzny44xM1WKghGlwgs5y7WKxfoKy1LHbdgAVN3cxOCq5lHUpj+M3lMyOeSERmL0tIBe
 27EXnMXziaBhLo2pdPTPG43GmN1eB6k6eswOFCx3lgK4sK1ro/XZKIZUFb6IFdHzMtQAQ7Qiy
 b8vI4uXqtSovpFWgo0rMXjkpIgPrZkbhKega2NRsdt1urYCcgNmcgO2pjVtNCmZ8HY3P0VjdI
 AMQjzRuaAj9LGn7NYPVL+5DcW/+u4izea8G1YbC0cmFHgez1Ilm+Q1+pSyGWPNB1fZtue5VVi
 ClPE0NgBm2d/HH8D2zXz8XackNYdKSjlYw6rEDj7AOUHGd//j/s182o3NJXnPpqt1NkeZkAbq
 aehpJSvVECAkSzxq9wNEAvMaOGVTkuoyUlzQ9U/MaFVcBF+PoVq4/pd1BdS4Z5ZGgb2YwkEEL
 PtMlFfqavkvNa84/Obrn1Y74e0/w0ZlvpVPrciOEshAnF5HcewPbeeOLQ32ddHwsMkUhPcIe/
 DpV/w98MwiRE8uwbQo8UkLT01omPbpS2w0Fa0haRjgDZmDpgSwZ07F5XVVQUhFUqegsjHBmZU
 TOHozcuzNlsfZgj+Y0YdFnnzkgquhkV365wGckupW+IdbLXisRFYUFS/EEnaWqBK3tZe6fpPZ
 3KuCCsYU9fPc8bqoB/sdaONRhLsawLALYOqsYiEJ+575hHecLhUm04DnvdRK8gXLZi35gsa+a
 uJcSsOO73R/s5KJxANIsmFv+/pHFA8VT1S5TrlGSs7rGDpTh0pxXr2yAtHdAGAuXgiaD1mw8O
 m/pfcKblwbEGiYZWM0eUqH70L8uanAxxMaydnIypJK275/tEaI0W4LLH5U5y6Yg2Ppb4G1hQc
 A4TsTt30aQNjM6tn5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VHDFcxykKagu3QaaW7dRBfitrwkZ9vQA5
Content-Type: multipart/mixed; boundary="khQhEgLjQ75XtUUlLCmdqTRPGkcWvMUPl"

--khQhEgLjQ75XtUUlLCmdqTRPGkcWvMUPl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/27 =E4=B8=8B=E5=8D=8811:29, David Sterba wrote:
> On Mon, Apr 27, 2020 at 02:50:14PM +0800, Qu Wenruo wrote:
>> index 8cede6eb9843..132bf2f1aa0d 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -662,10 +662,19 @@ start_transaction(struct btrfs_root *root, unsig=
ned int num_items,
>>  	}
>> =20
>>  got_it:
>> -	btrfs_record_root_in_trans(h, root);
>> -
>>  	if (!current->journal_info)
>>  		current->journal_info =3D h;
>> +
>> +	/*
>> +	 * btrfs_record_root_in_trans() need to alloc new extents, and may
>> +	 * call btrfs_join_transaction() while we're also starting a
>> +	 * transaction.
>> +	 *
>> +	 * Thus it need to be called after current->journal_info initialized=
,
>> +	 * or we can deadlock.
>> +	 */
>> +	btrfs_record_root_in_trans(h, root);
>=20
> This applies cleanly on master, so that's fine as it'll go as a fix in
> this dev cycle, but there's a conflict with misc-next patch "btrfs:
> force chunk allocation if our global rsv is larger than metadata".
>=20
> There's a chunk allocation added:
>=20
> 	btrfs_record_root_in_trans(...)
> 	if (!current->journal_info)
> 		...
> 	if (do_chunk_alloc ...)
> 		btrfs_chunk_alloc(...)
>=20
> so the call btrfs_record_root_in_trans() should be moved after the chun=
k
> allocation, to potentially use the newly added chunk. The merged order
> is:
>=20
> 	if (!current->journal_info)
> 		...
> 	if (do_chunk_alloc ...)
> 		btrfs_chunk_alloc(...)
> 	btrfs_record_root_in_trans(...)
>=20
> Please check if this is correct. Once this fix bubbles through master,
> the conflicting patch in misc-next will have to be updated, but the end=

> result should remain. Thanks.
>=20
Checked the final code. Looks good, especially after that chunk
allocation, we would have less chance to hit BUG_ON() due to ENOSPC in
btrfs_record_root_in_trans().

Thanks for the merge,
Qu


--khQhEgLjQ75XtUUlLCmdqTRPGkcWvMUPl--

--VHDFcxykKagu3QaaW7dRBfitrwkZ9vQA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6naTwACgkQwj2R86El
/qhEJgf/W6scDEPmnrldbWuIGmeAYpZNp+vshpobhfaMarpl9si/a3DmjgUNEK8K
7Cp4YdLGyEQOdWKF8rtZEa4fcktDJBQsYgSQumP9nx2uNGykpABiVthhrDko7cNz
8FkZmqQI62nCat4E7HPwkHdX4qCWs0xQHtZhAoogBYMqm16iLBDvkJJ4voKSsPmM
/jsu1EU6wSgDRWa7a250qaR2k1S7vPyqVMOCW16BkZUk71U8AzVw/nj5VKIOu53T
+bzgvQWng2sbP+2+bzSTpwwBXOKpByLXUr2bU5k3oCBf3l4e2YaK/mW8m60ynHEf
Ojwn8pdnYNJeSq2vyB+ZtitcPYlEwQ==
=XUX9
-----END PGP SIGNATURE-----

--VHDFcxykKagu3QaaW7dRBfitrwkZ9vQA5--
