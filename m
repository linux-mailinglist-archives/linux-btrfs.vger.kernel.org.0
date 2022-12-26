Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9076560C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Dec 2022 08:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiLZHbs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Dec 2022 02:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLZHbr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Dec 2022 02:31:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5EF25EE;
        Sun, 25 Dec 2022 23:31:44 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M59GG-1pAnt232P6-00177D; Mon, 26
 Dec 2022 08:31:41 +0100
Message-ID: <462e7bd3-d1f2-3718-fde9-77b418e9fd91@gmx.com>
Date:   Mon, 26 Dec 2022 15:31:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Write time corrupting for log tree.
Content-Language: en-US
To:     David Arendt <admin@prnet.org>, Filipe Manana <fdmanana@gmail.com>
Cc:     wqu@suse.com, dsterba@suse.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
 <f68699c3-ec5e-d8e8-f101-6e9a7020ac81@gmx.com>
 <CABXGCsNrm3ddn3p_ECSRe+yQeoF3KojTFvy-CpXNzi9ADkbnvQ@mail.gmail.com>
 <18b5fa1e-7d1e-4560-c98b-d7ac5fc87c3a@gmx.com>
 <eaf71061-548d-59d1-b8a9-fa79fd0ed9b3@prnet.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <eaf71061-548d-59d1-b8a9-fa79fd0ed9b3@prnet.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UY1c9N/D8BUMalQxjwAoX1cKrUZd+LUIFNpjr3DySlHiSofRCrw
 8SWXgzvQ/2kRWGxoVe54QZW2d525C8yXH7lcv7u7oyCfKfo/3eJuhUOOdInhzx4N/rf/RrC
 dTl7skO4vXrmrbwqbotZ9Dtwu/3K3Xr1ltJ2L6LR8lCsjBoK2j8YA7YXj+L93zf8R1twVWE
 Sd9kjfOGKlmXTAHgrG3nQ==
UI-OutboundReport: notjunk:1;M01:P0:nsqJkTcA79I=;DHmYMVFaYFuokpizOBUKq6nxJCP
 2TaEJcL3+tqGOAczN2gym5mv7Ib8BrwTuLp2S5lK4LpJXESazUYi3ElNzwleR8vhiAIPdKdKU
 wN1/TK2vaC+0OnefN3uSqOpvnQQjs7pk+/qDx73XehWeJFbp6SMAs1lfg2BqVHwP8cTXP2euC
 ffAENKjtgT/aqiBxFq+fUnOCC0COMiEr4kr8aYMpYwbN6cv3t2UxUSZq+jGadFlZiGbjvpiDj
 lptEHM+UKMiwV5R2Dsxq5kb5CtaOssRz2BcNUvuRofM/9TWsqCky+5Q9EEV48HL0BQRNOeCTu
 /ddd7x2lo4B/u+07Un7jy426lOj2Sh6cgoJPlaRkvBXxk9nrKO97kTfz8OsVM7lPFk5a/Er2b
 NtYnVVb06PaM9jevE+/piVHvkHQhzxg1uT28gEgHI4G1b6Iftj7hKEuXf7+dvPw+eYjgzgu7U
 5+E6QzHpjOnUuVOm1pVCMaoABhy4cscA+KhN18uH3L2uzhMx2SLP3kYUH1xTqmK2W4Xzf+bGW
 +ckcNNtVbEZ4+clx3SLaqlLwtpPA9OscG7hENDfzivUbk3GiKJLx0bDTq8NC9OG/ZpzKWgLRp
 OQHlvxgPu8SpgD23owdF0GA0z+Wj3ddJW8IP1aBbydRxBjhvi6xtMPzySKMUW4PXb606f4wO+
 d2GTIaCCakMqc+Zd/yOZxVMaolcyozkSZhKBIfFSr7o0s5PtVRDSTyOcxVloPCOYm4aACvVIP
 Q66x5YQjODN0gH/Ni4k5Sq8UOUyEkFrCIN9wULbInDwjmwMgFupKXpi4OQG2cVSMVB2ktMwgE
 +8IgPD+FWm4yR36k97aqPyDUbZYdrW02uDYAmPhFAfnZqVy8KZhCpameE0gNjMW1/+1P1dhqd
 t/qgJJOWCVbZSdnrn7gUD0BTpOPcMP+e7lKnNt0DmXe4rRpXfZe6QloBdhyRc6vHLtn6jL9N2
 AZGrPTtz8bkRjABtMkf5nWQK+Fc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/26 15:25, David Arendt wrote:
> Hi,
> 
> I am experiencing I similiar issue using kernel 6.1.1. The problem has 
> started in kernel 6.1. It never happend before.

6.1 kernel doesn't have that commit at all.

> 
> A btrfs scrub and a btrfs check --readonly returned 0 errors.
> 
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS critical 
> (device sda2): corrupt leaf: root=18446744073709551610 
> block=203366612992 slot=73, bad key order, prev (484119 96 1312873) 
> current (484119 96 1312849)
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS info 
> (device sda2): leaf 203366612992 gen 5068802 total ptrs 105 free space 
> 10820 owner 18446744073709551610
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 0 key 
> (484119 1 0) itemoff 16123 itemsize 160
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09inode 
> generation 45 size 2250 mode 40700
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 1 key 
> (484119 12 484118) itemoff 16097 itemsize 26
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 2 key 
> (484119 72 15) itemoff 16089 itemsize 8
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 3 key 
> (484119 72 20) itemoff 16081 itemsize 8
> ...
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 82 key 
> (484119 96 1312873) itemoff 14665 itemsize 51
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 83 key 
> (484119 96 1312877) itemoff 14609 itemsize 56
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 84 key 
> (484128 1 0) itemoff 14449 itemsize 160
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09inode 
> generation 45 size 98304 mode 100644
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 85 key 
> (484128 108 0) itemoff 14396 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data disk bytenr 10674830381056 nr 65536
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data offset 0 nr 65536 ram 65536
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 86 key 
> (484129 1 0) itemoff 14236 itemsize 160
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09inode 
> generation 45 size 26214400 mode 100644
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 87 key 
> (484129 108 589824) itemoff 14183 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data disk bytenr 10665699962880 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 88 key 
> (484129 108 2850816) itemoff 14130 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data disk bytenr 10665848733696 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 89 key 
> (484129 108 11042816) itemoff 14077 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data disk bytenr 10660869349376 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 90 key 
> (484129 108 13402112) itemoff 14024 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data disk bytenr 10660207378432 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 91 key 
> (484129 108 19628032) itemoff 13971 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data disk bytenr 10665835618304 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 92 key 
> (484129 108 21266432) itemoff 13918 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data disk bytenr 10661222666240 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 93 key 
> (484129 108 22740992) itemoff 13865 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data disk bytenr 10665565814784 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 94 key 
> (484129 108 23101440) itemoff 13812 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data disk bytenr 10665836371968 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 95 key 
> (484129 108 24084480) itemoff 13759 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data disk bytenr 10665836404736 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 96 key 
> (484129 108 24150016) itemoff 13706 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data disk bytenr 10665849159680 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 97 key 
> (484129 108 24313856) itemoff 13653 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data disk bytenr 10665849192448 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent 
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 98 key 
> (484147 1 0) itemoff 13493 itemsize 160
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09inode 
> generation 45 size 886 mode 40755
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 99 key 
> (484147 72 4) itemoff 13485 itemsize 8
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 100 key 
> (484147 72 27) itemoff 13477 itemsize 8
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 101 key 
> (484147 72 35) itemoff 13469 itemsize 8
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 102 key 
> (484147 72 40) itemoff 13461 itemsize 8
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 103 key 
> (484147 72 45) itemoff 13453 itemsize 8
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 104 key 
> (484147 72 52) itemoff 13445 itemsize 8
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS error 
> (device sda2): block=203366612992 write time tree block corruption detected

And this is completely different problem from the original report.

Better to do a separate report, as the problem the original reporter is 
a purely read time error.

Furthermore, the corrupted tree block belongs to log tree, thus really 
think it's a different problem.

Adding Filipe as he is the expert on log tree.

Thanks,
Qu

> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS: error 
> (device sda2: state AL) in free_log_tree:3284: errno=-5 IO failure
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS info 
> (device sda2: state EAL): forced readonly
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS warning 
> (device sda2: state EAL): Skipping commit of aborted transaction.
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS: error 
> (device sda2: state EAL) in cleanup_transaction:1958: errno=-5 IO failure
> 
> 
> There are no SSD access errors in the kernel logs. Smart data for the 
> SSD is normal. I also did a 12 hour memtest to rule out bad RAM.
> 
> The filesystem consists of a single 480GB SATA SSD (Corsair Neutron 
> XTI). Like for the original poster, the problems occurs only on one 
> machine.
> 
> The error appears about every few days and seems to be triggered by a 
> combination specially under high cpu utilization combined with some disk 
> IO. CPU temperature never exceeds 60 degrees.
> 
> 
> On 26/12/2022 04:29, Qu Wenruo wrote:
>>
>>
>> On 2022/12/26 10:47, Mikhail Gavrilov wrote:
>>> On Mon, Dec 26, 2022 at 5:15 AM Qu Wenruo <quwenruo.btrfs@gmx.com> 
>>> wrote:
>>>>
>>>> Thanks a lot for the full kernel log.
>>>>
>>>> It indeed shows something is wrong in the run_one_delayed_ref().
>>>> But surprisingly, if there is something wrong, I'd expect more output
>>>> from btrfs, as normally if one tree block failed to pass whatever the
>>>> checks, it should cause an error message at least.
>>>>
>>>> Since you can reproduce the bug (although I don't think this is easy to
>>>> reproduce), mind to apply the extra debug patch and then try to 
>>>> reproduce?
>>>
>>> Of course I am still able to reproduce.
>>> The number of messages foreshadowing readonly has become somewhat more:
>>> [ 2295.155437] BTRFS error (device nvme0n1p3): level check failed on
>>> logical 4957418700800 mirror 1 wanted 0 found 1
>>
>> OK, indeed a level mismatch.
>>
>> From the remaining lines, it shows we're failing at 
>> do_free_extent_accounting(), which failed at the btrfs_del_csums().
>>
>> And inside btrfs_del_csums(), what we do are all regular btree 
>> operations, thus the tree level check should work without problem.
>>
>> Thus it seems to be a corrupted csum tree.
>>
>>> [ 2295.155831] BTRFS error (device nvme0n1p3: state A): Transaction
>>> aborted (error -5)
>>> [ 2295.155946] BTRFS: error (device nvme0n1p3: state A) in
>>> do_free_extent_accounting:2849: errno=-5 IO failure
>>> [ 2295.155978] BTRFS info (device nvme0n1p3: state EA): forced readonly
>>> [ 2295.155985] BTRFS error (device nvme0n1p3: state EA):
>>> run_one_delayed_ref returned -5
>>> [ 2295.156051] BTRFS: error (device nvme0n1p3: state EA) in
>>> btrfs_run_delayed_refs:2153: errno=-5 IO failure
>>>
>>> Of course full logs are also attached.
>>>
>>>> Another thing is, mind to run "btrfs check --readonly" on the fs?
>>> Result of check attached too.
>>>
>> Could you please run "btrfs check --readonly" from a liveCD?
>> There are tons of possible false alerts if ran on a RW mounted fs.
>>
>> Thanks,
>> Qu
> 
> 
