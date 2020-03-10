Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFB1017F771
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 13:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgCJM3k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 08:29:40 -0400
Received: from a4-3.smtp-out.eu-west-1.amazonses.com ([54.240.4.3]:54686 "EHLO
        a4-3.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726273AbgCJM3k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 08:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1583843378;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=jSdzJA3T0GxJuUaeAyFM0INDqDZi0A+tc/CK8AbkSDo=;
        b=caEQm/pDwHHgXzpzX6fsDtbY2DWbWnHWfr4kJOaBP/l0w29/valrpQxEooo2xeJo
        wbXhrW3aHgPEWUgZahAuv1ciFfeIWl7uXEv1KCIo0wBSuxcY1xuyYuCUtJ+im+WnZy3
        dhdESfUdpB5MSD9wMcgXtOdpbpDtCr1Y74/WNvAM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1583843378;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=jSdzJA3T0GxJuUaeAyFM0INDqDZi0A+tc/CK8AbkSDo=;
        b=kMX/g8kZm74acuNRD1v1O7BKbz3CjalpmoRx6sfVjZHSmClgm2G0ZDmSO2t9CNvM
        z/PKSuPjjJZXoeqaJJsTMixxswvWuQL7aXUpkCGXrkVrxGS2bno/xrUNZ1s5CBRbom1
        CIcGZnCd+n5I55K7udXQcYXpmgweT7nW9ivz4CTI=
Subject: Re: ENOSPC in btrfs_drop_snapshot with 5.4.21
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <01020170c1c26e04-031eb2cc-f2da-4ba3-b259-986730cfae7a-000000@eu-west-1.amazonses.com>
 <4d136b19-b2d9-bc4a-8dba-504ae3aabdf8@suse.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <01020170c46c0495-72dcea31-f541-4b4a-9e17-55a595d289e6-000000@eu-west-1.amazonses.com>
Date:   Tue, 10 Mar 2020 12:29:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4d136b19-b2d9-bc4a-8dba-504ae3aabdf8@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.03.10-54.240.4.3
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10.03.2020 09:54 Nikolay Borisov wrote:
>
> On 10.03.20 г. 2:05 ч., Martin Raiber wrote:
>> Hi,
>>
>> I get a enospc to remount-ro with 5.4.21. Details:
>>
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
> Were you performing any specific operation when this happened or you had
> simply deleted a snapshot and some time later you got the ENOSPC?

It does something like this if it matters: It creates a chain of
snapshots and writes only to the one it last created, while sometimes
deleting files from older snapshots in the chain. It has max 5 snapshots
in the chain and every ~60min creates a new one and later deletes the
oldest. For example it has a_1, a_2, a_3, a_4, a_5 (a_2 being a
writeable snapshot of a_1) and writes only to a_5. Then it snapshots a_5
to a_6 and then only writes to a_6 and later deletes a_1.

Looking at the latest ENOSPC that occured at 3:55, it created the latest
snapshot at 3:05 and deleted the oldest at 3:48. It wrote to the latest
snapshot while it dropped the oldest.

