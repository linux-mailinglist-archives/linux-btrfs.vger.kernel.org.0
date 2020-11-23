Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D472C1133
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Nov 2020 18:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgKWQ6y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Nov 2020 11:58:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:59000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729482AbgKWQ6y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Nov 2020 11:58:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5A9AAC82;
        Mon, 23 Nov 2020 16:58:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7EFDADA818; Mon, 23 Nov 2020 17:57:04 +0100 (CET)
Date:   Mon, 23 Nov 2020 17:57:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 01/12] btrfs: lift rw mount setup from mount and
 remount
Message-ID: <20201123165704.GG8669@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1605736355.git.boris@bur.io>
 <ac259f3ceafae5a8bb9b6c554375588705aa55b2.1605736355.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac259f3ceafae5a8bb9b6c554375588705aa55b2.1605736355.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 18, 2020 at 03:06:16PM -0800, Boris Burkov wrote:
> +/*
> + * Mounting logic specific to read-write file systems. Shared by open_ctree
> + * and btrfs_remount when remounting from read-only to read-write.
> + */
> +int btrfs_mount_rw(struct btrfs_fs_info *fs_info)

The function could be named better, to reflect that it's starting some
operations prior to the rw mount. As its now it would read as "mount the
filesystem as read-write", we already have 'btrfs_mount' as callback for
mount.

As this is a cosmetic fix it's not blocking the patchset but I'd like to
have that fixed for the final version. I don't have a suggestion for
now.
