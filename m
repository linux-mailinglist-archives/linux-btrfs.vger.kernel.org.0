Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0B1930BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 19:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgCYS5Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 14:57:16 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:37477 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727174AbgCYS5Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 14:57:16 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id HBDFjlHqUMAUpHBDFjTaPk; Wed, 25 Mar 2020 19:57:13 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1585162633; bh=MqytIApy0/yXUj5567nYIrWE+SAJGvUFw5OaGjLoqCY=;
        h=From;
        b=lKCWE/ORjgeVbcSj4eEzaMAr6WB86nfcaZ7APd1uIHwUb4T0cL8ClKLC/as6ukyww
         eEt4GMD/OQIBk8ozJOqMfv6fUeB9W1BIhuJfCMvMPm53TohR1tlg0CxLzRbXB2qAvE
         Z3q/04fQCMvA0JlMXuXRctJaiHqJ+72riIWVwHgH8da7e3FqP8KMpWI+8RZp1a3tjt
         lEeq2vahbYvK5OeRgu+57yMWJVMvcwp0xCREimnbwhhKOjjcxjtrr/8yvJBf1iGKWA
         O9Imhq+LdjqDfbUT2+u+ew5DuMhaTzdGXh6eOKOiwpCt9RIQ9FNDH9EFOLt9E7yHjq
         dZP9L7DgYrcPw==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=rCvdS46E3op-ld_S1B0A:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: btrfs-progs: RAID1C3/C4 missing some info in btrfs_raid_array
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.cz>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <2f5db5cd-001f-449d-d370-697f3494ed34@libero.it>
 <cf046899-7a7b-a93b-2340-c996cbfbc6ac@gmx.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <b8b874d0-a60e-2a4c-f3eb-e54539bddc8d@inwind.it>
Date:   Wed, 25 Mar 2020 19:57:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cf046899-7a7b-a93b-2340-c996cbfbc6ac@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCq86WPXRyidPZ1Q3mawyM++wfBboCrD5ry+DYf4YgOQ1tak5YPTFH+WWC6Xryw2oyhXLXEv9pZmnuvNSAYkZVXJBpXnZJzApCaMWw4UolABsyhaxNd4
 cMNPmp7h51j9JoiUmQ3noamHrLf6HM9y/Yx/OZvcotp+27ckq9qkzNIkAV9ppnwtryqtLeVG4b6FIk0F1omtlcmHJNFSbF1RM+Yh7Kc8fEDebo3MPc5o7SK8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

On 3/25/20 1:12 AM, Qu Wenruo wrote:
> 
> 
> On 2020/3/25 上午4:00, Goffredo Baroncelli wrote:
>> Hi David,
>>
>> I noticed that in btrfs-progs - volumes.c in the array
>> "btrfs_raid_array", the info
>> raid_name and bg_flag are missing for the item BTRFS_RAID_RAID1C3 and
>> BTRFS_RAID_RAID1C4.
> 
> In devel branch, it's between RAID_DUP and RAID_1.

Sorry I cant find it. In the devel branch (last commit be952386cab3973b3e15434495d0070d5479516f) I found
$ cat volumes.c
[...]
	[BTRFS_RAID_RAID1] = {
		.sub_stripes	= 1,
		.dev_stripes	= 1,
		.devs_max	= 2,
		.devs_min	= 2,
		.tolerated_failures = 1,
		.devs_increment	= 2,
		.ncopies	= 2,
		.nparity        = 0,
		.raid_name	= "raid1",
		.bg_flag	= BTRFS_BLOCK_GROUP_RAID1,
		.mindev_error	= BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET,
	},
	[BTRFS_RAID_RAID1C3] = {
		.sub_stripes	= 1,
		.dev_stripes	= 1,
		.devs_max	= 3,
		.devs_min	= 3,
		.tolerated_failures = 2,
		.devs_increment	= 3,
		.ncopies	= 3,
	},
	[BTRFS_RAID_RAID1C4] = {
		.sub_stripes	= 1,
		.dev_stripes	= 1,
		.devs_max	= 4,
		.devs_min	= 4,
		.tolerated_failures = 3,
		.devs_increment	= 4,
		.ncopies	= 4,
	},
	[BTRFS_RAID_DUP] = {
[...]

As you can see the items BTRFS_RAID_RAID1C3 and BTRFS_RAID_RAID1C4, missed of the fields '.raid_name' and '.bg_flag';
if you look at BTRFS_RAID_RAID1 item, it has both the fields filled with "raid1" and "BTRFS_BLOCK_GROUP_RAID1".

Am I missing something ?

I am asking that because I need these fields. I don't have problem to issue a patch about that, however I want to be
sure that these fields are not missing for a some valid reason.

BR
G.Baroncelli

> 
> Thanks,
> Qu
>>
>> Is it wanted ? Which is the reason to do that ?
>>
>> BR
>> G.Baroncelli
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
