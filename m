Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B9F65F3D2
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 19:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjAESg3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 13:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjAESgA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 13:36:00 -0500
Received: from ns2.prnet.org (ns2.prnet.org [188.165.43.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F0DB1CFD3;
        Thu,  5 Jan 2023 10:35:56 -0800 (PST)
Received: from secure.prnet.org (mail.intern.prnet.org [192.168.1.206])
        by ns2.prnet.org (Postfix) with ESMTP id E87A0F4804;
        Thu,  5 Jan 2023 19:36:36 +0100 (CET)
Received: from [IPV6:2001:7e8:cf00:bc01:9441:d7ff:fede:982a] (unknown [IPv6:2001:7e8:cf00:bc01:9441:d7ff:fede:982a])
        by secure.prnet.org (Postfix) with ESMTPSA id 68DBC159FF3;
        Thu,  5 Jan 2023 19:35:55 +0100 (CET)
Message-ID: <9ab03294-57d0-3503-4da6-df920ab1d4a1@prnet.org>
Date:   Thu, 5 Jan 2023 19:35:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [regression] Bug 216851 - btrfs write time corrupting for log
 tree
Content-Language: en-US
From:   David Arendt <admin@prnet.org>
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
In-Reply-To: <3b5c7161-1a48-619b-b6b3-1868b7695c97@prnet.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/5/23 19:24, David Arendt wrote:
> On 1/5/23 18:04, Filipe Manana wrote:
>> On Thu, Jan 5, 2023 at 4:49 PM David Arendt <admin@prnet.org> wrote:
>>> On 1/5/23 11:22, Filipe Manana wrote:
>>>> On Wed, Jan 4, 2023 at 7:35 PM David Arendt <admin@prnet.org> wrote:
>>>>> On 1/4/23 20:29, Filipe Manana wrote:
>>>>>> On Wed, Jan 4, 2023 at 7:26 PM David Arendt <admin@prnet.org> wrote:
>>>>>>> On 1/3/23 00:38, Qu Wenruo wrote:
>>>>>>>> On 2023/1/2 23:40, David Sterba wrote:
>>>>>>>>> On Tue, Dec 27, 2022 at 03:01:34PM +0100, Thorsten Leemhuis 
>>>>>>>>> wrote:
>>>>>>>>>> Hi, this is your Linux kernel regression tracker speaking.
>>>>>>>>>>
>>>>>>>>>> I noticed a regression report in bugzilla.kernel.org. As many 
>>>>>>>>>> (most?)
>>>>>>>>>> kernel developer don't keep an eye on it, I decided to 
>>>>>>>>>> forward it by
>>>>>>>>>> mail. Quoting from 
>>>>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=216851 :
>>>>>>>>>>
>>>>>>>>>>> I am experiencing btrfs file system errors followed by a 
>>>>>>>>>>> switch to
>>>>>>>>>>> readony with kernel 6.1 and 6.1.1. It never happened with 
>>>>>>>>>>> kernel
>>>>>>>>>>> versions before.
>>>>>>>>>>>
>>>>>>>>>>> A btrfs scrub and a btrfs check --readonly returned 0 errors.
>>>>>>>>>>>
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS
>>>>>>>>>>> critical (device sda2): corrupt leaf: root=18446744073709551610
>>>>>>>>>>> block=203366612992 slot=73, bad key order, prev (484119 96 
>>>>>>>>>>> 1312873)
>>>>>>>>>>> current (484119 96 1312849)
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS 
>>>>>>>>>>> info
>>>>>>>>>>> (device sda2): leaf 203366612992 gen 5068802 total ptrs 105 
>>>>>>>>>>> free
>>>>>>>>>>> space 10820 owner 18446744073709551610
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 0
>>>>>>>>>>> key (484119 1 0) itemoff 16123 itemsize 160
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09inode generation 45 size 2250 mode 40700
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 1
>>>>>>>>>>> key (484119 12 484118) itemoff 16097 itemsize 26
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 2
>>>>>>>>>>> key (484119 72 15) itemoff 16089 itemsize 8
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 3
>>>>>>>>>>> key (484119 72 20) itemoff 16081 itemsize 8
>>>>>>>>>>> ...
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 82
>>>>>>>>>>> key (484119 96 1312873) itemoff 14665 itemsize 51
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 83
>>>>>>>>>>> key (484119 96 1312877) itemoff 14609 itemsize 56
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 84
>>>>>>>>>>> key (484128 1 0) itemoff 14449 itemsize 160
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09inode generation 45 size 98304 mode 100644
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 85
>>>>>>>>>>> key (484128 108 0) itemoff 14396 itemsize 53
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data disk bytenr 10674830381056 nr 65536
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data offset 0 nr 65536 ram 65536
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 86
>>>>>>>>>>> key (484129 1 0) itemoff 14236 itemsize 160
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09inode generation 45 size 26214400 mode 100644
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 87
>>>>>>>>>>> key (484129 108 589824) itemoff 14183 itemsize 53
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data disk bytenr 10665699962880 nr 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 88
>>>>>>>>>>> key (484129 108 2850816) itemoff 14130 itemsize 53
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data disk bytenr 10665848733696 nr 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 89
>>>>>>>>>>> key (484129 108 11042816) itemoff 14077 itemsize 53
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data disk bytenr 10660869349376 nr 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 90
>>>>>>>>>>> key (484129 108 13402112) itemoff 14024 itemsize 53
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data disk bytenr 10660207378432 nr 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 91
>>>>>>>>>>> key (484129 108 19628032) itemoff 13971 itemsize 53
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data disk bytenr 10665835618304 nr 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 92
>>>>>>>>>>> key (484129 108 21266432) itemoff 13918 itemsize 53
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data disk bytenr 10661222666240 nr 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 93
>>>>>>>>>>> key (484129 108 22740992) itemoff 13865 itemsize 53
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data disk bytenr 10665565814784 nr 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 94
>>>>>>>>>>> key (484129 108 23101440) itemoff 13812 itemsize 53
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data disk bytenr 10665836371968 nr 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 95
>>>>>>>>>>> key (484129 108 24084480) itemoff 13759 itemsize 53
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data disk bytenr 10665836404736 nr 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 96
>>>>>>>>>>> key (484129 108 24150016) itemoff 13706 itemsize 53
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data disk bytenr 10665849159680 nr 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 97
>>>>>>>>>>> key (484129 108 24313856) itemoff 13653 itemsize 53
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data disk bytenr 10665849192448 nr 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09extent data offset 0 nr 32768 ram 32768
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 98
>>>>>>>>>>> key (484147 1 0) itemoff 13493 itemsize 160
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
>>>>>>>>>>> \x09\x09inode generation 45 size 886 mode 40755
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 99
>>>>>>>>>>> key (484147 72 4) itemoff 13485 itemsize 8
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 100
>>>>>>>>>>> key (484147 72 27) itemoff 13477 itemsize 8
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 101
>>>>>>>>>>> key (484147 72 35) itemoff 13469 itemsize 8
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 102
>>>>>>>>>>> key (484147 72 40) itemoff 13461 itemsize 8
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 103
>>>>>>>>>>> key (484147 72 45) itemoff 13453 itemsize 8
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> \x09item 104
>>>>>>>>>>> key (484147 72 52) itemoff 13445 itemsize 8
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS 
>>>>>>>>>>> error
>>>>>>>>>>> (device sda2): block=203366612992 write time tree block 
>>>>>>>>>>> corruption
>>>>>>>>>>> detected
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> BTRFS: error
>>>>>>>>>>> (device sda2: state AL) in free_log_tree:3284: errno=-5 IO 
>>>>>>>>>>> failure
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS 
>>>>>>>>>>> info
>>>>>>>>>>> (device sda2: state EAL): forced readonly
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS
>>>>>>>>>>> warning (device sda2: state EAL): Skipping commit of aborted
>>>>>>>>>>> transaction.
>>>>>>>>>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - 
>>>>>>>>>>> BTRFS: error
>>>>>>>>>>> (device sda2: state EAL) in cleanup_transaction:1958: 
>>>>>>>>>>> errno=-5 IO
>>>>>>>>>>> failure
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> There are no SSD access errors in the kernel logs. Smart 
>>>>>>>>>>> data for
>>>>>>>>>>> the SSD is normal. I also did a 12 hour memtest to rule out 
>>>>>>>>>>> bad RAM.
>>>>>>>>>>>
>>>>>>>>>>> The filesystem consists of a single 480GB SATA SSD (Corsair 
>>>>>>>>>>> Neutron
>>>>>>>>>>> XTI). The problems occurs only on one machine.
>>>>>>>>>>>
>>>>>>>>>>> The error appears about every few days and seems to be 
>>>>>>>>>>> triggered by
>>>>>>>>>>> a cspecially under high cpu utilization combined with some 
>>>>>>>>>>> disk IO.
>>>>>>>>>>> CPU temperature never exceeds 60 degrees.
>>>>>>>>>> See the ticket for more details.
>>>>>>>>>>
>>>>>>>>>> For the record, the issue is apparently different from the 
>>>>>>>>>> 6.2-rc
>>>>>>>>>> regression currently discussed, as stated here:
>>>>>>>>>> https://lore.kernel.org/lkml/462e7bd3-d1f2-3718-fde9-77b418e9fd91@gmx.com/ 
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> BTW, let me use this mail to also add the report to the list 
>>>>>>>>>> of tracked
>>>>>>>>>> regressions to ensure it's doesn't fall through the cracks:
>>>>>>>>>>
>>>>>>>>>> #regzbot introduced: v6.0..v6.1
>>>>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=216851
>>>>>>>>>> #regzbot title: btrfs: write time corrupting for log tree in 6.1
>>>>>>>>>> #regzbot ignore-activity
>>>>>>>>> #regzbot fix: 'btrfs: fix false alert on bad tree level check'
>>>>>>>> Oh no, this is a different one, this one is not level mismatch.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>> Hi,
>>>>>>>
>>>>>>> Here the logging from another crash, this time on kernel 6.1.3, 
>>>>>>> about 1
>>>>>>> hour after boot. Again during high CPU usage combined with lots 
>>>>>>> of io.
>>>>>>>
>>>>>>> [ 1989.025015] BTRFS critical (device sda2): corrupt leaf:
>>>>>>> root=18446744073709551610 block=574078976 slot=70, bad key 
>>>>>>> order, prev
>>>>>>> (484119 96 1328571) current (484119 96 1328553)
>>>>>>> [ 1989.025022] BTRFS info (device sda2): leaf 574078976 gen 5089233
>>>>>>> total ptrs 108 free space 10370 owner 18446744073709551610
>>>>>>> [ 1989.025024]  item 0 key (484119 1 0) itemoff 16123 itemsize 160
>>>>>>> [ 1989.025025]          inode generation 45 size 2198 mode 40700
>>>>>>> [ 1989.025026]  item 1 key (484119 12 484118) itemoff 16097 
>>>>>>> itemsize 26
>>>>>>> [ 1989.025027]  item 2 key (484119 72 15) itemoff 16089 itemsize 8
>>>>>>> [ 1989.025027]  item 3 key (484119 72 20) itemoff 16081 itemsize 8
>>>>>>>
>>>>>>> ...
>>>>>> Can you please paste the full message?
>>>>>> If an error/warning, don't just paste a section of the message, 
>>>>>> paste
>>>>>> the full thing.
>>>>>>
>>>>>> I've previously commented on that in the other thread:
>>>>>>
>>>>>> https://lore.kernel.org/linux-btrfs/CAL3q7H6RbPsa9Ff9or6+0d4R5vzVcR=RPxHA0=3A_KeSmf7hcQ@mail.gmail.com/ 
>>>>>>
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>>
>>>>>>> [ 1989.025135]  item 105 key (484147 1 0) itemoff 13086 itemsize 
>>>>>>> 160
>>>>>>> [ 1989.025137]          inode generation 45 size 886 mode 40755
>>>>>>> [ 1989.025138]  item 106 key (484147 72 4) itemoff 13078 itemsize 8
>>>>>>> [ 1989.025139]  item 107 key (484147 72 27) itemoff 13070 
>>>>>>> itemsize 8
>>>>>>> [ 1989.025140] BTRFS error (device sda2): block=574078976 write 
>>>>>>> time
>>>>>>> tree block corruption detected
>>>>>>> [ 1989.053710] BTRFS: error (device sda2: state AL) in
>>>>>>> free_log_tree:3284: errno=-5 IO failure
>>>>>>> [ 1989.053717] BTRFS info (device sda2: state EAL): forced readonly
>>>>>>> [ 1989.055442] BTRFS warning (device sda2: state EAL): Skipping 
>>>>>>> commit
>>>>>>> of aborted transaction.
>>>>>>> [ 1989.055444] BTRFS: error (device sda2: state EAL) in
>>>>>>> cleanup_transaction:1958: errno=-5 IO failure
>>>>>>>
>>>>>>> Thanks in advance,
>>>>>>>
>>>>>>> David Arendt
>>>>>>>
>>>>> Hi,
>>>>>
>>>>> here is the full message:
>>>> Ok, this is intriguing. Same set of keys is added twice to a leaf.
>>>>
>>>> Are you able to apply a debug patch which adds extra logging when the
>>>> issue happens?
>>>> That would be the fastest way to figure where and why the issue is 
>>>> happening.
>>>>
>>>> Thanks.
>>>>
>>>>
>>>>> [ 1989.025015] BTRFS critical (device sda2): corrupt leaf:
>>>>> root=18446744073709551610 block=574078976 slot=70, bad key order, 
>>>>> prev
>>>>> (484119 96 1328571) current (484119 96 1328553)
>>>>> [ 1989.025022] BTRFS info (device sda2): leaf 574078976 gen 5089233
>>>>> total ptrs 108 free space 10370 owner 18446744073709551610
>>>>> [ 1989.025024]     item 0 key (484119 1 0) itemoff 16123 itemsize 160
>>>>> [ 1989.025025]         inode generation 45 size 2198 mode 40700
>>>>> [ 1989.025026]     item 1 key (484119 12 484118) itemoff 16097 
>>>>> itemsize 26
>>>>> [ 1989.025027]     item 2 key (484119 72 15) itemoff 16089 itemsize 8
>>>>> [ 1989.025027]     item 3 key (484119 72 20) itemoff 16081 itemsize 8
>>>>> [ 1989.025028]     item 4 key (484119 72 25) itemoff 16073 itemsize 8
>>>>> [ 1989.025029]     item 5 key (484119 72 30) itemoff 16065 itemsize 8
>>>>> [ 1989.025029]     item 6 key (484119 72 32630) itemoff 16057 
>>>>> itemsize 8
>>>>> [ 1989.025030]     item 7 key (484119 72 40332) itemoff 16049 
>>>>> itemsize 8
>>>>> [ 1989.025031]     item 8 key (484119 72 40335) itemoff 16041 
>>>>> itemsize 8
>>>>> [ 1989.025031]     item 9 key (484119 72 93630) itemoff 16033 
>>>>> itemsize 8
>>>>> [ 1989.025032]     item 10 key (484119 72 101741) itemoff 16025 
>>>>> itemsize 8
>>>>> [ 1989.025033]     item 11 key (484119 72 131485) itemoff 16017 
>>>>> itemsize 8
>>>>> [ 1989.025034]     item 12 key (484119 72 183799) itemoff 16009 
>>>>> itemsize 8
>>>>> [ 1989.025034]     item 13 key (484119 72 183801) itemoff 16001 
>>>>> itemsize 8
>>>>> [ 1989.025035]     item 14 key (484119 72 203038) itemoff 15993 
>>>>> itemsize 8
>>>>> [ 1989.025036]     item 15 key (484119 72 254997) itemoff 15985 
>>>>> itemsize 8
>>>>> [ 1989.025036]     item 16 key (484119 72 255172) itemoff 15977 
>>>>> itemsize 8
>>>>> [ 1989.025037]     item 17 key (484119 72 255208) itemoff 15969 
>>>>> itemsize 8
>>>>> [ 1989.025037]     item 18 key (484119 72 256848) itemoff 15961 
>>>>> itemsize 8
>>>>> [ 1989.025038]     item 19 key (484119 72 264839) itemoff 15953 
>>>>> itemsize 8
>>>>> [ 1989.025039]     item 20 key (484119 72 266090) itemoff 15945 
>>>>> itemsize 8
>>>>> [ 1989.025039]     item 21 key (484119 72 266976) itemoff 15937 
>>>>> itemsize 8
>>>>> [ 1989.025040]     item 22 key (484119 72 267056) itemoff 15929 
>>>>> itemsize 8
>>>>> [ 1989.025040]     item 23 key (484119 72 302340) itemoff 15921 
>>>>> itemsize 8
>>>>> [ 1989.025041]     item 24 key (484119 72 513980) itemoff 15913 
>>>>> itemsize 8
>>>>> [ 1989.025042]     item 25 key (484119 72 848319) itemoff 15905 
>>>>> itemsize 8
>>>>> [ 1989.025042]     item 26 key (484119 72 848845) itemoff 15897 
>>>>> itemsize 8
>>>>> [ 1989.025043]     item 27 key (484119 72 938962) itemoff 15889 
>>>>> itemsize 8
>>>>> [ 1989.025044]     item 28 key (484119 72 1001565) itemoff 15881 
>>>>> itemsize 8
>>>>> [ 1989.025044]     item 29 key (484119 72 1217319) itemoff 15873 
>>>>> itemsize 8
>>>>> [ 1989.025045]     item 30 key (484119 72 1217321) itemoff 15865 
>>>>> itemsize 8
>>>>> [ 1989.025046]     item 31 key (484119 72 1268172) itemoff 15857 
>>>>> itemsize 8
>>>>> [ 1989.025046]     item 32 key (484119 72 1298657) itemoff 15849 
>>>>> itemsize 8
>>>>> [ 1989.025047]     item 33 key (484119 72 1299762) itemoff 15841 
>>>>> itemsize 8
>>>>> [ 1989.025048]     item 34 key (484119 72 1322969) itemoff 15833 
>>>>> itemsize 8
>>>>> [ 1989.025048]     item 35 key (484119 72 1326818) itemoff 15825 
>>>>> itemsize 8
>>>>> [ 1989.025049]     item 36 key (484119 72 1327157) itemoff 15817 
>>>>> itemsize 8
>>>>> [ 1989.025050]     item 37 key (484119 72 1327930) itemoff 15809 
>>>>> itemsize 8
>>>>> [ 1989.025050]     item 38 key (484119 72 1327934) itemoff 15801 
>>>>> itemsize 8
>>>>> [ 1989.025051]     item 39 key (484119 72 1328324) itemoff 15793 
>>>>> itemsize 8
>>>>> [ 1989.025052]     item 40 key (484119 72 1328423) itemoff 15785 
>>>>> itemsize 8
>>>>> [ 1989.025052]     item 41 key (484119 72 1328486) itemoff 15777 
>>>>> itemsize 8
>>>>> [ 1989.025053]     item 42 key (484119 72 1328506) itemoff 15769 
>>>>> itemsize 8
>>>>> [ 1989.025054]     item 43 key (484119 72 1328507) itemoff 15761 
>>>>> itemsize 8
>>>>> [ 1989.025054]     item 44 key (484119 72 1328509) itemoff 15753 
>>>>> itemsize 8
>>>>> [ 1989.025055]     item 45 key (484119 72 1328510) itemoff 15745 
>>>>> itemsize 8
>>>>> [ 1989.025055]     item 46 key (484119 72 1328511) itemoff 15737 
>>>>> itemsize 8
>>>>> [ 1989.025056]     item 47 key (484119 72 1328514) itemoff 15729 
>>>>> itemsize 8
>>>>> [ 1989.025057]     item 48 key (484119 72 1328515) itemoff 15721 
>>>>> itemsize 8
>>>>> [ 1989.025057]     item 49 key (484119 72 1328518) itemoff 15713 
>>>>> itemsize 8
>>>>> [ 1989.025058]     item 50 key (484119 72 1328519) itemoff 15705 
>>>>> itemsize 8
>>>>> [ 1989.025059]     item 51 key (484119 72 1328520) itemoff 15697 
>>>>> itemsize 8
>>>>> [ 1989.025059]     item 52 key (484119 72 1328521) itemoff 15689 
>>>>> itemsize 8
>>>>> [ 1989.025060]     item 53 key (484119 72 1328523) itemoff 15681 
>>>>> itemsize 8
>>>>> [ 1989.025060]     item 54 key (484119 72 1328525) itemoff 15673 
>>>>> itemsize 8
>>>>> [ 1989.025061]     item 55 key (484119 72 1328528) itemoff 15665 
>>>>> itemsize 8
>>>>> [ 1989.025062]     item 56 key (484119 72 1328529) itemoff 15657 
>>>>> itemsize 8
>>>>> [ 1989.025062]     item 57 key (484119 72 1328532) itemoff 15649 
>>>>> itemsize 8
>>>>> [ 1989.025063]     item 58 key (484119 72 1328561) itemoff 15641 
>>>>> itemsize 8
>>>>> [ 1989.025063]     item 59 key (484119 72 1328564) itemoff 15633 
>>>>> itemsize 8
>>>>> [ 1989.025064]     item 60 key (484119 72 1328566) itemoff 15625 
>>>>> itemsize 8
>>>>> [ 1989.025065]     item 61 key (484119 72 1328570) itemoff 15617 
>>>>> itemsize 8
>>>>> [ 1989.025065]     item 62 key (484119 96 1328553) itemoff 15566 
>>>>> itemsize 51
>>>>> [ 1989.025066]     item 63 key (484119 96 1328555) itemoff 15523 
>>>>> itemsize 43
>>>>> [ 1989.025067]     item 64 key (484119 96 1328559) itemoff 15489 
>>>>> itemsize 34
>>>>> [ 1989.025067]     item 65 key (484119 96 1328563) itemoff 15441 
>>>>> itemsize 48
>>>>> [ 1989.025068]     item 66 key (484119 96 1328565) itemoff 15388 
>>>>> itemsize 53
>>>>> [ 1989.025069]     item 67 key (484119 96 1328568) itemoff 15341 
>>>>> itemsize 47
>>>>> [ 1989.025069]     item 68 key (484119 96 1328569) itemoff 15292 
>>>>> itemsize 49
>>>>> [ 1989.025070]     item 69 key (484119 96 1328571) itemoff 15254 
>>>>> itemsize 38
>>>>> [ 1989.025071]     item 70 key (484119 96 1328553) itemoff 15203 
>>>>> itemsize 51
>>>>> [ 1989.025071]     item 71 key (484119 96 1328555) itemoff 15160 
>>>>> itemsize 43
>>>>> [ 1989.025072]     item 72 key (484119 96 1328559) itemoff 15126 
>>>>> itemsize 34
>>>>> [ 1989.025073]     item 73 key (484119 96 1328563) itemoff 15078 
>>>>> itemsize 48
>>>>> [ 1989.025073]     item 74 key (484119 96 1328565) itemoff 15025 
>>>>> itemsize 53
>>>>> [ 1989.025074]     item 75 key (484119 96 1328568) itemoff 14978 
>>>>> itemsize 47
>>>>> [ 1989.025074]     item 76 key (484119 96 1328569) itemoff 14929 
>>>>> itemsize 49
>>>>> [ 1989.025076]     item 77 key (484119 96 1328571) itemoff 14891 
>>>>> itemsize 38
>>>>> [ 1989.025077]     item 78 key (484128 1 0) itemoff 14731 itemsize 
>>>>> 160
>>>>> [ 1989.025078]         inode generation 45 size 98304 mode 100644
>>>>> [ 1989.025079]     item 79 key (484128 108 0) itemoff 14678 
>>>>> itemsize 53
>>>>> [ 1989.025080]         extent data disk bytenr 10698843275264 nr 
>>>>> 65536
>>>>> [ 1989.025081]         extent data offset 0 nr 65536 ram 65536
>>>>> [ 1989.025081]     item 80 key (484129 1 0) itemoff 14518 itemsize 
>>>>> 160
>>>>> [ 1989.025082]         inode generation 45 size 26214400 mode 100644
>>>>> [ 1989.025083]     item 81 key (484129 108 589824) itemoff 14465 
>>>>> itemsize 53
>>>>> [ 1989.025084]         extent data disk bytenr 10697670373376 nr 
>>>>> 32768
>>>>> [ 1989.025085]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025086]     item 82 key (484129 108 1310720) itemoff 14412
>>>>> itemsize 53
>>>>> [ 1989.025087]         extent data disk bytenr 10697126309888 nr 
>>>>> 32768
>>>>> [ 1989.025087]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025088]     item 83 key (484129 108 3670016) itemoff 14359
>>>>> itemsize 53
>>>>> [ 1989.025089]         extent data disk bytenr 10697672445952 nr 
>>>>> 32768
>>>>> [ 1989.025090]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025090]     item 84 key (484129 108 10944512) itemoff 14306
>>>>> itemsize 53
>>>>> [ 1989.025091]         extent data disk bytenr 10697673764864 nr 
>>>>> 65536
>>>>> [ 1989.025092]         extent data offset 0 nr 65536 ram 65536
>>>>> [ 1989.025093]     item 85 key (484129 108 11304960) itemoff 14253
>>>>> itemsize 53
>>>>> [ 1989.025094]         extent data disk bytenr 10697154973696 nr 
>>>>> 32768
>>>>> [ 1989.025095]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025095]     item 86 key (484129 108 11370496) itemoff 14200
>>>>> itemsize 53
>>>>> [ 1989.025096]         extent data disk bytenr 10697160564736 nr 
>>>>> 32768
>>>>> [ 1989.025097]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025098]     item 87 key (484129 108 11730944) itemoff 14147
>>>>> itemsize 53
>>>>> [ 1989.025099]         extent data disk bytenr 10697672478720 nr 
>>>>> 32768
>>>>> [ 1989.025100]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025100]     item 88 key (484129 108 12156928) itemoff 14094
>>>>> itemsize 53
>>>>> [ 1989.025102]         extent data disk bytenr 10697673052160 nr 
>>>>> 32768
>>>>> [ 1989.025102]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025103]     item 89 key (484129 108 12353536) itemoff 14041
>>>>> itemsize 53
>>>>> [ 1989.025104]         extent data disk bytenr 10697160597504 nr 
>>>>> 32768
>>>>> [ 1989.025105]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025106]     item 90 key (484129 108 12582912) itemoff 13988
>>>>> itemsize 53
>>>>> [ 1989.025107]         extent data disk bytenr 10697677389824 nr 
>>>>> 32768
>>>>> [ 1989.025108]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025108]     item 91 key (484129 108 13139968) itemoff 13935
>>>>> itemsize 53
>>>>> [ 1989.025110]         extent data disk bytenr 10697681383424 nr 
>>>>> 65536
>>>>> [ 1989.025110]         extent data offset 0 nr 65536 ram 65536
>>>>> [ 1989.025111]     item 92 key (484129 108 13467648) itemoff 13882
>>>>> itemsize 53
>>>>> [ 1989.025111]         extent data disk bytenr 10697743683584 nr 
>>>>> 65536
>>>>> [ 1989.025112]         extent data offset 0 nr 65536 ram 65536
>>>>> [ 1989.025112]     item 93 key (484129 108 13697024) itemoff 13829
>>>>> itemsize 53
>>>>> [ 1989.025113]         extent data disk bytenr 10697160630272 nr 
>>>>> 32768
>>>>> [ 1989.025113]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025114]     item 94 key (484129 108 13795328) itemoff 13776
>>>>> itemsize 53
>>>>> [ 1989.025114]         extent data disk bytenr 10697160663040 nr 
>>>>> 32768
>>>>> [ 1989.025115]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025115]     item 95 key (484129 108 14090240) itemoff 13723
>>>>> itemsize 53
>>>>> [ 1989.025116]         extent data disk bytenr 10697160695808 nr 
>>>>> 32768
>>>>> [ 1989.025116]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025117]     item 96 key (484129 108 14548992) itemoff 13670
>>>>> itemsize 53
>>>>> [ 1989.025117]         extent data disk bytenr 10697677422592 nr 
>>>>> 32768
>>>>> [ 1989.025118]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025118]     item 97 key (484129 108 17694720) itemoff 13617
>>>>> itemsize 53
>>>>> [ 1989.025119]         extent data disk bytenr 10697686274048 nr 
>>>>> 32768
>>>>> [ 1989.025119]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025120]     item 98 key (484129 108 19726336) itemoff 13564
>>>>> itemsize 53
>>>>> [ 1989.025121]         extent data disk bytenr 10697688305664 nr 
>>>>> 32768
>>>>> [ 1989.025121]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025122]     item 99 key (484129 108 20185088) itemoff 13511
>>>>> itemsize 53
>>>>> [ 1989.025122]         extent data disk bytenr 10697690374144 nr 
>>>>> 32768
>>>>> [ 1989.025123]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025124]     item 100 key (484129 108 20971520) itemoff 13458
>>>>> itemsize 53
>>>>> [ 1989.025125]         extent data disk bytenr 10697714982912 nr 
>>>>> 32768
>>>>> [ 1989.025126]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025126]     item 101 key (484129 108 22151168) itemoff 13405
>>>>> itemsize 53
>>>>> [ 1989.025127]         extent data disk bytenr 10697718345728 nr 
>>>>> 32768
>>>>> [ 1989.025128]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025129]     item 102 key (484129 108 23363584) itemoff 13352
>>>>> itemsize 53
>>>>> [ 1989.025129]         extent data disk bytenr 10697768124416 nr 
>>>>> 65536
>>>>> [ 1989.025130]         extent data offset 0 nr 65536 ram 65536
>>>>> [ 1989.025131]     item 103 key (484129 108 23461888) itemoff 13299
>>>>> itemsize 53
>>>>> [ 1989.025132]         extent data disk bytenr 10697730711552 nr 
>>>>> 32768
>>>>> [ 1989.025133]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025133]     item 104 key (484129 108 23527424) itemoff 13246
>>>>> itemsize 53
>>>>> [ 1989.025134]         extent data disk bytenr 10697164943360 nr 
>>>>> 32768
>>>>> [ 1989.025135]         extent data offset 0 nr 32768 ram 32768
>>>>> [ 1989.025135]     item 105 key (484147 1 0) itemoff 13086 
>>>>> itemsize 160
>>>>> [ 1989.025137]         inode generation 45 size 886 mode 40755
>>>>> [ 1989.025138]     item 106 key (484147 72 4) itemoff 13078 
>>>>> itemsize 8
>>>>> [ 1989.025139]     item 107 key (484147 72 27) itemoff 13070 
>>>>> itemsize 8
>>>>> [ 1989.025140] BTRFS error (device sda2): block=574078976 write time
>>>>> tree block corruption detected
>>>>> [ 1989.053710] BTRFS: error (device sda2: state AL) in
>>>>> free_log_tree:3284: errno=-5 IO failure
>>>>> [ 1989.053717] BTRFS info (device sda2: state EAL): forced readonly
>>>>> [ 1989.055442] BTRFS warning (device sda2: state EAL): Skipping 
>>>>> commit
>>>>> of aborted transaction.
>>>>> [ 1989.055444] BTRFS: error (device sda2: state EAL) in
>>>>> cleanup_transaction:1958: errno=-5 IO failure
>>>>>
>>>>> Sorry, I didn't notice your message in the other thread.
>>>>>
>>>>> Thanks in advance,
>>>>>
>>>>> David Arendt
>>>>>
>>> Hi,
>>>
>>> Yes, if you send me a debug patch, I can apply it. However it might 
>>> take
>>> between 1 hour and 2 weeks until the next crash.
>> That would be very helpful.
>> So here's a debug patch (against 6.2-rc, but should apply to 6.1 as
>> well) attached.
>>
>> Thanks a lot!
>>
>>> Thanks in advance,
>>>
>>> David Arendt
>>>
> Hi,
>
> The patch did not apply to 6.1.3, so I tried using 6.2-rc2. I did my 
> best to do much IO and different load as possible and was having this 
> output:
>
> [ 1716.050035] BTRFS error (device sda2): corrupt leaf batch insert 
> (count 6), slot 75, leaf before:
> [ 1716.050037] BTRFS info (device sda2): leaf 713932800 gen 5091428 
> total ptrs 106 free space 11639 owner 18446744073709551610
> [ 1716.050040]  item 0 key (484119 1 0) itemoff 16123 itemsize 160
> [ 1716.050041]          inode generation 45 size 2238 mode 40700
> [ 1716.050042]  item 1 key (484119 12 484118) itemoff 16097 itemsize 26
> [ 1716.050044]  item 2 key (484119 72 15) itemoff 16089 itemsize 8
> [ 1716.050045]  item 3 key (484119 72 20) itemoff 16081 itemsize 8
> [ 1716.050046]  item 4 key (484119 72 25) itemoff 16073 itemsize 8
> [ 1716.050048]  item 5 key (484119 72 30) itemoff 16065 itemsize 8
> [ 1716.050049]  item 6 key (484119 72 32630) itemoff 16057 itemsize 8
> [ 1716.050050]  item 7 key (484119 72 40332) itemoff 16049 itemsize 8
> [ 1716.050051]  item 8 key (484119 72 40335) itemoff 16041 itemsize 8
> [ 1716.050052]  item 9 key (484119 72 93630) itemoff 16033 itemsize 8
> [ 1716.050053]  item 10 key (484119 72 101741) itemoff 16025 itemsize 8
> [ 1716.050054]  item 11 key (484119 72 131485) itemoff 16017 itemsize 8
> [ 1716.050056]  item 12 key (484119 72 183799) itemoff 16009 itemsize 8
> [ 1716.050057]  item 13 key (484119 72 183801) itemoff 16001 itemsize 8
> [ 1716.050058]  item 14 key (484119 72 203038) itemoff 15993 itemsize 8
> [ 1716.050059]  item 15 key (484119 72 254997) itemoff 15985 itemsize 8
> [ 1716.050060]  item 16 key (484119 72 255172) itemoff 15977 itemsize 8
> [ 1716.050062]  item 17 key (484119 72 255208) itemoff 15969 itemsize 8
> [ 1716.050063]  item 18 key (484119 72 256848) itemoff 15961 itemsize 8
> [ 1716.050064]  item 19 key (484119 72 264839) itemoff 15953 itemsize 8
> [ 1716.050065]  item 20 key (484119 72 266090) itemoff 15945 itemsize 8
> [ 1716.050066]  item 21 key (484119 72 266976) itemoff 15937 itemsize 8
> [ 1716.050067]  item 22 key (484119 72 267056) itemoff 15929 itemsize 8
> [ 1716.050068]  item 23 key (484119 72 302340) itemoff 15921 itemsize 8
> [ 1716.050070]  item 24 key (484119 72 513980) itemoff 15913 itemsize 8
> [ 1716.050071]  item 25 key (484119 72 848319) itemoff 15905 itemsize 8
> [ 1716.050072]  item 26 key (484119 72 848845) itemoff 15897 itemsize 8
> [ 1716.050073]  item 27 key (484119 72 938962) itemoff 15889 itemsize 8
> [ 1716.050074]  item 28 key (484119 72 1001565) itemoff 15881 itemsize 8
> [ 1716.050076]  item 29 key (484119 72 1217319) itemoff 15873 itemsize 8
> [ 1716.050077]  item 30 key (484119 72 1217321) itemoff 15865 itemsize 8
> [ 1716.050078]  item 31 key (484119 72 1268172) itemoff 15857 itemsize 8
> [ 1716.050079]  item 32 key (484119 72 1298657) itemoff 15849 itemsize 8
> [ 1716.050080]  item 33 key (484119 72 1299762) itemoff 15841 itemsize 8
> [ 1716.050081]  item 34 key (484119 72 1328486) itemoff 15833 itemsize 8
> [ 1716.050082]  item 35 key (484119 72 1329021) itemoff 15825 itemsize 8
> [ 1716.050083]  item 36 key (484119 72 1329328) itemoff 15817 itemsize 8
> [ 1716.050085]  item 37 key (484119 72 1329330) itemoff 15809 itemsize 8
> [ 1716.050086]  item 38 key (484119 72 1329857) itemoff 15801 itemsize 8
> [ 1716.050087]  item 39 key (484119 72 1330009) itemoff 15793 itemsize 8
> [ 1716.050089]  item 40 key (484119 72 1330037) itemoff 15785 itemsize 8
> [ 1716.050091]  item 41 key (484119 72 1330038) itemoff 15777 itemsize 8
> [ 1716.050092]  item 42 key (484119 72 1330041) itemoff 15769 itemsize 8
> [ 1716.050093]  item 43 key (484119 72 1330042) itemoff 15761 itemsize 8
> [ 1716.050094]  item 44 key (484119 72 1330046) itemoff 15753 itemsize 8
> [ 1716.050096]  item 45 key (484119 72 1330048) itemoff 15745 itemsize 8
> [ 1716.050097]  item 46 key (484119 72 1330054) itemoff 15737 itemsize 8
> [ 1716.050098]  item 47 key (484119 72 1330055) itemoff 15729 itemsize 8
> [ 1716.050099]  item 48 key (484119 72 1330059) itemoff 15721 itemsize 8
> [ 1716.050101]  item 49 key (484119 72 1330062) itemoff 15713 itemsize 8
> [ 1716.050102]  item 50 key (484119 72 1330066) itemoff 15705 itemsize 8
> [ 1716.050103]  item 51 key (484119 72 1330080) itemoff 15697 itemsize 8
> [ 1716.050104]  item 52 key (484119 72 1330081) itemoff 15689 itemsize 8
> [ 1716.050105]  item 53 key (484119 72 1330087) itemoff 15681 itemsize 8
> [ 1716.050107]  item 54 key (484119 72 1330088) itemoff 15673 itemsize 8
> [ 1716.050108]  item 55 key (484119 72 1330089) itemoff 15665 itemsize 8
> [ 1716.050109]  item 56 key (484119 72 1330090) itemoff 15657 itemsize 8
> [ 1716.050111]  item 57 key (484119 72 1330091) itemoff 15649 itemsize 8
> [ 1716.050112]  item 58 key (484119 72 1330092) itemoff 15641 itemsize 8
> [ 1716.050114]  item 59 key (484119 72 1330105) itemoff 15633 itemsize 8
> [ 1716.050115]  item 60 key (484119 72 1330107) itemoff 15625 itemsize 8
> [ 1716.050116]  item 61 key (484119 72 1330110) itemoff 15617 itemsize 8
> [ 1716.050117]  item 62 key (484119 72 1330112) itemoff 15609 itemsize 8
> [ 1716.050118]  item 63 key (484119 72 1330113) itemoff 15601 itemsize 8
> [ 1716.050119]  item 64 key (484119 72 1330115) itemoff 15593 itemsize 8
> [ 1716.050120]  item 65 key (484119 72 1330118) itemoff 15585 itemsize 8
> [ 1716.050122]  item 66 key (484119 72 1330120) itemoff 15577 itemsize 8
> [ 1716.050123]  item 67 key (484119 72 1330122) itemoff 15569 itemsize 8
> [ 1716.050124]  item 68 key (484119 72 1330124) itemoff 15561 itemsize 8
> [ 1716.050125]  item 69 key (484119 72 1330126) itemoff 15553 itemsize 8
> [ 1716.050126]  item 70 key (484119 72 1330129) itemoff 15545 itemsize 8
> [ 1716.050127]  item 71 key (484119 72 1330131) itemoff 15537 itemsize 8
> [ 1716.050128]  item 72 key (484119 72 1330136) itemoff 15529 itemsize 8
> [ 1716.050130]  item 73 key (484119 72 1330139) itemoff 15521 itemsize 8
> [ 1716.050131]  item 74 key (484119 72 1330141) itemoff 15513 itemsize 8
> [ 1716.050132]  item 75 key (484119 96 1330116) itemoff 15463 itemsize 50
> [ 1716.050133]  item 76 key (484119 96 1330128) itemoff 15405 itemsize 58
> [ 1716.050134]  item 77 key (484119 96 1330130) itemoff 15362 itemsize 43
> [ 1716.050136]  item 78 key (484129 1 0) itemoff 15202 itemsize 160
> [ 1716.050137]          inode generation 45 size 26214400 mode 100644
> [ 1716.050138]  item 79 key (484129 108 589824) itemoff 15149 itemsize 53
> [ 1716.050140]          extent data disk bytenr 10701807767552 nr 32768
> [ 1716.050141]          extent data offset 0 nr 32768 ram 32768
> [ 1716.050142]  item 80 key (484129 108 1310720) itemoff 15096 
> itemsize 53
> [ 1716.050144]          extent data disk bytenr 10701808283648 nr 32768
> [ 1716.050144]          extent data offset 0 nr 32768 ram 32768
> [ 1716.050145]  item 81 key (484129 108 1769472) itemoff 15043 
> itemsize 53
> [ 1716.050146]          extent data disk bytenr 10701828988928 nr 32768
> [ 1716.050147]          extent data offset 0 nr 32768 ram 32768
> [ 1716.050148]  item 82 key (484129 108 11763712) itemoff 14990 
> itemsize 53
> [ 1716.050150]          extent data disk bytenr 10701830090752 nr 32768
> [ 1716.050150]          extent data offset 0 nr 32768 ram 32768
> [ 1716.050151]  item 83 key (484129 108 13139968) itemoff 14937 
> itemsize 53
> [ 1716.050153]          extent data disk bytenr 10701269446656 nr 32768
> [ 1716.050153]          extent data offset 0 nr 32768 ram 32768
> [ 1716.050154]  item 84 key (484129 108 13467648) itemoff 14884 
> itemsize 53
> [ 1716.050156]          extent data disk bytenr 10701904338944 nr 32768
> [ 1716.050156]          extent data offset 0 nr 32768 ram 32768
> [ 1716.050157]  item 85 key (484129 108 13795328) itemoff 14831 
> itemsize 53
> [ 1716.050159]          extent data disk bytenr 10701904437248 nr 32768
> [ 1716.050159]          extent data offset 0 nr 32768 ram 32768
> [ 1716.050160]  item 86 key (484129 108 17694720) itemoff 14778 
> itemsize 53
> [ 1716.050161]          extent data disk bytenr 10701806407680 nr 32768
> [ 1716.050162]          extent data offset 0 nr 32768 ram 32768
> [ 1716.050163]  item 87 key (484129 108 19726336) itemoff 14725 
> itemsize 53
> [ 1716.050164]          extent data disk bytenr 10701806505984 nr 32768
> [ 1716.050165]          extent data offset 0 nr 32768 ram 32768
> [ 1716.050166]  item 88 key (484129 108 20185088) itemoff 14672 
> itemsize 53
> [ 1716.050167]          extent data disk bytenr 10701806538752 nr 32768
> [ 1716.050168]          extent data offset 0 nr 32768 ram 32768
> [ 1716.050168]  item 89 key (484129 108 21168128) itemoff 14619 
> itemsize 53
> [ 1716.050170]          extent data disk bytenr 10701807833088 nr 32768
> [ 1716.050170]          extent data offset 0 nr 32768 ram 32768
> [ 1716.050171]  item 90 key (484129 108 23396352) itemoff 14566 
> itemsize 53
> [ 1716.050172]          extent data disk bytenr 10701807865856 nr 32768
> [ 1716.050173]          extent data offset 0 nr 32768 ram 32768
> [ 1716.050174]  item 91 key (484147 1 0) itemoff 14406 itemsize 160
> [ 1716.050175]          inode generation 45 size 1096 mode 40755
> [ 1716.050176]  item 92 key (484147 12 484145) itemoff 14393 itemsize 13
> [ 1716.050177]  item 93 key (484147 72 4) itemoff 14385 itemsize 8
> [ 1716.050179]  item 94 key (484147 72 27) itemoff 14377 itemsize 8
> [ 1716.050180]  item 95 key (484147 72 35) itemoff 14369 itemsize 8
> [ 1716.050181]  item 96 key (484147 72 40) itemoff 14361 itemsize 8
> [ 1716.050183]  item 97 key (484147 72 45) itemoff 14353 itemsize 8
> [ 1716.050184]  item 98 key (484147 72 52) itemoff 14345 itemsize 8
> [ 1716.050185]  item 99 key (484147 72 61) itemoff 14337 itemsize 8
> [ 1716.050186]  item 100 key (484147 72 65) itemoff 14329 itemsize 8
> [ 1716.050187]  item 101 key (484147 72 88) itemoff 14321 itemsize 8
> [ 1716.050189]  item 102 key (484147 72 92) itemoff 14313 itemsize 8
> [ 1716.050190]  item 103 key (484147 72 350) itemoff 14305 itemsize 8
> [ 1716.050192]  item 104 key (484147 72 351) itemoff 14297 itemsize 8
> [ 1716.050193]  item 105 key (484147 72 352) itemoff 14289 itemsize 8
> [ 1716.050194] BTRFS error (device sda2): batch items:
> [ 1716.050195] BTRFS error (device sda2): item 0 index 1330094
> [ 1716.050197] BTRFS error (device sda2): item 1 index 1330116
> [ 1716.050198] BTRFS error (device sda2): item 2 index 1330127
> [ 1716.050199] BTRFS error (device sda2): item 3 index 1330128
> [ 1716.050200] BTRFS error (device sda2): item 4 index 1330130
> [ 1716.050201] BTRFS error (device sda2): item 5 index 1330132
>
> However this time the filesystem didn't switch to readonly.
>
> Thanks in advance,
>
> David Arendt
>
Hi,

Sorry, I missed some messages that where before, here the complete output:

[ 1678.850339] Modules linked in:
[ 1678.850341] CPU: 0 PID: 10022 Comm: mozStorage #8 Tainted: G        
W          6.2.0-rc2 #1
[ 1678.850344] Hardware name: ASUS All Series/H87M-PRO, BIOS 2102 10/28/2014
[ 1678.850345] RIP: 0010:generic_err+0x1e/0xa8
[ 1678.850348] Code: 90 90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 
52 4c 8d 55 10 48 83 ec 58 48 89 4d e0 4c 89 45 e8 4c 89 4d f0 4c 8b 5f 
18 <0f> 0b 48 8d 45 c8 48 89 55 a0 ba 11 ff ff 01 41 89 f1 48 89 45 c0
[ 1678.850350] RSP: 0018:ffffc90001e7b9c8 EFLAGS: 00010292
[ 1678.850352] RAX: 0000000000000060 RBX: 0000000000003cdb RCX: 
0000000000076317
[ 1678.850353] RDX: ffffffff82670cf8 RSI: 0000000000000040 RDI: 
ffff8882c9eb4c00
[ 1678.850354] RBP: ffffc90001e7ba28 R08: 0000000000000060 R09: 
0000000000144b58
[ 1678.850355] R10: ffffc90001e7ba38 R11: ffff888101e4d000 R12: 
00000000000006a5
[ 1678.850356] R13: 0000000000000040 R14: 0000000000000640 R15: 
ffff888101e4d000
[ 1678.850357] FS:  00007f0eaf2646c0(0000) GS:ffff8887fdc00000(0000) 
knlGS:0000000000000000
[ 1678.850359] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1678.850360] CR2: 00007f0eaaac5920 CR3: 00000002c9e34005 CR4: 
00000000001706f0
[ 1678.850362] Call Trace:
[ 1678.850364]  <TASK>
[ 1678.850365]  ? leaf_space_used+0xad/0xd0
[ 1678.850370]  check_leaf.cold+0x562/0x601
[ 1678.850373]  ? copy_extent_buffer+0xe6/0x110
[ 1678.850376]  log_dir_items+0x58d/0x890
[ 1678.850380]  log_directory_changes+0x8b/0x1a0
[ 1678.850383]  btrfs_log_inode+0x897/0x1960
[ 1678.850385]  ? __kmem_cache_alloc_node+0x20e/0x330
[ 1678.850390]  ? find_get_pages_range_tag+0x7a/0x1c0
[ 1678.850394]  btrfs_log_inode_parent+0x24e/0xdf0
[ 1678.850396]  ? pagevec_lookup_range_tag+0x1f/0x30
[ 1678.850400]  ? __filemap_fdatawait_range+0x46/0xe0
[ 1678.850404]  ? perf_event_exec+0x1b0/0x310
[ 1678.850407]  ? wait_current_trans+0x15/0xe0
[ 1678.850410]  ? kmem_cache_alloc+0x226/0x380
[ 1678.850414]  ? join_transaction+0x1b/0x3f0
[ 1678.850417]  btrfs_log_dentry_safe+0x35/0x50
[ 1678.850419]  btrfs_sync_file+0x296/0x4e0
[ 1678.850422]  __x64_sys_fsync+0x32/0x60
[ 1678.850425]  do_syscall_64+0x42/0x90
[ 1678.850428]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 1678.850432] RIP: 0033:0x7f0eda50b35a
[ 1678.850434] Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 
83 ec 18 89 7c 24 0c e8 f3 72 f8 ff 8b 7c 24 0c 89 c2 b8 4a 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 53 73 f8 ff 8b 44 24
[ 1678.850435] RSP: 002b:00007f0eaf263330 EFLAGS: 00000293 ORIG_RAX: 
000000000000004a
[ 1678.850437] RAX: ffffffffffffffda RBX: 00007f0ea96db5e0 RCX: 
00007f0eda50b35a
[ 1678.850438] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000039
[ 1678.850439] RBP: 0000000000000000 R08: 0000000000000000 R09: 
00007f0ed985e000
[ 1678.850440] R10: 0000000000000000 R11: 0000000000000293 R12: 
d763a120f905d5d9
[ 1678.850441] R13: 00007f0ea7f0f000 R14: 0000000000000002 R15: 
0000000000000000
[ 1678.850442]  </TASK>
[ 1678.850443] ---[ end trace 0000000000000000 ]---
[ 1678.850444] BTRFS critical (device sda2): corrupt leaf: 
root=18446744073709551610 block=682721280 slot=64, bad key order, prev 
(484119 96 1330008) current (484119 96 1330008)
[ 1678.850456] ------------[ cut here ]------------
[ 1678.850457] WARNING: CPU: 0 PID: 10022 at fs/btrfs/tree-log.c:3678 
log_dir_items.cold+0x0/0xbc
[ 1678.850461] Modules linked in:
[ 1678.850463] CPU: 0 PID: 10022 Comm: mozStorage #8 Tainted: G        
W          6.2.0-rc2 #1
[ 1678.850465] Hardware name: ASUS All Series/H87M-PRO, BIOS 2102 10/28/2014
[ 1678.850466] RIP: 0010:log_dir_items.cold+0x0/0xbc
[ 1678.850469] Code: 4e 18 4d 89 f0 e8 43 4a 00 00 4d 8b 76 40 49 8d 46 
c0 48 89 04 24 eb c6 8b 4c 24 0c 48 c7 c6 f0 df 66 82 e8 25 4a 00 00 eb 
a4 <0f> 0b 48 8b 44 24 30 8b 94 24 b4 00 00 00 8b 48 40 48 8b 44 24 18
[ 1678.850470] RSP: 0018:ffffc90001e7baf8 EFLAGS: 00010286
[ 1678.850471] RAX: 00000000ffffff8b RBX: ffff8882c033c380 RCX: 
0000000000000027
[ 1678.850472] RDX: ffff8887fdc1b288 RSI: 0000000000000001 RDI: 
ffff8887fdc1b280
[ 1678.850473] RBP: ffff8882382958c0 R08: 00000000ffffdfff R09: 
0000000000000000
[ 1678.850474] R10: ffffffff82854220 R11: ffffffff82854220 R12: 
ffff8882c8a08400
[ 1678.850475] R13: 00000000ffffff8b R14: ffff8882c933b200 R15: 
ffff8882c9eb4c00
[ 1678.850476] FS:  00007f0eaf2646c0(0000) GS:ffff8887fdc00000(0000) 
knlGS:0000000000000000
[ 1678.850478] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1678.850479] CR2: 00007f0eaaac5920 CR3: 00000002c9e34005 CR4: 
00000000001706f0
[ 1678.850480] Call Trace:
[ 1678.850481]  <TASK>
[ 1678.850482]  log_directory_changes+0x8b/0x1a0
[ 1678.850485]  btrfs_log_inode+0x897/0x1960
[ 1678.850487]  ? __kmem_cache_alloc_node+0x20e/0x330
[ 1678.850492]  ? find_get_pages_range_tag+0x7a/0x1c0
[ 1678.850496]  btrfs_log_inode_parent+0x24e/0xdf0
[ 1678.850498]  ? pagevec_lookup_range_tag+0x1f/0x30
[ 1678.850502]  ? __filemap_fdatawait_range+0x46/0xe0
[ 1678.850504]  ? perf_event_exec+0x1b0/0x310
[ 1678.850507]  ? wait_current_trans+0x15/0xe0
[ 1678.850510]  ? kmem_cache_alloc+0x226/0x380
[ 1678.850512]  ? join_transaction+0x1b/0x3f0
[ 1678.850514]  btrfs_log_dentry_safe+0x35/0x50
[ 1678.850517]  btrfs_sync_file+0x296/0x4e0
[ 1678.850519]  __x64_sys_fsync+0x32/0x60
[ 1678.850521]  do_syscall_64+0x42/0x90
[ 1678.850524]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 1678.850527] RIP: 0033:0x7f0eda50b35a
[ 1678.850528] Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 
83 ec 18 89 7c 24 0c e8 f3 72 f8 ff 8b 7c 24 0c 89 c2 b8 4a 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 53 73 f8 ff 8b 44 24
[ 1678.850529] RSP: 002b:00007f0eaf263330 EFLAGS: 00000293 ORIG_RAX: 
000000000000004a
[ 1678.850531] RAX: ffffffffffffffda RBX: 00007f0ea96db5e0 RCX: 
00007f0eda50b35a
[ 1678.850532] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000039
[ 1678.850533] RBP: 0000000000000000 R08: 0000000000000000 R09: 
00007f0ed985e000
[ 1678.850534] R10: 0000000000000000 R11: 0000000000000293 R12: 
d763a120f905d5d9
[ 1678.850535] R13: 00007f0ea7f0f000 R14: 0000000000000002 R15: 
0000000000000000
[ 1678.850536]  </TASK>
[ 1678.850537] ---[ end trace 0000000000000000 ]---
[ 1678.850538] BTRFS error (device sda2): corrupt leaf batch insert 
(count 2), slot 62, leaf before:
[ 1678.850540] BTRFS info (device sda2): leaf 682721280 gen 5091426 
total ptrs 149 free space 4354 owner 18446744073709551610
[ 1678.850542]  item 0 key (484119 1 0) itemoff 16123 itemsize 160
[ 1678.850544]          inode generation 45 size 2290 mode 40700
[ 1678.850545]  item 1 key (484119 12 484118) itemoff 16097 itemsize 26
[ 1678.850546]  item 2 key (484119 72 15) itemoff 16089 itemsize 8
[ 1678.850548]  item 3 key (484119 72 20) itemoff 16081 itemsize 8
[ 1678.850549]  item 4 key (484119 72 25) itemoff 16073 itemsize 8
[ 1678.850550]  item 5 key (484119 72 30) itemoff 16065 itemsize 8
[ 1678.850551]  item 6 key (484119 72 32630) itemoff 16057 itemsize 8
[ 1678.850552]  item 7 key (484119 72 40332) itemoff 16049 itemsize 8
[ 1678.850553]  item 8 key (484119 72 40335) itemoff 16041 itemsize 8
[ 1678.850554]  item 9 key (484119 72 93630) itemoff 16033 itemsize 8
[ 1678.850555]  item 10 key (484119 72 101741) itemoff 16025 itemsize 8
[ 1678.850557]  item 11 key (484119 72 131485) itemoff 16017 itemsize 8
[ 1678.850558]  item 12 key (484119 72 183799) itemoff 16009 itemsize 8
[ 1678.850559]  item 13 key (484119 72 183801) itemoff 16001 itemsize 8
[ 1678.850560]  item 14 key (484119 72 203038) itemoff 15993 itemsize 8
[ 1678.850561]  item 15 key (484119 72 254997) itemoff 15985 itemsize 8
[ 1678.850562]  item 16 key (484119 72 255172) itemoff 15977 itemsize 8
[ 1678.850563]  item 17 key (484119 72 255208) itemoff 15969 itemsize 8
[ 1678.850564]  item 18 key (484119 72 256848) itemoff 15961 itemsize 8
[ 1678.850565]  item 19 key (484119 72 264839) itemoff 15953 itemsize 8
[ 1678.850567]  item 20 key (484119 72 266090) itemoff 15945 itemsize 8
[ 1678.850568]  item 21 key (484119 72 266976) itemoff 15937 itemsize 8
[ 1678.850569]  item 22 key (484119 72 267056) itemoff 15929 itemsize 8
[ 1678.850570]  item 23 key (484119 72 302340) itemoff 15921 itemsize 8
[ 1678.850571]  item 24 key (484119 72 513980) itemoff 15913 itemsize 8
[ 1678.850572]  item 25 key (484119 72 848319) itemoff 15905 itemsize 8
[ 1678.850573]  item 26 key (484119 72 848845) itemoff 15897 itemsize 8
[ 1678.850574]  item 27 key (484119 72 938962) itemoff 15889 itemsize 8
[ 1678.850575]  item 28 key (484119 72 1001565) itemoff 15881 itemsize 8
[ 1678.850576]  item 29 key (484119 72 1217319) itemoff 15873 itemsize 8
[ 1678.850577]  item 30 key (484119 72 1217321) itemoff 15865 itemsize 8
[ 1678.850579]  item 31 key (484119 72 1268172) itemoff 15857 itemsize 8
[ 1678.850580]  item 32 key (484119 72 1298657) itemoff 15849 itemsize 8
[ 1678.850581]  item 33 key (484119 72 1299762) itemoff 15841 itemsize 8
[ 1678.850582]  item 34 key (484119 72 1328486) itemoff 15833 itemsize 8
[ 1678.850583]  item 35 key (484119 72 1329021) itemoff 15825 itemsize 8
[ 1678.850584]  item 36 key (484119 72 1329328) itemoff 15817 itemsize 8
[ 1678.850585]  item 37 key (484119 72 1329330) itemoff 15809 itemsize 8
[ 1678.850586]  item 38 key (484119 72 1329426) itemoff 15801 itemsize 8
[ 1678.850587]  item 39 key (484119 72 1329431) itemoff 15793 itemsize 8
[ 1678.850589]  item 40 key (484119 72 1329433) itemoff 15785 itemsize 8
[ 1678.850590]  item 41 key (484119 72 1329857) itemoff 15777 itemsize 8
[ 1678.850591]  item 42 key (484119 72 1329939) itemoff 15769 itemsize 8
[ 1678.850592]  item 43 key (484119 72 1329940) itemoff 15761 itemsize 8
[ 1678.850593]  item 44 key (484119 72 1329974) itemoff 15753 itemsize 8
[ 1678.850594]  item 45 key (484119 72 1329975) itemoff 15745 itemsize 8
[ 1678.850595]  item 46 key (484119 72 1329987) itemoff 15737 itemsize 8
[ 1678.850596]  item 47 key (484119 72 1329989) itemoff 15729 itemsize 8
[ 1678.850597]  item 48 key (484119 72 1329991) itemoff 15721 itemsize 8
[ 1678.850598]  item 49 key (484119 72 1329995) itemoff 15713 itemsize 8
[ 1678.850599]  item 50 key (484119 72 1329999) itemoff 15705 itemsize 8
[ 1678.850601]  item 51 key (484119 72 1330001) itemoff 15697 itemsize 8
[ 1678.850602]  item 52 key (484119 72 1330002) itemoff 15689 itemsize 8
[ 1678.850603]  item 53 key (484119 72 1330005) itemoff 15681 itemsize 8
[ 1678.850604]  item 54 key (484119 72 1330010) itemoff 15673 itemsize 8
[ 1678.850605]  item 55 key (484119 72 1330012) itemoff 15665 itemsize 8
[ 1678.850606]  item 56 key (484119 72 1330014) itemoff 15657 itemsize 8
[ 1678.850607]  item 57 key (484119 72 1330015) itemoff 15649 itemsize 8
[ 1678.850608]  item 58 key (484119 72 1330018) itemoff 15641 itemsize 8
[ 1678.850609]  item 59 key (484119 72 1330021) itemoff 15633 itemsize 8
[ 1678.850611]  item 60 key (484119 72 1330023) itemoff 15625 itemsize 8
[ 1678.850612]  item 61 key (484119 72 1330025) itemoff 15617 itemsize 8
[ 1678.850613]  item 62 key (484119 96 1330008) itemoff 15566 itemsize 51
[ 1678.850614]  item 63 key (484147 1 0) itemoff 15406 itemsize 160
[ 1678.850615]          inode generation 45 size 958 mode 40755
[ 1678.850616]  item 64 key (484147 12 484145) itemoff 15393 itemsize 13
[ 1678.850617]  item 65 key (484147 72 4) itemoff 15385 itemsize 8
[ 1678.850618]  item 66 key (484147 72 27) itemoff 15377 itemsize 8
[ 1678.850620]  item 67 key (484147 72 35) itemoff 15369 itemsize 8
[ 1678.850621]  item 68 key (484147 72 40) itemoff 15361 itemsize 8
[ 1678.850622]  item 69 key (484147 72 45) itemoff 15353 itemsize 8
[ 1678.850623]  item 70 key (484147 72 52) itemoff 15345 itemsize 8
[ 1678.850624]  item 71 key (484147 72 61) itemoff 15337 itemsize 8
[ 1678.850625]  item 72 key (484147 72 65) itemoff 15329 itemsize 8
[ 1678.850626]  item 73 key (484147 72 88) itemoff 15321 itemsize 8
[ 1678.850627]  item 74 key (484147 72 92) itemoff 15313 itemsize 8
[ 1678.850628]  item 75 key (484147 72 334) itemoff 15305 itemsize 8
[ 1678.850629]  item 76 key (484147 72 335) itemoff 15297 itemsize 8
[ 1678.850630]  item 77 key (484147 96 344) itemoff 15231 itemsize 66
[ 1678.850632]  item 78 key (484147 96 345) itemoff 15166 itemsize 65
[ 1678.850633]  item 79 key (484147 96 346) itemoff 15094 itemsize 72
[ 1678.850634]  item 80 key (486594 1 0) itemoff 14934 itemsize 160
[ 1678.850635]          inode generation 45 size 419328 mode 100644
[ 1678.850636]  item 81 key (486594 108 0) itemoff 14881 itemsize 53
[ 1678.850637]          extent data disk bytenr 10701215838208 nr 421888
[ 1678.850638]          extent data offset 0 nr 421888 ram 421888
[ 1678.850639]  item 82 key (377976411 1 0) itemoff 14721 itemsize 160
[ 1678.850640]          inode generation 0 size 0 mode 40755
[ 1678.850641]  item 83 key (377989435 1 0) itemoff 14561 itemsize 160
[ 1678.850643]          inode generation 0 size 0 mode 100644
[ 1678.850643]  item 84 key (377989435 12 377985588) itemoff 14535 
itemsize 26
[ 1678.850645]  item 85 key (377989505 1 0) itemoff 14375 itemsize 160
[ 1678.850646]          inode generation 0 size 0 mode 100644
[ 1678.850646]  item 86 key (377989505 12 484119) itemoff 14342 itemsize 33
[ 1678.850648]  item 87 key (377989506 1 0) itemoff 14182 itemsize 160
[ 1678.850649]          inode generation 0 size 0 mode 100600
[ 1678.850650]  item 88 key (377989506 12 484119) itemoff 14164 itemsize 18
[ 1678.850651]  item 89 key (377989514 1 0) itemoff 14004 itemsize 160
[ 1678.850652]          inode generation 0 size 44341 mode 100600
[ 1678.850653]  item 90 key (377989514 108 0) itemoff 13951 itemsize 53
[ 1678.850654]          extent data disk bytenr 10698890280960 nr 45056
[ 1678.850655]          extent data offset 0 nr 45056 ram 45056
[ 1678.850656]  item 91 key (377989515 1 0) itemoff 13791 itemsize 160
[ 1678.850657]          inode generation 0 size 0 mode 100644
[ 1678.850658]  item 92 key (377989515 12 484119) itemoff 13760 itemsize 31
[ 1678.850659]  item 93 key (377989516 1 0) itemoff 13600 itemsize 160
[ 1678.850660]          inode generation 5091426 size 424312 mode 100644
[ 1678.850661]  item 94 key (377989516 108 0) itemoff 13547 itemsize 53
[ 1678.850662]          extent data disk bytenr 10701211512832 nr 4096
[ 1678.850663]          extent data offset 0 nr 4096 ram 4096
[ 1678.850663]  item 95 key (377989516 108 4096) itemoff 13494 itemsize 53
[ 1678.850665]          extent data disk bytenr 10701243060224 nr 425984
[ 1678.850666]          extent data offset 4096 nr 421888 ram 425984
[ 1678.850666]  item 96 key (377989517 1 0) itemoff 13334 itemsize 160
[ 1678.850668]          inode generation 5091426 size 104 mode 100644
[ 1678.850669]  item 97 key (377989517 108 0) itemoff 13209 itemsize 125
[ 1678.850670]          inline extent data size 104
[ 1678.850670]  item 98 key (377989521 1 0) itemoff 13049 itemsize 160
[ 1678.850672]          inode generation 0 size 0 mode 40755
[ 1678.850672]  item 99 key (377989521 12 475176) itemoff 13027 itemsize 22
[ 1678.850674]  item 100 key (377989534 1 0) itemoff 12867 itemsize 160
[ 1678.850675]          inode generation 0 size 0 mode 40755
[ 1678.850676]  item 101 key (377989534 12 377989521) itemoff 12850 
itemsize 17
[ 1678.850677]  item 102 key (377989534 72 12) itemoff 12842 itemsize 8
[ 1678.850678]  item 103 key (377989534 72 14) itemoff 12834 itemsize 8
[ 1678.850679]  item 104 key (377989534 72 16) itemoff 12826 itemsize 8
[ 1678.850680]  item 105 key (377989534 72 18) itemoff 12818 itemsize 8
[ 1678.850681]  item 106 key (377989575 1 0) itemoff 12658 itemsize 160
[ 1678.850683]          inode generation 0 size 14291234 mode 100644
[ 1678.850683]  item 107 key (377989575 12 377989534) itemoff 12625 
itemsize 33
[ 1678.850685]  item 108 key (377989575 108 0) itemoff 12572 itemsize 53
[ 1678.850686]          extent data disk bytenr 10702164959232 nr 14295040
[ 1678.850687]          extent data offset 0 nr 14065664 ram 14295040
[ 1678.850688]  item 109 key (377989575 108 14065664) itemoff 12519 
itemsize 53
[ 1678.850689]          extent data disk bytenr 10702164959232 nr 14295040
[ 1678.850690]          extent data offset 14065664 nr 229376 ram 14295040
[ 1678.850691]  item 110 key (377989576 1 0) itemoff 12359 itemsize 160
[ 1678.850692]          inode generation 0 size 333596 mode 100644
[ 1678.850693]  item 111 key (377989576 12 377989534) itemoff 12324 
itemsize 35
[ 1678.850694]  item 112 key (377989576 108 0) itemoff 12271 itemsize 53
[ 1678.850695]          extent data disk bytenr 10701966163968 nr 335872
[ 1678.850696]          extent data offset 0 nr 335872 ram 335872
[ 1678.850696]  item 113 key (377989577 1 0) itemoff 12111 itemsize 160
[ 1678.850698]          inode generation 0 size 105248 mode 100644
[ 1678.850698]  item 114 key (377989577 12 377989534) itemoff 12075 
itemsize 36
[ 1678.850700]  item 115 key (377989577 108 0) itemoff 12022 itemsize 53
[ 1678.850701]          extent data disk bytenr 10701977268224 nr 106496
[ 1678.850701]          extent data offset 0 nr 106496 ram 106496
[ 1678.850702]  item 116 key (377989578 1 0) itemoff 11862 itemsize 160
[ 1678.850703]          inode generation 0 size 583936 mode 100644
[ 1678.850704]  item 117 key (377989578 12 377989534) itemoff 11825 
itemsize 37
[ 1678.850705]  item 118 key (377989578 108 0) itemoff 11772 itemsize 53
[ 1678.850706]          extent data disk bytenr 10702179254272 nr 585728
[ 1678.850707]          extent data offset 0 nr 565248 ram 585728
[ 1678.850708]  item 119 key (377989578 108 565248) itemoff 11719 
itemsize 53
[ 1678.850709]          extent data disk bytenr 10702179254272 nr 585728
[ 1678.850710]          extent data offset 565248 nr 20480 ram 585728
[ 1678.850711]  item 120 key (377989580 1 0) itemoff 11559 itemsize 160
[ 1678.850712]          inode generation 0 size 44341 mode 100600
[ 1678.850713]  item 121 key (377989580 108 0) itemoff 11506 itemsize 53
[ 1678.850714]          extent data disk bytenr 10702072410112 nr 45056
[ 1678.850715]          extent data offset 0 nr 45056 ram 45056
[ 1678.850715]  item 122 key (377989581 1 0) itemoff 11346 itemsize 160
[ 1678.850717]          inode generation 0 size 0 mode 100644
[ 1678.850717]  item 123 key (377989581 12 484147) itemoff 11300 itemsize 46
[ 1678.850719]  item 124 key (377989598 1 0) itemoff 11140 itemsize 160
[ 1678.850720]          inode generation 0 size 0 mode 100644
[ 1678.850721]  item 125 key (377989599 1 0) itemoff 10980 itemsize 160
[ 1678.850722]          inode generation 0 size 44341 mode 100600
[ 1678.850723]  item 126 key (377989599 12 484119) itemoff 10962 itemsize 18
[ 1678.850724]  item 127 key (377989599 108 0) itemoff 10909 itemsize 53
[ 1678.850725]          extent data disk bytenr 10701383086080 nr 45056
[ 1678.850726]          extent data offset 0 nr 45056 ram 45056
[ 1678.850726]  item 128 key (377989600 1 0) itemoff 10749 itemsize 160
[ 1678.850728]          inode generation 0 size 0 mode 100644
[ 1678.850728]  item 129 key (377989601 1 0) itemoff 10589 itemsize 160
[ 1678.850730]          inode generation 5091426 size 32 mode 100644
[ 1678.850731]  item 130 key (377989601 12 484147) itemoff 10544 itemsize 45
[ 1678.850732]  item 131 key (377989601 108 0) itemoff 10491 itemsize 53
[ 1678.850733]          inline extent data size 32
[ 1678.850733]  item 132 key (377989602 1 0) itemoff 10331 itemsize 160
[ 1678.850735]          inode generation 0 size 0 mode 100644
[ 1678.850735]  item 133 key (377989602 12 484119) itemoff 10301 itemsize 30
[ 1678.850737]  item 134 key (377989603 1 0) itemoff 10141 itemsize 160
[ 1678.850738]          inode generation 0 size 0 mode 100644
[ 1678.850738]  item 135 key (377989603 12 484147) itemoff 10089 itemsize 52
[ 1678.850740]  item 136 key (377989604 1 0) itemoff 9929 itemsize 160
[ 1678.850741]          inode generation 5091426 size 33288 mode 100644
[ 1678.850742]  item 137 key (377989604 12 484119) itemoff 9893 itemsize 36
[ 1678.850743]  item 138 key (377989604 108 0) itemoff 9840 itemsize 53
[ 1678.850744]          extent data disk bytenr 10701979844608 nr 36864
[ 1678.850745]          extent data offset 0 nr 36864 ram 36864
[ 1678.850746]  item 139 key (377989605 1 0) itemoff 9680 itemsize 160
[ 1678.850747]          inode generation 0 size 0 mode 100644
[ 1678.850747]  item 140 key (377989606 1 0) itemoff 9520 itemsize 160
[ 1678.850749]          inode generation 0 size 0 mode 100644
[ 1678.850749]  item 141 key (377989607 1 0) itemoff 9360 itemsize 160
[ 1678.850751]          inode generation 0 size 0 mode 100644
[ 1678.850751]  item 142 key (377989607 12 484119) itemoff 9327 itemsize 33
[ 1678.850752]  item 143 key (18446744073709551606 128 10698890280960) 
itemoff 9283 itemsize 44
[ 1678.850754]  item 144 key (18446744073709551606 128 10701211512832) 
itemoff 9279 itemsize 4
[ 1678.850756]  item 145 key (18446744073709551606 128 10701215838208) 
itemoff 8867 itemsize 412
[ 1678.850757]  item 146 key (18446744073709551606 128 10701243060224) 
itemoff 8451 itemsize 416
[ 1678.850759]  item 147 key (18446744073709551606 128 10701383086080) 
itemoff 8407 itemsize 44
[ 1678.850762]  item 148 key (18446744073709551606 128 10701966163968) 
itemoff 8079 itemsize 328
[ 1678.850763] BTRFS error (device sda2): batch items:
[ 1678.850766] BTRFS error (device sda2): item 0 index 1330006
[ 1678.850768] BTRFS error (device sda2): item 1 index 1330008
[ 1716.049824] ------------[ cut here ]------------
[ 1716.049827] WARNING: CPU: 5 PID: 12051 at fs/btrfs/tree-checker.c:62 
generic_err+0x1e/0xa8
[ 1716.049834] Modules linked in:
[ 1716.049836] CPU: 5 PID: 12051 Comm: firefox Tainted: G W          
6.2.0-rc2 #1
[ 1716.049838] Hardware name: ASUS All Series/H87M-PRO, BIOS 2102 10/28/2014
[ 1716.049840] RIP: 0010:generic_err+0x1e/0xa8
[ 1716.049842] Code: 90 90 90 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 
52 4c 8d 55 10 48 83 ec 58 48 89 4d e0 4c 89 45 e8 4c 89 4d f0 4c 8b 5f 
18 <0f> 0b 48 8d 45 c8 48 89 55 a0 ba 11 ff ff 01 41 89 f1 48 89 45 c0
[ 1716.049844] RSP: 0018:ffffc9000392b9c8 EFLAGS: 00010292
[ 1716.049846] RAX: 0000000000000060 RBX: 0000000000003bba RCX: 
0000000000076317
[ 1716.049847] RDX: ffffffff82670cf8 RSI: 0000000000000051 RDI: 
ffff88825efce800
[ 1716.049848] RBP: ffffc9000392ba28 R08: 0000000000000060 R09: 
0000000000144bd4
[ 1716.049849] R10: ffffc9000392ba38 R11: ffff888101e4d000 R12: 
000000000000084e
[ 1716.049850] R13: 0000000000000051 R14: 00000000000007e9 R15: 
ffff888101e4d000
[ 1716.049852] FS:  00007fcf9d012780(0000) GS:ffff8887fdd40000(0000) 
knlGS:0000000000000000
[ 1716.049854] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1716.049855] CR2: 00007fcf881a5000 CR3: 00000002c8bce003 CR4: 
00000000001706e0
[ 1716.049857] Call Trace:
[ 1716.049860]  <TASK>
[ 1716.049862]  ? leaf_space_used+0xad/0xd0
[ 1716.049866]  check_leaf.cold+0x562/0x601
[ 1716.049870]  ? copy_extent_buffer+0xe6/0x110
[ 1716.049874]  log_dir_items+0x58d/0x890
[ 1716.049878]  log_directory_changes+0x8b/0x1a0
[ 1716.049880]  btrfs_log_inode+0x897/0x1960
[ 1716.049883]  ? __kmem_cache_alloc_node+0x20e/0x330
[ 1716.049887]  ? find_get_pages_range_tag+0x7a/0x1c0
[ 1716.049892]  btrfs_log_inode_parent+0x24e/0xdf0
[ 1716.049894]  ? pagevec_lookup_range_tag+0x1f/0x30
[ 1716.049897]  ? __filemap_fdatawait_range+0x46/0xe0
[ 1716.049900]  ? perf_event_exec+0x1b0/0x310
[ 1716.049903]  ? wait_current_trans+0x15/0xe0
[ 1716.049906]  ? kmem_cache_alloc+0x226/0x380
[ 1716.049908]  ? join_transaction+0x1b/0x3f0
[ 1716.049911]  btrfs_log_dentry_safe+0x35/0x50
[ 1716.049913]  btrfs_sync_file+0x296/0x4e0
[ 1716.049916]  __x64_sys_fsync+0x32/0x60
[ 1716.049919]  do_syscall_64+0x42/0x90
[ 1716.049923]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 1716.049928] RIP: 0033:0x7fcf9d11135a
[ 1716.049930] Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 
83 ec 18 89 7c 24 0c e8 f3 72 f8 ff 8b 7c 24 0c 89 c2 b8 4a 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 53 73 f8 ff 8b 44 24
[ 1716.049931] RSP: 002b:00007ffc920f8cb0 EFLAGS: 00000293 ORIG_RAX: 
000000000000004a
[ 1716.049933] RAX: ffffffffffffffda RBX: 00007fcf79ca5148 RCX: 
00007fcf9d11135a
[ 1716.049935] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000069
[ 1716.049936] RBP: 0000000000000000 R08: 0000000000000000 R09: 
00007fcf9c45e000
[ 1716.049937] R10: 0000000000000000 R11: 0000000000000293 R12: 
00007fcf71024038
[ 1716.049938] R13: 0000000000000000 R14: 0000000000000002 R15: 
0000000000000000
[ 1716.049939]  </TASK>
[ 1716.049940] ---[ end trace 0000000000000000 ]---
[ 1716.049941] BTRFS critical (device sda2): corrupt leaf: 
root=18446744073709551610 block=713932800 slot=81, bad key order, prev 
(484119 96 1330132) current (484119 96 1330116)
[ 1716.049954] ------------[ cut here ]------------
[ 1716.049955] WARNING: CPU: 5 PID: 12051 at fs/btrfs/tree-log.c:3678 
log_dir_items.cold+0x0/0xbc
[ 1716.049960] Modules linked in:
[ 1716.049961] CPU: 5 PID: 12051 Comm: firefox Tainted: G W          
6.2.0-rc2 #1
[ 1716.049963] Hardware name: ASUS All Series/H87M-PRO, BIOS 2102 10/28/2014
[ 1716.049964] RIP: 0010:log_dir_items.cold+0x0/0xbc
[ 1716.049967] Code: 4e 18 4d 89 f0 e8 43 4a 00 00 4d 8b 76 40 49 8d 46 
c0 48 89 04 24 eb c6 8b 4c 24 0c 48 c7 c6 f0 df 66 82 e8 25 4a 00 00 eb 
a4 <0f> 0b 48 8b 44 24 30 8b 94 24 b4 00 00 00 8b 48 40 48 8b 44 24 18
[ 1716.049969] RSP: 0018:ffffc9000392baf8 EFLAGS: 00010286
[ 1716.049970] RAX: 00000000ffffff8b RBX: ffff888283aa6070 RCX: 
0000000000000027
[ 1716.049971] RDX: ffff8887fdd5b288 RSI: 0000000000000001 RDI: 
ffff8887fdd5b280
[ 1716.049972] RBP: ffff8881b9a10380 R08: 00000000ffffdfff R09: 
0000000000000000
[ 1716.049973] R10: ffffffff82854220 R11: ffffffff82854220 R12: 
ffff8882c9338b00
[ 1716.049975] R13: 00000000ffffff8b R14: ffff8881e6958700 R15: 
ffff88825efce800
[ 1716.049976] FS:  00007fcf9d012780(0000) GS:ffff8887fdd40000(0000) 
knlGS:0000000000000000
[ 1716.049977] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1716.049978] CR2: 00007fcf881a5000 CR3: 00000002c8bce003 CR4: 
00000000001706e0
[ 1716.049979] Call Trace:
[ 1716.049980]  <TASK>
[ 1716.049981]  log_directory_changes+0x8b/0x1a0
[ 1716.049985]  btrfs_log_inode+0x897/0x1960
[ 1716.049987]  ? __kmem_cache_alloc_node+0x20e/0x330
[ 1716.049991]  ? find_get_pages_range_tag+0x7a/0x1c0
[ 1716.049994]  btrfs_log_inode_parent+0x24e/0xdf0
[ 1716.049996]  ? pagevec_lookup_range_tag+0x1f/0x30
[ 1716.049999]  ? __filemap_fdatawait_range+0x46/0xe0
[ 1716.050001]  ? perf_event_exec+0x1b0/0x310
[ 1716.050004]  ? wait_current_trans+0x15/0xe0
[ 1716.050007]  ? kmem_cache_alloc+0x226/0x380
[ 1716.050009]  ? join_transaction+0x1b/0x3f0
[ 1716.050011]  btrfs_log_dentry_safe+0x35/0x50
[ 1716.050013]  btrfs_sync_file+0x296/0x4e0
[ 1716.050016]  __x64_sys_fsync+0x32/0x60
[ 1716.050018]  do_syscall_64+0x42/0x90
[ 1716.050021]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 1716.050023] RIP: 0033:0x7fcf9d11135a
[ 1716.050025] Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 
83 ec 18 89 7c 24 0c e8 f3 72 f8 ff 8b 7c 24 0c 89 c2 b8 4a 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 53 73 f8 ff 8b 44 24
[ 1716.050026] RSP: 002b:00007ffc920f8cb0 EFLAGS: 00000293 ORIG_RAX: 
000000000000004a
[ 1716.050028] RAX: ffffffffffffffda RBX: 00007fcf79ca5148 RCX: 
00007fcf9d11135a
[ 1716.050029] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000069
[ 1716.050030] RBP: 0000000000000000 R08: 0000000000000000 R09: 
00007fcf9c45e000
[ 1716.050030] R10: 0000000000000000 R11: 0000000000000293 R12: 
00007fcf71024038
[ 1716.050031] R13: 0000000000000000 R14: 0000000000000002 R15: 
0000000000000000
[ 1716.050033]  </TASK>
[ 1716.050033] ---[ end trace 0000000000000000 ]---
[ 1716.050035] BTRFS error (device sda2): corrupt leaf batch insert 
(count 6), slot 75, leaf before:
[ 1716.050037] BTRFS info (device sda2): leaf 713932800 gen 5091428 
total ptrs 106 free space 11639 owner 18446744073709551610
[ 1716.050040]  item 0 key (484119 1 0) itemoff 16123 itemsize 160
[ 1716.050041]          inode generation 45 size 2238 mode 40700
[ 1716.050042]  item 1 key (484119 12 484118) itemoff 16097 itemsize 26
[ 1716.050044]  item 2 key (484119 72 15) itemoff 16089 itemsize 8
[ 1716.050045]  item 3 key (484119 72 20) itemoff 16081 itemsize 8
[ 1716.050046]  item 4 key (484119 72 25) itemoff 16073 itemsize 8
[ 1716.050048]  item 5 key (484119 72 30) itemoff 16065 itemsize 8
[ 1716.050049]  item 6 key (484119 72 32630) itemoff 16057 itemsize 8
[ 1716.050050]  item 7 key (484119 72 40332) itemoff 16049 itemsize 8
[ 1716.050051]  item 8 key (484119 72 40335) itemoff 16041 itemsize 8
[ 1716.050052]  item 9 key (484119 72 93630) itemoff 16033 itemsize 8
[ 1716.050053]  item 10 key (484119 72 101741) itemoff 16025 itemsize 8
[ 1716.050054]  item 11 key (484119 72 131485) itemoff 16017 itemsize 8
[ 1716.050056]  item 12 key (484119 72 183799) itemoff 16009 itemsize 8
[ 1716.050057]  item 13 key (484119 72 183801) itemoff 16001 itemsize 8
[ 1716.050058]  item 14 key (484119 72 203038) itemoff 15993 itemsize 8
[ 1716.050059]  item 15 key (484119 72 254997) itemoff 15985 itemsize 8
[ 1716.050060]  item 16 key (484119 72 255172) itemoff 15977 itemsize 8
[ 1716.050062]  item 17 key (484119 72 255208) itemoff 15969 itemsize 8
[ 1716.050063]  item 18 key (484119 72 256848) itemoff 15961 itemsize 8
[ 1716.050064]  item 19 key (484119 72 264839) itemoff 15953 itemsize 8
[ 1716.050065]  item 20 key (484119 72 266090) itemoff 15945 itemsize 8
[ 1716.050066]  item 21 key (484119 72 266976) itemoff 15937 itemsize 8
[ 1716.050067]  item 22 key (484119 72 267056) itemoff 15929 itemsize 8
[ 1716.050068]  item 23 key (484119 72 302340) itemoff 15921 itemsize 8
[ 1716.050070]  item 24 key (484119 72 513980) itemoff 15913 itemsize 8
[ 1716.050071]  item 25 key (484119 72 848319) itemoff 15905 itemsize 8
[ 1716.050072]  item 26 key (484119 72 848845) itemoff 15897 itemsize 8
[ 1716.050073]  item 27 key (484119 72 938962) itemoff 15889 itemsize 8
[ 1716.050074]  item 28 key (484119 72 1001565) itemoff 15881 itemsize 8
[ 1716.050076]  item 29 key (484119 72 1217319) itemoff 15873 itemsize 8
[ 1716.050077]  item 30 key (484119 72 1217321) itemoff 15865 itemsize 8
[ 1716.050078]  item 31 key (484119 72 1268172) itemoff 15857 itemsize 8
[ 1716.050079]  item 32 key (484119 72 1298657) itemoff 15849 itemsize 8
[ 1716.050080]  item 33 key (484119 72 1299762) itemoff 15841 itemsize 8
[ 1716.050081]  item 34 key (484119 72 1328486) itemoff 15833 itemsize 8
[ 1716.050082]  item 35 key (484119 72 1329021) itemoff 15825 itemsize 8
[ 1716.050083]  item 36 key (484119 72 1329328) itemoff 15817 itemsize 8
[ 1716.050085]  item 37 key (484119 72 1329330) itemoff 15809 itemsize 8
[ 1716.050086]  item 38 key (484119 72 1329857) itemoff 15801 itemsize 8
[ 1716.050087]  item 39 key (484119 72 1330009) itemoff 15793 itemsize 8
[ 1716.050089]  item 40 key (484119 72 1330037) itemoff 15785 itemsize 8
[ 1716.050091]  item 41 key (484119 72 1330038) itemoff 15777 itemsize 8
[ 1716.050092]  item 42 key (484119 72 1330041) itemoff 15769 itemsize 8
[ 1716.050093]  item 43 key (484119 72 1330042) itemoff 15761 itemsize 8
[ 1716.050094]  item 44 key (484119 72 1330046) itemoff 15753 itemsize 8
[ 1716.050096]  item 45 key (484119 72 1330048) itemoff 15745 itemsize 8
[ 1716.050097]  item 46 key (484119 72 1330054) itemoff 15737 itemsize 8
[ 1716.050098]  item 47 key (484119 72 1330055) itemoff 15729 itemsize 8
[ 1716.050099]  item 48 key (484119 72 1330059) itemoff 15721 itemsize 8
[ 1716.050101]  item 49 key (484119 72 1330062) itemoff 15713 itemsize 8
[ 1716.050102]  item 50 key (484119 72 1330066) itemoff 15705 itemsize 8
[ 1716.050103]  item 51 key (484119 72 1330080) itemoff 15697 itemsize 8
[ 1716.050104]  item 52 key (484119 72 1330081) itemoff 15689 itemsize 8
[ 1716.050105]  item 53 key (484119 72 1330087) itemoff 15681 itemsize 8
[ 1716.050107]  item 54 key (484119 72 1330088) itemoff 15673 itemsize 8
[ 1716.050108]  item 55 key (484119 72 1330089) itemoff 15665 itemsize 8
[ 1716.050109]  item 56 key (484119 72 1330090) itemoff 15657 itemsize 8
[ 1716.050111]  item 57 key (484119 72 1330091) itemoff 15649 itemsize 8
[ 1716.050112]  item 58 key (484119 72 1330092) itemoff 15641 itemsize 8
[ 1716.050114]  item 59 key (484119 72 1330105) itemoff 15633 itemsize 8
[ 1716.050115]  item 60 key (484119 72 1330107) itemoff 15625 itemsize 8
[ 1716.050116]  item 61 key (484119 72 1330110) itemoff 15617 itemsize 8
[ 1716.050117]  item 62 key (484119 72 1330112) itemoff 15609 itemsize 8
[ 1716.050118]  item 63 key (484119 72 1330113) itemoff 15601 itemsize 8
[ 1716.050119]  item 64 key (484119 72 1330115) itemoff 15593 itemsize 8
[ 1716.050120]  item 65 key (484119 72 1330118) itemoff 15585 itemsize 8
[ 1716.050122]  item 66 key (484119 72 1330120) itemoff 15577 itemsize 8
[ 1716.050123]  item 67 key (484119 72 1330122) itemoff 15569 itemsize 8
[ 1716.050124]  item 68 key (484119 72 1330124) itemoff 15561 itemsize 8
[ 1716.050125]  item 69 key (484119 72 1330126) itemoff 15553 itemsize 8
[ 1716.050126]  item 70 key (484119 72 1330129) itemoff 15545 itemsize 8
[ 1716.050127]  item 71 key (484119 72 1330131) itemoff 15537 itemsize 8
[ 1716.050128]  item 72 key (484119 72 1330136) itemoff 15529 itemsize 8
[ 1716.050130]  item 73 key (484119 72 1330139) itemoff 15521 itemsize 8
[ 1716.050131]  item 74 key (484119 72 1330141) itemoff 15513 itemsize 8
[ 1716.050132]  item 75 key (484119 96 1330116) itemoff 15463 itemsize 50
[ 1716.050133]  item 76 key (484119 96 1330128) itemoff 15405 itemsize 58
[ 1716.050134]  item 77 key (484119 96 1330130) itemoff 15362 itemsize 43
[ 1716.050136]  item 78 key (484129 1 0) itemoff 15202 itemsize 160
[ 1716.050137]          inode generation 45 size 26214400 mode 100644
[ 1716.050138]  item 79 key (484129 108 589824) itemoff 15149 itemsize 53
[ 1716.050140]          extent data disk bytenr 10701807767552 nr 32768
[ 1716.050141]          extent data offset 0 nr 32768 ram 32768
[ 1716.050142]  item 80 key (484129 108 1310720) itemoff 15096 itemsize 53
[ 1716.050144]          extent data disk bytenr 10701808283648 nr 32768
[ 1716.050144]          extent data offset 0 nr 32768 ram 32768
[ 1716.050145]  item 81 key (484129 108 1769472) itemoff 15043 itemsize 53
[ 1716.050146]          extent data disk bytenr 10701828988928 nr 32768
[ 1716.050147]          extent data offset 0 nr 32768 ram 32768
[ 1716.050148]  item 82 key (484129 108 11763712) itemoff 14990 itemsize 53
[ 1716.050150]          extent data disk bytenr 10701830090752 nr 32768
[ 1716.050150]          extent data offset 0 nr 32768 ram 32768
[ 1716.050151]  item 83 key (484129 108 13139968) itemoff 14937 itemsize 53
[ 1716.050153]          extent data disk bytenr 10701269446656 nr 32768
[ 1716.050153]          extent data offset 0 nr 32768 ram 32768
[ 1716.050154]  item 84 key (484129 108 13467648) itemoff 14884 itemsize 53
[ 1716.050156]          extent data disk bytenr 10701904338944 nr 32768
[ 1716.050156]          extent data offset 0 nr 32768 ram 32768
[ 1716.050157]  item 85 key (484129 108 13795328) itemoff 14831 itemsize 53
[ 1716.050159]          extent data disk bytenr 10701904437248 nr 32768
[ 1716.050159]          extent data offset 0 nr 32768 ram 32768
[ 1716.050160]  item 86 key (484129 108 17694720) itemoff 14778 itemsize 53
[ 1716.050161]          extent data disk bytenr 10701806407680 nr 32768
[ 1716.050162]          extent data offset 0 nr 32768 ram 32768
[ 1716.050163]  item 87 key (484129 108 19726336) itemoff 14725 itemsize 53
[ 1716.050164]          extent data disk bytenr 10701806505984 nr 32768
[ 1716.050165]          extent data offset 0 nr 32768 ram 32768
[ 1716.050166]  item 88 key (484129 108 20185088) itemoff 14672 itemsize 53
[ 1716.050167]          extent data disk bytenr 10701806538752 nr 32768
[ 1716.050168]          extent data offset 0 nr 32768 ram 32768
[ 1716.050168]  item 89 key (484129 108 21168128) itemoff 14619 itemsize 53
[ 1716.050170]          extent data disk bytenr 10701807833088 nr 32768
[ 1716.050170]          extent data offset 0 nr 32768 ram 32768
[ 1716.050171]  item 90 key (484129 108 23396352) itemoff 14566 itemsize 53
[ 1716.050172]          extent data disk bytenr 10701807865856 nr 32768
[ 1716.050173]          extent data offset 0 nr 32768 ram 32768
[ 1716.050174]  item 91 key (484147 1 0) itemoff 14406 itemsize 160
[ 1716.050175]          inode generation 45 size 1096 mode 40755
[ 1716.050176]  item 92 key (484147 12 484145) itemoff 14393 itemsize 13
[ 1716.050177]  item 93 key (484147 72 4) itemoff 14385 itemsize 8
[ 1716.050179]  item 94 key (484147 72 27) itemoff 14377 itemsize 8
[ 1716.050180]  item 95 key (484147 72 35) itemoff 14369 itemsize 8
[ 1716.050181]  item 96 key (484147 72 40) itemoff 14361 itemsize 8
[ 1716.050183]  item 97 key (484147 72 45) itemoff 14353 itemsize 8
[ 1716.050184]  item 98 key (484147 72 52) itemoff 14345 itemsize 8
[ 1716.050185]  item 99 key (484147 72 61) itemoff 14337 itemsize 8
[ 1716.050186]  item 100 key (484147 72 65) itemoff 14329 itemsize 8
[ 1716.050187]  item 101 key (484147 72 88) itemoff 14321 itemsize 8
[ 1716.050189]  item 102 key (484147 72 92) itemoff 14313 itemsize 8
[ 1716.050190]  item 103 key (484147 72 350) itemoff 14305 itemsize 8
[ 1716.050192]  item 104 key (484147 72 351) itemoff 14297 itemsize 8
[ 1716.050193]  item 105 key (484147 72 352) itemoff 14289 itemsize 8
[ 1716.050194] BTRFS error (device sda2): batch items:
[ 1716.050195] BTRFS error (device sda2): item 0 index 1330094
[ 1716.050197] BTRFS error (device sda2): item 1 index 1330116
[ 1716.050198] BTRFS error (device sda2): item 2 index 1330127
[ 1716.050199] BTRFS error (device sda2): item 3 index 1330128
[ 1716.050200] BTRFS error (device sda2): item 4 index 1330130
[ 1716.050201] BTRFS error (device sda2): item 5 index 1330132

Thanks in advance,

David Arendt

