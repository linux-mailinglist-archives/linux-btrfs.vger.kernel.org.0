Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56272C5BD4
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 19:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403903AbgKZSRx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 13:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391720AbgKZSRx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 13:17:53 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C7CC0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Nov 2020 10:17:52 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1kiLqJ-0000s4-PU; Thu, 26 Nov 2020 18:18:07 +0000
Date:   Thu, 26 Nov 2020 18:18:07 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Steve Keller <keller.steve@gmx.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: State of BTRFS
Message-ID: <20201126181807.GC1908@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Steve Keller <keller.steve@gmx.de>, linux-btrfs@vger.kernel.org
References: <trinity-ca02807b-66c1-46e7-a4ed-efa79636413b-1606411979151@3c-app-gmx-bs37>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-ca02807b-66c1-46e7-a4ed-efa79636413b-1606411979151@3c-app-gmx-bs37>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 26, 2020 at 06:32:59PM +0100, Steve Keller wrote:
> What is the state of btrfs concerning stability and reliability?
> 
> Is it safe to my /home file system on btrfs?  I need no RAID,
> currently, as I have mdraid with LVM on top of that already, and I
> have an LVM volume for /home.  But I do like snapshots and would
> probably use them quite a lot.
> 
> Currently, I have ext4 for /home but I consider switching to btrfs.
> But I want to be really sure not to loose data or otherwise have
> to repair the file system.

   In general, it's in pretty good shape. Avoid parity RAID
(especially for metadata), and qgroups. Other than that, the FS itself
should be good.

   The main concern these days is broken hardware: Disks that have
poor cache behaviour in the face of power failure, or that simply lie
about stuff having reached permanent storage, or have other serious
firmware bugs. These can lead to the (generally unrecoverable) transid
error state (see the FAQ [1] for a detailed explanation).

   Hugo.

[1] https://btrfs.wiki.kernel.org/index.php/FAQ#What_does_.22parent_transid_verify_failed.22_mean.3F

-- 
Hugo Mills             | Do not meddle in the affairs of system
hugo@... carfax.org.uk | administrators, for they are subtle, and quick to
http://carfax.org.uk/  | anger.
PGP: E2AB1DE4          |
