Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D833E149634
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 16:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgAYPWp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jan 2020 10:22:45 -0500
Received: from savella.carfax.org.uk ([85.119.84.138]:36652 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYPWp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jan 2020 10:22:45 -0500
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1ivNGl-0001iz-LQ; Sat, 25 Jan 2020 15:22:43 +0000
Date:   Sat, 25 Jan 2020 15:22:43 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Broken Filesystem
Message-ID: <20200125152243.GI26453@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Hendrik Friedel <hendrik@friedels.name>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <em16e3d03d-97be-4ddb-b4a4-6a056b469f20@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <em16e3d03d-97be-4ddb-b4a4-6a056b469f20@ryzen>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 25, 2020 at 11:34:10AM +0000, Hendrik Friedel wrote:
> Hello,
> 
> I am helping someone here https://forum.openmediavault.org/index.php/Thread/29290-Harddrive-Failure-and-Data-Recovery/?postID=226502#post226502
> to recover his data.
> He is new to linux.
> 
> Two of his drives have a hardware problem.
> btrfs filesystem show /dev/sda
> Label: 'sdadisk1' uuid: fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
> Total devices 1 FS bytes used 128.00KiB
> devid 1 size 931.51GiB used 4.10GiB path /dev/sda
> 
> The 4.1GiB are way less than what was used.
> 
> 
> We tried to mount with mount -t btrfs -o recovery,nospace_cache,clear_cache
> 
> [Sat Jan 18 11:40:29 2020] BTRFS warning (device sda): 'recovery' is
> deprecated, use 'usebackuproot' instead
> [Sat Jan 18 11:40:29 2020] BTRFS info (device sda): trying to use backup
> root at mount time
> [Sat Jan 18 11:40:29 2020] BTRFS info (device sda): disabling disk space
> caching
> [Sat Jan 18 11:40:29 2020] BTRFS info (device sda): force clearing of disk
> cache
> [Sun Jan 19 11:58:24 2020] BTRFS warning (device sda): 'recovery' is
> deprecated, use 'usebackuproot' instead
> [Sun Jan 19 11:58:24 2020] BTRFS info (device sda): trying to use backup
> root at mount time
> [Sun Jan 19 11:58:24 2020] BTRFS info (device sda): disabling disk space
> caching
> [Sun Jan 19 11:58:24 2020] BTRFS info (device sda): force clearing of disk
> cache
> 
> 
> The mountpoint does not show any data when mounted

   After you mount the FS, do you see the mounted filesystem in the
output of "mount"? If not, then you've probably got systemd thinking
that the FS shouldn't be mounted there, and unmounting it again
immediately.

   If you do see the FS in the output of "mount", then there's
something else going on, like files or subvolumes have been deleted,
or you're not mounting the subvol you think you are -- try mounting
with -o subvolid=0 to see the whole FS.

   Hugo.

> Scrub did not help:
> btrfs scrub start /dev/sda
> scrub started on /dev/sda, fsid fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
> (pid=19881)
> 
> btrfs scrub status /dev/sda
> scrub status for fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
> scrub started at Sun Jan 19 12:03:35 2020 and finished after 00:00:00
> total bytes scrubbed: 256.00KiB with 0 errors
> 
> 
> btrfs check /dev/sda
> Checking filesystem on /dev/sda
> UUID: fdce5ae5-fd6d-46b9-8056-3ff15ce9fa16
> checking extents
> checking free space cache
> cache and super generation don't match, space cache will be invalidated
> checking fs roots
> checking csums
> checking root refs
> found 131072 bytes used err is 0
> total csum bytes: 0
> total tree bytes: 131072
> total fs tree bytes: 32768
> total extent tree bytes: 16384
> btree space waste bytes: 123986
> file data blocks allocated: 0
> referenced 0
> 
> 
> Also btrfs restore -i -v /dev/sda /srv/dev-disk-by-label-NewDrive2 | tee
> /restorelog.txt did not help:
> It came immediately back with 'Reached the end of the tree searching the
> directory'
> 
> 
> btrfs-find-root /dev/sda
> Superblock thinks the generation is 8
> Superblock thinks the level is 0
> It did not finish even in 54 hours
> 
> I am out of ideas. Can you give further advice?
> 
> Regards,
> Hendrik
> 

-- 
Hugo Mills             | Prisoner unknown: Return to Zenda.
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
