Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6AD7D594
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2019 08:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfHAGhG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 02:37:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:53839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730012AbfHAGhD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Aug 2019 02:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564641415;
        bh=1gI3ACTGZAF9w79OnCNRVv1MdrQFQn2bPx5Ljq0Gp6E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HVjRYETwcwU+83p+Utn+OLBtVu70ggMZk0LBgS+rSUw9tB9UQwbjCT0Niyk5K9k7n
         EI4LvxRx4dl8PaDeCLx172EmBIxxRIy4HgNlmJsxOTnYKtd652PYp+EH+YNoUw6kDI
         C6GipcojereX8pdlCLyB7tJsuJQXvLwwHwW+PLG4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0McluX-1hboyF3tdB-00HwpG; Thu, 01
 Aug 2019 08:36:55 +0200
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
Message-ID: <a199a382-3ea4-e061-e5fc-dc8c2cc66e73@gmx.com>
Date:   Thu, 1 Aug 2019 14:36:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0bba3536-391b-42ea-1030-bd4598f39140@petaramesh.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CNTmGxGHsZa+ih/sll5sCz2ze8vhlwfOokE3d+b5hfZCFXjxTvi
 kxx7uDZh0Sm2nY+bUf4BCH82nbm2YC9YLwhUj1XMruJJsbj1haXO2hYPVijhMBm+YmtHgfY
 GKnvAuMAPjjoQw/gKZY7Tk5LE1NOKJvfKlSxnFVNA/1NqpfnMePV/KnRRlV91UrzTe9AGz5
 5MLk9rVsS3YOeZ2v8OyaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0B9zRJKX/K8=:zWNOa+9AdYhUS9GvBELPeM
 Gu3Q51jSCFC/RKWLHNqU7EBD0vA8s3d8E83XjpIhTX+k76F7MkMalkM6ONrdjiSEQiPWkesxk
 Q5s7E84z3LwH5hbzCe8dLKHHjU9sOtIYfKjtRW4v4ynL0gqpPDD8bS3C3L6gFIicU3IcALWTO
 RMxBnTYneNQJvA2inUtuC1xpv3HYdVhdKbGzdPSJsDmHBVBiPafllIy0MNJYHajwR3eUNU4S7
 huAtnH+tRaHkfh2klXc4TTKiQECjCYh41BTm/6uObennRSRCGGvI1ENieo2+KpbZ33NlxQi+y
 ZVT730W8B5hfCcHoNNGeLvK+QPIAfDztPZc3xR6ujkiu2wvT9xH6Bgbmgj22kVxyc5R3mp9hh
 5QfoR6Q72jgIK4wWxaytWJ0Box/h/1MJY7tdK5oG7EoOCFRyynfBRpWgVzOKyWyZL5Mx1/FCA
 Z4dZBagy3itFDMSQpTwAanX9SJzD/6Ur9+VANyR6KkrMlAwBUawSLRldMOPiy6J1irOwLiume
 l6KudEVdCIOoLj7lkXWKhYpTqGrC0gu5GNl6F8Dqbzg1tuccac/OGIyHebYt5eTjSwo8DxzOO
 yDBFiVT6MSoZD9UR8rxaqu8rGtb3Fcj13H3y/wIklpBgNwYgfRcqnoJSHL5Xpkyl8bXc9Svxs
 Fhpux792xV7jz5KqP3LJK1Ik6jAHUf5m9/TUmEza/d/+H/lzR1Fro4w+XBn3cfwslCaK5k4wB
 g3BYP60LXsSaYvp/9UDi75I92WMiQcbJ3k6anQq2as5eehRSHmrBXenaARKRCPs7LQbHf+kDl
 NnlKDif+6u3b9SRr2q28jiMBWLiRbBvh0VadRWpxOCWTL/alLJF5rsRUmAcQI9ZCpzkaAxaoE
 P8gYLkMC7YfSYnys1G+t3MSOTEjdwXXwIaiJ7DtVIaJQ81KvtT573ggkxm9MbsGmP93vmZ0xV
 41qECRXhEp3VIRY0SgZbpAupLORU3+gg+DEWC5M5OipY7XY0RhUDNMJ4yuNQZvpQNuGkbp45a
 MaYbVeqFtksXHeiUa6yhLBb+MbrauRIbjsN7Jp/d3Otud/CuKOqK2sRQuyugaTDgi+4dzcbEA
 4V0RMOjgfdPQmiJfFxasErpQme584wQGS3v
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[...]
>
> So I am - for myself - positively sure that the 2 FS corruptions I met
> were related to Arch kernel 5.2 on this machine, as it happened right
> after I had upgraded the kernel, had never happened before, and doesn't
> happen since I downgraded the kernel.

Could you give more detailed history, including each reboot?

Like:

CASE 1
# Upgrade kernel (running 5.1)
# Reboot
# Kernel mount failure (running 5.2)

CASE 2
# Upgrade kernel (running 5.1)
# Reboot
# Kernel mount success (running 5.2)
# Doing some operations (running 5.2)
# Reboot
# Kernel mount failure (running 5.2)

For case 1, as already explained, the damage is done using 5.1 not 5.2.
For case 2, it's indeed more likely 5.2's fault.

BTW, working case makes no sense here, as that's expected.

(It's a really pity that the original corrupted leaf kernel message
can't be preserved, that could really help a lot to detect memory
corruption or things like that)

Thanks,
Qu


>
> I have to add however that I upgraded another little machine to Manjaro
> kernel 5.2 - after taking a full clone of the FS - and I don't have met
> any filesystem corruption so far.
>
> It is worth noting that Manjaro is the same family as Arch.
>
>
> So even though I have no better logs to provide, here is my experience :
>
> - Arch kernel 5.2 : BTRFS over LVM over LUKS on a SSD, and BTRFS over
> LUKS on an USB HD : 2 filesystem corruptions. Both using numerous
> snapshots, some were deleted (either by snapper or manually). Downgraded
> to 5.1 now OK.
>
>
> - Manjaro kernel 5.2 on a small laptop, BTRFS over LUKS on eMMC, no
> compression, no snapshots, no problem so far.
>
>
> - Manjaro kernel 5.2 on another laptop for a very short while before
> reverting to 5.1, BTRFS over LVM over LUKS on SSD, a few snapshots, I
> dunno if some were deleted (snapper) : Still OK.
>
> - Manjaro kernel 5.2 on a desktop for a very short while before
> reverting to 5.1, BTRFS RAID-1 over bcache over LUKS on a 2 HD + 1 SSD
> mix, a few snapshots, I dunno if some were deleted (snapper) : Still OK.
>
> So you see the setups can be a bit complex : Always a LUKS layer,
> compression used on mechanical HDs, sometimes LVM or bcache, some BTRFS
> RAID on one system...
>
> As far as I can tell, the issue doesn't relate to the most complex setup=
s.
>
>
> I am under the unproved but strong feeling that the mess has something
> to do with snapshots deletion with kernel 5.2...
>
> Dunno if it can be of some help.
>
> Kind regards.
>
> =E0=A5=90
>
