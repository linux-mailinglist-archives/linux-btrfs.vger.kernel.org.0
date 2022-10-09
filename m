Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042265F8AEB
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Oct 2022 13:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJILhN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Oct 2022 07:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJILhM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Oct 2022 07:37:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D81CB8C
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Oct 2022 04:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665315426;
        bh=+hohaJHgRt6oEx3sSfUVVghJpmxm5ubo0zibHFmlwzg=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=Ll01xv74OsGwSxcpKgkIFM238KknCPaV8Gfi1JyEyRkKx0lTInLSmJKSfBdoQENtF
         HmGaCJS4tz6i12d4hSDU8kMFr7LHhRZROUr+HJbcw1oqXtHI5ca2PHMnun+BdN0Rw/
         Rz4jxF6OsoFJFOl6mg9VqjGNawcfRz6twjKjSNl4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKKUv-1oT00M3LbT-00Ljac; Sun, 09
 Oct 2022 13:37:06 +0200
Message-ID: <c57e3674-255d-ab3c-a386-479b84c19eee@gmx.com>
Date:   Sun, 9 Oct 2022 19:37:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: BTRFS w/ quotas hangs on read-write mount using all available RAM
 - rev2
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     admiral@admiralbulli.de, linux-btrfs@vger.kernel.org
References: <133101d8dbce$c666a030$5333e090$@admiralbulli.de>
 <9167e4a5-252c-0192-6814-da91e3692b88@gmx.com>
In-Reply-To: <9167e4a5-252c-0192-6814-da91e3692b88@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ugWi3oAP+59L7FUtUay7D07+jHy4SDtFAIWu608Ilao71k3chYk
 5QpLN6/CEgEUwjqRVMaQuC7kFU7RmrngiOnbLHizq8/KWKZxIBz21FPFgd6z4BE+IKWrWH/
 isnT2dP+6b7Ikk5RNPo3kYqdZazEHD9yDLCk9tRk24hiEkvnUjThfqsc7mAbG2OgH8uxyv4
 Gc7WuQnmN8pk54D4AaLtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AoIVImFaTDw=:7QjBdBs7QKuW2Hv/dowzvr
 Zpx3T1ZqTJ9PM3IaGUURKyNEHjqX/oIlC54QPLpkbCAAEEnwURJfrZl6Jv+vAQPqPWpex4j6v
 8O+CpEK9b99MwWqS+o66yAFTWmrYJYmyxI1Zuy0dgnddhv5b6XcALLZ3mueSomUrU6qkeOWrA
 SWZ7geqEhnkrjgTVS4C0pZ2JvoPCOHf3UOwJPJ9ZnDPmwlZHCV88Dkx/o+wBqGRXQgSXbDguw
 cwE9qxo0YUVxrvHCUw99Z7k6GlrV1CyIXAlfERJm4Uqt/TGm3zyS3h0p/4o12IkubS42BEMiN
 bE370MyexoD//B7CN2yafkaD0RY7jkFy6ciVKPMzjVXa9RRpFfdz4lF7WsVr6XKOEywFUqNBV
 DqSLN1ou1vnosk53eTXEsrs9ju9dX2dCsh0d0m3GJ4XDgdgc6FINWqAZL+Cf60EZJi69rl9Fc
 fyokozqetPiFmfj9kWNHJQxj1eJZlOAX2cYwEpkAKPfH00TM1eC6vfvfmyXlvAmTpuKIuGsXf
 gqu6tv+p8OXYGTiFGp2kujAUJNmB3Kvc3FOiGge3kYvFBlqWDTaGN3wD/Ga52g7P/JsbiZz7s
 juTIKbNcnSzPgjiGeOKYfTO0yXiwgFfW0DV8GSn/eyfPamljUP/oZvpxNOtCawMZo5d5X/bSK
 vqUMSG9tq8fDqgRBa7w+ucg8LMnxPl5WoscQZUW8VCEI2d/ZKTJjwaHWOecEdaAn39kAxxESN
 wT7TeWBQc6u7EVkfXxtuqeox65rs09bnCJ4S2ldRBqQS2qWxMmVW8ACD4UUEib74cYD0SzdGH
 eCoX8PK/kRzmLX4eIFFvzGPtjiYLeo6KgG3Q1Wjyk/vim9yMFjR7qiz6BgEr0lBDsgabmm+zh
 pMty1R93yQhVoeORsyWuVqsUH7v6ySBssCQ3T5MfO3DVSaseYnGCVknLDrzWqAZa00n8kgl7Z
 ankW+62hZxOflApbZrOKznuVvo6GQDnjy6vshQdq/gPDoUbenSZlgBZZt7yelt/wQCqSNlbhC
 4U/jgBQKmXqy9BwjQJNqEQD1tKyopne+yMUZwBq3eTrfffoDuCDMbDKLbqTYs0FbDh7bt1x7l
 pg08gZqnBbABg3/fZi6nkgOAA62+a6J4AybsQxtNvYUBf72tgTVblfToYeAK/rv4HJbSoYh/d
 VCDRwHxqg4SrtCYF6kFjKGzV3LoMDQtsZ7tM918DfqQKs9WcEr06drvD3R0lJzjJVy16efN4s
 hHPZ7mcqL+3oPhHErtYnDjvk7h7vai300EKAycuDsf22PXJAkp+LHRnkWahFI7CAsvaY9YaOI
 abPSqH5u3vgnucbid+ZIm8MFsOLLPMXNsHbtURV8g6EMsewqTVYR0nS20kb9knk+SDMH30Cxa
 OAyZiYnhLvIayYaPjFED0rvFajhWxeCzSecdtJbMKI9rXi+ROZ0AGkNrSDKYbMCSmWehGsUQy
 6YxRCQL3NChatMO6+/3kuf2UbPryGOV4JNg6/UWUda3JmUJmiLCjDoV2y+Z4hNgdexXRqzbTl
 O6Z+FgmfZ0O3WrQHR33fybomAjF26jTsngMSbTlTIAInT
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/9 19:13, Qu Wenruo wrote:
>
>
> On 2022/10/9 19:03, admiral@admiralbulli.de wrote:
>> Dear btrfs team,
>> thanks for all your great work!
>> I have been running btrfs now for several years and really like the
>> robustness and ease of use!
>>
>> Last week I experienced 99% the same thing as described here by Loren M=
.
>> Lang:
>> https://www.spinics.net/lists/linux-btrfs/msg81173.html
>> only difference: This is not my / but a 40TB storage mounted to
>> /media/btrfs1/
>>
>> quick summary what happend:
>> - enabled quotas to better understand where all my space has gone
>> - started balancing
>> - system got completely stuck due to the meanwhile well understood
>> reasons
>> - pushed reset button
>>
>> I can mount my btrfs system perfectly read-only and access the data.
>> As soon
>> as I try to mount rw, my system will exremely slow down, memory will
>> fill up
>> until I will finally end up with a panicking kernel.
>>
>> So, no problem to successfully boot with the fstab entries on ro or
>> commented out.
>>
>> =C2=A0=C2=A0=C2=A0 admiral@server:/$ uname -a
>> =C2=A0=C2=A0=C2=A0 Linux server.domain.loc 4.19.0-21-amd64 #1 SMP Debia=
n 4.19.249-2
>> (2022-06-30) x86_64 GNU/Linux
>
> Your kernel is just one version too old...

My bad, two versions too old.

>
> In fact, v5.0 kernel we have introduced a lot of qgroup optimization to

Git describes --contains shows it's v5.1 for the optimization.

> address the slow performance (including hang, huge memory usage) of
> balance with qgroup enabled.
>
> Although that optimization also introduced some regression, all the
> known regression should have been fixed and backported.
>
> But for older kernels, like your 4.x kernels, we don't have the
> optimization at all.
>
> Thus in your case, you may want to use the latest LTS kernel at least
> (v5.15.x).
>
> Thanks,
> Qu
>
>>
>> =C2=A0=C2=A0=C2=A0 admiral@server:/$ btrfs --version
>> =C2=A0=C2=A0=C2=A0 btrfs-progs v5.10.1
>>
>> Here the question:
>> I am looking for the option to disable quota on an unmounted btrfs like
>> described here:
>> https://patchwork.kernel.org/project/linux-btrfs/patch/20180812013358.1=
6431-
>> 1-wqu@suse.com/
>>
>> All my trials and checks et cetera were performed with btrfs-progs
>> v4.20.1-2
>> as debian buster's latest state:
>> https://packages.debian.org/de/buster/btrfs-progs
>>
>> I already upgraded the btrfs-progs to debian backport v5.10.1 but do no=
t
>> find any option to offline disable quota, yet:
>> https://packages.debian.org/buster-backports/btrfs-progs
>>
>> Can you point me some direction how to move forward to recover the btrf=
s?
>>
>> Thanks a lot,
>>
>> admiralbulli
>>
