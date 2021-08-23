Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC163F4CF7
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhHWPD1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 11:03:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52456 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhHWPDL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 11:03:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5B15121FD3;
        Mon, 23 Aug 2021 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730947;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LEuL7qT/kqvHPaqPBBlsNB7vy63lFLKh+ZjcFOC5BFI=;
        b=IdLjY7wIhIR6Yr7Ou3D8hlH3tUIwjEcgaFlfAL99H634CDenNL25jeO79ZbXG1EzRio8P8
        I31bSCxt4WbLCFJhbRCjvv5U342KUVLzxH5lNU8cRp7FxvTMX+5ZT7NRsYGBtyqt89V0g8
        W7HKXrfbUhN0eJgCDodA+nQvZlYmRJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730947;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LEuL7qT/kqvHPaqPBBlsNB7vy63lFLKh+ZjcFOC5BFI=;
        b=WEekTEKkbVKQgkzz9saT9SF00zFm8clyr6fd+78IC9L+h6cX8PPMfG6kZUjU9p4dFLjQey
        g/tNzhX7SLk5vgBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 54DFFA3BBB;
        Mon, 23 Aug 2021 15:02:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B6F5EDA725; Mon, 23 Aug 2021 16:59:27 +0200 (CEST)
Date:   Mon, 23 Aug 2021 16:59:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 07/12] btrfs-progs: add the ability to corrupt fields
 of the super block
Message-ID: <20210823145927.GC5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1629322156.git.josef@toxicpanda.com>
 <7c5a5c52f3cf9ba6b0188b5509e39de93f6bb662.1629322156.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c5a5c52f3cf9ba6b0188b5509e39de93f6bb662.1629322156.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 05:33:19PM -0400, Josef Bacik wrote:
> Doing the extent tree v2 work I generated an invalid super block with
> the wrong bytes_used set, and only noticed because it affected the block
> groups as well.  Neither modes of fsck check for a valid bytes_used, so
> add the ability to corrupt this field so I can generate a testcase for
> fsck.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  btrfs-corrupt-block.c | 66 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
> index 80622f29..7e576897 100644
> --- a/btrfs-corrupt-block.c
> +++ b/btrfs-corrupt-block.c
> @@ -355,6 +355,24 @@ enum btrfs_block_group_field {
>  	BTRFS_BLOCK_GROUP_ITEM_BAD,
>  };
>  
> +enum btrfs_super_field {
> +	BTRFS_SUPER_FIELD_FLAGS,
> +	BTRFS_SUPER_FIELD_TOTAL_BYTES,
> +	BTRFS_SUPER_FIELD_BYTES_USED,
> +	BTRFS_SUPER_FIELD_BAD,
> +};
> +
> +static enum btrfs_super_field convert_super_field(char *field)
> +{
> +	if (!strncmp(field, "flags", FIELD_BUF_LEN))
> +		return BTRFS_SUPER_FIELD_FLAGS;
> +	if (!strncmp(field, "total_bytes", FIELD_BUF_LEN))
> +		return BTRFS_SUPER_FIELD_TOTAL_BYTES;
> +	if (!strncmp(field, "bytes_used", FIELD_BUF_LEN))
> +		return BTRFS_SUPER_FIELD_BYTES_USED;
> +	return BTRFS_SUPER_FIELD_BAD;

There's a more feature-complete utility to modify super block fields
btrfs-sb-mod, this would be duplicated in corrupt-block.
