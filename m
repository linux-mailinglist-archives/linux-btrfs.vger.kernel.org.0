Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C173B484C11
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 02:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiAEBV7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 4 Jan 2022 20:21:59 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:34472 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234412AbiAEBV7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jan 2022 20:21:59 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 6567B13AA8C; Tue,  4 Jan 2022 20:21:58 -0500 (EST)
Date:   Tue, 4 Jan 2022 20:21:58 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: "hardware-assisted zeroing"
Message-ID: <YdTytv47JUGujVl5@hungrycats.org>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
 <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
 <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
 <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
 <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
 <YdSy09eCHqU5sgez@hungrycats.org>
 <f264615001da2f24ca418fdaa4b4567b7ff4cb22.camel@ericlevy.name>
 <2193547e-d88e-9f53-6777-793b58130afd@gmx.com>
 <SYXPR01MB1918C7BCE283C34FE862387E9E4B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <ca2d0ec03b6ec81add904d44e432ec063777b6e0.camel@ericlevy.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <ca2d0ec03b6ec81add904d44e432ec063777b6e0.camel@ericlevy.name>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 04, 2022 at 07:44:21PM -0500, Eric Levy wrote:
> On Wed, 2022-01-05 at 00:38 +0000, Paul Jones wrote:
> 
> > It's also needed to keep throughput high on near full drives, as
> > flash can't write at anywhere near the rated speed of the drive. If
> > there is not enough free blocks to dump incoming data then the drive
> > needs to stop and wait for in-progress data to finish writing/erasing
> > before processing the next command.
> 
> Isn't the address of a free block, for writing new data, resolved by
> the file system, based on the allocation data it maintains, not by the
> hardware?

No SSD works this way.

You say "hardware", but a SSD is an embedded computer running a minimalist
filesystem in its firmware (only one file, the nominal size of the
entire drive).  SSDs can't directly map LBA addresses to physical media,
so they need to implement data placement algorithms that have noticeable
side-effects on performance.

ZNS SSD devices do address mapping entirely in reverse--in a write
command, the host says "append this block to zone Z", the drive chooses
a block address for the data within that zone, and sends the written
block address back to the host filesystem as part of the command reply.
This allows the drive to implement writes in parallel (so they are
subject to reordering) without having to store where it put user data
in the SSD's own memory.
