Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2C16440B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 13:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBSMSY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 07:18:24 -0500
Received: from bang.steev.me.uk ([81.2.120.65]:57113 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSMSY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 07:18:24 -0500
Received: from localhost ([::1] helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.92.2)
        id 1j4OIy-001vnQ-R1; Wed, 19 Feb 2020 12:18:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Feb 2020 12:18:16 +0000
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     josef@toxicpanda.com, dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 5/5] btrfs: introduce new read_policy device
In-Reply-To: <1582111766-8372-6-git-send-email-anand.jain@oracle.com>
References: <1582111766-8372-1-git-send-email-anand.jain@oracle.com>
 <1582111766-8372-6-git-send-email-anand.jain@oracle.com>
Message-ID: <ca5fe4b1232aadb3aa0d39b3b339dcbe@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-02-19 11:29, Anand Jain wrote:
> A new read policy 'device' is introduced with this patch, which when 
> set
> can pick only the device flagged as read_preferred for reading. This
> tunable is for the advance users and the testers, which can make sure 
> that
> reads are read from the device they prefer for chunks of type raid1,
> raid10, raid1c3 and raid1c4.
> 
> The default read policy is pid which can be changed to device as below.
> 
> $ pwd
> /sys/fs/btrfs/12345678-1234-1234-1234-123456789abc
> 
> $ cat read_policy; echo device > ./read_policy; cat read_policy
> [pid] device
> pid [device]
> 
> One or more devices which are favored for reading should set the flag
> read-preferred. In an example below a typical two disk raid1, devid1 is
> configured as read preferred.
> 
> $ echo 1 > devinfo/1/read_preferred
> $ cat devinfo/1/read_preferred; cat devinfo/2/read_preffered

Typo: should be read_preferred

> 1
> 0
> 
> So now when the file is read, the read IO would prefer device(s) with
> read_preferred flags for reading.
> 
> $ echo 3 > /proc/sys/vm/drop_caches; md5sum /btrfs/YkZI
> 
> Since the devid 1 (sdb) is our read preferred device, the reads are set
> to sdb only.
> $ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
> sdb              50.00     40048.00         0.00      40048          0
> 
> $ echo 0 > ./devinfo/1/read_preferred; echo 1 >
> ./devinfo/2/read_preferred;
> 
> [ 3343.918658] BTRFS info (device sdb): reset read preferred on devid 1
> (1334)
> [ 3343.919876] BTRFS info (device sdb): set read preferred on devid 2
> (1334)
> 
> $ echo 3 > /proc/sys/vm/drop_caches; md5sum /btrfs/YkZI
> 
> Since now we changed the read preferred from devid 1 (sdb) to 2 (sdc),
> now all the read IO goes to sdc.
> 
> $ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
> sdc              49.00     40048.00         0.00      40048          0
> 
> Whenever there isn't any read preferred device(s) or if more than one
> stripe is marked as read preferred device then this read policy shall
> use the stripe 0 for reading.

Should we consider the situation where more than one device is preferred 
(perhaps for a future patch) - e.g. devid1 is HDD, devid2 is SSD, devid3 
is SSD and data is RAID1C3?

Will there be a warning when this fallback to stripe 0 happens? Although 
I imagine that would either always display on mount before 
read_preferred is set or flood dmesg for every read.

Perhaps fallback to the %pid policy to give some form of balancing would 
be a better default?

-- 
Steven Davies
