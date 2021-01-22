Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7660B300B4B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 19:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbhAVScU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 13:32:20 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:45028 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728583AbhAVScI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 13:32:08 -0500
Received: from venice.bhome ([94.37.172.193])
        by smtp-33.iol.local with ESMTPA
        id 31DLlw91i11DD31DLlZV2b; Fri, 22 Jan 2021 19:31:19 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1611340279; bh=6AlophqYKg4ZMCQfyPgga5BnQni3GqYeAKqhDbZmj94=;
        h=From;
        b=Xmk3foonbbnckvjXelRnWDvIdk34jNf5ct/2Rs2NwfQhQL/jggnYETplRzDQSy9bE
         T9UoeAzjUQNMB6ZmZ4vHycXxO9URzRy6pjqzhmkO8t/4RuMYTX7RR/gPuxdJw2W5+8
         jr1Z3BKsba3SxUZw4NjSL1sC/4su43AzJaJllTycbIWdljZxlK+JNjdexgxoBmSVXn
         dbmER0GbzleMTARRFdgy78LtrcJxAR17wMKqTneHCncLLDp+IYyggDbSMrbv15hTYr
         AijMiUE7TyYU8PjZN7XwagjLsQeAuLx23Jkj8xUeM/g36qSXHm/CxugOhtRRePQDfD
         ZAKPTbHTL8rfQ==
X-CNFS-Analysis: v=2.4 cv=ba6u7MDB c=1 sm=1 tr=0 ts=600b19f7 cx=a_exe
 a=z1y4hvBwYU35dpVEhKc0WA==:117 a=z1y4hvBwYU35dpVEhKc0WA==:17
 a=IkcTkHD0fZMA:10 a=vjV27OyoboYHZ0UY2dEA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20210117185435.36263-1-kreijack@libero.it>
 <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
 <765cec4e-b989-081b-2ad7-e2d1c9cf7f55@libero.it>
 <20210121185400.GH28049@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <89ee4ab9-64cd-b093-92d2-02eee4997250@inwind.it>
Date:   Fri, 22 Jan 2021 19:31:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121185400.GH28049@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfB9y9z+/yhJx/A1p6+kw0ui0tWDlImu0HNFpjgE7nQDWTlpkJH/OIxEgIe9hWFyiEGl/OSiIydwbbYflYOto9y2qBNl1X1nbTb3PFhnLdMvYcyQOWlTV
 fO0h5pVUAx/mv6+s1v31jcriquoqxPdVni+EKzB27Zk7oV++WXRybWPrYSyCwkFbNc4iA0N+/aNlIUw5VCs8C+nUwmBnS8cWE3vaJyjPr4KFhcCuqwrA4HLD
 2a9DNuSmfhKpyYiguafwVBIweisciHEKD55CumZIpF8=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/21/21 7:54 PM, Zygo Blaxell wrote:
> On Thu, Jan 21, 2021 at 07:16:05PM +0100, Goffredo Baroncelli wrote:
>> On 1/20/21 5:02 PM, Josef Bacik wrote:
>>> On 1/17/21 1:54 PM, Goffredo Baroncelli wrote:
>>>>
>>>> Hi all,
>>>>
>>>> This is an RFC; I wrote this patch because I find the idea interesting
>>>> even though it adds more complication to the chunk allocator.
>>>>
>>>> The basic idea is to store the metadata chunk in the fasters disks.
>>>> The fasters disk are marked by the "preferred_metadata" flag.
>>>>
>>>> BTRFS when allocate a new metadata/system chunk, selects the
>>>> "preferred_metadata" disks, otherwise it selectes the non
>>>> "preferred_metadata" disks. The intial patch allowed to use the other
>>>> kind of disk in case a set is full.
>>>>
>>>> This patches set is based on v5.11-rc2.
>>>>
>>>> For now, the only user of this patch that I am aware is Zygo.
>>>> However he asked to further constraint the allocation: i.e. avoid to
>>>> allocated metadata on a not "preferred_metadata"
>>>> disk. So I extended the patch adding 4 modes to operate.
>>>>
>>>> This is enabled passing the option "preferred_metadata=<mode>" at
>>>> mount time.
>>>>
>>>
>>> I'll echo Zygo's hatred for mount options.  The more complicated policy decisions belong in properties and sysfs knobs, not mount options.
>>>
>> I tend to agree. However adding a filesystem property can be done in a second time. I don't think that this a problem. However I prefer to make the patch smaller.
>>
>> Anyway I have to point out that we need a way to change the allocation
>> policy without changing the metadata otherwise we risk to be in the
>> loop of exhausting metadata space: - how we can increase the space for
>> metadata if we don't have space for metadata but I need to allocate
>> few block of metadata....
>>
>> What I mean is that even if we store the setting as filesystem
>> properties (and definitely we have to do), we need a way to override
>> in an emergency scenario.
> 
> There are no new issues introduced by this change, thus no requirement
> for a mount option to deal with new issues.
> 
> The same issue comes up when changing RAID profile, or removing devices,
> or when existing devices simply fill up.  Part of the solution is the
> global reserve, which ensures we can always create a transaction to modify
> a few metadata pages.
> 
> Part of the solution is a run-time check to ensure we have min_devs for
> active RAID profiles whenever we change a device policy to reject data
> or metadata (see btrfs_check_raid_min_devices).  This is currently
> implemented for the device remove ioctl, and a similar check will
> be needed for the device property set ioctl for preferred_metadata.
> That part is missing in v5 of this patch and will have to be added,
> though even now it works most of the time without.
> 
> v5 is also missing changes to the df statvfs code to deal with metadata
> only devices.  At this stage it's an RFC patch, so that's OK, but it
> will also need to be fixed.  We presume these will be addressed in future
> versions.  Again, it works now, but 'df' will give the wrong number.
> 
> None of the above requirements is addressed by a mount option, and
> the mount option adds new requirements that we don't want.
> 
>>> And then for the properties themselves, presumably we'll want to
>> add other FS wide properties in the future.  I'm not against adding
>> new actual keys and items to the tree itself, but is there a way
>> we could use our existing property infrastructure that we use for
>> compression, and simply store the xattrs in the tree root?  It looks
>> like we're just toggling a policy decision, and we don't actually
>> need the other properties in the item you've created, so why not
>> just a btrfs.preferred_metadata property with the value stored in it,
>> dropped into the tree_root so it can be read on mount?  Thanks,
>>
>> What if the root subvolume is not mounted ?
> 
> Same as device add or remove--if the filesystem isn't mounted, you can't
> make any changes.

I am referring to a case where a subvolume (id != 5) is mounted but not the root one (id=5).
The point is that (e.g.) in the current implementation you can use

$ sudo btrfs property set /dev/vde preferred_metadata 1

in any case where the filesystem is mounted (doesn't matter which
subvvolume).

I like the Josef idea: instead to develop a new api to retrive/change/list/store/delete/create
some setting, we could use the xattr api which already exists.

# adding properties
$ sudo setfattr -n "btrfs.metadata_preferred_disk=aabbcc" -v "mode=1"  /
$ sudo setfattr -n "btrfs.metadata_preferred_disk=aabbee" -v "mode=1"  /
$ sudo setfattr -n "btrfs.metadata_preferred" -v "1"  /

# listing properties and their values
$ sudo getfattr -d /
getfattr: Removing leading '/' from absolute path names
# file: .
btrfs.metadata_preferred_disk\075aabbcc="mode=1"
btrfs.metadata_preferred_disk\075aabbee="mode=1"
btrfs.metadata_preferred="1"

# removing a properties
$ sudo setfattr -x "btrfs.metadata_preferred_disk=aabbcc" /

However the xattr requires an inode to attach the .. xattrs. But when we are talking about
filesystem properties, which is the right inode ? The only stable inode is the '.' of
the root subvolume. The other inodes may be deleted so are not suitable to store per
filesystem properties.

So the point is: what happens if the root subvolume is not mounted ?

Of course we can tweak the xattr api to deal this case, but doing so is not
so different than developing a new api, which (I think) is not what Josef suggested.

> 
> Note that all the required properties are per-device, so really you just
> need any open FD on the filesystem.  (I think Josef didn't read that far
> down).
> 
> The per-device policy storage can go in dev_root (tree 4) along with the
> device stats data, if we don't want to use btrfs_device::type.  You'd still
> need an ioctl to get to it.
> 
> Or maybe I'm misreading Josef here, and his idea is to make the per-device
> configuration a string blob that can be set by putting an xattr on the
> root subvol?  I'm not sure that's better, but it'll work.
> 
>> Yes we can create a further
>> api to store/retrive this kind of metadata without mounting the root
>> subvolume, but doing so in what it would be different than adding a
>> key to the root fs like the default subvolume ioctl does ?
> 
>>>
>>> Josef
>>
>>
>> -- 
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
