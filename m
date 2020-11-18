Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3C02B88C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgKRXti (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:49:38 -0500
Received: from mout.gmx.net ([212.227.17.20]:39497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgKRXth (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605743373;
        bh=Dhcqo4QTdlr2qSMSjVMyZa6GE5dNoL1ujVQKX3wdQDg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jGyyzSoMFl3VUi6ih/AstVtDGTjTK2FvAFHsWxEwDmauvoWHElwAtfgR6/faWyG3w
         Qaxcfjk/adjySEFR6GOTXPnDkl2fPmA/ueDiEI7U9fyP0yCthK0d0WKL8fPbkhH0bK
         qE06yTlBaI8DnICwfYou0Vu8GL5lzSomk8W7reQU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbG2-1kNJta1gLG-00sgIq; Thu, 19
 Nov 2020 00:49:33 +0100
Subject: Re: [PATCH v2 03/24] btrfs: extent_io: replace
 extent_start/extent_len with better structure for end_bio_extent_readpage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-4-wqu@suse.com>
 <20201118160532.74rfxqovyjymzipc@twin.jikos.cz>
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
Message-ID: <f624c1a2-f0e6-7d3c-e963-f8aaf0ec3e6f@gmx.com>
Date:   Thu, 19 Nov 2020 07:49:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118160532.74rfxqovyjymzipc@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6PQMuRN3Z7KKNfSamafJsOwqv1YcqoS3F"
X-Provags-ID: V03:K1:OUj/oJ5ewA0DKo4UxM5fu93XfEPzAJxArwGrxJqBMAMy7Tfc1Tl
 gzS+vSJnAMqDQnBKCko8F3b8yeNdLBdLghQivgWeJUKYDimJyyQ0h4gl6sNNf1NT8rRJAZ/
 hu4ZwiBlgcQhkqTD6dwaV869ptA/THkKHjZXDPR8LfhqB53zXymsnplFISM1plh7h+cmyNk
 cel35i3XCkpwkh73KL5tw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gHRGs4jj8/c=:ZjURYPn9+7Rc9EMEGtNuBf
 Yse+KBRU+QqsWfNIEwZB4vZeR99S1hjUgv+TGHjRKgYGzAVOWZXr1rtxAI70uo1uMPmMt9M3v
 T9VriOe7eeMD1tnsskI62g1Err/W/Ca5XAHlbSA85ppBjitzn5NrOl4vLEp7nBaqiN6dUc9EJ
 NGV1QEtGPlJwmamo0DpdGlTmAXVCXQXFV5shcHvmBPxyg81KHRaoqWHvuwyQhlb1TDsiSOAPr
 MFWUg3vWdPWZUfZ3+Ti9fyWuq/eawD6F8EC1HVer6f3fZAalhGak8ilorA1E3GWm2Y2F41jAY
 fShM8fBaiYUeWbHwlItWHW5rfy9vkmLJeeIDiWOBAZbHf1/GdxuUOy5rsmRrClUfYWOTGg4wn
 FOsISFl0/sRDmfMlbSURXJZuXlHen//kKLojkZMhtPMmCXxuRDKJKimmDPwMJ3X3IH+FXSeG8
 k4sRLnhTR7q7extGbvKmKe7e+rEEluN+k8ZJICfl74hhla00awgalthoQsX8urcibJU69z+CG
 yZok9K7shLIiM6vjU6nkJ+Y64tELg5BPSdWGCeR5RYRFSHaHB0SEQ3dOTc4OsfhDejQcscPJs
 fk3T+7o268CybAm5LfP80+lHughmOSgK7N2fFcHPWIoMZElXyAopRte+no8AiMzKK49VANYlg
 /eeCkhdF0YeQ5LfhkxM44sVhUFKs5pn3IwI17zB+HUccX6Phz3jkHrEOoiMdyHM9dJGh1vLz1
 N1bWp+9wa1v3SWZxrYyUZ4MROWR0E84PTGS4VlVeQ7TZxTpAN1f/6gp/h9MkoOG7Cqv07Qc34
 l2MGbZVZ1qYxC1DABaAyaJApuwMOnbC/ucR25W3wmu8+8wxG0tTmQonbUeAxYIg17uNKOe71D
 NgOHiLsaA7x+n1BjPppw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6PQMuRN3Z7KKNfSamafJsOwqv1YcqoS3F
Content-Type: multipart/mixed; boundary="1NXsaFcKV7zzZEqmVmTnPGwmbSyYsyznv"

--1NXsaFcKV7zzZEqmVmTnPGwmbSyYsyznv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/19 =E4=B8=8A=E5=8D=8812:05, David Sterba wrote:
> On Fri, Nov 13, 2020 at 08:51:28PM +0800, Qu Wenruo wrote:
>>  }
>> =20
>> +/*
>> + * Records previously processed extent range.
>> + *
>> + * For endio_readpage_release_extent() to handle a full extent range,=
 reducing
>> + * the extent io operations.
>> + */
>> +struct processed_extent {
>> +	struct btrfs_inode *inode;
>> +	u64 start;	/* file offset in @inode */
>> +	u64 end;	/* file offset in @inode */
>=20
> Please don't use the in-line comments for struct members.

Even for such short description?

That's a little overkilled to me now.

Thanks,
Qu
>=20
>> +	bool uptodate;
>> +};
>> +
>> +/*
>> + * Try to release processed extent range.
>> + *
>> + * May not release the extent range right now if the current range is=
 contig
>=20
> 'contig' means what? If it's for 'contiguous' then please spell it out
> in text and use the abbreviated form only for variables.
>=20
>> + * with processed extent.
>> + *
>> + * Will release processed extent when any of @inode, @uptodate, the r=
ange is
>> + * no longer contig with processed range.
>> + * Pass @inode =3D=3D NULL will force processed extent to be released=
=2E
>> + */
>>  static void
>> -endio_readpage_release_extent(struct extent_io_tree *tree, u64 start,=
 u64 len,
>> -			      int uptodate)
>> +endio_readpage_release_extent(struct processed_extent *processed,
>> +			      struct btrfs_inode *inode, u64 start, u64 end,
>> +			      bool uptodate)
>>  {
>>  	struct extent_state *cached =3D NULL;
>> -	u64 end =3D start + len - 1;
>> +	struct extent_io_tree *tree;
>> =20
>> -	if (uptodate && tree->track_uptodate)
>> -		set_extent_uptodate(tree, start, end, &cached, GFP_ATOMIC);
>> -	unlock_extent_cached_atomic(tree, start, end, &cached);
>> +	/* We're the first extent, initialize @processed */
>> +	if (!processed->inode)
>> +		goto update;
>> +
>> +	/*
>> +	 * Contig with processed extent. Just uptodate the end
>> +	 *
>> +	 * Several things to notice:
>> +	 * - Bio can be merged as long as on-disk bytenr is contig
>> +	 *   This means we can have page belonging to other inodes, thus nee=
d to
>> +	 *   check if the inode matches.
>> +	 * - Bvec can contain range beyond current page for multi-page bvec
>> +	 *   Thus we need to do processed->end + 1 >=3D start check
>> +	 */
>> +	if (processed->inode =3D=3D inode && processed->uptodate =3D=3D upto=
date &&
>> +	    processed->end + 1 >=3D start && end >=3D processed->end) {
>> +		processed->end =3D end;
>> +		return;
>> +	}
>> +
>> +	tree =3D &processed->inode->io_tree;
>> +	/*
>> +	 * Now we have a range not contig with processed range, release the
>> +	 * processed range now.
>> +	 */
>> +	if (processed->uptodate && tree->track_uptodate)
>> +		set_extent_uptodate(tree, processed->start, processed->end,
>> +				    &cached, GFP_ATOMIC);
>> +	unlock_extent_cached_atomic(tree, processed->start, processed->end,
>> +				    &cached);
>> +
>> +update:
>> +	/* Update @processed to current range */
>> +	processed->inode =3D inode;
>> +	processed->start =3D start;
>> +	processed->end =3D end;
>> +	processed->uptodate =3D uptodate;
>>  }


--1NXsaFcKV7zzZEqmVmTnPGwmbSyYsyznv--

--6PQMuRN3Z7KKNfSamafJsOwqv1YcqoS3F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+1swoACgkQwj2R86El
/qjJ9gf/Yshxjw3ozLGqgwnOVRyTZcEuwcpdhsXNtNzqCFDbotBwYoQjRVhp8vN7
Ncgww/c1YyIgrTaKK/3UrIx53/HoSmn2T+QUbQwbCYomHwLDa4h+cT6pUcRBsQGj
fp2rF9XvM21bCjQoVrhwaa169tURY5ehpndbWgt7geghBDkN5ThA4SuqhD4tXitp
WTUJV457t9TJCaq5w5qi9jOl2t/zFW0+mK1ZhNOmU5dcxP7N+xXIQmX6vnkr84TS
np1asgUQFATIg8yAW3G/FbsVNe2DruSMSIWpQXreb9PnmsN0RJXHt+Wdn3+2UDOc
udopa3pv+kIlGgLNr0VG0XQUt/NCjA==
=gCkS
-----END PGP SIGNATURE-----

--6PQMuRN3Z7KKNfSamafJsOwqv1YcqoS3F--
