Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7BB2FF34E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 19:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbhAUS0b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 13:26:31 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:50884 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389415AbhAUSRC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 13:17:02 -0500
Received: from venice.bhome ([94.37.172.193])
        by smtp-33.iol.local with ESMTPA
        id 2eV3lewW211DD2eV4lKmqA; Thu, 21 Jan 2021 19:16:06 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1611252966; bh=IcTFjwUki1ckqgmyqGzADthGDkGGcap6h+PuBluMBlw=;
        h=From;
        b=pY/MFo7a6uXpOibnFTYYc0LOWRIP5mahLQFTNpVMnKM9XL+ijD2gCiYF/YaWnWpzh
         +4GfAlLifNL6WJnLBJJIAHgr0ClC5MrJq/bPVHQj+Vq6/56+Aa7HSBNro2gbo43707
         ZhIBDSKYRRi7z9PvPhuCn0YsJRqee5i3Sa0pl2NSJhiPZUwMivj+PpITmRwtWO8HBh
         ItGPoyI8iDmBFGTuwPBNvAxsbaBXM0E2/jDzR9/TQyCFLh+U/iD5fKsH+AKMRO0X84
         N1HmMdLDpipj1dnGX22+yD9d0LMmGRrVvVzaNXlwkodxwteVMBDh+ihmdjs7jBKMsa
         fTvIs29oNzD8w==
X-CNFS-Analysis: v=2.4 cv=ba6u7MDB c=1 sm=1 tr=0 ts=6009c4e6 cx=a_exe
 a=z1y4hvBwYU35dpVEhKc0WA==:117 a=z1y4hvBwYU35dpVEhKc0WA==:17
 a=IkcTkHD0fZMA:10 a=3-TMlGnVWw1Yy_zT-BYA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20210117185435.36263-1-kreijack@libero.it>
 <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <765cec4e-b989-081b-2ad7-e2d1c9cf7f55@libero.it>
Date:   Thu, 21 Jan 2021 19:16:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfL904GRjuYlAmnfh5pI4cK9cr5yReYEnAqG0K5sVpVsFqysA05BHUNBhkgXwIkK/oYRjbB/tw8bMhlbUo9Hf8pidX6m5+5tekMNcIyRzrjzmeCEtw8MJ
 KDU11+78MCCsubhWVvAh0tHY5sM+lNQC5TgKJNZ+PbUy32W7VBcQjbQHFtpK0/S4cr/i70tB9kTinse4RkysTyEFij1DVkbS6VknDrvM25UkMy5zQLkHF6yW
 VZqnzK2m7YperjI/feU+bl8qyMpNWefXjTV8n2pXXO0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/21 5:02 PM, Josef Bacik wrote:
> On 1/17/21 1:54 PM, Goffredo Baroncelli wrote:
>>
>> Hi all,
>>
>> This is an RFC; I wrote this patch because I find the idea interesting
>> even though it adds more complication to the chunk allocator.
>>
>> The basic idea is to store the metadata chunk in the fasters disks.
>> The fasters disk are marked by the "preferred_metadata" flag.
>>
>> BTRFS when allocate a new metadata/system chunk, selects the
>> "preferred_metadata" disks, otherwise it selectes the non
>> "preferred_metadata" disks. The intial patch allowed to use the other
>> kind of disk in case a set is full.
>>
>> This patches set is based on v5.11-rc2.
>>
>> For now, the only user of this patch that I am aware is Zygo.
>> However he asked to further constraint the allocation: i.e. avoid to
>> allocated metadata on a not "preferred_metadata"
>> disk. So I extended the patch adding 4 modes to operate.
>>
>> This is enabled passing the option "preferred_metadata=<mode>" at
>> mount time.
>>
> 
> I'll echo Zygo's hatred for mount options.  The more complicated policy decisions belong in properties and sysfs knobs, not mount options.
> 
I tend to agree. However adding a filesystem property can be done in a second time. I don't think that this a problem. However I prefer to make the patch smaller.

Anyway I have to point out that we need a way to change the allocation policy without changing the metadata otherwise we risk to be in the loop of exhausting metadata space:
- how we can increase the space for metadata if we don't have space for metadata but I need to allocate few block of metadata....

What I mean is that even if we store the setting as filesystem properties (and definitely we have to do), we need a way to override in an emergency scenario.

> And then for the properties themselves, presumably we'll want to add other FS wide properties in the future.  I'm not against adding new actual keys and items to the tree itself, but is there a way we could use our existing property infrastructure that we use for compression, and simply store the xattrs in the tree root?  It looks like we're just toggling a policy decision, and we don't actually need the other properties in the item you've created, so why not just a btrfs.preferred_metadata property with the value stored in it, dropped into the tree_root so it can be read on mount?  Thanks,

What if the root subvolume is not mounted ? Yes we can create a further api to store/retrive this kind of metadata without mounting the root subvolume, but doing so in what it would be different than adding a key to the root fs like the default subvolume ioctl does ?

> 
> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
