Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB9D4A3AAE
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jan 2022 23:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiA3W2W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Jan 2022 17:28:22 -0500
Received: from smtp-34.italiaonline.it ([213.209.10.34]:42182 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232281AbiA3W2V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Jan 2022 17:28:21 -0500
Received: from [192.168.1.27] ([78.14.151.50])
        by smtp-34.iol.local with ESMTPA
        id EIgGnQB8D4gIpEIgGndudR; Sun, 30 Jan 2022 23:28:20 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1643581700; bh=ARhS84ESdrSIncM0cUr0o3sPMCGoOjYKXAValCn3lto=;
        h=From;
        b=QrS9SHtStwfn7Y+vytPgClr1+5oU9BKvjxKtOCjz4Puf0qGToe7Ib7iS4Kj3Ablug
         YH173rcKTY4vYU8/MgRss+Dg/uGdWmIXPv20Y6LZqs+uhpFZIZfmxJ9P50zqCJJkPA
         veHb8kH2R8AF+1ien4axILUoAGcQ5WwS/RjGwKhrapATOHDAURW6I+guqD/Fqf8SmY
         mMDrnRcLsecScuhKZb7OGUbJQt/pglxGLvNKkrSFuG7HjH79SHvwm+/GX1JzZentPi
         ixpFMS6NI4ixucsWrmvSLw6bl6MFk7FWHK7T7FzjrGA7FXRzYAFgDyTNQpqblMZLQE
         1cmKnxBPJYS8g==
X-CNFS-Analysis: v=2.4 cv=d4QwdTvE c=1 sm=1 tr=0 ts=61f71104 cx=a_exe
 a=d4nNsk+SGr75ik5id+62uA==:117 a=d4nNsk+SGr75ik5id+62uA==:17
 a=IkcTkHD0fZMA:10 a=5KrOQb5agRvglubQmWAA:9 a=QEXdDO2ut3YA:10
Message-ID: <1639cabc-e644-885d-5201-1ef355029342@libero.it>
Date:   Sun, 30 Jan 2022 23:28:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 2/2] btrfs: create chunk device type aware
Content-Language: en-US
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1642518245.git.anand.jain@oracle.com>
 <4ac12d6661470b18e1145f98c355bc1a93ebf214.1642518245.git.anand.jain@oracle.com>
 <20220126173838.GE14046@twin.jikos.cz>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <20220126173838.GE14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMnJC2k/ZUB2h504nVOnqDoHTaiclsmdq25MFftdM4Qsg+OrOqIgMUSKJv9sOIPyPYggMhVGDkOWXjUMAkcls9leKfqzsRealqbzBOX2fxX640hsocxM
 iq5lMcnxWrrqtWvjegCrpnDwuLi1skS6u9EOIw/+J9w3tTdLJTDtDlgrFJ4f1DB+J+OVCHweiYNkGIHlcXrtE3AiRtjV9RzrEF9bH1cNjyEzdeb78PUKfTR2
 Lysl6N4VXPsuaCMPnRNaIQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/01/2022 18.38, David Sterba wrote:
>> The advantage of this method is that data/metadata allocation distribution
>> based on the device type happens automatically without any manual
>> configuration.
> Yeah, but the default behaviour may not be suitable for all users so
> some policy will have to be done anyway.
> 
> I vaguely remember some comments regarding mixed setups, along lines
> that "if there's a fast flash device I'd rather see ENOSPC and either
> delete files or add more devices than to let everything work but with
> the risk of storing metadata on the slow devices."
> 

I confirm that. There are two aspects that impacted the "allocation_hint"
patches set discussions:
1) the criteria to order the disks
2) allow/permit/deny a kind of BG to be hosted by a device

Regarding 1), initially the first set of patches considered an automatic
behavior on the basis of the "rotational" attribute. Soon it was pointed out
that in the "not rotational" class there are different options (like SSD, NVME...).
The conclusion was that the "priority" should not be cabled in the btrfs code.
(e.g. we could consider the reliability ?)

Regarding 2), my initial patches set only ordered the disks and alloed any
disk to be used. Some user asked me to prevent to use certain disks
for (e.g.) the data; this to prevent the data BG to consume all the
available space [*]

These discussions leads me to create 4 "classes" for disks
- ONLY_METADATA
- PREFERRED_METADATA
- PREFERRED_DATA
- ONLY_DATA

Where the last one is not suitable for metadata, and the first one is not
suitable for data. The middle ones allow one type but only of the other disks are full.

Another differences between the Anand patches and the my ones, is that
in the "allocation_hint" for striped profiles (like raid5, which spans all
the available disks), the devices involved should have the same classes.

I.e., if btrfs has to allocate a RAID5 metadata chunk,
- first tries to use ONLY_METADATA disks.
- If the disks are not enough, then it tries to use ONLY_METADATA and
   PREFERRED_METADATA disks.
- If the disks are not enough, then it tries to use ONLY_METADATA,
   PREFERRED_METADATA and PREFERRED_DATA disks.
- If the disks are not enough, then -ENOSPC

What the Anand patches has more than allocation_hint patches, is that
these handle the case of different latency disks, giving higher
priority to the disks with lower latency. If this is a requirements
we can reserve some bits to add a priority of a disk, and then
we can sort the disk by:

- allocation_hint class
- priority
- max avail
- free space

BR
G.Baroncelli

[*] I don't want to open another discussion, but this seems to me more a "quota"
problem than a "disk allocation" problem...

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
