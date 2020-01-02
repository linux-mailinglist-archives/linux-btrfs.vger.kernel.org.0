Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E8B12E62B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 13:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgABMed (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 07:34:33 -0500
Received: from mout.gmx.net ([212.227.17.22]:39225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbgABMed (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 07:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577968468;
        bh=2+QaiiLy1y89hbY81H5pF4KDtsluAaMEvIGp4wVgU9Y=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IvTVawZNVCPfuurY8HideOtAOjNqgpVvkig43FXAjJk5KgFcQcFjxKdvXbAl3IyS4
         q5dmE66igOw6JQ8EfuVXCHfvxvKrV5xUPy05yBov9/4OMAaU1ytS/tzQLv91i9TpDX
         dZDVCmIfz7gzps2NAxFrYSzO5t5PtXvBn2wXBzFI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwwdf-1jg58a0x7z-00yQyo; Thu, 02
 Jan 2020 13:34:27 +0100
Subject: Re: Interrupted and resumed scrubs seem to have caused filesystem to
 go readonly (EFBIG error)
To:     Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
References: <f15c0d2f-df61-17fc-667c-2b0eb5674be2@cobb.uk.net>
 <7798d1f5-d54d-e756-973c-f2ebfa456315@gmx.com>
 <09556f2c-be43-1363-ccbe-065c88f8d5c5@cobb.uk.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <e481748b-d31a-e9a5-8532-e3e77188cbe3@gmx.com>
Date:   Thu, 2 Jan 2020 20:34:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <09556f2c-be43-1363-ccbe-065c88f8d5c5@cobb.uk.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ccVHDrTJtaVT20An7qQL3rhpIdSqZNSqH"
X-Provags-ID: V03:K1:dgdTnP6Vh42l98STM4jY/bh99CYzhsiunR1sfQAutAK+htSJHug
 3uM2ndP6+M+U3lYRl3RgLrhnKVRx4Z6BofoPjavFnTg0ugVP4O3KRGHD7e5I08+aoPCNyBQ
 b32ggvDfsJSv2VTMMuolI9Yet5hIa1JnIHV3YTYdP4uj1bF0SXmjfSDbb+OVwXM7tQ86ooQ
 PdmWdkrUyVHAIkJRKJgZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sLfEPqaSk1M=:JDM69GV2CDOlA2Gq674xOn
 Xj0RvlMJiV9jMhJWv7IgPhnk6HRqPxKGC9NwS6AobvZ28W/X/qQ5/+2N+WySVzg0/PjSeqLJl
 9uQjxuHKdLgQZCinIljukyl3HUySevlPardh0riqofQVG0REz+9PBsnNZZ6nTtFGCt0u3+qrK
 1x575Uda5ZZWKSTkcghEwK4gnjFdSRL9iAx/5OwiUWmiB5rV1uLDzUXZG5D6xRUJ6DJ7av8FD
 79JpowoIyAYXI4FGw8NQd59JYXJQvtUUQT+NWQed8xkNwIEijeAn1ml1dRNYXssKy9pGgzA+b
 yKAmzDFKF/Kl+TrkQfG341m4uztVHLN+2PDHCnTR2v7CJ4VrIaVRGFVa9aCGPurMfiPLQWgLk
 wo41nljof8BiblFRXbEvn5B01Lu96mjO0/15sDb1d852m+giiRAqFzGlprC+eqoqOPsgJ44ym
 8BeW9wAxMTS38wOu//7E37WacivVWtyNsDLBVLUTFF8Y4mJqAoGqrCY+NsJSgz4ERQlxcd7Nx
 dWFM6QA6AHsIgDJAtIq62J9qAJU+GeNhJurWNBHeWPRA7hAHNcs7V4GaFl7Np0yeJOywX/Vvx
 YZsVp8ut2qj/VFDWB818QivhRF49jPV2kZ1LJIKevyGwi8KLevcC7dWeGHe5Nu7ziwAdIORWD
 v3Hql5SCccoS+XSZmHw3n4dnrOwC9J9hndM2ZTJbVglhFDf27N5WZ6zP2XckfonyAtzaVWxb9
 YaEiTG3gyW9sUiIEbOBH5aGkDr036+rrPsUKzI9OXn+woeT2Kd708N224V/fF6GxliAb65aeC
 a+cUm+H3IcQXdKlZF7kUBJQObKnjWCTXufCLBWNQMdteXlPsU1nnz7YxlGARlog1oU4IrktGa
 UadUQqKZ6EZ4+MSN6qE6l51WZQ/0bZPtm5X7/ETiSiDKbn93ShE5v7qGUlJl8OUOohodaZyCm
 GeDM8wONkLSX9YD0Bcp3Eyd11RJ5htyTorwBOYxINfVmiKUqXWfzig5xcYJPCfMM8D0GHaeCo
 RDgPsdrTbcy+mHrq9BJCCzPK5tE6AYx3dGaHlUridEAkWxmbnhmzPzdiZy9nAQ8zKwUFowpml
 BQWVNmYcrTn7SzOSekpjpFUMpdJwedPXQ0KZjGygExMfAcXXyGgH151uq3+fxPaP7d3VspkBh
 nk8mruNioEmlmsPPEtm0iXo7bGwPmAEjxl7wVrQFlGiOEvsfGANfFrak1qrhl8bs9Sa51LuWU
 n+02+/weD4ecW0s8c4TrHG6MAZB+HgC83z0t2coSIe0EuicudYPfOFbSe364=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ccVHDrTJtaVT20An7qQL3rhpIdSqZNSqH
Content-Type: multipart/mixed; boundary="j1jxtR6nfyFXafTgd7nJPVyPCRlYLoiWn"

--j1jxtR6nfyFXafTgd7nJPVyPCRlYLoiWn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/2 =E4=B8=8B=E5=8D=888:07, Graham Cobb wrote:
> On 02/01/2020 01:26, Qu Wenruo wrote:
>>
>>
>> On 2020/1/2 =E4=B8=8A=E5=8D=887:35, Graham Cobb wrote:
>>> I have a problem on one BTRFS filesystem. It is not a critical
>>> filesystem (it is used for backups) and I have not yet tried even
>>> unmounting and remounting, let alone a "btrfs check".
>>>
>>> The problem seems to be that after several iterations of running 'btr=
fs
>>> scrub' for 30 minutes, then pausing for a while, then resuming the
>>> scrub, I got a transaction aborted with an EFBIG error and a warning =
in
>>> the kernel log. The fs went readonly, and transid verify errors are n=
ow
>>> reported. The original log extract is available at
>>> http://www.cobb.uk.net/kern.log.bug-010120 but I have pasted the key
>>> part below.
>>
>> EFBIG in btrfs is very rare, and can only be caused by too many system=

>> chunks.
>>
>> The most common reason is the chunk pre-alllocation for scrub, which
>> also matches your situation.
>>
>> There is already a fix for it, and will land in v5.5 kernel.
>> It looks like we should backport it.
>=20
> Thanks Qu. I will wait for that kernel, and maybe stop my monthly scrub=
s
> (although my several other btrfs filesystems did not have a problem thi=
s
> month fortunately).

And the problem will normally not impact the fs, as newly created empty
system chunks will be soon cleaned up.

>=20
> I am getting transid errors:

This is not a good news. And in fact it's normally a deadly problem.

>=20
>>> Jan  1 06:51:56 black kernel: [1931271.801468] BTRFS error (device
>>> sdc3): parent transid verify failed on 16216583520256 wanted 301800
>>> found 301756
>=20
> I presume 301800 is the transaction which failed and caused the fs to g=
o
> readonly. I don't suppose it is likely I could revert the whole fs to
> the state of the last successful transaction is there?

This means some tree blocks doesn't reach disk.
It can be deadly, or just a side effect caused by the transaction abort.

>=20
> It is not a big problem: the fs only contains backup snapshots (not my
> only backups!) although it would be nice to recover the historical
> snapshots if I could (I used them to research a bug I reported to debia=
n
> just the other day!).

I'm afraid this depends on where the corruption is.

If it's just caused by that EFBIG error, and btrfs check reports no
error, then it's just temporary problem caused by transaction abort.


If it's in extent tree, it only affects mount or certain write
operations, but if you can mount the fs, it should be OK to read out the
whole fs.

If it's in csum tree, it will affect certain data read, other than
mostly OK.

If it's in subvolume trees, some directories/files can't be accessed.

So, please run a btrfs check on the unmounted fs to verify what's the cas=
e.

Thanks,
Qu

>=20
> Regards
> Graham
>=20


--j1jxtR6nfyFXafTgd7nJPVyPCRlYLoiWn--

--ccVHDrTJtaVT20An7qQL3rhpIdSqZNSqH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4N408XHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhipAf+LKVn+3jSeMZVcB8qqfWgtLtz
ZHsODriTEVSmaVIjUJtg5LtDDHLcKUIpSFpAkLU3NUHZnVioZexa0wSr8whOuAbV
upcXdQOC5lJWX4+XLL5QNT+ldEPSMe1IT4neCRBudsc8kgExqa0hZb2ekd1ECMr4
QeifQOsatFhfkC1w9PUlj+cHYrHe1dlVgSaV5oCWEoQvQrpcWWHMwEef7r1slfoX
LdlM8Lcjx5a330rW+PhuyKkro7NjrfhD7D/hRRolwMLgyrCzSOhgIb6YJFKv+4QD
shszn7NLsweEZz5aC4ORpANiQSuaNZkz5PdsdZA/jrHyIwecvtbQQEN3G/VuEQ==
=SdwE
-----END PGP SIGNATURE-----

--ccVHDrTJtaVT20An7qQL3rhpIdSqZNSqH--
