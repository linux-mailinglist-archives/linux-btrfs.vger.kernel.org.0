Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1934017EE53
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 03:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgCJCCm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 22:02:42 -0400
Received: from a4-3.smtp-out.eu-west-1.amazonses.com ([54.240.4.3]:46392 "EHLO
        a4-3.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbgCJCCm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Mar 2020 22:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1583805760;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=iJdTbLOABClAZBsmQOc/oKWzZ3Ud0LyDd64NOK8rlY4=;
        b=BP0CohVxxOQGCV6zxUdwAHG4iAoKzVshiBHeKnJuOXT4VheC8P6NJ/JQ9vaMFiuy
        I/Uurr4HYy1b6wbx5oZnNXjLxmbh3kpw2uJIhFdpt56KjwwC4KA3RIwN/UmrRgEQcwv
        APxw0v85Bhy8OFhkSV7DGr/M3wxtZ1eToDxIKiLk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1583805760;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=iJdTbLOABClAZBsmQOc/oKWzZ3Ud0LyDd64NOK8rlY4=;
        b=HZloe7WWrY990aMN4zZvGvAUyXvBs5sCU3V+vWyOUDelDBt5BDJtxEfh1Dltf1Rh
        xyd5eoXRZnjDThOdjB0+sIK1g06N5k3K/u8uQEuiBL7sSD7gBUYKHFb4C8pae1wy7Un
        IF3Qhcz5Tqev7BOS5/3ZdRC4IgTDawmwbwfwoAyE=
Subject: Re: ENOSPC in btrfs_drop_snapshot with 5.4.21
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <01020170c1c26e04-031eb2cc-f2da-4ba3-b259-986730cfae7a-000000@eu-west-1.amazonses.com>
 <f44d3ea5-7ec5-60c2-f0cb-bb9654bf7d47@gmx.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <01020170c22e02f3-0fac99b3-1cb9-4d17-88e8-4d6bab41d934-000000@eu-west-1.amazonses.com>
Date:   Tue, 10 Mar 2020 02:02:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f44d3ea5-7ec5-60c2-f0cb-bb9654bf7d47@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.03.10-54.240.4.3
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10.03.2020 02:41 Qu Wenruo wrote:
>
> On 2020/3/10 上午8:05, Martin Raiber wrote:
>> Hi,
>>
>> I get a enospc to remount-ro with 5.4.21. Details:
> Sorry, the attached dmesg doesn't contain the transaction abort message.
>
> It only has the flooded ENOSPC from enospc_debug option.

This isn't it?

[76641.627535] BTRFS: error (device dm-0) in btrfs_drop_snapshot:5419:
errno=-28 No space left
[76641.627549] BTRFS info (device dm-0): forced readonly
[...]

>
> Thanks,
> Qu
>> Linux 5.4.21 #1 SMP Fri Feb 21 03:20:26 CET 2020 x86_64 GNU/Linux
>>
>> btrfs fi usage /media/btrfs (after remount-ro)
>> Overall:
>>     Device size:                 511.99GiB
>>     Device allocated:            511.99GiB
>>     Device unallocated:              0.00B
>>     Device missing:                  0.00B
>>     Used:                        443.68GiB
>>     Free (estimated):             54.94GiB      (min: 54.94GiB)
>>     Data ratio:                       1.00
>>     Metadata ratio:                   1.00
>>     Global reserve:              512.00MiB      (used: 0.00B)
>>
>> Data,single: Size:490.98GiB, Used:436.04GiB (88.81%)
>>    /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc  490.98GiB
>>
>> Metadata,single: Size:21.01GiB, Used:7.65GiB (36.40%)
>>    /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc   21.01GiB
>>
>> System,single: Size:4.00MiB, Used:80.00KiB (1.95%)
>>    /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc    4.00MiB
>>
>> Unallocated:
>>    /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc      0.00B
>>
>> Mount options:
>> /dev/mapper/LUKS-RC-cd46b6b4909845918eaa285c532476dc on /media/btrfs
>> type btrfs
>> (ro,noatime,compress-force=zstd:3,nossd,space_cache=v2,enospc_debug,skip_balance,metadata_ratio=8,subvolid=5,subvol=/)
>>
>> btrfs fi df /media/btrfs
>> Data, single: total=490.98GiB, used=436.04GiB
>> System, single: total=4.00MiB, used=80.00KiB
>> Metadata, single: total=21.01GiB, used=7.65GiB
>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>
>> dmesg attached.
>>

