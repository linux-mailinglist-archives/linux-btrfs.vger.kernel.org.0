Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8439631FBFC
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 16:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhBSPcv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 10:32:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:42978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhBSPcr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 10:32:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 901FBAC6E;
        Fri, 19 Feb 2021 15:32:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 14EF6DA806; Fri, 19 Feb 2021 16:30:07 +0100 (CET)
Date:   Fri, 19 Feb 2021 16:30:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: receive: fix btrfs_mount_root substring bug
Message-ID: <20210219153007.GE1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <8f5cec45ff013e9967f3261676e5ff41d340305e.1605572809.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f5cec45ff013e9967f3261676e5ff41d340305e.1605572809.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 16, 2020 at 04:58:20PM -0800, Boris Burkov wrote:
> The current mount detection code in btrfs receive is not quite perfect.
> For example, suppose /tmp is mounted as a tmpfs. In that case,
> btrfs receive /tmp2 will find /tmp as the longest mount that matches a
> prefix of /tmp2 and blow up because it is not a btrfs filesystem, even
> if /tmp2 is just a directory in / mounted as btrfs.
> 
> Fix this by replacing the substring check with a dirname recursion to
> only check the directories in the path of the dir, rather than every
> substring.
> 
> Add a new test for this case.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Added to devel, thanks.
