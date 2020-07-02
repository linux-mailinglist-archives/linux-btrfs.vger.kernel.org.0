Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3C2212549
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgGBNy1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:54:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:33637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgGBNy1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593698061;
        bh=lK9jtckM+3oa6BfgahH5NgMY9MyOIZQvYIHAAY7uZDw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SAqRuoyTaXBx4maDMkPAICD/OsnMZ6S+mpUVAMKiAnUUJkBwyRS4fwD53U/IS74Cg
         Z+dikEB4Ux2tVWmPbPnP66X1l7nb7WJpJvLirwjqWZT1aPh/VMjVgoHJ38dtZMivmb
         BSlnwdJtq8OXefeKg4YgZTItvylpbutSDIeGhjLY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Md6Mj-1jHvlW0VGd-00aHyd; Thu, 02
 Jul 2020 15:54:21 +0200
Subject: Re: [PATCH 2/3] btrfs: qgroup: Try to flush qgroup space when we get
 -EDQUOT
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702001434.7745-1-wqu@suse.com>
 <20200702001434.7745-3-wqu@suse.com>
 <3ed599a3-3712-81ad-6d04-0889523cfa44@toxicpanda.com>
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
Message-ID: <f4f0e752-0166-538d-7376-17f7fefe44f2@gmx.com>
Date:   Thu, 2 Jul 2020 21:54:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3ed599a3-3712-81ad-6d04-0889523cfa44@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JFyBJVxrQqjbhDemuRJpqL2lE1rMSIQCx"
X-Provags-ID: V03:K1:qEieM8VUWEGcQoeBL1d0X2drMBM9CPUQ8d7BGCZGJ1EpybS7f4Z
 kySS78LZwkxT9/f8n8khhVzIvf1V3gjSayEj/qdFrp2FoVoWWsrBb8vSTFhAXpGDZOjBzaG
 qklQgsn4mW1j0ZhwUjaxvPeM9U+lobfwBfawmoX/wI0SjGrYeRIh9yHlLEbWgK1RbfVa5LY
 ZY3UKR1Cq6vgCoKo1MIdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ENcMTB94c64=:koM7M+dzXn2ve4zxqw2FWq
 NowgEGXq55sgxz6xLv8uGXDb0gfp0Ik5j5AJx7YqmaxNL8jSbeTLdXEsg0LChelgOkbgnhw8s
 QvGdQlapNidqg+FacXg6l/4VAICbng9zc1aDQqwGtqdvvpGzNBYmFMGPFZP65lZgAZiw9HOmH
 piHDJPmN85+9T9WpUHB/GQxiTIYmNS4st71tR0q4YGgiJYlxUcDjKkhMf8u/XUXVq7qJoaChj
 GiwgYf8vhixpOblECMwaZIeoUzYkBq0l7vUYZY2G6lqMRdV/09g6jVPs/MWvkIUUjVXrhNpjE
 AYHxY4hK9MRbBxmwdB5Q/OlgYf6sFohI3erVu6WtT9YkE0k8iYbOOeDGleveeZEurofywRGMw
 df8wJePVvUirI9i2tLkwXCFDosQht/irIkdArp7rmS6ki3n84163D85W1PLzoiJFezJ4A8DlK
 x+WdeMb6MDd6NG9wxG7NuaqQMmtYdWIkOslgzlkaduHnKEYK7Xg55fzp1jjNXFEUq2DwuElwK
 fEsBBfk9aRVXOoEavVihaTFoN6PSYeSG2Io4TeTU41t7j7rlAmu07eBF1LmW+XhAHFRQtrjkj
 boNjRM9FNHmS1B6jxl6DjJBFRflc36RB3gT0S/MFcJV5U220O6aZARDNbaXIw2XtXTp1211hM
 mqw0oPL5ahlEgzKrno6qDvNIenACLEsyh4guBTo98QLNPH9TjK0TToJjTSpqyhemsnmRXLyWT
 12hh0dtP46VlN2jJ0o1WQFMvbVgpwBncf34ZKKwW0SLuoiVGmfkQS4jjl/QppwJKZzv36Lyrx
 i/nCik8MUrT8B7dH4sru9LIe+5KFPzeyCemWJBQ1xikV88teFQZDgpy2MAoVaa4kBJvvFGCtm
 4qAFKiY+ETD5tGIsVTi9WQVtjQW+KtoP1/bpDPMdmBq5YwYSEgMjK3xUrBCkzscWs+d7i4Me6
 USE7yZJTsRZIxLA9Ao0zCums3QT/09oor4VEK2bY2dq4n1I2UKYR6p2+GQlq27CPJ+6JxR0hB
 rdNY1stkHQgb/byv71z5HQSZyZJlToPPYIabciMdTrLEnGVaGrHCI2F2s4o7l7gF3ZrZkQlM4
 sDqJ8wV67jybhuPRiW9hn8MSpkM7JqucdVxAcihc71S9fOrntpQq4DXE/KgW32VlFe6qRgBqG
 rNDfQOcG98n/DVn0BkDrdt+Lno5+zy2xc/UJ84wHu/BUhTjjXQNnXUs81UjucDPOrsjadGc7J
 mm8x19kc/r8QrrHGd
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JFyBJVxrQqjbhDemuRJpqL2lE1rMSIQCx
Content-Type: multipart/mixed; boundary="iUUndMQsNBM99Gn8G7dmkmBKsfmg6VDq3"

--iUUndMQsNBM99Gn8G7dmkmBKsfmg6VDq3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/2 =E4=B8=8B=E5=8D=889:43, Josef Bacik wrote:
> On 7/1/20 8:14 PM, Qu Wenruo wrote:
>> [PROBLEM]
>> There are known problem related to how btrfs handles qgroup reserved
>> space.
>> One of the most obvious case is the the test case btrfs/153, which do
>> fallocate, then write into the preallocated range.
>>
>> =C2=A0=C2=A0 btrfs/153 1s ... - output mismatch (see
>> xfstests-dev/results//btrfs/153.out.bad)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --- tests/btrfs/153.out=C2=A0=C2=A0=
=C2=A0=C2=A0 2019-10-22 15:18:14.068965341 +0800
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +++ xfstests-dev/results//btrfs/1=
53.out.bad=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2020-07-01
>> 20:24:40.730000089 +0800
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @@ -1,2 +1,5 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 153
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +pwrite: Disk quota exceeded
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +/mnt/scratch/testfile2: Disk quo=
ta exceeded
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +/mnt/scratch/testfile2: Disk quo=
ta exceeded
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Silence is golden
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Run 'diff -u xfstests-dev/tests/=
btrfs/153.out
>> xfstests-dev/results//btrfs/153.out.bad'=C2=A0 to see the entire diff)=

>>
>> [CAUSE]
>> Since commit c6887cd11149 ("Btrfs: don't do nocow check unless we have=

>> to"),
>> we always reserve space no matter if it's COW or not.
>>
>> Such behavior change is mostly for performance, and reverting it is no=
t
>> a good idea anyway.
>>
>> For preallcoated extent, we reserve qgroup data space for it already,
>> and since we also reserve data space for qgroup at buffered write time=
,
>> it needs twice the space for us to write into preallocated space.
>>
>> This leads to the -EDQUOT in buffered write routine.
>>
>> And we can't follow the same solution, unlike data/meta space check,
>> qgroup reserved space is shared between data/meta.
>> The EDQUOT can happen at the metadata reservation, so doing NODATACOW
>> check after qgroup reservation failure is not a solution.
>=20
> Why not?=C2=A0 I get that we don't know for sure how we failed, but in =
the
> case of a write we're way more likely to have failed for data reasons
> right?

Nope, mostly we failed at metadata reservation, as that would return
EDQUOT to user space.

We may have some cases which get EDQUOT at data reservation part, but
that's what we excepted.
(And already what we're doing)

The problem is when the metadata reservation failed with EDQUOT.

>=C2=A0 So why not just fall back to the NODATACOW check and then do the
> metadata reservation. Then if it fails again you know its a real EDQUOT=

> and your done.
>=20
> Or if you want to get super fancy you could even break up the metadata
> and data reservations here so that we only fall through to the NODATACO=
W
> check if we fail the data reservation.=C2=A0 Thanks,

The problem is, qgroup doesn't split metadata and data (yet).
Currently data and meta shares the same limit.

So when we hit EDQUOT, you have no guarantee it would happen only in
qgroup data reservation.

Thanks,
Qu
>=20
> Josef


--iUUndMQsNBM99Gn8G7dmkmBKsfmg6VDq3--

--JFyBJVxrQqjbhDemuRJpqL2lE1rMSIQCx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl795wkACgkQwj2R86El
/qj/Pgf9FCLxZoIcr+91DfwGlwIB1LZCqYImvq/Dj6Cdp5tNiTgx3JQh7vIXBS/X
O+edj0MZwaHoaiG7Rl5ZpAxm590/G7LPam9S7qayRFS6IfeZdC5H6o6nD+3sIsAJ
koxfWfdLILzLdB9YvC26jy3ntWGKMmSoPaxrmKzAgq30GnGmo6VFIAvdDObl1KWb
ZFPWJL3nUfcfyNEF3D84Y679+4cPLghwP55kkdUN4wfFOh3txElrkWeaacCdixru
iiw7EsRaubkXm6nTCu7MLDxoIXoFDXneu1XbxBeGXP63jZpZroQNtmTFbbNZdrte
RZv97dTrdbkki+I1PBchAkk7TgutNQ==
=mugz
-----END PGP SIGNATURE-----

--JFyBJVxrQqjbhDemuRJpqL2lE1rMSIQCx--
