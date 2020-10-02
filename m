Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEF72817C4
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 18:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbgJBQWf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 12:22:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:46320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388076AbgJBQWc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Oct 2020 12:22:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC472AC54;
        Fri,  2 Oct 2020 16:22:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35CE9DA781; Fri,  2 Oct 2020 18:21:10 +0200 (CEST)
Date:   Fri, 2 Oct 2020 18:21:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Support json format in device stats
Message-ID: <20201002162110.GX6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20200917072948.3354-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917072948.3354-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 17, 2020 at 07:29:47AM +0000, Sidong Yang wrote:
> This patch supports the feature that printing device stats in json
> format. So textcollector like prometheus can parse the output easier.
> This patch implements option for json format and print in json when
> the option enabled.

Thanks, but this got a few things wrong.

> This patch implements enhancement for this issue.
> https://github.com/kdave/btrfs-progs/issues/291
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  cmds/device.c | 46 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/cmds/device.c b/cmds/device.c
> index d72881f8..3e4bf837 100644
> --- a/cmds/device.c
> +++ b/cmds/device.c
> @@ -467,6 +467,7 @@ static const char * const cmd_device_stats_usage[] = {
>  	"",
>  	"-c|--check             return non-zero if any stat counter is not zero",
>  	"-z|--reset             show current stats and reset values to zero",
> +	"-j|--json              show stats in json format",

The output format is a global option like:

    $ btrfs --format=json device stats ...

>  	NULL
>  };
>  
> @@ -482,6 +483,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  	int check = 0;
>  	__u64 flags = 0;
>  	DIR *dirstream = NULL;
> +	bool json = 0;
>  
>  	optind = 0;
>  	while (1) {
> @@ -489,6 +491,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  		static const struct option long_options[] = {
>  			{"check", no_argument, NULL, 'c'},
>  			{"reset", no_argument, NULL, 'z'},
> +			{"json", no_argument, NULL, 'j'},
>  			{NULL, 0, NULL, 0}
>  		};
>  
> @@ -503,6 +506,9 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  		case 'z':
>  			flags = BTRFS_DEV_STATS_RESET;
>  			break;
> +		case 'j':
> +			json = 1;
> +			break;
>  		default:
>  			usage_unknown_option(cmd, argv);
>  		}
> @@ -574,18 +580,34 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  				snprintf(canonical_path, 32,
>  					 "devid:%llu", args.devid);
>  			}
> -
> -			for (j = 0; j < ARRAY_SIZE(dev_stats); j++) {
> -				/* We got fewer items than we know */
> -				if (args.nr_items < dev_stats[j].num + 1)
> -					continue;
> -				printf("[%s].%-16s %llu\n", canonical_path,
> -					dev_stats[j].name,
> -					(unsigned long long)
> -					 args.values[dev_stats[j].num]);
> -				if ((check == 1)
> -				    && (args.values[dev_stats[j].num] > 0))
> -					err |= 64;
> +			if (json) {

Two separate implementations that dump the data, so both would have to
be kept in sync, which is error prone.

I've implemented data dumper that automatically picks the right format
based on the --format option from a specification.

Last time the json output was discussed, there was not a consensus how
exactly it should look like. There's a preview for subvolume command
(https://github.com/kdave/btrfs-progs/tree/preview-json), you can see
how it's supposed to be used.

Given the output is not finazlied, the json output is still a bit of
research how other tools eg. from util-linux do it and also to have some
sample use cases, eg. examples with 'jq' extracting the data. The hard
part here is to specify a reasonable format that won't have to be
changed in the future.
