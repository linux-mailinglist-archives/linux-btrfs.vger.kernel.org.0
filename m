Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE921D235E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 02:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbgENAGQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 20:06:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:49915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732806AbgENAGQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 20:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589414767;
        bh=QAKJwFcloKZgFjZNKPs7dXI+ootwCCyu/1PD3S1AKB4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RkNYvvWdVx614AUaenbXlZyOqXHoDvSvwUSczeprJPVCqefB9uah2ZTTbzpAhHpX8
         /hIiQa3Fq66XDtUAKQs65Ur/8Bh4cwMvpyXdFVvxtlMN9Hrlpnu9FTr/s6FyPT//qP
         +Dw7PWqQLqS+0auNstSAwp61wIMQAM3XWQ3tHq5c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mz9Yv-1jDnFF3MN1-00wG9L; Thu, 14
 May 2020 02:06:07 +0200
Subject: Re: [PATCH 2/2] btrfs: Don't set SHAREABLE flag for data reloc tree
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200513061611.111807-1-wqu@suse.com>
 <20200513061611.111807-3-wqu@suse.com> <20200513140157.GK18421@twin.jikos.cz>
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
Message-ID: <08819168-7e48-8e91-c1c9-1f554dd2e4e6@gmx.com>
Date:   Thu, 14 May 2020 08:06:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513140157.GK18421@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PbPkvkF9PjrjULwWU6mcBPhecOhzVAahD"
X-Provags-ID: V03:K1:hb+qb0Fj1guqVQmAUBVFUr7c1vIWKnFX/drj5q7wCEXTveVdXCj
 qYLHQrb5m4GWx5dF+s/o+eCc32w6jvak5ZaR4EwxMSdTJ3MJ8x1xVXILrRP8Hg2O4hANzQ4
 le+znif77zq+nvxtLGKiD0Z4eWR3pvZoaoySjjx/EmQEESY8SCGveEEaeGfkFaT6s+QLCFc
 Cdj6hf20wHknG5ZmDSn+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L3+fWcu9D3w=:Y5OFiFtWXSRZ01vBGtV9eX
 Fpe5zhv9avRb/wpKR1YXBJsDG6XBW+qqe/fyP/ox1U6PzfYpnIy6/xNahIZDJ+Ioaca9bYb3s
 oGq3eTibzFaYhWv57EEA3JRzWBtRkaTFqtNBPcoo3tYsiHjoqkbXpbHyA+Qb/+ROkoZrFMj7Y
 sBv6DMvxSSRdE0Y5G4R8Ru6ke1748m52KyJolryIUft0tRqSWAWhHSTR81TGM5+qYLmimItZW
 n/uxsKQTgj6o2HFy25yhX3PdqdwbBPFmECttyNFPsDvLZNl1OCob4Tvn3hx/16ACWp8NMYphK
 StBhs+PEXVncMPPJLriy/rXSWmXIPtC7ex8bol7lL5NTUMFpvRlihkj9WC67hBBEEkZFpfCN2
 FIbMvJ3WuPOiH956gtWppzpBoQxmhMsbNPLy1jdOCGDdngOjO1bZ7zSTYFg/+sQxXypME5q7H
 EC7yosnelcbA1qR2sZKvFBaKCICTzWHgMQimeSb4NbgBH7yFk0FkBqYX6mFtexcH4Q1SCkFup
 16VpetenZA65lbxHlNqykGwaOXrPTVQXN4xS+lroORuDHlNvQWUugelZKTil3v4HirFBGOK02
 Q8oBuf1zezF4+Kary4MreFd1S+twCD2rgi0TyCgejmBxHvdXMo/aZT2bSJ7snBAWCaCV+KP/Q
 9BM8H4NlE1CzJManwdG1+Xru7KvX1mdDN5/EaBZwn5ZfW4suo+OwfoLSkN7dORfb7chfIo6Jt
 GuWtH8SI0TWUlRyH7vSyua/2DzaNuF+m3stSS+RADlNNWZYzEuBXi6a7v6hPTKbhT/mVU7Rt3
 lQK59aISjUXqTQojFjMK3X23ErvwuNcSGUp8RP75q1THbPpCrCHIakCyfyL3Z3Tu1MrJEWkem
 Z7nZn5ybguEaglGmwMz7hTnyXzrTGLSwctvbwZeC3pNCxTNDb5rtOJIN7TpxRlCdJolpewJ4X
 rxul1vw8M7luZdYLVr+vBdJytzytk/fRvZxfHKQQukhyQidFc1gPGbmty417eE95SsklQ/jQb
 DPPgkJuCIMoVYHSeiv0h+2AS7ztR34NFdCW9EWBehrCxKIqsqThjlPqoRWFnsKIQdwRZH/2Jt
 SrUQateMWakJlgV8l+8tK7HuQ1hqmwDoaPGhAjp0zzTFgGpkXLKfp3VUTH4gFMQzblRaM8LC2
 u3Sw1Mwas8cz4uowhGm2N+QiR04mpcT46VvuVN+GErshvK1bbuprtDZS8YgNaaRX323Zb1VBF
 NtMzqINVIU+7nNrAV
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PbPkvkF9PjrjULwWU6mcBPhecOhzVAahD
Content-Type: multipart/mixed; boundary="aoCDMXkNDv5hJ4IsoAaC0oUJKf9LjyPCE"

--aoCDMXkNDv5hJ4IsoAaC0oUJKf9LjyPCE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/13 =E4=B8=8B=E5=8D=8810:01, David Sterba wrote:
> On Wed, May 13, 2020 at 02:16:11PM +0800, Qu Wenruo wrote:
>> -	if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID) {
>> +	if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID &&
>> +	    root->root_key.objectid !=3D BTRFS_DATA_RELOC_TREE_OBJECTID) {
>=20
>>  	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
>> -	    root =3D=3D fs_info->tree_root)
>> +	    root =3D=3D fs_info->tree_root || root =3D=3D fs_info->dreloc_ro=
ot)
>=20
>>  		if (found_extent &&
>>  		    (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) ||
>> -		     root =3D=3D fs_info->tree_root)) {
>> +		     root =3D=3D fs_info->tree_root ||
>> +		     root =3D=3D fs_info->dreloc_root)) {
>=20
> Lots of repeated conditions, though not all of them exactly the same. I=

> was thinking about adding some helpers but don't have a good suggestion=
=2E

The good news is, only inode truncating cares that much.
All other locations won't bother at all.

The concern here is, INODE_ITEM can exist in trees without SHAREABLE
(REF_COWS).
The original exception is root tree (v1 space cache uses INODE_ITEM).

As we don't set SHAREABLE flag for data reloc tree now, it's adding the
exception.

I could find a way to make it more readable, by separating the regular
SHAREABLE check and two exceptions and wrap it into a function.

Thanks,
Qu

>=20
> The concern is about too much special casing, it's eg tree_root +
> data_reloc_tree, or SHAREABLE + tree_reloc + data_reloc, etc. The
> helpers should capture the common semantics of the condition and also
> reduce the surface for future errors.
>=20


--aoCDMXkNDv5hJ4IsoAaC0oUJKf9LjyPCE--

--PbPkvkF9PjrjULwWU6mcBPhecOhzVAahD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl68i2sACgkQwj2R86El
/qiV8Af/YO9zZBhCPNsbBWyNk7jIgkTlZU7xAoCK4uLL7H2gdhrCfp5ArlPGMB5O
oFX1+Fc4fG9En20joOlEX5OVbAXQv8AE+oVYRofBJSuH5Jp4Z7ZpjoFFPGZPg9fU
DAtZT7PeVQZCpGk+BxjfkVOvf+X2kenVfDXyRzYXvmQF346Vts5X+Xdub+3yEIMO
lxHw4LW0ZfFqRYPGhwO6oFxPSVwQAAASRTMt3q6A454vYMsICVky6UaIEtKSz0li
rIKGWAZAArKGRyuDM/BnDw6XyiWp0vVmydy7BFVpN8TPXD5VtEeBCTExa8MtFa2R
zzc/1upbG2N1C0sOAnzVik2xbYV9Zg==
=7q/s
-----END PGP SIGNATURE-----

--PbPkvkF9PjrjULwWU6mcBPhecOhzVAahD--
