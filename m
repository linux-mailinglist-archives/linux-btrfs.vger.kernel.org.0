Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2DC30F1D8
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 12:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbhBDLQW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 06:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbhBDLON (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Feb 2021 06:14:13 -0500
X-Greylist: delayed 1114 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 Feb 2021 03:13:33 PST
Received: from mail.bitfolk.com (mail.bitfolk.com [IPv6:2001:ba8:1f1:f019::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E4CC0613D6
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Feb 2021 03:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com; s=alpha;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=kF8waiFxbtyf+atYBuynw6nkJM0tRtbwVLDSrHUZxCM=;
        b=cFQdW24iuK0g3jNNU8yKYOzSIBwK4zq3iLJRbRe7JPIULQwuQYJGfUxfC7EQDfS9dG1FAnBclG1mia/8EeY4TFGdS7/jeukKY0AFRnEtak7Q/TGc5nz9PBRMaIYmraFnhPmKt5suK4SYA72nE7mr0IYGw6CPkN9WzaK8Q9I43fX0+NdnYQ3Vr7F5MaSC8rnEBTuZOzPTiIWzU+XwY/zcydcjrbI3omS6J5q+diYl+rKdddB5rnVDpI3t3cYnZi4Svl87/JxJI1RrgEl2wEio9ssuLPmma+UpDe4hbL4a5jVDOw2GDv5xtcTQMCJ4G0QsGkNAR2L+qw9Oe4454t7yAQ==;
Received: from andy by mail.bitfolk.com with local (Exim 4.84_2)
        (envelope-from <andy@strugglers.net>)
        id 1l7cHp-0005Na-MJ; Thu, 04 Feb 2021 10:54:57 +0000
Date:   Thu, 4 Feb 2021 10:54:57 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-raid@vger.kernel.org
Subject: Re: put 2 hard drives in mdadm raid 1 and detect bitrot like btrfs
 does, what's that called?
Message-ID: <20210204105457.GI3712@bitfolk.com>
Mail-Followup-To: linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org
References: <f5d8af48e8d5543267089286c01c476f@mail.eclipso.de>
 <a2cd87208a74fb36224539fa10727066@mail.eclipso.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2cd87208a74fb36224539fa10727066@mail.eclipso.de>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL:  http://strugglers.net/wiki/User:Andy
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Cedric,

On Wed, Feb 03, 2021 at 08:33:18PM +0100,   wrote:
> it's called "dm-integrity", as mentioned in this e-mail:
> https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg93037.html

If you do this it would be very interesting to see performance
figures for the following setups:

- btrfs with raid1 meta and data allocation
- mdadm raid1 on raw devices
- mdadm raid1 on dm-integrity (no encryption) on raw devices
- mdadm raid1 on dm-integrity (encryption) on raw devices

just to see what kind of performance loss dm-integrity and
encryption is going to impose.

After doing it, it would find a nice home on the Linux RAID wiki:

    https://raid.wiki.kernel.org/index.php/Dm-integrity

Cheers,
Andy
