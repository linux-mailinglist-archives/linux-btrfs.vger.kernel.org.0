Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A503358EA62
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiHJKSt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 06:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHJKSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 06:18:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E671F6F56A
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 03:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660126720;
        bh=NYTa4+Ww3xpBBEHWZncx3uwE9/T62Zc5RgJIIA6Z+4Q=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=XrM4stqHFgpMmyeQv0MGpb0d558GXTTe8Xptg0eJokWPTcSj3/qJ2YC+XEhI7AavX
         RXlYWF6MKzU5+0M0mOMcuIyALQRhZ4bkFQb1dozaZdqT0BmKGz5yUhfr9kBcizC5Ue
         erZXpaKNd+tAA4WfuxhXYaZFOz19EEDs5DeRijDY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp5Q-1nuLb92dKO-00YDuh; Wed, 10
 Aug 2022 12:18:40 +0200
Message-ID: <c2bcb950-0cc4-2e6d-4a77-36fd2f337aa1@gmx.com>
Date:   Wed, 10 Aug 2022 18:18:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] btrfs-progs: read device fsid from the sysfs
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1634598659.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <cover.1634598659.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AmQ/vQofGceRZlJMpall9rDdOrOgNEnL8o+oZiIAql7khLC+9bR
 ymx/nZw9uouEgE1Wygb/cWnRMb1taATHy7fPwBs+SeNY1iSQ+7RCDAleF8qO3C7a1oYEj0e
 w3sMH7vz+PtbW/WhrMmhhi4nhynnh8fWyWkfFmPLRm9hqzxRsZx5ejuJcQDsW70o0sldNgV
 ux+BPSSxj8GVwp9J/FfyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v/FGtuEXxYc=:SJRHeC934FV6GMiOWvVHct
 WVn0VoUIZxc1RUicD8cbDPjsRKR5Tqn+mOyrllgVUcNI13pvbG+HnRormlkEaIlSfid2lfgJA
 K9J0pWyh9E7lRom4LB/2Nk+4wkwSUnHHtgpVC1rK6hrGMWnG0R3SeDTBfFnLlkjO8Y+hsLSq6
 896iyQ5W5Sto3XrsnhtjDaXaM0PpiBFNljplkmsPfERKxLBpvHiB2oyl06VqcW0dibfABKJH9
 sDydFgFvieXde3tjOh3QsCXu1f8wjzSS+FGQj/HICdDKtNm8/jifaEnqI74kKiYpmQ6bmA2US
 lFD2bxx62ppwq3kDWrMZwwnS8qDrMoOHWPbIFYcoKdASiYaXgKlLbDA+1IxlLQxWeGcZ1Fv6s
 /pTdX2yjFh5AypWNqx6SMifwa05eK32QC7V0bwCG2Q+sGsoUOO7TX4EPuDlW3p1euG4gMI3c5
 9h5WCA062K7jPvjF7dbn8LmjbR3O4ad5EL9Mp97DfJcFi2htNJkUz/CKIcnDQW7yB0EQAd8iX
 q22AIPkyq1yg4yiewYYDCUf1bJ/iyLRIKTZzrAevDRUSgKKBQm+uSLNV+ToKHP5PuCMb1FApM
 IL3C+jeHJeEBOFIjWJn3yxu/NJYSZBebLJSPM+tx07PNOJTu/LbxA9/4rpbl49OUefD/wa9BY
 pplfd0vGm76pHeIyFjva3gdVOxoNaLbfxLzgbY8jhKRyf2O75C1KgbRReYSK0csD9hpLZykKS
 F9zqsq1Le6qzVSSD+1AxY5SGfXZE2MC8XFjUSeswpNBLaDb1hOkT6bHp5VSPPV5uhcww2in0D
 Dwawyoo/M2GHBITsco3vNUejGmu/DjeBYbAz+xHj8BgFoluF8R8Bhzd3UGeA8BGHdHs4tSSrX
 Jc1wOa8mnc7jSjoNngOQbnF+6sThhzlg+wwTxY5JEIRZLxNL89v02IhKNFRxA3u4Nms/cLTB9
 AqjGdnd6wNSL/y4tWRieqRsivdHgi8p0McxXnQa2hhkd70djOU+z0oT/abdXEsqNjhaNQil3a
 VtKQ8owQfwhYgTEIOeCBq66Oz6l6IOCEiTwN0H7HKgjC4I7z0Q95Tvd0IM3avLKO44JUXi05C
 iXc10BIsVsUhe8mKuDQpaaU+U2YdD09QQWH088JrgW2ZpfYuPDk4C3gKQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/19 08:23, Anand Jain wrote:
> The following test case fails as it trying to read the fsid from the sb
> for a missing device.
>
>     $ mkfs.btrfs -f -draid1 -mraid1 $DEV1 $DEV2
>     $ btrfstune -S 1 $DEV1

I just wonder, should we even allow seed device setting for multi-device
btrfs?

This doesn't sound correct to me, and can lead to split-brain problems.

Thanks,
Qu
>     $ wipefs -a $DEV2
>     $ btrfs dev scan --forget
>     $ mount -o degraded $DEV1 /btrfs
>     $ btrfs device add $DEV3 /btrfs -f
>
>     $ btrfs fi us /btrfs
>       ERROR: unexpected number of devices: 1 >=3D 1
>       ERROR: if seed device is used, try running this command as root
>
> The kernel patch [1] in the mailing list provided a sysfs interface
> to read the fsid of the device, so use it instead.
>
>   [1]  btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
>
> This patch also retains the old method that is to read the SB for
> backward compatibility purposes.
>
> Anand Jain (2):
>    btrfs-progs: prepare helper device_is_seed
>    btrfs-progs: read fsid from the sysfs in device_is_seed
>
>   cmds/filesystem-usage.c | 47 ++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 42 insertions(+), 5 deletions(-)
>
