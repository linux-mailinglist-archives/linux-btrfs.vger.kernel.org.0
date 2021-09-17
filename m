Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7575640F689
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 13:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243602AbhIQLKg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 07:10:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44272 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbhIQLKg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 07:10:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4AE6622361;
        Fri, 17 Sep 2021 11:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631876953;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZGjbs4+7hQuu8jfSTpamvHRT+dOcf3B5k/+YYKUHHBw=;
        b=mSfCMbaqU0pqFvAxnKmR2FlHMXbi7XKWNQECMRkX2Dj2fqwK7yqs1lHi1yQKovF34MfsOq
        /cV/69PSpXIYrUvVvpi+qR4YhOhsIRZeItQGSlnaSJFqwbFF/guBhDBGDKNqlGE8OWm8tX
        9/HukBIdK1eD485ojJ0dkiai1CQAmgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631876953;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZGjbs4+7hQuu8jfSTpamvHRT+dOcf3B5k/+YYKUHHBw=;
        b=zblXz4EgMw8gzQy2l1BH9xXsfsL8qqwbkHDew7bHYdcTvFdSYyhpL+L6CQSicBL2hBI/wV
        PTfCnb6atk9Lp7Dw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 443ECA3B93;
        Fri, 17 Sep 2021 11:09:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9B274DA781; Fri, 17 Sep 2021 13:09:03 +0200 (CEST)
Date:   Fri, 17 Sep 2021 13:09:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Eli V <eliventer@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: strangely large space_info value in dmesg
Message-ID: <20210917110903.GM9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Eli V <eliventer@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAJtFHUSy4zgyhf-4d9T+KdJp9w=UgzC2A0V=VtmaeEpcGgm1-Q@mail.gmail.com>
 <ca8e4d97-633c-2d1b-80b9-85a4f82229f1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca8e4d97-633c-2d1b-80b9-85a4f82229f1@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 16, 2021 at 08:38:52PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/9/16 20:32, Eli V wrote:
> > I just upgraded one of my btrfs systems from 4.19 kernel to 5.10.46
> > dmesg is outputing the below messages, I assume because of the
> > enospc_debug mount option I've had in fstab for quite some time now.
> > Didn't check all of the numbers, but the first line free value does
> > seem erroneous, unless that's some sort of theoretical maximum being
> > displayed. This is a fairly large filesystem at 382TB (btrfs usage
> > below,) but that's a lot more free then total space:
> >
> > Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): space_info 4 has
> > 18446743694945091584 free, is not full
> 
> This is space info dump, normally meaning you're hitting ENOSPC.
> 
> The free value has underflow, we should output it in s64 other than u64.
> 
> The free space should be -378764460032.

It's still a bit weird to see a negative number but as you found out
it's due to overcommit so it's possible.
