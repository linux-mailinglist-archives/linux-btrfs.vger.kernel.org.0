Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABFC2F5811
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 04:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbhANCNl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jan 2021 21:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbhANCNa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jan 2021 21:13:30 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88E8C061575
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jan 2021 18:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202012; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Reply-To:To:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uFMvi4lyAneeZxEQk6rGmGymyuPC55TCA9Payu/Y4+U=; b=mVgw50wd6WnP0fAYIFBSQb+cfe
        qMfnJGOjByIVsXXv3rVcoduUrKrbeZN2q3CeWy6dp6o+LxEFt26iAkkT2mRS1J6GcuRg+o6jCRTAd
        GFfPiQPb0lV4PfC+zPvoo4A6FEy1VkXM2MweG8n28uYrFbVqnl+r/XmzQzZQIrGo5kmDEjQc+7pYE
        6g3s24UzYXP0q/cvNgRCWMOQ+eoafNFkfuh3QvCZYvKlrjaLUWa+hFOxJKv2NIiiowtbdOVbEn8ck
        p0/iOa630IcFyyP5qhPbQBLsy/ofpWqafwaDpx54DtGCrlHFsYIQzSg/LTJJ+zqVMoK8IBShsvFRE
        yXs9528A==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:5689 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1kzs7e-0006sy-UT
        for linux-btrfs@vger.kernel.org; Thu, 14 Jan 2021 03:12:26 +0100
To:     linux-btrfs@vger.kernel.org
Reply-To: waxhead@dirtcellar.net
From:   waxhead <waxhead@dirtcellar.net>
Subject: Why do we need these mount options?
Message-ID: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
Date:   Thu, 14 Jan 2021 03:12:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Howdy,

I was looking through the mount options and being a madman with strong 
opinions I can't help thinking that a lot of them does not really belong 
as mount options at all, but should rather be properties set on the 
subvolume - for example the toplevel subvolume.

And any options set on a child subvolume should override the parrent 
subvolume the way I see it.

By having a quick look - I don't see why these should be mount options 
at all.

autodefrag / noautodefrag
commit
compress / compress-force
datacow / nodatacow
datasum / nodatasum
discard / nodiscard
inode_cache / noinode_cache
space_cache / nospace_cache
sdd / ssd_spread / nossd / no_ssdspread
user_subvol_rm_allowed

Stuff like compress and nodatacow can be set with chattr so there is as 
far as I am aware three methods of setting compression for example.

Either by mount options in fstab, by chattr or by btrfs property set

I think it would be more consistent to have one interface for adjusting 
behavior.

As I asked before, the future plan to have different storage profiles on 
subvolumes seem to have been sneakily(?) removed from the wiki - if that 
is indeed a dropped goal I can see why it makes sense to keep the mount 
options, if not I think the mount options should go in favor of btrfs 
property set.
