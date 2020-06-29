Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EB220CB28
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jun 2020 02:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgF2APM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Jun 2020 20:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgF2APM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Jun 2020 20:15:12 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B5FC03E979
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jun 2020 17:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201912; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ltPC8NjqPyagJ6V9+O1LdYDAEcRjwhPIG9YLPtIAL58=; b=HxftmQ3bWVo2jU01ILj/M2ciIH
        kKkEHxSOIh4ldoRwJQI12GCrfCRDOVRLvVUGZbsDOoSAy9ROeQ6VrWGCTJ0dsv1UG70N/7KlglmU3
        gguzZZ2KXwn3oHDN2Z+Uy0ghEIeb0LnVU7eaESCl4wOVbxYWcNkrAHy5cltP2rdAsACtnU317OK2S
        jYLRlz9iFM7KCpibuUSAi1lGpbFdIOFvDBKMs/9J+CVM5Xe3YKKH/BDVeTvXxELgme5opu7r2bGSe
        eQzqHwjFmcfupqbvKVJw9jR6lUj+ebvtdVlocsQXR/P/64wuODGC32Sq4vreO+YoqKBucnOa9gn/E
        OJMoBIdQ==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:52065 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1jphS0-0007tT-4p; Mon, 29 Jun 2020 02:15:08 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: Buggy disk firmware (fsync/FUA) and power-loss btrfs survability
To:     Hans van Kranenburg <hans@knorrie.org>,
        Pablo Fabian Wagner Boian <pablofabian.wagnerboian@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAK=moY9cRF0WKnBp5wRzFUuuL9=rJ8mD8uEA6murWEUYwvQkWw@mail.gmail.com>
 <f0144a34-f14a-5413-9b0c-a2ccba1a1cd9@knorrie.org>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <2aaab8d7-a37d-8965-bd70-9ed7b0e80b0f@dirtcellar.net>
Date:   Mon, 29 Jun 2020 02:15:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
In-Reply-To: <f0144a34-f14a-5413-9b0c-a2ccba1a1cd9@knorrie.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hans van Kranenburg wrote:
> Hi!
> 
> On 6/28/20 3:33 PM, Pablo Fabian Wagner Boian wrote:
>> Hi.
>>
>> Recently, it came to my knowledge that btrfs relies on disks honoring
>> fsync. So, when a transaction is issued, all of the tree structure is
>> updated (not in-place, bottom-up) and, lastly, the superblock is
>> updated to point to the new tree generation. If reordering happens (or
>> buggy firmware just drops its cache contents without updating the
>> corresponding sectors) then a power-loss could render the filesystem
>> unmountable.
>>
>> Upon more reading, ZFS seems to implement a circular buffer in which
>> new pointers are updated one after another. That means that, if older
>> generations (in btrfs terminology) of the tree are kept on disk you
>> could survive such situations by just using another (older) pointer.
> 
> Btrfs does not keep older generations of trees on disk. *) Immediately
> after completing a transaction, the space that was used by the previous
> metadata can be overwritten again. IIRC when using the discard mount
> options, it's even directly freed up on disk level by unallocating the
> physical space by e.g. the FTL in an SSD. So, even while not overwritten
> yet, reading it back gives you zeros.
> 
> *) Well, only for fs trees, and only if you explicitly ask for it, when
> making subvolume snapshots/clones.
> So just out of curiosity... if BTRFS internally at every successful 
mount did a 'btrfs subvolume create /mountpoint /mountpoint/fsbackup1' 
you would always have a good filesystem tree to fall back to?! would 
this be correct?!

And if so - this would mean that you would loose everything that 
happened since last mount, but compared to having a catastrophic failure 
this sound much much better.

And if I as just a regular BTRFS user with my (possibly distorted) view 
see this, if you would leave the top level subvolume (5) untouched and 
avoid updates to this except creating child subvolues you reduce the 
risk of catastrophic failure in case a fsync does not work out as only 
the child subvolumes (that are regularily updated) would be at risk.

And if BTRFS internally made alternating snapshots of the root 
subvolumes (5)'s child subvolumes you would loose at maximum 30sec x 2 
(or whatever the commit time is set to) of data.

E.g. keep only child subvolumes on the top level (5).
And if we pretend the top level has a child subvolume called rootfs, 
then BTRFS could internally auto-snapshot (5)/rootfs every other time to 
(5)/rootfs_autobackup1 and (5)/rootfs_autobackup2

Do I understand this correctly or would there be any (significant) 
performance drawback to this? Quite frankly I assume it is or else I 
guess it would have been done already , but it never hurts (that much) 
to ask...
