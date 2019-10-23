Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBE5E1E0A
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 16:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392167AbfJWOYv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 10:24:51 -0400
Received: from mail.itouring.de ([188.40.134.68]:42078 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfJWOYv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 10:24:51 -0400
Received: from tux.wizards.de (pD9EBF359.dip0.t-ipconnect.de [217.235.243.89])
        by mail.itouring.de (Postfix) with ESMTPSA id E83B7416CB7B;
        Wed, 23 Oct 2019 16:24:49 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id A5310F0160C;
        Wed, 23 Oct 2019 16:24:49 +0200 (CEST)
Subject: Re: Curious problem: btrfs device stats & unpriviliged access
To:     Hans van Kranenburg <Hans.van.Kranenburg@mendix.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <05c64256-71d3-81dc-3189-628e8cc0a5db@applied-asynchrony.com>
 <5eafba35-c79b-17f2-e296-aafddf06ebf1@mendix.com>
 <7bcc7f99-a857-6ef1-d2df-a256424d2b29@applied-asynchrony.com>
 <650dd0a2-f945-163d-d44b-db0f1cf21ac1@mendix.com>
 <c13f4c95-ab2e-911d-6476-7f93f9c1e2c9@applied-asynchrony.com>
 <faab0e97-c853-11dd-243d-021232b0783a@mendix.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <85bc00c7-a5b9-ffa7-3d68-97db8f199cf4@applied-asynchrony.com>
Date:   Wed, 23 Oct 2019 16:24:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <faab0e97-c853-11dd-243d-021232b0783a@mendix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's been a while.. :D

On 10/8/18 10:02 PM, Hans van Kranenburg wrote:
> On 10/08/2018 06:37 PM, Holger Hoffstätte wrote:
>> On 10/08/18 17:46, Hans van Kranenburg wrote:
>> <snip>
>>> fs.devices() also looks for dev_items in the chunk tree:
>>>
>>> https://github.com/knorrie/python-btrfs/blob/master/btrfs/ctree.py#L481
>>>
>>> So, BOOM! you need root.
>>>
>>> Or just start a 0, ignore errors and start trying all devids until you
>>> found num_devices amount of them that work, yolo.
>>
>> Since I need to walk /sys/fs/btrfs/ anyway I *think* I can just look
>> at the entries in /sys/fs/btrfs/<fsid>/devices/ and query them all
>> directly.
> 
> But, you still need root for that right? The progs code does a RO open
> directly on the block device.
> 
> -$ btrfs dev stats /dev/xvdb
> ERROR: cannot open /dev/xvdb: Permission denied
> ERROR: '/dev/xvdb' is not a mounted btrfs device
> 
> stat("/dev/loop0", {st_mode=S_IFBLK|0660, st_rdev=makedev(7, 0), ...}) = 0
> stat("/dev/loop0", {st_mode=S_IFBLK|0660, st_rdev=makedev(7, 0), ...}) = 0
> open("/dev/loop0", O_RDONLY)            = -1 EACCES (Permission denied)
> 
> But:
> 
> -# btrfs dev stats /dev/xvdb
> [/dev/xvdb].write_io_errs    0
> [/dev/xvdb].read_io_errs     0
> [/dev/xvdb].flush_io_errs    0
> [/dev/xvdb].corruption_errs  0
> [/dev/xvdb].generation_errs  0

As it turns out you don't need full root, you need permissions to read the device.
Which permissions are those, you ask?

holger>ll /dev/loop0
brw-rw---- 1 root disk 7, 0 Oct 23 02:10 /dev/loop0

Indeed directly reading the device started working when I added myself to the
"disk" group (I was in wheel before, but that wasn't sufficient - good!). \o/
Never go full root. Adding the daemon to a group (e.g. during installation)
is IMHO acceptable.

This particular rabbit hole goes deep since it involves systemd, udev,
session management and eventually alcohol; see:
https://wiki.archlinux.org/index.php/Users_and_groups#Group_list and
https://enotty.pipebreaker.pl/2012/05/23/linux-automatic-user-acl-management/
for things you never really wanted to know. In my case I can get away with
the disk group menbership since I'm on Gentoo with OpenRC.

I still have to figure out the devid(s) for the ioctl, but the above
mentioned Yolo Method™ of iterating after finding the number of devices
in sysfs (under <fs-uuid>/devices/) might just be good enough; we'll see.

-h
