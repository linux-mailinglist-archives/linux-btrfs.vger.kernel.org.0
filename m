Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8509B27D1FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgI2O4t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 10:56:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:35826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbgI2O4t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 10:56:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6BD2FB23D;
        Tue, 29 Sep 2020 14:56:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45640DA701; Tue, 29 Sep 2020 16:55:28 +0200 (CEST)
Date:   Tue, 29 Sep 2020 16:55:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2 5/5] btrfs: introduce rescue=all
Message-ID: <20200929145527.GG6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
References: <cover.1601318001.git.josef@toxicpanda.com>
 <b3975f6ad0362885ffd7ff8ff53e7861a316515a.1601318001.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3975f6ad0362885ffd7ff8ff53e7861a316515a.1601318001.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 28, 2020 at 02:34:57PM -0400, Josef Bacik wrote:
> Now that we have the building blocks for some better recovery options
> with corrupted file systems, add a rescue=all option to enable all of
> the relevant rescue options.  This will allow distro's to simply default
> to rescue=all for the "oh dear lord the world's on fire" recovery
> without needing to know all the different options that we have and may
> add in the future.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 2282f0240c1d..3412763a9a0d 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -362,6 +362,7 @@ enum {
>  	Opt_nologreplay,
>  	Opt_ignorebadroots,
>  	Opt_ignoredatacsums,
> +	Opt_all,
>  
>  	/* Deprecated options */
>  	Opt_recovery,
> @@ -459,6 +460,7 @@ static const match_table_t rescue_tokens = {
>  	{Opt_nologreplay, "nologreplay"},
>  	{Opt_ignorebadroots, "ignorebadroots"},
>  	{Opt_ignoredatacsums, "ignoredatacsums"},
> +	{Opt_all, "all"},
>  	{Opt_err, NULL},
>  };
>  
> @@ -510,6 +512,12 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
>  			btrfs_set_and_info(info, IGNOREDATACSUMS,
>  					   "ignoring data csums");
>  			break;
> +		case Opt_all:
> +			btrfs_set_opt(info->mount_opt, IGNOREDATACSUMS);
> +			btrfs_set_opt(info->mount_opt, IGNOREBADROOTS);
> +			btrfs_set_opt(info->mount_opt, NOLOGREPLAY);
> +			btrfs_info(info, "enabling all of the rescue options");

As we're going to add more options in the future, this shoud be more
specific which ones are being enabled under 'all'.

	btrfs_info(info, "enabling all default rescue options:");
	btrfs_set_opt_and_info(info->mount_opt, IGNOREDATACSUMS, "descripton...");
	btrfs_set_opt(info->mount_opt, IGNOREBADROOTS);
	btrfs_set_opt(info->mount_opt, NOLOGREPLAY);

Also in sysfs/features we should export all supported rescue options and
which are enabled by all. That's just for user convenience so we don't
have to publish version + supported options separately.

> +			break;
>  		case Opt_err:
>  			btrfs_info(info, "unrecognized rescue option '%s'", p);
>  			ret = -EINVAL;
> -- 
> 2.26.2
