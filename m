Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622D885D35
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2019 10:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfHHIqv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 04:46:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:33115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730305AbfHHIqu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Aug 2019 04:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565254001;
        bh=AiQpJAasUk9yTYL15Po6iCVKJ8d6NFW6uqWsDIsbWTU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lBjxZmbj6VrIDwod2vpEHGvfjM2T902SqvrOlmqY6un5Fv3UfQ+N9sloVu6O6fisO
         bPXuB0E3RCJkGxAjSRPWuoyJURV3pNQ06NwbwnTY+WgGjx8leEZpF9+0lupPsSNCEd
         +YTpMiKhwZd6X1YVQCdnW49wCb/9nltTh1OCO0/0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LuP5z-1iM5EW3Cv1-011mut; Thu, 08
 Aug 2019 10:46:41 +0200
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        Anand Jain <anand.jain@oracle.com>
Cc:     Lionel Bouton <lionel-subscription@bouton.name>,
        linux-btrfs@vger.kernel.org
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <f8b08aec-2c43-9545-906e-7e41953d9ed4@bouton.name>
 <02f206eb-0c36-6ba7-94ce-f50fa3061271@bouton.name>
 <6fb5af6c-d7b8-951b-f213-e2b9b536ae6a@petaramesh.org>
 <d8c571e4-718e-1241-66ab-176d091d6b48@bouton.name>
 <f8dfd578-95ac-1711-e382-7304bf800fb2@petaramesh.org>
 <c4885e92-937c-8fc7-625a-3bfc372e3bf5@oracle.com>
 <0bba3536-391b-42ea-1030-bd4598f39140@petaramesh.org>
 <a199a382-3ea4-e061-e5fc-dc8c2cc66e73@gmx.com>
 <e73421f5-444b-2daa-4c28-45f3b5db007c@petaramesh.org>
 <e952ed13-07d4-426e-e872-60d8b4506619@gmx.com>
 <BD134906-E79B-49D4-80C4-954D574CCC68@oracle.com>
 <54d0f80f-a7b8-8b10-f142-c9b60c9f0d7c@petaramesh.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <69c47874-6608-2509-c059-659c4a1b6782@gmx.com>
Date:   Thu, 8 Aug 2019 16:46:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <54d0f80f-a7b8-8b10-f142-c9b60c9f0d7c@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C6twpCnAZlb7K+OkErgPO1rqyhjTRE33HD+7QWjQd2Nv6aKpPMY
 6jyovbCNYck4FYtbloPuaUJ8ixEOXRekIG9r05DtXlm0FT4CyFzBqQyvmNC9z1rLosjazdN
 /PyiLEhkh9e/r/gjia6w/GvaxOqVvyxx2dq5QX94KlnNjfTfJxKQhiq1jQ9ipPP3983qolK
 s41JUwPjjhNucUzLjIuiA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k7XVS7SSB8c=:82fw5emlh1DvSc927Ug2Ka
 YAsBQrQqnkA1cn633+WXInH//n3Aw3o49yKPARCVICvsAUobjDRuuF3TLvfyKa8jHU1fh5HWL
 dLKZDWd/vV6J/uvIK0TB6xRF9KxMZyqw49J49/Xi3B5HMPig2Am8+taWKr16c7OeAMdZdw5wl
 ypkn8mtgzfQspQqpTE7vgqGLicso1mG9cwuXXBl28yNePo9g9bS7qmElFmYTDaCZ6ahzudyVR
 j6xsQexv3bLyDuou1ZK6BEf1+Zrb4/xSnh/sTAsfkKA3LUr7bNaEh3mjGcfAyxh3zvMVFcByh
 BbLkx9CPV1/8BJ5r49lXSbLOA5wj1IIBQP5E0EAW7HCWN5iJekfEUu29GLzUW3n1jZlEdbPCC
 8Y2CYxKcGcHdKh9kPxxLSW0kdZdoQrJkwIt0upvU2lP+QfGP/own82GbUzAZYYQFQfAoYnTAt
 kmeYsJoKaGTtTtZgBm1eel0JRXmMO9YjHOXzXC1k1bee5UegIYuiWmEipq9NEKJN2BTV8R1V4
 xohVBp5zeDwkF+b2NMF+U13Y4/bnsh0DZI98fWwxomhiQxM0vqnsWKlHJ22+6/+iwUFJ3Gxn3
 jl9/3dpuNyusrRfLCBxoVdjzQ92xYkK//HgkjmcwvZtsS/dHznPUuP68z+ccnTKjNjlvIH0xq
 BSthXcxMKOUH6HyOWNqiIwPtB4W2GsbSLelVqaTVD0wLkfpFXsvCfTQ0aMziv8P222c9szq6N
 xvoBC7qoc90nkyY8T5b5jmP6TipI9RfciPQ0HsTYw52Cx88mznbKcVo9OjWnyfMIEM1sO981H
 enzT0oUp7btTKB+SiawjIm0ceeA55fiIFDC3I9w60vv+GksXTbAKiJIUQtbim3+UhFftpBq8H
 taZGnpWKuOPxd+XoaFDluMBVXvkkkqsvjvCXfYqflCKujSQRSNYnskJHK2RIIkiW4wQCAFKvc
 P3nlnieFtmYIWgpEvvOSig0KPg9QXlypafcXluBZ6ETVsF2fi5wnS1jsFGn/imWIEBSM4CSwo
 tD/gMfTIuT/Ao+NsVjVlBkbrmS7yh6V36nCUP6bYGeCKnhaZZLnK0IP2UajLlFisoa9fhdg5F
 Bm3VPSUlzkp5Mpz+nmZR4xBWhAElghXkrihvgJRSskepESaUq4/5DNcHIotdOvlFErrH24BX2
 MfI84=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/2 =E4=B8=8A=E5=8D=882:56, Sw=C3=A2mi Petaramesh wrote:
> Le 01/08/2019 =C3=A0 15:46, Anand Jain a =C3=A9crit=C2=A0:
>>  Swami, Do you have the kernel logs around this time frame?
>
> No, it really got lost.
>
> =E0=A5=90
>
Follow up questions about the corruption.

Is there enough free space (not only unallocated, but allocated bg) for
metadata?

As further digging into the case, it looks like btrfs is even harder to
get corrupted for tree blocks.

If we have enough metadata free space, we will try to allocate tree
blocks at bytenr sequence, without reusing old bytenr until there is not
enough space or hit the end of the block group.

This means, even we have something wrong implementing barrier, we still
won't write new data to old tree blocks (even several trans ago).

Thanks,
Qu
