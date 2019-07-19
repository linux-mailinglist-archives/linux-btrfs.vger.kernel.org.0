Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA6856E80B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2019 17:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfGSPiQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jul 2019 11:38:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:58106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbfGSPiP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jul 2019 11:38:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9576AEEC;
        Fri, 19 Jul 2019 15:38:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E272EDA861; Fri, 19 Jul 2019 17:38:50 +0200 (CEST)
Date:   Fri, 19 Jul 2019 17:38:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        calestyo@scientia.net
Subject: Re: "btrfs: harden agaist duplicate fsid" spams syslog
Message-ID: <20190719153850.GM20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Graham Cobb <g.btrfs@cobb.uk.net>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        calestyo@scientia.net
References: <5d8baf80-4fb3-221f-5ab4-e98a838f63e1@cobb.uk.net>
 <c01ab9f6-c553-3625-5656-a8f61659de7d@oracle.com>
 <a3d6e202-acf4-c02e-430a-aef4a2ee4247@cobb.uk.net>
 <7766d592-525e-67fa-5db0-bcfff17fbf83@oracle.com>
 <330f717e-c77c-f0b8-6b0d-b06249d58a81@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <330f717e-c77c-f0b8-6b0d-b06249d58a81@cobb.uk.net>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 12, 2019 at 02:32:10PM +0100, Graham Cobb wrote:
> It is weird, because there are other symlinks also pointing to the
> device. In my case, lvm sets up both /dev/mapper/cryptdata4tb--vg-backup
> and /dev/cryptdata4tb-vg/backup as symlinks to ../dm-13 but only the
> first one fights with /dev/dm-13 for the devid.

'btrfs' utility has code to canonicalize the device mapper names and use
only '/dev/mapper' and not /dev/dm-*, but I think systemd/udev has own
utility for device scanning that might not do the translation.

> > One fix for this is to make it a ratelimit print. But then the same
> > thing happens without notice. If you monitor /proc/self/mounts
> > probably you will notice that mount device changes every ~2mins.
> 
> I haven't managed to catch it. Presumably because, according to the
> logs, it seems to switch the devices back again within less than a second.

This looks like some device enumeration takes any name for a given
device and calls scan on it. I have seen that eg. systemd tries to
deactivate a swap partition by all names it found under /dev/disk/* .

> > I will be more keen to find the module which is causing this issue,
> > that is calling 'btrfs dev scan' every ~2mins or trying to mount
> > an unmounted device without understanding that its mapper is already
> > mounted.
> 
> Any ideas how we can determine that?
> 
> Can I try something like stopping udev for 5 minutes to see if it stops?
> Or will that break my system (I can't schedule any downtime until after
> I am back)? Note (in case it is relevant) this is a systemd system so
> udev is actually systemd-udevd.service.

'udevadm monitor' can tell something about the device changes.

We still don't understand what happens but I'm inclined to think that
the fix should be in btrfs scanning code to print the message only once
for a given device with the first name.

The device path must exist in system and can be always traced either to
the /dev/dm-* or to /dev/mapper name, so it's maybe a minor usability
issue expecing user to resolve the path to see the pretty name.
