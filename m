Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF524484C6F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 03:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbiAECUx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 21:20:53 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:39654 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234474AbiAECUx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jan 2022 21:20:53 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 8054E13ACBF; Tue,  4 Jan 2022 21:20:45 -0500 (EST)
Date:   Tue, 4 Jan 2022 21:20:16 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: "hardware-assisted zeroing"
Message-ID: <YdUAYId7qCY1MCAb@hungrycats.org>
References: <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
 <YdSy09eCHqU5sgez@hungrycats.org>
 <f264615001da2f24ca418fdaa4b4567b7ff4cb22.camel@ericlevy.name>
 <2193547e-d88e-9f53-6777-793b58130afd@gmx.com>
 <SYXPR01MB1918C7BCE283C34FE862387E9E4B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <ca2d0ec03b6ec81add904d44e432ec063777b6e0.camel@ericlevy.name>
 <YdTytv47JUGujVl5@hungrycats.org>
 <18d02df50fc7f9c63ff07b5433a445d911538be6.camel@ericlevy.name>
 <YdT1gEF0zMIN6eQ8@hungrycats.org>
 <9dbeb4327f5e42f0fd45ee4a348bff3f34c6e3f9.camel@ericlevy.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dbeb4327f5e42f0fd45ee4a348bff3f34c6e3f9.camel@ericlevy.name>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 04, 2022 at 08:37:54PM -0500, Eric Levy wrote:
> On Tue, 2022-01-04 at 20:33 -0500, Zygo Blaxell wrote:
> 
> > That's up to the host filesystem implementation.  ZNS devices require
> > filesystems that speak ZNS protocol.  They don't implement a
> > traditional
> > LBA-oriented interface (or if they do, they provide a separate
> > logical
> > device interface for that).
> 
> The entire file system must fit on one device, even the allocation
> data. How would the host find the allocation information, if its
> location has been remapped?

For ZBD devices, a linear read of a superblock log zone can provide the
root pointer for the filesystem.  The rest of the trees arise from that
root.  ZNS filesystems can do something similar.

The location of the data is not entirely unknown.  It is written somewhere
within the zone designated by the filesystem--only the bottom N bits
are filled in by the device.
