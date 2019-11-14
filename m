Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD13FCAA0
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 17:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfKNQQx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 11:16:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:51048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfKNQQx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 11:16:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED34BAD0F;
        Thu, 14 Nov 2019 16:16:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AA98EDA774; Thu, 14 Nov 2019 17:16:54 +0100 (CET)
Date:   Thu, 14 Nov 2019 17:16:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v1 08/18] btrfs-progs: filesystem defragment: use global
 verbose option
Message-ID: <20191114161653.GL3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
 <1572849196-21775-9-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572849196-21775-9-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 04, 2019 at 02:33:06PM +0800, Anand Jain wrote:
> Transpire global --verbose option down to the btrfs receive sub-command.
> 
> Suggested-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  cmds/filesystem.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 4f22089abeaa..819b9fd1fcc5 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -844,11 +844,12 @@ static const char * const cmd_filesystem_defrag_usage[] = {
>  	"(e.g., files copied with 'cp --reflink', snapshots) which may cause",
>  	"considerable increase of space usage. See btrfs-filesystem(8) for",
>  	"more information.",
> +	HELPINFO_GLOBAL_OPTIONS_HEADER,
> +	HELPINFO_INSERT_VERBOSE,

Please not that this needs to be put right after the command options,
ie. before the paragraph.
