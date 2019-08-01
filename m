Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85F797D7EB
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2019 10:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfHAInV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 04:43:21 -0400
Received: from mout.gmx.net ([212.227.17.22]:42521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfHAInV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Aug 2019 04:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564648991;
        bh=AOkMfmkNe8Im2Q5i1GImDr1Oh22wtjGbgPPCyp1i9Kc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fRSNyDOBpRKbWZbuuJUZrXkmoqTE6Exl5s2xNPBIcXE3KR+paLHaDTK0ev/g0aVJG
         VzPvr+a1fjE0uY+3eoDucJfpDcTmGM8BiX9Z8Vvc5tlZGTo/9bzIUz0rSrxwGbeFH9
         ei32v507G5Lj9CwIMsoYQBW+npDYY5vkgNl22GhQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wLT-1hzSKL2Oz5-007WHz; Thu, 01
 Aug 2019 10:43:11 +0200
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     Anand Jain <anand.jain@oracle.com>,
        Lionel Bouton <lionel-subscription@bouton.name>,
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
Message-ID: <e952ed13-07d4-426e-e872-60d8b4506619@gmx.com>
Date:   Thu, 1 Aug 2019 16:43:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e73421f5-444b-2daa-4c28-45f3b5db007c@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4SJgASsfu0abNca7xKEZLwZIGlnLbjxl6Zbf5PXJt1KKf9AqPtv
 qDRxtU2GVIiSvLC1C4gqrG17okMts3e1iYx+bJcKGnS0Gf0GtOLFI09StMu/F+GN1KJpNMs
 XkzIeQrUeeMb62mCVMtfT72JFoOSzIWQrf4KqoyZ5j35SF6IoCcbFr5NjW/K3bzPnBIX+uZ
 2gwyZ9l5PqUGjZW7ScHGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vXuVIYLSNYk=:eRp6ZFYYGIHSuDiyrk2qyA
 QMx90uNbK/9VNeaaLjig5FhNrPxCi2v7Dd7ZRnyDD9IlCz2eUtFkgWmNi32LBVM4hj8KbMUSc
 Y6neNFrYOPU7Zz2ujQ22VIxPk6ABTAkAIP3A6ZlFllPZN/L5vR2gO9MKSCBNjzvawhm23UsfP
 7izWiOlFMRW3F1BkDdlIqhE3gFfjgkrKwI6kmbKcfkRnm3+k1gy/9XCE20iFvfZzjpWLFKhR+
 ekAZtL4JEbegqucGK6mhtcZiWBaXRS6XRQcdQKmesx5aJo5vyDVP5ZGvtBVPBeYmSQ+wVBiLH
 gkXI6RxshcE3oDOkf9hu4ssTRdCwXx0lO3eN5svRAAu5J3GrlbuEc34x3yfjopEowsx8L2L+d
 lg3vnjndMNC2cv8TPdl2w6hKcSBhrcdsxH643N2UWiCareJrq58Q1LEqmO8FmqGMfL5SA5Iix
 W2PWzboZ9YLrtQ+/xuYiQRXYVA/Ni8JcQ9ShvYT+ira1sGPpKYgx9KP+dmLVGhns6ieUy/hJx
 3qt+Z+i5/ZMSlu20MiRzLVYoUH+TdLRXCvS2Lroaxq7O1lBrdz6WeZkYWWQEBEipVSK0HmXsx
 7CIa7lrhdXtC4v6oZRnULPDC7PhiTjWnYFbV/Q7bC4Tm8CSnKXXYNP6SMIbanXw87vE9vT6XI
 AMQGWT4eqq74PHc4F34CT01S/eNAK58eX366lgtEPyTw9PepSp1cxlBUjueLEmJK8rPKfKiOj
 hpEv8U4FoiKBeVjQ72SNaFGA5QBeaI+c1QhFfhMLiyGpFL/jSipDDJG2al11bK5IlEqJhvU/E
 ZqXNiKAaxyerpH+bmHVDOXy+1T20Ri8gabqAbw42OJI7JZBkT9PHoQdw3nlJhw6ufSuRdoUsB
 cBU6klE18LmytIo4rrvltPw4atPspp4sXqtBbk618KHOHKmqXkqEynwgdUsDNxR2ZU4avpTmC
 eFQLItVOEDt3z8RKaH3ST3Ci8Tp08NeOv+sAPxyV+H3+6Brcc5xmuOxovO9qcg7AgSKqIbxqx
 YzqjoJZLZYLwmkKb8DVrKB9EocsnPs0q0hTWzu5OdmAJC+y9959FR23W8Iz0hpEqadjX/bZXt
 kJEMzkLtIqv2GcQSAzGIU5NkEH9gDn0f9PO
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/1 =E4=B8=8B=E5=8D=884:07, Sw=C3=A2mi Petaramesh wrote:
> On 8/1/19 8:36 AM, Qu Wenruo wrote:
>> Could you give more detailed history, including each reboot?
>> Like:
>>
>> CASE 1
>> # Upgrade kernel (running 5.1)
>> # Reboot
>> # Kernel mount failure (running 5.2)
>
> No, it never was a =E2=80=9Ckernel mount failure=E2=80=9D, it was more o=
f :
>
> - Running 5.1 OK
>
> - Upgrade to 5.2
>
> - Reboot without noticing problem on kernel 5.2.1-arch1-1
>
> - Performed usual remote rsync backup using kernel 5.2.1-arch1-1 WITHOUT
> any error at 23:20 on july, 16
>
> - Quite unfortunately I do not backup /var/log in frequent rsync backups=
...
>
> - Machine does its usual cronned snapper snapshots auto-delete
>
> - Turned off machine for the night

So it looks like damage is done at this point.

It looks like some data doesn't reach disk properly.

>
> - Next days, boot machine as usual (without paying attention to
> scrolling messages)
>
> - Machine boots. Cinnamon GUI fails loading. Wonders. Reboot.
>
> - Notice BTRFS error messages on console at boot. Still no GUI.
>
> - Reboot in systemd rescue mode. Run "btrfs check -f" in read-only mode.
>
> - Get LOADS of error messages.
>
> - Tells myself =C2=AB Jeez the damn thing screwed up ! =C2=BB
>
> - Reboot in multi-user.target console mode
>
> - Notice BTRFS errors again.
>
> - Connect external USB HD for performing an emergency full backup of
> what can be.
>
> - Lack enough space on external USB HD. Delete a load of old snapshots
> to make enough space.

Indeed looks like some btrfs bug in 5.2 now.

So far, the common workload involves snapshot deletion and proper shutdown=
.

I need to double check the snapshot deletion with dm-logwrites.

Thanks for the detailed history, this helps more than the btrfs
check/log message.

Thanks,
Qu
