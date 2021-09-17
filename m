Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD4440F6BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 13:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344007AbhIQLez (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 07:34:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47366 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344005AbhIQLey (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 07:34:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8DE5F222E3;
        Fri, 17 Sep 2021 11:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631878411;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SKD5dpDe2XKJl9n1OReIot6H2x7FPFzpTbvfLH32/yY=;
        b=ueIft2lTsfU01FaCG7zFw+sysLQxdRjqo2O7TH0vvy7+f2xo4pAnI6PSOS9k0yRRzAaTw0
        6UPYf+xhP0cIjpwgdESWsIu9diGLqFib/R7MTtHYhwx/Rg6iQ/IZSJ6dr9TL1bsQMJ1If8
        Azj0JmbekATr1QASOXxJuwGpki28KH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631878411;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SKD5dpDe2XKJl9n1OReIot6H2x7FPFzpTbvfLH32/yY=;
        b=oZq5fhHvjrP6+BaS1eV4plJq4UMzBscSYordkk0hgqCTXOO+ycq6aWBniq64VzW0jtZrRL
        +QKVXEkCb6D2ctAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 87232A3B90;
        Fri, 17 Sep 2021 11:33:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E9FDADA781; Fri, 17 Sep 2021 13:33:21 +0200 (CEST)
Date:   Fri, 17 Sep 2021 13:33:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] btrfs: rename btrfs_bio to btrfs_io_context
Message-ID: <20210917113321.GO9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-2-wqu@suse.com>
 <20210917111923.GN9286@twin.jikos.cz>
 <c0d3f033-5b53-4026-d38d-e7e9284c1f80@gmx.com>
 <5767f47f-fd6d-1c50-e6b4-90c8bd0d8fdd@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5767f47f-fd6d-1c50-e6b4-90c8bd0d8fdd@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 17, 2021 at 07:27:30PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/9/17 19:24, Qu Wenruo wrote:
> > 
> > 
> > On 2021/9/17 19:19, David Sterba wrote:
> >> On Wed, Sep 15, 2021 at 03:17:16PM +0800, Qu Wenruo wrote:
> >>> The structure btrfs_bio is used by two different sites:
> >>>
> >>> - bio->bi_private for mirror based profiles
> >>>    For those profiles (SINGLE/DUP/RAID1*/RAID10), this structures 
> >>> records
> >>
> >> Why is SINGLE here?
> >>
> > For single we use the same routine as RAID1/DUP/etc, it's
> > submit_stripe_bio() doing the remapping.
> > 
> > Thus there is really only two types, non-RAID56 and RAID56.
> 
> And there is no really "SINGLE" profile in btrfs.
> 
> As even for SINGLE profile, we may need to submit two bios to two 
> different devices (one is the current device, the other is the 
> dev-replace target).

Ok, thanks. It's a bit confusing to mention 'single' with mirrored
profiles but here it's on the implementation level where it could be
written on more than one device. We don't have a terminology for that so
be it.
