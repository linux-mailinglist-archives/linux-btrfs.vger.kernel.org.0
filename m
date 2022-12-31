Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7237659F41
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Dec 2022 01:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiLaAKj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Dec 2022 19:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiLaAKh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Dec 2022 19:10:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4811E3C5
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Dec 2022 16:10:36 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5mGB-1omOXs1H35-017I8G; Sat, 31
 Dec 2022 01:10:24 +0100
Message-ID: <9aefd92a-2198-fe96-078e-0b9ccc84c630@gmx.com>
Date:   Sat, 31 Dec 2022 08:10:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Possible bug in BTRFS w/ Duplication
To:     Sam Winchenbach <swichenbach@tethers.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
Cc:     "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <62218a2a5a274ada96f97f7ac4e151ef@tethers.com>
 <bc82fc52-18b8-1205-5509-6fcd24529bea@gmx.de>
 <58f08b77-f8cc-c2f8-a1ec-135ce48fbd8e@gmx.com>
 <642db528742c47d79ee0314db67a1bed@tethers.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <642db528742c47d79ee0314db67a1bed@tethers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ldmzDEdjVymBTGe2WQRFi/vJmQGf0bBNAJUNdPiE2UCzla0LU1H
 FAOIrztAziLtaFvdewJoslaGHZcsVVpo2Dxt2XL3cEV8tWN+E+zCzmyWeKtkwhNAM/9zY50
 MODG6DYmnG9IIQK4CNOu8z1ni5aDS087GFs+Wog5cXvL0n4/PkL6g1tebtWj6hWL0GAiyi7
 VfzNeVUECakZBpWbVweQw==
UI-OutboundReport: notjunk:1;M01:P0:iKFFirkXh/w=;swjmMjZsCAlX03O0W9b0b7BJX8H
 oXltO0xoe5416Cfex7HiO4yHaSSJQ4u4UJ0E+2ozl0pFEtFlqMNPuHT5mBTl4RAus2rP+G/+r
 sfEPztk+60BNFDvYhBuSQdtk3jx9kGhjsVZay5lzfixy1M28/0Le7VXrdoF1PrevVR5OQY6/j
 3i5yfmZPCBuFhoZpbFeKTntiNWBB9wqTJO5VfCO2GMKryxjs8qlZNIPPfuW28g4q/rucHqNgd
 43eJhqxYnLfTdKC9ZLfQT31+F8REY2aAzB4qRuQWQeX59vS5RHNJqo6HsfiFoi8oeQFjbNLrw
 JeTrgl/BsoZD3dHEg/3r2qaCQWeC2i75jtWpOAP9kvWDNoYvrQlMPZY2RQd51dDy2BeOJPf8Q
 VMeAFbeeNQaY29hJFZdPUTyqDXO+tJ6lcxz3twc8PU0tgcoiSubhqF9nAfRprcmJiRjx/Q+0I
 iSL9SKfo1DLj9AppOx/HkmC3g0o3W6qafiZ/U1A77iyxa5ZcesppNBqHLgggLkVsWQL/IDQUu
 EQwQYbS1I+5DVeXhcz3mPsxbIQm7sxzPPi7YDQsCOJh+QPFwHkJfG/V5paaLGiIEyijVGwQgS
 fxhVshP8KxbYFrFrFLqff81zoujQvxBCtgjsLhdsYUu2Io/lJ2p/N7zr19PwbfY6fJ6FU2OQe
 VyOCu36XjgtoL+u9u1VajqzlBRdzzcNbEhvkits4b+h6IzQKC6czu9+3fkGLpHqei2UOgSgqk
 RVFUjeasXWqsqdXjpl1U5Z59WH1AujYfAN5ZE1NAh+8xvcsruYFluvKNNzJUaaYJ7v7YFqO9t
 CShVcjo2OxU8TPr4yihICcpZM5sIVLNmEWJxvJZFopv4WM1emd1MjVi7t1nAxa4QYQ5tMdQUk
 lctqfQ7ThRccwGUsaQsn/e7TKtesxS6ugFdrutTGfzWeuZhBlKujchT/umx8RoBQ6YqJ6U3s0
 bzS23M633/cI3jk6LAQ+OOTaulw=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/30 23:28, Sam Winchenbach wrote:
> I believe you fixed the issue with the patch you presented. I was in the process of testing a similar fix for release and it solved the issue I encountered.

But I still want to make sure that only RAID0 on single device can cause 
the problem.

For multi-device RAID0/RAID10/RAID5/6, we don't support them until we 
can scan all devices in U-boot...

Thanks,
Qu
> 
> Thanks,
> Sam Winchenbach
> 
> -----Original Message-----
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Qu Wenruo
> Sent: Thursday, December 29, 2022 7:01 PM
> To: Heinrich Schuchardt <xypron.glpk@gmx.de>; Sam Winchenbach <swichenbach@tethers.com>; Marek Behún <kabel@kernel.org>
> Cc: u-boot@lists.denx.de; Qu Wenruo <wqu@suse.com>; linux-btrfs@vger.kernel.org
> Subject: Re: Possible bug in BTRFS w/ Duplication
> 
> 
> 
> On 2022/12/29 22:12, Heinrich Schuchardt wrote:
>> On 12/28/22 21:51, Sam Winchenbach wrote:
>>> Hello,
>>>
>>> Hello, I have hit the following situation when trying to load files
>>> from a BTRFS partition with duplication enabled.
> 
> You mean multi-device?
> 
> For DUP/RAID1 duplication, they don't have stripe limitation at all.
> 
> Thus I believe you're talking about RAID0 (which doesn't have any duplication/extra mirrors) or RAID10 or RAID5/6?
> 
> But for now, we don't support multi-device in U-boot yet, thus I'm not sure what situation you're talking about.
> 
> Mind to run the following command?
> 
>    # btrfs fi usage <mnt of the btrfs>
> 
>>>
>>> In the first example I read a 16KiB file - __btrfs_map_block()
>>> changes the length to something larger than the file being read. This
>>> works fine, as length is later clamped to the file size.
>>>
>>> In the second example, __btrfs_map_block() changes the length
>>> parameter to something smaller than the file (the size of a stripe).
>>> This seems to break this check here:
>>>
>>>       read = len;
>>>       num_copies = btrfs_num_copies(fs_info, logical, len);
>>>       for (i = 1; i <= num_copies; i++) {
>>>           ret = read_extent_data(fs_info, dest, logical, &read, i);
>>>           if (ret < 0 || read != len) {
>>>               continue;
>>>           }
>>>           finished = true;
>>>           break;
>>>       }
>>>
>>> The problem being that read is always less than len.
>>>
>>> I am not sure if __btrfs_map_block is changing "len" to the incorrect
>>> value, or if there is some logic in "read_extent_data" that isn't
>>> correct. Any pointers on how this code is supposed to work would be
>>> greatly appreciated.
>>> Thanks.
>>
>> Thanks for reporting the issue
>>
>> $ scripts/get_maintainer.pl -f fs/btrfs/volumes.c
>>
>> suggests to include
>>
>> "Marek Behún" <kabel@kernel.org> (maintainer:BTRFS) Qu Wenruo
>> <wqu@suse.com> (reviewer:BTRFS) linux-btrfs@vger.kernel.org
>>
>> to the communication.
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>> === EXAMPLE 2 ===
>>> Zynq> load mmc 1:0 0 16K
>>> [btrfs_file_read,fs/btrfs/inode.c:710] === read the aligned part ===
>>> [btrfs_read_extent_reg,fs/btrfs/inode.c:458] before read_extent_data
>>> (ret = 0, read = 16384, len = 16384)
>>> [read_extent_data,fs/btrfs/disk-io.c:547] before __btrfs_map_block
>>> (len = 16384) [read_extent_data,fs/btrfs/disk-io.c:550] after
>>> __btrfs_map_block (len = 28672)
>>> [read_extent_data,fs/btrfs/disk-io.c:565] before __btrfs_devread (len
>>> = 16384) [read_extent_data,fs/btrfs/disk-io.c:568] after
>>> __btrfs_devread (len =
>>> 16384)
>>> [btrfs_read_extent_reg,fs/btrfs/inode.c:460] after read_extent_data
>>> (ret = 0, read = 16384, len = 16384)
>>> cur: 0, extent_num_bytes: 16384, aligned_end: 16384
>>> 16384 bytes read in 100 ms (159.2 KiB/s)
>>>
>>> === EXAMPLE 2 ===
>>> Zynq> load mmc 1:0 0 32K
>>> [btrfs_file_read,fs/btrfs/inode.c:710] === read the aligned part ===
>>> [btrfs_read_extent_reg,fs/btrfs/inode.c:458] before read_extent_data
>>> (ret = 0, read = 32768, len = 32768)
>>> [read_extent_data,fs/btrfs/disk-io.c:547] before __btrfs_map_block
>>> (len = 32768) [read_extent_data,fs/btrfs/disk-io.c:550] after
>>> __btrfs_map_block (len = 12288)
>>> [read_extent_data,fs/btrfs/disk-io.c:565] before __btrfs_devread (len
>>> = 12288) [read_extent_data,fs/btrfs/disk-io.c:568] after
>>> __btrfs_devread (len =
>>> 12288)
> 
> So the first 3 sectors are before the stripe boundary and we read it correctly.
> 
>>> [btrfs_read_extent_reg,fs/btrfs/inode.c:460] after read_extent_data
>>> (ret = 0, read = 12288, len = 32768)
>>> [btrfs_read_extent_reg,fs/btrfs/inode.c:458] before read_extent_data
>>> (ret = 0, read = 12288, len = 32768)
>>> [read_extent_data,fs/btrfs/disk-io.c:547] before __btrfs_map_block
>>> (len = 12288) [read_extent_data,fs/btrfs/disk-io.c:550] after
>>> __btrfs_map_block (len = 12288)
> 
> I believe this is the problem.
> 
> If we're reading the full 32K, and the first 12K is in the first stripe, we should then try to map the remaining 20K, not the 12K again.
> 
> I'll look into the situation.
> But if you can provide the image or the dump, it can greatly help the debugging.
> 
> Thanks,
> Qu
> 
>>> [read_extent_data,fs/btrfs/disk-io.c:565] before __btrfs_devread (len
>>> = 12288) [read_extent_data,fs/btrfs/disk-io.c:568] after
>>> __btrfs_devread (len =
>>> 12288)
>>> [btrfs_read_extent_reg,fs/btrfs/inode.c:460] after read_extent_data
>>> (ret = 0, read = 12288, len = 32768)
>>> file: fs/btrfs/inode.c, line: 468
>>> cur: 0, extent_num_bytes: 32768, aligned_end: 32768
>>> -----> btrfs_read_extent_reg: -5, line: 758
>>> BTRFS: An error occurred while reading file 32K Failed to load '32K'
>>>
>>>
>>>
>>>
>>>
>>> Sam Winchenbach
>>> Embedded Software Engineer III
>>> Tethers Unlimited, Inc. | Connect Your Universe | www.tethers.com
>>> swinchenbach@tethers.com | C: 207-974-6934
>>> 11711 North Creek Pkwy # D113, Bothell, WA 98011-8808, USA
>>
