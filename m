Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F7629D7DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 23:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbgJ1W1d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 18:27:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:46099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733286AbgJ1W1c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603924049;
        bh=RJbVGWREQfcUagoABzA1MmK1T4m0THk+Y3igpiIpC8c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=V9ce6e9KC87k4COcYqj6LPjhqUuRaV1ZIu5kma9IeF4HnM0teU6Em0cLxxPsJzuVG
         xZyyd+KLii5LSFvxXWj7cxhapyT6/HMVANbBX/4bReRa+34kGE2jHTDPanndyNAY9z
         3vhrt4rBlDsfdn4gDL6EvzOz3nOH6NxVNts6unP0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8ygO-1kUqki1SuU-00692A; Wed, 28
 Oct 2020 01:57:11 +0100
Subject: Re: [PATCH v4 08/68] btrfs: inode: sink parameter @start and @len for
 check_data_csum()
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-9-wqu@suse.com> <20201027001305.GW6756@twin.jikos.cz>
 <bb49899c-c25a-a4e4-825c-4c8a2ea4b176@gmx.com>
 <20201027231754.GG6756@twin.jikos.cz>
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
Message-ID: <d53118ab-8d9a-db24-26d3-1a4d66cbe2bf@gmx.com>
Date:   Wed, 28 Oct 2020 08:57:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027231754.GG6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jmDY94zTA6QZsgNNZRD9dl4w35q8yhxPI"
X-Provags-ID: V03:K1:vhfp+ujOHdQ/eCnjW6u4XUZ52K4YU5JviOsWfFPGKgYSU9m2a0/
 5Jd8Vho/AzlgXLJubQHlks7nt6Pi5LrrvjtC4lpIiPxq5MlghSWgssisfZ6bJX0zeGgriNH
 Wau2PeiHDNQyio6kYy4kSYTOqSSVAf6cSqDZDH/O17/GYNTRdc1PEl7xWqqIgb85zOSkDRz
 U0XMGhX07JOBkYtcgfNgw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gsh2QBqtJ9g=:R4EAKJgagW1jtUiK3tSrW6
 Qil7SUjHgOGEBD3n3A25jfFA0R+lSGG+eqGTRwHFzqEQV1AsXXSPwJv8+eZTBdb6kFPmembti
 o5g9pjhvlAwOM+ljgb/XYDRgv23ewWOmNp/Ky06yHWGnAg3l6Kv50xnWy+10egEAf0JqaupA4
 DFEYBp54MjfWHhQytvx+4d8ML3LfRhW1edNpnW9Aj2V/sPt4X7zP3J72aoYqp6oF9g1iuxdLK
 nhfQ10tDDZimy/xWZffN7U1gH7anbnAJziBB29lLOUNTcARfkSuMeeBLQDqMw3od7qed3l07t
 0cLCXKU0xEmGkBPMw57NFXiIUY/+M9L3tTn/sbjAgouOQLE2akZ1RzLMT4h+DvQCa+lG0xN/z
 a8WcwxLE8G3DFHFaVwJyVqus4V8ykQOwBGP+Gkc2GuZ3VooOL55+KtqH2aBBSUvwZwv+Y/4Es
 Bzkly9WDDzp7AxNhMg2pQ6asluou3lZvUwclGGusqhWRnWeLO08KsyCNGEfO1rTV14Lxau6Lf
 hDuaFNSM3Mn4p5mHQFOp2lRxBdsnDL7qioxno/IOtjf5JHAZ965WRmUKWkwEBa60FbafMk7H4
 3TC/INab/cXYDpUuk/XhSO2x474n7TCdeoSgbIqj2qVHioNo8bq76FQRxK+I2GisY2FNYyKK7
 YQLYP3J4h8bt2JPIzkdQ9VS4Jv8t7VkzY0msnJbb04zip1Hj3/zkFSes7P0x4osPE6UQ91P/P
 rdYYEcDcOZACzRsaipNJ9LcxoWwTt+jjzclh1mbGIBf8orHvHFbkxDtJMQqrFWkqbOfzD9o6Q
 1gMzDQ0pSFVYaWNUP8+XdahZNxO87BnHI+JSnKE84f/2vfglnFF+z2ss8T7aDqc9gLGm9zwM8
 /KTkCe5qJPlJh2loyvrQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jmDY94zTA6QZsgNNZRD9dl4w35q8yhxPI
Content-Type: multipart/mixed; boundary="rqmiQEmLypltsgU1a8g2lflo2UApgaLIE"

--rqmiQEmLypltsgU1a8g2lflo2UApgaLIE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/28 =E4=B8=8A=E5=8D=887:17, David Sterba wrote:
> On Tue, Oct 27, 2020 at 08:50:15AM +0800, Qu Wenruo wrote:
>> On 2020/10/27 =E4=B8=8A=E5=8D=888:13, David Sterba wrote:
>>> On Wed, Oct 21, 2020 at 02:24:54PM +0800, Qu Wenruo wrote:
>>>> For check_data_csum(), the page we're using is directly from inode
>>>> mapping, thus it has valid page_offset().
>>>>
>>>> We can use (page_offset() + pg_off) to replace @start parameter
>>>> completely, while the @len should always be sectorsize.
>>>>
>>>> Since we're here, also add some comment, as there are quite some
>>>> confusion in words like start/offset, without explaining whether it'=
s
>>>> file_offset or logical bytenr.
>>>>
>>>> This should not affect the existing behavior, as for current sectors=
ize
>>>> =3D=3D PAGE_SIZE case, @pgoff should always be 0, and len is always
>>>> PAGE_SIZE (or sectorsize from the dio read path).
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>  fs/btrfs/inode.c | 27 +++++++++++++++++++--------
>>>>  1 file changed, 19 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>>> index 2a56d3b8eff4..24fbf2c46e56 100644
>>>> --- a/fs/btrfs/inode.c
>>>> +++ b/fs/btrfs/inode.c
>>>> @@ -2791,17 +2791,30 @@ void btrfs_writepage_endio_finish_ordered(st=
ruct page *page, u64 start,
>>>>  	btrfs_queue_work(wq, &ordered_extent->work);
>>>>  }
>>>> =20
>>>> +/*
>>>> + * Verify the checksum of one sector of uncompressed data.
>>>> + *
>>>> + * @inode:	The inode.
>>>> + * @io_bio:	The btrfs_io_bio which contains the csum.
>>>> + * @icsum:	The csum offset (by number of sectors).
>>>
>>> This is not true, it's the index to the checksum array, where size of=

>>> the element is fs_info::csum_size. The offset can be calculated but i=
t's
>>> not the thing that's passed as argument.
>=20
>> Isn't the offset by sectors the same?
>=20
> Offset by sectors reads as something expressed in sector-sized units.
>>
>> If it's 1, it means we need to skip 1 csum which is in csum_size.
>=20
> Yes, so you see the difference sector vs csum_size. I understand what
> you meant by that but reading the comment without going to the code can=

> confuse somebody.
>=20

Any better naming alternative for that?

Or maybe I can refactor the function by passing in the current
file_offset into the function, and let check_data_csum() to calculate
the csum offset by itself?

Thanks,
Qu


--rqmiQEmLypltsgU1a8g2lflo2UApgaLIE--

--jmDY94zTA6QZsgNNZRD9dl4w35q8yhxPI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+YweMACgkQwj2R86El
/qjDEQf+Loo6j19HYKv98AfHTcZKCziLi/oDZG5rzZJey8iSfFxPuzVEnwtk7fFF
VFDLCCbiI/RGahAevPsD4LrHbn9TST/3zwJmFHHHUn7NfvXS3WBKt1XVAlHJangS
MQHQcxiW+87Z0sRmcNhBZer9ni/DukpHkFmeC971dnQQ+0djU96HisTMA4DUxRtM
qWIcw75XoGZqDfqcGdp8/OwFRF/CCC6Nl8pSnahlbnXnx714Wu3GLM+rNv9JkU1c
F3dAvlowxWKNnqW6CzTvt6u3AGtqI5jwxEA/CSu3UO0S/hkqcGWny9aVq2ZIO2CC
EfwKz2TNOonkZHWrszgKzlZActStpw==
=pWeU
-----END PGP SIGNATURE-----

--jmDY94zTA6QZsgNNZRD9dl4w35q8yhxPI--
