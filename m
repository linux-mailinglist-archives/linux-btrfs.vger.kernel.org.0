Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D811433BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 23:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgATWNH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 17:13:07 -0500
Received: from savella.carfax.org.uk ([85.119.84.138]:35538 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgATWNH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 17:13:07 -0500
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1itfIA-0003Jd-9r; Mon, 20 Jan 2020 22:13:06 +0000
Date:   Mon, 20 Jan 2020 22:13:06 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     kjansen387 <kjansen387@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs raid1 balance slow
Message-ID: <20200120221306.GH26453@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        kjansen387 <kjansen387@gmail.com>, linux-btrfs@vger.kernel.org
References: <6bc329d9-6dc5-a4bc-e7c4-eccd377823eb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bc329d9-6dc5-a4bc-e7c4-eccd377823eb@gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 20, 2020 at 11:08:40PM +0100, kjansen387 wrote:
> I had a btrfs raid1 with 2 4TB SATA 5400RPM disks . Regular disk I/O is
> about 2MB/sec per drive, ~40IOPS, mostly write. I had ~150GB free and added
> one 2 TB disk and started the balance:
> 
> btrfs device add -f /dev/sdb /export
> btrfs filesystem balance /export
> 
> It's now running for 24 hours, 70% remaining:
> 
> # btrfs balance status -v /export
> Balance on '/export' is running
> 1057 out of about 3561 chunks balanced (1058 considered),  70% left
> Dumping filters: flags 0x7, state 0x1, force is off
>   DATA (flags 0x0): balancing
>   METADATA (flags 0x0): balancing
>   SYSTEM (flags 0x0): balancing
> 
> I have searched for similar cases, but, I do not have quotas enabled, I do
> not have compression enabled, and my CPU supports sse4_2 . CPU (i7-8700K) is
> doing fine, 80% idle (average over all threads).

   Do you have lots of snapshots? It can take a lot of time on some of
the metadata chunks if there's lots of shared extents.

> Is this normal ? I have to repeat this process 2 times (adding more 2TB
> disks), any way I can make it faster ?

   Cancel the current balance, add the remaining disks, and then
balance only once you've added them all.

   Hugo.

-- 
Hugo Mills             | If it's December 1941 in Casablanca, what time is it
hugo@... carfax.org.uk | in New York?
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                               Rick Blaine, Casablanca
