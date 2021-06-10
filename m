Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4563A30D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 18:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhFJQlo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 12:41:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48496 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJQln (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 12:41:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B49731FD3F;
        Thu, 10 Jun 2021 16:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623343185;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rjo4yU49aNzDHUoL/7NPBcF08/U2ZIUgmFLmvQnYc9g=;
        b=bbUV11Aph3pL8ls72exZ+QSSOz0E9pGx4rhxu9A2lKy2xrs2x9ve7S4Q8nwWAyJll2ejLC
        qj13BgTgpp+8ZcbBD1R0JULicJYAYiYqVokdMpwB4vEEeNNYWz1c5GikAI4X6VlUmtpXZz
        xRbhlXhAQeWauE6lUoGJ4ekxXIXNC00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623343185;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rjo4yU49aNzDHUoL/7NPBcF08/U2ZIUgmFLmvQnYc9g=;
        b=HmjryIKpa7BsoSdlSiwGdwKpyuNKmavvHenkwddEzWx7cLlDIr8rLifTtEiG62vaaUl3Un
        rwl2rend/F+M4/AQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AE275A3B96;
        Thu, 10 Jun 2021 16:39:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1EABDDA8EB; Thu, 10 Jun 2021 18:37:01 +0200 (CEST)
Date:   Thu, 10 Jun 2021 18:37:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: export dev stats in devinfo directory
Message-ID: <20210610163700.GC28158@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210604132058.11334-1-dsterba@suse.com>
 <YMEHVWTrcJ6ol5bH@relinquished.localdomain>
 <20210609185014.GE27283@twin.jikos.cz>
 <YMFi6fSxMUDCU/C9@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMFi6fSxMUDCU/C9@relinquished.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 09, 2021 at 05:55:05PM -0700, Omar Sandoval wrote:
> > > The ioctl returns ENODEV is !dev_stats_valid, maybe this file should do
> > > the same? It seems a little awkward to have a flag that means that the
> > > rest of the file is meaningless.
> > 
> > You mean returning -ENODEV when reading the stats file? Or return 0 but
> > the contents is something like 'stats invalid' or similar.
> 
> I'd vote for returning -ENODEV when reading the stats file, but I think
> either one is fine.

Hm so I think this should reflect how the sysfs files are used. They all
contain textual information, and errors are returned when eg. there are
no permissions.

In a shell script it's IMHO more convenient to do

stats=$(cat $devicepath/stats)

and then validate contents of $stats rather then catching the error
value and deciding based on that what happend. Not to say that this
would also print an error message. I've found this in
admin-guide/sysfs-rules.rst that's perhaps closest to a recommendation
we could follow:

172 - When reading and writing sysfs device attribute files, avoid dependency
173     on specific error codes wherever possible. This minimizes coupling to
174     the error handling implementation within the kernel.

So I take it as that error codes belong to the sysfs layer and the
validity of the contents is up to the sysfs user, ie. btrfs in this
case.
