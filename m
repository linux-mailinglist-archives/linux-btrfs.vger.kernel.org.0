Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765F41026DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 15:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfKSOer (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 09:34:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:54200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbfKSOer (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 09:34:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5112B2F8;
        Tue, 19 Nov 2019 14:34:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A3309DA783; Tue, 19 Nov 2019 15:34:46 +0100 (CET)
Date:   Tue, 19 Nov 2019 15:34:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nathan Dehnel <ncdehnel@gmail.com>
Subject: Re: [PATCH] btrfs: resize: Allow user to shrink missing device
Message-ID: <20191119143444.GT3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nathan Dehnel <ncdehnel@gmail.com>
References: <20191118070525.62844-1-wqu@suse.com>
 <18e6af7c-a9b0-9a9d-f91b-ade078c6b2c1@oracle.com>
 <a7dedb8c-f80c-8abb-8332-cbbc681e7a49@gmx.com>
 <9f35f91d-802f-9c93-11f5-fbdffe583a88@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f35f91d-802f-9c93-11f5-fbdffe583a88@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 19, 2019 at 03:40:42PM +0800, Anand Jain wrote:
>   IMO changing the size of the missing device is point less. What if
>   in between the resize and replace the missing device reappears
>   in the following unmount and mount.

The reappearing device is always tricky. If the device is missing from
the beginning, it'll exist in the fs_devices structure with MISSING bit
set. If it reappears, device_list_add will find it, update the path and
drop the missing bit.

From that point the device is regular but might miss some data updates.
There's a check for last generation of the device to pick the latest
one, but this applies only to mount.

Now when there's a replace in progress, and on a redundant profile, like
in the reported case, the device can be used as source device as long as
the data are not stale. This is detected by generation mismatch.

The resize of missing device happens on the in-memory structure as it is
represented in the fs_devices list, before the device reappears. And
after it's scanned again, the device item in memory is not changed, so
the size stays and is used until replace finishes.

Which is IMO all ok for the usecase, but the device states are tricky so
I could have missed something.
