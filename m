Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B95A559A23
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 15:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiFXNKg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 09:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiFXNKc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 09:10:32 -0400
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB39233E3D
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 06:10:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id E4D523FDAA;
        Fri, 24 Jun 2022 15:10:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -3.704
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iZkbQmQUZGYb; Fri, 24 Jun 2022 15:10:25 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 475743FD63;
        Fri, 24 Jun 2022 15:10:25 +0200 (CEST)
Received: from [192.168.0.134] (port=53428)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1o4j4q-000IGo-C4; Fri, 24 Jun 2022 15:10:24 +0200
Message-ID: <744f4b1b-badd-5610-318a-a944465454a8@tnonline.net>
Date:   Fri, 24 Jun 2022 15:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Criteria for mount messages. (was "Re: [PATCH] btrfs: remove
 skinny extent verbose message")
Content-Language: en-US
To:     Martin Steigerwald <martin@lichtvoll.de>, dsterba@suse.cz,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <20220623080858.1433010-1-nborisov@suse.com>
 <20220623141954.GP20633@twin.jikos.cz>
 <7a42092f-9534-e54c-174e-8aaf17509d4b@gmx.com> <1852203.CQOukoFCf9@ananda>
From:   Forza <forza@tnonline.net>
In-Reply-To: <1852203.CQOukoFCf9@ananda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6/24/22 12:52, Martin Steigerwald wrote:
> Qu Wenruo - 24.06.22, 00:46:02 CEST:
>> Thus my idea criteria would be:
>>
>> - Would this feature bring bad impact to end users?
>>     If the feature is only bringing good impact, it should not be
>> output.
>>
>>     Thus in this way, v2 cache nowadays should also be skipped, as it's
>> already well tested, and no real disadvantage at all.
> 
> There is one aspect where I find those messages helpful:
> 
> To confirm that I successfully enabled a feature (like space cache v2).
> 
> However, for that there does not really need to be a kernel message on
> each mounting, as long as I have a way to confirm the currently used
> features of BTRFS like:
> 
> - which checksum algorithm?
> - space cache v2
> - big metadata
> - which compression method configured as standard (I am aware that does
> not say anything about which files are compressed by which method)
> 
> and all other things like that.
> 
> Preferably in the output of just one command instead of being scattered
> around several different outputs or not even available at all. For
> example I am not aware of a command that confirms whether or not a
> filesystem uses "xxhash" instead of "crc32c" as checksum algorithm.
> 
> Something a bit similar to "tune2fs -l" or "xfs_info".
> 
> Is there such a something? I believe there is some way to dump a
> superblock however is there something that gives a structured output on
> what features are in use on a given filesystem?
> 

This is perhaps the better choice? A "btrfs info" or "btrfs filesystem 
info" command could output all these things in a user friendly and 
machine readable way. Possibly with added machine parsable output with 
an optional flag.

Currently we have "btrfs inspect-internal dump-super" which has a lot of 
the infomation already. I might be mistaken, but I think it only reads 
the superblocks directly off the block device, and it may not reflect 
what options the kernel currently uses. For example it cannot tell what 
kernel implementation of the checksum algorithm is used (crc32c-intel, 
sha256-generic, etc).


  # btrfs inspect-internal dump-super /dev/sdc2
superblock: bytenr=65536, device=/dev/sdc2
---------------------------------------------------------
csum_type               1 (xxhash64)
csum_size               8
csum                    0x46c8eb9318dc87eb [match]
bytenr                  65536
flags                   0x1
                         ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    aa358efb-ce43-498c-9997-0d35ba13261f
metadata_uuid           aa358efb-ce43-498c-9997-0d35ba13261f
label                   btrfs_backup_2T
generation              30096
root                    927851757568
sys_array_size          129
chunk_root_generation   30092
root_level              1
chunk_root              23003136
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             2996496760832
bytes_used              1756499472384
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x3
                         ( FREE_SPACE_TREE |
                           FREE_SPACE_TREE_VALID )
incompat_flags          0x371
                         ( MIXED_BACKREF |
                           COMPRESS_ZSTD |
                           BIG_METADATA |
                           EXTENDED_IREF |
                           SKINNY_METADATA |
                           NO_HOLES )
cache_generation        0
uuid_tree_generation    30096
block_group_root        0
block_group_root_generation     0
block_group_root_level  0
dev_item.uuid           d97d96ae-8f9c-4d32-a326-632700d29fa2
dev_item.fsid           aa358efb-ce43-498c-9997-0d35ba13261f [match]
dev_item.type           0
dev_item.total_bytes    2996496760832
dev_item.bytes_used     1803903041536
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0


Thanks,
Forza
