Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F88A5E48C
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2019 14:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGCMw1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 08:52:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:41248 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbfGCMw1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jul 2019 08:52:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7FA47AD4E;
        Wed,  3 Jul 2019 12:52:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0FEB7DA861; Wed,  3 Jul 2019 14:53:10 +0200 (CEST)
Date:   Wed, 3 Jul 2019 14:53:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v7 RESEND Rebased] btrfs-progs: dump-tree: add noscan
 option
Message-ID: <20190703125309.GT20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190626083017.1833-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626083017.1833-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 26, 2019 at 01:30:17AM -0700, Anand Jain wrote:
> From: Anand Jain <Anand.Jain@oracle.com>
> 
> The cli 'btrfs inspect dump-tree <dev>' will scan for the partner devices
> if any by default.
> 
> So as of now you can not inspect each mirrored device independently.
> 
> This patch adds noscan option, which when used won't scan the system for
> the partner devices, instead it just uses the devices provided in the
> argument.
> 
> For example:
>   btrfs inspect dump-tree --noscan <dev> [<dev>..]
> 
> This helps to debug degraded raid1 and raid10.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to devel, with some minor tweaks. Sorry for the delay.

> ---
> v6->v7: rebase on latest btrfs-progs::devel
> v5->v6: rebase on latest btrfs-progs::devel
> v4->v5: nit: use %m to print error string.
> 	changelog update.
> v3->v4: change the patch title.
> 	collapse scan_args() to its only parent cmd_inspect_dump_tree()
> 	(it was bit confusing).
> 	update the change log.
> 	update usage.
> 	update man page.
> v2->v3: make it scalable for more than two disks in noscan mode
> v1->v2: rename --degraded to --noscan
>  Documentation/btrfs-inspect-internal.asciidoc |  5 +-
>  cmds-inspect-dump-tree.c                      | 53 ++++++++++++++-----
>  2 files changed, 45 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/btrfs-inspect-internal.asciidoc b/Documentation/btrfs-inspect-internal.asciidoc
> index 210f18c30a40..c9962ab3b548 100644
> --- a/Documentation/btrfs-inspect-internal.asciidoc
> +++ b/Documentation/btrfs-inspect-internal.asciidoc
> @@ -61,7 +61,7 @@ specify which mirror to print, valid values are 0, 1 and 2 and the superblock
>  must be present on the device with a valid signature, can be used together with
>  '--force'
>  
> -*dump-tree* [options] <device>::
> +*dump-tree* [options] <device> [device...]::
>  (replaces the standalone tool *btrfs-debug-tree*)
>  +
>  Dump tree structures from a given device in textual form, expand keys to human
> @@ -95,6 +95,9 @@ intermixed in the output
>  --bfs::::
>  use breadth-first search to print trees. the nodes are printed before all
>  leaves
> +--device::::

Minor typo, --noscan, fixed.
