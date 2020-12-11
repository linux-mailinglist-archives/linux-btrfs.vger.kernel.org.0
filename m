Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EB12D7CF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 18:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395295AbgLKReD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 12:34:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:45488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392464AbgLKRdl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:33:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E6BCACF1;
        Fri, 11 Dec 2020 17:33:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52E05DA7CF; Fri, 11 Dec 2020 18:31:23 +0100 (CET)
Date:   Fri, 11 Dec 2020 18:31:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH v3 1/2] btrfs-progs: common: extend fmt_print_start_group
 handles unnamed group
Message-ID: <20201211173123.GP6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20201211164812.459012-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211164812.459012-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 11, 2020 at 04:48:11PM +0000, Sidong Yang wrote:
> This patch extends fmt_print_start_group() that it can handle when name
> argument is NULL. It is useful for printing unnamed array or map.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v3:
>  - extend fmt_print_start_group rather than writing new function
> ---
>  common/format-output.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/common/format-output.c b/common/format-output.c
> index 8df93ecb..2f74595c 100644
> --- a/common/format-output.c
> +++ b/common/format-output.c
> @@ -181,17 +181,23 @@ void fmt_end_value(struct format_ctx *fctx, const struct rowspec *row)
>  void fmt_print_start_group(struct format_ctx *fctx, const char *name,
>  		enum json_type jtype)
>  {
> +	char bracket;
>  	if (bconf.output_format == CMD_FORMAT_JSON) {
>  		fmt_separator(fctx);
>  		fmt_inc_depth(fctx);
>  		fctx->jtype[fctx->depth] = jtype;
>  		fctx->memb[fctx->depth] = 0;

This can be simplified a bit, the name can be conditionally printed here

>  		if (jtype == JSON_TYPE_MAP)
> -			printf("\"%s\": {", name);
> +			bracket = '{';

and this just does the right putchar(). With this change now added to
devel, thanks.

>  		else if (jtype == JSON_TYPE_ARRAY)
> -			printf("\"%s\": [", name);
> +			bracket = '[';
>  		else
>  			fmt_error(fctx);
> +
> +		if (name)
> +			printf("\"%s\": %c", name, bracket);
> +		else
> +			putchar(bracket);
