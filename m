Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33912161A7
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 00:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGFWoE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 18:44:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:51159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgGFWoE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 18:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594075439;
        bh=F65myfiiDDGa/s8dr5k+uOiYR4FX3WfX7VoPv3CSCxw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=M0K3tZ6UIZwxrm+3REJXU3VT6w7ONBysUvaFHweOwzp6ZVjsmgnr8oa72l/OWuNGa
         47maHfXVOYgODKW2JZ7cMxbEvrtRotwASSJpR/M1Dqn6zefZMkAtfwD02nlYQoTIVR
         iYYSKKmbFtAg8A8A/VZPtWqWHkfxA+gt1F5GnihE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmUHj-1ka7v52mnJ-00iTwV; Tue, 07
 Jul 2020 00:43:59 +0200
Subject: Re: [PATCH RFC 1/2] btrfs: relocation: Allow signal to cancel balance
To:     Hans van Kranenburg <hans@knorrie.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200706074435.52356-1-wqu@suse.com>
 <20200706074435.52356-2-wqu@suse.com>
 <14c1e755-fd6e-be72-3c2d-247ae7f57d9d@knorrie.org>
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
Message-ID: <ee7d390c-f676-8aab-f3f7-9b64f018ac39@gmx.com>
Date:   Tue, 7 Jul 2020 06:43:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <14c1e755-fd6e-be72-3c2d-247ae7f57d9d@knorrie.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EDfCbe03uCyF9gQ1NiVX168Q8Iupp0fKe"
X-Provags-ID: V03:K1:mCPUC9cNWcXPRrrZPaPWDar3BEBfVwCe5ZMtsk9ghI//tGeF/dD
 2wJbfta7xKo1P5sB8wsHhJOxXkKpBD72434ipVG342ymLp3DrmYP3wPeOUOAZprUM6UQKgp
 oN50yPVu1w0wr/pbkMIik1/5x3lkwObY6wkwVyscg0rP5LWfHs4ALzaIFd5/3gth9uOigf6
 I5UAszr+yLvFvYn00I2bA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EJ2NQKnzres=:TqvnrMvQWW9/hE8ji+w/TA
 cSR/kx1RGuuIicc3rQ7jPv6ERwT7DfJ+2GrZnO0kuWNJL5JKyd3LOQbzg3kbQ+O4DXnytRMPA
 iij7xpFhoDodAKhJiYTKxBvPwnrQFbM+Z9GpBxxJeZ5+1NvORM/4LUdxH+LoOX6fKeHC2/EJ8
 WWW712mpQcaBJVBjxKPqdpbdHlV/DlwKCnDIPIwJGfd0bvGE9kNUrpk43p/cskxOrUuZtb6px
 e4n4CCLd2E6vzdKF55RcHTwyjvdojauNw75u4gTBmbKCCC5ocKZFmnlgug45lJbiyxB1MvYos
 DKmNYQTZxd/dYQBPaipAr9CVFHWEXzMsjT8Rgamnwx+l+yMEJqOXc85Wn3aKEvBjDFH0WjbOh
 X7R/zpEJYLsLfTO9LWQloesTWMYNV6SU7I6bDuot6KrZea+WkWtIyD5VIotCsyap0bEg+rHC8
 oBc5rzrBXCUuedeEgbrpLx4vTY0Tuzn4cgMYhYyTyAA7iMKSX5+R9sjtfym5wnTUfHVSDW2a0
 7ok19tmLpB0gYeb7scPHcWzb8vZq4GIWeI0tLrDCDsxh3trwDu+ir5/blXJBmgWUaGafaDBGQ
 2OI+4oUzViCYa5A/s6Wd3bLDNKn90AXA3etOdLQaKqGFHSdTVzZ6d8oQl6NJtIAq0QDvvHK8V
 MZZys5PpDQobk4imCBM0pqHnwXB+olOxF1pJUvMEgPgvya73Hbj1Kpx8vvjmUkIc2NNIRmZXU
 iG+ddCmg8IVC8toYUFHd6RPGPXP/urE5J2KTya+fHxgga6z9S2qtqJ4qykoP8JNOicz4dW/5q
 LuLxcwxCVbHv3iyhR0qN2SSmVjHcH9vJlJvfwA3yYVBc+sxylaXCoUt0rUTqLU/GbRpfex6mq
 RShQb1TRZlVi2ISD14pbtmieH6CPjSpBR3VnP3pPUBn1kuGf1a7C9zbMkVAI8X0ChxQPZXWjW
 6sE8ZAA+ibP6ZuMQn+gMzBcPjMQ4CkNY1wWfxr/UlxhCCd6BZAAQxIv1RfX4NQEIib/VkvkNi
 jPXhGDfO2IpaeLn9W0XSrdBWEGacW4RowpKwKj1spyNG3wWRnlrJoTp1A7rVx9KiTuVXvU16c
 hrr7gsxKG0DCqwtbE705p8kXI6oVU/DQ5oGgEI8nFlNNjbCRkYklNbgO8xreaPOU7BDI6H443
 SL37+f9Pu6R2EBVnmae2+SHIInaXDsO3khCZpWbmxaXeUULd2c7zgBE4Wsye90c1wIpRjgG0Z
 3La9JwiSXulXzDq6K2wlV757lEAdWOUiSL6LRDA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EDfCbe03uCyF9gQ1NiVX168Q8Iupp0fKe
Content-Type: multipart/mixed; boundary="qxoMlL6OcPuTRENeb78SflDQ78fEak0Dl"

--qxoMlL6OcPuTRENeb78SflDQ78fEak0Dl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/7 =E4=B8=8A=E5=8D=882:19, Hans van Kranenburg wrote:
> Hi,
>=20
> On 7/6/20 9:44 AM, Qu Wenruo wrote:
>> Although btrfs balance can be canceled with "btrfs balance cancel"
>> command, it's still almost muscle memory to press Ctrl-C to cancel a
>> long running btrfs balance.
>=20
> Thanks for investigating all of this.
>=20
> Has it actually been unsafe (read: undefined behaviour) forever, or onl=
y
> since some recent change?

Forever.

That -EINTR from metadata reservation path is there for a long long time.=


>=20
> Or did it just by accident not cause real damage earlier on in the past=
?
>=20
> [ 1041.810963] BTRFS info (device xvdb): relocating block group
> 91423244288 flags metadata
>=20
> <- ^C made it stop here
>=20
> [ 1076.189766] BTRFS info (device xvdb): relocating block group
> 91423244288 flags metadata
> [ 1081.300131] BTRFS info (device xvdb): found 6689 extents
> [ 1081.311138] BTRFS info (device xvdb): relocating block group
> 90349502464 flags data
> [ 1089.776066] BTRFS info (device xvdb): found 215 extents
>=20
> The above is with 4.19.118. Now I'm trying this again and looking just =
a
> little better at the logging, I see that what I thought (it always
> stopped after doing 1 block group) is not true. With ^C I can make it
> stop halfway and then next time it again starts at 91423244288.
>=20
> Related question: should, additionally, the btrfs balance in progs also=

> be changed to catch the SIGINT while it's doing the balance ioctl, to
> prevent the signal from leaking to the kernel space? I mean, kernels
> with the bug are already 'out there' now...

It has no way to catch signal while trapped into kernel space.

My previous assumption of the whole ioctl thing is still right, when
we're in kernel space, we can't catch any signal.

It's just the metadata reservation code manually checking the pending
signal and return -EINTR.

So even if we make btrfs-progs to catch that signal, it won't work.
And even if it seems to work, it's because in btrfs module we're
checking signal explicitly.

Thanks,
Qu

>=20
> Thanks
>=20
>> So allow btrfs balance to check signal to determine if it should exit.=

>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/relocation.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 523d2e5fab8f..2b869fb2e62c 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -2656,7 +2656,8 @@ int setup_extent_mapping(struct inode *inode, u6=
4 start, u64 end,
>>   */
>>  int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
>>  {
>> -	return atomic_read(&fs_info->balance_cancel_req);
>> +	return atomic_read(&fs_info->balance_cancel_req) ||
>> +		fatal_signal_pending(current);
>>  }
>>  ALLOW_ERROR_INJECTION(btrfs_should_cancel_balance, TRUE);
>> =20
>>
>=20


--qxoMlL6OcPuTRENeb78SflDQ78fEak0Dl--

--EDfCbe03uCyF9gQ1NiVX168Q8Iupp0fKe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8DqSsACgkQwj2R86El
/qiAHwf/fxAv2frhYe1x1KxLbOnReFksD5ocGQtbVM0dHmRNO1H+Ex4CHcq6tjcv
khEQ/ZuYGsRKhWP91YA03LLhw2xa42k41fMV89MIiEdoZFEb26ZnsFzsYXFGvj7u
cA0k0wd1fBSF06YqudoY/AJDCubweJkVi871VP4hLYbs7ZlrIRcYw55jjTbmJmLm
Nqw1kz1zo/TEW+iTgOFnftl/sACLw3HsyctQBZUlsu0Q4Xkv+wqcdXWMjJG5YcdY
ofiIPd+/1kcluHwkZgNMHqlyRW6+A9vMz4iekUnehbiw4lRO89Re4jX8BCsT2Rns
lZQGDjeGtV90Zkwy+VVYLmx1VwcO9Q==
=K5zH
-----END PGP SIGNATURE-----

--EDfCbe03uCyF9gQ1NiVX168Q8Iupp0fKe--
