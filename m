Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAE41E83D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 18:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgE2Qha (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 May 2020 12:37:30 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:52770 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725795AbgE2Qh3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 May 2020 12:37:29 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id ei0djvyMitrlwei0djTNlG; Fri, 29 May 2020 18:37:27 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590770247; bh=RoUGvMp/GcYXERS3KTf8P/i8j/6eY+PvWs3WCY08A7Y=;
        h=From;
        b=YocuBZWrkzzzIkN/mQvEIBM87YOu4g0dT+/p7swAbEj3NKsWR8lD2ncPUOdC/7MNQ
         Zeyydw0uCidJcAaebj5BURHpgCzvoM1iIixIwfdKTk1GhOB0+RIYZe4QnUIRSbOUTi
         cSMaRK05WaBBc+xGOnN25H1UaWMz+M6kL76NrbdkVVbvKiwwWK+i3mvFGGp1lvee1a
         P1aAu1N2VE6jMeDq+wWtUDemcnJc26vE1IyFxv9es4oqmeGM2S/gocw6/69ekmnuib
         4b6M0OhLmawf/xsKpb/+j9E5X4861vNj8FJZVVk5o8/OtajON3O+q+uKILKj8gjnlF
         iQYbJGzq3j/MQ==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=tvJWwJrz6FzJT4ICdCwA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V4] btrfs: preferred_metadata: preferred device for
 metadata
To:     Hans van Kranenburg <hans@knorrie.org>, linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20200528183451.16654-1-kreijack@libero.it>
 <8f85f920-b0d0-3c11-3fd2-2f831efb37f4@knorrie.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <f1982b10-2b02-5a6c-a613-c961de4fa6db@libero.it>
Date:   Fri, 29 May 2020 18:37:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <8f85f920-b0d0-3c11-3fd2-2f831efb37f4@knorrie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBEVoty9/QP3Ife2p/lKPend/SKXg4qttD75MFMii1RHWS9m/7EXG92JeTrjmVzkG5Rb2ItUso89rHQNpdl9uS2w0VvStYKU0zEQB02pyt7/Oj5aJOJU
 /fEsnvasIEvSw5mOl81fFG+BEcZrYYyhzKhWmUC0gSbAQArs2ANaoHkVt3NYGdJOCo0R8UtP/xvNkRciY+TF5pwmn+wm9vc7ItCTQspUvwCvkEYGV/kp7b2T
 DfzP+KShDN4KjYVk+HvqfGSKW1YNpqTpsRhneDRk4Pcb0QENFANFhUWcycWt4M0e6QcvzXFjG6E2H4XHAjvkfGFdxW4ZsUTWlxoNvic3s+TNF0h2BGT0t0LK
 5MT/Q1HgSO8hDNlqRCplBWmLFzTF6+U0AhU55yrUw1ALRZj/wE0Jobz1i4Z1HoYrDDedtOIsP+JyrTUhbYuZR8vX6xwStw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/28/20 11:59 PM, Hans van Kranenburg wrote:
> Hi!
> 
> On 5/28/20 8:34 PM, Goffredo Baroncelli wrote:
>>
>> [the previous patches sets called this mode ssd_metadata]
>>
>> Hi all,
>>
>> This is an RFC; I wrote this patch because I find the idea interesting
>> even though it adds more complication to the chunk allocator.
> 
> Thanks for working on this. This is an often discussed feature request.
> So, taking it to the next level by actually writing PoC code helps a lot
> I guess.
> 
>> The initial idea was to store the metadata on the ssd and to leave the data
>> on the rotational disks. The kind of disk was determined from the rotational
>> flag. However looking only at the rotational flags is not flexible enough. So
>> I added a device property called "preferred_metadata" to mark a device
>> as preferred for metadata.
>>
>> A separate patches set is sent to extend the "btrfs property" command
>> for supporting the preferred_metadata device flag. The basic usage is:
>>
>>      $ # set a new value
>>      $ sudo btrfs property set /dev/vde preferred_metadata 1
>>      
>>      $ # get the current value
>>      $ sudo btrfs property get /dev/vde preferred_metadata
>>      devid=4, path=/dev/vde: dedicated_metadata=1
>>
>> This new mode is enabled passing the option "preferred_metadata" at mount time.
>> This policy of allocation is the default one. However if this doesn't permit
>> a chunk allocation, the "classic" one is used.
>>
>> Some examples: (/dev/sd[abc] are marked as preferred_metadata,
>> and /dev/sd[ef] are not)
>>
>> Non striped profile: metadata->raid1, data->raid1
>> The data is stored on /dev/sd[ef], metadata is stored on /dev/sd[abc].
>> When /dev/sd[ef] are full, then the data chunk is allocated also on
>> /dev/sd[abc].
>>
>> Striped profile: metadata->raid6, data->raid6
>> raid6 requires 3 disks at minimum, so /dev/sd[ef] are not enough for a
>> data profile raid6. To allow a data chunk allocation, the data profile raid6
>> will be stored on all the disks /dev/sd[abcdef].
>> Instead the metadata profile raid6 will be allocated on /dev/sd[abc],
>> because these are enough to host this chunk.
>>
>> The patches set is composed by four patches:
>>
>> - The first patch adds the ioctl to update the btrfs_dev_item.type field.
>> The ioctl is generic to handle more fields, however now only the "type"
>> field is supported.
> 
> What are your thoughts about the chicken/egg situation of changing these
> properties only when the filesystem is mounted?

The logic is related only to a chunk allocation. I.e. if you have a not
empty filesystem, after enabling the preferred_metadata "mode", in order
to get the benefit a full balance is required.

> 
> E.g. mkfs puts metadata on the wrong disk, and then only after actually
> mounting, I have to find out how to find out where metadata is actually
> placed, and then play around with btrfs balance options until I get
> everything moved to my preferred disks. Do you have any ideas about
> improving the out of the box usability of this?

In order to figure out where the (meta)data are placed, "btrfs fi us"
is your friend.
Of course setting this at mkfs.btrfs time is a good suggestion.

> 
>> - The second patch adds the flag BTRFS_DEV_PREFERRED_METADATA which is
>> used to mark a device as "preferred_metadata"
>>
>> - The third patch exports the btrfs_dev_item.type field via sysfs files
>> /sys/fs/btrfs/<UUID>/devinfo/<devid>/type
>>
>> It is possible only to read the value. It is not implemented the updated
>> of the value because in btrfs/stsfs.c there is a comment that states:
>> "We don't want to do full transaction commit from inside sysfs".
>>
>> - The fourth patch implements this new mode
>>
>> Changelog:
>> v4: - renamed ssd_metadata to preferred_metadata
>>      - add the device property "preferred_metadata"
>>      - add the ioctl BTRFS_IOC_DEV_PROPERTIES
>>      - export the btrfs_dev_item.type values via sysfs
>> v3: - correct the collision between BTRFS_MOUNT_DISCARD_ASYNC and
>>        BTRFS_MOUNT_SSD_METADATA.
>> v2: - rebased to v5.6.2
>>      - correct the comparison about the rotational disks (>= instead of >)
>>      - add the flag rotational to the struct btrfs_device_info to
>>        simplify the comparison function (btrfs_cmp_device_info*() )
>> v1: - first issue
>>
>> [...]
> Another question: what is your opinion about device replace? Should it
> leave properties of the destination device alone, or should it copy the
> bit over?
>
> If I'm replacing my ssd with metadata with a larger one, then what
> should I expect to happen by default as user (already having forgotten
> about that property command that I had to use to actually make it work
> months ago)?

In the previous attempt I rtried  to detect automatically which disk is faster
looking at the rotation flag. However someone pointed me that even from
a sata ssd and a pci nvme there is an huge speed differences (even tough
the latency is more important).
This to say that an automatic logic is not the best possible choice for all
the cases .
Then the next step was to add a flag to mark explicitly the devices for
metadata.

I think that "replacing" and "adding" doesn't have a "sane" default. There will
be always a case where an user replace an ssd with an mechanical hdd or
a case where an ssd is added where there is already an pci nvme.

What would make sense is an additional option to btrfs add/replace
that allows to specify if the disk should be preferred for metadata or not.
> 
> Thanks,
> Hans
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
