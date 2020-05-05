Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAFA1C5E48
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 19:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgEERDk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 13:03:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:44766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729553AbgEERDk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 May 2020 13:03:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 60D8FAED5;
        Tue,  5 May 2020 17:03:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 08F11DA726; Tue,  5 May 2020 19:02:50 +0200 (CEST)
Date:   Tue, 5 May 2020 19:02:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        nborisov@suse.com, josef@toxicpanda.com
Subject: Re: [PATCH 3/3] btrfs: free alien device due to device add
Message-ID: <20200505170250.GU18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com,
        josef@toxicpanda.com
References: <20200428152227.8331-1-anand.jain@oracle.com>
 <20200428152227.8331-4-anand.jain@oracle.com>
 <20200430133111.GL18421@twin.jikos.cz>
 <af735fb7-e03d-b143-5eef-5b1b32c283bd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af735fb7-e03d-b143-5eef-5b1b32c283bd@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 02, 2020 at 04:01:28AM +0800, Anand Jain wrote:
>   Ah. I didn't notice that. Will fix.
> 
> > As there's NULL passed, 
> 
>   NULL is passed to the 2nd argument skip_device
> 
> > all stale devices will be removed from the list,
> 
>   No, It means it does not have any particular device to skip.
>   Added device is already part of mounted fs_device list,
>   the loop skips its check. So no need to skip_device.
> 
> > but we can remove just the device being added, no?
> 
>   It does exactly that.
>   btrfs_free_stale_devices(device_path, NULL);
> 
>   It removes the device from all other fs_devices which are _unmounted_.

Right, I got it wrong.

> > And before the whole
> > operation starts, not after. 
> 
>   What if the add fails? Then we have to add scanned device back to avoid
>   that mess. why not remove after we have successfully add the device
>   to the mounted fsid.

As there's no synchronization, there will be either need for a rollback
action or stale information after the change is permanent (device added
to new filesystem) but no fs_devices update happens.

The difference is that when the device is removed first, the rollback
happens only in exceptional cases, when the commit fails.

OTOH the time window between commit and removal happens each time. The
ohly hope here is that the window is really short so there's practically
zero chance of another process to jump in trying to use the device.
