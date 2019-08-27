Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9C49E809
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 14:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfH0Met (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 08:34:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:59391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfH0Met (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 08:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566909286;
        bh=egx6QySEL9fLCqEeahcsFpMjr2Riy8HkM9VGsCH1TiQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kO6qnE4FUnoi+jycYrukn83XdYSHiksRpmI5/sEAvshN1lYrq91X+jvF0taHkJ3Rb
         Te3vZPeaoSxEBYA4e2OCHF4v59OwHSvGcEvRgBr4ccqeBTl3OymP7z5FUH9LzBh3WA
         5h/4EQL8QmC8+j37dWSwTS0gwYBs+LQO8WnJJmL8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJmGZ-1hmzbo44cb-00KB2b; Tue, 27
 Aug 2019 14:34:46 +0200
Subject: =?UTF-8?Q?Re=3a_Re=c2=a0=3a_Massive_filesystem_corruption_since_ker?=
 =?UTF-8?Q?nel_5=2e2_=28ARCH=29?=
To:     "swami@petaramesh.org" <swami@petaramesh.org>,
        linux-btrfs@vger.kernel.org
Cc:     Christoph Anton Mitterer <calestyo@scientia.net>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <18d24f2f-4d33-10aa-5052-c358d4f7c328@petaramesh.org>
 <a8968a812e270a0dd80c4cf431a8437d3a7daba5.camel@scientia.net>
 <5aefca34-224a-0a81-c930-4ccfcd144aef@petaramesh.org>
 <4bd70aa2-7ad0-d5c6-bc1f-22340afaac60@petaramesh.org>
 <370697f1-24c9-c8bd-01a7-c2885a7ece05@gmx.com>
 <209fcd36-6748-99c5-7b6d-319571bdd11f@petaramesh.org>
 <6525d5cf-9203-0332-cad5-2abc5d3e541c@gmx.com>
 <-z770dp-y45icx-naspi1dhhf7m-b1jjq3853x22lswnef-p5g363n8kd2f-vdijlg-jk4z4q-raec5-em5djr-et1h33i4xib8jxzw1zxyza74-miq3zn-e4azxaaeyo3abtrf6zj8nb18-hbhrrmnr1ww1.1566894946135@email.android.com>
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
Message-ID: <4aec59db-c4df-276e-28ca-586e8df89ad2@gmx.com>
Date:   Tue, 27 Aug 2019 20:34:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <-z770dp-y45icx-naspi1dhhf7m-b1jjq3853x22lswnef-p5g363n8kd2f-vdijlg-jk4z4q-raec5-em5djr-et1h33i4xib8jxzw1zxyza74-miq3zn-e4azxaaeyo3abtrf6zj8nb18-hbhrrmnr1ww1.1566894946135@email.android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bmPJ9DJZNjaFfcWU/GDbsS6roViaC2nEpsW7VqbvPmFeKLYcac1
 m8x5GQPkZSy17MRzabwpu9SvTNcwH60f5j3dKQPlMhMY0H0b9KpUvtbDGQMBg5xmCjPRJ/O
 7S1qb2amEe9OBbQoEnczBcXM2MfFYyPIDpl1Bc1v0QJ6Q+N2WXc8RMl48KZmbTDUo83JOjp
 w7yfhcgs8tWumSIvCOhPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qp2tI+3b5w4=:m8NUnWmg9N/mdh/+Td59Z2
 il3w9xN5niZmF7LFisq2YepRQ25AX25toulqDea1LNSWXbaF/NsO5RNoCXggaTgEMGr/7l3tX
 UJczjt22ImotWL3g7wv7OCUBk2OcH++YsiTEerp7YPBvB/kYl/f3Loc8LCEMrFNHWt268hSgD
 69SPh/bQU+zeX9fErppCaYrieOxaLGc9ufk4RzRWuBhuo7Oiq1T+Qaerbg2hyrPWdJYC9HUHH
 cwWOHeTyrbFt506EUNhhNVP6Y84fb8EhSs2B2xsnuFh7UX9XukmU0q1tmOkuz+Z3mQvpZ4Lbu
 NPrWVC4JSbZauLBLvoKXmIni9LnrguixcT6Er9VZ3rTMz3Inh5AcOZKrb5+i5z1IqJBe8rbK6
 oYPOTKzqUGg9w/TfVG+JImg7kytIce0UjnsKuj1BXzglvqNZq4HLCgohw8mBX9sV2UU39SDp2
 47V/VkhlLqPYad7zwWryJZ5dmP67pVSP3fRVQUGEg/E5c4gqcxmTWyH8455SPwfZ2r24EkWBk
 pcUNlZFSw7jF7grE/zu6nZkKUAxUQWFVDG4AAYrRfOiF5FKMP/RxRPn8B0blES50KDl5S1B21
 DJB61+LP4P0SxUSK7POhP/52JY3+5xwb7teXqsXxTdjOirCChJhYu1cq5WVZsnrNH8N7fAqCc
 0p1jJTwkzQY9y3oG8yEQUN+WzcQsHNmp/DsVpge3eJhfBuEyv2R5WficSD55YM6GIsUHenR7z
 4gFWVa4hKAlCAZLl50KjL9s6Wh3hD/MBiUyn1wTRqziwolxyVIbwEUpOF4+UKPR/v46W87oqT
 YnoSMbm3Tu00rr74PXnLRTrSQ/Vxa9/cixeNQtZ9P7rd5+jhAhl9SEyMC3L3KBZfaTi91G2Vl
 kohnv+NuT3r52sIoFDOaiaKofctK5o1xt7qz+2efFuU5Fka0vijjg+Yv/GO/Ik8/QClXcrKmd
 dLDHgo7s89SHNi91WW/BVGDdRagT7rFDI3qtZ/NPGzXXLx4LV6u/Wfg4/hJ6IzVsJ2HXnmeny
 X5jnWRqE8hkpqs0s87JYRMba+hF7t5GOpnxQe2buWj7W7LLPq+RcoKWqiXbiWzxic9TlSg6pa
 cAAVOyNL/YgZMOWL13WrHq5mkWrMsWoqzL0IyVQjSW26xdNZ5mr+Ff+NvNCjKc30T04XXiPc8
 ygAhdj+eKpwZb1mTzZ4ptkt14tAtKLvprLw5j0LQSTQXcJ8A==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/27 =E4=B8=8B=E5=8D=884:35, swami@petaramesh.org wrote:
> Hi Qu,
>
> Sorry for top-posting (my phone, uh...)
>
> I meant that I had understood that the V2 space cache was preferable to
> V1 only for multi-TB filesystems.
>
> So would you advise to use V2 space cache also for filesystems < 1 TB ?

Sorry, I'm not that familiar with space cache/tree code to do any
recommendation based on code.

My recommendation is, disable space cache if in doubt. Simple and
straightforward.

Thanks,
Qu
>
> TIA.
>
> Kind regards.
>
>
>
> -------- Message original --------
> Objet=C2=A0: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
> De=C2=A0: Qu Wenruo
> =C3=80=C2=A0: Sw=C3=A2mi Petaramesh ,linux-btrfs@vger.kernel.org
> Cc=C2=A0: Christoph Anton Mitterer
>
>
>     > or to use the V2 space
>     > cache generally speaking, on any machine that I use (I had
>     understood it
>     > was useful only on multi-TB filesystems...)
>
>     10GiB is enough to create large enough block groups to utilize free
>     space cache.
>     So you can't really escape from free space cache.
>
