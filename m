Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003FD17B326
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 01:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCFAxZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 19:53:25 -0500
Received: from mout.gmx.net ([212.227.17.22]:46271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgCFAxZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 19:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583455999;
        bh=/aiF1L0oeWgrXmGgOm2xHjjnzz6DM6WUS91Hbp6PqeQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OJvyjGu4WJMTGVxVKmh1TuJvK/ygzjEMR7sib2NcGhXLzp6fYCU/QtBHjFcNWvoGy
         6alrNLHZT1n3bS9wrW2IEd0cpRR05pxb9gtPNr0YYhhb0q621J3plLM5aEYpEzb2rJ
         A2aQrFarU1Sv0u0/V6yPLHu8MYTkZvXv2EGTnafI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlw3X-1jaaTt3fGt-00j0Cj; Fri, 06
 Mar 2020 01:53:19 +0100
Subject: Re: problem with newer kernels
To:     Arun Persaud <apersaud@lbl.gov>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <e8904a49-bd28-46c7-77d0-d114627ce0d9@lbl.gov>
 <CAJCQCtT0CVBfupwj9wM3JAopg7YZ3FicLFGMo=is21CdyEg8Jg@mail.gmail.com>
 <aa4ba5af-1d0f-9db2-8cad-693b970bf843@lbl.gov>
 <dd0dffb5-e248-4498-dffb-4a6e6e4fd0fb@gmx.com>
 <99ddd844-3371-d496-701d-bc6ea9fb0779@lbl.gov>
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
Message-ID: <dd7f7fb0-a0da-cc8b-8af6-3b9c3bc2878a@gmx.com>
Date:   Fri, 6 Mar 2020 08:53:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <99ddd844-3371-d496-701d-bc6ea9fb0779@lbl.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XnCb7apqbBVLlYPrFipzHAmYUHWW5EBiE"
X-Provags-ID: V03:K1:nCHZF1+i7kwcuatdgu40iOhkan5K3uWeRzi4gnZHucbLzcwwgiX
 zqhAmhaxAbjuo0NXegF9qChwfihJfqhUVNtdrOa06B/Y2Bu9nvXF5s+kx/9hZuokSQVINIn
 UCSv0LOfhJT7qNyYpMh2DytV42metKyZTrt5TIld3jd8oqEtwOHveh8qIE6hUkkvSok+tMp
 8/JIJ2KRqgri7/bpECy8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nh3jMiSHIsQ=:7IURRnoCk7Bt6QqTY4jQr3
 3XxBsStdVc4dkH4IbJf9uEN/QbHfXdi1SbzLmsZ5eiVK9kXFnJpeMdN8u8ohnBl27FkaM02F/
 50mhFRfdI1XLT4H+DLJl0S01IOsBGU55uyTMLWNPSd6lpxs3npRcezUVfZ/28+kg46kcHlCHC
 G75HWh/TqGFyZso+JApNCNJcSreNZufyKNzyAEL2FgEApiceX9nEKZyqm6tDPgAgPBmI7y8RE
 IhJSWrVoYwAgq8ByLK/pBPmu5sA0lsFU7ms/HURI6o6wQILHC9vQeNjY/fxmQ/3qQgEmoyUYA
 QwszIxRPxzsb1SMmOkQ05LSh6PFUYOLKldPc6lO5KZ+KxoAtLcwBYdJbKrc1hy3FCFJN4oUOK
 XGkNpjALf/RFkrYxK6j76BhxLwTFKslQ8M+EQW22BNcTVSv6RasrpHSjLGXRa2jE7B9Cstq2q
 PA+I5HJ2pCKYZY8abWVSjd5SBErC+nNdqXMQ4QqODY7SLLWdriFk5AcJYCf/BMKpyJeEhJpor
 wgeMDpg6RQs2k/9gRZk9ZtbM5CRBBdDu5bVHGCjPX7NCRSZeft8gz8AmUu1f82r5rfiXW+4yc
 V9ERbIRGTTxP8Rv0fX9Yf4rst5hTFO+SaLBjAf6Drznv9BusnLO/1cABE9RAsVJzHCmo4xbCs
 eAbla3bWDcnHxXFvOetK/FlOSiAD8ZZSUDwu5f04/8hkJ695iY1oNrydv6s5cekX/QW/ibLzu
 420W/B5B/cEx90AwQyrDccIPUOfbMLmMQY9rYl1e6cesGIqqrVBCVDM9U3QAtylYmSHwe1+va
 CwSWC1ahvLvxbYs2962t1jBCHGZHsvCdH70ciuNVXAAAoYvM6m1B8eNPzIOb5v0ZdTdhBA7PF
 iuydUQomSuYNDOP8AXxa7m+qZAjaT25WcoNZRRWHbASqp0s9uZrQaDn4phBJZ11OpJHmUhVcE
 gOrWaxAK++VLtbgQBcH5ExkPXv24wwo8xJmjTIjal/eYmjgdCwU/CvarntyuqlSKDIClKvx/0
 +v/mHd2M2a7FX49N55lYPtg/6VzXRnPJd6Zz+AGheKDKeIKWoeS12KuPUG5RL4ngdK2i1DpRE
 g91Y8mubSl6krmmCb94XIHbapTlsvLrgq4UZrvguekzTSuCSSwEY8Y1bcKN2D65XjwUU7tfXC
 pONfBMS8+cy29K/W0B4E8e92yToIoc13zbcK0v4zQQ0yDsUwAGSbHJ8Mmi/YGU3kgqZ62pDkJ
 OGC0FC9bGIqbHF2m7
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XnCb7apqbBVLlYPrFipzHAmYUHWW5EBiE
Content-Type: multipart/mixed; boundary="mQja1ZyRD7PEoSUXxOvFt0hiHg5R0CTXL"

--mQja1ZyRD7PEoSUXxOvFt0hiHg5R0CTXL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/6 =E4=B8=8A=E5=8D=888:36, Arun Persaud wrote:
> Hi
>=20
>> [...]
>>>>> BTRFS critical, corrupt leaf...
>>>>
>>>> Complete dmesg is needed, thanks.
>>>
>>> dmesg is attached
>>
>> It's inode generation underflow, caused by some older kernel.
>>
>> It can be fixed by v5.4 btrfs-progs, by running btrfs check --repair.
>>
>> Thanks,
>> Qu
> I just tried running
>=20
> btrfs check --repair /dev/sda2
>=20
> However, it didn't fix the problem.
>=20
> I also tried it with the --mode=3Dlowmem option, but no change
>=20
> I then ran the same again to generate logs which are attached. Also
> attached a dmesg from the reboot after calling the repair function.
>=20
> Arun
>=20

That's strange.
As btrfs check selftest can detect such inode generation mismatch and
repair it.

If btrfs-progs failed to repair it, you can delete that inode manually
using older kernel.

`find -inum 131072` can locate that inode.

But before you delete it, please provide the following dump for us to
further debug the problem.

# btrfs ins dump-tree -b 14720090112 /dev/sda2

Please note that, the dump will contain filenames, feel free to remove
such filenames.

Thanks,
Qu


--mQja1ZyRD7PEoSUXxOvFt0hiHg5R0CTXL--

--XnCb7apqbBVLlYPrFipzHAmYUHWW5EBiE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5hnvsACgkQwj2R86El
/qipYAgAhyjbDNgFG9GwDy2qrfkrn7zwLIWZrVv9NhdhNiy2OjQmrJQFio7e8vd7
z/5Ax7oCFw+DF9lIWSYBrqlS9CJsPRVEow/RN8lC30enW+Vsgp5Z/zsRNTTHgTFk
kLbMkjKAJphkG8/ntRUxUAamVuIkBNGoMXOUzGeNoRsJkMwa/VfR591kJrcHBUk4
qzcHCzMBXLSRupqnt6k5Za15PkanlZSoay9GCZUAeIdpNvqzG95jf9MRCECjEm/9
8o1G/78RdhWa5O8w4WktChoVA6/HdKtnopPSq8fcwmo4oEgHFVXAa2ZjYkubTzOi
nBjDYaSMyqITSaSUjTe3tsk/k1PleQ==
=zR4Y
-----END PGP SIGNATURE-----

--XnCb7apqbBVLlYPrFipzHAmYUHWW5EBiE--
