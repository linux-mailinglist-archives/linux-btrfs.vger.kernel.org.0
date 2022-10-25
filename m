Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FE560C60A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 10:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiJYIEe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 04:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiJYIEc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 04:04:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AE3271
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666685068;
        bh=ahs3CHknZrNolThgtcti6MCcaiaGcSeCxNusOkyYTGs=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=OarkXfVhAVsi/hEGEeZ+JCa8XU6nCMZ7lIX4lpTiKt5Izn5wYzl/07eKzPoaN4lBU
         +450vfA5M8YKxm/iJF4Q2Rd4Z4FGFmd1FPx+vm+HBsP7nhWTmA+kgwpn8Z0k+mzep4
         Am92Y2rNpYs2L8Q8+bjk2slNkzkv5i7ftFbd5Vrs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlKy-1pHsmR18pU-00dlzc; Tue, 25
 Oct 2022 10:04:27 +0200
Message-ID: <3f94d330-7ed3-8f1d-ea4e-ece46efd15e5@gmx.com>
Date:   Tue, 25 Oct 2022 16:04:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: btrfs filesystem becomes read only
Content-Language: en-US
To:     Abhimanyu Saurot <saurotabhimanyu89@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CALyjvZsgYXkDXKbNhNYrsbVE8rx3nGwy8fAD6gxredq0_ezNoA@mail.gmail.com>
 <CALyjvZu61NNDokqaHxDvMOwXpsdgkd0SrR4+PPb5Nee5BBtprQ@mail.gmail.com>
 <37b27805-a229-6734-72e0-aa7513145e57@gmx.com>
 <CALyjvZsjq_OS=rjo3dW5d-pqfi+v+ofAChoTMKR5bGKDRYGavQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CALyjvZsjq_OS=rjo3dW5d-pqfi+v+ofAChoTMKR5bGKDRYGavQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qlZcXuzUARIULEbyDGDuv2pK7XEe2kJxQ6+m3qLipwZRfV2qfyn
 edMKXufSAXdhybsHzJqY+Ik61Rhj8T390lLA5igatXNHP88t6JBVYDLGWjjBrvMy9Q7jg45
 U0zKcLaMce9wkr9JxFfVuPVx29Fx4VNWpGZoE1/BDfJBCijofgpYHUrJRYkxuC3bmMALVLh
 xt0oZSHFkO8oPygbIyytA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C16wF+1E6jk=:otVlDjtjw1AnAluhTGl5Re
 VgWw4Q4ZrC1+fST8zAMNbvu5+ywE6o2oe9EeahQsCbUrevfcHEGl4FT4YAR8rUpgLokrEmMXN
 zxu1NK6bIIEfg6gSGsaCgz79I8+mJNRSZwOG2yJHQRavPFv3ErLtWUk7tBIEkxLAE2x4yvTlv
 myB9RmgbR3Uxa57S8EUMKZR4Qk8uMnDFUn81AKKbECcoZtd3q1aoddlJYvapN4VmoaOVb5OOF
 OUcwpGePDXc1QroGKUj2yKOm0wfDGJO76CGAVETlqJzhLnB8T1VTEwnjQK2eQDCAMtCgg23Kd
 J3Isjbta4RMubKuCSjL79jXofGXUCKY1RE+5cJb00uuRDgNe2+8MDTpb2GKmogxyRnoK6NwNE
 KECk1eAHJ/gCxH+1Ob4hGXhP7X4I+7LehHwsFZBNdkHzu5UyhquwdJG+cyjH0ITjwOszS10tP
 aqVwsgUUQWefOF0vw3Hg4HB2LeuNqqScytWFQkcqXtcCJHkF03s0LRWipHOK2xBBZiu5nRIoY
 UxIQb7nCwshRJc76KwJHtLeqiGBgsuoIMxpFP0a10emENEeLsG7rMqWMkySrqS6KOS8XbCBmG
 NxqYBO/V6tcsiLo6vkzQJ4++S36GijlaK4xDaXSMHPOeYK6zjbZ5huTaycS5PE1Bn7PMCmFoo
 WmP1m4EmOXtcKWZDoZJ7UUZFkpXmQMoPF5tcsYVaB32gXJNbGaBnfDq6EjVK/bEM45JXemH6n
 RINPAUCFvv/JUJ3I5J8ztamM662GKgIf+xZrWgwyNxfSTR1JcI+hv3qvbkXOKuViEGsM7669+
 ICyW6Wo16vboM3K3Agu4Oc34eE4L01d8C7QmMB0atI4eER3Ayr1I6YEs0WNkvpYG3aHoLy+tt
 GpqeVHw0mOUsg8FyYsmLvBOJAJpyOt4VdubBB4Uccmyk7MDcRNdWzokl2o2xh1D160RHwnhd2
 J28XVewl4nqLTkQWQlMC9RJQfSv/laeRBSF4UFPYHyBqT6+WXki+2pPsZ/2G60gMP1FGzgJIp
 LLvk9tHvSkkvPp6S6g3SEklANEkVbrc0dqcWUzHtQ4qETz2HmPF4Izup4QDQx2mESilLQoaJa
 z9gvUEQSeF2de/jhvchENNwWPhMZqoJ2VNrTRYaY2x069Xtle1Sx35RAndUXZtt9HqWkLBVv9
 qTVsaZiBNr2p28955npZlw7HmFDt5+DlySbN32ohSCk+32+QCKcBZA3YrOpCxTvIhM1iO4BHT
 IRY4WCsuXFmSEz8eJr0s3dywBeNjpT8Cz9i8J8ZN3xRqtbzAgsSanwFISa24rKuM9LgCrzgXR
 V6DUbJnAj8Eh/6y2T1KeUsG30uRVxtJAaFjT9gXmndD9I/2T1Kge0sFMt/zBdYeahs08gfcTW
 /dKaPppGFA9/Kjj2pivx1RTGvefU4rEfW14k7cYFVKjtKin5tkjkC/LgZqZ1xldmkXYZBDRkW
 HoFQbKzXEmvH72rAKF4i5FR8cqR2XmrXFsZTixghqNwLdZJN5lXMgRxo6ixM2kVuZo+2Xq8fv
 2OPaMBxy70PbeSM6h0ezl5setYf0skMUi4APRNP6RZ910
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/25 13:50, Abhimanyu Saurot wrote:
> Hi Qu,
>
> Would it be possible to let us know what would be a good kernel match
> for this distro ?

I'd recommend upstream kernels.

Like the latest LTS kernel.

Despite that, you may want a much newer btrfs-progs (e.g. v6.0) and run
"btrfs check --readonly" with the fs unmounted, to catch any metadata
corruption first.

Thanks,
Qu

>
> We have 2 more setup with same configuration with difference in amount
> of data(less) however no such issue is observed there.
>
> Regards,
> Abhimanyu Saurot
>
> On Tue, Oct 25, 2022, 01:56 Qu Wenruo <quwenruo.btrfs@gmx.com
> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>
>
>
>     On 2022/10/24 19:11, Abhimanyu Saurot wrote:
>      > Hi Team,
>      >
>      > We have installed btrfs on our backup server having a 1.2 P parti=
tion
>      > formatted using btrfs.
>      > This partition stores the=C2=A0 data which is backed up from a di=
fferent
>      > folder mounted on the same server.
>      > However we see that btrfs filesystem become read only quite
>     frequently
>      > and we can do anything but reboot the server to recover the
>     filesystem
>      >
>      > We tried to run balance on the filesystem that gives some breathi=
ng
>      > space however the issue reoccurs.
>      >
>      > Would it be possible to help us fix the issue ?
>      >
>      > Details of system:
>      > uname -a
>      > Linux 3.10.0-1160.el7.x86_64 #1 SMP Tue Aug 18 14:50:17 EDT 2020
>      > x86_64 x86_64 x86_64 GNU/Linux
>
>     Heavily backported kernel for RHEL7, I'd say please consult with you=
r
>     distro vendor instead.
>
>      >
>      > btrfs --version
>      > btrfs-progs v4.9.1
>      >
>      > btrfs fi show
>      > Label: none=C2=A0 uuid: b6d915e1-47c6-43ed-9f6e-eed2dc4309f3
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Total devices 9 FS bytes used 3=
12.06TiB
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 1 size 130.9=
6TiB used 34.74TiB path /dev/sda
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 2 size 130.9=
6TiB used 34.74TiB path /dev/sdb
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 3 size 130.9=
6TiB used 34.74TiB path /dev/sdc
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 4 size 130.9=
6TiB used 34.74TiB path /dev/sdd
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 5 size 130.9=
6TiB used 34.74TiB path /dev/sde
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 6 size 130.9=
6TiB used 34.74TiB path /dev/sdf
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 7 size 130.9=
6TiB used 34.74TiB path /dev/sdg
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 8 size 130.9=
6TiB used 34.74TiB path /dev/sdh
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 9 size 130.9=
6TiB used 34.74TiB path /dev/sdi
>      >
>      > btrfs filesystem df -h=C2=A0 /hpc/storage/nlhtc/fs-htc-002
>      > Data, RAID0: total=3D311.47TiB, used=3D311.46TiB
>      > System, RAID1: total=3D32.00MiB, used=3D12.59MiB
>      > Metadata, RAID1: total=3D612.00GiB, used=3D610.29GiB
>      > GlobalReserve, single: total=3D512.00MiB, used=3D29.00MiB
>      >
>      > Regards,
>      > Abhimanyu Saurot
>
