Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687DB31AACB
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Feb 2021 11:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBMKUQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Feb 2021 05:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhBMKUM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Feb 2021 05:20:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FC6464DEB;
        Sat, 13 Feb 2021 10:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613211572;
        bh=DZYpgIfFOFXJBGvrbEklrWD/iVoTHFJ4vSHqyi4HYLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKKG2vSAf3MbywiQweiAouDBjjvD9EdRdFjr6nIURi1rpMi86FSgI53/DwkLTEN7v
         2tcOQyOQ2S5XDw1HTmV43qLrE3y4zN0Xbi/3Vq9YB30wkPlAoO7sEkJlToFkRvRQ9E
         dHe4+ambgVonnyrUkQWHXEfGRgiXrtk+wlKk8hGY=
Date:   Sat, 13 Feb 2021 11:19:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Rostecki <mrostecki@suse.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH RFC 5/6] btrfs: sysfs: Add directory for read policies
Message-ID: <YCensH6UvkIp7Hnm@kroah.com>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <20210209203041.21493-6-mrostecki@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209203041.21493-6-mrostecki@suse.de>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 09, 2021 at 09:30:39PM +0100, Michal Rostecki wrote:
> From: Michal Rostecki <mrostecki@suse.com>
> 
> Before this change, raid1 read policy could be selected by using the
> /sys/fs/btrfs/[fsid]/read_policy file.
> 
> Change it to /sys/fs/btrfs/[fsid]/read_policies/policy.
> 
> The motivation behing creating the read_policies directory is that the
> next changes and new read policies are going to intruduce settings
> specific to read policies.

No Documentation/ABI/ update for this change?

