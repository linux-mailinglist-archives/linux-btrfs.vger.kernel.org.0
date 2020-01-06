Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556D813158D
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 17:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgAFQAR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 11:00:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:40794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgAFQAR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 11:00:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4BF3CAE8A;
        Mon,  6 Jan 2020 16:00:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5180EDA78B; Mon,  6 Jan 2020 17:00:05 +0100 (CET)
Date:   Mon, 6 Jan 2020 17:00:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: sysfs, add devid/dev_state kobject and
 attribute
Message-ID: <20200106160004.GL3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <20191205112706.8125-5-anand.jain@oracle.com>
 <20191205142148.GQ2734@twin.jikos.cz>
 <78560abd-7d85-c95d-ed76-7810b1d03789@oracle.com>
 <20191205151428.GS2734@twin.jikos.cz>
 <673babd8-90ec-2f7e-532a-df8c98a844cf@oracle.com>
 <8bd3d9b9-11b1-4c9a-8b59-ccfe0c6d92c4@oracle.com>
 <20191213164332.GA3929@twin.jikos.cz>
 <20191213170215.GB3929@twin.jikos.cz>
 <1faa5860-130a-9f3c-3e44-724ce9a26adb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1faa5860-130a-9f3c-3e44-724ce9a26adb@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 14, 2019 at 08:26:24AM +0800, Anand Jain wrote:
> 
> 
> On 14/12/19 1:02 AM, David Sterba wrote:
> > On Fri, Dec 13, 2019 at 05:43:32PM +0100, David Sterba wrote:
> >>>    Looked into this further, actually we don't need any lock here
> >>>    the device delete thread which calls kobject_put() makes sure
> >>>    sysfs read is closed. So an existing sysfs read thread will have
> >>>    to complete before device free.
> >>>
> >>>
> >>>         CPU1                                   CPU2
> >>>
> >>>    btrfs_rm_device
> >>>                                             open file
> >>>       btrfs_sysfs_rm_device_link
> >>>                                             call read, access freed device
> >>>         sysfs waits for the open file
> >>>         to close.
> >>
> >> How exactly does sysfs wait for the device? Is it eg wait_event checking
> >> number of references? If the file stays open by an evil process is it
> >> going to block the device removal indefinitelly?
> > 
> > Yeah, sysfs waits until the file is closed. Eg. umount can be stalled
> > that way too.
> 
>   And similar to umount, I don't think we should return EBUSY
>   for btrfs_rm_device if the device sysfs attribute is opened,
>   as sysfs show attributes are non blocking and would be completed
>   in the timely manner.

While I don't think the blocking behaviour is totally OK, returning
EBUSY could be confusing without any other explanation. Also leaving
sysfs files open but not read is kind of strange on itself.
