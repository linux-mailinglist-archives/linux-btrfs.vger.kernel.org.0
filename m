Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A656D78591
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 08:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfG2Gy4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 02:54:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:48007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfG2Gyz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 02:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564383265;
        bh=4b2YwEfDYjF6TxP761JZNW6O/ty2qJHAVWIFQlVecV8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gnXauCgy7CI/RhN6AshyNCEzUVpi/z/MrdO/AoQLmi+ObLNPUnRamfiS0GdjcrDQq
         fCJfbXLgmKPpbeef8BwmN7oJiDRf9TejykfEfXlJTv0szBF9i58CHkn346NPBDXx+m
         WqCvzfDN+PKhKibv9pABxpSdhtybObDFzrlrJ0Wc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N9MpS-1iURVs0sL6-015F14; Mon, 29
 Jul 2019 08:54:25 +0200
Subject: Re: [PATCH] btrfs: fix extent buffer read/write range checks
To:     Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20190726052724.12338-1-naohiro.aota@wdc.com>
 <d81154a4-dd3f-481f-92cb-25ea32b55900@suse.com>
 <20190726061300.gvwypjd32elqtkhu@naota.dhcp.fujisawa.hgst.com>
 <71f0399e-0719-ca8c-cb7b-aba5de5d0c5a@gmx.com>
 <20190726081518.ilukyrpdsrioiq36@naota.dhcp.fujisawa.hgst.com>
 <009c2be3-f09d-3dfc-6c95-8fa0e62d4f41@gmx.com>
 <c89565ac-4a23-a1cf-a889-e3da34d877a8@suse.com>
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
Message-ID: <284f9454-7be7-32e1-7e5f-2d5c3e6cfea8@gmx.com>
Date:   Mon, 29 Jul 2019 14:54:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c89565ac-4a23-a1cf-a889-e3da34d877a8@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:llFACWMRKJOKhEuHCaGoHNljaqraA1DhYmUTCi0b3Naf9laLwkd
 O5w5NxiBcbf72bFnK4QnXX2II4cVzVvDBhtOW1uJg6BiMoyFO3o/auaiaqt4POilLkcI3Qq
 6VXH2CMSQ+jir3yIfPe4y+ljW0tvv3Pbm14aaSXwJL4N7g5RmuRiIOmomQCEO9V2LCEWT6v
 9uAPGPrd7BI/hkW2nGxEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IMnl8hSoMn0=:OmOIy5N5+M1Zb/67kuNsES
 kVGhyuSekyJRHXdq8nNIBO6a5V8TbSELD4sG3cPWvBNsoNTpjIvsdjm6wiU51tMj/JNagU4JE
 rfnmNKbQTQMkY6N/yMewBPyGB2GQnp86FQ6xfKQjq15/FGqYYB+4bWeFnuLbVwhQiy4/801UT
 /NfFUvAsN/ssNt5KDenDfGEMuVWag7QL5i/vRj6sp434u6EGKEaFd6rpYtVOlucGuc/3q0WTT
 7DkAtoUDkkMS8OyWI/qNEepGF/i0At/npXD8KKPYhZhDWSWMuRTNwGoWZyr8Wx75o/uU8TJ4a
 bU9OE4Z5akIONSENOkBeuFijGrlwfEbonxBpnkhMjzUg4wcdNfJYgjCeeapx9M/45n9Cu+eM/
 V9aqTwNu4pfPSVe+QIcdU+qcaSnRRqQHPlKt0AgHbaBJJOHkMu8OLOVxc9J8/LAHO74Cap0TC
 bTW4V0PaNG+MBAvFdliGSYCYQec9Rm56WISpy30aNpjW/fvRoQ5g52rYsMyAd1yDBMKHadndH
 uWI8dmvnO1SgsPh3xDHr2XVtUxxJrdHOQESjx+9vTPyRTEuv/TUD2oNsNr4logNTBA6T7/W+8
 PPUjgkJUOEML/+t9Q3zXqly8DIBIWxaYlZ/pPLQwNjWYrVr91EdwqjvBAgyilx7vymOXz8ViV
 6eVL1rpaUQ+JQ8ivgZ+8FN8HAuntouEjN8fG5dS1IJtHFadDu0UANd65mkEAcAM1HWXlh0rdf
 B++Lf/I7IjC6RHqnfiIRjpvTbKYbyfA/Z5SrCfImqFNos5njuyL1bPb4dT96x7cPk0jKYSGLq
 kHfHOcKKLypzvjbBL/ePl0I65wMI6PXw0EPHQitLFOjUwnNL4aeYfrVOqDFGlMLB2ILH0NzNm
 dMeVO9Fqae9FLOFqmkxFKmi+mlIzAFUANxRXS/bvlTgiJyRmqA/1BSvwHk2d036uzLSvoTU3d
 5pTAJWPSFxgrQfgK3YZuK85SsBADybm++2PWV4j2ysDyiO28u4oCkBgq5JGyG6Pe4WzP6+2xk
 yRS+Cv47znEqXyFf37qeetpIBU7mo3TyhxBlDLebmFdSPdA11U5lE9tY0xAeXzWcI8QJr5nQa
 WRsKHR0ORYy8PU/lGuqUq2hAnfsDMbvhVC4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/29 =E4=B8=8B=E5=8D=882:46, Nikolay Borisov wrote:
> <snip>
>
>>>
>>> But then, we can even say "start > eb->len" is valid if len =3D=3D 0?
>>
>> Tried the "start >=3D eb->len" check in the centralized check_eb_range(=
),
>> and unfortunately it triggers a lot of warnings.
>>
>> Some callers in fact pass start =3D=3D eb->len and len =3D=3D 0:
>
> Isn't this a noop?

Yep.

>
>> memmove_extent_buffer() in btrfs_del_items()
>> copy_extent_buffer() in __push_leaf_*()
>>
>> Since the check of "start > eb->len || len > eb->len || start + len >
>> eb->len)" has already ensured we won't access anything beyond the eb
>> data, I'd prefer to let the start =3D=3D eb->len && len =3D=3D 0 case t=
o pass.
>
> In an ideal world shouldn't callers detect their parameters are going to
> be a NOOP and never execute the code in the first place? E.g. is it
> posible that the math in btrfs_del_item is broken for some edge
> condition hence calling those functions with such parameters?

This depends.
Sometimes we can save unnecessary (len =3D=3D 0) check depending on how th=
e
loop is written.

In btrfs, leaf item 0 always ends at eb->len, thus I believe it's the
reason why we have some loop generating (start =3D eb->len len =3D 0) requ=
est.

As long as we're not accessing any range beyond [0, eb->len), I tend not
to touch all these callers.

Thanks,
Qu

>
>>
>> Doing the extra len =3D=3D 0 check in those callers seems a little
>> over-reacted IMHO.
>>
>> Thanks,
>> Qu
>>>
>>>> Or should we also warn such bad practice?
>>>
>>> Maybe...
>>>
>>> Or how about let the callers bailing out by e.g. "if (!len) return 1;"
>>> in the check function?
>>>
>>> Regards,
>>> Naohiro
>>
