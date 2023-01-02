Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3430D65B841
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 00:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjABXjU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 18:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjABXjT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 18:39:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB7E23;
        Mon,  2 Jan 2023 15:39:17 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTRMs-1pOTub1Gg8-00TlCL; Tue, 03
 Jan 2023 00:39:02 +0100
Message-ID: <ac2f141b-b03a-6054-8250-d27a5b568027@gmx.com>
Date:   Tue, 3 Jan 2023 07:38:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: =?UTF-8?Q?Re=3a_=5bregression=5d_Bug=c2=a0216851_-_btrfs_write_time?=
 =?UTF-8?Q?_corrupting_for_log_tree?=
Content-Language: en-US
To:     dsterba@suse.cz, Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <ae169fc6-f504-28f0-a098-6fa6a4dfb612@leemhuis.info>
 <20230102154050.GJ11562@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230102154050.GJ11562@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:C/xZqsYrwkO00+tH8TXDJxEtU/9RN0MVaG7f4rNvdxT8culmiB5
 0z2qM+YuYL2YuVqZydVctrLsYc69XXRKoT1Ohoy6Loaf+mqd1cs1rpwqeaCBQLQH+45gBgH
 ZcDvZruq6uKuOWdKcnzMFAbuxUtJP2vjZ1uPOsydS76+hik6JQZAnCniFf0UKlXfHktU0Ha
 1oQAGNGaKoCim+s624/gA==
UI-OutboundReport: notjunk:1;M01:P0:YDJglJ+qY70=;f5EOxOUQdYGKw9VLrjwG0skcUIi
 zxRpcrLtSLvKsx/DQUDd1eAQ8ATPDYtqXe1OBm+zhPJPmNZ+7HXqzgKCvmfomOQhgxaQNCVs6
 AI2xAZhEavj5DPFJBUdbzaEnC8ltM1infogwOjOfW2Ke/OlqQeFpZQKxqwqt2Q159LJbw2BYp
 XXhu94NCRDXj9RqnmV8U0GjBEuLcbd0WApM4ziyW1i8ulL6HzONJAp1vlV0WCapWEesXWsbwD
 Rd0+i3N3K6/HbbqBkCfbxHer49qvMcIn+r7Tu2Yla/HlZDAC82n0FxVlhbSSrJAJiKY2qwuiK
 846rT2AbHUzwve2nTPB8U9PD7DpCp02C8RD0N+S4cfUacFZnEiyA3EHDvgBrttHmAPd0W3aY7
 mePEFh413n59sc8gmMe467euL014Nbsbr/230N7O9CpVzRR8YYo7BYBPDW6xQc0g+ihdioHpA
 bawzuRiW6t6/Twmr8PwAL7bUQtoDjmmGckp9gGM4C2oReXpCVEEesmz1ktLYbs3VKEF10ojvO
 vfZfvCGvBFj+8HMmZyung7+Am+fUpvUmwQDL2ufj9Aaoo7s9pV8Sgn99hbILSv8bAGm6efqPt
 3oSrB6iLThfehErqwlbaenthBy2i6Trq8SwM84sAVImEqCnnT5Z5CNYUUrI5MUSHfB6tE0h5m
 TXUcvPaO7EoWAJqEvYZLC4x37Yz3Y15r1AUG88cfyRxlzEkaFRGjF0y5GoB9FvyoPbCD37t0x
 uwgD8DLIcF+VTdWy1Ind5kdCBp2DUbfIIuvAVwtbI4yJAsl52RdK83oHEfoinyXAX8kCSmRXF
 t6MohXqssYMWZTdovMdHlt0eNXg2fjYjaSx+WD9A9flbzxsj4icpb7B2THLIA5tLBflJsITEF
 o0n+7RPd2GUqZxcQG453CZ0wdHxnvFJYNKC4rQOqo9tq2uhjwYMM+YhoLRrC58+sSOQvOylhc
 Qbo9R5KxfZRTLyYmNt6t0TMf6I4=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/2 23:40, David Sterba wrote:
> On Tue, Dec 27, 2022 at 03:01:34PM +0100, Thorsten Leemhuis wrote:
>> Hi, this is your Linux kernel regression tracker speaking.
>>
>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>> kernel developer don't keep an eye on it, I decided to forward it by
>> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216851 :
>>
>>> I am experiencing btrfs file system errors followed by a switch to readony with kernel 6.1 and 6.1.1. It never happened with kernel versions before.
>>>
>>> A btrfs scrub and a btrfs check --readonly returned 0 errors.
>>>
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS critical (device sda2): corrupt leaf: root=18446744073709551610 block=203366612992 slot=73, bad key order, prev (484119 96 1312873) current (484119 96 1312849)
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS info (device sda2): leaf 203366612992 gen 5068802 total ptrs 105 free space 10820 owner 18446744073709551610
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 0 key (484119 1 0) itemoff 16123 itemsize 160
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09inode generation 45 size 2250 mode 40700
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 1 key (484119 12 484118) itemoff 16097 itemsize 26
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 2 key (484119 72 15) itemoff 16089 itemsize 8
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 3 key (484119 72 20) itemoff 16081 itemsize 8
>>> ...
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 82 key (484119 96 1312873) itemoff 14665 itemsize 51
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 83 key (484119 96 1312877) itemoff 14609 itemsize 56
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 84 key (484128 1 0) itemoff 14449 itemsize 160
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09inode generation 45 size 98304 mode 100644
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 85 key (484128 108 0) itemoff 14396 itemsize 53
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data disk bytenr 10674830381056 nr 65536
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data offset 0 nr 65536 ram 65536
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 86 key (484129 1 0) itemoff 14236 itemsize 160
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09inode generation 45 size 26214400 mode 100644
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 87 key (484129 108 589824) itemoff 14183 itemsize 53
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data disk bytenr 10665699962880 nr 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data offset 0 nr 32768 ram 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 88 key (484129 108 2850816) itemoff 14130 itemsize 53
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data disk bytenr 10665848733696 nr 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data offset 0 nr 32768 ram 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 89 key (484129 108 11042816) itemoff 14077 itemsize 53
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data disk bytenr 10660869349376 nr 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data offset 0 nr 32768 ram 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 90 key (484129 108 13402112) itemoff 14024 itemsize 53
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data disk bytenr 10660207378432 nr 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data offset 0 nr 32768 ram 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 91 key (484129 108 19628032) itemoff 13971 itemsize 53
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data disk bytenr 10665835618304 nr 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data offset 0 nr 32768 ram 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 92 key (484129 108 21266432) itemoff 13918 itemsize 53
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data disk bytenr 10661222666240 nr 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data offset 0 nr 32768 ram 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 93 key (484129 108 22740992) itemoff 13865 itemsize 53
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data disk bytenr 10665565814784 nr 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data offset 0 nr 32768 ram 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 94 key (484129 108 23101440) itemoff 13812 itemsize 53
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data disk bytenr 10665836371968 nr 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data offset 0 nr 32768 ram 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 95 key (484129 108 24084480) itemoff 13759 itemsize 53
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data disk bytenr 10665836404736 nr 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data offset 0 nr 32768 ram 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 96 key (484129 108 24150016) itemoff 13706 itemsize 53
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data disk bytenr 10665849159680 nr 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data offset 0 nr 32768 ram 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 97 key (484129 108 24313856) itemoff 13653 itemsize 53
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data disk bytenr 10665849192448 nr 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent data offset 0 nr 32768 ram 32768
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 98 key (484147 1 0) itemoff 13493 itemsize 160
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09inode generation 45 size 886 mode 40755
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 99 key (484147 72 4) itemoff 13485 itemsize 8
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 100 key (484147 72 27) itemoff 13477 itemsize 8
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 101 key (484147 72 35) itemoff 13469 itemsize 8
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 102 key (484147 72 40) itemoff 13461 itemsize 8
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 103 key (484147 72 45) itemoff 13453 itemsize 8
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 104 key (484147 72 52) itemoff 13445 itemsize 8
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS error (device sda2): block=203366612992 write time tree block corruption detected
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS: error (device sda2: state AL) in free_log_tree:3284: errno=-5 IO failure
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS info (device sda2: state EAL): forced readonly
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS warning (device sda2: state EAL): Skipping commit of aborted transaction.
>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS: error (device sda2: state EAL) in cleanup_transaction:1958: errno=-5 IO failure
>>>
>>>
>>> There are no SSD access errors in the kernel logs. Smart data for the SSD is normal. I also did a 12 hour memtest to rule out bad RAM.
>>>
>>> The filesystem consists of a single 480GB SATA SSD (Corsair Neutron XTI). The problems occurs only on one machine.
>>>
>>> The error appears about every few days and seems to be triggered by a cspecially under high cpu utilization combined with some disk IO. CPU temperature never exceeds 60 degrees.
>>
>> See the ticket for more details.
>>
>> For the record, the issue is apparently different from the 6.2-rc
>> regression currently discussed, as stated here:
>> https://lore.kernel.org/lkml/462e7bd3-d1f2-3718-fde9-77b418e9fd91@gmx.com/
>>
>> BTW, let me use this mail to also add the report to the list of tracked
>> regressions to ensure it's doesn't fall through the cracks:
>>
>> #regzbot introduced: v6.0..v6.1
>> https://bugzilla.kernel.org/show_bug.cgi?id=216851
>> #regzbot title: btrfs: write time corrupting for log tree in 6.1
>> #regzbot ignore-activity
> 
> #regzbot fix: 'btrfs: fix false alert on bad tree level check'

Oh no, this is a different one, this one is not level mismatch.

Thanks,
Qu
