Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F57760AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 10:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfGZI04 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 04:26:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:35603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfGZI04 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 04:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564129607;
        bh=4wKAQUe/2SeznEXQTior8F3yIlk6uh0BBPVnAKMxl0o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YVurt8UExSthB0GvdOcJauvh3d1n9l/OB2dFNACFIxXWofwOB/vW5u/f59r5J6xsB
         vBn8ztY+St1KslVLoKbsCw7Tv+bKCm7h+bp+nFRwyQ8get2mzTQ2J+Kb81bYVM/ERQ
         mSBnGeNCZbupk57NZTWwMmSx/E0zyalrNKOTqmiA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MqJqD-1iCSof2SUF-00nRUv; Fri, 26
 Jul 2019 10:26:47 +0200
Subject: Re: [PATCH] btrfs: fix extent buffer read/write range checks
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <20190726052724.12338-1-naohiro.aota@wdc.com>
 <d81154a4-dd3f-481f-92cb-25ea32b55900@suse.com>
 <20190726061300.gvwypjd32elqtkhu@naota.dhcp.fujisawa.hgst.com>
 <71f0399e-0719-ca8c-cb7b-aba5de5d0c5a@gmx.com>
 <20190726081518.ilukyrpdsrioiq36@naota.dhcp.fujisawa.hgst.com>
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
Message-ID: <539b12bb-200f-b53e-fa63-dba39aaeeb9a@gmx.com>
Date:   Fri, 26 Jul 2019 16:26:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726081518.ilukyrpdsrioiq36@naota.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C8qhMNW/nQTpbfzPpR8VVXhZaP7Oute0USVZAqwgkpeVhLoHzuc
 /85HppmWANLtNx8ecZPQgnPvXGGXBJmOygvuxfb7BcII/UkiY9xzaXAsAmQBg2PfggcWjyD
 nOBbnib3RewB2kYstglMo+Bo2rk3cAamRk0r7EF7DTQ2Qt8ygPUmS0IVAryqBAKPLdvTrgH
 ECsGrU8kEeaiu5FN8BWIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Rc8H3f3ozw=:OGNvx516+rdkeKiO5J86ce
 R5QFp+J/0rxZnOUsjcAXUTNyvJ1fDjQAWh5eAioKY0d+qmYZu2EdcjTHYM8meCwiPCZi5uoL0
 /EhIrUNdqN3eRJKBXhyN0/Z8YGHvblSJ9WhhGvJhL7cdWddWSmFYhgKeaDc2nQLhi18IkDsee
 F4xLSoxjZwGGV04ItjhwVa5VNp81AqlwDiOuYkZ0cOa+NubNBYBCYpPszA8HD14w/c4kCyj7i
 fnD8fD7ygDicbv4KoI0Z4jpm5V1fVLxRIKD7AD7J+hcC22wFywjIjUSIAZRlGBV220/sT2y8X
 ZlBHbQLeKHzB5tDCpXBUBux6rhobUApGkNlz29QnChEabDBR8r5ECmlp2R0jdBOkfRptZ+HNF
 9Xvz3hGz5l4C7hCcmQg1ecacVDuWWkug7N4aULnFeAIC9vGoG9PsEgaPbC9Qoh4PFZnPdqojU
 a+cwia1uLW7R25Bu+Rnlk410udFo7JRc3sTfiyG7/zGSz6+8PR6pM3ZtlEhB1D/pMq6eImuns
 i6BMJ4KDVpeYprhSuTEVqn0FFGQslp87ym2HfiUAygnV4ACRmiegFwTTzSMDlEQLxjmLkl8Ke
 r0+MuW4/5TYR2KFNcOaOopQlpX04mzxkbo7kSWoEnNBMm/tJOkDq6QtQAcxPKh/wSxXF/jgDs
 aerXzZfMKGJulr9VbECb+1OcTENi8XaDBxeAyUt6SB1CWrTZxjEB/8QEar8fYHCw+fHi80ckr
 4zbgeBD8Ro7tI4PlmRrZwDh1H+g9jTmdazeSWxwdC/966JEMOxKTEqTAEeWFtMXnePpCKBmdM
 4l5Hm9nEbdPBDZhUECpQdhw+wwHq3V25/ROcYUX7Poi2hvCsgFZwhNJyIsiYFnloJLMfHDQCW
 B9HMN5lkj+NsCbxGgMpXxV+plpd/grhNbA3bbrwyIfutA8qVj7W2ZjXP6WmnPjm2jDkLczxeG
 /mVRlNLdtGuQ+5cD1uedWebPb0Mx2QqyjJHmFtj4gA3NR/XswCqfQfVq2lY435xDOYkGv2lVG
 OvLJh16j4VageBygT5Bg6T9MletXKLTqI6sWxT6BdjOTmA7yMc5Lul+5a3Rnv9/TcT/qq/zSD
 AI1B/KP1WZnBXLPZ8sQus5sGgzCbhf4TqEt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/26 =E4=B8=8B=E5=8D=884:15, Naohiro Aota wrote:
> On Fri, Jul 26, 2019 at 02:36:10PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/7/26 =E4=B8=8B=E5=8D=882:13, Naohiro Aota wrote:
>>> On Fri, Jul 26, 2019 at 08:38:27AM +0300, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 26.07.19 =D0=B3. 8:27 =D1=87., Naohiro Aota wrote:
>>>>> Several functions to read/write an extent buffer check if specified
>>>>> offset
>>>>> range resides in the size of the extent buffer. However, those check=
s
>>>>> have
>>>>> two problems:
>>>>>
>>>>> (1) they don't catch "start =3D=3D eb->len" case.
>>>>> (2) it checks offset in extent buffer against logical address using
>>>>> =C2=A0=C2=A0=C2=A0 eb->start.
>>>>>
>>>>> Generally, eb->start is much larger than the offset, so the second
>>>>> WARN_ON
>>>>> was almost useless.
>>>>>
>>>>> Fix these problems in read_extent_buffer_to_user(),
>>>>> {memcmp,write,memzero}_extent_buffer().
>>>>>
>>>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>>>
>>>> Qu already sent similar patch:
>>>>
>>>> [PATCH v2 1/5] btrfs: extent_io: Do extra check for extent buffer rea=
d
>>>> write functions
>>>>
>>>>
>>>> He centralised the checking code, your >=3D fixes though should be me=
rged
>>>> there.
>>>
>>> Oops, I missed that series. Thank you for pointing out. Then, this
>>> should be merged into Qu's version.
>>>
>>> Qu, could you pick the change from "start > eb->len" to "start >=3D
>>> eb->len"?
>>
>> start >=3D eb->len is not always invalid.
>>
>> start =3D=3D eb->len while len =3D=3D 0 is still valid.
>
> Correct.
>
> But then, we can even say "start > eb->len" is valid if len =3D=3D 0?
>
>> Or should we also warn such bad practice?
>
> Maybe...
>
> Or how about let the callers bailing out by e.g. "if (!len) return 1;"
> in the check function?

Well, let's forgot len =3D=3D 0 case and make start >=3D eb->len invalid.

That len =3D=3D 0 is making a lot of invalid use case valid, and making th=
e
check more complex.

Thanks,
Qu
>
> Regards,
> Naohiro
