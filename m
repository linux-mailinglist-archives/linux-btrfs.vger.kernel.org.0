Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E4A449CC8
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbhKHUCM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 15:02:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42858 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhKHUCL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 15:02:11 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 16DDD21639;
        Mon,  8 Nov 2021 19:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636401566;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oW2AojMJ2r9cfeNL3419R+eKAl9HABG3/c9sJG0m1Rc=;
        b=LbIJh6oppynVSvdXRbq93GWI7+S/itN5AC73kywEeSyDGNg3MsqyznONOpa525OALUo0ra
        CBFyxaerQwCRtsdSWt0lUiB7D0LHoHeGdsfOSjiN262wXhhSGa8/Jq4JoJ87/2u71nSeua
        FaeYDyiqhYkooJDeYllbE8rdsUYitPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636401566;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oW2AojMJ2r9cfeNL3419R+eKAl9HABG3/c9sJG0m1Rc=;
        b=uZ3YL8DFzddC5vSmYFPqhxaslIgwoxE7AkRdu1rdBMePxWMYNyhR5veX4MkaaPzhBQVkjC
        QdjEJ7M+GY2qCPBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0FE90A3B81;
        Mon,  8 Nov 2021 19:59:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6DE7BDA799; Mon,  8 Nov 2021 20:58:47 +0100 (CET)
Date:   Mon, 8 Nov 2021 20:58:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add a warning to check on the leaking device close
Message-ID: <20211108195847.GN28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <8ad72827dc32542915f87db73cbb6b609f24dce4.1600074377.git.anand.jain@oracle.com>
 <20200916101003.GM1791@twin.jikos.cz>
 <52013ea3-fd54-5dbd-5c4d-3c5f41fdbf93@oracle.com>
 <c1ff087a-26e6-f2d1-eeac-73d65d3a432e@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1ff087a-26e6-f2d1-eeac-73d65d3a432e@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 28, 2020 at 02:16:34PM -0400, Josef Bacik wrote:
> On 9/16/20 7:51 AM, Anand Jain wrote:
> > 
> > 
> > On 16/9/20 6:10 pm, David Sterba wrote:
> >> On Mon, Sep 14, 2020 at 05:11:14PM +0800, Anand Jain wrote:
> >>> To help better understand the device-close leaks, add a warning if the
> >>> device freed is still open.
> >>
> >> Have you seen that happen or is it just a precaution? I've checked where
> >> the bdev is set to NULL and all paths seem to be covered, so the warn_on
> >> does not harm anything just that it does not seem to be possible to hit.
> >> For that an assert would be better.
> > 
> > There is an early/unconfirmed report [1] that after the forget
> > sub-command a device had partition changes and the new partitions failed
> > to recognize by the kernel.
> > [1]
> > https://lore.kernel.org/linux-btrfs/40e2315e-e60e-6161-ceb7-acd8b8a4e4a0@oracle.com/T/#t 
> > 
> > 
> > The mount thread can't use device_list_mutex (because of bd_mutex),
> > and we rely on the uuid_mutex during mount.
> > 
> > The forget thread used both uuid_mutex and device_list_mutex.
> > 
> > So there isn't race between these two.
> > 
> > As of now we don't know. So the warning will help to know if we are
> > missing something.
> > 
> 
> It is clear that it can't really happen, but if we're worried about it I'd 
> rather it be an ASSERT().  Thanks,

I'm going through the patch backlog and the patch may be still relevant
but a lot of device locking code has changed recently.

Anand, if this is still relevant, please resend, thanks.
