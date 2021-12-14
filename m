Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47A5474336
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 14:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhLNNNQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 08:13:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38610 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbhLNNNP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 08:13:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0B0D12114E;
        Tue, 14 Dec 2021 13:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639487594;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jb/qK4n55YrzzvgsRiBa0Acw6Mf2xOKXaf7QIwBgOOY=;
        b=NgvkjPwRYzDqPzySXyoXS5Ggjv0LYvLs6IKyd17oSv8PQBtOXcC6BxHiDkluZ8D/cv459X
        DQo96RQC8jAMIW4n+BpBQtAoEpDU7JeqWDQYrI3JiBzFXwWqx2qfgcyKI8mZgvNr1vZmNd
        JNIhCaoPb+HrBYeEZBgFDX20oV22+d0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639487594;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jb/qK4n55YrzzvgsRiBa0Acw6Mf2xOKXaf7QIwBgOOY=;
        b=Nmb7NUT98hPvZaZ/+/Fa9sNWYgIzblgkFyifW/+S0Xp4gfRVvrvlcXCCmZKKKO+p72mvg1
        TJTl9gc2wewhOPDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 022BDA3B83;
        Tue, 14 Dec 2021 13:13:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0956DA781; Tue, 14 Dec 2021 14:12:55 +0100 (CET)
Date:   Tue, 14 Dec 2021 14:12:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/254: test cleaning up of the stale device
Message-ID: <20211214131255.GT28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <c1c22a67c90f1b0b94ea3f99d6d6fd4a4d5d5473.1638953165.git.anand.jain@oracle.com>
 <YbDGIWHVD4cmdZz0@localhost.localdomain>
 <5864b5a8-7572-1f43-b217-761bb6e4bfce@oracle.com>
 <YbISe4E9/Yr8OGFH@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbISe4E9/Yr8OGFH@localhost.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 09, 2021 at 09:28:11AM -0500, Josef Bacik wrote:
> On Thu, Dec 09, 2021 at 02:41:22PM +0800, Anand Jain wrote:
> > On 08/12/2021 22:50, Josef Bacik wrote:
> > > On Wed, Dec 08, 2021 at 10:07:46PM +0800, Anand Jain wrote:
> Yup, its the following, I was using -s btrfs_normal
> 
> [btrfs_normal]
> TEST_DIR=/mnt/test
> TEST_DEV=/dev/mapper/vg0-lv0
> SCRATCH_DEV_POOL="/dev/mapper/vg0-lv9 /dev/mapper/vg0-lv8 /dev/mapper/vg0-lv7 /dev/mapper/vg0-lv6 /dev/mapper/vg0-lv5 /dev/mapper/vg0-lv4 /dev/mapper/vg0-lv3 /dev/mapper/vg0-lv2 /dev/mapper/vg0-lv1 "
> SCRATCH_MNT=/mnt/scratch
> LOGWRITES_DEV=/dev/mapper/vg0-lv10
> PERF_CONFIGNAME=jbacik
> MKFS_OPTIONS="-K -O ^no-holes -R ^free-space-tree"

Unrelated to the patch, but why do you disable no-holes and
free-space-tree? Is this a special testing setup?
