Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A11D2F8A9E
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 02:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbhAPB6J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jan 2021 20:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbhAPB6J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 20:58:09 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBACC061757
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 17:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202012; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0juaDQNFhuBnMzmBfwS+FUIxp2EBPzrlisKjfmuoYyA=; b=QcVSrQspykGkv+Kye3zw8OV0Tb
        yjEQt4ReJjEk6lq5SiKeKnsqCmz0IuNFhGOpldiGyhCEuC8jZitdFY1FPqKVQmnSvPOaGesMOacQc
        bTb5zylnQaK0S4Al+JJa2EnIBltnLnHhLQ3PL0/HaMPGZnp2HFz2Um+1LCI4X5GrDNH908ZGVlZu2
        08UA17duHOzgYMwPHpWSoGUUHVCcav7phr2DLGw8HZ0AcAQLbD4ot94PRH2bFBCc1Gc+TRHNFcEdA
        Z1azIf3Zla1n53v4zRxR38LsbKkwDC0S/HfB4sq89JJU7OzPKsmYACvxyR2OTSKZ9UpeOmE+9riyo
        p3LYdHeg==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:38123 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1l0apu-00035d-TN; Sat, 16 Jan 2021 02:57:06 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: Why do we need these mount options?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
 <20210114163729.GY6430@twin.jikos.cz> <20210115035448.GD31381@hungrycats.org>
 <649487eb-0161-877c-9e80-b0400d1097bf@dirtcellar.net>
 <20210116004208.GF31381@hungrycats.org>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <650854d9-1558-ab11-683d-6ebac147b0b7@dirtcellar.net>
Date:   Sat, 16 Jan 2021 02:57:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.4
MIME-Version: 1.0
In-Reply-To: <20210116004208.GF31381@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Zygo Blaxell wrote:
> On Fri, Jan 15, 2021 at 10:32:39AM +0100, waxhead wrote:
>> Zygo Blaxell wrote:
>>>
>>>>> commit
>>>>> space_cache / nospace_cache
>>>>> sdd / ssd_spread / nossd / no_ssdspread
>>>
>>> How could those be anything other than filesystem-wide options?
>>>
>>
>> Well being me, I tend to live in a fantasy world where BTRFS have complete
>> world domination and has become the VFS layer.
>> As I have nagged about before on this list - I really think that the only
>> sensible way forward for BTRFS (or dare I say BTRFS2) would be to make it
>> possible to assign "storage device groups" where you can make certain btrfs
>> device ids belong to group a,b,c, etc...
>>
>> And with that it would be possible to assign a weight to subvolumes so that
>> they would be preferred to be stored on group a (SSD's perhaps), while other
>> subvolumes would be stored mostly or exlusively on HDD's, Fast HDD's,
>> Archival HDD's etc... So maybe a bit over enthusiastic in thinking perhaps ,
>> but hopefully you see now why I think it is right that this is not
>> filesystem-wide , but subvolume baseed properties.
> 
> Sure, that's all wonderful, but it has nothing to do with any of those
> mount options.  ;)
> 
> commit sets a timer that forces a filesystem-wide sync() every now
> and then.  space_cache picks one of the allocator implementations, also
> for the entire filesystem.  ssd and related options affect the behavior
> of the metadata allocator and superblocks.
> 
Ok I understand the space_cache, but commit (the way I understand it) 
could be useful to keep stuff in memory for longer for certain subvolume.
ssd options could also be useful pr. subvolume *if* and that is a big if 
BTRFS sometime in the far future allows for storage device groups. 
However when that happens maybe everything is solid state , who knows ;)

>>>>> discard / nodiscard
>>>
>>> Maybe, but probably requires too much introspection in a fast path (we'd
>>> have to add a check for the last owner of a deleted extent to see if it
>>> had 'discard' set on some parent level).
>>>
>>> On the other hand, I'm in favor of deprecating the whole discard option
>>> and going with fstrim instead.  discard in its current form tends to
>>> increase write wear rather than decrease it, especially on metadata-heavy
>>> workloads.  discard is roughly equivalent to running fstrim thousands
>>> of times a day, which is clearly bad for many (most?  all?) SSDs.
>>>
>>> It might be possible to make the discard mount option's behavior more
>>> sane (e.g. discard only full chunks, configurable minimum discard length,
>>> discard only within data chunks, discard only once per hour, etc).
>>>
>> Interesting, it might as well make sense to perhaps use the free space cache
>> and a slow LRU mechanism e.g. "these chunks has not been in use for 64
>> hours/days" or something similar.
> 
> That would add more writes, as the free space cache is an on-disk entity.
> It might make sense to maintain a 'discard tree', which lists extents
> that have been freed but not yet discarded or overwritten, to make fstrim
> more efficient.  This wouldn't have to be very precise, just pointing to
> general regions of the disk (maybe even entire block groups) so fstrim
> doesn't issue discards to idle areas of the disk over and over.
> 
> Currently the discard extent list is stored in memory, so doing one
> discard per T time units would use more memory.  This feature would be
> like discard=async, but 1) it would hold on to the pinned extents for a
> few hundred transactions instead of just one or two (subject to memory
> availability), and 2) it would be able to reclaim space from the discard
> list as free space, thus removing the need to issue a discard at all.
> 
> But that's really complicated, considering that a cron job that runs
> fstrim once an hour can do the same thing without all the complexity.
> On the other hand, I just ran fstrim on a test machine and it took
> 34 minutes, so maybe some complexity might be useful after all... :-O
> 
Thanks for the education. Inspired by this I ran fstrim on my main 
machine with 7 older and smaller SSD's. Have not run fstrim on it or 
maybe a year so it took 15-20 minutes to do. But I see your point. 
Minimizing writes to SSD's is a good thing, but if I am not mistaking 
SMR disks can benefit from discard as well, I don't know the details but 
maybe it would be more beneficial on real disks than SSD storage?

>>>>> compress / compress-force
>>>>> datacow / nodatacow
>>>>> datasum / nodatasum
>>>
>>> Here's where I prefer the mount option over the more local attributes,
>>> because I'd like filesystem-level sysadmin overrides for those.
>>> i.e. disallow all users, even privileged ones, from being able to create
>>> files that don't have csums or compression on a filesystem.
>>>
>> Then how about a mount option that allow only root to do certain things?
>> e.g. a security restriction.
> 
> No, I don't want root doing those things either.  Most of the applications
> I want to bring to heel are already running as root.
> 
> Basically I want to say "every file on this filesystem shall be datacow
> and datasum" and (short of altering the mount option) no other kind of
> file can be created.
> 
> It might possibly make more sense to do this through tunefs--that way the
> filesystem couldn't ever have nodatacow files (new kernels would refuse,
> old kernels wouldn't be able to mount through a new feature flag).
> 
Allrighty point taken.

>>>>> user_subvol_rm_allowed
>>>
>>> I'd like "user_subvol_create_disallowed" too.  Unprivileged users can
>>> create subvols, and that breaks backups that rely on atomic btrfs
>>> snapshots.  It could be a feature (it allows users to exclude parts of
>>> their home directory from backups) but most users I've met who have
>>> discovered this "feature" the hard way didn't enjoy it.
>>>
>>> Historically I had other reasons to disallow subvol creates by
>>> unprivileged users, but they are mostly removed in 4.18, now that 'rmdir'
>>> works on an empty subvol.
>>>
>> Again see above...
> 
> Here, unlike above, I was already asking precisely for subvol create to
> be made root only.
> 
> That, or make snapshots recursive and atomic to avoid the accidental
> user data loss/corruption case.
> 
Allrighty again! :)
