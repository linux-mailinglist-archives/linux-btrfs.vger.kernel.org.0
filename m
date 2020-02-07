Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2825155A6A
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 16:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgBGPLz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 10:11:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:59156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgBGPLz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 10:11:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6912CAFA9;
        Fri,  7 Feb 2020 15:11:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 60F23DA790; Fri,  7 Feb 2020 16:11:38 +0100 (CET)
Date:   Fri, 7 Feb 2020 16:11:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/3] btrfs: add a comment describing block-rsvs
Message-ID: <20200207151137.GF2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200204181856.765916-1-josef@toxicpanda.com>
 <20200204181856.765916-2-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204181856.765916-2-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 04, 2020 at 01:18:54PM -0500, Josef Bacik wrote:
> This is a giant comment at the top of block-rsv.c describing generally
> how block rsvs work.  It is purely about the block rsv's themselves, and
> nothing to do with how the actual reservation system works.

> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-rsv.c | 91 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index d07bd41a7c1e..c3843a0001cb 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -6,6 +6,97 @@
>  #include "space-info.h"
>  #include "transaction.h"
>  
> +/*
> + * HOW DO BLOCK RSVS WORK

For documentation please try to avoid abbreviations unless they're at
least somehow explained or can be infered from the previous.

RSVS = RESERVES
