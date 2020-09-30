Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2609D27DE35
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 04:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgI3CDd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 22:03:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:35067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgI3CDd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 22:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601431410;
        bh=W98oOjEuclZ0eqM8JDQW0UPiHamX2APWYP5TnnkiTpY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lGdDMrvD3jziJgd+792Gu2KQOYsATPo4wpHcgK5Hkg/8XRruhPQUm4NJjUemg+Pjn
         T03L9K6EtxZHRULZhh/52xOIOMMj6zc2yGeWQAwEGFVLuND01ucdVgdm27q9uctt21
         OZ8iquY0jA92LclM4UdsgxzkuUrB2V7Evh7Swmuw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N33Il-1kZ1rQ1TZ7-013LEY; Wed, 30
 Sep 2020 04:03:30 +0200
Subject: Re: ERROR... please contact btrfs developers
To:     Eric Levy <ericlevy@gmail.com>, linux-btrfs@vger.kernel.org
References: <CA++hEgx2x=HjjUR=o2=PFHdQSFSqquNffePTVUqMNs19sj_wcQ@mail.gmail.com>
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
Message-ID: <c2d13609-564d-1e3b-482a-0af65532b42b@gmx.com>
Date:   Wed, 30 Sep 2020 10:03:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA++hEgx2x=HjjUR=o2=PFHdQSFSqquNffePTVUqMNs19sj_wcQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MGyyWyMLupsjwSZNsGb5ld5v8B4mLDDsr"
X-Provags-ID: V03:K1:GEQWNt7YE3VXLNthayAJUrxeWCEYKZvO2sSqdJFeQ2R1zgyaaIC
 TSg2BtSrYFhMg/pHf5Lpk3WEgTLGPhrGk+dqPwI9jUmRTjik3yXHcW1HE3HVWk/XeKS7MKA
 ZDTKuvu2S4W2YHu2zmcqqZ4DqErXj0+lt15P1Om9mDHsGpZonzsbI/+bA4qy/4KaqA0yWla
 U9btxoBHsoaR6C/WhKDGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xeTN4NkMONs=:FIP2c1khSaYgkzrOcitS8w
 0qVwl193kSdeu9xEt4tcUzc1dk2DBauYkM43d5409HMYd+dg1Z3EP5LgKY0hDlC2sj6WKNdf1
 vIEur1M7+DsqOdUkOdX/NpCYGmMyfFcPZEyaaK067NpChLqsoXkZwD2t16iKkabRrnAIRSFZu
 J2J5bBQlQo4pfAKb8y0McXxt9iH2mTXrYJFYycvm1GpwjkZp0NQlKlir3SiAdJhjptCNG8RyM
 b7bWR1g1HWfLN7T0K4/zwRbdjf8t4VJbOGz/bRhwmzHGfQYjZ1kOkQYXUj67DCLkHst2fvmrh
 Rrnrh1QRhcud34MUwMurtcvjpu+AfY3x3SEZkOk3tiKtqYfjeClJtxkWLAhLqjjMWyz9BzO/+
 5aanNoQgZXnEgzwvL/u4bkFavAwNR3MqpPRAz5jyKE5yfNi9TR4zm/h8X0MARW2L7NNSOfXU2
 FW2kPixMlzFS7dZxAXTR1xNBpnCxWhemVF3V4bxZWE48EwueF+AFb0RGUA2nd/2Y607oQ1ZZA
 An535IFqTpL+S4rnfCCCkwx5iXJPFYBLod1Vly/wqD2UNUqL7L3TOw86bNSFydYTVYKVbLmAG
 Gl271LFF1vUY1hQm6sZdptcIYqR90+5dsauigW0OMDUY2Uck5KZ1mUFqG7e7E6xgB2Tmq2TX/
 34POjDBVWj1V57Ht4fsAE+bs8W22dqD6sTlYHImu/GfxjGj8m/+NC1RGkXK5S255Izmaj8pZi
 iW3BDiEQTeysOWpvY9WBvXmYDo2bW5iue+yfPfS5Y6r7P8eMeCC71u2uw5OAKhjXIj2pBBIPI
 mZKMFJFCijJcxi9fO7IR6FGlrQ0xSwFY9aLa2HULLkt+04EkU5X9iDVju1lD1Kci7LsF5whY7
 zdtwRBzwonADxYWKQHSiGV4tWBlj1q79eu2p3iWXCwEbfcwCWFDgPOPq3+8i28UtXi62WBaLA
 UCSAPX5Vnoh8NGRBxc0dXPY62ruroWFLqRllXy/x0SRJNLJ0+YDJR7O5EynLRV5+p1DacdqC6
 6+PYCgkUdWLePe9ptkgSaQ3/8TLOkUclNoZ5wCrB58CGcFEkRPjEC/Px1wihtcQ+fcBplhoRB
 cnJwHrowvi8tpApnDZi22AA5WJdCHor+futFIBmTTH9C32fQyoUgyv3Cikpo+eMw7lG54trq4
 Ie45gwccYMw0VeHiSKBinls74g57Q/qqMh/FTjIhXrugMzDhYUIvg0N9XCjNo06ed0Qxx+t4L
 m+wC8nVFPoAmlhPec2q6YoNRgOsquzl4+rcHG8Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MGyyWyMLupsjwSZNsGb5ld5v8B4mLDDsr
Content-Type: multipart/mixed; boundary="CBRlebZ70CingcR07EbGSEIPpKJGdDChW"

--CBRlebZ70CingcR07EbGSEIPpKJGdDChW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/30 =E4=B8=8A=E5=8D=889:44, Eric Levy wrote:
> I recently upgraded a Linux system running on btrfs from a 5.3.x
> kernel to a 5.4.x version. The system failed to run for more than a
> few minutes after the upgrade, because the root mount degraded to a
> read-only state. I continued to use the system by booting using the
> 5.3.x kernel.

Dmesg please. But according to your btrfs check result, I think it's
already caused by bad extent generation from older kernels.

>=20
> Some time later, I attempted to migrate the root subvolume using a
> send-receive command pairing, and noticed that the operation would
> invariably abort before completion. I also noticed that a full file
> walk of the mounted volume was impossible, because operations on some
> files generated errors from the file-system level.
>=20
> Upon investigating using a check command, I learned that the file
> system had errors.
>=20
> Examining the error report (not saved), I noticed that overall my
> situation had rather clear similarities to one described in an earlier
> discussion [1].
>=20
> Unfortunately, it appears that the differences in the kernels may have
> corrupted the file system.

Nope, your fs is still fine.

>=20
> Based on eagerness for a resolution, and on an optimistic comment
> toward the end of the discussion, I chose to run a check operation on
> the partition with the --repair flag included.

And obviously it won't help. Since we don't have extent item repair
functionality yet.

There is an off-tree branch to do the repair:
https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair

You could try that to see if it works.

Thanks,
Qu

>=20
> Perhaps not surprisingly to some, the result of a read-only check
> operation after the attempted repair gave a much more discouraging
> report, suggesting that the damage to the file system was made worse
> not better by the operation. I realize that this possibility is
> explained in the documentation.
>=20
> At the moment, the full report appears as below.
>=20
> Presently, the file system mounts, but the ability to successfully
> read files degrades the longer the system is mounted and the more
> files are read during a continuous mount. Experiments involving
> unmounting and then mounting again give some indication that this
> degradation is not entirely permanent.
>=20
> What possibility is open to recover all or part of the file system?
> After such a rescue attempt, would I have any way to know what is lost
> versus saved? Might I expect corruption within the file contents that
> would not be detected by the rescue effort?
>=20
> I would be thankful for any guidance that might lead to restoring the d=
ata
>=20
>=20
> [1] https://www.spinics.net/lists/linux-btrfs/msg96735.html
> ---
>=20
> Opening filesystem to check...
> Checking filesystem on /dev/sda5
> UUID: 9a4da0b6-7e39-4a5f-85eb-74acd11f5b94
> [1/7] checking root items
> [2/7] checking extents
> ERROR: invalid generation for extent 4064026624, have 94810718697136
> expect (0, 33469925]
> ERROR: invalid generation for extent 16323178496, have 94811372174048
> expect (0, 33469925]
> ERROR: invalid generation for extent 79980945408, have 94811372219744
> expect (0, 33469925]
> ERROR: invalid generation for extent 318963990528, have 94810111593504
> expect (0, 33469925]
> ERROR: invalid generation for extent 319650189312, have 14758526976
> expect (0, 33469925]
> ERROR: invalid generation for extent 319677259776, have 414943019007
> expect (0, 33469925]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> block group 71962722304 has wrong amount of free space, free space
> cache has 266420224 block group has 266354688
> ERROR: free space cache has more free space than block group item,
> this could leads to serious corruption, please contact btrfs
> developers
> failed to load free space cache for block group 71962722304
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups
> found 399845548032 bytes used, error(s) found
> total csum bytes: 349626220
> total tree bytes: 5908873216
> total fs tree bytes: 4414324736
> total extent tree bytes: 879493120
> btree space waste bytes: 1122882578
> file data blocks allocated: 550505705472
>  referenced 512080416768
>=20


--CBRlebZ70CingcR07EbGSEIPpKJGdDChW--

--MGyyWyMLupsjwSZNsGb5ld5v8B4mLDDsr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9z524ACgkQwj2R86El
/qhnbwf+Jlxon38xt6FUB0ooFFTAx5KwdzTrEi8R2xVwWZ/I25dn8AwBLD/gNyIU
OsKc2MY3gPLG1bXqyX3Ii2iWg0xRoC/V6BZ/X2dhSOWO753l1alNAjUxzQRZQ/5l
XJAFvfvgBwPRUQl+hW/EaZV3pz96t5jDdM0eT6ykULKHIhDFDSGmjr1vtVINNqiU
zLsIoVSuf/STIfqgZyNQYZCl+fnyz0Bimni+R0acQbkYPFhCL0NsSczC/rbgcNZS
pXEK+k783wSaVYqLMnzYTFCF4FZ32nz7uiiAeKBC6mtcuD05vEpgl3zJUTNOPpWT
tL+ffvV4gK3hlnrZ25MbNm1IGPEyVw==
=hYVA
-----END PGP SIGNATURE-----

--MGyyWyMLupsjwSZNsGb5ld5v8B4mLDDsr--
