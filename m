Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E4067F26A
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jan 2023 00:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjA0Xuz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 18:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjA0Xuy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 18:50:54 -0500
Received: from fallback16.mail.ru (fallback16.mail.ru [94.100.177.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C3088CF5
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 15:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=BvY2Ye4t6VHLELPaLG9FyHM1qyq2gE/4Shm6gZe02kc=;
        t=1674863448;x=1674953448; 
        b=Sq1hC+2x0X4NbtuXLX5QlEL7mAV3Eu3lNKoflckLJvIcW+lK4xF547TRa2+igcx0YxfflmHphJ5DWjZ+4Z70H7MsQSZopXkBR1m5+gIKDUnUQTu571DHLRHcXw4ADhT7YQmhPD4WiEFJqGl4AG2OmGIyUQnzAyBS8wY8AwLWBDuSxWL3frAIgqJgK23e0+tp2Iq1IoLgMsdL5PdHLNLk7UroifjdKuhTsZfIH8XFrUQeaDBWes5IX1UGRL5iMhr6Ow8lyeOayZBx2p7hdoKtFlophadF15Mx5FE79qkdu10Q2BoPu8trUm5WxUhUok5iRrVeU9sv7/1mQI+LrBIIdw==;
Received: from [10.161.22.27] (port=37160 helo=smtp57.i.mail.ru)
        by fallback16.i with esmtp (envelope-from <Nemcev_Aleksey@inbox.ru>)
        id 1pLYUY-0007Mb-Le
        for linux-btrfs@vger.kernel.org; Sat, 28 Jan 2023 02:50:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=BvY2Ye4t6VHLELPaLG9FyHM1qyq2gE/4Shm6gZe02kc=;
        t=1674863446;x=1674953446; 
        b=ai6/PruKgi3Ls/rUFQ+ttXOUNyIC597eUIZaj2ZMZdSoxvV/KGYJyLpRuFeP0coPXWGThy+AiFFYXW3ftbSBfskfCOqrLXep2rM99qgmiGYJAHYgs+fYIlsF9cOIyib0CYFqMpx1yvtejhYJd84v1P0pfQuM3f5nRhvgKIxKHiNt0H/sv0Wd9wCCU3CNR+zwmMFdGQOVzyb/1KbU7SOC690Pbo++4iD2bVp6m5sPgGqSUpIfuXJk6BkTy0TzBoZ22sDZpNueFKGGC8aqKQJip30U8JT8dznR3YJZzYCN9WQDbbhBpbcbiBgw5xlL2l7XfLpuHHg9e2OmD4GWl62H5w==;
Received: by smtp57.i.mail.ru with esmtpa (envelope-from <Nemcev_Aleksey@inbox.ru>)
        id 1pLYUV-0002go-KN
        for linux-btrfs@vger.kernel.org; Sat, 28 Jan 2023 02:50:44 +0300
Message-ID: <427ae065-988d-8a3d-e4f6-af60b676f695@inbox.ru>
Date:   Sat, 28 Jan 2023 02:50:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Nemcev Aleksey <Nemcev_Aleksey@inbox.ru>
Subject: BTRFS hangs on USB SSD with kernel 6.1.7-1-MANJARO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD939F4CB9F411D0C0472CE2DC3ADD5D4C35919768B1C782977182A05F53808504073BACA191E1A0EC17B5E90D9C0134B522BCCC31C2585BA5D29AB2679BA14D677
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75BDEF5A3674FD449EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D58A1C8964E53F0E8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D82D295C9C1C2884DBD0D5849D1024484A6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7E4DF6D1C10F22F599FA2833FD35BB23D9E625A9149C048EE902A1BE408319B292CC0D3CB04F14752D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BB816BE3345416868389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637B87A4010CF3FD00ED81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636D81D268191BDAD3D78DA827A17800CE7BEA50CE3F70B38CACD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B61E7D461CEF46D50775ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A52855A8D811E490C39F5790D836B7ED3912A5AC427179071B4EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D346B71C4B0698719D74E255F5F66436EDCA7790D72B339BB35871358E22E3925B71F543AB84F626DDE1D7E09C32AA3244CA0BB72879D40DE0CA131E81B22A3DA5269B6CAE0477E908D3EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojF3ARSjuaUAJ6jmleh6R9mw==
X-Mailru-Sender: 00097D31F91C944B2C6B234B040A1F9D5E5891A441C6524A7B5E90D9C0134B52A0970A890641089B937B03147C9FB1C7DDBB79867CC2C1EC8FBF9CDAF219B22883CE97D6EC8C31C50E14EF3F621F2B87C77752E0C033A69E3453F38A29522196
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B49D0DB769823A2E33E8C7DEFE9388D8BE79269FE8F5B0D124B647ED114AB003AC0CD88DABC72C73183E2AF7FF73DB52663B54E6C843C5A14196479AA81113B879
X-7FA49CB5: 0D63561A33F958A5A42B1C8D924B6B3E8448F7DAAE163191A7E690258DAA1213CACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdXAer6iYXgmz621v7gO/17Q==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I'm running Manjaro with kernel 6.1.7-1-MANJARO and using bees to 
deduplicate the BTRFS on external SSD (Samsunt T7 1TB(.
I had two kernel hangups during this - each time when bees is almost 
finished its work.

Those hangups have the following dmesg log entries:
```
[54804.671287] INFO: task crawl_5:322766 blocked for more than 122 seconds.
[54804.671294]       Tainted: P           OE      6.1.7-1-MANJARO #1
[54804.671296] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[54804.671298] task:crawl_5         state:D stack:0     pid:322766 
ppid:1      flags:0x00000002
[54804.671303] Call Trace:
[54804.671305]  <TASK>
[54804.671309]  __schedule+0x370/0x12a0
[54804.671319]  schedule+0x5e/0xd0
[54804.671325]  wait_current_trans+0xf0/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.671397]  ? sugov_start+0x150/0x150
[54804.671403]  start_transaction+0x341/0x5b0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.671464]  ? btrfs_scrub_progress+0x160/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.671542]  iterate_extent_inodes+0xab/0x370 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.671620]  ? btrfs_previous_extent_item+0xb2/0x120 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.671677]  ? iterate_inodes_from_logical+0xb8/0xf0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.671752]  iterate_inodes_from_logical+0xb8/0xf0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.671829]  btrfs_ioctl_logical_to_ino+0x105/0x170 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.671901]  __x64_sys_ioctl+0x91/0xd0
[54804.671908]  do_syscall_64+0x5c/0x90
[54804.671911]  ? __x64_sys_futex+0x92/0x1d0
[54804.671917]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.671922]  ? do_syscall_64+0x6b/0x90
[54804.671924]  ? do_syscall_64+0x6b/0x90
[54804.671927]  ? do_syscall_64+0x6b/0x90
[54804.671929]  ? exit_to_user_mode_prepare+0x16f/0x1d0
[54804.671933]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.671937]  ? do_syscall_64+0x6b/0x90
[54804.671939]  ? do_syscall_64+0x6b/0x90
[54804.671942]  ? do_syscall_64+0x6b/0x90
[54804.671944]  ? do_syscall_64+0x6b/0x90
[54804.671947]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[54804.671952] RIP: 0033:0x7f6c01315ecf
[54804.671980] RSP: 002b:00007f6c012143b0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[54804.671985] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 
00007f6c01315ecf
[54804.671988] RDX: 00007f6c012147b8 RSI: 00000000c038943b RDI: 
0000000000000003
[54804.671990] RBP: 00007f6c012147b0 R08: 000000000004ecce R09: 
000055d8a76d8428
[54804.671992] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007f6c012147b8
[54804.671994] R13: 00007f6c01214638 R14: 00007f6c01214760 R15: 
00007f6c012147b0
[54804.671999]  </TASK>
[54804.672001] INFO: task crawl_5:322768 blocked for more than 122 seconds.
[54804.672004]       Tainted: P           OE      6.1.7-1-MANJARO #1
[54804.672006] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[54804.672007] task:crawl_5         state:D stack:0     pid:322768 
ppid:1      flags:0x00000002
[54804.672011] Call Trace:
[54804.672013]  <TASK>
[54804.672015]  __schedule+0x370/0x12a0
[54804.672022]  schedule+0x5e/0xd0
[54804.672025]  wait_current_trans+0xf0/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.672085]  ? sugov_start+0x150/0x150
[54804.672089]  start_transaction+0x341/0x5b0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.672149]  ? btrfs_scrub_progress+0x160/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.672224]  iterate_extent_inodes+0xab/0x370 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.672300]  ? btrfs_previous_extent_item+0xb2/0x120 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.672356]  ? iterate_inodes_from_logical+0xb8/0xf0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.672430]  iterate_inodes_from_logical+0xb8/0xf0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.672506]  btrfs_ioctl_logical_to_ino+0x105/0x170 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.672577]  __x64_sys_ioctl+0x91/0xd0
[54804.672582]  do_syscall_64+0x5c/0x90
[54804.672586]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.672590]  ? do_syscall_64+0x6b/0x90
[54804.672594]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.672597]  ? do_syscall_64+0x6b/0x90
[54804.672600]  ? do_syscall_64+0x6b/0x90
[54804.672602]  ? do_syscall_64+0x6b/0x90
[54804.672605]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[54804.672610] RIP: 0033:0x7f6c01315ecf
[54804.672618] RSP: 002b:00007f6c002123b0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[54804.672622] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 
00007f6c01315ecf
[54804.672624] RDX: 00007f6c002127b8 RSI: 00000000c038943b RDI: 
0000000000000003
[54804.672626] RBP: 00007f6c002127b0 R08: 000000000004ecd0 R09: 
000055d8a76d8428
[54804.672628] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007f6c002127b8
[54804.672630] R13: 00007f6c00212638 R14: 00007f6c00212760 R15: 
00007f6c002127b0
[54804.672634]  </TASK>
[54804.672636] INFO: task crawl_5:322769 blocked for more than 122 seconds.
[54804.672638]       Tainted: P           OE      6.1.7-1-MANJARO #1
[54804.672640] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[54804.672642] task:crawl_5         state:D stack:0     pid:322769 
ppid:1      flags:0x00000002
[54804.672645] Call Trace:
[54804.672647]  <TASK>
[54804.672649]  __schedule+0x370/0x12a0
[54804.672653]  ? btrfs_read_extent_buffer+0xd4/0x120 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.672710]  ? __check_object_size+0x6e/0x210
[54804.672715]  ? copy_to_user_nofault+0x77/0xa0
[54804.672720]  schedule+0x5e/0xd0
[54804.672723]  rwsem_down_write_slowpath+0x336/0x720
[54804.672729]  ? kmem_cache_free+0x19/0x360
[54804.672735]  lock_two_nondirectories+0x92/0xc0
[54804.672740]  btrfs_remap_file_range+0x5a/0x560 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.672818]  ? security_capable+0x41/0x70
[54804.672822]  vfs_dedupe_file_range_one+0x16a/0x200
[54804.672828]  vfs_dedupe_file_range+0x18d/0x200
[54804.672833]  do_vfs_ioctl+0x6ba/0x930
[54804.672839]  __x64_sys_ioctl+0x72/0xd0
[54804.672843]  do_syscall_64+0x5c/0x90
[54804.672846]  ? __x64_sys_futex+0x92/0x1d0
[54804.672851]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.672855]  ? do_syscall_64+0x6b/0x90
[54804.672858]  ? do_syscall_64+0x6b/0x90
[54804.672860]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.672864]  ? do_syscall_64+0x6b/0x90
[54804.672866]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[54804.672871] RIP: 0033:0x7f6c01315ecf
[54804.672879] RSP: 002b:00007f6bffa111a0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[54804.672882] RAX: ffffffffffffffda RBX: 00007f6bffa114d0 RCX: 
00007f6c01315ecf
[54804.672884] RDX: 00007f6be81a20d0 RSI: 00000000c0189436 RDI: 
0000000000000006
[54804.672886] RBP: 00007f6be81a20d0 R08: 0000000000000000 R09: 
0000000000000000
[54804.672888] R10: 00007ffeabf64080 R11: 0000000000000246 R12: 
00007f6c015b074f
[54804.672890] R13: 0000000000000001 R14: 00007f6be818bcf0 R15: 
0000000000000001
[54804.672895]  </TASK>
[54804.672896] INFO: task crawl_5:322770 blocked for more than 122 seconds.
[54804.672898]       Tainted: P           OE      6.1.7-1-MANJARO #1
[54804.672900] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[54804.672901] task:crawl_5         state:D stack:0     pid:322770 
ppid:1      flags:0x00000002
[54804.672905] Call Trace:
[54804.672906]  <TASK>
[54804.672909]  __schedule+0x370/0x12a0
[54804.672915]  schedule+0x5e/0xd0
[54804.672918]  wait_current_trans+0xf0/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.672978]  ? sugov_start+0x150/0x150
[54804.672982]  start_transaction+0x341/0x5b0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.673042]  ? btrfs_scrub_progress+0x160/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.673117]  iterate_extent_inodes+0xab/0x370 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.673193]  ? btrfs_previous_extent_item+0xb2/0x120 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.673249]  ? iterate_inodes_from_logical+0xb8/0xf0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.673326]  iterate_inodes_from_logical+0xb8/0xf0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.673421]  btrfs_ioctl_logical_to_ino+0x105/0x170 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.673489]  __x64_sys_ioctl+0x91/0xd0
[54804.673494]  do_syscall_64+0x5c/0x90
[54804.673499]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.673503]  ? do_syscall_64+0x6b/0x90
[54804.673506]  ? do_syscall_64+0x6b/0x90
[54804.673509]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[54804.673513] RIP: 0033:0x7f6c01315ecf
[54804.673522] RSP: 002b:00007f6bff2103b0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[54804.673525] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 
00007f6c01315ecf
[54804.673527] RDX: 00007f6bff2107b8 RSI: 00000000c038943b RDI: 
0000000000000003
[54804.673529] RBP: 00007f6bff2107b0 R08: 000000000004ecd2 R09: 
000055d8a76d8428
[54804.673531] R10: 00007f6b98052080 R11: 0000000000000246 R12: 
00007f6bff2107b8
[54804.673533] R13: 00007f6bff210638 R14: 00007f6bff210760 R15: 
00007f6bff2107b0
[54804.673538]  </TASK>
[54804.673540] INFO: task crawl_5:322773 blocked for more than 122 seconds.
[54804.673542]       Tainted: P           OE      6.1.7-1-MANJARO #1
[54804.673544] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[54804.673545] task:crawl_5         state:D stack:0     pid:322773 
ppid:1      flags:0x00000002
[54804.673549] Call Trace:
[54804.673550]  <TASK>
[54804.673553]  __schedule+0x370/0x12a0
[54804.673557]  ? release_extent_buffer+0x99/0xb0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.673622]  schedule+0x5e/0xd0
[54804.673625]  rwsem_down_write_slowpath+0x336/0x720
[54804.673632]  lock_two_nondirectories+0x92/0xc0
[54804.673637]  btrfs_remap_file_range+0x5a/0x560 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.673708]  ? security_capable+0x41/0x70
[54804.673712]  vfs_dedupe_file_range_one+0x16a/0x200
[54804.673717]  vfs_dedupe_file_range+0x18d/0x200
[54804.673721]  do_vfs_ioctl+0x6ba/0x930
[54804.673727]  __x64_sys_ioctl+0x72/0xd0
[54804.673732]  do_syscall_64+0x5c/0x90
[54804.673735]  ? do_syscall_64+0x6b/0x90
[54804.673738]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.673742]  ? do_syscall_64+0x6b/0x90
[54804.673744]  ? do_syscall_64+0x6b/0x90
[54804.673746]  ? do_syscall_64+0x6b/0x90
[54804.673749]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[54804.673754] RIP: 0033:0x7f6c01315ecf
[54804.673762] RSP: 002b:00007f6bfda0d1a0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[54804.673765] RAX: ffffffffffffffda RBX: 00007f6bfda0d4d0 RCX: 
00007f6c01315ecf
[54804.673767] RDX: 00007f6b900c2c30 RSI: 00000000c0189436 RDI: 
0000000000000006
[54804.673769] RBP: 00007f6b900c2c30 R08: 0000000000000000 R09: 
0000000000000000
[54804.673770] R10: 00007ffeabf64080 R11: 0000000000000246 R12: 
00007f6c015b074f
[54804.673772] R13: 0000000000000001 R14: 00007f6b880e24f0 R15: 
0000000000000001
[54804.673777]  </TASK>
[54804.673778] INFO: task crawl_5:322774 blocked for more than 122 seconds.
[54804.673780]       Tainted: P           OE      6.1.7-1-MANJARO #1
[54804.673782] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[54804.673783] task:crawl_5         state:D stack:0     pid:322774 
ppid:1      flags:0x00000002
[54804.673787] Call Trace:
[54804.673788]  <TASK>
[54804.673790]  __schedule+0x370/0x12a0
[54804.673794]  ? update_load_avg+0x7e/0x780
[54804.673801]  schedule+0x5e/0xd0
[54804.673804]  rwsem_down_write_slowpath+0x336/0x720
[54804.673807]  ? psi_task_switch+0xd6/0x230
[54804.673812]  ? __switch_to_asm+0x3e/0x60
[54804.673820]  btrfs_inode_lock+0x40/0x70 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.673878]  btrfs_remap_file_range+0x3c3/0x560 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.673950]  ? security_capable+0x41/0x70
[54804.673954]  vfs_dedupe_file_range_one+0x16a/0x200
[54804.673959]  vfs_dedupe_file_range+0x18d/0x200
[54804.673963]  do_vfs_ioctl+0x6ba/0x930
[54804.673969]  __x64_sys_ioctl+0x72/0xd0
[54804.673973]  do_syscall_64+0x5c/0x90
[54804.673977]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.673981]  ? do_syscall_64+0x6b/0x90
[54804.673983]  ? do_syscall_64+0x6b/0x90
[54804.673986]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.673990]  ? do_syscall_64+0x6b/0x90
[54804.673993]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[54804.673997] RIP: 0033:0x7f6c01315ecf
[54804.674005] RSP: 002b:00007f6bfd20c1a0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[54804.674008] RAX: ffffffffffffffda RBX: 00007f6bfd20c4d0 RCX: 
00007f6c01315ecf
[54804.674010] RDX: 00007f6b942587b0 RSI: 00000000c0189436 RDI: 
0000000000000016
[54804.674012] RBP: 00007f6b942587b0 R08: 0000000000000000 R09: 
0000000000000000
[54804.674014] R10: 00007ffeabf64080 R11: 0000000000000246 R12: 
00007f6c015b074f
[54804.674015] R13: 0000000000000001 R14: 00007f6b9403cb50 R15: 
0000000000000001
[54804.674020]  </TASK>
[54804.674022] INFO: task crawl_5:322775 blocked for more than 122 seconds.
[54804.674023]       Tainted: P           OE      6.1.7-1-MANJARO #1
[54804.674025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[54804.674026] task:crawl_5         state:D stack:0     pid:322775 
ppid:1      flags:0x00000002
[54804.674029] Call Trace:
[54804.674031]  <TASK>
[54804.674033]  __schedule+0x370/0x12a0
[54804.674039]  schedule+0x5e/0xd0
[54804.674042]  wait_current_trans+0xf0/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.674099]  ? sugov_start+0x150/0x150
[54804.674103]  start_transaction+0x253/0x5b0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.674160]  btrfs_replace_file_extents+0x119/0x7c0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.674221]  ? btrfs_search_slot+0x89a/0xc90 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.674274]  btrfs_clone+0x767/0x830 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.674350]  btrfs_extent_same_range+0x6e/0xb0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.674433]  btrfs_remap_file_range+0x489/0x560 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.674505]  vfs_dedupe_file_range_one+0x16a/0x200
[54804.674511]  vfs_dedupe_file_range+0x18d/0x200
[54804.674515]  do_vfs_ioctl+0x6ba/0x930
[54804.674521]  __x64_sys_ioctl+0x72/0xd0
[54804.674526]  do_syscall_64+0x5c/0x90
[54804.674529]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.674533]  ? do_syscall_64+0x6b/0x90
[54804.674535]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.674539]  ? do_syscall_64+0x6b/0x90
[54804.674542]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[54804.674546] RIP: 0033:0x7f6c01315ecf
[54804.674555] RSP: 002b:00007f6bfca0b1a0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[54804.674557] RAX: ffffffffffffffda RBX: 00007f6bfca0b4d0 RCX: 
00007f6c01315ecf
[54804.674559] RDX: 00007f6b8c313000 RSI: 00000000c0189436 RDI: 
0000000000000006
[54804.674561] RBP: 00007f6b8c313000 R08: 0000000000000000 R09: 
0000000000000000
[54804.674563] R10: 00007ffeabf64080 R11: 0000000000000246 R12: 
00007f6c015b074f
[54804.674565] R13: 0000000000000001 R14: 00007f6b8c0972b0 R15: 
0000000000000001
[54804.674569]  </TASK>
[54804.674571] INFO: task crawl_5:322776 blocked for more than 122 seconds.
[54804.674573]       Tainted: P           OE      6.1.7-1-MANJARO #1
[54804.674575] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[54804.674576] task:crawl_5         state:D stack:0     pid:322776 
ppid:1      flags:0x00000002
[54804.674579] Call Trace:
[54804.674581]  <TASK>
[54804.674583]  __schedule+0x370/0x12a0
[54804.674589]  schedule+0x5e/0xd0
[54804.674592]  wait_current_trans+0xf0/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.674649]  ? sugov_start+0x150/0x150
[54804.674654]  start_transaction+0x341/0x5b0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.674710]  ? btrfs_scrub_progress+0x160/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.674781]  iterate_extent_inodes+0xab/0x370 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.674852]  ? btrfs_previous_extent_item+0xb2/0x120 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.674906]  ? iterate_inodes_from_logical+0xb8/0xf0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.674975]  iterate_inodes_from_logical+0xb8/0xf0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.675047]  btrfs_ioctl_logical_to_ino+0x105/0x170 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.675114]  __x64_sys_ioctl+0x91/0xd0
[54804.675119]  do_syscall_64+0x5c/0x90
[54804.675123]  ? do_futex+0xde/0x1b0
[54804.675127]  ? __x64_sys_futex+0x92/0x1d0
[54804.675132]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.675136]  ? do_syscall_64+0x6b/0x90
[54804.675138]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.675142]  ? do_syscall_64+0x6b/0x90
[54804.675145]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[54804.675150] RIP: 0033:0x7f6c01315ecf
[54804.675157] RSP: 002b:00007f6bfc20a3b0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[54804.675160] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 
00007f6c01315ecf
[54804.675162] RDX: 00007f6bfc20a7b8 RSI: 00000000c038943b RDI: 
0000000000000003
[54804.675164] RBP: 00007f6bfc20a7b0 R08: 000000000004ecd8 R09: 
000055d8a76d8428
[54804.675166] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007f6bfc20a7b8
[54804.675168] R13: 00007f6bfc20a638 R14: 00007f6bfc20a760 R15: 
00007f6bfc20a7b0
[54804.675172]  </TASK>
[54804.675174] INFO: task crawl_5:322777 blocked for more than 122 seconds.
[54804.675176]       Tainted: P           OE      6.1.7-1-MANJARO #1
[54804.675177] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[54804.675179] task:crawl_5         state:D stack:0     pid:322777 
ppid:1      flags:0x00000002
[54804.675182] Call Trace:
[54804.675183]  <TASK>
[54804.675185]  __schedule+0x370/0x12a0
[54804.675191]  schedule+0x5e/0xd0
[54804.675194]  wait_current_trans+0xf0/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.675251]  ? sugov_start+0x150/0x150
[54804.675255]  start_transaction+0x341/0x5b0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.675311]  ? btrfs_scrub_progress+0x160/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.675382]  iterate_extent_inodes+0xab/0x370 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.675452]  ? btrfs_previous_extent_item+0xb2/0x120 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.675506]  ? iterate_inodes_from_logical+0xb8/0xf0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.675575]  iterate_inodes_from_logical+0xb8/0xf0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.675647]  btrfs_ioctl_logical_to_ino+0x105/0x170 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.675714]  __x64_sys_ioctl+0x91/0xd0
[54804.675719]  do_syscall_64+0x5c/0x90
[54804.675723]  ? __seccomp_filter+0x32a/0x4e0
[54804.675729]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.675733]  ? do_syscall_64+0x6b/0x90
[54804.675736]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[54804.675741] RIP: 0033:0x7f6c01315ecf
[54804.675748] RSP: 002b:00007f6bfba09050 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[54804.675751] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 
00007f6c01315ecf
[54804.675753] RDX: 00007f6bfba09458 RSI: 00000000c038943b RDI: 
0000000000000003
[54804.675754] RBP: 00007f6bfba09450 R08: 000000000004ecd9 R09: 
000055d8a76d8428
[54804.675756] R10: 00007f6b84000de0 R11: 0000000000000246 R12: 
00007f6bfba09458
[54804.675758] R13: 00007f6bfba092d8 R14: 00007f6bfba09400 R15: 
00007f6bfba09450
[54804.675763]  </TASK>
[54804.675764] INFO: task crawl_5:322778 blocked for more than 122 seconds.
[54804.675766]       Tainted: P           OE      6.1.7-1-MANJARO #1
[54804.675768] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[54804.675769] task:crawl_5         state:D stack:0     pid:322778 
ppid:1      flags:0x00000002
[54804.675772] Call Trace:
[54804.675773]  <TASK>
[54804.675776]  __schedule+0x370/0x12a0
[54804.675780]  ? __clear_extent_bit+0x13a/0x480 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.675850]  schedule+0x5e/0xd0
[54804.675853]  wait_current_trans+0xf0/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.675909]  ? sugov_start+0x150/0x150
[54804.675914]  start_transaction+0x253/0x5b0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.675971]  btrfs_setattr+0x530/0x8d0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
[54804.676029]  ? path_init+0x35c/0x3c0
[54804.676033]  ? terminate_walk+0x61/0x100
[54804.676038]  ? filename_lookup+0xe8/0x1f0
[54804.676042]  notify_change+0x292/0x5b0
[54804.676048]  ? do_truncate+0x95/0xe0
[54804.676052]  do_truncate+0x95/0xe0
[54804.676058]  do_sys_ftruncate+0x154/0x1a0
[54804.676063]  do_syscall_64+0x5c/0x90
[54804.676068]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.676072]  ? do_syscall_64+0x6b/0x90
[54804.676075]  ? syscall_exit_to_user_mode+0x1b/0x40
[54804.676079]  ? do_syscall_64+0x6b/0x90
[54804.676081]  ? do_syscall_64+0x6b/0x90
[54804.676084]  ? do_syscall_64+0x6b/0x90
[54804.676086]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[54804.676091] RIP: 0033:0x7f6c013182cb
[54804.676099] RSP: 002b:00007f6bfb208aa8 EFLAGS: 00000202 ORIG_RAX: 
000000000000004d
[54804.676102] RAX: ffffffffffffffda RBX: 00007f6bfb208ac0 RCX: 
00007f6c013182cb
[54804.676104] RDX: 0000000000000000 RSI: 000000000000b000 RDI: 
0000000000000015
[54804.676106] RBP: 00007f6bfb208ae0 R08: 000000000004ecda R09: 
000055d8a76d8428
[54804.676108] R10: 00007ffeabf64080 R11: 0000000000000202 R12: 
00007f6bfb208b40
[54804.676109] R13: 0000000000001000 R14: 00007f6b9400a0a0 R15: 
173e1b588dd99ec3
[54804.676114]  </TASK>
[56148.329006] audit: type=1334 audit(1674807651.571:1200): prog-id=53 
op=LOAD

```
And the second one (from syslog):
```
jan 28 02:42:26 tuf kernel: INFO: task crawl_5:2829 blocked for more 
than 122 seconds.
jan 28 02:42:26 tuf kernel:       Tainted: P           OE 6.1.7-1-MANJARO #1
jan 28 02:42:26 tuf kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
jan 28 02:42:26 tuf kernel: task:crawl_5         state:D stack:0 
pid:2829  ppid:1      flags:0x00004002
jan 28 02:42:26 tuf kernel: Call Trace:
jan 28 02:42:26 tuf kernel:  <TASK>
jan 28 02:42:26 tuf kernel:  __schedule+0x370/0x12a0
jan 28 02:42:26 tuf kernel:  schedule+0x5e/0xd0
jan 28 02:42:26 tuf kernel:  wait_current_trans+0xf0/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? sugov_start+0x150/0x150
jan 28 02:42:26 tuf kernel:  start_transaction+0x341/0x5b0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? btrfs_scrub_progress+0x160/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  iterate_extent_inodes+0xab/0x370 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? btrfs_previous_extent_item+0xb2/0x120 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? iterate_inodes_from_logical+0xb8/0xf0 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  iterate_inodes_from_logical+0xb8/0xf0 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  btrfs_ioctl_logical_to_ino+0x105/0x170 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  __x64_sys_ioctl+0x91/0xd0
jan 28 02:42:26 tuf kernel:  do_syscall_64+0x5c/0x90
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
jan 28 02:42:26 tuf kernel: RIP: 0033:0x7f34bd82decf
jan 28 02:42:26 tuf kernel: RSP: 002b:00007f34bd72c3b0 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
jan 28 02:42:26 tuf kernel: RAX: ffffffffffffffda RBX: 0000000000000003 
RCX: 00007f34bd82decf
jan 28 02:42:26 tuf kernel: RDX: 00007f34bd72c7b8 RSI: 00000000c038943b 
RDI: 0000000000000003
jan 28 02:42:26 tuf kernel: RBP: 00007f34bd72c7b0 R08: 0000000000000b0d 
R09: 000055d27e52b428
jan 28 02:42:26 tuf kernel: R10: 00007f3434010ff0 R11: 0000000000000246 
R12: 00007f34bd72c7b8
jan 28 02:42:26 tuf kernel: R13: 00007f34bd72c638 R14: 00007f34bd72c760 
R15: 00007f34bd72c7b0
jan 28 02:42:26 tuf kernel:  </TASK>
jan 28 02:42:26 tuf kernel: INFO: task crawl_5:2830 blocked for more 
than 122 seconds.
jan 28 02:42:26 tuf kernel:       Tainted: P           OE 6.1.7-1-MANJARO #1
jan 28 02:42:26 tuf kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
jan 28 02:42:26 tuf kernel: task:crawl_5         state:D stack:0 
pid:2830  ppid:1      flags:0x00000002
jan 28 02:42:26 tuf kernel: Call Trace:
jan 28 02:42:26 tuf kernel:  <TASK>
jan 28 02:42:26 tuf kernel:  __schedule+0x370/0x12a0
jan 28 02:42:26 tuf kernel:  ? copy_to_user_nofault+0x77/0xa0
jan 28 02:42:26 tuf kernel:  schedule+0x5e/0xd0
jan 28 02:42:26 tuf kernel:  rwsem_down_write_slowpath+0x336/0x720
jan 28 02:42:26 tuf kernel:  ? aa_file_perm+0x122/0x4e0
jan 28 02:42:26 tuf kernel:  btrfs_remap_file_range+0x5a/0x560 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? security_capable+0x41/0x70
jan 28 02:42:26 tuf kernel:  vfs_dedupe_file_range_one+0x16a/0x200
jan 28 02:42:26 tuf kernel:  vfs_dedupe_file_range+0x18d/0x200
jan 28 02:42:26 tuf kernel:  do_vfs_ioctl+0x6ba/0x930
jan 28 02:42:26 tuf kernel:  __x64_sys_ioctl+0x72/0xd0
jan 28 02:42:26 tuf kernel:  do_syscall_64+0x5c/0x90
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
jan 28 02:42:26 tuf kernel: RIP: 0033:0x7f34bd82decf
jan 28 02:42:26 tuf kernel: RSP: 002b:00007f34bcf2aae0 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
jan 28 02:42:26 tuf kernel: RAX: ffffffffffffffda RBX: 00007f34bcf2ae10 
RCX: 00007f34bd82decf
jan 28 02:42:26 tuf kernel: RDX: 00007f3428073e90 RSI: 00000000c0189436 
RDI: 0000000000000012
jan 28 02:42:26 tuf kernel: RBP: 00007f3428073e90 R08: 0000000000000000 
R09: 0000000000000000
jan 28 02:42:26 tuf kernel: R10: 00007ffcac240080 R11: 0000000000000246 
R12: 00007f34bdbb074f
jan 28 02:42:26 tuf kernel: R13: 0000000000000001 R14: 00007f342823b9c0 
R15: 0000000000000001
jan 28 02:42:26 tuf kernel:  </TASK>
jan 28 02:42:26 tuf kernel: INFO: task crawl_5:2831 blocked for more 
than 122 seconds.
jan 28 02:42:26 tuf kernel:       Tainted: P           OE 6.1.7-1-MANJARO #1
jan 28 02:42:26 tuf kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
jan 28 02:42:26 tuf kernel: task:crawl_5         state:D stack:0 
pid:2831  ppid:1      flags:0x00000002
jan 28 02:42:26 tuf kernel: Call Trace:
jan 28 02:42:26 tuf kernel:  <TASK>
jan 28 02:42:26 tuf kernel:  __schedule+0x370/0x12a0
jan 28 02:42:26 tuf kernel:  schedule+0x5e/0xd0
jan 28 02:42:26 tuf kernel:  wait_current_trans+0xf0/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? sugov_start+0x150/0x150
jan 28 02:42:26 tuf kernel:  start_transaction+0x253/0x5b0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  btrfs_replace_file_extents+0x119/0x7c0 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? btrfs_search_slot+0x89a/0xc90 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  btrfs_clone+0x767/0x830 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  btrfs_extent_same_range+0x6e/0xb0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  btrfs_remap_file_range+0x489/0x560 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  vfs_dedupe_file_range_one+0x16a/0x200
jan 28 02:42:26 tuf kernel:  vfs_dedupe_file_range+0x18d/0x200
jan 28 02:42:26 tuf kernel:  do_vfs_ioctl+0x6ba/0x930
jan 28 02:42:26 tuf kernel:  __x64_sys_ioctl+0x72/0xd0
jan 28 02:42:26 tuf kernel:  do_syscall_64+0x5c/0x90
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
jan 28 02:42:26 tuf kernel: RIP: 0033:0x7f34bd82decf
jan 28 02:42:26 tuf kernel: RSP: 002b:00007f34bc729ae0 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
jan 28 02:42:26 tuf kernel: RAX: ffffffffffffffda RBX: 00007f34bc729e10 
RCX: 00007f34bd82decf
jan 28 02:42:26 tuf kernel: RDX: 00007f34ac06c110 RSI: 00000000c0189436 
RDI: 0000000000000018
jan 28 02:42:26 tuf kernel: RBP: 00007f34ac06c110 R08: 0000000000000000 
R09: 0000000000000000
jan 28 02:42:26 tuf kernel: R10: 00007ffcac240080 R11: 0000000000000246 
R12: 00007f34bdbb074f
jan 28 02:42:26 tuf kernel: R13: 0000000000000001 R14: 00007f34ac2e7c50 
R15: 0000000000000001
jan 28 02:42:26 tuf kernel:  </TASK>
jan 28 02:42:26 tuf kernel: INFO: task crawl_5:2832 blocked for more 
than 122 seconds.
jan 28 02:42:26 tuf kernel:       Tainted: P           OE 6.1.7-1-MANJARO #1
jan 28 02:42:26 tuf kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
jan 28 02:42:26 tuf kernel: task:crawl_5         state:D stack:0 
pid:2832  ppid:1      flags:0x00000002
jan 28 02:42:26 tuf kernel: Call Trace:
jan 28 02:42:26 tuf kernel:  <TASK>
jan 28 02:42:26 tuf kernel:  __schedule+0x370/0x12a0
jan 28 02:42:26 tuf kernel:  ? btrfs_read_extent_buffer+0xd4/0x120 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  schedule+0x5e/0xd0
jan 28 02:42:26 tuf kernel:  rwsem_down_write_slowpath+0x336/0x720
jan 28 02:42:26 tuf kernel:  lock_two_nondirectories+0x92/0xc0
jan 28 02:42:26 tuf kernel:  btrfs_remap_file_range+0x5a/0x560 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? security_capable+0x41/0x70
jan 28 02:42:26 tuf kernel:  vfs_dedupe_file_range_one+0x16a/0x200
jan 28 02:42:26 tuf kernel:  vfs_dedupe_file_range+0x18d/0x200
jan 28 02:42:26 tuf kernel:  do_vfs_ioctl+0x6ba/0x930
jan 28 02:42:26 tuf kernel:  __x64_sys_ioctl+0x72/0xd0
jan 28 02:42:26 tuf kernel:  do_syscall_64+0x5c/0x90
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
jan 28 02:42:26 tuf kernel: RIP: 0033:0x7f34bd82decf
jan 28 02:42:26 tuf kernel: RSP: 002b:00007f34bbf291a0 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
jan 28 02:42:26 tuf kernel: RAX: ffffffffffffffda RBX: 00007f34bbf294d0 
RCX: 00007f34bd82decf
jan 28 02:42:26 tuf kernel: RDX: 00007f345c0b1940 RSI: 00000000c0189436 
RDI: 0000000000000008
jan 28 02:42:26 tuf kernel: RBP: 00007f345c0b1940 R08: 0000000000000000 
R09: 0000000000000000
jan 28 02:42:26 tuf kernel: R10: 00007ffcac240080 R11: 0000000000000246 
R12: 00007f34bdbb074f
jan 28 02:42:26 tuf kernel: R13: 0000000000000001 R14: 00007f345c033270 
R15: 0000000000000001
jan 28 02:42:26 tuf kernel:  </TASK>
jan 28 02:42:26 tuf kernel: INFO: task crawl_5:2833 blocked for more 
than 122 seconds.
jan 28 02:42:26 tuf kernel:       Tainted: P           OE 6.1.7-1-MANJARO #1
jan 28 02:42:26 tuf kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
jan 28 02:42:26 tuf kernel: task:crawl_5         state:D stack:0 
pid:2833  ppid:1      flags:0x00000002
jan 28 02:42:26 tuf kernel: Call Trace:
jan 28 02:42:26 tuf kernel:  <TASK>
jan 28 02:42:26 tuf kernel:  __schedule+0x370/0x12a0
jan 28 02:42:26 tuf kernel:  schedule+0x5e/0xd0
jan 28 02:42:26 tuf kernel:  wait_current_trans+0xf0/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? sugov_start+0x150/0x150
jan 28 02:42:26 tuf kernel:  start_transaction+0x341/0x5b0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? btrfs_scrub_progress+0x160/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  iterate_extent_inodes+0xab/0x370 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? btrfs_previous_extent_item+0xb2/0x120 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? iterate_inodes_from_logical+0xb8/0xf0 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  iterate_inodes_from_logical+0xb8/0xf0 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  btrfs_ioctl_logical_to_ino+0x105/0x170 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  __x64_sys_ioctl+0x91/0xd0
jan 28 02:42:26 tuf kernel:  do_syscall_64+0x5c/0x90
jan 28 02:42:26 tuf kernel:  ? do_futex+0xde/0x1b0
jan 28 02:42:26 tuf kernel:  ? __x64_sys_futex+0x92/0x1d0
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
jan 28 02:42:26 tuf kernel: RIP: 0033:0x7f34bd82decf
jan 28 02:42:26 tuf kernel: RSP: 002b:00007f34bb7283b0 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
jan 28 02:42:26 tuf kernel: RAX: ffffffffffffffda RBX: 0000000000000003 
RCX: 00007f34bd82decf
jan 28 02:42:26 tuf kernel: RDX: 00007f34bb7287b8 RSI: 00000000c038943b 
RDI: 0000000000000003
jan 28 02:42:26 tuf kernel: RBP: 00007f34bb7287b0 R08: 0000000000000b11 
R09: 000055d27e52b428
jan 28 02:42:26 tuf kernel: R10: 0000000000000000 R11: 0000000000000246 
R12: 00007f34bb7287b8
jan 28 02:42:26 tuf kernel: R13: 00007f34bb728638 R14: 00007f34bb728760 
R15: 00007f34bb7287b0
jan 28 02:42:26 tuf kernel:  </TASK>
jan 28 02:42:26 tuf kernel: INFO: task crawl_5:2834 blocked for more 
than 122 seconds.
jan 28 02:42:26 tuf kernel:       Tainted: P           OE 6.1.7-1-MANJARO #1
jan 28 02:42:26 tuf kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
jan 28 02:42:26 tuf kernel: task:crawl_5         state:D stack:0 
pid:2834  ppid:1      flags:0x00000002
jan 28 02:42:26 tuf kernel: Call Trace:
jan 28 02:42:26 tuf kernel:  <TASK>
jan 28 02:42:26 tuf kernel:  __schedule+0x370/0x12a0
jan 28 02:42:26 tuf kernel:  schedule+0x5e/0xd0
jan 28 02:42:26 tuf kernel:  wait_current_trans+0xf0/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? sugov_start+0x150/0x150
jan 28 02:42:26 tuf kernel:  start_transaction+0x341/0x5b0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? btrfs_scrub_progress+0x160/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  iterate_extent_inodes+0xab/0x370 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? btrfs_previous_extent_item+0xb2/0x120 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? iterate_inodes_from_logical+0xb8/0xf0 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  iterate_inodes_from_logical+0xb8/0xf0 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  btrfs_ioctl_logical_to_ino+0x105/0x170 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  __x64_sys_ioctl+0x91/0xd0
jan 28 02:42:26 tuf kernel:  do_syscall_64+0x5c/0x90
jan 28 02:42:26 tuf kernel:  ? exc_page_fault+0x74/0x170
jan 28 02:42:26 tuf kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
jan 28 02:42:26 tuf kernel: RIP: 0033:0x7f34bd82decf
jan 28 02:42:26 tuf kernel: RSP: 002b:00007f34baf26810 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
jan 28 02:42:26 tuf kernel: RAX: ffffffffffffffda RBX: 0000000000000003 
RCX: 00007f34bd82decf
jan 28 02:42:26 tuf kernel: RDX: 00007f34baf26c18 RSI: 00000000c038943b 
RDI: 0000000000000003
jan 28 02:42:26 tuf kernel: RBP: 00007f34baf26c10 R08: 0000000000000b12 
R09: 000055d27e52b428
jan 28 02:42:26 tuf kernel: R10: 00007f34480092f0 R11: 0000000000000246 
R12: 00007f34baf26c18
jan 28 02:42:26 tuf kernel: R13: 00007f34baf26a98 R14: 00007f34baf26bc0 
R15: 00007f34baf26c10
jan 28 02:42:26 tuf kernel:  </TASK>
jan 28 02:42:26 tuf kernel: INFO: task crawl_5:2835 blocked for more 
than 122 seconds.
jan 28 02:42:26 tuf kernel:       Tainted: P           OE 6.1.7-1-MANJARO #1
jan 28 02:42:26 tuf kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
jan 28 02:42:26 tuf kernel: task:crawl_5         state:D stack:0 
pid:2835  ppid:1      flags:0x00000002
jan 28 02:42:26 tuf kernel: Call Trace:
jan 28 02:42:26 tuf kernel:  <TASK>
jan 28 02:42:26 tuf kernel:  __schedule+0x370/0x12a0
jan 28 02:42:26 tuf kernel:  schedule+0x5e/0xd0
jan 28 02:42:26 tuf kernel:  wait_current_trans+0xf0/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? sugov_start+0x150/0x150
jan 28 02:42:26 tuf kernel:  start_transaction+0x341/0x5b0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? btrfs_scrub_progress+0x160/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  iterate_extent_inodes+0xab/0x370 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? btrfs_previous_extent_item+0xb2/0x120 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? iterate_inodes_from_logical+0xb8/0xf0 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  iterate_inodes_from_logical+0xb8/0xf0 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  btrfs_ioctl_logical_to_ino+0x105/0x170 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  __x64_sys_ioctl+0x91/0xd0
jan 28 02:42:26 tuf kernel:  do_syscall_64+0x5c/0x90
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
jan 28 02:42:26 tuf kernel: RIP: 0033:0x7f34bd82decf
jan 28 02:42:26 tuf kernel: RSP: 002b:00007f34ba725810 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
jan 28 02:42:26 tuf kernel: RAX: ffffffffffffffda RBX: 0000000000000003 
RCX: 00007f34bd82decf
jan 28 02:42:26 tuf kernel: RDX: 00007f34ba725c18 RSI: 00000000c038943b 
RDI: 0000000000000003
jan 28 02:42:26 tuf kernel: RBP: 00007f34ba725c10 R08: 0000000000000b13 
R09: 000055d27e52b428
jan 28 02:42:26 tuf kernel: R10: 00007f3454004290 R11: 0000000000000246 
R12: 00007f34ba725c18
jan 28 02:42:26 tuf kernel: R13: 00007f34ba725a98 R14: 00007f34ba725bc0 
R15: 00007f34ba725c10
jan 28 02:42:26 tuf kernel:  </TASK>
jan 28 02:42:26 tuf kernel: INFO: task crawl_5:2836 blocked for more 
than 122 seconds.
jan 28 02:42:26 tuf kernel:       Tainted: P           OE 6.1.7-1-MANJARO #1
jan 28 02:42:26 tuf kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
jan 28 02:42:26 tuf kernel: task:crawl_5         state:D stack:0 
pid:2836  ppid:1      flags:0x00000002
jan 28 02:42:26 tuf kernel: Call Trace:
jan 28 02:42:26 tuf kernel:  <TASK>
jan 28 02:42:26 tuf kernel:  __schedule+0x370/0x12a0
jan 28 02:42:26 tuf kernel:  schedule+0x5e/0xd0
jan 28 02:42:26 tuf kernel:  wait_current_trans+0xf0/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? sugov_start+0x150/0x150
jan 28 02:42:26 tuf kernel:  start_transaction+0x253/0x5b0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  btrfs_replace_file_extents+0x119/0x7c0 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? btrfs_search_slot+0x89a/0xc90 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  btrfs_clone+0x767/0x830 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  btrfs_extent_same_range+0x6e/0xb0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  btrfs_remap_file_range+0x489/0x560 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  vfs_dedupe_file_range_one+0x16a/0x200
jan 28 02:42:26 tuf kernel:  vfs_dedupe_file_range+0x18d/0x200
jan 28 02:42:26 tuf kernel:  do_vfs_ioctl+0x6ba/0x930
jan 28 02:42:26 tuf kernel:  __x64_sys_ioctl+0x72/0xd0
jan 28 02:42:26 tuf kernel:  do_syscall_64+0x5c/0x90
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
jan 28 02:42:26 tuf kernel: RIP: 0033:0x7f34bd82decf
jan 28 02:42:26 tuf kernel: RSP: 002b:00007f34b9f24ae0 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
jan 28 02:42:26 tuf kernel: RAX: ffffffffffffffda RBX: 00007f34b9f24e10 
RCX: 00007f34bd82decf
jan 28 02:42:26 tuf kernel: RDX: 00007f344c02cfd0 RSI: 00000000c0189436 
RDI: 0000000000000017
jan 28 02:42:26 tuf kernel: RBP: 00007f344c02cfd0 R08: 0000000000000000 
R09: 0000000000000000
jan 28 02:42:26 tuf kernel: R10: 00007ffcac240080 R11: 0000000000000246 
R12: 00007f34bdbb074f
jan 28 02:42:26 tuf kernel: R13: 0000000000000001 R14: 00007f344c15d7b0 
R15: 0000000000000001
jan 28 02:42:26 tuf kernel:  </TASK>
jan 28 02:42:26 tuf kernel: INFO: task crawl_5:2837 blocked for more 
than 122 seconds.
jan 28 02:42:26 tuf kernel:       Tainted: P           OE 6.1.7-1-MANJARO #1
jan 28 02:42:26 tuf kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
jan 28 02:42:26 tuf kernel: task:crawl_5         state:D stack:0 
pid:2837  ppid:1      flags:0x00000002
jan 28 02:42:26 tuf kernel: Call Trace:
jan 28 02:42:26 tuf kernel:  <TASK>
jan 28 02:42:26 tuf kernel:  __schedule+0x370/0x12a0
jan 28 02:42:26 tuf kernel:  schedule+0x5e/0xd0
jan 28 02:42:26 tuf kernel:  rwsem_down_write_slowpath+0x336/0x720
jan 28 02:42:26 tuf kernel:  ? btrfs_ioctl_tree_search_v2+0xc3/0x100 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  lock_two_nondirectories+0x92/0xc0
jan 28 02:42:26 tuf kernel:  btrfs_remap_file_range+0x5a/0x560 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? security_capable+0x41/0x70
jan 28 02:42:26 tuf kernel:  vfs_dedupe_file_range_one+0x16a/0x200
jan 28 02:42:26 tuf kernel:  vfs_dedupe_file_range+0x18d/0x200
jan 28 02:42:26 tuf kernel:  do_vfs_ioctl+0x6ba/0x930
jan 28 02:42:26 tuf kernel:  __x64_sys_ioctl+0x72/0xd0
jan 28 02:42:26 tuf kernel:  do_syscall_64+0x5c/0x90
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
jan 28 02:42:26 tuf kernel: RIP: 0033:0x7f34bd82decf
jan 28 02:42:26 tuf kernel: RSP: 002b:00007f34b97241a0 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
jan 28 02:42:26 tuf kernel: RAX: ffffffffffffffda RBX: 00007f34b97244d0 
RCX: 00007f34bd82decf
jan 28 02:42:26 tuf kernel: RDX: 00007f344000f660 RSI: 00000000c0189436 
RDI: 0000000000000008
jan 28 02:42:26 tuf kernel: RBP: 00007f344000f660 R08: 0000000000000000 
R09: 0000000000000000
jan 28 02:42:26 tuf kernel: R10: 00007ffcac240080 R11: 0000000000000246 
R12: 00007f34bdbb074f
jan 28 02:42:26 tuf kernel: R13: 0000000000000001 R14: 00007f3440064ca0 
R15: 0000000000000001
jan 28 02:42:26 tuf kernel:  </TASK>
jan 28 02:42:26 tuf kernel: INFO: task crawl_5:2838 blocked for more 
than 122 seconds.
ян�� 28 02:42:26 tuf kernel:       Tainted: P           OE 
6.1.7-1-MANJARO #1
jan 28 02:42:26 tuf kernel: "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
jan 28 02:42:26 tuf kernel: task:crawl_5         state:D stack:0 
pid:2838  ppid:1      flags:0x00000002
jan 28 02:42:26 tuf kernel: Call Trace:
jan 28 02:42:26 tuf kernel:  <TASK>
jan 28 02:42:26 tuf kernel:  __schedule+0x370/0x12a0
jan 28 02:42:26 tuf kernel:  schedule+0x5e/0xd0
jan 28 02:42:26 tuf kernel:  wait_current_trans+0xf0/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? sugov_start+0x150/0x150
jan 28 02:42:26 tuf kernel:  start_transaction+0x341/0x5b0 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? btrfs_scrub_progress+0x160/0x160 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  iterate_extent_inodes+0xab/0x370 [btrfs 
13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? btrfs_previous_extent_item+0xb2/0x120 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  ? iterate_inodes_from_logical+0xb8/0xf0 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  iterate_inodes_from_logical+0xb8/0xf0 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  btrfs_ioctl_logical_to_ino+0x105/0x170 
[btrfs 13bc16e98c7a8d5d966c4096cfee4d520183f65f]
jan 28 02:42:26 tuf kernel:  __x64_sys_ioctl+0x91/0xd0
jan 28 02:42:26 tuf kernel:  do_syscall_64+0x5c/0x90
jan 28 02:42:26 tuf kernel:  ? do_futex+0xde/0x1b0
jan 28 02:42:26 tuf kernel:  ? __x64_sys_futex+0x92/0x1d0
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
jan 28 02:42:26 tuf kernel:  ? do_syscall_64+0x6b/0x90
jan 28 02:42:26 tuf kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
jan 28 02:42:26 tuf kernel: RIP: 0033:0x7f34bd82decf
jan 28 02:42:26 tuf kernel: RSP: 002b:00007f34b8f233b0 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
jan 28 02:42:26 tuf kernel: RAX: ffffffffffffffda RBX: 0000000000000003 
RCX: 00007f34bd82decf
jan 28 02:42:26 tuf kernel: RDX: 00007f34b8f237b8 RSI: 00000000c038943b 
RDI: 0000000000000003
jan 28 02:42:26 tuf kernel: RBP: 00007f34b8f237b0 R08: 0000000000000b16 
R09: 000055d27e52b428
jan 28 02:42:26 tuf kernel: R10: 0000000000000000 R11: 0000000000000246 
R12: 00007f34b8f237b8
jan 28 02:42:26 tuf kernel: R13: 00007f34b8f23638 R14: 00007f34b8f23760 
R15: 00007f34b8f237b0
jan 28 02:42:26 tuf kernel:  </TASK>
```
I had to reboot my system using hardware power button, as it hadn't 
rebooted using regular reboot command.

How can I help you to debug this issue?

Sincerely, Aleksey Nemcev.
