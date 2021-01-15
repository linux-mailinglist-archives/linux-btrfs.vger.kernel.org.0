Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBE12F6F3A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jan 2021 01:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbhAOADR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 19:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbhAOADR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 19:03:17 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E47C061575
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 16:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202012; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E562Myb1Wc7MLN67Xq20W7cSFZkwotEBwqUdJkbI/sY=; b=qQyROAQ4uQAqiAWZfurl4Qw6tY
        SWK747qbHReBK/rvfz2c7rFwSlCxwkqnOYu92moOW+jhBvM+YnfkE9l6q1j4doRMrkEbRCJ++R6o0
        080KyPYiRITe7dKZj6CBeHN4T+1qzOFbjPDx3tsfLUY3fVZj+SZoxnwCjLDVZGpsZNqQHP3VWqbWY
        0X6JS5+B1wEp4M3MjG7nAfspXNfiBUly0N3NPkVgjFonEaogWJDbynNzFW1jUOwMxV2oX3s2FeNS1
        eSHy7Hg6ombVYD3dvCmURF2P8RBN6mNiU/vOrinefapAMZXo9G48J7tnjtjAPgP7sMGjPt9bOslAi
        9WEbNvJQ==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:2763 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1l0CZA-0006pl-T7; Fri, 15 Jan 2021 01:02:12 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: Why do we need these mount options?
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
 <20210114163729.GY6430@twin.jikos.cz>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <e9257bae-b744-42a7-1fc3-39b3ea676898@dirtcellar.net>
Date:   Fri, 15 Jan 2021 01:02:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.4
MIME-Version: 1.0
In-Reply-To: <20210114163729.GY6430@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David Sterba wrote:
> Hi,
> 
> On Thu, Jan 14, 2021 at 03:12:26AM +0100, waxhead wrote:
>> I was looking through the mount options and being a madman with strong
>> opinions I can't help thinking that a lot of them does not really belong
>> as mount options at all, but should rather be properties set on the
>> subvolume - for example the toplevel subvolume.
> 
> I agree that some of them should not be there but mount options still
> have their own usecase. They can be set from the outside and are
> supposed to affect the whole filesystem mount lifetime.
> Yes, some of them. But not all, the ones I list for example can 
perfectly well be set on the toplevel subvolume.

> However, they've been used as default values for some operations, which
> is something that points more to what you suggest. And as they're not
> persistent and need to be stored in /etc/fstab is also weighing for
> storage inside the fs.
> 
>> And any options set on a child subvolume should override the parrent
>> subvolume the way I see it.
> 
> Yeah, that's one of the ways how to do it and I see it that way as well.
> Property set closer to the object takes precedence, roughly
> 
> mount < subvolume < directory < file
> 
> but last time we had a discussion about that, the other oppinion was
> that mount options beat everything, perhaps because they can be set from
> the outside and forced to ovrride whatever is on the filesystem.
> 
Well I agree with that. Mount options should beat everything and just 
because of that I think that some mount options should be deprecated and 
instead be set per. subvolume.

>> By having a quick look - I don't see why these should be mount options
>> at all.
>>
>> autodefrag / noautodefrag
>> commit
>> compress / compress-force
>> datacow / nodatacow
>> datasum / nodatasum
>> discard / nodiscard
>> inode_cache / noinode_cache
>> space_cache / nospace_cache
>> sdd / ssd_spread / nossd / no_ssdspread
>> user_subvol_rm_allowed
> 
> So there are historical reasons and interface limitations that led to
> current state and multiple ways to do things.
> 
> Per-inode attributes were originally private ioctl of ext2 that other
> filesystems adopted due to feature parity, and as the interface was
> bit-based, no additional values could be set eg. compression, limited
> number of bits, no precedence, inter-flag dependencies.
> 
Ok thanks, I was not aware of that.

>> Stuff like compress and nodatacow can be set with chattr so there is as
>> far as I am aware three methods of setting compression for example.
>>
>> Either by mount options in fstab, by chattr or by btrfs property set
>>
>> I think it would be more consistent to have one interface for adjusting
>> behavior.
> 
> I agree with that and there's a proposal to unify that into the
> properties as interface once for all, accessible through the extended
> attributes. But there are much more ways how to do that wrong so it
> hasn't been implemented so far.
> 
Good to know, and by the way another nugget of entertainment is that 
with btrfs property set the parameters come after the object. Usually 
command->params->target is IMHO the better way to go. It seems a bit 
backwards.

> A suggestion for an inode flag here and there comes from time to time,
> fixing one problem each time. Repeating that would lead to a mess that
> can be demonstrated on the existing mount options, so we've been there
> and need to do it the right way.
> 
>> As I asked before, the future plan to have different storage profiles on
>> subvolumes seem to have been sneakily(?) removed from the wiki
> 
> I don't think the per-subvolume storage options were ever tracked on
> wiki, the closest match is per-subvolume mount options that's still
> there
> 
> https://btrfs.wiki.kernel.org/index.php/Project_ideas#Per-subvolume_mount_options
> 
Well how about this from our friends archive.org ?
http://web.archive.org/web/20200117205248/https://btrfs.wiki.kernel.org/index.php/Main_Page

Here it clearly states that object level mirroring and striping is 
planned. Maybe I misinterpret this , but I understand this as (amongst 
other things) configurable storage profiles per subvolume.

>> - if that is indeed a dropped goal I can see why it makes sense to
>> keep the mount options, if not I think the mount options should go in
>> favor of btrfs property set.
