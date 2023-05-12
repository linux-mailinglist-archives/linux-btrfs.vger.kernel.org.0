Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0AB7009B6
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 May 2023 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241382AbjELN7e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 May 2023 09:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241378AbjELN71 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 May 2023 09:59:27 -0400
Received: from sm-r-016-dus.org-dns.com (sm-r-016-dus.org-dns.com [89.107.70.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5660814913
        for <linux-btrfs@vger.kernel.org>; Fri, 12 May 2023 06:59:11 -0700 (PDT)
Received: from smarthost-dus.org-dns.com (localhost [127.0.0.1])
        by smarthost-dus.org-dns.com (Postfix) with ESMTP id 76613A379D
        for <linux-btrfs@vger.kernel.org>; Fri, 12 May 2023 15:59:06 +0200 (CEST)
Received: by smarthost-dus.org-dns.com (Postfix, from userid 1001)
        id 69BE9A3728; Fri, 12 May 2023 15:59:06 +0200 (CEST)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
Received: from ha01s030.org-dns.com (ha01s030.org-dns.com [62.108.32.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smarthost-dus.org-dns.com (Postfix) with ESMTPS id 91CEBA07F4;
        Fri, 12 May 2023 15:59:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=friedels.name;
        s=default; t=1683899948;
        bh=O0h1BqoZJZEnzHRA22nf5/QFEklV+ZH/LrgYE7KuG8c=;
        h=Received:From:To:Subject;
        b=CzUAy9sX3h26yNwk8PrgigfyrOb7xKhsnA7Hwmkoa0Y6rDkdSMUp/Jzl4gCyhBoWx
         kUiw0Zk61X8ggGh8qqC5uTGguNWULIYnnqBD4iDycmFCZYTHU8fJ9lVwHbWYPLnmnh
         2qSt2zLzXVXvq43iai6vZSSb4rADZzJmS8DHCk5o=
Authentication-Results: ha01s030.org-dns.com;
        spf=pass (sender IP is 127.0.0.1) smtp.mailfrom=hendrik@friedels.name smtp.helo=ha01s030.org-dns.com
Received-SPF: pass (ha01s030.org-dns.com: connection is authenticated)
Received: from [94.31.96.101] ([94.31.96.101]) by webmail.friedels.name
 (Horde Framework) with HTTPS; Fri, 12 May 2023 15:59:07 +0200
Date:   Fri, 12 May 2023 15:59:07 +0200
Message-ID: <20230512155907.Horde.XvUj6kvB0C-9DWnCX3495GZ@webmail.friedels.name>
From:   hendrik@friedels.name
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Scrub errors unable to fixup (regular) error
References: <25249f22-7e1b-43bf-9586-91c9803e4c28@email.android.com>
 <6528e2b3-cc84-2faa-29e5-9a26fe1685a7@gmx.com>
 <20230509192639.Horde.QxWaLhyEPB3pLQHuBQtufoy@webmail.friedels.name>
 <6a175825-67a5-89f5-8456-6ffcf492ee9f@suse.com>
 <20230510171413.Horde.Hni1DVgjm4BqVg4XdHnLRsT@webmail.friedels.name>
 <9bf450c9-0efd-f1d0-4af6-d20d77929d33@gmx.com>
 <20230511100430.Horde.Q4rsEEoGJiD70MPHAHrw-Ir@webmail.friedels.name>
 <04805c00-ab15-f121-fd71-7d2ca4ffca9d@gmx.com>
 <20230511115121.Horde.Z26uEVt4e3xPor-FGgu6gHv@webmail.friedels.name>
 <62be2a21-c574-82f8-adbd-58892c6f1f09@gmx.com>
 <20230511135212.Horde.6ttSR_DZDVV9Pq-oIEuYT-O@webmail.friedels.name>
 <cf1846c3-eca1-f1db-4fdd-d670a0e4a146@gmx.com>
 <20230511162830.Horde.7w0mEKkjng-92Yh8zNPhbhX@webmail.friedels.name>
 <04b58586-06c2-76b3-e2bd-2e6d200bca0c@gmx.com>
 <20230512090553.Horde.rZuQva6ZL8JC6AVL5sz8Kv9@webmail.friedels.name>
 <c790c406-b55f-10c1-6d6e-262b3ec23432@suse.com>
 <20230512130223.Horde.dVkiBPzfIrCSdTCqSHyitZs@webmail.friedels.name>
 <3c5f9fca-2756-0971-e121-71aad42fe1b1@suse.com>
In-Reply-To: <3c5f9fca-2756-0971-e121-71aad42fe1b1@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <168389994848.31948.7933885539884620587@ha01s030.org-dns.com>
X-PPP-Vhost: friedels.name
X-POWERED-BY: wint.global - AV:CLEAN SPAM:OK
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu,


>>>> [Fr Mai 12 08:57:28 2023] BTRFS: error (device sda3: state A) in  
>>>> btrfs_finish_ordered_io:3316: errno=-5 IO failure
>>>> [Fr Mai 12 08:57:28 2023] BTRFS info (device sda3: state EA):  
>>>> forced readonly
>
> Is there any extra logs before that btrfs_finish_ordered_io line?
>
> That normally means metadata errors during file extents insertion.


No, no extra logs:
grep btrfs_finish_ordered_io  -B 100 kern.log* |grep -i btrfs
kern.log-May 11 21:34:28 homeserver kernel: [36358.184406] BTRFS:  
device label USB_Backup devid 1 transid 890 /dev/sdd scanned by  
systemd-udevd (414587)
kern.log-May 11 21:36:14 homeserver kernel: [36463.967735] BTRFS info  
(device sdd): using crc32c (crc32c-intel) checksum algorithm
kern.log-May 11 21:36:14 homeserver kernel: [36463.967746] BTRFS info  
(device sdd): disk space caching is enabled
kern.log:May 12 08:57:28 homeserver kernel: [77338.315620] BTRFS:  
error (device sda3: state A) in btrfs_finish_ordered_io:3316: errno=-5  
IO failure


kern.log.1:May  6 07:54:24 homeserver kernel: [ 1377.009844] BTRFS:  
error (device sda3: state A) in btrfs_finish_ordered_io:3316: errno=-5  
IO failure

or just looking at the last few minutes before the error:

kern.log-May 12 08:23:21 homeserver kernel: [75291.546502]  sdd: sdd1 sdd2
kern.log-May 12 08:23:21 homeserver kernel: [75291.547334] sd 6:0:0:0:  
[sdd] Attached SCSI disk
kern.log:May 12 08:57:28 homeserver kernel: [77338.315620] BTRFS:  
error (device sda3: state A) in btrfs_finish_ordered_io:3316: errno=-5  
IO failure
--
regulatory.db failed with error -2
kern.log.1-May  6 07:32:30 homeserver kernel: [   62.894912] cfg80211:  
failed to load regulatory.db
kern.log.1:May  6 07:54:24 homeserver kernel: [ 1377.009844] BTRFS:  
error (device sda3: state A) in btrfs_finish_ordered_io:3316: errno=-5  
IO failure


Note, that I had this error twice. Today and a week ago.

Greetings,
Hendrik


> Thanks,
> Qu
>
>
>>>
>>> This is not good at all. But it may also explain the original  
>>> problem, the fs already has some problem.
>>>
>>> Thus strongly recommend a "btrfs check --readonly" for it.
>>>
>>> Thanks,
>>> Qu
>>>
>>>> [Fr Mai 12 08:57:29 2023] BTRFS warning (device sda3: state EA):  
>>>> Skipping commit of aborted transaction.
>>>> [Fr Mai 12 08:57:29 2023] BTRFS: error (device sda3: state EA) in  
>>>> cleanup_transaction:1958: errno=-5 IO failure
>>>> [Fr Mai 12 08:58:59 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 239466283008 mirror 1  
>>>> wanted 1455880 found 1455857
>>>> [Fr Mai 12 08:58:59 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 239466283008 mirror 1  
>>>> wanted 1455880 found 1455857
>>>> [Fr Mai 12 08:59:18 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 2124513280 mirror 1  
>>>> wanted 1455880 found 1455870
>>>> [Fr Mai 12 08:59:18 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 2124513280 mirror 1  
>>>> wanted 1455880 found 1455870
>>>> [Fr Mai 12 08:59:18 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 2124513280 mirror 1  
>>>> wanted 1455880 found 1455870
>>>> [Fr Mai 12 08:59:18 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 2124513280 mirror 1  
>>>> wanted 1455880 found 1455870
>>>> [Fr Mai 12 08:59:18 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 2124513280 mirror 1  
>>>> wanted 1455880 found 1455870
>>>> [Fr Mai 12 08:59:29 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 239466283008 mirror 1  
>>>> wanted 1455880 found 1455857
>>>> [Fr Mai 12 08:59:43 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 239452585984 mirror 1  
>>>> wanted 1455880 found 1455863
>>>> [Fr Mai 12 08:59:43 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 239452585984 mirror 1  
>>>> wanted 1455880 found 1455863
>>>> [Fr Mai 12 08:59:43 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 239466283008 mirror 1  
>>>> wanted 1455880 found 1455857
>>>> [Fr Mai 12 08:59:43 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 239466283008 mirror 1  
>>>> wanted 1455880 found 1455857
>>>> [Fr Mai 12 08:59:59 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 239466283008 mirror 1  
>>>> wanted 1455880 found 1455857
>>>> [Fr Mai 12 09:00:10 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 239452585984 mirror 1  
>>>> wanted 1455880 found 1455863
>>>> [Fr Mai 12 09:00:10 2023] BTRFS error (device sda3: state EA):  
>>>> parent transid verify failed on logical 239452585984 mirror 1  
>>>> wanted 1455880 found 1455863
>>>>
>>>> Best regards,
>>>> Hendrik
>>>>
>>>>
>>>>> But the backref walk still failed, there can be two possible reasons:
>>>>>
>>>>> - The offending sector is not really being referred
>>>>>   Btrfs has extent bookend behavior, thus some range of an extent may
>>>>>   not be referred by any file.
>>>>>   This can happen on frequently updated files like qcow2 files.
>>>>>
>>>>> - The subvolume tree is corrupted
>>>>>   Some directory items are missing thus failed the filename resolution.
>>>>>   So far I would put this worst case situation unlikely.
>>>>>
>>>>>>
>>>>>>> My guess is, since btrfs check reports no error, it must mean there is
>>>>>>> one deleted file/directory preventing us from reaching the offending
>>>>>>> inode (20516966).
>>>>>>>
>>>>>>> Normally cleaner would be kicked in when mounting, and your fs should
>>>>>>> have been mounted for a while, I doubt why the offending files are not
>>>>>>> properly handled.
>>>>>>
>>>>>> Hm. I can only say, that this drive was mounted for a while - remember:
>>>>>> The issue first appeared more than a month ago.
>>>>>> By the way, the number of errors reported by scrub significantly (x15)
>>>>>> increased in the meantime.
>>>>>
>>>>> Another thing is, the offending file is qcow2 file, IIRC there used to
>>>>> be some bugs causing csum mismatch just like this.
>>>>>
>>>>> I'm not sure if this is the case.
>>>>>
>>>>> Can you please try defragging that qcow2 file (without the VM running),
>>>>> then I believe the error would be gone (need sync before scrub though).
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> Greetings,
>>>>>> Hendrik
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>
>>>>>>>>
>>>>>>>> [no output]
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> Hendrik
>>>>>>>>
>>>>>>>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>>>>>
>>>>>>>>> On 2023/5/11 17:51, hendrik@friedels.name wrote:
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>>> Mind to use the following command to dump needed info?
>>>>>>>>>>>
>>>>>>>>>>> # btrfs ins logical-resolve -P 256655540224 <mnt>
>>>>>>>>>>
>>>>>>>>>> btrfs ins dump-tree -t 5
>>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
>>>>>>>>>> |grep -A5 20516966
>>>>>>>>>> ERROR: not a block device or regular file:
>>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
>>>>>>>>>> ERROR: device scan
>>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/:
>>>>>>>>>> Input/output error
>>>>>>>>>>
>>>>>>>>>> So, I tried
>>>>>>>>>> btrfs ins dump-tree -t 5 /dev/sda3 |grep -A5 20516966
>>>>>>>>>>
>>>>>>>>>> Here below the first 300 lines. The whole output is 825MB. I can
>>>>>>>>>> put it
>>>>>>>>>> on some clouddrive, if helpful.
>>>>>>>>>
>>>>>>>>> Oh, that's super large...
>>>>>>>>>
>>>>>>>>> What about this command? What I care is not the data extents, but the
>>>>>>>>> inode item and orphan items.
>>>>>>>>>
>>>>>>>>> # btrfs ins dump-tree -t 5 <dev> | grep -A5 "(20516966 INODE"
>>>>>>>>>
>>>>>>>>> And
>>>>>>>>>
>>>>>>>>> # btrfs ins dump-tree -t 5 <dev> | grep -A5 "20516966)"
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>>>>
>>>>>>>>>> Best regards,
>>>>>>>>>> Hendrik
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>     key (20516966 EXTENT_DATA 265646080) block 164778459136 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 2382381056) block 164687511552 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 3017527296) block 164689084416 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 3347685376) block 238769209344 gen
>>>>>>>>>> 1452272
>>>>>>>>>>     key (20516966 EXTENT_DATA 3694825472) block 239448473600 gen
>>>>>>>>>> 1453367
>>>>>>>>>>     key (20516966 EXTENT_DATA 4002680832) block 164783800320 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 4277063680) block 164681154560 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 4547493888) block 164681302016 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 5055336448) block 164778098688 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 6010699776) block 164781572096 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 7062020096) block 223582420992 gen
>>>>>>>>>> 1439541
>>>>>>>>>>     key (20516966 EXTENT_DATA 7323496448) block 211509592064 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 7589588992) block 1401044992  
>>>>>>>>>> gen 1397353
>>>>>>>>>>     key (20516966 EXTENT_DATA 7855419392) block 227035529216 gen
>>>>>>>>>> 1397314
>>>>>>>>>>     key (20516966 EXTENT_DATA 8103256064) block 210562678784 gen
>>>>>>>>>> 1445713
>>>>>>>>>>     key (20516966 EXTENT_DATA 8342720512) block 1795260416  
>>>>>>>>>> gen 1441223
>>>>>>>>>>     key (20516966 EXTENT_DATA 8544866304) block 239422554112 gen
>>>>>>>>>> 1453367
>>>>>>>>>>     key (20516966 EXTENT_DATA 8779956224) block 238414020608 gen
>>>>>>>>>> 1441803
>>>>>>>>>>     key (20516966 EXTENT_DATA 9077592064) block 223811584000 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 9297559552) block 210727698432 gen
>>>>>>>>>> 1439539
>>>>>>>>>>     key (20516966 EXTENT_DATA 9550733312) block 226777022464 gen
>>>>>>>>>> 1357911
>>>>>>>>>>     key (20516966 EXTENT_DATA 9795792896) block 1118519296  
>>>>>>>>>> gen 1359749
>>>>>>>>>>     key (20516966 EXTENT_DATA 9991553024) block 223432949760 gen
>>>>>>>>>> 1359920
>>>>>>>>>>     key (20516966 EXTENT_DATA 10247729152) block 163268411392 gen
>>>>>>>>>> 1441223
>>>>>>>>>>     key (20516966 EXTENT_DATA 10549501952) block 164783734784 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 10860040192) block 226811281408 gen
>>>>>>>>>> 1439935
>>>>>>>>>>     key (20516966 EXTENT_DATA 11130150912) block 227281223680 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 11379605504) block 211351076864 gen
>>>>>>>>>> 1438445
>>>>>>>>>>     key (20516966 EXTENT_DATA 11637706752) block 205487079424 gen
>>>>>>>>>> 1356900
>>>>>>>>>>     key (20516966 EXTENT_DATA 11896266752) block 238427766784 gen
>>>>>>>>>> 1357750
>>>>>>>>>>     key (20516966 EXTENT_DATA 12148346880) block 205693779968 gen
>>>>>>>>>> 1357896
>>>>>>>>>>     key (20516966 EXTENT_DATA 12400721920) block 165179523072 gen
>>>>>>>>>> 1357941
>>>>>>>>>>     key (20516966 EXTENT_DATA 12608835584) block 227041509376 gen
>>>>>>>>>> 1397314
>>>>>>>>>>     key (20516966 EXTENT_DATA 12859318272) block 223969394688 gen
>>>>>>>>>> 1353766
>>>>>>>>>>     key (20516966 EXTENT_DATA 13127262208) block 226946203648 gen
>>>>>>>>>> 1352132
>>>>>>>>>>     key (20516966 EXTENT_DATA 13627129856) block 226847883264 gen
>>>>>>>>>> 1353976
>>>>>>>>>>     key (20516966 EXTENT_DATA 13881053184) block 2094366720 gen
>>>>>>>>>> 1353923
>>>>>>>>>>     key (20516966 EXTENT_DATA 14134448128) block 164436787200 gen
>>>>>>>>>> 1354138
>>>>>>>>>>     key (20516966 EXTENT_DATA 14393528320) block 227636854784 gen
>>>>>>>>>> 1360684
>>>>>>>>>>     key (20516966 EXTENT_DATA 14648418304) block 2115108864 gen
>>>>>>>>>> 1354056
>>>>>>>>>>     key (20516966 EXTENT_DATA 14904184832) block 164892196864 gen
>>>>>>>>>> 1375632
>>>>>>>>>>     key (20516966 EXTENT_DATA 15413915648) block 227232759808 gen
>>>>>>>>>> 1353091
>>>>>>>>>>     key (20516966 EXTENT_DATA 15920713728) block 239131492352 gen
>>>>>>>>>> 1353487
>>>>>>>>>>     key (20516966 EXTENT_DATA 16175820800) block 223470190592 gen
>>>>>>>>>> 1438445
>>>>>>>>>>     key (20516966 EXTENT_DATA 16439250944) block 227287695360 gen
>>>>>>>>>> 1439542
>>>>>>>>>>     key (20516966 EXTENT_DATA 16685133824) block 1534607360 gen
>>>>>>>>>> 1441075
>>>>>>>>>>     key (20516966 EXTENT_DATA 16936067072) block 227636248576 gen
>>>>>>>>>> 1360684
>>>>>>>>>>     key (20516966 EXTENT_DATA 17165570048) block 205794885632 gen
>>>>>>>>>> 1359476
>>>>>>>>>>     key (20516966 EXTENT_DATA 17389993984) block 227032547328 gen
>>>>>>>>>> 1438447
>>>>>>>>>>     key (20516966 EXTENT_DATA 17621237760) block 227175464960 gen
>>>>>>>>>> 1438447
>>>>>>>>>>     key (20516966 EXTENT_DATA 17865830400) block 211096109056 gen
>>>>>>>>>> 1356226
>>>>>>>>>>     key (20516966 EXTENT_DATA 18123091968) block 227360014336 gen
>>>>>>>>>> 1355774
>>>>>>>>>>     key (20516966 EXTENT_DATA 18385969152) block 205471334400 gen
>>>>>>>>>> 1356900
>>>>>>>>>>     key (20516966 EXTENT_DATA 18630250496) block 205934067712 gen
>>>>>>>>>> 1356511
>>>>>>>>>>     key (20516966 EXTENT_DATA 18889089024) block 224197115904 gen
>>>>>>>>>> 1356806
>>>>>>>>>>     key (20516966 EXTENT_DATA 19166941184) block 1860763648 gen
>>>>>>>>>> 1358727
>>>>>>>>>>     key (20516966 EXTENT_DATA 19412447232) block 211453952000 gen
>>>>>>>>>> 1358824
>>>>>>>>>>     key (20516966 EXTENT_DATA 19676684288) block 239204237312 gen
>>>>>>>>>> 1397353
>>>>>>>>>>     key (20516966 EXTENT_DATA 19942309888) block 227036610560 gen
>>>>>>>>>> 1397314
>>>>>>>>>>     key (20516966 EXTENT_DATA 20189745152) block 238787739648 gen
>>>>>>>>>> 1439937
>>>>>>>>>>     key (20516966 EXTENT_DATA 20410966016) block 238569340928 gen
>>>>>>>>>> 1439937
>>>>>>>>>>     key (20516966 EXTENT_DATA 20651180032) block 164689035264 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 20968505344) block 164690182144 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 21243555840) block 238618427392 gen
>>>>>>>>>> 1439937
>>>>>>>>>>     key (20516966 EXTENT_DATA 21493923840) block 238416429056 gen
>>>>>>>>>> 1441803
>>>>>>>>>>     key (20516966 EXTENT_DATA 21709266944) block 223821905920 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 21942276096) block 165219434496 gen
>>>>>>>>>> 1449140
>>>>>>>>>>     key (20516966 EXTENT_DATA 22184435712) block 224314474496 gen
>>>>>>>>>> 1439541
>>>>>>>>>>     key (20516966 EXTENT_DATA 22434406400) block 164675731456 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 22685433856) block 1110278144 gen
>>>>>>>>>> 1441075
>>>>>>>>>>     key (20516966 EXTENT_DATA 22964740096) block 205633748992 gen
>>>>>>>>>> 1439497
>>>>>>>>>>     key (20516966 EXTENT_DATA 23203467264) block 163564617728 gen
>>>>>>>>>> 1446532
>>>>>>>>>>     key (20516966 EXTENT_DATA 23445389312) block 1210531840 gen
>>>>>>>>>> 1453368
>>>>>>>>>>     key (20516966 EXTENT_DATA 23702712320) block 210816352256 gen
>>>>>>>>>> 1439539
>>>>>>>>>>     key (20516966 EXTENT_DATA 23950020608) block 164825481216 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20519233 EXTENT_DATA 322072576) block 164451090432 gen
>>>>>>>>>> 1453431
>>>>>>>>>> node 164240982016 level 1 items 367 free space 126  
>>>>>>>>>> generation 1453430
>>>>>>>>>> owner FS_TREE
>>>>>>>>>> node 164240982016 flags 0x1(WRITTEN) backref revision 1
>>>>>>>>>> fs uuid c1534c07-d669-4f55-ae50-b87669ecb259
>>>>>>>>>> chunk uuid cfbd6daf-a5c8-422a-a66e-def7108053bb
>>>>>>>>>> -- 
>>>>>>>>>>     key (20516966 EXTENT_DATA 15638528) block 164782145536  
>>>>>>>>>> gen 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 228098048) block 164786749440 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 229384192) block 164786814976 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 231342080) block 164825661440 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 235835392) block 164697227264 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 236634112) block 164729225216 gen
>>>>>>>>>> 1449140
>>>>>>>>>>     key (20516966 EXTENT_DATA 237568000) block 164729208832 gen
>>>>>>>>>> 1449140
>>>>>>>>>>     key (20516966 EXTENT_DATA 240009216) block 164680728576 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 245379072) block 164778704896 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 248561664) block 224396935168 gen
>>>>>>>>>> 1439935
>>>>>>>>>>     key (20516966 EXTENT_DATA 254631936) block 238791753728 gen
>>>>>>>>>> 1439937
>>>>>>>>>>     key (20516966 EXTENT_DATA 256368640) block 227325968384 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 258596864) block 163882074112 gen
>>>>>>>>>> 1450534
>>>>>>>>>>     key (20516966 EXTENT_DATA 260284416) block 227326574592 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 261296128) block 164536254464 gen
>>>>>>>>>> 1438441
>>>>>>>>>>     key (20516966 EXTENT_DATA 262922240) block 164782850048 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 264183808) block 226980741120 gen
>>>>>>>>>> 1439541
>>>>>>>>>> node 164778459136 level 1 items 444 free space 49 generation 1453387
>>>>>>>>>> owner FS_TREE
>>>>>>>>>> node 164778459136 flags 0x1(WRITTEN) backref revision 1
>>>>>>>>>> fs uuid c1534c07-d669-4f55-ae50-b87669ecb259
>>>>>>>>>> chunk uuid cfbd6daf-a5c8-422a-a66e-def7108053bb
>>>>>>>>>>     key (20516966 EXTENT_DATA 265646080) block 238792065024 gen
>>>>>>>>>> 1439937
>>>>>>>>>>     key (20516966 EXTENT_DATA 267952128) block 227328049152 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 269443072) block 227326738432 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 271007744) block 238460026880 gen
>>>>>>>>>> 1439937
>>>>>>>>>>     key (20516966 EXTENT_DATA 272699392) block 227333488640 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 273977344) block 164838899712 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 274591744) block 227391864832 gen
>>>>>>>>>> 1439542
>>>>>>>>>>     key (20516966 EXTENT_DATA 275689472) block 227333505024 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 280240128) block 1207533568  
>>>>>>>>>> gen 1446519
>>>>>>>>>>     key (20516966 EXTENT_DATA 281145344) block 227333521408 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 281952256) block 227229417472 gen
>>>>>>>>>> 1439542
>>>>>>>>>>     key (20516966 EXTENT_DATA 283787264) block 210564628480 gen
>>>>>>>>>> 1445713
>>>>>>>>>>     key (20516966 EXTENT_DATA 285298688) block 227229499392 gen
>>>>>>>>>> 1439542
>>>>>>>>>>     key (20516966 EXTENT_DATA 286175232) block 227332227072 gen
>>>>>>>>>> 1439542
>>>>>>>>>>     key (20516966 EXTENT_DATA 287105024) block 227332325376 gen
>>>>>>>>>> 1439542
>>>>>>>>>>     key (20516966 EXTENT_DATA 293130240) block 227029549056 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 294088704) block 227030433792 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 295129088) block 227030351872 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 295690240) block 227030089728 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 296648704) block 227030728704 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 298176512) block 227030630400 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 299155456) block 205842038784 gen
>>>>>>>>>> 1439497
>>>>>>>>>>     key (20516966 EXTENT_DATA 300711936) block 227332751360 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 309911552) block 227333095424 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 311549952) block 227332898816 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 312725504) block 227332997120 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 314884096) block 227332718592 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 317952000) block 227333783552 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 319668224) block 164838932480 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 321069056) block 227333947392 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 322899968) block 227333963776 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 324415488) block 163606888448 gen
>>>>>>>>>> 1446533
>>>>>>>>>>     key (20516966 EXTENT_DATA 328224768) block 163606953984 gen
>>>>>>>>>> 1446533
>>>>>>>>>>     key (20516966 EXTENT_DATA 332066816) block 211113377792 gen
>>>>>>>>>> 1441063
>>>>>>>>>>     key (20516966 EXTENT_DATA 339017728) block 1317519360  
>>>>>>>>>> gen 1453367
>>>>>>>>>>     key (20516966 EXTENT_DATA 348356608) block 1220706304  
>>>>>>>>>> gen 1453368
>>>>>>>>>>     key (20516966 EXTENT_DATA 354250752) block 227334258688 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 355418112) block 227334340608 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 356929536) block 227334307840 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 359043072) block 206079819776 gen
>>>>>>>>>> 1439590
>>>>>>>>>>     key (20516966 EXTENT_DATA 361721856) block 227335061504 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 424017920) block 163951755264 gen
>>>>>>>>>> 1449117
>>>>>>>>>>     key (20516966 EXTENT_DATA 431935488) block 227335241728 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 443465728) block 227089612800 gen
>>>>>>>>>> 1439935
>>>>>>>>>>     key (20516966 EXTENT_DATA 448565248) block 210757517312 gen
>>>>>>>>>> 1439932
>>>>>>>>>>     key (20516966 EXTENT_DATA 453402624) block 210798329856 gen
>>>>>>>>>> 1439932
>>>>>>>>>>     key (20516966 EXTENT_DATA 457375744) block 238465318912 gen
>>>>>>>>>> 1439937
>>>>>>>>>>     key (20516966 EXTENT_DATA 498782208) block 238464581632 gen
>>>>>>>>>> 1439937
>>>>>>>>>>     key (20516966 EXTENT_DATA 500420608) block 164842422272 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 529051648) block 165252153344 gen
>>>>>>>>>> 1453347
>>>>>>>>>>     key (20516966 EXTENT_DATA 530108416) block 239353839616 gen
>>>>>>>>>> 1453367
>>>>>>>>>>     key (20516966 EXTENT_DATA 531210240) block 163611279360 gen
>>>>>>>>>> 1453375
>>>>>>>>>>     key (20516966 EXTENT_DATA 532463616) block 164645879808 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 533319680) block 164680777728 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 534040576) block 164686102528 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 535052288) block 164741496832 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 535687168) block 164742414336 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 536858624) block 164805787648 gen
>>>>>>>>>> 1453387
>>>>>>>>>>     key (20516966 EXTENT_DATA 538189824) block 202955309056 gen
>>>>>>>>>> 1452617
>>>>>>>>>>     key (20516966 EXTENT_DATA 539148288) block 164615208960 gen
>>>>>>>>>> 1452668
>>>>>>>>>>     key (20516966 EXTENT_DATA 540790784) block 205406814208 gen
>>>>>>>>>> 1452684
>>>>>>>>>>     key (20516966 EXTENT_DATA 541609984) block 239260991488 gen
>>>>>>>>>> 1452713
>>>>>>>>>>     key (20516966 EXTENT_DATA 542449664) block 164773363712 gen
>>>>>>>>>> 1452743
>>>>>>>>>>     key (20516966 EXTENT_DATA 543408128) block 202046947328 gen
>>>>>>>>>> 1452817
>>>>>>>>>>     key (20516966 EXTENT_DATA 544808960) block 202293264384 gen
>>>>>>>>>> 1452820
>>>>>>>>>>     key (20516966 EXTENT_DATA 545796096) block 1538818048  
>>>>>>>>>> gen 1452860
>>>>>>>>>>     key (20516966 EXTENT_DATA 546942976) block 165280333824 gen
>>>>>>>>>> 1452886
>>>>>>>>>>     key (20516966 EXTENT_DATA 547934208) block 1112162304  
>>>>>>>>>> gen 1452918
>>>>>>>>>>     key (20516966 EXTENT_DATA 548970496) block 164755652608 gen
>>>>>>>>>> 1452942
>>>>>>>>>>     key (20516966 EXTENT_DATA 549752832) block 210809552896 gen
>>>>>>>>>> 1452965
>>>>>>>>>>     key (20516966 EXTENT_DATA 550522880) block 224242892800 gen
>>>>>>>>>> 1453025
>>>>>>>>>>     key (20516966 EXTENT_DATA 551743488) block 238447132672 gen
>>>>>>>>>> 1453030
>>>>>>>>>>     key (20516966 EXTENT_DATA 552792064) block 164376117248 gen
>>>>>>>>>> 1453051
>>>>>>>>>>     key (20516966 EXTENT_DATA 553607168) block 210912362496 gen
>>>>>>>>>> 1453078
>>>>>>>>>>     key (20516966 EXTENT_DATA 554512384) block 163702718464 gen
>>>>>>>>>> 1453109
>>>>>>>>>>     key (20516966 EXTENT_DATA 555601920) block 163334782976 gen
>>>>>>>>>> 1453143
>>>>>>>>>>     key (20516966 EXTENT_DATA 556838912) block 202463232000 gen
>>>>>>>>>> 1453176
>>>>>>>>>>     key (20516966 EXTENT_DATA 557846528) block 226976235520 gen
>>>>>>>>>> 1453197
>>>>>>>>>>     key (20516966 EXTENT_DATA 558559232) block 163318284288 gen
>>>>>>>>>> 1453218
>>>>>>>>>>     key (20516966 EXTENT_DATA 559181824) block 226670477312 gen
>>>>>>>>>> 1453253
>>>>>>>>>>     key (20516966 EXTENT_DATA 560259072) block 227081469952 gen
>>>>>>>>>> 1453254
>>>>>>>>>>     key (20516966 EXTENT_DATA 591917056) block 210962579456 gen
>>>>>>>>>> 1451296
>>>>>>>>>>     key (20516966 EXTENT_DATA 618921984) block 210837946368 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 621625344) block 210908741632 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 623837184) block 210909085696 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 626323456) block 210909528064 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 636444672) block 238631813120 gen
>>>>>>>>>> 1443988
>>>>>>>>>>     key (20516966 EXTENT_DATA 637927424) block 224226033664 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 642646016) block 202396745728 gen
>>>>>>>>>> 1444331
>>>>>>>>>>     key (20516966 EXTENT_DATA 659083264) block 226792439808 gen
>>>>>>>>>> 1439935
>>>>>>>>>>     key (20516966 EXTENT_DATA 669257728) block 211273154560 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 670150656) block 164483465216 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 671039488) block 164483448832 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 671805440) block 164485595136 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 672665600) block 164485562368 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 673452032) block 164483497984 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 674205696) block 164487970816 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 675647488) block 238951858176 gen
>>>>>>>>>> 1439547
>>>>>>>>>>     key (20516966 EXTENT_DATA 676605952) block 224107675648 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 685223936) block 238951809024 gen
>>>>>>>>>> 1439547
>>>>>>>>>>     key (20516966 EXTENT_DATA 686133248) block 164534648832 gen
>>>>>>>>>> 1397336
>>>>>>>>>>     key (20516966 EXTENT_DATA 686575616) block 210852249600 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 687304704) block 211308363776 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 688599040) block 211273187328 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 689987584) block 210915983360 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 690569216) block 211358105600 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 691851264) block 211336413184 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 701837312) block 211493978112 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 703156224) block 211538690048 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 704167936) block 164493836288 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 704737280) block 164493819904 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 705576960) block 164493803520 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 706842624) block 164511956992 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 708247552) block 164512006144 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 710197248) block 164511973376 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 711176192) block 164512022528 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 712298496) block 164512169984 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 713072640) block 164512186368 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 714477568) block 164512202752 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 715161600) block 164459954176 gen
>>>>>>>>>> 1438630
>>>>>>>>>>     key (20516966 EXTENT_DATA 716636160) block 211538755584 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 726118400) block 223465586688 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 728231936) block 223465799680 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 729100288) block 224288309248 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 729538560) block 224288669696 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 730017792) block 223402016768 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 730841088) block 223403065344 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 731627520) block 223465144320 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 732479488) block 223465537536 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 733294592) block 223468879872 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 733904896) block 223488131072 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 734633984) block 223488868352 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 735215616) block 223490768896 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 735993856) block 163788718080 gen
>>>>>>>>>> 1438626
>>>>>>>>>>     key (20516966 EXTENT_DATA 736845824) block 163788996608 gen
>>>>>>>>>> 1438626
>>>>>>>>>>     key (20516966 EXTENT_DATA 737697792) block 163789537280 gen
>>>>>>>>>> 1438626
>>>>>>>>>>     key (20516966 EXTENT_DATA 738545664) block 163790077952 gen
>>>>>>>>>> 1438626
>>>>>>>>>>     key (20516966 EXTENT_DATA 739340288) block 163790340096 gen
>>>>>>>>>> 1438626
>>>>>>>>>>     key (20516966 EXTENT_DATA 740192256) block 163790487552 gen
>>>>>>>>>> 1438626
>>>>>>>>>>     key (20516966 EXTENT_DATA 741011456) block 163791142912 gen
>>>>>>>>>> 1438626
>>>>>>>>>>     key (20516966 EXTENT_DATA 741863424) block 163791290368 gen
>>>>>>>>>> 1438626
>>>>>>>>>>     key (20516966 EXTENT_DATA 742715392) block 163791405056 gen
>>>>>>>>>> 1438626
>>>>>>>>>>     key (20516966 EXTENT_DATA 743485440) block 223390285824 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 744759296) block 223390334976 gen
>>>>>>>>>> 1439933
>>>>>>>>>>     key (20516966 EXTENT_DATA 746999808) block 223422660608 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 747802624) block 223464964096 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 749133824) block 223465078784 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 751181824) block 223490031616 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 752517120) block 223493046272 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 753668096) block 223515492352 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 754909184) block 223532253184 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 755765248) block 223751962624 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 756449280) block 223540592640 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 757211136) block 223540789248 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 757850112) block 223541067776 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 758513664) block 223541985280 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 759169024) block 223565447168 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 759713792) block 223565643776 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 760565760) block 223573442560 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 762245120) block 227043786752 gen
>>>>>>>>>> 1439935
>>>>>>>>>>     key (20516966 EXTENT_DATA 763772928) block 223885590528 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 765255680) block 224022249472 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 766418944) block 224338804736 gen
>>>>>>>>>> 1439935
>>>>>>>>>>     key (20516966 EXTENT_DATA 768241664) block 224113967104 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 769867776) block 223503384576 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 770482176) block 223504285696 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 771244032) block 223511789568 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 771743744) block 223512100864 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 772595712) block 223512969216 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 773361664) block 224257163264 gen
>>>>>>>>>> 1439934
>>>>>>>>>>     key (20516966 EXTENT_DATA 773951488) block 224340983808 gen
>>>>>>>>>> 1439935
>>>>>>>>>>     key (20516966 EXTENT_DATA 774746112) block 163899850752 gen
>>>>>>>>>> 1438440
>>>>>>>>>>     key (20516966 EXTENT_DATA 775524352) block 164888084480 gen
>>>>>>>>>> 1438442
>>>>>>>>>>     key (20516966 EXTENT_DATA 776376320) block 164888346624 gen
>>>>>>>>>> 1438442
>>>>>>>>>>     key (20516966 EXTENT_DATA 777072640) block 165259034624 gen
>>>>>>>>>> 1438442
>>>>>>>>>>     key (20516966 EXTENT_DATA 777674752) block 226860810240 gen
>>>>>>>>>> 1439935
>>>>>>>>>>     key (20516966 EXTENT_DATA 780267520) block 227272769536 gen
>>>>>>>>>> 1439936
>>>>>>>>>>     key (20516966 EXTENT_DATA 789573632) block 227023208448 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 795152384) block 227024781312 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 795873280) block 227025125376 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 796712960) block 227025321984 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 797446144) block 227025420288 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 798355456) block 227026173952 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 799281152) block 227027386368 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 800145408) block 227027173376 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 800727040) block 227026862080 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 801345536) block 227026812928 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 802140160) block 227026501632 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 802836480) block 227026272256 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 803655680) block 227027795968 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 804376576) block 227027615744 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 805261312) block 205484032000 gen
>>>>>>>>>> 1439460
>>>>>>>>>>     key (20516966 EXTENT_DATA 806207488) block 227027599360 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 806748160) block 227027582976 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 807702528) block 227027517440 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 808386560) block 227027402752 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 809234432) block 227027894272 gen
>>>>>>>>>> 1439468
>>>>>>>>>>     key (20516966 EXTENT_DATA 810024960) block 1280884736  
>>>>>>>>>> gen 1447385
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> With output, I still need to dump the offending inode of the
>>>>>>>>>>> subvolume
>>>>>>>>>>> later.
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Qu
>>>>>>>>>>>>
>>>>>>>>>>>> Best regards,
>>>>>>>>>>>> Hendrik
>>>>>>>>>>>>
>>>>>>>>>>>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>>>>>>>>>
>>>>>>>>>>>>> On 2023/5/10 23:14, hendrik@friedels.name wrote:
>>>>>>>>>>>>>> Thanks Qu,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> compiling (and make install) worked.
>>>>>>>>>>>>>> However, I still get no list of the affected files:
>>>>>>>>>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal
>>>>>>>>>>>>>> logical-resolve
>>>>>>>>>>>>>> 256655245312 /mnt/temp/
>>>>>>>>>>>>>> /dev/sda3 on /mnt/temp type btrfs
>>>>>>>>>>>>>> (rw,relatime,ssd,space_cache,subvolid=5,subvol=/)
>>>>>>>>>>>>>
>>>>>>>>>>>>> It's possible the bytenr is for deleted files, in that case
>>>>>>>>>>>>> logical-resolve won't find the filename.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Are the NNNNNNN (here 256655245312) changing after reboot?
>>>>>>>>>>>>>> I did in the meantime reboot, so currently the dmesg does not
>>>>>>>>>>>>>> have any
>>>>>>>>>>>>>> errors...
>>>>>>>>>>>>>> Do I need to run scrub again?
>>>>>>>>>>>>>
>>>>>>>>>>>>> It's better to scrub again to make sure if the affected extent is
>>>>>>>>>>>>> gone.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Greetings,
>>>>>>>>>>>>>> Hendrik
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Quoting Qu Wenruo <wqu@suse.com>:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 2023/5/10 01:26, hendrik@friedels.name wrote:
>>>>>>>>>>>>>>>> Hi Qu,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> thanks for your reply.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I feel a bit helpless:
>>>>>>>>>>>>>>>> wget
>>>>>>>>>>>>>>>> https://github.com/kdave/btrfs-progs/archive/16f9a8f43a4ed6984349b502151049212838e6a0.zip
>>>>>>>>>>>>>>>> unpack, change into dir
>>>>>>>>>>>>>>>> patch --dry-run -ruN --strip 1 < ../patch
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> checking file Documentation/btrfs-inspect-internal.rst
>>>>>>>>>>>>>>>> checking file cmds/inspect.c
>>>>>>>>>>>>>>>> Hunk #1 FAILED at 167.
>>>>>>>>>>>>>>>> Hunk #2 FAILED at 216.
>>>>>>>>>>>>>>>> Hunk #3 FAILED at 258.
>>>>>>>>>>>>>>>> 3 out of 3 hunks FAILED
>>>>>>>>>>>>>>>> checking file common/utils.c
>>>>>>>>>>>>>>>> Hunk #1 FAILED at 424.
>>>>>>>>>>>>>>>> Hunk #2 succeeded at 528 with fuzz 1.
>>>>>>>>>>>>>>>> 1 out of 2 hunks FAILED
>>>>>>>>>>>>>>>> checking file
>>>>>>>>>>>>>>>> tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
>>>>>>>>>>>>>>>> Hunk #1 FAILED at 51.
>>>>>>>>>>>>>>>> 1 out of 1 hunk FAILED
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> What am I doing wrong?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Please grab this branch directly:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> https://github.com/adam900710/btrfs-progs/tree/logic_resolve
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> You can go git command to fetch that branch or through the
>>>>>>>>>>>>>>> webUI to
>>>>>>>>>>>>>>> download the zip.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Best regards,
>>>>>>>>>>>>>>>> Hendrik
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On 2023/5/9 02:51, hendrik@friedels.name wrote:
>>>>>>>>>>>>>>>>>> Dear Qu,
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> great, thank you!
>>>>>>>>>>>>>>>>>> Can you tell me, where to find the basis for this patch?
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I tried to patch against master of
>>>>>>>>>>>>>>>>>> https://github.com/kdave/btrfs-progs, but that seems wrong:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> checking file Documentation/btrfs-inspect-internal.rst
>>>>>>>>>>>>>>>>>> checking file cmds/inspect.c
>>>>>>>>>>>>>>>>>> Hunk #1 FAILED at 167.
>>>>>>>>>>>>>>>>>> Hunk #2 FAILED at 216.
>>>>>>>>>>>>>>>>>> Hunk #3 FAILED at 258.
>>>>>>>>>>>>>>>>>> 3 out of 3 hunks FAILED
>>>>>>>>>>>>>>>>>> checking file common/utils.c
>>>>>>>>>>>>>>>>>> Hunk #1 FAILED at 424.
>>>>>>>>>>>>>>>>>> Hunk #2 succeeded at 528 with fuzz 1.
>>>>>>>>>>>>>>>>>> 1 out of 2 hunks FAILED
>>>>>>>>>>>>>>>>>> checking file
>>>>>>>>>>>>>>>>>> tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
>>>>>>>>>>>>>>>>>> Hunk #1 FAILED at 51.
>>>>>>>>>>>>>>>>>> 1 out of 1 hunk FAILED
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I have also tried to patch against v6.3 also with failed
>>>>>>>>>>>>>>>>>> Hunks.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> It needs to be applied to David's devel branch.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I applied against 16f9a8f43a4ed6984349b502151049212838e6a0
>>>>>>>>>>>>>>>>> btrfs-progs: build: enable -Wmissing-prototypes, and it
>>>>>>>>>>>>>>>>> works as
>>>>>>>>>>>>>>>>> expected.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Best regards,
>>>>>>>>>>>>>>>>>> Hendrik
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> On 2023/4/5 16:41, Hendrik Friedel wrote:
>>>>>>>>>>>>>>>>>>>> Hello Andrei,
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> this partially works:
>>>>>>>>>>>>>>>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal
>>>>>>>>>>>>>>>>>>>> logical-resolve 254530580480
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> The user interface of logical-resolve is a total mess, it
>>>>>>>>>>>>>>>>>>> requires
>>>>>>>>>>>>>>>>>>> every subvolume to be mounted.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> You can apply this patch, and mount the subvolid 5, then
>>>>>>>>>>>>>>>>>>> logical-resolve would properly handle all the path lookup:
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/7ccf52d35fdcdf743a254f3c93065f9334d878f8.1681971385.git.wqu@suse.com/
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
>>>>>>>>>>>>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/582/snapshot
>>>>>>>>>>>>>>>>>>>> could
>>>>>>>>>>>>>>>>>>>> not be accessed: not mounted
>>>>>>>>>>>>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/586/snapshot
>>>>>>>>>>>>>>>>>>>> could
>>>>>>>>>>>>>>>>>>>> not be accessed: not mounted
>>>>>>>>>>>>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/583/snapshot
>>>>>>>>>>>>>>>>>>>> could
>>>>>>>>>>>>>>>>>>>> not be accessed: not mounted
>>>>>>>>>>>>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/584/snapshot
>>>>>>>>>>>>>>>>>>>> could
>>>>>>>>>>>>>>>>>>>> not be accessed: not mounted
>>>>>>>>>>>>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/581/snapshot
>>>>>>>>>>>>>>>>>>>> could
>>>>>>>>>>>>>>>>>>>> not be accessed: not mounted
>>>>>>>>>>>>>>>>>>>> inode 22214605 subvol dockerconfig/.snapshots/585/snapshot
>>>>>>>>>>>>>>>>>>>> could
>>>>>>>>>>>>>>>>>>>> not be accessed: not mounted
>>>>>>>>>>>>>>>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal
>>>>>>>>>>>>>>>>>>>> logical-resolve 224457719808
>>>>>>>>>>>>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
>>>>>>>>>>>>>>>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal
>>>>>>>>>>>>>>>>>>>> logical-resolve 196921389056
>>>>>>>>>>>>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
>>>>>>>>>>>>>>>>>>>> root@homeserver:/home/henfri# btrfs inspect-internal
>>>>>>>>>>>>>>>>>>>> logical-resolve 254530899968
>>>>>>>>>>>>>>>>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> I do not quite understand, why it complains of the subvol
>>>>>>>>>>>>>>>>>>>> not
>>>>>>>>>>>>>>>>>>>> being mounted, as I have mounted the root-volume...
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> However, it already shows that some of the files  
>>>>>>>>>>>>>>>>>>>> (all that I
>>>>>>>>>>>>>>>>>>>> found) are in snapshots, which are read only...
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> I am not sure, what the best way would be to get  
>>>>>>>>>>>>>>>>>>>> rid of the
>>>>>>>>>>>>>>>>>>>> errors. Do you have any suggestion?
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Best regards,
>>>>>>>>>>>>>>>>>>>> Hendrik
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> ------ Originalnachricht ------
>>>>>>>>>>>>>>>>>>>> Von "Andrei Borzenkov" <arvidjaar@gmail.com>
>>>>>>>>>>>>>>>>>>>> An "Hendrik Friedel" <hendrik@friedels.name>
>>>>>>>>>>>>>>>>>>>> Cc linux-btrfs@vger.kernel.org
>>>>>>>>>>>>>>>>>>>> Datum 04.04.2023 21:07:42
>>>>>>>>>>>>>>>>>>>> Betreff Re: Scrub errors unable to fixup (regular) error
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> On 03.04.2023 09:44, Hendrik Friedel wrote:
>>>>>>>>>>>>>>>>>>>>>> Hello,
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> thanks.
>>>>>>>>>>>>>>>>>>>>>> Can you Tell ne, how I identify the affected files?
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> You could try
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> btrfs inspect-internal logical-resolve NNNNN
>>>>>>>>>>>>>>>>>>>>> /btrfs/mount/point
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> where NNNNN is logical address from kernel message
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> Best regards,
>>>>>>>>>>>>>>>>>>>>>> Hendrik
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> Am 03.04.2023 08:41 schrieb Andrei Borzenkov
>>>>>>>>>>>>>>>>>>>>>> <arvidjaar@gmail.com>:
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>      On Sun, Apr 2, 2023 at 10:26 PM Hendrik Friedel
>>>>>>>>>>>>>>>>>>>>>> <hendrik@friedels.name> wrote:
>>>>>>>>>>>>>>>>>>>>>>       >
>>>>>>>>>>>>>>>>>>>>>>       > Hello,
>>>>>>>>>>>>>>>>>>>>>>       >
>>>>>>>>>>>>>>>>>>>>>>       > after a scrub, I had these errors:
>>>>>>>>>>>>>>>>>>>>>>       > [Sa Apr  1 23:23:28 2023] BTRFS info (device
>>>>>>>>>>>>>>>>>>>>>> sda3):
>>>>>>>>>>>>>>>>>>>>>> scrub: started on
>>>>>>>>>>>>>>>>>>>>>>       > devid 1
>>>>>>>>>>>>>>>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device
>>>>>>>>>>>>>>>>>>>>>> sda3):
>>>>>>>>>>>>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 63, gen 0
>>>>>>>>>>>>>>>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device
>>>>>>>>>>>>>>>>>>>>>> sda3):
>>>>>>>>>>>>>>>>>>>>>> unable to fixup
>>>>>>>>>>>>>>>>>>>>>>       > (regular) error at logical 2244718592 on dev
>>>>>>>>>>>>>>>>>>>>>> /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device
>>>>>>>>>>>>>>>>>>>>>> sda3):
>>>>>>>>>>>>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 64, gen 0
>>>>>>>>>>>>>>>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device
>>>>>>>>>>>>>>>>>>>>>> sda3):
>>>>>>>>>>>>>>>>>>>>>> unable to fixup
>>>>>>>>>>>>>>>>>>>>>>       > (regular) error at logical 2260582400 on dev
>>>>>>>>>>>>>>>>>>>>>> /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device
>>>>>>>>>>>>>>>>>>>>>> sda3):
>>>>>>>>>>>>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 65, gen 0
>>>>>>>>>>>>>>>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device
>>>>>>>>>>>>>>>>>>>>>> sda3):
>>>>>>>>>>>>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 66, gen 0
>>>>>>>>>>>>>>>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device
>>>>>>>>>>>>>>>>>>>>>> sda3):
>>>>>>>>>>>>>>>>>>>>>> unable to fixup
>>>>>>>>>>>>>>>>>>>>>>       > (regular) error at logical 2260054016 on dev
>>>>>>>>>>>>>>>>>>>>>> /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device
>>>>>>>>>>>>>>>>>>>>>> sda3):
>>>>>>>>>>>>>>>>>>>>>> unable to fixup
>>>>>>>>>>>>>>>>>>>>>>       > (regular) error at logical 2259877888 on dev
>>>>>>>>>>>>>>>>>>>>>> /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device
>>>>>>>>>>>>>>>>>>>>>> sda3):
>>>>>>>>>>>>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 67, gen 0
>>>>>>>>>>>>>>>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device
>>>>>>>>>>>>>>>>>>>>>> sda3):
>>>>>>>>>>>>>>>>>>>>>> unable to fixup
>>>>>>>>>>>>>>>>>>>>>>       > (regular) error at logical 2259935232 on dev
>>>>>>>>>>>>>>>>>>>>>> /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device
>>>>>>>>>>>>>>>>>>>>>> sda3):
>>>>>>>>>>>>>>>>>>>>>> bdev /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 68, gen 0
>>>>>>>>>>>>>>>>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device
>>>>>>>>>>>>>>>>>>>>>> sda3):
>>>>>>>>>>>>>>>>>>>>>> unable to fixup
>>>>>>>>>>>>>>>>>>>>>>       > (regular) error at logical 2264600576 on dev
>>>>>>>>>>>>>>>>>>>>>> /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       >
>>>>>>>>>>>>>>>>>>>>>>       >
>>>>>>>>>>>>>>>>>>>>>>       > root@homeserver:~# btrfs scrub status /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       > UUID:
>>>>>>>>>>>>>>>>>>>>>> c1534c07-d669-4f55-ae50-b87669ecb259
>>>>>>>>>>>>>>>>>>>>>>       > Scrub started:    Sat Apr  1 23:24:01 2023
>>>>>>>>>>>>>>>>>>>>>>       > Status:           finished
>>>>>>>>>>>>>>>>>>>>>>       > Duration:         0:09:03
>>>>>>>>>>>>>>>>>>>>>>       > Total to scrub:   146.79GiB
>>>>>>>>>>>>>>>>>>>>>>       > Rate:             241.40MiB/s
>>>>>>>>>>>>>>>>>>>>>>       > Error summary:    csum=239
>>>>>>>>>>>>>>>>>>>>>>       >    Corrected:      0
>>>>>>>>>>>>>>>>>>>>>>       >    Uncorrectable:  239
>>>>>>>>>>>>>>>>>>>>>>       >    Unverified:     0
>>>>>>>>>>>>>>>>>>>>>>       > root@homeserver:~# btrfs fi show /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       > Label: none  uuid:
>>>>>>>>>>>>>>>>>>>>>> c1534c07-d669-4f55-ae50-b87669ecb259
>>>>>>>>>>>>>>>>>>>>>>       >          Total devices 1 FS bytes used 146.79GiB
>>>>>>>>>>>>>>>>>>>>>>       >          devid    1 size 198.45GiB used  
>>>>>>>>>>>>>>>>>>>>>> 198.45GiB
>>>>>>>>>>>>>>>>>>>>>> path
>>>>>>>>>>>>>>>>>>>>>> /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>       >
>>>>>>>>>>>>>>>>>>>>>>       >
>>>>>>>>>>>>>>>>>>>>>>       > Smartctl tells me:
>>>>>>>>>>>>>>>>>>>>>>       > SMART Attributes Data Structure revision
>>>>>>>>>>>>>>>>>>>>>> number: 16
>>>>>>>>>>>>>>>>>>>>>>       > Vendor Specific SMART Attributes with  
>>>>>>>>>>>>>>>>>>>>>> Thresholds:
>>>>>>>>>>>>>>>>>>>>>>       > ID# ATTRIBUTE_NAME          FLAG     VALUE WORST
>>>>>>>>>>>>>>>>>>>>>> THRESH
>>>>>>>>>>>>>>>>>>>>>> TYPE
>>>>>>>>>>>>>>>>>>>>>>       > UPDATED  WHEN_FAILED RAW_VALUE
>>>>>>>>>>>>>>>>>>>>>>       >    1 Raw_Read_Error_Rate     0x002f   100   100
>>>>>>>>>>>>>>>>>>>>>> 000
>>>>>>>>>>>>>>>>>>>>>>  Pre-fail  Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       2
>>>>>>>>>>>>>>>>>>>>>>       >    5 Reallocate_NAND_Blk_Cnt 0x0032   100   100
>>>>>>>>>>>>>>>>>>>>>> 010
>>>>>>>>>>>>>>>>>>>>>>  Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       2
>>>>>>>>>>>>>>>>>>>>>>       >    9 Power_On_Hours          0x0032   100   100
>>>>>>>>>>>>>>>>>>>>>> 000
>>>>>>>>>>>>>>>>>>>>>>  Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       4930
>>>>>>>>>>>>>>>>>>>>>>       >   12 Power_Cycle_Count       0x0032   100   100
>>>>>>>>>>>>>>>>>>>>>> 000
>>>>>>>>>>>>>>>>>>>>>>  Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       1864
>>>>>>>>>>>>>>>>>>>>>>       > 171 Program_Fail_Count      0x0032   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       0
>>>>>>>>>>>>>>>>>>>>>>       > 172 Erase_Fail_Count        0x0032   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       0
>>>>>>>>>>>>>>>>>>>>>>       > 173 Ave_Block-Erase_Count   0x0032   049
>>>>>>>>>>>>>>>>>>>>>> 049   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       769
>>>>>>>>>>>>>>>>>>>>>>       > 174 Unexpect_Power_Loss_Ct  0x0032   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       22
>>>>>>>>>>>>>>>>>>>>>>       > 183 SATA_Interfac_Downshift 0x0032   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       0
>>>>>>>>>>>>>>>>>>>>>>       > 184 Error_Correction_Count  0x0032   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       0
>>>>>>>>>>>>>>>>>>>>>>       > 187 Reported_Uncorrect      0x0032   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       0
>>>>>>>>>>>>>>>>>>>>>>       > 194 Temperature_Celsius     0x0022   068
>>>>>>>>>>>>>>>>>>>>>> 051   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       32 (Min/Max 9/49)
>>>>>>>>>>>>>>>>>>>>>>       > 196 Reallocated_Event_Count 0x0032   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       2
>>>>>>>>>>>>>>>>>>>>>>       > 197 Current_Pending_ECC_Cnt 0x0032   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       0
>>>>>>>>>>>>>>>>>>>>>>       > 198 Offline_Uncorrectable   0x0030   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age
>>>>>>>>>>>>>>>>>>>>>>       > Offline      -       0
>>>>>>>>>>>>>>>>>>>>>>       > 199 UDMA_CRC_Error_Count    0x0032   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       0
>>>>>>>>>>>>>>>>>>>>>>       > 202 Percent_Lifetime_Remain 0x0030   049
>>>>>>>>>>>>>>>>>>>>>> 049   001
>>>>>>>>>>>>>>>>>>>>>> Old_age
>>>>>>>>>>>>>>>>>>>>>>       > Offline      -       51
>>>>>>>>>>>>>>>>>>>>>>       > 206 Write_Error_Rate        0x000e   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       0
>>>>>>>>>>>>>>>>>>>>>>       > 246 Total_LBAs_Written      0x0032   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       146837983747
>>>>>>>>>>>>>>>>>>>>>>       > 247 Host_Program_Page_Count 0x0032   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       4592609183
>>>>>>>>>>>>>>>>>>>>>>       > 248 FTL_Program_Page_Count  0x0032   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       4948954393
>>>>>>>>>>>>>>>>>>>>>>       > 180 Unused_Reserve_NAND_Blk 0x0033   000
>>>>>>>>>>>>>>>>>>>>>> 000   000
>>>>>>>>>>>>>>>>>>>>>> Pre-fail  Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       2050
>>>>>>>>>>>>>>>>>>>>>>       > 210 Success_RAIN_Recov_Cnt  0x0032   100
>>>>>>>>>>>>>>>>>>>>>> 100   000
>>>>>>>>>>>>>>>>>>>>>> Old_age   Always
>>>>>>>>>>>>>>>>>>>>>>       >        -       0
>>>>>>>>>>>>>>>>>>>>>>       >
>>>>>>>>>>>>>>>>>>>>>>       > What would you recommend wrt. the health of the
>>>>>>>>>>>>>>>>>>>>>> drive
>>>>>>>>>>>>>>>>>>>>>> (ssd) and to fix
>>>>>>>>>>>>>>>>>>>>>>       > these errors?
>>>>>>>>>>>>>>>>>>>>>>       >
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>      Scrub errors can only be corrected if the  
>>>>>>>>>>>>>>>>>>>>>> filesystem
>>>>>>>>>>>>>>>>>>>>>> has
>>>>>>>>>>>>>>>>>>>>>> redundancy.
>>>>>>>>>>>>>>>>>>>>>>      You have a single device which in the past
>>>>>>>>>>>>>>>>>>>>>> defaulted to
>>>>>>>>>>>>>>>>>>>>>> dup for
>>>>>>>>>>>>>>>>>>>>>>      metadata and single for data. If errors are in the
>>>>>>>>>>>>>>>>>>>>>> data
>>>>>>>>>>>>>>>>>>>>>> part, then the
>>>>>>>>>>>>>>>>>>>>>>      only way to fix it is to delete files containing
>>>>>>>>>>>>>>>>>>>>>> these
>>>>>>>>>>>>>>>>>>>>>> blocks.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>      Scrub error means data written to stable storage is
>>>>>>>>>>>>>>>>>>>>>> bad.
>>>>>>>>>>>>>>>>>>>>>> It is
>>>>>>>>>>>>>>>>>>>>>>      unlikely caused by SSD error, could be  
>>>>>>>>>>>>>>>>>>>>>> software bug,
>>>>>>>>>>>>>>>>>>>>>> could
>>>>>>>>>>>>>>>>>>>>>> be faulty
>>>>>>>>>>>>>>>>>>>>>>      RAM.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>
>>>>
>>>>
>>
>>
>>



