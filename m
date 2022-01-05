Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39382484C20
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 02:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiAEBdy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 20:33:54 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:35458 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234314AbiAEBdx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jan 2022 20:33:53 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 8068013AB17; Tue,  4 Jan 2022 20:33:52 -0500 (EST)
Date:   Tue, 4 Jan 2022 20:33:52 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: "hardware-assisted zeroing"
Message-ID: <YdT1gEF0zMIN6eQ8@hungrycats.org>
References: <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
 <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
 <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
 <YdSy09eCHqU5sgez@hungrycats.org>
 <f264615001da2f24ca418fdaa4b4567b7ff4cb22.camel@ericlevy.name>
 <2193547e-d88e-9f53-6777-793b58130afd@gmx.com>
 <SYXPR01MB1918C7BCE283C34FE862387E9E4B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <ca2d0ec03b6ec81add904d44e432ec063777b6e0.camel@ericlevy.name>
 <YdTytv47JUGujVl5@hungrycats.org>
 <18d02df50fc7f9c63ff07b5433a445d911538be6.camel@ericlevy.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18d02df50fc7f9c63ff07b5433a445d911538be6.camel@ericlevy.name>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 04, 2022 at 08:26:41PM -0500, Eric Levy wrote:
> On Tue, 2022-01-04 at 20:21 -0500, Zygo Blaxell wrote:
> 
> > ZNS SSD devices do address mapping entirely in reverse--in a write
> > command, the host says "append this block to zone Z", the drive
> > chooses
> > a block address for the data within that zone, and sends the written
> > block address back to the host filesystem as part of the command
> > reply.
> > This allows the drive to implement writes in parallel (so they are
> > subject to reordering) without having to store where it put user data
> > in the SSD's own memory.
> 
> How does the host remember the mapping, and where does it get applied
> during followup access?

That's up to the host filesystem implementation.  ZNS devices require
filesystems that speak ZNS protocol.  They don't implement a traditional
LBA-oriented interface (or if they do, they provide a separate logical
device interface for that).
