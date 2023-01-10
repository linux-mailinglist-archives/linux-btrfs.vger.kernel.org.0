Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA97664DDE
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 22:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjAJVM6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 16:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjAJVMw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 16:12:52 -0500
Received: from ns2.prnet.org (ns2.prnet.org [188.165.43.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A104634D6F;
        Tue, 10 Jan 2023 13:12:47 -0800 (PST)
Received: from secure.prnet.org (mail.intern.prnet.org [192.168.1.206])
        by ns2.prnet.org (Postfix) with ESMTP id 4F561FAB19;
        Tue, 10 Jan 2023 22:13:30 +0100 (CET)
Received: from [IPV6:2001:7e8:cf00:bc01:9441:d7ff:fede:982a] (unknown [IPv6:2001:7e8:cf00:bc01:9441:d7ff:fede:982a])
        by secure.prnet.org (Postfix) with ESMTPSA id A48B3163950;
        Tue, 10 Jan 2023 22:12:45 +0100 (CET)
Message-ID: <d4f0758b-d11c-aee8-43df-885233a14a80@prnet.org>
Date:   Tue, 10 Jan 2023 22:12:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [regression] Bug 216851 - btrfs write time corrupting for log
 tree
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <ae169fc6-f504-28f0-a098-6fa6a4dfb612@leemhuis.info>
 <20230102154050.GJ11562@twin.jikos.cz>
 <ac2f141b-b03a-6054-8250-d27a5b568027@gmx.com>
 <03ad09d2-0c0e-ed82-509a-9758fbc81f64@prnet.org>
 <CAL3q7H75DScFAnUGHFn9x=ZmnCbd_u3+KsLU6qKOGPeVogOQwg@mail.gmail.com>
 <544a0942-d505-148e-9b65-f5b366a3a0e3@prnet.org>
 <CAL3q7H7b+hrro9weiE2fLFMwvUm0PBjKPqetpQyGHUFqQd8s=w@mail.gmail.com>
 <ec38dc9b-6e54-7166-402a-fe92c38170d0@prnet.org>
 <CAL3q7H7anKa6ova5MYx4ZDsz6gwaq-K0OSRZuNEo-hNft7pZHQ@mail.gmail.com>
 <3b5c7161-1a48-619b-b6b3-1868b7695c97@prnet.org>
 <CAL3q7H7pEYNpzZYgNRxXwMz6ftCK53u46CQjPAh8nTO4ixgYwg@mail.gmail.com>
 <CAL3q7H5bdpH621LRO+mr98r_MBhNFLU3q1NQ8erOjZFkFAzf-A@mail.gmail.com>
Content-Language: en-US
From:   David Arendt <admin@prnet.org>
In-Reply-To: <CAL3q7H5bdpH621LRO+mr98r_MBhNFLU3q1NQ8erOjZFkFAzf-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/10/23 16:10, Filipe Manana wrote:
> On Thu, Jan 5, 2023 at 9:11 PM Filipe Manana <fdmanana@kernel.org> wrote:
>> On Thu, Jan 5, 2023 at 6:24 PM David Arendt <admin@prnet.org> wrote:
>>> On 1/5/23 18:04, Filipe Manana wrote:
>>>> On Thu, Jan 5, 2023 at 4:49 PM David Arendt <admin@prnet.org> wrote:
>>>>> On 1/5/23 11:22, Filipe Manana wrote:
>>>>>> On Wed, Jan 4, 2023 at 7:35 PM David Arendt <admin@prnet.org> wrote:
>>>>>>> On 1/4/23 20:29, Filipe Manana wrote:
>>>>>>>> On Wed, Jan 4, 2023 at 7:26 PM David Arendt <admin@prnet.org> wrote:
>>>>>>>>> On 1/3/23 00:38, Qu Wenruo wrote:
>>>>>>>>>> On 2023/1/2 23:40, David Sterba wrote:
>>>>>>>>>>> On Tue, Dec 27, 2022 at 03:01:34PM +0100, Thorsten Leemhuis wrote:
>>>>>>>>>>>> Hi, this is your Linux kernel regression tracker speaking.
>>>>>>>>>>>>
>>>>>>>>>>>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>>>>>>>>>>>> kernel developer don't keep an eye on it, I decided to forward it by
>>>>>>>>>>>> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216851 :
>>>>>>>>>>>>
>>>>>>>>>>>>> I am experiencing btrfs file system errors followed by a switch to
>>>>>>>>>>>>> readony with kernel 6.1 and 6.1.1. It never happened with kernel
>>>>>>>>>>>>> versions before.
>>>>>>>>>>>>>
>>>>>>>>>>>>> A btrfs scrub and a btrfs check --readonly returned 0 errors.
>>>>>>>>>>>>>
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS
>>>>>>>>>>>>> critical (device sda2): corrupt leaf: root=18446744073709551610
>>>>>>>>>>>>> block=203366612992 slot=73, bad key order, prev (484119 96 1312873)
>>>>>>>>>>>>> current (484119 96 1312849)
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS info
>>>>>>>>>>>>> (device sda2): leaf 203366612992 gen 5068802 total ptrs 105 free
>>>>>>>>>>>>> space 10820 owner 18446744073709551610
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 0
>>>>>>>>>>>>> key (484119 1 0) itemoff 16123 itemsize 160
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09inode generation 45 size 2250 mode 40700
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 1
>>>>>>>>>>>>> key (484119 12 484118) itemoff 16097 itemsize 26
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 2
>>>>>>>>>>>>> key (484119 72 15) itemoff 16089 itemsize 8
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 3
>>>>>>>>>>>>> key (484119 72 20) itemoff 16081 itemsize 8
>>>>>>>>>>>>> ...
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 82
>>>>>>>>>>>>> key (484119 96 1312873) itemoff 14665 itemsize 51
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 83
>>>>>>>>>>>>> key (484119 96 1312877) itemoff 14609 itemsize 56
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 84
>>>>>>>>>>>>> key (484128 1 0) itemoff 14449 itemsize 160
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09inode generation 45 size 98304 mode 100644
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 85
>>>>>>>>>>>>> key (484128 108 0) itemoff 14396 itemsize 53
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data disk bytenr 10674830381056 nr 65536
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data offset 0 nr 65536 ram 65536
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 86
>>>>>>>>>>>>> key (484129 1 0) itemoff 14236 itemsize 160
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09inode generation 45 size 26214400 mode 100644
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 87
>>>>>>>>>>>>> key (484129 108 589824) itemoff 14183 itemsize 53
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data disk bytenr 10665699962880 nr 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 88
>>>>>>>>>>>>> key (484129 108 2850816) itemoff 14130 itemsize 53
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data disk bytenr 10665848733696 nr 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 89
>>>>>>>>>>>>> key (484129 108 11042816) itemoff 14077 itemsize 53
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data disk bytenr 10660869349376 nr 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 90
>>>>>>>>>>>>> key (484129 108 13402112) itemoff 14024 itemsize 53
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data disk bytenr 10660207378432 nr 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 91
>>>>>>>>>>>>> key (484129 108 19628032) itemoff 13971 itemsize 53
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data disk bytenr 10665835618304 nr 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 92
>>>>>>>>>>>>> key (484129 108 21266432) itemoff 13918 itemsize 53
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data disk bytenr 10661222666240 nr 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 93
>>>>>>>>>>>>> key (484129 108 22740992) itemoff 13865 itemsize 53
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data disk bytenr 10665565814784 nr 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 94
>>>>>>>>>>>>> key (484129 108 23101440) itemoff 13812 itemsize 53
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data disk bytenr 10665836371968 nr 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 95
>>>>>>>>>>>>> key (484129 108 24084480) itemoff 13759 itemsize 53
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data disk bytenr 10665836404736 nr 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 96
>>>>>>>>>>>>> key (484129 108 24150016) itemoff 13706 itemsize 53
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data disk bytenr 10665849159680 nr 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 97
>>>>>>>>>>>>> key (484129 108 24313856) itemoff 13653 itemsize 53
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data disk bytenr 10665849192448 nr 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 98
>>>>>>>>>>>>> key (484147 1 0) itemoff 13493 itemsize 160
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>>>> \x09\x09inode generation 45 size 886 mode 40755
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 99
>>>>>>>>>>>>> key (484147 72 4) itemoff 13485 itemsize 8
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 100
>>>>>>>>>>>>> key (484147 72 27) itemoff 13477 itemsize 8
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 101
>>>>>>>>>>>>> key (484147 72 35) itemoff 13469 itemsize 8
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 102
>>>>>>>>>>>>> key (484147 72 40) itemoff 13461 itemsize 8
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 103
>>>>>>>>>>>>> key (484147 72 45) itemoff 13453 itemsize 8
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 104
>>>>>>>>>>>>> key (484147 72 52) itemoff 13445 itemsize 8
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS error
>>>>>>>>>>>>> (device sda2): block=203366612992 write time tree block corruption
>>>>>>>>>>>>> detected
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS: error
>>>>>>>>>>>>> (device sda2: state AL) in free_log_tree:3284: errno=-5 IO failure
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS info
>>>>>>>>>>>>> (device sda2: state EAL): forced readonly
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS
>>>>>>>>>>>>> warning (device sda2: state EAL): Skipping commit of aborted
>>>>>>>>>>>>> transaction.
>>>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS: error
>>>>>>>>>>>>> (device sda2: state EAL) in cleanup_transaction:1958: errno=-5 IO
>>>>>>>>>>>>> failure
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> There are no SSD access errors in the kernel logs. Smart data for
>>>>>>>>>>>>> the SSD is normal. I also did a 12 hour memtest to rule out bad RAM.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The filesystem consists of a single 480GB SATA SSD (Corsair Neutron
>>>>>>>>>>>>> XTI). The problems occurs only on one machine.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The error appears about every few days and seems to be triggered by
>>>>>>>>>>>>> a cspecially under high cpu utilization combined with some disk IO.
>>>>>>>>>>>>> CPU temperature never exceeds 60 degrees.
>>>>>>>>>>>> See the ticket for more details.
>>>>>>>>>>>>
>>>>>>>>>>>> For the record, the issue is apparently different from the 6.2-rc
>>>>>>>>>>>> regression currently discussed, as stated here:
>>>>>>>>>>>> https://lore.kernel.org/lkml/462e7bd3-d1f2-3718-fde9-77b418e9fd91@gmx.com/
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> BTW, let me use this mail to also add the report to the list of tracked
>>>>>>>>>>>> regressions to ensure it's doesn't fall through the cracks:
>>>>>>>>>>>>
>>>>>>>>>>>> #regzbot introduced: v6.0..v6.1
>>>>>>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=216851
>>>>>>>>>>>> #regzbot title: btrfs: write time corrupting for log tree in 6.1
>>>>>>>>>>>> #regzbot ignore-activity
>>>>>>>>>>> #regzbot fix: 'btrfs: fix false alert on bad tree level check'
>>>>>>>>>> Oh no, this is a different one, this one is not level mismatch.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Qu
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> Here the logging from another crash, this time on kernel 6.1.3, about 1
>>>>>>>>> hour after boot. Again during high CPU usage combined with lots of io.
>>>>>>>>>
>>>>>>>>> [ 1989.025015] BTRFS critical (device sda2): corrupt leaf:
>>>>>>>>> root=18446744073709551610 block=574078976 slot=70, bad key order, prev
>>>>>>>>> (484119 96 1328571) current (484119 96 1328553)
>>>>>>>>> [ 1989.025022] BTRFS info (device sda2): leaf 574078976 gen 5089233
>>>>>>>>> total ptrs 108 free space 10370 owner 18446744073709551610
>>>>>>>>> [ 1989.025024]  item 0 key (484119 1 0) itemoff 16123 itemsize 160
>>>>>>>>> [ 1989.025025]          inode generation 45 size 2198 mode 40700
>>>>>>>>> [ 1989.025026]  item 1 key (484119 12 484118) itemoff 16097 itemsize 26
>>>>>>>>> [ 1989.025027]  item 2 key (484119 72 15) itemoff 16089 itemsize 8
>>>>>>>>> [ 1989.025027]  item 3 key (484119 72 20) itemoff 16081 itemsize 8
>>>>>>>>>
>>>>>>>>> ...
>>>>>>>> Can you please paste the full message?
>>>>>>>> If an error/warning, don't just paste a section of the message, paste
>>>>>>>> the full thing.
>>>>>>>>
>>>>>>>> I've previously commented on that in the other thread:
>>>>>>>>
>>>>>>>> https://lore.kernel.org/linux-btrfs/CAL3q7H6RbPsa9Ff9or6+0d4R5vzVcR=RPxHA0=3A_KeSmf7hcQ@mail.gmail.com/
>>>>>>>>
>>>>>>>> Thanks.
>>>>>>>>
>>>>>>>>
>>>>>>>>> [ 1989.025135]  item 105 key (484147 1 0) itemoff 13086 itemsize 160
>>>>>>>>> [ 1989.025137]          inode generation 45 size 886 mode 40755
>>>>>>>>> [ 1989.025138]  item 106 key (484147 72 4) itemoff 13078 itemsize 8
>>>>>>>>> [ 1989.025139]  item 107 key (484147 72 27) itemoff 13070 itemsize 8
>>>>>>>>> [ 1989.025140] BTRFS error (device sda2): block=574078976 write time
>>>>>>>>> tree block corruption detected
>>>>>>>>> [ 1989.053710] BTRFS: error (device sda2: state AL) in
>>>>>>>>> free_log_tree:3284: errno=-5 IO failure
>>>>>>>>> [ 1989.053717] BTRFS info (device sda2: state EAL): forced readonly
>>>>>>>>> [ 1989.055442] BTRFS warning (device sda2: state EAL): Skipping commit
>>>>>>>>> of aborted transaction.
>>>>>>>>> [ 1989.055444] BTRFS: error (device sda2: state EAL) in
>>>>>>>>> cleanup_transaction:1958: errno=-5 IO failure
>>>>>>>>>
>>>>>>>>> Thanks in advance,
>>>>>>>>>
>>>>>>>>> David Arendt
>>>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> here is the full message:
>>>>>> Ok, this is intriguing. Same set of keys is added twice to a leaf.
>>>>>>
>>>>>> Are you able to apply a debug patch which adds extra logging when the
>>>>>> issue happens?
>>>>>> That would be the fastest way to figure where and why the issue is happening.
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>>
>>>>>>> [ 1989.025015] BTRFS critical (device sda2): corrupt leaf:
>>>>>>> root=18446744073709551610 block=574078976 slot=70, bad key order, prev
>>>>>>> (484119 96 1328571) current (484119 96 1328553)
>>>>>>> [ 1989.025022] BTRFS info (device sda2): leaf 574078976 gen 5089233
>>>>>>> total ptrs 108 free space 10370 owner 18446744073709551610
>>>>>>> [ 1989.025024]     item 0 key (484119 1 0) itemoff 16123 itemsize 160
>>>>>>> [ 1989.025025]         inode generation 45 size 2198 mode 40700
>>>>>>> [ 1989.025026]     item 1 key (484119 12 484118) itemoff 16097 itemsize 26
>>>>>>> [ 1989.025027]     item 2 key (484119 72 15) itemoff 16089 itemsize 8
>>>>>>> [ 1989.025027]     item 3 key (484119 72 20) itemoff 16081 itemsize 8
>>>>>>> [ 1989.025028]     item 4 key (484119 72 25) itemoff 16073 itemsize 8
>>>>>>> [ 1989.025029]     item 5 key (484119 72 30) itemoff 16065 itemsize 8
>>>>>>> [ 1989.025029]     item 6 key (484119 72 32630) itemoff 16057 itemsize 8
>>>>>>> [ 1989.025030]     item 7 key (484119 72 40332) itemoff 16049 itemsize 8
>>>>>>> [ 1989.025031]     item 8 key (484119 72 40335) itemoff 16041 itemsize 8
>>>>>>> [ 1989.025031]     item 9 key (484119 72 93630) itemoff 16033 itemsize 8
>>>>>>> [ 1989.025032]     item 10 key (484119 72 101741) itemoff 16025 itemsize 8
>>>>>>> [ 1989.025033]     item 11 key (484119 72 131485) itemoff 16017 itemsize 8
>>>>>>> [ 1989.025034]     item 12 key (484119 72 183799) itemoff 16009 itemsize 8
>>>>>>> [ 1989.025034]     item 13 key (484119 72 183801) itemoff 16001 itemsize 8
>>>>>>> [ 1989.025035]     item 14 key (484119 72 203038) itemoff 15993 itemsize 8
>>>>>>> [ 1989.025036]     item 15 key (484119 72 254997) itemoff 15985 itemsize 8
>>>>>>> [ 1989.025036]     item 16 key (484119 72 255172) itemoff 15977 itemsize 8
>>>>>>> [ 1989.025037]     item 17 key (484119 72 255208) itemoff 15969 itemsize 8
>>>>>>> [ 1989.025037]     item 18 key (484119 72 256848) itemoff 15961 itemsize 8
>>>>>>> [ 1989.025038]     item 19 key (484119 72 264839) itemoff 15953 itemsize 8
>>>>>>> [ 1989.025039]     item 20 key (484119 72 266090) itemoff 15945 itemsize 8
>>>>>>> [ 1989.025039]     item 21 key (484119 72 266976) itemoff 15937 itemsize 8
>>>>>>> [ 1989.025040]     item 22 key (484119 72 267056) itemoff 15929 itemsize 8
>>>>>>> [ 1989.025040]     item 23 key (484119 72 302340) itemoff 15921 itemsize 8
>>>>>>> [ 1989.025041]     item 24 key (484119 72 513980) itemoff 15913 itemsize 8
>>>>>>> [ 1989.025042]     item 25 key (484119 72 848319) itemoff 15905 itemsize 8
>>>>>>> [ 1989.025042]     item 26 key (484119 72 848845) itemoff 15897 itemsize 8
>>>>>>> [ 1989.025043]     item 27 key (484119 72 938962) itemoff 15889 itemsize 8
>>>>>>> [ 1989.025044]     item 28 key (484119 72 1001565) itemoff 15881 itemsize 8
>>>>>>> [ 1989.025044]     item 29 key (484119 72 1217319) itemoff 15873 itemsize 8
>>>>>>> [ 1989.025045]     item 30 key (484119 72 1217321) itemoff 15865 itemsize 8
>>>>>>> [ 1989.025046]     item 31 key (484119 72 1268172) itemoff 15857 itemsize 8
>>>>>>> [ 1989.025046]     item 32 key (484119 72 1298657) itemoff 15849 itemsize 8
>>>>>>> [ 1989.025047]     item 33 key (484119 72 1299762) itemoff 15841 itemsize 8
>>>>>>> [ 1989.025048]     item 34 key (484119 72 1322969) itemoff 15833 itemsize 8
>>>>>>> [ 1989.025048]     item 35 key (484119 72 1326818) itemoff 15825 itemsize 8
>>>>>>> [ 1989.025049]     item 36 key (484119 72 1327157) itemoff 15817 itemsize 8
>>>>>>> [ 1989.025050]     item 37 key (484119 72 1327930) itemoff 15809 itemsize 8
>>>>>>> [ 1989.025050]     item 38 key (484119 72 1327934) itemoff 15801 itemsize 8
>>>>>>> [ 1989.025051]     item 39 key (484119 72 1328324) itemoff 15793 itemsize 8
>>>>>>> [ 1989.025052]     item 40 key (484119 72 1328423) itemoff 15785 itemsize 8
>>>>>>> [ 1989.025052]     item 41 key (484119 72 1328486) itemoff 15777 itemsize 8
>>>>>>> [ 1989.025053]     item 42 key (484119 72 1328506) itemoff 15769 itemsize 8
>>>>>>> [ 1989.025054]     item 43 key (484119 72 1328507) itemoff 15761 itemsize 8
>>>>>>> [ 1989.025054]     item 44 key (484119 72 1328509) itemoff 15753 itemsize 8
>>>>>>> [ 1989.025055]     item 45 key (484119 72 1328510) itemoff 15745 itemsize 8
>>>>>>> [ 1989.025055]     item 46 key (484119 72 1328511) itemoff 15737 itemsize 8
>>>>>>> [ 1989.025056]     item 47 key (484119 72 1328514) itemoff 15729 itemsize 8
>>>>>>> [ 1989.025057]     item 48 key (484119 72 1328515) itemoff 15721 itemsize 8
>>>>>>> [ 1989.025057]     item 49 key (484119 72 1328518) itemoff 15713 itemsize 8
>>>>>>> [ 1989.025058]     item 50 key (484119 72 1328519) itemoff 15705 itemsize 8
>>>>>>> [ 1989.025059]     item 51 key (484119 72 1328520) itemoff 15697 itemsize 8
>>>>>>> [ 1989.025059]     item 52 key (484119 72 1328521) itemoff 15689 itemsize 8
>>>>>>> [ 1989.025060]     item 53 key (484119 72 1328523) itemoff 15681 itemsize 8
>>>>>>> [ 1989.025060]     item 54 key (484119 72 1328525) itemoff 15673 itemsize 8
>>>>>>> [ 1989.025061]     item 55 key (484119 72 1328528) itemoff 15665 itemsize 8
>>>>>>> [ 1989.025062]     item 56 key (484119 72 1328529) itemoff 15657 itemsize 8
>>>>>>> [ 1989.025062]     item 57 key (484119 72 1328532) itemoff 15649 itemsize 8
>>>>>>> [ 1989.025063]     item 58 key (484119 72 1328561) itemoff 15641 itemsize 8
>>>>>>> [ 1989.025063]     item 59 key (484119 72 1328564) itemoff 15633 itemsize 8
>>>>>>> [ 1989.025064]     item 60 key (484119 72 1328566) itemoff 15625 itemsize 8
>>>>>>> [ 1989.025065]     item 61 key (484119 72 1328570) itemoff 15617 itemsize 8
>>>>>>> [ 1989.025065]     item 62 key (484119 96 1328553) itemoff 15566 itemsize 51
>>>>>>> [ 1989.025066]     item 63 key (484119 96 1328555) itemoff 15523 itemsize 43
>>>>>>> [ 1989.025067]     item 64 key (484119 96 1328559) itemoff 15489 itemsize 34
>>>>>>> [ 1989.025067]     item 65 key (484119 96 1328563) itemoff 15441 itemsize 48
>>>>>>> [ 1989.025068]     item 66 key (484119 96 1328565) itemoff 15388 itemsize 53
>>>>>>> [ 1989.025069]     item 67 key (484119 96 1328568) itemoff 15341 itemsize 47
>>>>>>> [ 1989.025069]     item 68 key (484119 96 1328569) itemoff 15292 itemsize 49
>>>>>>> [ 1989.025070]     item 69 key (484119 96 1328571) itemoff 15254 itemsize 38
>>>>>>> [ 1989.025071]     item 70 key (484119 96 1328553) itemoff 15203 itemsize 51
>>>>>>> [ 1989.025071]     item 71 key (484119 96 1328555) itemoff 15160 itemsize 43
>>>>>>> [ 1989.025072]     item 72 key (484119 96 1328559) itemoff 15126 itemsize 34
>>>>>>> [ 1989.025073]     item 73 key (484119 96 1328563) itemoff 15078 itemsize 48
>>>>>>> [ 1989.025073]     item 74 key (484119 96 1328565) itemoff 15025 itemsize 53
>>>>>>> [ 1989.025074]     item 75 key (484119 96 1328568) itemoff 14978 itemsize 47
>>>>>>> [ 1989.025074]     item 76 key (484119 96 1328569) itemoff 14929 itemsize 49
>>>>>>> [ 1989.025076]     item 77 key (484119 96 1328571) itemoff 14891 itemsize 38
>>>>>>> [ 1989.025077]     item 78 key (484128 1 0) itemoff 14731 itemsize 160
>>>>>>> [ 1989.025078]         inode generation 45 size 98304 mode 100644
>>>>>>> [ 1989.025079]     item 79 key (484128 108 0) itemoff 14678 itemsize 53
>>>>>>> [ 1989.025080]         extent data disk bytenr 10698843275264 nr 65536
>>>>>>> [ 1989.025081]         extent data offset 0 nr 65536 ram 65536
>>>>>>> [ 1989.025081]     item 80 key (484129 1 0) itemoff 14518 itemsize 160
>>>>>>> [ 1989.025082]         inode generation 45 size 26214400 mode 100644
>>>>>>> [ 1989.025083]     item 81 key (484129 108 589824) itemoff 14465 itemsize 53
>>>>>>> [ 1989.025084]         extent data disk bytenr 10697670373376 nr 32768
>>>>>>> [ 1989.025085]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025086]     item 82 key (484129 108 1310720) itemoff 14412
>>>>>>> itemsize 53
>>>>>>> [ 1989.025087]         extent data disk bytenr 10697126309888 nr 32768
>>>>>>> [ 1989.025087]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025088]     item 83 key (484129 108 3670016) itemoff 14359
>>>>>>> itemsize 53
>>>>>>> [ 1989.025089]         extent data disk bytenr 10697672445952 nr 32768
>>>>>>> [ 1989.025090]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025090]     item 84 key (484129 108 10944512) itemoff 14306
>>>>>>> itemsize 53
>>>>>>> [ 1989.025091]         extent data disk bytenr 10697673764864 nr 65536
>>>>>>> [ 1989.025092]         extent data offset 0 nr 65536 ram 65536
>>>>>>> [ 1989.025093]     item 85 key (484129 108 11304960) itemoff 14253
>>>>>>> itemsize 53
>>>>>>> [ 1989.025094]         extent data disk bytenr 10697154973696 nr 32768
>>>>>>> [ 1989.025095]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025095]     item 86 key (484129 108 11370496) itemoff 14200
>>>>>>> itemsize 53
>>>>>>> [ 1989.025096]         extent data disk bytenr 10697160564736 nr 32768
>>>>>>> [ 1989.025097]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025098]     item 87 key (484129 108 11730944) itemoff 14147
>>>>>>> itemsize 53
>>>>>>> [ 1989.025099]         extent data disk bytenr 10697672478720 nr 32768
>>>>>>> [ 1989.025100]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025100]     item 88 key (484129 108 12156928) itemoff 14094
>>>>>>> itemsize 53
>>>>>>> [ 1989.025102]         extent data disk bytenr 10697673052160 nr 32768
>>>>>>> [ 1989.025102]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025103]     item 89 key (484129 108 12353536) itemoff 14041
>>>>>>> itemsize 53
>>>>>>> [ 1989.025104]         extent data disk bytenr 10697160597504 nr 32768
>>>>>>> [ 1989.025105]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025106]     item 90 key (484129 108 12582912) itemoff 13988
>>>>>>> itemsize 53
>>>>>>> [ 1989.025107]         extent data disk bytenr 10697677389824 nr 32768
>>>>>>> [ 1989.025108]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025108]     item 91 key (484129 108 13139968) itemoff 13935
>>>>>>> itemsize 53
>>>>>>> [ 1989.025110]         extent data disk bytenr 10697681383424 nr 65536
>>>>>>> [ 1989.025110]         extent data offset 0 nr 65536 ram 65536
>>>>>>> [ 1989.025111]     item 92 key (484129 108 13467648) itemoff 13882
>>>>>>> itemsize 53
>>>>>>> [ 1989.025111]         extent data disk bytenr 10697743683584 nr 65536
>>>>>>> [ 1989.025112]         extent data offset 0 nr 65536 ram 65536
>>>>>>> [ 1989.025112]     item 93 key (484129 108 13697024) itemoff 13829
>>>>>>> itemsize 53
>>>>>>> [ 1989.025113]         extent data disk bytenr 10697160630272 nr 32768
>>>>>>> [ 1989.025113]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025114]     item 94 key (484129 108 13795328) itemoff 13776
>>>>>>> itemsize 53
>>>>>>> [ 1989.025114]         extent data disk bytenr 10697160663040 nr 32768
>>>>>>> [ 1989.025115]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025115]     item 95 key (484129 108 14090240) itemoff 13723
>>>>>>> itemsize 53
>>>>>>> [ 1989.025116]         extent data disk bytenr 10697160695808 nr 32768
>>>>>>> [ 1989.025116]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025117]     item 96 key (484129 108 14548992) itemoff 13670
>>>>>>> itemsize 53
>>>>>>> [ 1989.025117]         extent data disk bytenr 10697677422592 nr 32768
>>>>>>> [ 1989.025118]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025118]     item 97 key (484129 108 17694720) itemoff 13617
>>>>>>> itemsize 53
>>>>>>> [ 1989.025119]         extent data disk bytenr 10697686274048 nr 32768
>>>>>>> [ 1989.025119]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025120]     item 98 key (484129 108 19726336) itemoff 13564
>>>>>>> itemsize 53
>>>>>>> [ 1989.025121]         extent data disk bytenr 10697688305664 nr 32768
>>>>>>> [ 1989.025121]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025122]     item 99 key (484129 108 20185088) itemoff 13511
>>>>>>> itemsize 53
>>>>>>> [ 1989.025122]         extent data disk bytenr 10697690374144 nr 32768
>>>>>>> [ 1989.025123]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025124]     item 100 key (484129 108 20971520) itemoff 13458
>>>>>>> itemsize 53
>>>>>>> [ 1989.025125]         extent data disk bytenr 10697714982912 nr 32768
>>>>>>> [ 1989.025126]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025126]     item 101 key (484129 108 22151168) itemoff 13405
>>>>>>> itemsize 53
>>>>>>> [ 1989.025127]         extent data disk bytenr 10697718345728 nr 32768
>>>>>>> [ 1989.025128]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025129]     item 102 key (484129 108 23363584) itemoff 13352
>>>>>>> itemsize 53
>>>>>>> [ 1989.025129]         extent data disk bytenr 10697768124416 nr 65536
>>>>>>> [ 1989.025130]         extent data offset 0 nr 65536 ram 65536
>>>>>>> [ 1989.025131]     item 103 key (484129 108 23461888) itemoff 13299
>>>>>>> itemsize 53
>>>>>>> [ 1989.025132]         extent data disk bytenr 10697730711552 nr 32768
>>>>>>> [ 1989.025133]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025133]     item 104 key (484129 108 23527424) itemoff 13246
>>>>>>> itemsize 53
>>>>>>> [ 1989.025134]         extent data disk bytenr 10697164943360 nr 32768
>>>>>>> [ 1989.025135]         extent data offset 0 nr 32768 ram 32768
>>>>>>> [ 1989.025135]     item 105 key (484147 1 0) itemoff 13086 itemsize 160
>>>>>>> [ 1989.025137]         inode generation 45 size 886 mode 40755
>>>>>>> [ 1989.025138]     item 106 key (484147 72 4) itemoff 13078 itemsize 8
>>>>>>> [ 1989.025139]     item 107 key (484147 72 27) itemoff 13070 itemsize 8
>>>>>>> [ 1989.025140] BTRFS error (device sda2): block=574078976 write time
>>>>>>> tree block corruption detected
>>>>>>> [ 1989.053710] BTRFS: error (device sda2: state AL) in
>>>>>>> free_log_tree:3284: errno=-5 IO failure
>>>>>>> [ 1989.053717] BTRFS info (device sda2: state EAL): forced readonly
>>>>>>> [ 1989.055442] BTRFS warning (device sda2: state EAL): Skipping commit
>>>>>>> of aborted transaction.
>>>>>>> [ 1989.055444] BTRFS: error (device sda2: state EAL) in
>>>>>>> cleanup_transaction:1958: errno=-5 IO failure
>>>>>>>
>>>>>>> Sorry, I didn't notice your message in the other thread.
>>>>>>>
>>>>>>> Thanks in advance,
>>>>>>>
>>>>>>> David Arendt
>>>>>>>
>>>>> Hi,
>>>>>
>>>>> Yes, if you send me a debug patch, I can apply it. However it might take
>>>>> between 1 hour and 2 weeks until the next crash.
>>>> That would be very helpful.
>>>> So here's a debug patch (against 6.2-rc, but should apply to 6.1 as
>>>> well) attached.
>>>>
>>>> Thanks a lot!
>>>>
>>>>> Thanks in advance,
>>>>>
>>>>> David Arendt
>>>>>
>>> Hi,
>>>
>>> The patch did not apply to 6.1.3, so I tried using 6.2-rc2. I did my
>>> best to do much IO and different load as possible and was having this
>>> output:
>>>
>>> [ 1716.050035] BTRFS error (device sda2): corrupt leaf batch insert
>>> (count 6), slot 75, leaf before:
>>> [ 1716.050037] BTRFS info (device sda2): leaf 713932800 gen 5091428
>>> total ptrs 106 free space 11639 owner 18446744073709551610
>>> [ 1716.050040]  item 0 key (484119 1 0) itemoff 16123 itemsize 160
>>> [ 1716.050041]          inode generation 45 size 2238 mode 40700
>>> [ 1716.050042]  item 1 key (484119 12 484118) itemoff 16097 itemsize 26
>>> [ 1716.050044]  item 2 key (484119 72 15) itemoff 16089 itemsize 8
>>> [ 1716.050045]  item 3 key (484119 72 20) itemoff 16081 itemsize 8
>>> [ 1716.050046]  item 4 key (484119 72 25) itemoff 16073 itemsize 8
>>> [ 1716.050048]  item 5 key (484119 72 30) itemoff 16065 itemsize 8
>>> [ 1716.050049]  item 6 key (484119 72 32630) itemoff 16057 itemsize 8
>>> [ 1716.050050]  item 7 key (484119 72 40332) itemoff 16049 itemsize 8
>>> [ 1716.050051]  item 8 key (484119 72 40335) itemoff 16041 itemsize 8
>>> [ 1716.050052]  item 9 key (484119 72 93630) itemoff 16033 itemsize 8
>>> [ 1716.050053]  item 10 key (484119 72 101741) itemoff 16025 itemsize 8
>>> [ 1716.050054]  item 11 key (484119 72 131485) itemoff 16017 itemsize 8
>>> [ 1716.050056]  item 12 key (484119 72 183799) itemoff 16009 itemsize 8
>>> [ 1716.050057]  item 13 key (484119 72 183801) itemoff 16001 itemsize 8
>>> [ 1716.050058]  item 14 key (484119 72 203038) itemoff 15993 itemsize 8
>>> [ 1716.050059]  item 15 key (484119 72 254997) itemoff 15985 itemsize 8
>>> [ 1716.050060]  item 16 key (484119 72 255172) itemoff 15977 itemsize 8
>>> [ 1716.050062]  item 17 key (484119 72 255208) itemoff 15969 itemsize 8
>>> [ 1716.050063]  item 18 key (484119 72 256848) itemoff 15961 itemsize 8
>>> [ 1716.050064]  item 19 key (484119 72 264839) itemoff 15953 itemsize 8
>>> [ 1716.050065]  item 20 key (484119 72 266090) itemoff 15945 itemsize 8
>>> [ 1716.050066]  item 21 key (484119 72 266976) itemoff 15937 itemsize 8
>>> [ 1716.050067]  item 22 key (484119 72 267056) itemoff 15929 itemsize 8
>>> [ 1716.050068]  item 23 key (484119 72 302340) itemoff 15921 itemsize 8
>>> [ 1716.050070]  item 24 key (484119 72 513980) itemoff 15913 itemsize 8
>>> [ 1716.050071]  item 25 key (484119 72 848319) itemoff 15905 itemsize 8
>>> [ 1716.050072]  item 26 key (484119 72 848845) itemoff 15897 itemsize 8
>>> [ 1716.050073]  item 27 key (484119 72 938962) itemoff 15889 itemsize 8
>>> [ 1716.050074]  item 28 key (484119 72 1001565) itemoff 15881 itemsize 8
>>> [ 1716.050076]  item 29 key (484119 72 1217319) itemoff 15873 itemsize 8
>>> [ 1716.050077]  item 30 key (484119 72 1217321) itemoff 15865 itemsize 8
>>> [ 1716.050078]  item 31 key (484119 72 1268172) itemoff 15857 itemsize 8
>>> [ 1716.050079]  item 32 key (484119 72 1298657) itemoff 15849 itemsize 8
>>> [ 1716.050080]  item 33 key (484119 72 1299762) itemoff 15841 itemsize 8
>>> [ 1716.050081]  item 34 key (484119 72 1328486) itemoff 15833 itemsize 8
>>> [ 1716.050082]  item 35 key (484119 72 1329021) itemoff 15825 itemsize 8
>>> [ 1716.050083]  item 36 key (484119 72 1329328) itemoff 15817 itemsize 8
>>> [ 1716.050085]  item 37 key (484119 72 1329330) itemoff 15809 itemsize 8
>>> [ 1716.050086]  item 38 key (484119 72 1329857) itemoff 15801 itemsize 8
>>> [ 1716.050087]  item 39 key (484119 72 1330009) itemoff 15793 itemsize 8
>>> [ 1716.050089]  item 40 key (484119 72 1330037) itemoff 15785 itemsize 8
>>> [ 1716.050091]  item 41 key (484119 72 1330038) itemoff 15777 itemsize 8
>>> [ 1716.050092]  item 42 key (484119 72 1330041) itemoff 15769 itemsize 8
>>> [ 1716.050093]  item 43 key (484119 72 1330042) itemoff 15761 itemsize 8
>>> [ 1716.050094]  item 44 key (484119 72 1330046) itemoff 15753 itemsize 8
>>> [ 1716.050096]  item 45 key (484119 72 1330048) itemoff 15745 itemsize 8
>>> [ 1716.050097]  item 46 key (484119 72 1330054) itemoff 15737 itemsize 8
>>> [ 1716.050098]  item 47 key (484119 72 1330055) itemoff 15729 itemsize 8
>>> [ 1716.050099]  item 48 key (484119 72 1330059) itemoff 15721 itemsize 8
>>> [ 1716.050101]  item 49 key (484119 72 1330062) itemoff 15713 itemsize 8
>>> [ 1716.050102]  item 50 key (484119 72 1330066) itemoff 15705 itemsize 8
>>> [ 1716.050103]  item 51 key (484119 72 1330080) itemoff 15697 itemsize 8
>>> [ 1716.050104]  item 52 key (484119 72 1330081) itemoff 15689 itemsize 8
>>> [ 1716.050105]  item 53 key (484119 72 1330087) itemoff 15681 itemsize 8
>>> [ 1716.050107]  item 54 key (484119 72 1330088) itemoff 15673 itemsize 8
>>> [ 1716.050108]  item 55 key (484119 72 1330089) itemoff 15665 itemsize 8
>>> [ 1716.050109]  item 56 key (484119 72 1330090) itemoff 15657 itemsize 8
>>> [ 1716.050111]  item 57 key (484119 72 1330091) itemoff 15649 itemsize 8
>>> [ 1716.050112]  item 58 key (484119 72 1330092) itemoff 15641 itemsize 8
>>> [ 1716.050114]  item 59 key (484119 72 1330105) itemoff 15633 itemsize 8
>>> [ 1716.050115]  item 60 key (484119 72 1330107) itemoff 15625 itemsize 8
>>> [ 1716.050116]  item 61 key (484119 72 1330110) itemoff 15617 itemsize 8
>>> [ 1716.050117]  item 62 key (484119 72 1330112) itemoff 15609 itemsize 8
>>> [ 1716.050118]  item 63 key (484119 72 1330113) itemoff 15601 itemsize 8
>>> [ 1716.050119]  item 64 key (484119 72 1330115) itemoff 15593 itemsize 8
>>> [ 1716.050120]  item 65 key (484119 72 1330118) itemoff 15585 itemsize 8
>>> [ 1716.050122]  item 66 key (484119 72 1330120) itemoff 15577 itemsize 8
>>> [ 1716.050123]  item 67 key (484119 72 1330122) itemoff 15569 itemsize 8
>>> [ 1716.050124]  item 68 key (484119 72 1330124) itemoff 15561 itemsize 8
>>> [ 1716.050125]  item 69 key (484119 72 1330126) itemoff 15553 itemsize 8
>>> [ 1716.050126]  item 70 key (484119 72 1330129) itemoff 15545 itemsize 8
>>> [ 1716.050127]  item 71 key (484119 72 1330131) itemoff 15537 itemsize 8
>>> [ 1716.050128]  item 72 key (484119 72 1330136) itemoff 15529 itemsize 8
>>> [ 1716.050130]  item 73 key (484119 72 1330139) itemoff 15521 itemsize 8
>>> [ 1716.050131]  item 74 key (484119 72 1330141) itemoff 15513 itemsize 8
>>> [ 1716.050132]  item 75 key (484119 96 1330116) itemoff 15463 itemsize 50
>>> [ 1716.050133]  item 76 key (484119 96 1330128) itemoff 15405 itemsize 58
>>> [ 1716.050134]  item 77 key (484119 96 1330130) itemoff 15362 itemsize 43
>>> [ 1716.050136]  item 78 key (484129 1 0) itemoff 15202 itemsize 160
>>> [ 1716.050137]          inode generation 45 size 26214400 mode 100644
>>> [ 1716.050138]  item 79 key (484129 108 589824) itemoff 15149 itemsize 53
>>> [ 1716.050140]          extent data disk bytenr 10701807767552 nr 32768
>>> [ 1716.050141]          extent data offset 0 nr 32768 ram 32768
>>> [ 1716.050142]  item 80 key (484129 108 1310720) itemoff 15096 itemsize 53
>>> [ 1716.050144]          extent data disk bytenr 10701808283648 nr 32768
>>> [ 1716.050144]          extent data offset 0 nr 32768 ram 32768
>>> [ 1716.050145]  item 81 key (484129 108 1769472) itemoff 15043 itemsize 53
>>> [ 1716.050146]          extent data disk bytenr 10701828988928 nr 32768
>>> [ 1716.050147]          extent data offset 0 nr 32768 ram 32768
>>> [ 1716.050148]  item 82 key (484129 108 11763712) itemoff 14990 itemsize 53
>>> [ 1716.050150]          extent data disk bytenr 10701830090752 nr 32768
>>> [ 1716.050150]          extent data offset 0 nr 32768 ram 32768
>>> [ 1716.050151]  item 83 key (484129 108 13139968) itemoff 14937 itemsize 53
>>> [ 1716.050153]          extent data disk bytenr 10701269446656 nr 32768
>>> [ 1716.050153]          extent data offset 0 nr 32768 ram 32768
>>> [ 1716.050154]  item 84 key (484129 108 13467648) itemoff 14884 itemsize 53
>>> [ 1716.050156]          extent data disk bytenr 10701904338944 nr 32768
>>> [ 1716.050156]          extent data offset 0 nr 32768 ram 32768
>>> [ 1716.050157]  item 85 key (484129 108 13795328) itemoff 14831 itemsize 53
>>> [ 1716.050159]          extent data disk bytenr 10701904437248 nr 32768
>>> [ 1716.050159]          extent data offset 0 nr 32768 ram 32768
>>> [ 1716.050160]  item 86 key (484129 108 17694720) itemoff 14778 itemsize 53
>>> [ 1716.050161]          extent data disk bytenr 10701806407680 nr 32768
>>> [ 1716.050162]          extent data offset 0 nr 32768 ram 32768
>>> [ 1716.050163]  item 87 key (484129 108 19726336) itemoff 14725 itemsize 53
>>> [ 1716.050164]          extent data disk bytenr 10701806505984 nr 32768
>>> [ 1716.050165]          extent data offset 0 nr 32768 ram 32768
>>> [ 1716.050166]  item 88 key (484129 108 20185088) itemoff 14672 itemsize 53
>>> [ 1716.050167]          extent data disk bytenr 10701806538752 nr 32768
>>> [ 1716.050168]          extent data offset 0 nr 32768 ram 32768
>>> [ 1716.050168]  item 89 key (484129 108 21168128) itemoff 14619 itemsize 53
>>> [ 1716.050170]          extent data disk bytenr 10701807833088 nr 32768
>>> [ 1716.050170]          extent data offset 0 nr 32768 ram 32768
>>> [ 1716.050171]  item 90 key (484129 108 23396352) itemoff 14566 itemsize 53
>>> [ 1716.050172]          extent data disk bytenr 10701807865856 nr 32768
>>> [ 1716.050173]          extent data offset 0 nr 32768 ram 32768
>>> [ 1716.050174]  item 91 key (484147 1 0) itemoff 14406 itemsize 160
>>> [ 1716.050175]          inode generation 45 size 1096 mode 40755
>>> [ 1716.050176]  item 92 key (484147 12 484145) itemoff 14393 itemsize 13
>>> [ 1716.050177]  item 93 key (484147 72 4) itemoff 14385 itemsize 8
>>> [ 1716.050179]  item 94 key (484147 72 27) itemoff 14377 itemsize 8
>>> [ 1716.050180]  item 95 key (484147 72 35) itemoff 14369 itemsize 8
>>> [ 1716.050181]  item 96 key (484147 72 40) itemoff 14361 itemsize 8
>>> [ 1716.050183]  item 97 key (484147 72 45) itemoff 14353 itemsize 8
>>> [ 1716.050184]  item 98 key (484147 72 52) itemoff 14345 itemsize 8
>>> [ 1716.050185]  item 99 key (484147 72 61) itemoff 14337 itemsize 8
>>> [ 1716.050186]  item 100 key (484147 72 65) itemoff 14329 itemsize 8
>>> [ 1716.050187]  item 101 key (484147 72 88) itemoff 14321 itemsize 8
>>> [ 1716.050189]  item 102 key (484147 72 92) itemoff 14313 itemsize 8
>>> [ 1716.050190]  item 103 key (484147 72 350) itemoff 14305 itemsize 8
>>> [ 1716.050192]  item 104 key (484147 72 351) itemoff 14297 itemsize 8
>>> [ 1716.050193]  item 105 key (484147 72 352) itemoff 14289 itemsize 8
>>> [ 1716.050194] BTRFS error (device sda2): batch items:
>>> [ 1716.050195] BTRFS error (device sda2): item 0 index 1330094
>>> [ 1716.050197] BTRFS error (device sda2): item 1 index 1330116
>>> [ 1716.050198] BTRFS error (device sda2): item 2 index 1330127
>>> [ 1716.050199] BTRFS error (device sda2): item 3 index 1330128
>>> [ 1716.050200] BTRFS error (device sda2): item 4 index 1330130
>>> [ 1716.050201] BTRFS error (device sda2): item 5 index 1330132
>> Wow, that was fast!
>>
>>> However this time the filesystem didn't switch to readonly.
>> Yes, the debug patch changed that too. It's actually not a critical
>> situation to turn the fs to readonly.
>>
>> Ok, I see now what's going on. I will work on a fix for that plus a
>> few other things I noticed are not right.
>> I'll likely submit the changes to the list by monday or tuesday, and
>> let you know in case you want/can test them.
> Ok, here they are:
>
> https://lore.kernel.org/linux-btrfs/cover.1673361215.git.fdmanana@suse.com/
>
>> Thanks a lot for the testing and reporting.
>>
>>> Thanks in advance,
>>>
>>> David Arendt
>>>
Hi,

Many thanks.

I have applied the patches to 6.2-rc3 and tried to do everything to 
reproduce the problem so the problem seems to be fixed by the patches, 
but for sure only time will tell.

Bye,

David Arendt

