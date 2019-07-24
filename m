Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF9D472D55
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 13:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfGXLWO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 07:22:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:38044 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbfGXLWO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 07:22:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63822AE89;
        Wed, 24 Jul 2019 11:22:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A2042DA808; Wed, 24 Jul 2019 13:22:50 +0200 (CEST)
Date:   Wed, 24 Jul 2019 13:22:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/4] btrfs-progs: receive: remove commented out
 transid checks
Message-ID: <20190724112250.GK2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1563822638.git.osandov@fb.com>
 <3035988eb320d8582006bbbfa0e872c0c4532889.1563822638.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3035988eb320d8582006bbbfa0e872c0c4532889.1563822638.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 22, 2019 at 12:15:02PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The checks for a subvolume being modified after it was received have
> been commented out since they were added back in commit f1c24cd80dfd
> ("Btrfs-progs: add btrfs send/receive commands"). Let's just get rid of
> the noise.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  cmds/receive.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
> 
> diff --git a/cmds/receive.c b/cmds/receive.c
> index b97850a7..830ed082 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -344,15 +344,6 @@ static int process_snapshot(const char *path, const u8 *uuid, u64 ctransid,
>  			parent_subvol->path[sub_len - root_len - 1] = '\0';
>  		}
>  	}
> -	/*if (rs_args.ctransid > rs_args.rtransid) {

This looks like a (missing) sanity check, don't we want it?
