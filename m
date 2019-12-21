Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 433CF12890B
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 13:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLUMRH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 07:17:07 -0500
Received: from mout.gmx.net ([212.227.17.20]:53119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfLUMRG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 07:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576930624;
        bh=UxJpGp/W3r7A9K5iRSZp1/8Z6DN7m9Etqdp+329OTgQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=cN54zT3LmQrPJzqxwDJVW8SHlt4RbSiQHOz4c9DVyY4nQWsf79EvBiyjM23EEOti8
         p+YPkY9MEm7W6s96CIiU7f4IyRHOTVWOrdYITO3rBH1WZ6KjaTz8JRJaXuIAIiYzB5
         zVhq4paM0W/YmMksAiU2n7ZCierh+hbM3vIUrA9A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mr9Bu-1humOf2yzG-00oES1; Sat, 21
 Dec 2019 13:17:04 +0100
Subject: Re: Kernel 5.4 - BTRFS FS shows full with about 600 GB Free ?
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>
References: <8bd55f28-2176-89f7-bd53-4992ccd53f42@petaramesh.org>
 <81dec38b-ec8e-382e-7dfe-cb331f418ffa@gmx.com>
 <e7204e11-bb45-b7d2-7e98-af4d52c306a8@petaramesh.org>
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
Message-ID: <9e54330f-0443-8a3b-d8a4-6377a3a55d0a@gmx.com>
Date:   Sat, 21 Dec 2019 20:16:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <e7204e11-bb45-b7d2-7e98-af4d52c306a8@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PhSgGB4B6fuEj7dSjhb3X00eZf+KGpLe3tOQz7W8Kp8Bg64lE+B
 LaTSZzblHGtHSFl3r0CGSsz/dfo93qjaOeDFNKAnB8PyOKAsx4NXeawXd7iObHW9ZmZRx69
 FoRY6VXJ1OBHXBxyxkSdYpqpFlzPgnF9U9pdH+kgFwNJhwwLyowx5Jh50YVTLbHqLu7zhzt
 MZu2YOUd4GGXBX5KyDAZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pC3O7rBi27M=:vYcfKcHUzQ5Kfs1eygedf9
 WmiUtfT7nFAEyL5kZMfzTNGnAq1DsQdc2z0NoA++rg8T+Y+1mXeJ79XmF9NF8oG9/JIz7V2oy
 XkdrgrNN7Tc6cCIUenuOpY6vLzE8PCDvV3IEGDu33UVPOuVK6rIL8tZbacX+lVd8GgV6u0REj
 u7/vCs5bjFTCFTSNjanjs9IK0KlSlYQhcbGm2HVVE49z67Q92aoYZOwpbPBN/koCm+Dh9AhIU
 rJKJmseV5igxpXDtBvmR6HEi/H9VoS59O433F1IAmmuPLU/M5ZBfqsXwnOG0bKLDbJ/1eFwkj
 lvHc/z59MA514JGwHT19BIRHas+kKJ4pgFwDm9B7SQFrI+KsMtIiOIJyGkeVv69uWFaPuwcKn
 8GOjH3trA62Mqy2aO3V9vdYEtKmh9LHTie8Iz32Mm9qKgsWRdSCSv4hvmBb6Ip+LZJ0Dccw26
 kqprV4ai1CHI+detNJ55VRdmGO7WkKuQIU+jPnZGuNfekgODM+VGdjzc03vMkhby9enoVaA4i
 A+4qaBH3SbQue4os5tA4OGcEAT45EmRgGdKE3jW3DTYx7FnMJDT2E+G6Tx6s6jg1D7mG3vqW4
 z8RMKgSdkfsQK5vYfFzJHFFeHpg1YIId4qlAw4G9hZRcSxLd3mRs0i9+2AbVjJrnPGU++uuDu
 BSmUP7cAVzfdtoTimoYttuEsKI0sGcKRLOBy0grqXuVRgiD4PJynSMc+/iptzQbMR8anTKdoV
 zZgl5UCHuJ+3I+T8oKjnLtngW3T5U5nhfnlsJQDvyC3n2WZnpjFZ8OMFbanBNavcJyX/AMHH2
 M1xQ+KB+kxyyjVvy7oob0G7i82Lz0UkoNSPYducDwngojjPLcwLgKzLo4sZTLPGpxhzS7SuqS
 ZGwq0OFHno2+3/4YW0BLNor/ljoOLTmdfQr2joSPjjRpX1FmPUnL4xlf3sbM7dP0fCMNRPCZU
 A/X+BNx7eH7E5TNtJqXDM/02viuanyHBUf87DPx89/fa5V8WnH0q9eGVoH1ByPITBl3Q64Bqt
 O/wMDNZAPutD44T55NXxgF9etWf5Lk7DFkVyqHnuqwoeMzjWbti2dlBqF7j+iPAjeLLHq46wX
 60Gdq/CmU9e7M8JdWu+JrCjyiVZ4XW2ReNRNT5lhZrVcKOQdIGnFVodtyUEKhlT7sTtYnB5Cw
 tUXkcApfJHiObNrDVo6zn0QTQLt5FbLkTuyDOX2RPwhro93xnyDb8MGAeAY4umr150QKIfiBW
 ck8Yv6MZfcpexSa/7UZ4EjhiUjTBnrIutZ4ALfg3DdIiBeMU5W+bitdNlYrw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/12/21 =E4=B8=8B=E5=8D=888:07, Sw=C3=A2mi Petaramesh wrote:
> Le 21/12/2019 =C3=A0 13:00, Qu Wenruo a =C3=A9crit=C2=A0:
>> A known regression introduced in v5.4.
>>
>> The new metadata over-commit behavior conflicts with an existing check
>> in btrfs_statfs().
>> It is completely a runtime false behavior, and had*no*=C2=A0 other bad =
effect.
>
> Many thanks to you for the quick explanation.
>
> I understand =C2=AB no other bad effect =C2=BB as =C2=AB The FS will be =
OK again when
> this is fixed in the kernel, I can leave the disk in my drawer in the
> mean time =C2=BB ?

You can even use it without any problem with v5.4 kernel, except the
`df` will sometimes bother you.

>
> Well I find that makes several recent problematic regressions in
> BTRFS... 5.2... 5.4...

That's why we have LTS, and commercial company baked kernels.

Thanks,
Qu

>
> I'm starting worrying about this development model.
>
> Something as serious as an =C2=AB Enterprise grade filesystem =C2=BB tha=
t has been
> under heavy development for about ten years is not supposed to be a toy
> that breaks every now and then and couple patches is it ?
>
> Or it would mean that it would ever stay a toy, not an enterprise-grade
> FS...
>
> Kind regards.
>
