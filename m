Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB32A5BC9
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2019 19:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfIBRVu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 13:21:50 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:40915 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfIBRVt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Sep 2019 13:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dirtcellar.net; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:Reply-To:To; bh=i9Wpr2TAGvkNpLMGPYOy5bzC16jd2ywX18ybwpmFogU=;
        b=eIWiWqejxm6Wv2Lz54IuN1Z/KuqMakWWt0uWmXDLdAuGnsuDxJqGoKiu3h4olVW9nsRRw4QDVazx07BtNdCFbWerJERKtAkAZYjvynPv+4VrOZo6425ucuPs6AQyCHqJ4noqw6tIjW+3tKd4Y9CNS8KVjemU1VJmimCvIqXFC9AEGpxS/lYhq0PMX1ahma1RBZ2v4njmvX5kWh0ypEG7nYjJLQxOXFsA9sjvwpEQZP8+EGS748AxH3vC91YsY7aZFKyDuEZrZ+MZ3WF2DAmP+FNmhxhQIFH1907fiqEhcZNonGPLlRxsVPwGwRjcv8ds7Yw4ZR7th8t7kuWa4MlvlQ==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:2927 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1i4q1T-00064G-HD
        for linux-btrfs@vger.kernel.org; Mon, 02 Sep 2019 19:21:47 +0200
To:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Reply-To: waxhead@dirtcellar.net
From:   waxhead <waxhead@dirtcellar.net>
Subject: BTRFS state on kernel 5.2
Message-ID: <204b3c8c-2f29-2319-b69e-37426cf5c792@dirtcellar.net>
Date:   Mon, 2 Sep 2019 19:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Being a long time BTRFS user and frequent reader of the mailing list I 
do have some (hopefully practical) questions / requests. Some asked 
before perhaps , but I think it is about time with an update. So without 
further ado... here we go:

1. THE STATUS PAGE:
The status page has not been updated with information for the latest 
stable kernel which is 5.2 as of writing this. Can someone please update?

2. DEFRAG: (status page)
The status page marks defrag as "mostly ok" for stability and "ok" for 
performance. While I understand that extents gets unshared I don't see 
how this will affect stability. Performance (as in space efficiency) on 
the other hand is more likely to be affected. Also is is not (perfectly) 
clear what the difference is in consequence by using the autodefrag 
mount option vs "btrfs filesystem defrag" Can someone please consider 
rewriting this?

3. SCRUB + RAID56: (status page)
The status page says it is mostly ok for both stability and performance.
It is not stated what the problem is with stability, does this have to 
do with the write-hole ?

4. DEVICE REPLACE: (status page)
This is also marked mostly ok for stability. As I understand it BTRFS 
have no issues of recovering from a failed device if it is completely 
removed. If the device is still (partly) working you may get "stuck" 
during a replace operation because BTRFS keeps trying to read from the 
failed device.
 From my point of view I think it is important to clear up this a bit so 
that people will understand that it is not the ability to replace a 
device that is "mostly ok" but the "online replace" functionality that 
might be problematic (but will not damage data).

5. DEVICE REPLACE: (Using_Btrfs_with_Multiple_Devices page)
It is not clear what to do to recover from a device failure on BTRFS.
If a device is partly working then you can run the replace functionality 
and hopefully you're good to go afterwards. Ok fine , if this however 
does not work or you have a completely failed device it is a different 
story. My understanding of it is:
If not enough free space (or devices) is available to restore redundancy 
you first need to add a new device, and then you need to A: first run 
metadata balance (to ensure that the filesystem structures is redundant) 
and then B: run a data balance to restore redundancy for your data.
Is there any filters that can be applied to only restore chunks which 
are having a missing mirror / stripe member?

6. RAID56 (status page)
The RAID56 have had the write hole problem for a long time now, but it 
is not well explained what the consequence of it is for data - 
especially if you have metadata stored in raid1/10.
If you encounter a powerloss / kernel panic during write - what will 
actually happen?
Will a fresh file simply be missing or corrupted (as in partly written).
If you overwrite/append to a existing file - what is the consequence 
then? will you end up with... A: The old data, B: Corrupted or zeroed 
data?! This is not made clear in the comment and it would be great if 
we, the BTRFS users would understand what the risk of hitting the write 
hole actually is.

7. QUOTAS, QGROUPS (status page)
Again marked as "mostly ok" on the stability. Is there any risk of 
dataloss or irrecoverable failure? If not I think it should be marked as 
stable - The only note seems to be performance related.

8. PER SUBVOLUME REDUNDANCY LEVEL:
What is the state / plan for per subvolume (or object level) redundancy 
levels - is that on the agenda somewhere? One use case is to flag the 
main filesystem as RAID1/10 and another subvolume as RAID5/6. That way 
you could be fairly sure that the server comes up while you are prepared 
to tolerate some issue (depends on the answer to question #6) on the 
subvolume that (for now) is prone to the write hole.

9. ADDING EXISTING FILESYSTEM TO THE POOL?:
Is it somehow, or will it ever be possible to add a existing BTRFS 
filesystem to a pool? It would be a wet dream come true to be able to 
add a device containing an existing BTRFS filesystem and get it to show 
up as a subvolume in the main pool

10. PURE BTRFS BOOTLOADER?
This probably belongs somewhere else, but has someone considered the 
very idea of a pure BTRFS bootloader which only supports booting up a 
BTRFS filesystem in a (as failsafe as possible) way. It is a pain to 
ensure that grub is installed on all devices and update as you 
add/remove devices from the pool and a "butterboot"-loader would be 
fantastic

11. DEDUPLICATION:
Is deduplication planned to be part of the btrfs management tool? e.g 
btrfs filesystem[/subvolume?] deuplicate /mnt

12. SPACE CACHE: (Manpage/btrfs(5) page):
I have been using space cache v2 for a long time. No issues (that I know 
about) yet. That page states that the safe default space cache is v1. 
What is the current recommended default?

13. NODATACOW:
As far as I can remember there was some issues regarding NOCOW 
files/directories on the mailing list a while ago. I can't find any 
issues related to nocow on the wiki (I might note have searched enough) 
but I don't think they are fixed so maybe someone can verify that.
And by the way ...are NOCOW files still not checksummed? If yes, are 
there plans to add that (it would be especially nice to know if a nocow 
file is correct or not)

14. VIRTUAL BLOCK DEVICE EXPORT
Are there plans to allow BTRFS to export virtual block devices from the 
BTRFS pool? E.g. so it would be possible to run other filesystems on top 
of a "protected" BTRFS layer (much like LVM / mdraid).
