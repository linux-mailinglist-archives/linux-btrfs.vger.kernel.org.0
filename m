Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98FBA6E79B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2019 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfGSO6B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jul 2019 10:58:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbfGSO6B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jul 2019 10:58:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD106B005;
        Fri, 19 Jul 2019 14:57:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D4E60DA7E8; Fri, 19 Jul 2019 16:58:34 +0200 (CEST)
Date:   Fri, 19 Jul 2019 16:58:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, g.btrfs@cobb.uk.net,
        calestyo@scientia.net
Subject: Re: [PATCH] btrfs: ratelimit device path change info on mounted
 device
Message-ID: <20190719145833.GL20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, g.btrfs@cobb.uk.net,
        calestyo@scientia.net
References: <5d8baf80-4fb3-221f-5ab4-e98a838f63e1@cobb.uk.net>
 <20190716135910.848-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716135910.848-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 16, 2019 at 09:59:10PM +0800, Anand Jain wrote:
> If there are more than one path to a device, the last scanned path
> will map to the mounted FS. In some Linux based os there appears to be a
> system script (autofs?) which fails to notice that a device's alternative
> path is already mounted, and so the change in device-path gets logged
> every ~2mins whenever such a script is active.
> 
> kernel: [33017.407252] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
> kernel: [33017.522242] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
> kernel: [33018.797161] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
> kernel: [33019.061631] BTRFS info (device sdc3):
> device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
> old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
> 
> Fix this by using the ratelimit printk.

The ratelimiting will most certainly not stop the repeated messages,
btrfs_info_rl_in_rcu uses the default settings which is to limit within
5 seconds and allow burts of 10 messages.
