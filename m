Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631DB43ABFE
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 08:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhJZGFw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 26 Oct 2021 02:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbhJZGFu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 02:05:50 -0400
Received: from rx2.rx-server.de (rx2.rx-server.de [IPv6:2a03:4000:45:69b::100:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59163C061243
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 23:03:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by rx2.rx-server.de (Postfix) with ESMTP id EA81D43FCD;
        Tue, 26 Oct 2021 08:03:24 +0200 (CEST)
X-Spam-Flag: NO
X-Spam-Score: -2.402
X-Spam-Level: 
X-Spam-Status: No, score=-2.402 required=5 tests=[BAYES_00=-1.9,
        FROM_IS_REPLY_TO=-0.5, NO_RECEIVED=-0.001, NO_RELAYS=-0.001]
        autolearn=ham autolearn_force=no
Received: from rx2.rx-server.de ([127.0.0.1])
        by localhost (rx2.rx-server.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FXXWNAOZoORi; Tue, 26 Oct 2021 08:03:24 +0200 (CEST)
X-Original-To: quwenruo.btrfs@gmx.com
X-Original-To: wqu@suse.com
X-Original-To: linux-btrfs@vger.kernel.org
From:   Mia <9speysdx24@kr33.de>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>, "Qu Wenruo" <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: filesystem corrupt - error -117
Date:   Tue, 26 Oct 2021 06:03:21 +0000
Message-Id: <em2512c4e9-1e5e-4aa0-b9fc-fb68891e615d@rx2.rx-server.de>
In-Reply-To: <3ce1dd17-b574-abe3-d6cc-eb16f00117cc@rx2.rx-server.de>
References: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
 <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de>
 <c2941415-e32f-b31d-0bc2-911ede3717b7@gmx.com>
 <69109d24-efa7-b9d1-e1df-c79b3989e7bf@rx2.rx-server.de>
 <em0473d04b-06b0-43aa-91d6-1b0298103701@rx2.rx-server.de>
 <146cff2c-3081-7d03-04c8-4cc2b4ef6ff1@suse.com>
 <884d76d1-5836-9a91-a39b-41c37441e020@rx2.rx-server.de>
 <em6e5eb690-6dcd-482d-b4f2-1b940b6cb770@rx2.rx-server.de>
 <3ce1dd17-b574-abe3-d6cc-eb16f00117cc@rx2.rx-server.de>
Reply-To: Mia <9speysdx24@kr33.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

thanks for clarification.
So I should just ignore these errors for now?
What about these ones, you haven't mentioned:
bad metadata [342605463552, 342605479936) crossing stripe boundary

Problem with updating is that this is currently still Debian 10 and a 
production environment and I don't know when it is possible to upgrade 
because of dependencies.

Regards
Mia

------ Originalnachricht ------
Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
An: "Mia" <9speysdx24@kr33.de>; "Qu Wenruo" <wqu@suse.com>; 
linux-btrfs@vger.kernel.org
Gesendet: 26.10.2021 00:45:18
Betreff: Re: filesystem corrupt - error -117

>
>
>On 2021/10/26 01:09, Mia wrote:
>>Hi Qu,
>>
>>sorry for the late reply. I tried the btrfs check again with arch live cd:
>>
>>root@archiso ~ # uname -a
>>Linux archiso 5.11.16-arch1-1 #1 SMP PREEMPT Wed, 21 Apr 2021 17:22:13
>>+0000 x86_64 GNU/Linux
>>root@archiso ~ # btrfs --version
>>btrfs-progs v5.14.2
>>
>>https://gist.github.com/lynara/12dcfff870260b6bc35b9d1137921fc4
>
>OK, so the metadata problem is really there, but it shouldn't affect
>your fs right now, unless you want to mount it with 64K page size.
>
>And for the new error (inline file extent too large), it may cause
>problems, but under most cases, kernel can handle it without problem.
>>
>>I'm still getting many errors.
>>Sorry I currently don't know what caused this. I suspect it might be
>>Seafile since I'm now having a currupted library there.
>>
>>Should I use --repair?
>
>No, --repair won't help in this case.
>
>In fact, your fs is fine, no on-disk metadata problem yet.
>
>For your case, I can only recommend to use newer kernel to have better
>sanity check.
>Meanwhile I would also recommend to run a memtest to ensure it's not
>some memory problem causing the bug.
>
>Thanks,
>Qu
>
>>
>>Regards
>>Mia
>>
>>------ Originalnachricht ------
>>Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>An: "Qu Wenruo" <wqu@suse.com>; "Mia" <9speysdx24@kr33.de>;
>>linux-btrfs@vger.kernel.org
>>Gesendet: 25.10.2021 13:18:54
>>Betreff: Re: filesystem corrupt - error -117
>>
>>>
>>>
>>>On 2021/10/25 19:14, Qu Wenruo wrote:
>>>>
>>>>
>>>>On 2021/10/25 19:13, Mia wrote:
>>>>>Hi Qu,
>>>>>
>>>>>thanks for your response.
>>>>>Here the output of btrfs check:
>>>>>https://gist.github.com/lynara/1c613f7ec9448600f643a59d22c1efb2
>>>>
>>>>Unfortunately it's not full, and it's using an old btrfs-progs which can
>>>>cause false alert.
>>>
>>>My bad, gist is folding the output.
>>>
>>>It shows no corruption for the extent tree, thus I guess the transaction
>>>abort has prevented COW from being broken.
>>>
>>>>
>>>>Please use latest btrfs-progs v5.14.2 to re-check.
>>>
>>>In that case, a newer btrfs-progs is only going to remove the false
>>>alerts.
>>>
>>>Any clue on the workload causing the abort?
>>>
>>>For now, I can only recommend to use newer kernel (v5.10+ I guess?) to
>>>see if you can reproduce the problem.
>>>
>>>Thanks,
>>>Qu
>>>
>>>>
>>>>Thanks,
>>>>Qu
>>>>>
>>>>>Thanks,
>>>>>Mia
>>>>>
>>>>>------ Originalnachricht ------
>>>>>Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>>>>An: "Mia" <9speysdx24@kr33.de>; linux-btrfs@vger.kernel.org
>>>>>Gesendet: 25.10.2021 12:55:46
>>>>>Betreff: Re: filesystem corrupt - error -117
>>>>>
>>>>>>
>>>>>>
>>>>>>On 2021/10/25 18:53, Qu Wenruo wrote:
>>>>>>>
>>>>>>>
>>>>>>>On 2021/10/25 16:46, Mia wrote:
>>>>>>>>Hello,
>>>>>>>>I need support since my root filesystem just went readonly :(
>>>>>>>>
>>>>>>>>[641955.981560] BTRFS error (device sda3): tree block 342685007872
>>>>>>>>owner
>>>>>>>>7 already locked by pid=8099, extent tree corruption detected
>>>>>>>
>>>>>>>This line explains itself.
>>>>>>>
>>>>>>>Your extent tree is no corrupted, thus it allocated a new tree block
>>>>>>
>>>>>>I missed the "w" for the word "now"...
>>>>>>
>>>>>>>which is in fact already hold by other tree.
>>>>>>>
>>>>>>>This means your metadata is no longer protected properly by COW.
>>>>>>>
>>>>>>>"btrfs check" is highly recommended to expose the root cause.
>>>>>>>
>>>>>>>>
>>>>>>>>root@rx1 ~ # btrfs fi show
>>>>>>>>Label: none  uuid: 21306973-6bf3-4877-9543-633d472dcb46
>>>>>>>>      Total devices 1 FS bytes used 189.12GiB
>>>>>>>>      devid    1 size 319.00GiB used 199.08GiB path /dev/sda3
>>>>>>>>
>>>>>>>>root@rx1 ~ # btrfs fi df /
>>>>>>>>Data, single: total=194.89GiB, used=187.46GiB
>>>>>>>>System, single: total=32.00MiB, used=48.00KiB
>>>>>>>>Metadata, single: total=4.16GiB, used=1.65GiB
>>>>>>>>GlobalReserve, single: total=380.45MiB, used=0.00B
>>>>>>>>
>>>>>>>>root@rx1 ~ # btrfs --version
>>>>>>>>                                                 :(
>>>>>>>>btrfs-progs v4.20.1
>>>>>>>>
>>>>>>>>
>>>>>>>>root@rx1 ~ # uname -a
>>>>>>>>Linux rx1 4.19.0-17-amd64 #1 SMP Debian 4.19.194-3 (2021-07-18)
>>>>>>>>x86_64
>>>>>>>>GNU/Linux
>>>>>>>
>>>>>>>This is a little old for btrfs, but I don't think that's the cause.
>>>>>>>
>>>>>>>Thanks,
>>>>>>>Qu
>>>>>>>
>>>>>>>>
>>>>>>>>Hope someone can help.
>>>>>>>>Regrads
>>>>>>>>Mia
>>>>>>>>
>>>>>
>>>>
>>

