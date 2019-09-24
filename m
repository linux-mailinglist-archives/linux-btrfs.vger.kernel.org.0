Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE0BBC700
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389706AbfIXLlI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 07:41:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:54425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388764AbfIXLlH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 07:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569325237;
        bh=OBpCsWLO7gyHzxuIjB/Gf88EgPnEQ/tfJreL2Y7Bp+E=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VETFp2cxlVLoM0E5y3SLDvJgZMKL6ea62sGyGJgtavyqJivqRTpnp8sW4y4yjJd3D
         n64Izfg6KCt48hrCBObooyazH1fk4uKOPDjLR96HgeFSkeASzyET/+4pboHLWuKom2
         Qr2aZx/bZWSHZArMZIgombVAhogjBgR9+pW7MM20=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVeMG-1ieKk33Mo8-00RcOo; Tue, 24
 Sep 2019 13:40:37 +0200
Subject: Re: [PATCH v2.1 00/10] btrfs-progs: image: Enhancement with new data
 dump feature
To:     Anand Jain <anand.jain@oracle.com>, WenRuo Qu <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190704061103.20096-1-wqu@suse.com>
 <8e533879-f048-fd28-6d88-2222a4c8f019@suse.com>
 <c96b0f9f-6bb1-6497-d260-26705bc664e7@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <e037aa6d-637e-2ddd-88a3-17fd05f85583@gmx.com>
Date:   Tue, 24 Sep 2019 19:40:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <c96b0f9f-6bb1-6497-d260-26705bc664e7@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ERRBjnufMqNGLRWF6GO7uVHeLONNRwqnE"
X-Provags-ID: V03:K1:70n78DmsTTgp7lPq2RrhWjJK6MvOx/rPirNXZvSeAM88c+s3NMR
 rfaGRZlsWu0BQ1xieiptoeInjvcdS+5zfLrCTgy+gMBs5bS+9AfcBdTbeRva3q3jOaPNADJ
 JXVZ9Xiho/0veLiHclcHa+MiXEbSxIaRn8SSImkDguoYBUVjKg9FjidDlG8tURObVykaPoj
 yiEhYnEduILmi6eySqaPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:000aOeTzS5U=:VdzSLu57MsaHzGKec5EJRC
 0m6q8jaXh4tP5qilxR7qU2p5xNK7tYWKI+90sidVQ/GTfEzKP7TmMZTSWqBF7GQMucd+Uxpzd
 FlLi6NvUsbnO1WZgHGykLZvY11Rr1/KptV/1oWeyE5qf47g+KVVCP5GReW0IQWEp1uvbkHtGC
 f3lSpIFVRia+CvpYyntmf4/YWWozoCYtVQJa47uiMzGVsStZvru8TWsawy4g4jK1zc3vKN87C
 HsqFD+lDAe9701ym6I/zYeAVNi/vvwNUlF75AobdtzBvSc6Np40darjCZlyHX+8cZnhgxcZEM
 P6uFgFYI0jEF7wxgfVhUSuAodBRAjulwKGEd0cj7gPHhV7LpxWhOa5w9lXA9su2olJjiipUiB
 DcV6LbMGPnD8V8HhgZW4IpdXey9PB5NHuZIjmHEAch6oh/DiUx/F8YRX/MkwSTsSvhOZj4dDR
 9gkMMRTLXHunxKIItFHeu1x5916dPX6gsEHYdI849K6VRkDduxqy5a+IeOV1lS9X/NOpTpGJO
 RILAEPeb7L2ZT3K7xQgDXByiRG5zSebG2+LUZhqOqUlhVswXZcek+RN/BGoszcvx8qj79gBVh
 aWjbcOBjrUqPIchswT7tHs/y7lf2Z1pTGf1u7s3kbtuSFGSIkMGyKcNThCp38SzjgvoeGfIdB
 GI5Pk+4W73ioZjGsYxOfxJ2CU+gvO7rIBJnPOP+9bKEy0rsMT71hPt8XoJzgxcieSYAUh3z1u
 TleEqPY92vW4fMKrZ148cSoWxW9g1EJ95ipM4wr7gC7ETOLBqxbMU2Y9GKrAo6fpRX+soSaBx
 fDMw9+TIWtVfCqraOiLrMKA2NlauVfrH1QJgEXMh+LilqwzjTlyzGGHR1MpzZ3S9N+D2m3GaC
 v+RcJ33QGPEc8Z8nbfRmLTJgCHPuk7EzJ83Wq/kt9x8r9f/z4eZBrIkh1vxQrVudJ3o34L/Ts
 nNCY1cy6LSUhV3h0c8hRbQYYIYt3oK/I9mqVp9qYh0ChyvyAn6XS08wukcUZfuczIKx/1hDK2
 h/M31+5W+HvHqvW6oEhLqiRd5SEAdw8auibu1CmC1VuFhDcUnHpoEdAFkSxFHjHhRg1/CRtV/
 1OeRbMZIr5hCX1vtkFKUg1FN4Ey/IVPuCY7IhkcfqQasdO3vuwYfzZZ2KlfgeuTgUH7ZUSoSH
 e3sceSKTkq1b2sO/EZnh61wa+6uwcNA7z2XY+p9CBhyCQlZ9kAM+Ub7ThThR8Qy+0pW/AC2IA
 HF0Wuz0+IxVcoFogzWwtXhiPGS6/mF3guxBZPd/eOc3JiNExmwSAPjYBTMqc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ERRBjnufMqNGLRWF6GO7uVHeLONNRwqnE
Content-Type: multipart/mixed; boundary="vxfNgy3w1PKm8NVDPUvPtMPTppMH9czPi"

--vxfNgy3w1PKm8NVDPUvPtMPTppMH9czPi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/24 =E4=B8=8B=E5=8D=887:31, Anand Jain wrote:
> On 9/19/19 3:19 PM, WenRuo Qu wrote:
>> Gentle ping?
>>
>> This feature should be pretty useful for both full fs backup and debug=

>> purpose.
>>
>> Any feedback?
>=20
> =C2=A0Did you miss my review? There are bugs in the patch.

Oh, my bad.

Indeed there is a bug.

I'll update the patchset soon.

Thanks for reminding me about that.
Qu

>=20
> Thanks, Anand
>=20
>> It can still be applied to latest stable branch without any conflict.
>>
>> Thanks,
>> Qu
>=20
>=20
>=20


--vxfNgy3w1PKm8NVDPUvPtMPTppMH9czPi--

--ERRBjnufMqNGLRWF6GO7uVHeLONNRwqnE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2KAK4ACgkQwj2R86El
/qiDogf+Ila8ufSBD2NvMeA03s5DgfLS6KISTC5wBRUkkN8GS7unE3J5uSW5/v6U
9FFXV1V6KCrzHjfV3xIi0JaUbHJ2OrestyRT+zJdo+DGk9ppMsEgHRmeZEUXtL9C
W8rTEzQLSVvQwdU5OA+xPWYv4hPOKcckpytE7PRpepzeRqLWVu9ogZ+K8YlZUQkp
M4zvkfZZW0tkoJZZU5yfe/WCFupbgqDnW4plrFThciczlwSitKTecwMgCqMX/znf
i39dlRZBfL1MDFZmH66hmZ9GhG5hsdNXok05AsUHdwAaQqCNO9BHdJYGaQT08kIl
w+pyUcdK5gAiZAms3qUBHOHqYoxaKw==
=ZhxW
-----END PGP SIGNATURE-----

--ERRBjnufMqNGLRWF6GO7uVHeLONNRwqnE--
