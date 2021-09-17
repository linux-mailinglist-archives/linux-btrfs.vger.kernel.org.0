Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB1340FB52
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 17:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245649AbhIQPIe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 11:08:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43288 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239218AbhIQPId (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 11:08:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D92DD1FF1D;
        Fri, 17 Sep 2021 15:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631891229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z7HpYYc1qjs9iBTQ4saZP0AMgdlg/BGZq7jbZSAlSTo=;
        b=F0kObblDzQXlQRKbWG1E0axHat5lgX1CNz9cGBavBhcE2sztQUfsJI9V3lwbQgvEoVj8pR
        OTiixmideWJTxzX0kh/x4cvx7e0il3IZDCgyhhXFe8wjVRe86f1szjkPmpqI0U2Gs6BLOw
        OqFWjuOu1L43M8Vei4HznMgkLhrslkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631891229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z7HpYYc1qjs9iBTQ4saZP0AMgdlg/BGZq7jbZSAlSTo=;
        b=WVWCMV4FjPp8ORrUtExu/MqYzONwgZhiQILGExq724ACiHo9U3WRStR7gWzljUIuBW3Z4W
        TzRLdjIYsatTsjCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D285CA3BA2;
        Fri, 17 Sep 2021 15:07:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AB799DA781; Fri, 17 Sep 2021 17:06:59 +0200 (CEST)
Date:   Fri, 17 Sep 2021 17:06:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/7]
Message-ID: <20210917150658.GV9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1627419595.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 05:01:12PM -0400, Josef Bacik wrote:
> v1->v2:
> - Rework the first patch as it was wrong because we need it for seed devices.
> - Fix another lockdep splat I uncovered while testing against seed devices to
>   make sure I hadn't broken anything.
> 
> --- Original email ---
> 
> Hello,
> 
> The commit 87579e9b7d8d ("loop: use worker per cgroup instead of kworker")
> enabled the use of workqueues for loopback devices, which brought with it
> lockdep annotations for the workqueues for loopback devices.  This uncovered a
> cascade of lockdep warnings because of how we mess with the block_device while
> under the sb writers lock while doing the device removal.
> 
> The first patch seems innocuous but we have a lockdep_assert_held(&uuid_mutex)
> in one of the helpers, which is why I have it first.  The code should never be
> called which is why it is removed, but I'm removing it specifically to remove
> confusion about the role of the uuid_mutex here.
> 
> The next 4 patches are to resolve the lockdep messages as they occur.  There are
> several issues and I address them one at a time until we're no longer getting
> lockdep warnings.
> 
> The final patch doesn't necessarily have to go in right away, it's just a
> cleanup as I noticed we have a lot of duplicated code between the v1 and v2
> device removal handling.  Thanks,
> 
> Josef
> 
> Josef Bacik (7):
>   btrfs: do not call close_fs_devices in btrfs_rm_device
>   btrfs: do not take the uuid_mutex in btrfs_rm_device
>   btrfs: do not read super look for a device path
>   btrfs: update the bdev time directly when closing
>   btrfs: delay blkdev_put until after the device remove
>   btrfs: unify common code for the v1 and v2 versions of device remove
>   btrfs: do not take the device_list_mutex in clone_fs_devices

I've merged what looked ok and did not have comments. Remaining patches
are 1, 3 and 7. Please have a look and resend, thanks.
