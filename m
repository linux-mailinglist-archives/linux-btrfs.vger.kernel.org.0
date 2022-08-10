Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA9158EB71
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 13:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiHJLno (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 07:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiHJLnj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 07:43:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2672A78218
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660131811;
        bh=5cfAzBORGo1xZrJbOnm4oCxpKuJyvlGx4YulxBr8eyY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=eFNJSKs/aOn0IweQkRhFpe2GnKcMs8mz0WWOYeTQUY1W3sTcrwDmXpU3ipCQsWEKl
         /FhyQGe9nt3t2F1fqf6TvexYHUN9rCROKUdTqKmGP5d0N/vK10b5kX4hgLrA7SAJJd
         pYa4foCl41hFbHu4nyvYxjgYln1INRV7kVVjBe5E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4s51-1oM1VF0d9z-001wEP; Wed, 10
 Aug 2022 13:43:30 +0200
Message-ID: <f98b0694-e114-85d9-3476-153167c03610@gmx.com>
Date:   Wed, 10 Aug 2022 19:43:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] btrfs-progs: read device fsid from the sysfs
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1634598659.git.anand.jain@oracle.com>
 <c2bcb950-0cc4-2e6d-4a77-36fd2f337aa1@gmx.com>
 <e7c12925-57e2-0ddc-2297-7e2a90599379@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <e7c12925-57e2-0ddc-2297-7e2a90599379@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H3KK7MV49P1i8tHZFQ/42ecz09geT7jkvBJZG4rYQ0YXzwydeVp
 +urby/JQ3d6AWDo98piuII46quZk8cTBP1YNH0yHlj671iOMWFeV8SypJE6jhd4700DXLFs
 6G9soXxgyi7VW3GcDPnFHbKh8g5mxsWADaBly6ariUEykw5hpMi2yOBaeTbVCnc1sSvEQyt
 LqRMCUUVuGfa+T1UskjFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:05AOZk+6+Es=:KXjLua8f49wpvIaAMu/SiB
 LVsVZUlHs1JnUCtQAd+Y+udTmvCwu9UVUDFarVKO35XhVUy5/rDr45RgCCiDk3KIqGz0bdV/+
 qRvTMlzdpm2GuhrmuohLF1fXZm74jHUc2CJ+tnSy52Z5Qpkt3tv1lEUsbzEN4874ZQN8yggG3
 UtfPqF/E5BuZsh2J60yaH6a+9sKPasbD4YOOXamI89ZbRi2pPhRenr0oJ0XYUiwCZ1AEl5MaZ
 Dkwkv66wF3yh2910je/QDRFnBH5jAAKg/WqZC4n3NL7+WZ1HRRk0g6YYTf0tquEzHa6DBf+u0
 3/QhJfaWsIf7gEVDTkTAmVeA0grtzJeJ0EofZj6zQkDnRL+bdP4SCH6sK6L6cEmV7Qf3NNrAZ
 kIuL/KjUpAo2LhZY08OmIMkNZ4CCXxDtVJjTM6aqmS9v6bz0uNMb4BCU2/naHsba4deDG55Cw
 hA86E9dDOSTH30UI4hnpW92gC60l0psj6xm0q6fLwv/LUAE6EvEmFNRHzl8WtQ584L3TaxUdO
 MMnHn/7RUbO/Efy6C6LT0Nj7MZQYubMnfMWt1HXGZPuQqZ0PG7lzBKh+6o3VOVq/pRfFmyKaw
 FmZPTvwz1v71SAyOw0CX86YYN+4CHWJgwI722IIYBUsP6eVbD0DgMFCDWILKnWXoyyh9kiJnd
 w9baze9nsv1OWEA29UK/Mu9RD8HQ5R62+Lm8jnXUWUb+yY5W5NwF4nEkK5Hj+jaHQjV1q7UBF
 9nGUf788zbv6aZGhZz4ZQct2mpXkfr3cSE6QmDfPLOPhoev+L9adau0jCN4QnbraqtkmgfkBS
 oNOnYvHgyg/iwcmxGjszRc7DeQO6nkulOZIxTbhnSZc8eY+oi9nZGP4rxwCbAr+g2RlR+qK0M
 i1Z016H7LigGsN4JEcoCKqjxIr74jM1zsBqT88xXkG5bhvcWxhXvPlF1M8YJGPIkw/zK1lN2u
 fpsQFg+Q2x1ForfQpjQ+EOe+DA8dTjjKsH8UfzxphIxesNCznKf6bCezne2dlegFYpBkIWF4i
 N4ZWhExiAC0089QDvVPSNJg7fYS06olXssQitzu1qSazyqm3YJh194RXcPsAaWsKobqNGMj80
 ncYXOn2XysAiVic1wPaLYDBdOQSKecgC7WGS9VCq9I51z6M03S2xpOy/A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/10 19:18, Anand Jain wrote:
>
>
> On 10/08/2022 18:18, Qu Wenruo wrote:
>>
>>
>> On 2021/10/19 08:23, Anand Jain wrote:
>>> The following test case fails as it trying to read the fsid from the s=
b
>>> for a missing device.
>>>
>>> =C2=A0=C2=A0=C2=A0 $ mkfs.btrfs -f -draid1 -mraid1 $DEV1 $DEV2
>>> =C2=A0=C2=A0=C2=A0 $ btrfstune -S 1 $DEV1
>>
>> I just wonder, should we even allow seed device setting for multi-devic=
e
>> btrfs?
>
> Hmm. A desktop use-case which gets reset back to the golden image at EOD
> or a user logout may use fault tolerance to reduce unplanned downtime.
> I say we keep this feature. Further, if we allow a seed device to
> replace by another seed device it will help also.

OK, then I'm mostly fine with the patchset.

But on the other hand, what if the kernel doesn't support the new sysfs?
Shouldn't we need a fallback plan?
Like to use tree-search ioctl to grab all device items from the chunk tree=
?

Thanks,
Qu

>
>> This doesn't sound correct to me, and can lead to split-brain problems.
>
> Split-brain can happen even without seed devices. There is a patch for
> split-brain detection and avoiding. I love to revive it if there are
> enough interests.
>
> Thanks, Anand
>
>> Thanks,
>> Qu
>>> =C2=A0=C2=A0=C2=A0 $ wipefs -a $DEV2
>>> =C2=A0=C2=A0=C2=A0 $ btrfs dev scan --forget
>>> =C2=A0=C2=A0=C2=A0 $ mount -o degraded $DEV1 /btrfs
>>> =C2=A0=C2=A0=C2=A0 $ btrfs device add $DEV3 /btrfs -f
>>>
>>> =C2=A0=C2=A0=C2=A0 $ btrfs fi us /btrfs
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ERROR: unexpected number of devices: 1 =
>=3D 1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ERROR: if seed device is used, try runn=
ing this command as root
>>>
>>> The kernel patch [1] in the mailing list provided a sysfs interface
>>> to read the fsid of the device, so use it instead.
>>>
>>> =C2=A0 [1]=C2=A0 btrfs: sysfs add devinfo/fsid to retrieve fsid from t=
he device
>>>
>>> This patch also retains the old method that is to read the SB for
>>> backward compatibility purposes.
>>>
>>> Anand Jain (2):
>>> =C2=A0=C2=A0 btrfs-progs: prepare helper device_is_seed
>>> =C2=A0=C2=A0 btrfs-progs: read fsid from the sysfs in device_is_seed
>>>
>>> =C2=A0 cmds/filesystem-usage.c | 47 ++++++++++++++++++++++++++++++++++=
++-----
>>> =C2=A0 1 file changed, 42 insertions(+), 5 deletions(-)
>>>
