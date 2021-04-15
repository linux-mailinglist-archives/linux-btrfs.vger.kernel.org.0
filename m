Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5FA3613B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 22:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbhDOUr5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 16:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhDOUrx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 16:47:53 -0400
X-Greylist: delayed 2631 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Apr 2021 13:47:30 PDT
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56821C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 13:47:30 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1lX8DA-0004TA-3I; Thu, 15 Apr 2021 21:03:36 +0100
Date:   Thu, 15 Apr 2021 21:03:36 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Charles Zeitler <cfzeitler@gmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: moving disks to new case
Message-ID: <20210415200336.GA28465@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Charles Zeitler <cfzeitler@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CAB9fVVG=8qLX2g=p04Oc0dPqr4EgOf_a3oSHFgCDc_jHgeTtHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB9fVVG=8qLX2g=p04Oc0dPqr4EgOf_a3oSHFgCDc_jHgeTtHQ@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 15, 2021 at 02:36:37PM -0500, Charles Zeitler wrote:
> disks are raid5, i don't know which are /dev/sdb /dev/sdc etc.
> is this going to be an issue?

   Nope.

   Hugo.










   Oh, all right, I'll explain...

   The superblock on each device contains the UUID of the filesystem
and a device ID (you can see both of these in the output of btrfs fi
show). When btrfs dev scan is run (for example, by udev as it
enumerates the devices), it attempts to read the superblock on each
device. Any superblocks that are found are read, and the UUID and
devid of that device node are passed to the kernel. The kernel holds a
lookup table of information for every device known of every
filesystem, and uses that table to work out which device nodes it
needs to use for any given FS.

   Hugo.

-- 
Hugo Mills             | Guards! Help! We're being rescued!
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                       The Stainless Steel Rat Forever
