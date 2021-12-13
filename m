Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFB347358E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 21:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbhLMUCk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 15:02:40 -0500
Received: from smtp-31-wd.italiaonline.it ([213.209.13.31]:46661 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229897AbhLMUCk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 15:02:40 -0500
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 15:02:39 EST
Received: from [192.168.1.27] ([78.12.25.242])
        by smtp-31.iol.local with ESMTPA
        id wrOymyEqqg9rVwrOymVnkL; Mon, 13 Dec 2021 20:54:27 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639425267; bh=Tmx2eP75rFPlbfN41EGjt03bs5Jo0vCUEe3Uks9ORuc=;
        h=From;
        b=TV6k+vC4J6y0etRCXljlR+yOrpoqtgXnJxKWURcLfrLkLdTCurPHjVwfU6y0C6H1S
         VwoBaY7/zWHCMVnYkHOVvkO1zb+3TTTjI0FXnwgj3gaxsmatA+sZ/v8sqGyeAyXIIU
         dlLVIhPOsci6wPRyrq5rB+mFYpgB0cA7IYWOqJ6UnpuPcQNthf3Fit3Wtoh7IOgYYF
         hfiNZgGM5oNw8+wmRfnKLsrGqRjWmJLdeftOzXMEySQQGSQZOz7pWFfz0CIQSMFdWf
         3UtFDMqPmOfJcXwIx9lzBD4SNXYImlMKOl01AuT3UKwRhLZCZWxXXtTNpctBjZZ2CZ
         PL4eL6UkSz2vA==
X-CNFS-Analysis: v=2.4 cv=T8hJ89GQ c=1 sm=1 tr=0 ts=61b7a4f3 cx=a_exe
 a=IXMPufAKhGEaWfwa3qtiyQ==:117 a=IXMPufAKhGEaWfwa3qtiyQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=-r_FQfJlAAAA:8 a=maIFttP_AAAA:8
 a=cOLrLDMxAAAA:8 a=NEAV23lmAAAA:8 a=kT-NTsFwAAAA:8 a=B2wUXM0Dt9HCc0R-EMkA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=WQigP72iloSuIU9uEyai:22
 a=qR24C9TJY6iBuJVj_x8Y:22 a=P0s3qUPvOpV5zndjNR8V:22 a=TLwuWKmryFjkTYsgBL5T:22
Message-ID: <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
Date:   Mon, 13 Dec 2021 20:54:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.cz>
Cc:     Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Goffredo Baroncelli <kreijack@inwind.it>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <cover.1635089352.git.kreijack@inwind.it>
 <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOvHKOfLbPQQzjQu2X6Uk+WYoBg9QGnKROvoi32chy5NZpvuke9qMTappubunnF/tZERiuuWU3k3yEZn6Xi6ncrL0kIkXsRtgQ9ZtPdg1F2kSYuO/mzB
 Tsn6ToyqbjFfNESDyUsHQ5WRQRkz7UeYhN7vS146ZefwGUuvR8k2sbCv5JLhyjSJhvcgyuG94aPwdDS4mlihTG0fHKgZcjo7kZ5bcyudswdtEF/D6j7QwL2i
 wzWVywSBT1WKFOifGAftT7q+tNPJT8gqhKrYFFSohLi4FB+qOerlwmq3VcQZ8fNGdga5jyqCz+De8U5G6mHnHVvr4RjFM16MXRVLYfMpRLvRu4YJ8QUuEx2H
 S6wzSJBCqPtrt5CAeFYCJsivF1kZqERagYRuYUs4wcyQXXCc5Do=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Gentle ping :-)

Are there anyone of the mains developer interested in supporting this patch ?

I am open to improve it if required.

BR
G.Baroncelli

On 12/13/21 10:39, Paul Jones wrote:
>> -----Original Message-----
>> From: Goffredo Baroncelli <kreijack@tiscali.it>
>> Sent: Monday, 25 October 2021 2:31 AM
>> To: linux-btrfs@vger.kernel.org
>> Cc: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>; Josef Bacik
>> <josef@toxicpanda.com>; David Sterba <dsterba@suse.cz>; Sinnamohideen
>> Shafeeq <shafeeqs@panasas.com>; Goffredo Baroncelli
>> <kreijack@inwind.it>
>> Subject: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
>>
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> Hi all,
>>
>> This patches set was born after some discussion between me, Zygo and
>> Josef.
>> Some details can be found in https://github.com/btrfs/btrfs-todo/issues/19.
>>
>> Some further information about a real use case can be found in
>> https://lore.kernel.org/linux-
>> btrfs/20210116002533.GE31381@hungrycats.org/
>>
>> Reently Shafeeq told me that he is interested too, due to the performance
>> gain.
>>
>> In this revision I switched away from an ioctl API in favor of a sysfs API ( see
>> patch #2 and #3).
>>
>> The idea behind this patches set, is to dedicate some disks (the fastest one)
>> to the metadata chunk. My initial idea was a "soft" hint. However Zygo asked
>> an option for a "strong" hint (== mandatory). The result is that each disk can
>> be "tagged" by one of the following flags:
>> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
>> - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
>> - BTRFS_DEV_ALLOCATION_PREFERRED_DATA
>> - BTRFS_DEV_ALLOCATION_DATA_ONLY
>>
>> When the chunk allocator search a disks to allocate a chunk, scans the disks in
>> an order decided by these tags. For metadata, the order is:
>> *_METADATA_ONLY
>> *_PREFERRED_METADATA
>> *_PREFERRED_DATA
>>
>> The *_DATA_ONLY are not eligible from metadata chunk allocation.
>>
>> For the data chunk, the order is reversed, and the *_METADATA_ONLY are
>> excluded.
>>
>> The exact sort logic is to sort first for the "tag", and then for the space
>> available. If there is no space available, the next "tag" disks set are selected.
>>
>> To set these tags, a new property called "allocation_hint" was created.
>> There is a dedicated btrfs-prog patches set [[PATCH V5] btrfs-progs:
>> allocation_hint disk property].
>>
>> $ sudo mount /dev/loop0 /mnt/test-btrfs/ $ for i in /dev/loop[0-9]; do sudo
>> ./btrfs prop get $i allocation_hint; done devid=1, path=/dev/loop0:
>> allocation_hint=PREFERRED_METADATA
>> devid=2, path=/dev/loop1: allocation_hint=PREFERRED_METADATA
>> devid=3, path=/dev/loop2: allocation_hint=PREFERRED_DATA devid=4,
>> path=/dev/loop3: allocation_hint=PREFERRED_DATA devid=5,
>> path=/dev/loop4: allocation_hint=PREFERRED_DATA devid=6,
>> path=/dev/loop5: allocation_hint=DATA_ONLY devid=7, path=/dev/loop6:
>> allocation_hint=METADATA_ONLY devid=8, path=/dev/loop7:
>> allocation_hint=METADATA_ONLY
>>
>> $ sudo ./btrfs fi us /mnt/test-btrfs/
>> Overall:
>>      Device size:           2.75GiB
>>      Device allocated:           1.34GiB
>>      Device unallocated:           1.41GiB
>>      Device missing:             0.00B
>>      Used:             400.89MiB
>>      Free (estimated):           1.04GiB    (min: 1.04GiB)
>>      Data ratio:                  2.00
>>      Metadata ratio:              1.00
>>      Global reserve:           3.25MiB    (used: 0.00B)
>>      Multiple profiles:                no
>>
>> Data,RAID1: Size:542.00MiB, Used:200.25MiB (36.95%)
>>     /dev/loop0     288.00MiB
>>     /dev/loop1     288.00MiB
>>     /dev/loop2     127.00MiB
>>     /dev/loop3     127.00MiB
>>     /dev/loop4     127.00MiB
>>     /dev/loop5     127.00MiB
>>
>> Metadata,single: Size:256.00MiB, Used:384.00KiB (0.15%)
>>     /dev/loop1     256.00MiB
>>
>> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
>>     /dev/loop0      32.00MiB
>>
>> Unallocated:
>>     /dev/loop0     704.00MiB
>>     /dev/loop1     480.00MiB
>>     /dev/loop2       1.00MiB
>>     /dev/loop3       1.00MiB
>>     /dev/loop4       1.00MiB
>>     /dev/loop5       1.00MiB
>>     /dev/loop6     128.00MiB
>>     /dev/loop7     128.00MiB
>>
>> # change the tag of some disks
>>
>> $ sudo ./btrfs prop set /dev/loop0 allocation_hint DATA_ONLY $ sudo ./btrfs
>> prop set /dev/loop1 allocation_hint DATA_ONLY $ sudo ./btrfs prop set
>> /dev/loop5 allocation_hint METADATA_ONLY
>>
>> $ for i in /dev/loop[0-9]; do sudo ./btrfs prop get $i allocation_hint; done
>> devid=1, path=/dev/loop0: allocation_hint=DATA_ONLY devid=2,
>> path=/dev/loop1: allocation_hint=DATA_ONLY devid=3, path=/dev/loop2:
>> allocation_hint=PREFERRED_DATA devid=4, path=/dev/loop3:
>> allocation_hint=PREFERRED_DATA devid=5, path=/dev/loop4:
>> allocation_hint=PREFERRED_DATA devid=6, path=/dev/loop5:
>> allocation_hint=METADATA_ONLY devid=7, path=/dev/loop6:
>> allocation_hint=METADATA_ONLY devid=8, path=/dev/loop7:
>> allocation_hint=METADATA_ONLY
>>
>> $ sudo btrfs bal start --full-balance /mnt/test-btrfs/ $ sudo ./btrfs fi us
>> /mnt/test-btrfs/
>> Overall:
>>      Device size:           2.75GiB
>>      Device allocated:         735.00MiB
>>      Device unallocated:           2.03GiB
>>      Device missing:             0.00B
>>      Used:             400.72MiB
>>      Free (estimated):           1.10GiB    (min: 1.10GiB)
>>      Data ratio:                  2.00
>>      Metadata ratio:              1.00
>>      Global reserve:           3.25MiB    (used: 0.00B)
>>      Multiple profiles:                no
>>
>> Data,RAID1: Size:288.00MiB, Used:200.19MiB (69.51%)
>>     /dev/loop0     288.00MiB
>>     /dev/loop1     288.00MiB
>>
>> Metadata,single: Size:127.00MiB, Used:336.00KiB (0.26%)
>>     /dev/loop5     127.00MiB
>>
>> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
>>     /dev/loop7      32.00MiB
>>
>> Unallocated:
>>     /dev/loop0     736.00MiB
>>     /dev/loop1     736.00MiB
>>     /dev/loop2     128.00MiB
>>     /dev/loop3     128.00MiB
>>     /dev/loop4     128.00MiB
>>     /dev/loop5       1.00MiB
>>     /dev/loop6     128.00MiB
>>     /dev/loop7      96.00MiB
>>
>>
>> #As you can see all the metadata were placed on the disk loop5/loop7 even if
>> #the most empty one are loop0 and loop1.
>>
>>
>>
>> TODO:
>> - more tests
>> - the tool which show the space available should consider the tagging (eg
>>    the disks tagged by _METADATA_ONLY should be excluded from the data
>>    availability)
>>
>>
>> Comments are welcome
>> BR
>> G.Baroncelli
> 
> 
> I've been running this patch series since about V4, works really well. Would be nice to have it merged eventually.
> 
> Tested By: Paul Jones <paul@pauljones.id.au>
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
