Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F62439344
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 12:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhJYKDW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 06:03:22 -0400
Received: from 4.mo581.mail-out.ovh.net ([178.32.122.254]:48263 "EHLO
        4.mo581.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhJYKDT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 06:03:19 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Oct 2021 06:03:19 EDT
Received: from player770.ha.ovh.net (unknown [10.110.115.246])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 95AC6236A2
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:53:09 +0000 (UTC)
Received: from RCM-web6.webmail.mail.ovh.net (89-64-40-92.dynamic.chello.pl [89.64.40.92])
        (Authenticated sender: mailing@dmilz.net)
        by player770.ha.ovh.net (Postfix) with ESMTPSA id 65E8523AEA1A5;
        Mon, 25 Oct 2021 09:53:08 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 25 Oct 2021 11:53:08 +0200
From:   mailing@dmilz.net
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Filesystem Read Only due to errno=-28 during metadata allocation
In-Reply-To: <20211019132631.GB1208@hungrycats.org>
References: <f2ed8b05b03db6a4fec4cba7ed17222a@dmilz.net>
 <20211018140936.GA1208@hungrycats.org>
 <aefefca716de925195a0190a8d583a1d@dmilz.net>
 <20211019132631.GB1208@hungrycats.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <537ba7e11aae3e2c2cf28f546268c356@dmilz.net>
X-Sender: mailing@dmilz.net
X-Originating-IP: 89.64.40.92
X-Webmail-UserID: mailing@dmilz.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9116693021301996149
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeggfffhvffujghffgfkgihitgfgsehtjehjtddtredvnecuhfhrohhmpehmrghilhhinhhgsegumhhilhiirdhnvghtnecuggftrfgrthhtvghrnhepueekveetkeelgefgjeekheekteeugefgvedtgfehudfggeelkeeuuddugfeugfelnecukfhppedtrddtrddtrddtpdekledrieegrdegtddrledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejtddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehmrghilhhinhhgsegumhhilhiirdhnvghtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19.10.2021 15:26, Zygo Blaxell wrote:
> On Tue, Oct 19, 2021 at 12:57:39PM +0200, mailing@dmilz.net wrote:
>> On 18.10.2021 16:09, Zygo Blaxell wrote:
>> > On Wed, Oct 13, 2021 at 02:35:39PM +0200, mailing@dmilz.net wrote:
>> > > Hello,
>> > >
>> > > I faced issue with btrfs FS /var forced to RO due to errno=-28 (no
>> > > space
>> > > left).
> 
>> > Obviously, keeping 7GB reserved for metadata doesn't work on a device
>> > that is only 2.5GB to start with.  Even if you elect not to use discard
>> > or scrub, you'd still need 2.5GB for dup metadata.
>> >
>> 
>> Since this incident, the FS has been extended to 5GB.
>> 
>> But in our case the chunk size for metadata is 128MB, so:
>> 2 [dup metadata] * ( 128 * ( 1 [disk] + 1 [discard] + 1 [balance] ) + 
>> 512
>> [Global Reserve] ) = 1792 MB ?
> 
> The global reserve is normally much less than 512 MB on smaller disks.
> It is only 13MB on the 5GB disks.
> 
>> > While it's possible to use non-mixed block groups on a filesystem that
>> > has only a few GB, it's not possible to use a significant number of
>> > btrfs features, including scrub, balance, RAID disk replacement, online
>> > conversion to other RAID profiles, device shrink, or discard, due to
>> > the requirement to have an extra unlocked block group with available
>> > free space during these operations.
>> 
>> Last weekend I had the same behavior, the size allocated to metadata 
>> went
>> from 128MB to up to 768MB, so up to 6 * 12* MB metadata but the 
>> metdata
>> usage didn't grow:
>> 
>> ### Sat Oct 16 23:59:57 CEST 2021
>> Overall:
>>     Device size:                        5120.00MiB
>>     Device allocated:                   2647.25MiB
>>     Device unallocated:                 2472.75MiB
>>     Device missing:                        0.00MiB
>>     Used:                               1097.75MiB
>>     Free (estimated):                   2942.38MiB      (min: 
>> 1706.00MiB)
>>     Data ratio:                               1.00
>>     Metadata ratio:                           2.00
>>     Global reserve:                       13.00MiB      (used: 
>> 0.00MiB)
>> 
>> Data,single: Size:1559.25MiB, Used:1089.62MiB
>>    /dev/mapper/rootvg-varvol    1559.25MiB
>> 
>> Metadata,DUP: Size:512.00MiB, Used:4.00MiB
>>    /dev/mapper/rootvg-varvol    1024.00MiB
>> 
>> System,DUP: Size:32.00MiB, Used:0.06MiB
>>    /dev/mapper/rootvg-varvol      64.00MiB
>> 
>> Unallocated:
>>    /dev/mapper/rootvg-varvol    2472.75MiB
>> 
>> 
>> 
>> ### Sun Oct 17 00:00:32 CEST 2021
>> Overall:
>>     Device size:                        5120.00MiB
>>     Device allocated:                   2903.25MiB
>>     Device unallocated:                 2216.75MiB
>>     Device missing:                        0.00MiB
>>     Used:                               1097.44MiB
>>     Free (estimated):                   2686.69MiB      (min: 
>> 1578.31MiB)
>>     Data ratio:                               1.00
>>     Metadata ratio:                           2.00
>>     Global reserve:                       13.00MiB      (used: 
>> 0.00MiB)
>> 
>> Data,single: Size:1559.25MiB, Used:1089.31MiB
>>    /dev/mapper/rootvg-varvol    1559.25MiB
>> 
>> Metadata,DUP: Size:640.00MiB, Used:4.00MiB
>>    /dev/mapper/rootvg-varvol    1280.00MiB
>> 
>> System,DUP: Size:32.00MiB, Used:0.06MiB
>>    /dev/mapper/rootvg-varvol      64.00MiB
>> 
>> Unallocated:
>>    /dev/mapper/rootvg-varvol    2216.75MiB
>> 
>> 
>> ### Sun Oct 17 00:05:27 CEST 2021
>> Overall:
>>     Device size:                        5120.00MiB
>>     Device allocated:                   2903.25MiB
>>     Device unallocated:                 2216.75MiB
>>     Device missing:                        0.00MiB
>>     Used:                               1099.69MiB
>>     Free (estimated):                   2684.44MiB      (min: 
>> 1576.06MiB)
>>     Data ratio:                               1.00
>>     Metadata ratio:                           2.00
>>     Global reserve:                       13.00MiB      (used: 
>> 0.00MiB)
>> 
>> Data,single: Size:1559.25MiB, Used:1091.56MiB
>>    /dev/mapper/rootvg-varvol    1559.25MiB
>> 
>> Metadata,DUP: Size:640.00MiB, Used:4.00MiB
>>    /dev/mapper/rootvg-varvol    1280.00MiB
>> 
>> System,DUP: Size:32.00MiB, Used:0.06MiB
>>    /dev/mapper/rootvg-varvol      64.00MiB
>> 
>> Unallocated:
>>    /dev/mapper/rootvg-varvol    2216.75MiB
>> 
>> 
>> ### Sun Oct 17 00:05:32 CEST 2021
>> Overall:
>>     Device size:                        5120.00MiB
>>     Device allocated:                   3159.25MiB
>>     Device unallocated:                 1960.75MiB
>>     Device missing:                        0.00MiB
>>     Used:                               1100.25MiB
>>     Free (estimated):                   2427.88MiB      (min: 
>> 1447.50MiB)
>>     Data ratio:                               1.00
>>     Metadata ratio:                           2.00
>>     Global reserve:                       13.00MiB      (used: 
>> 0.00MiB)
>> 
>> Data,single: Size:1559.25MiB, Used:1092.12MiB
>>    /dev/mapper/rootvg-varvol    1559.25MiB
>> 
>> Metadata,DUP: Size:768.00MiB, Used:4.00MiB
>>    /dev/mapper/rootvg-varvol    1536.00MiB
>> 
>> System,DUP: Size:32.00MiB, Used:0.06MiB
>>    /dev/mapper/rootvg-varvol      64.00MiB
>> 
>> Unallocated:
>>    /dev/mapper/rootvg-varvol    1960.75MiB
>> 
>> ### Sun Oct 17 00:12:53 CEST 2021
>> Overall:
>>     Device size:                        5120.00MiB
>>     Device allocated:                   3159.25MiB
>>     Device unallocated:                 1960.75MiB
>>     Device missing:                        0.00MiB
>>     Used:                               1100.62MiB
>>     Free (estimated):                   2427.50MiB      (min: 
>> 1447.12MiB)
>>     Data ratio:                               1.00
>>     Metadata ratio:                           2.00
>>     Global reserve:                       13.00MiB      (used: 
>> 0.00MiB)
>> 
>> Data,single: Size:1559.25MiB, Used:1092.50MiB
>>    /dev/mapper/rootvg-varvol    1559.25MiB
>> 
>> Metadata,DUP: Size:768.00MiB, Used:4.00MiB
>>    /dev/mapper/rootvg-varvol    1536.00MiB
>> 
>> System,DUP: Size:32.00MiB, Used:0.06MiB
>>    /dev/mapper/rootvg-varvol      64.00MiB
>> 
>> Unallocated:
>>    /dev/mapper/rootvg-varvol    1960.75MiB
>> ### Sun Oct 17 00:12:58 CEST 2021
>> Overall:
>>     Device size:                        5120.00MiB
>>     Device allocated:                   2903.25MiB
>>     Device unallocated:                 2216.75MiB
>>     Device missing:                        0.00MiB
>>     Used:                               1100.69MiB
>>     Free (estimated):                   2683.44MiB      (min: 
>> 1575.06MiB)
>>     Data ratio:                               1.00
>>     Metadata ratio:                           2.00
>>     Global reserve:                       13.00MiB      (used: 
>> 0.12MiB)
>> 
>> Data,single: Size:1559.25MiB, Used:1092.56MiB
>>    /dev/mapper/rootvg-varvol    1559.25MiB
>> 
>> Metadata,DUP: Size:640.00MiB, Used:4.00MiB
>>    /dev/mapper/rootvg-varvol    1280.00MiB
>> 
>> System,DUP: Size:32.00MiB, Used:0.06MiB
>>    /dev/mapper/rootvg-varvol      64.00MiB
>> 
>> Unallocated:
>>    /dev/mapper/rootvg-varvol    2216.75MiB
>> 
>> So if I understand properly it might be due to chunk being needed for
>> balance/discard or scrub.
>> Is there 3rd party tools which are also able to lock metadata block 
>> group as
>> well? It seems to happens at the same time, when backup is running
>> (spectrum), and/or HANA backup and/or ReaR backup as well.
> 
> If the 3rd party tools are triggering any of the btrfs maintenance
> functions then they'll lock block groups; otherwise, normal filesystem
> operations don't generally hold locks at the block group level.
> 
> There might be some additional issues with the 4.12 kernel that cause
> it to allocate more than the minimum metadata.  I recall there were
> some problems with old kernels where multiple threads allocating at
> the same time will all grab their own chunks, but I'm not sure which
> kernel those were fixed in.  There are also changes to the allocator's
> behavior with the 'ssd' and 'nossd' mount options in 4.14 which might
> cause these effects.
> 
> Some temporary overallocation is normal.  It's likely it would have
> worked even without the overallocation, the overallocation has a pretty
> large impact on these tiny filesystems.  This seems a bit higher than
> the amount I've come to expect from modern btrfs.

Thanks for all information!

If the chunk size (128MB, 256MB... 1GB) is in relation to the FS size, 
is there a command to determine the chunk size for data and metadata? 
Should I expect BTRFS to start allocating bigger chunk at some point 
after filesystem extension?
