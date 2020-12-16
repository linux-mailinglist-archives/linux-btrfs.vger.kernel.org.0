Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710EF2DBFB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 12:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgLPLrF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 16 Dec 2020 06:47:05 -0500
Received: from mx2.uni-regensburg.de ([194.94.157.147]:57192 "EHLO
        mx2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLPLrF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 06:47:05 -0500
Received: from mx2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 0731E6000057
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 12:46:20 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx2.uni-regensburg.de (Postfix) with ESMTP id B8EDA600004D
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 12:46:19 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Wed, 16 Dec 2020 12:46:19 +0100
Message-Id: <5FD9F389020000A10003D906@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.0 
Date:   Wed, 16 Dec 2020 12:46:17 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <ce3g8jdj@umail.furryterror.org>
Cc:     <linux-btrfs@vger.kernel.org>
Subject: Antw: [EXT] Re: Unrecoverable filesystem (ERROR: child eb
 corrupted: parent bytenr=1106952192 item=75 parent level=1 child
 level=1)
References: <5FD3816B020000A10003D798@gwsmtp.uni-regensburg.de>
 <20201215181828.GN31381@hungrycats.org>
In-Reply-To: <20201215181828.GN31381@hungrycats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>>> Zygo Blaxell <ce3g8jdj@umail.furryterror.org> schrieb am 15.12.2020 um 19:18 in
Nachricht <20201215181828.GN31381@hungrycats.org>:
> On Fri, Dec 11, 2020 at 03:25:47PM +0100, Ulrich Windl wrote:
>> Hi!
>> 
>> While configuring a VM environment in a cluster I had setup an SLES15 SP2 
> test VM using BtrFS. Due to some problem with libvirt (or the VirtualDomain 
> RA) the VM was active on more than one cluster node at a time, corrupting the 
> filesystem beyond repair it seems:

[...]

> There are at least 3 different ways libvirt or other hosting
> infrastructure software on the VM host could have avoided passing the
> same physical device to multiple VM guests.  I would suggest implementing
> some or all of them.

As I found out the problem is with (live) migration and pacemaker: Migration fails for some reason still to find out, and pacemaker starts the VM on the destination node while it's still active on the source node. Amusingly it complains to "recover" from a VM running on two nodes when in fact it creates the problem by doing so ("restart" the VM on the destination node where none is running). Just for explanation...
[...]

Regards,
Ulrich


