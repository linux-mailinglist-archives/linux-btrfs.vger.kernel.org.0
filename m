Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4047D10DA3F
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2019 20:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfK2TyI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Nov 2019 14:54:08 -0500
Received: from smtp-31.italiaonline.it ([213.209.10.31]:47322 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbfK2TyH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Nov 2019 14:54:07 -0500
Received: from venice.bhome ([84.220.25.30])
        by smtp-31.iol.local with ESMTPA
        id amL6i8L75iFL3amL6i1OCf; Fri, 29 Nov 2019 20:54:04 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1575057244; bh=pH9AosH6wGOIzkfpivpSHiruOkK+/r+K4b/VkfdYi2k=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mvgiWDtZnjCpp7aQBezZIdwgSk8imeyqRnFwUr8/wJCQs5IaxkMpe1Nf9DlE4jHiw
         qRPebWGWV7553wuVXhRJVkssxsnaVumddv20NM6i/rS6JDFFHrgq76c0RQW2zAdzpy
         EV/1o+8a7LVivOXOgqKUOcsxvoFmNlJwTvQ3GAiAy44S/NkvZCXVkYfW1UJRbw6RJ/
         Da+L23vaZSzWIqo6AUHYB/wG34/9zDnMOewfp4lX94lLmYGlqMCDNwykoPRGhAvLgV
         0uhUlXBLzUXUj1Lh7CmbRzbnUh6MtWTieAjjUj7cq8ww4sQgEojzrLpiOrYjXpAPSI
         6ZwweH0cY/Hfg==
X-CNFS-Analysis: v=2.3 cv=J77UEzvS c=1 sm=1 tr=0
 a=zfQl08sXljvZd6EmK9/AFg==:117 a=zfQl08sXljvZd6EmK9/AFg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=FdVkZoV-AAAA:20
 a=6rTV6VZxAAAA:20 a=kZCwrTFWv9nJOiEdA3kA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it>
 <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <CAJCQCtS2CP75JTT4a6y=rzqVtkMTqTRoCvJK9z3mMwLRfKo9Xw@mail.gmail.com>
 <12f98aaa-14f0-a059-379a-1d1a53375f97@inwind.it>
 <CAJCQCtQF6xtBDWc+i3FezWZUqGsj8hJrAzYpWG+=huFkmOK==g@mail.gmail.com>
 <69aaf772-9eb0-945a-5277-40895e6901de@inwind.it>
 <CAJCQCtS6V+f5hq2Cu4r7g9nXB-nRPwUaL+=rh_Ets2mWtHrMcA@mail.gmail.com>
 <35b330e9-6ed7-8a34-7e96-601c19ec635c@inwind.it>
 <CAJCQCtQaq7r2G7Ff--n5g2eVknPtKcQjebj-=eoNjM-18hwhKw@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <0ce1c050-d90c-1351-ff56-4edc054463a4@inwind.it>
Date:   Fri, 29 Nov 2019 20:54:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQaq7r2G7Ff--n5g2eVknPtKcQjebj-=eoNjM-18hwhKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHuDoMqyaIi9lWhMmJ4e+8VRB6J/Ks1wb/AYXBJP17pZo+HE3MQgQoTjzF9e61jNgQ+CU/Ubybvexk1raDxH1jwtUtmxWJJqrFlwOAM7FHZehF5DSAy1
 x2XULFrHAl3MEbZ3ZwPeDhIUP1PaVRsmMEYhW9UoWo5j7+7h3RQt08VmZvyuGeVcepJ9GapG1hwOkt/5yUJjk3vJyAXC7VjF4uE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/11/2019 18.57, Chris Murphy wrote:
> On Thu, Nov 28, 2019 at 2:57 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>>
>> It seems that my supposition is true: the problem exists independently of btrfs.
>> It would be useful to see the debug (set debug=all + set pager=1) when doing "ls". It is a not so huge set of information (however it is composed by few pages).
> 
> OK I did debug=all on the grub command line instead of in the
> grub.cfg, and it's much more manageable.
> https://photos.app.goo.gl/75Lbobg39R4D9QUk6
> 
> It's a very strange coincidence that these errors only began soon
> after the Btrfs volume becomes a two device fs. I forgot to mention
> that while grub.cfg is on hfsplus, Fedora GRUB now uses blscfg.mod by
> default which goes looking for BLS snippets, which happen to be on
> /boot/loader/entries, which is on Btrfs. So even drawing the GRUB menu
> does in fact need to read from the 2 device Btrfs.
> 
>> Grub sees hd0..hd3 as disks of ~120GB; to be exactly, the size is 125753602048 bytes. The error is reported as unable to access sector 0xea3bfc8, which is locate at 0xea3bf00*512=125753491456 byte, which is less than the previous value...
> 
> Looks to me that hd0, hd1, hd2, hd3, hd4 are all phantom devices. hd5
> is the SSD, /dev/sda. cd0 is the empty dvd-rom drive.

On the basis of these info, it seems that when "ls" is run the errors come from the fact that:
- hd0..hd3 return errors when read (even before the end of device)
- hd4 returns error, because its size is 0 (as reported by grub)

However for these error btrfs seems not to be related.

Regarding the error at boot time; my hypothesis is that during the loading of the kernel, grub tries (but I don't know why) to read from hd0..hd4 returning an error. Unfortunately the videos is not available anymore.

Could you be so kindly to share the picture of the loading of the kernel/initramdisk ? Something like:

grub> set debug=all
grub> initrd /boot/initrd....

I hope that the errors come quickly. I don't think that we need the pictuers of all the download. It would be sufficient the pictures until the first (or better second) error....

BR
G.Baroncelli



> 
>>
>> It seems that  GRUB is correct in complaining. It is trying to access a valid disk location which return an error.
>> Why grub is trying to access this location ? My supposition is that grub is trying to probe a filesystem (or a partition type...)
>>
>> The problem seems to be related to the first 4 disks, which have all the same size and are "phantom" disks...
>> May be that the problem is that GRUB incorrectly detects disks ?
>>>
>>> But without rebooting, just repeating the ls for the same devices, I
>>> don't get the error for hd4 again.
>>> https://photos.app.goo.gl/M6yraHfgfAsMigaP8
>>
>> My understanding is that GRUB tried to load some external modules (zfs, ufs2, ...) without success. However this tentative was attempted only the first time. This could explain the fact that the error appeared only one time.
> 
> These errors may be misleading because the Fedora grubx64.efi doesn't
> contain them, and I've only copied a few GRUB modules from
> /usr/lib/grub/x86_64-efi to /boot/efi/EFI/fedora/x86_64-efi
> 
> The default installation on Fedora doesn't copy external modules to
> the ESP at all, so only the ones already in the grubx64.efi are
> available.
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
