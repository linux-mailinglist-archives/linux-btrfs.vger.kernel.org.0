Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F0865936A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Dec 2022 01:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbiL3ABM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Dec 2022 19:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiL3ABK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Dec 2022 19:01:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0194B1740C
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Dec 2022 16:01:08 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUGe1-1pJbPs2FoR-00RGIE; Fri, 30
 Dec 2022 01:00:52 +0100
Message-ID: <58f08b77-f8cc-c2f8-a1ec-135ce48fbd8e@gmx.com>
Date:   Fri, 30 Dec 2022 08:00:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Sam Winchenbach <swichenbach@tethers.com>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
Cc:     "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <62218a2a5a274ada96f97f7ac4e151ef@tethers.com>
 <bc82fc52-18b8-1205-5509-6fcd24529bea@gmx.de>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Possible bug in BTRFS w/ Duplication
In-Reply-To: <bc82fc52-18b8-1205-5509-6fcd24529bea@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wWg055236Xpz54bqDH2ddSUfGYJsgXFKc9+R3Nj4iAYV5KqP8Tm
 tXwEeIrUjl101Zdiy7ppcQTQdvRbYl2Vyi3891R79QQsdpk4TdvQJm4/DMkt4lpfczcaK4E
 z7YaDdSyf+N7XWuw1WuAPZ1cS21nS8vECTQQ4I2V2Bwk7Rgd9PxEpnhp0NmvRhr4HbvXln4
 wFJAxjdeoYoTJgTuEZ3WA==
UI-OutboundReport: notjunk:1;M01:P0:zzPFJ2h/kuo=;1bD927/emtHEnmLMNjS/h+saXIc
 oRmfRTqSbkj2B1wa682rnr4GCjPhqMukBA7UiyqUZfLDUVVrzLe/I1cnO6X9YEjMnFSUSuYWo
 p7KMj+tVOt9lDj66ukNhpdqC9QTF7GxJbiPPhwuB4tn7YDB4TYkjj1KF4pKEb7ozdIeCG7Qf4
 /6HS+0mUyUnSAJ7l1hj9kuVFq1N9WVtTCnsyilBVhhDRkCwneH4hmiaVjR4Jl54409SSUjJX7
 OCwBV6x7TUrXUjDPhRP4erWqY8Vm/QOtgF3tX84n5Jbw11lPAFKAmouWqXhNirABZ1H+eu8PA
 Ds4o1Xs4ss08NPDqrg6oLIkVtzPZxp0gAaqsovUHXJpATMDJ1NUzLoi9NG4uG/h2HZjfcbqJL
 PDDLdQAOGWqkuSbPEzx+CkZLGLcCQ1wdwuypKrtfLP1gfj0RcbQwod2p63mpH1CQBgxoiRJ53
 ffNrtF6kjgrkfhJ8JI5kZs+eHlGOxhC7gDUAYUUUnp9VWg8FKu56VN17MPFjPeW6pGw4WjcMA
 tAz1dzaTVqUj2rB4pDwiQq2MpwZUQEtPmBluhg49TYadytv+CUTaw7IIJcroTgEkMXHPxUfZd
 ws51hGchcgnZNQ7QJh/fPF/XnUvCYTXfsQ6nBCTfbbzsBfyEqDz6qxpDwebGV7X9eH2vApQwG
 XyQbAsKZI9rlKiSL/I7xrf+agomEZmxxWT5SRLdhAUu82Dx9UJJP+sEa8/Zv+Z8ITXCQ9Zah4
 Ft/LD9JSoakzx+UMxwQewK5/JbxWLiCDfAMlQQXyR0hOcTnz8ZjmwG6RDT1fv2qwOhynWCTx6
 xzbYB8cq0/hUFBSLgI8Tc8Bbk4KsKc/G0w5S0LEWcIdbgER81q3RV03bTpR9HO+lca88O/cce
 Oubx51kr/6Uc8ClPd7NrUh8WtbdSf4W81ztglRnWNbLRR3uWxdMi/RaWH6rmXrWhY8RFSFBnb
 fEgC4KkFhLuTNl8UUdNIoxAUIpA=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/29 22:12, Heinrich Schuchardt wrote:
> On 12/28/22 21:51, Sam Winchenbach wrote:
>> Hello,
>>
>> Hello, I have hit the following situation when trying to load files 
>> from a BTRFS partition with duplication enabled.

You mean multi-device?

For DUP/RAID1 duplication, they don't have stripe limitation at all.

Thus I believe you're talking about RAID0 (which doesn't have any 
duplication/extra mirrors) or RAID10 or RAID5/6?

But for now, we don't support multi-device in U-boot yet, thus I'm not 
sure what situation you're talking about.

Mind to run the following command?

  # btrfs fi usage <mnt of the btrfs>

>>
>> In the first example I read a 16KiB file - __btrfs_map_block() changes 
>> the length to something larger than the file being read. This works 
>> fine, as length is later clamped to the file size.
>>
>> In the second example, __btrfs_map_block() changes the length 
>> parameter to something smaller than the file (the size of a stripe).  
>> This seems to break this check here:
>>
>>      read = len;
>>      num_copies = btrfs_num_copies(fs_info, logical, len);
>>      for (i = 1; i <= num_copies; i++) {
>>          ret = read_extent_data(fs_info, dest, logical, &read, i);
>>          if (ret < 0 || read != len) {
>>              continue;
>>          }
>>          finished = true;
>>          break;
>>      }
>>
>> The problem being that read is always less than len.
>>
>> I am not sure if __btrfs_map_block is changing "len" to the incorrect 
>> value, or if there is some logic in "read_extent_data" that isn't 
>> correct. Any pointers on how this code is supposed to work would be 
>> greatly appreciated.
>> Thanks.
> 
> Thanks for reporting the issue
> 
> $ scripts/get_maintainer.pl -f fs/btrfs/volumes.c
> 
> suggests to include
> 
> "Marek Behún" <kabel@kernel.org> (maintainer:BTRFS)
> Qu Wenruo <wqu@suse.com> (reviewer:BTRFS)
> linux-btrfs@vger.kernel.org
> 
> to the communication.
> 
> Best regards
> 
> Heinrich
> 
>>
>> === EXAMPLE 2 ===
>> Zynq> load mmc 1:0 0 16K
>> [btrfs_file_read,fs/btrfs/inode.c:710] === read the aligned part ===
>> [btrfs_read_extent_reg,fs/btrfs/inode.c:458] before read_extent_data 
>> (ret = 0, read = 16384, len = 16384)
>> [read_extent_data,fs/btrfs/disk-io.c:547] before __btrfs_map_block 
>> (len = 16384)
>> [read_extent_data,fs/btrfs/disk-io.c:550] after __btrfs_map_block (len 
>> = 28672)
>> [read_extent_data,fs/btrfs/disk-io.c:565] before __btrfs_devread (len 
>> = 16384)
>> [read_extent_data,fs/btrfs/disk-io.c:568] after __btrfs_devread (len = 
>> 16384)
>> [btrfs_read_extent_reg,fs/btrfs/inode.c:460] after read_extent_data 
>> (ret = 0, read = 16384, len = 16384)
>> cur: 0, extent_num_bytes: 16384, aligned_end: 16384
>> 16384 bytes read in 100 ms (159.2 KiB/s)
>>
>> === EXAMPLE 2 ===
>> Zynq> load mmc 1:0 0 32K
>> [btrfs_file_read,fs/btrfs/inode.c:710] === read the aligned part ===
>> [btrfs_read_extent_reg,fs/btrfs/inode.c:458] before read_extent_data 
>> (ret = 0, read = 32768, len = 32768)
>> [read_extent_data,fs/btrfs/disk-io.c:547] before __btrfs_map_block 
>> (len = 32768)
>> [read_extent_data,fs/btrfs/disk-io.c:550] after __btrfs_map_block (len 
>> = 12288)
>> [read_extent_data,fs/btrfs/disk-io.c:565] before __btrfs_devread (len 
>> = 12288)
>> [read_extent_data,fs/btrfs/disk-io.c:568] after __btrfs_devread (len = 
>> 12288)

So the first 3 sectors are before the stripe boundary and we read it 
correctly.

>> [btrfs_read_extent_reg,fs/btrfs/inode.c:460] after read_extent_data 
>> (ret = 0, read = 12288, len = 32768)
>> [btrfs_read_extent_reg,fs/btrfs/inode.c:458] before read_extent_data 
>> (ret = 0, read = 12288, len = 32768)
>> [read_extent_data,fs/btrfs/disk-io.c:547] before __btrfs_map_block 
>> (len = 12288)
>> [read_extent_data,fs/btrfs/disk-io.c:550] after __btrfs_map_block (len 
>> = 12288)

I believe this is the problem.

If we're reading the full 32K, and the first 12K is in the first stripe, 
we should then try to map the remaining 20K, not the 12K again.

I'll look into the situation.
But if you can provide the image or the dump, it can greatly help the 
debugging.

Thanks,
Qu

>> [read_extent_data,fs/btrfs/disk-io.c:565] before __btrfs_devread (len 
>> = 12288)
>> [read_extent_data,fs/btrfs/disk-io.c:568] after __btrfs_devread (len = 
>> 12288)
>> [btrfs_read_extent_reg,fs/btrfs/inode.c:460] after read_extent_data 
>> (ret = 0, read = 12288, len = 32768)
>> file: fs/btrfs/inode.c, line: 468
>> cur: 0, extent_num_bytes: 32768, aligned_end: 32768
>> -----> btrfs_read_extent_reg: -5, line: 758
>> BTRFS: An error occurred while reading file 32K
>> Failed to load '32K'
>>
>>
>>
>>
>>
>> Sam Winchenbach
>> Embedded Software Engineer III
>> Tethers Unlimited, Inc. | Connect Your Universe | www.tethers.com
>> swinchenbach@tethers.com | C: 207-974-6934
>> 11711 North Creek Pkwy # D113, Bothell, WA 98011-8808, USA
> 
