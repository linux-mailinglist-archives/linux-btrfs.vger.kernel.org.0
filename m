Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A5C1356FB
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 11:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgAIKd6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 05:33:58 -0500
Received: from pme1.philip-seeger.de ([194.59.205.51]:42968 "EHLO
        pme1.philip-seeger.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgAIKd6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 05:33:58 -0500
Received: from webmail.philip-seeger.de (pme1.philip-seeger.de [IPv6:2a03:4000:34:141::100])
        by pme1.philip-seeger.de (Postfix) with ESMTPSA id 9B2C01FC8FC;
        Thu,  9 Jan 2020 11:33:56 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 09 Jan 2020 11:33:54 +0100
From:   Philip Seeger <philip@philip-seeger.de>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Monitoring not working as "dev stats" returns 0 after read error
 occurred
In-Reply-To: <d89fe4da-c498-bb24-8eb5-a19b01680a23@cobb.uk.net>
References: <3283de40c2750cd62d020ed71430cd35@philip-seeger.de>
 <d89fe4da-c498-bb24-8eb5-a19b01680a23@cobb.uk.net>
Message-ID: <ac61f79a3c373f319232640db5db9a5e@philip-seeger.de>
X-Sender: philip@philip-seeger.de
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-01-08 20:35, Graham Cobb wrote:
>> BTRFS info (device sda3): read error corrected: ino 194473 off 2170880
> 
> I am not convinced that that message is telling you that the error
> happened on device sda3. Certainly in some other cases Btrfs error
> messages  identify the **filesystem** using the name of the device the
> kernel thinks is mounted, which might be sda3.

You're right, it looks like I copied the wrong piece, my bad. This btrfs 
filesystem is a mirror with two drives:

# btrfs fi show / | grep devid
	devid    1 size 100.00GiB used 81.03GiB path /dev/sda3
	devid    2 size 100.00GiB used 81.03GiB path /dev/nvme0n1p3

And this is from dmesg:

print_req_error: critical medium error, dev nvme0n1, sector 40910720 
flags 84700
BTRFS info (device sda3): read error corrected: ino 194473 off 2134016 
(dev /dev/nvme0n1p3 sector 36711808)

So it's nvme0n1 that's about to die. But it doesn't matter, dev stats 
prints 0 for all error counts as if nothing had ever happened.

# btrfs dev stats /
[/dev/sda3].write_io_errs    0
[/dev/sda3].read_io_errs     0
[/dev/sda3].flush_io_errs    0
[/dev/sda3].corruption_errs  0
[/dev/sda3].generation_errs  0
[/dev/nvme0n1p3].write_io_errs    0
[/dev/nvme0n1p3].read_io_errs     0
[/dev/nvme0n1p3].flush_io_errs    0
[/dev/nvme0n1p3].corruption_errs  0
[/dev/nvme0n1p3].generation_errs  0

>> # btrfs dev stats / | grep sda3 | grep read
>> [/dev/sda3].read_io_errs 0
> 
> Have you checked the stats for the other devices as well?

Yes, of course. Nevermind that grep. The monitoring cron job checks all 
error counts returned by the stats command and sends out an alert if an 
error is reported (just like with zfs status on zfs filesystems which 
also returns error counts for read/write/cksum errors). But as you can 
see, it didn't send out anything as dev stats says that all error counts 
are at zero.
