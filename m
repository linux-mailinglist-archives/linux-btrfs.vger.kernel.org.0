Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9783FEEF2
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 15:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhIBNsd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 09:48:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46204 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbhIBNsb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 09:48:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4033B1FF9E;
        Thu,  2 Sep 2021 13:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630590451;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OAEHZs2p1Uyx4OdSXzqz45zFZ3sBEC2nUKopDQn3Rp0=;
        b=oB1Gz4Ri40RxB7x1nVJWi3LxTcSdqVxvsYFkgtgEWweLZO/XyHbE5Q2ODAqVkWUJvX9Pfv
        Q+Xr89NrVNYFg9sazcGW6NzHhPRteHUvIRr1jPLdtECRDXouS/nZ4mZEiaUF4XdWIfPg3I
        OIBNVgVZ3+45cMhkc/hmT2eYq6AoByU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630590451;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OAEHZs2p1Uyx4OdSXzqz45zFZ3sBEC2nUKopDQn3Rp0=;
        b=GVuw370vnlOGgWk4uBB4F4IDefpEL28rhRV8funU/KQru8mVUKXyqMeJsEeVYigju39QrG
        4WWdDycis7nHYxCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 368ADA3BA6;
        Thu,  2 Sep 2021 13:47:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C5D28DA72B; Thu,  2 Sep 2021 15:47:29 +0200 (CEST)
Date:   Thu, 2 Sep 2021 15:47:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
Subject: Re: [PATCH RFC V5 2/4] btrfs: use latest_dev in btrfs_show_devname
Message-ID: <20210902134729.GT3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
References: <cover.1629780501.git.anand.jain@oracle.com>
 <5d254bebd4afefa42e8c56ae1002354c04c7112c.1629780501.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d254bebd4afefa42e8c56ae1002354c04c7112c.1629780501.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 24, 2021 at 01:05:20PM +0800, Anand Jain wrote:
> RFC because,
> With this patch, /proc/self/mounts might not show the lowest devid
> device as we did before. Instead we show the device that has the greatest
> generation and, we used it to build the tree. IMO it is ok because
> /proc/self/mounts should show a device the belongs to the fsid not,
> necessarily the lowest devid device as devid is internal to btrfs.
> IMO this won't affect the ABI?

I tend to agree, the only thing that should be consistent that any
number of mounts of the same filesystem (eg. by subvolume) should print
the same device path. But given that fs_devices is shared then the same
output is guaranteed. The time when the latest_bdev changes is after
remove or replace, that's an intermediate state so the results may vary.

And maybe when printing the device by which the fs was mounted is more
correct, as it may be different from the lowest id and that could
potentially be confusing.  The commit 9c5085c14798 ("Btrfs: implement
->show_devname") adding the show_devname callback even mentions not
showing the mount device as a drawback.  The multi-device fs devices
should be treated equally for the purpose of mount.
