Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EBD53E711
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbiFFPcF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 11:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240803AbiFFPcB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 11:32:01 -0400
Received: from ts201-smtpout72.ddc.teliasonera.net (ts201-smtpout72.ddc.teliasonera.net [81.236.60.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA91136B68
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 08:31:32 -0700 (PDT)
X-RG-Rigid: 626BF45801713BB1
X-Originating-IP: [81.226.241.77]
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedruddtvddgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvffgnffktefuhgdpggftfghnshhusghstghrihgsvgdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomhepvfhorhgsjhpnrhhnpgflrghnshhsohhnuceothhorhgsjhhorhhnsehjrghnshhsohhnrdhtvggthheqnecuggftrfgrthhtvghrnhepiefgtddtvdefheffteeiiefhgeehkeduuedvgeegffejudeukeejueefieefieeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkedurddvvdeirddvgedurdejjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehgrghmmhgurghtrghnrdhhohhmvgdrlhgrnhdpihhnvghtpeekuddrvddviedrvdeguddrjeejpdhmrghilhhfrhhomhepthhorhgsjhhorhhnsehjrghnshhsohhnrdhtvggthhdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgsohhrihhsohhvsehsuhhsvgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from gammdatan.home.lan (81.226.241.77) by ts201-smtpout72.ddc.teliasonera.net (5.8.716)
        id 626BF45801713BB1; Mon, 6 Jun 2022 17:31:20 +0200
Received: from [192.168.9.3] (tobbe.home.lan [192.168.9.3])
        by gammdatan.home.lan (8.17.1/8.16.1) with ESMTP id 256FVKIN766596;
        Mon, 6 Jun 2022 17:31:20 +0200
Message-ID: <ffd08c40-03f9-ab11-6822-982faa72e508@jansson.tech>
Date:   Mon, 6 Jun 2022 17:31:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: btrfs-convert aborts with an assert
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <023b5ca9-0610-231b-fc4e-a72fe1377a5a@jansson.tech>
 <445c4c65-9b94-4961-c498-5c3d9b140a3d@suse.com>
 <db44a8ab-bfc1-667d-0c38-b04461768370@jansson.tech>
 <6670230b-dcbc-bcfc-f0d8-2baca1445b31@suse.com>
From:   =?UTF-8?Q?Torbj=c3=b6rn_Jansson?= <torbjorn@jansson.tech>
In-Reply-To: <6670230b-dcbc-bcfc-f0d8-2baca1445b31@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-06-06 17:21, Nikolay Borisov wrote:
> 
> 
> On 6.06.22 г. 18:00 ч., Torbjörn Jansson wrote:
>> On 2022-06-06 16:31, Nikolay Borisov wrote:
>>>
>>>
>>> On 6.06.22 г. 17:03 ч., Torbjörn Jansson wrote:
>>>> Hello
>>>>
>>>> i tried to do a btrfs-convert of a ext4 filesystem and after a short while 
>>>> after starting it i was greeted with:
>>>>
>>>> # btrfs-convert /dev/xxxx
>>>> btrfs-convert from btrfs-progs v5.16.2
>>>>
>>>> convert/main.c:1162: do_convert: Assertion `cctx.total_bytes != 0` failed, 
>>>> value 0
>>>> btrfs-convert(+0xffb0)[0x557defdabfb0]
>>>> btrfs-convert(main+0x6c5)[0x557defdaa125]
>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f66e1f8bd0a]
>>>> btrfs-convert(_start+0x2a)[0x557defdab52a]
>>>> Aborted
>>>>
>>>> Any idea whats going on?
>>>> Is it a known bug?
>>>> Is the btrfs-progs that come with my dist too old?
>>>> FYI the ext4 filesystem is a bit large ~10tb of used data on it.
>>>>
>>>> I assume the convert didn't even start in this case and nothing was 
>>>> modified on the ext4 filesystem, correct? or?
>>>>
>>>
>>> Care too run the following command and share the output:
>>>
>>> echo "show_super_stats -h" | debugfs -f /dev/stdin /dev/loop0
>>>
>>> change /dev/loop0 to wherever is your ext4 filesyste, however debugfs 
>>> require the fs to be unmounted.
>>>
>>
>> See output below.
>>
>> one more thing, when i ran fsck.ext4 -f on the device before trying to run 
>> btrfs-convert it said things like:
>> Inode 61475702 extent tree (at level 1) could be shorter.  Optimize<y>? yes
>> Inode 61477092 extent tree (at level 2) could be narrower.  Optimize<y>? yes
>> and then a bunch more, all aditonal looked similar and said narrower.
>>
>>
>> Filesystem volume name:   <none>
>> Last mounted on:          /mnt/data
>> Filesystem UUID:          78b93577-0bb5-41a1-89d7-3027cf0b9bc2
>> Filesystem magic number:  0xEF53
>> Filesystem revision #:    1 (dynamic)
>> Filesystem features:      has_journal ext_attr dir_index filetype meta_bg 
>> extent 64bit flex_bg casefold sparse_super large_file huge_file dir_nlink 
>> extra_isize metadata_csum
>> Filesystem flags:         signed_directory_hash
>> Default mount options:    user_xattr acl
>> Filesystem state:         clean
>> Errors behavior:          Continue
>> Filesystem OS type:       Linux
>> Inode count:              536870912
>> Block count:              4294967296
>> Reserved block count:     0
>> Overhead clusters:        12982806
>> Free blocks:              2134612618
>> Free inodes:              536845192
>> First block:              0
>> Block size:               4096
>> Fragment size:            4096
>> Group descriptor size:    64
>> Blocks per group:         32768
>> Fragments per group:      32768
>> Inodes per group:         4096
>> Inode blocks per group:   256
>> First meta block group:   1792
>> Flex block group size:    16
>> Filesystem created:       Fri Aug 13 17:27:43 2021
>> Last mount time:          Sat May 21 13:56:20 2022
>> Last write time:          Mon Jun  6 15:33:45 2022
>> Mount count:              0
>> Maximum mount count:      -1
>> Last checked:             Mon Jun  6 15:33:45 2022
>> Check interval:           0 (<none>)
>> Lifetime writes:          93 TB
>> Reserved blocks uid:      0 (user root)
>> Reserved blocks gid:      0 (group root)
>> First inode:              11
>> Inode size:               256
>> Required extra isize:     32
>> Desired extra isize:      32
>> Journal inode:            8
>> Default directory hash:   half_md4
>> Directory Hash Seed:      79d63f5e-1fd3-443f-ba05-1a90b7358160
>> Journal backup:           inode blocks
>> Checksum type:            crc32c
>> Checksum:                 0xb53baa13
>> Character encoding:       utf8-12.1
>> Directories:              138
>>
> 
> So indeed it seems like you've hit a bug with the way progs interacts with the 
> information provided by e2fsprogs. I will work on a fix and will post it to the 
> mailing list probably tomorrow. In the mean time it would be best to open a 
> github issue to track progress there as well.
> 

Thanks.
i created a bugreport: https://bugzilla.kernel.org/show_bug.cgi?id=216086

i will probably try to do what i wanted in a different way due to this bug so i 
don't have to rely on btrfs-convert.
i was going to convert from md (raid1) + lvm + ext4 to plain btrfs with raid1
but now i think i will split the md mirror first, create a new btrfs filesystem 
and them copy over the data myself.

