Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76652D68B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 21:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403988AbgLJUbF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 15:31:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:39880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729218AbgLJUbE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 15:31:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BFC5EAD45;
        Thu, 10 Dec 2020 20:30:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 24E18DA842; Thu, 10 Dec 2020 21:28:47 +0100 (CET)
Date:   Thu, 10 Dec 2020 21:28:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs-progs: common: introduce
 fmt_print_start_object
Message-ID: <20201210202846.GI6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20201111163909.3968-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111163909.3968-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 11, 2020 at 04:39:08PM +0000, Sidong Yang wrote:
> Introduce a new function that can be used when you need to print an json
> object in command like "device stats".
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  common/format-output.c | 20 ++++++++++++++++++++
>  common/format-output.h |  3 +++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/common/format-output.c b/common/format-output.c
> index 8df93ecb..f31e7259 100644
> --- a/common/format-output.c
> +++ b/common/format-output.c
> @@ -213,6 +213,26 @@ void fmt_print_end_group(struct format_ctx *fctx, const char *name)
>  	}
>  }
>  
> +void fmt_print_start_object(struct format_ctx *fctx)
> +{
> +	if (bconf.output_format == CMD_FORMAT_JSON) {
> +		fmt_separator(fctx);
> +		fmt_inc_depth(fctx);
> +		fctx->memb[fctx->depth] = 0;
> +		putchar('{');
> +	}
> +}

This duplicates what fmt_print_start_group and fmt_print_end_group do,
so these should be extended to handle when 'name' is NULL and print only
the [ or {.
