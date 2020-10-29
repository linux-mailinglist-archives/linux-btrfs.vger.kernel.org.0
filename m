Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3061129F44F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 19:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJ2SzL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 14:55:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:59476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgJ2SzL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 14:55:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2AF2ACD9;
        Thu, 29 Oct 2020 18:55:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 93833DA7CE; Thu, 29 Oct 2020 19:53:31 +0100 (CET)
Date:   Thu, 29 Oct 2020 19:53:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 2/3] btrfs: create read policy framework
Message-ID: <20201029185331.GS6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <cover.1603884513.git.anand.jain@oracle.com>
 <6cf180d094035e0d9cd6544f60b80d79957a17d9.1603884513.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cf180d094035e0d9cd6544f60b80d79957a17d9.1603884513.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 28, 2020 at 09:14:46PM +0800, Anand Jain wrote:
> @@ -5485,7 +5486,19 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>  	else
>  		num_stripes = map->num_stripes;
>  
> -	preferred_mirror = first + current->pid % num_stripes;
> +	switch (fs_info->fs_devices->read_policy) {
> +	default:
> +		/*
> +		 * Shouldn't happen, just warn and use pid instead of failing.
> +		 */
> +		btrfs_warn_rl(fs_info,
> +			      "unknown read_policy type %u, fallback to pid",
> +			      fs_info->fs_devices->read_policy);

So this would flood the system log with useless messages once this
happens. We should really reset it to pid or whatever default we choose.
Fixed.

> +		fallthrough;
> +	case BTRFS_READ_POLICY_PID:
> +		preferred_mirror = first + current->pid % num_stripes;

This is in the original code, but this should really use ( ) to make the
precedence clear.
