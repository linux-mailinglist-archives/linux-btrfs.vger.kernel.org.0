Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97EDAA409
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 15:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbfIENN1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 09:13:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:42693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388178AbfIENN0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Sep 2019 09:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567689197;
        bh=M//9KkcYbVWH1iL92XdiI04xcBcPW2RUCcnDDxakRlU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Oy8XIjraYFyKs+hIUrOk1bCSlNma4FBea5+EogoQE9sJEW3mTbPGhy5Q3fiCFJNQq
         0ZS/0fU2tFjlYZ3IVgIy2yj3h8p+iVs4XXUR7tcQcU2JVptO0l7kovjV8ZVOvDyZsO
         6c2jzm9kjYu5xIVMt+86Gqarc+BBW+hoJDH1nTDU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0ML72n-1i5aST2VEn-000PAQ; Thu, 05
 Sep 2019 15:13:17 +0200
Subject: Re: Cloning / getting a full backup of a BTRFS filesystem
To:     Anand Jain <anand.jain@oracle.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <7d044ff7-1381-91c8-2491-944df8315305@petaramesh.org>
 <CAJCQCtRCmG05mnTMtxYrnnY5T-gcjiVHP_dYNHSz7NuRrNpLTw@mail.gmail.com>
 <F4DE0ABD-51B3-4BBC-B26D-3599A78ED1E4@oracle.com>
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
Message-ID: <cb0a5e6e-ee0d-c62b-889a-a5e6c7cddc33@gmx.com>
Date:   Thu, 5 Sep 2019 21:13:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <F4DE0ABD-51B3-4BBC-B26D-3599A78ED1E4@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UrQxXf/oDg9vgbICSLnTxD3NO6QXzosO2UZlvMt+WZUVU400loU
 wA3csZbEXcjTq0vjdPdiAMYtzto5EZiBT/aatcQIH9zZS+cyeI+edLrhkQLssJTOiT+gFHD
 oNNF6kLWKdJ9LrfPXrxsHyShhBspOKLxzKkDkRQooQZhR46UkNvxCzs4lu2DcTI7ddJXvCD
 u5HYIIzsucbNXQX1LOeVQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VJKSMar74eQ=:WsAInL2ErGVHPLQxwVHmzP
 TlcJax5GSTaJdiAYaKUuvA1CiavSviehjulQixKInQl5CckwsvzwFGPVmb6fDLhk4yAyjkPaI
 2jZvL1nVuHfJ3J900TJ8QvPKCf8fhwHA3Hnh0fr10ZqqkBxXu7lBjjrrFkIjtu3azvkaqRZps
 1sblePMBF5Ejwhvd2xqkpns9kaD0MXD2e5RMWYIvS58ncKusxIHeyQk8kJ6B/+Ce5rsH6+37S
 LMKbWr/PRcLlkc2fppaU6492T2m4nn7pyKbq5bwdut4LAzi6YPnmB7j1ZgvI2F3TAykZDl6o8
 MmGyqtK207LVVaE0A6DHxSndbBoWMFtRIclmFY+Ja6hlA+YuqqdML9j7JnNyispBDq3NGr+8x
 jxmXufzwRfpq5lBAXOS/0aFVzIbM7jHPkm5bNA0pzzdFsuBJhomYhJxWuZiHQiNVfHQOKk8+L
 P3/FCWYLMVkkb99Py5WAvwvfsX6ak3ti/Lvm0AeUfnvdzFoGLEBpfjsMZR2TNsBjOnW518zzm
 ANRjNviAcP3WijXuUSuUGJCZ3hQzhURn0+tkwLXEQILfWkFuR/3+1k26NTBKWpK+iDcikhtoZ
 cWjGilZ6djzpEOQ7hREDt65cw+zSPRRePcZX2dwnMqssTsgiTQG/ySqwsOoQyimwByopqw8vb
 mjfElzgQwAnjYPr9p2GIhdp7+atAGI15ZLAAHbTzxk1iJXOdNN6ghnOLdNVt1bpXDNmf2a4dG
 ABWQoCY/I7MJbQPt1M+JI3IXpAwekzapKBEAknGc1oXsb1QR3/UrIKnG+dwyglu4VNyjRlOfY
 EzsIvw6TfpwEomDmHEHYLegKo0m8/jqjOx43+mSAn8YA9jNyFcuvfCl2UFjRBF2yDTztld/BT
 vBuMYbjL1WS5dkamciUDW9P8l8VZfzlSBFtH9W5IQvd06mbjANUebdqBUzGoSUsxamUMt+jqS
 3jtnBtzUkIC5heNKjzdUCZQvnoNg/nqOz+/F/7QlpqvNltkfnWm3dXdTLw+mWwTddUMr00b4e
 LzykpfrXKtjh4EL32PUPMhyWdE38agaqk/QTTc4xbKfgbCjUl1OkykOTw6WTdv18W5IDsOvLn
 N7vU7iC94E/tgzvuwuXQb3xAqg7qioBDJ81Uk8cupcy5KARg3GAWDDpPVrpUgyrG5VneyX5K8
 MClouGJf22An//Um//Wpd9KKMcEZyc4ltFFrWmYl9QyjwfcP6w7DtXxzFh/z9WtwT69Yvgagv
 ACUdpEH7t3nQeJf5G
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/5 =E4=B8=8B=E5=8D=889:06, Anand Jain wrote:
>
>
>> On 5 Sep 2019, at 1:55 AM, Chris Murphy <lists@colorremedies.com> wrote=
:
>>
>> On Wed, Sep 4, 2019 at 12:16 AM Sw=C3=A2mi Petaramesh <swami@petaramesh=
.org> wrote:
>>>
>>> Hi list,
>>>
>>> Is there an advised way to completely =E2=80=9Cclone=E2=80=9D a comple=
te BTRFS
>>> filesystem, I mean to get an exact copy of a BTRFS filesystem includin=
g
>>> subvolumes (even readonly snapshots) and complete file attributes
>>> including extended attributes, ACLs and so, to another storage pool,
>>> possibly defined with a different RAID geometry or compression ?
>>
>
>  Remote replication is a planned feature, when ready, it can be
>  used with a local target to meet this requisite.

In fact, I have submitted patches to implement btrfs-image data dump
feature, which can be used here.
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D141937

Further more, since it's btrfs-image, it can even support cloning a
RAID5 fs into single device!
But I doubt btrfs-image -r would restore into another profile other the
original profile or single device.

Thanks,
Qu

>
>> The bottom line answer is no. There are only compromises.
>>
>> Btrfs seed sprout will do what you want, except you can't change
>> geometry or compression. Last time I tested multiple devices as either
>> a source or destination, I ran into problems - but it's possible some
>> of this has been fixed, which is a question for Anand Jain.
>
>  Thanks for the report. I just tested the below test case[1],
>  it does not fail. Any idea?
>
> [1]
>  Create and mount a two devices seed fs, and create a sprout.
>
>  umount /btrfs; mkfs.btrfs -fq -dsingle -msingle /dev/sdb /dev/sdc && mo=
unt /dev/sdb /btrfs && fillfs /btrfs 100 && umount /btrfs && btrfstune -S1=
 /dev/sdb && mount /dev/sdb /btrfs && btrfs dev add /dev/sdd /btrfs && umo=
unt /btrfs
>
>  Mount the sprout device and delete the seed devices to make
>  it an independent but identical fs.
>
>  mount /dev/sdd /btrfs && btrfs dev del /dev/sdb /btrfs && btrfs dev del=
 /dev/sdc /btrfs
>
> Thanks, Anand
>
>
>
>
>
