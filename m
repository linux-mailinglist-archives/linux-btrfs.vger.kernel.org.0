Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4353EAF2
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbiFFPVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240393AbiFFPVw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 11:21:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3C7168D01
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 08:21:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4F4A51F93C;
        Mon,  6 Jun 2022 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654528909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XompClG8n2Dg9ScEZe1pIqpAjig8V6ol1MIkq4igkd4=;
        b=LmHIpJN+l8vVEwYiAwvM+g08WdG+xzXsHnnxCn29t9Ablg8sHgy17P/VwR/2VbdGWNHTDc
        ULlo29c7+usHazlIB31wrjUHY9MND8d0pBEAg5fE58y/dzZxpSjfEBsbVcwNWOVg/7V1MK
        emCMapARbjdHxxtEM6eoGtmLl4Xvw70=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 254EA139F5;
        Mon,  6 Jun 2022 15:21:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2L15Bo0bnmJ8cgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 06 Jun 2022 15:21:49 +0000
Message-ID: <6670230b-dcbc-bcfc-f0d8-2baca1445b31@suse.com>
Date:   Mon, 6 Jun 2022 18:21:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: btrfs-convert aborts with an assert
Content-Language: en-US
To:     =?UTF-8?Q?Torbj=c3=b6rn_Jansson?= <torbjorn@jansson.tech>,
        linux-btrfs@vger.kernel.org
References: <023b5ca9-0610-231b-fc4e-a72fe1377a5a@jansson.tech>
 <445c4c65-9b94-4961-c498-5c3d9b140a3d@suse.com>
 <db44a8ab-bfc1-667d-0c38-b04461768370@jansson.tech>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <db44a8ab-bfc1-667d-0c38-b04461768370@jansson.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6.06.22 г. 18:00 ч., Torbjörn Jansson wrote:
> On 2022-06-06 16:31, Nikolay Borisov wrote:
>>
>>
>> On 6.06.22 г. 17:03 ч., Torbjörn Jansson wrote:
>>> Hello
>>>
>>> i tried to do a btrfs-convert of a ext4 filesystem and after a short 
>>> while after starting it i was greeted with:
>>>
>>> # btrfs-convert /dev/xxxx
>>> btrfs-convert from btrfs-progs v5.16.2
>>>
>>> convert/main.c:1162: do_convert: Assertion `cctx.total_bytes != 0` 
>>> failed, value 0
>>> btrfs-convert(+0xffb0)[0x557defdabfb0]
>>> btrfs-convert(main+0x6c5)[0x557defdaa125]
>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f66e1f8bd0a]
>>> btrfs-convert(_start+0x2a)[0x557defdab52a]
>>> Aborted
>>>
>>> Any idea whats going on?
>>> Is it a known bug?
>>> Is the btrfs-progs that come with my dist too old?
>>> FYI the ext4 filesystem is a bit large ~10tb of used data on it.
>>>
>>> I assume the convert didn't even start in this case and nothing was 
>>> modified on the ext4 filesystem, correct? or?
>>>
>>
>> Care too run the following command and share the output:
>>
>> echo "show_super_stats -h" | debugfs -f /dev/stdin /dev/loop0
>>
>> change /dev/loop0 to wherever is your ext4 filesyste, however debugfs 
>> require the fs to be unmounted.
>>
> 
> See output below.
> 
> one more thing, when i ran fsck.ext4 -f on the device before trying to 
> run btrfs-convert it said things like:
> Inode 61475702 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 61477092 extent tree (at level 2) could be narrower.  Optimize<y>? 
> yes
> and then a bunch more, all aditonal looked similar and said narrower.
> 
> 
> Filesystem volume name:   <none>
> Last mounted on:          /mnt/data
> Filesystem UUID:          78b93577-0bb5-41a1-89d7-3027cf0b9bc2
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal ext_attr dir_index filetype 
> meta_bg extent 64bit flex_bg casefold sparse_super large_file huge_file 
> dir_nlink extra_isize metadata_csum
> Filesystem flags:         signed_directory_hash
> Default mount options:    user_xattr acl
> Filesystem state:         clean
> Errors behavior:          Continue
> Filesystem OS type:       Linux
> Inode count:              536870912
> Block count:              4294967296
> Reserved block count:     0
> Overhead clusters:        12982806
> Free blocks:              2134612618
> Free inodes:              536845192
> First block:              0
> Block size:               4096
> Fragment size:            4096
> Group descriptor size:    64
> Blocks per group:         32768
> Fragments per group:      32768
> Inodes per group:         4096
> Inode blocks per group:   256
> First meta block group:   1792
> Flex block group size:    16
> Filesystem created:       Fri Aug 13 17:27:43 2021
> Last mount time:          Sat May 21 13:56:20 2022
> Last write time:          Mon Jun  6 15:33:45 2022
> Mount count:              0
> Maximum mount count:      -1
> Last checked:             Mon Jun  6 15:33:45 2022
> Check interval:           0 (<none>)
> Lifetime writes:          93 TB
> Reserved blocks uid:      0 (user root)
> Reserved blocks gid:      0 (group root)
> First inode:              11
> Inode size:               256
> Required extra isize:     32
> Desired extra isize:      32
> Journal inode:            8
> Default directory hash:   half_md4
> Directory Hash Seed:      79d63f5e-1fd3-443f-ba05-1a90b7358160
> Journal backup:           inode blocks
> Checksum type:            crc32c
> Checksum:                 0xb53baa13
> Character encoding:       utf8-12.1
> Directories:              138
> 

So indeed it seems like you've hit a bug with the way progs interacts 
with the information provided by e2fsprogs. I will work on a fix and 
will post it to the mailing list probably tomorrow. In the mean time it 
would be best to open a github issue to track progress there as well.
