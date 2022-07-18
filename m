Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B93C578834
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 19:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiGRRSs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiGRRSr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 13:18:47 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E942C64E
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 10:18:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 27F0A3200919;
        Mon, 18 Jul 2022 13:18:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Jul 2022 13:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1658164724; x=1658251124; bh=UwnRPd1hbI
        Jq1IBVJow4Pf0/YyRo4othQRBpwb1+Yo0=; b=OC0Axa0QOk2nz5HItc2p6iMlcx
        ATer9L/IHHvCQ4QSEbYOBlHZTaAd2IvWuuf60CuBspIexvjfPSkau45MMlAEd61q
        kbegCDB/4UxqDZ/odtcuz7+/26rlPbFK2YZmqF35Lw/O6BehVIc6a5MNtUiW+AF+
        tkPC6wsmRTCE2eNzRSmqbuj7QRNpQ9DNcexEB2qgSPfUC5B1mZ8HVW+1LcT107Gc
        B1BdxMgjkPYFvv8cBeicgss3yoaU2atntfJ656B09UJfBLxfmbPjy0PnvKAXQyGa
        UffOpBGjZcsL4EAM2L7OkrAaBA8e+oeDscMKEvoPKCbbnG4DtWEbsDHMrC9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658164724; x=1658251124; bh=UwnRPd1hbIJq1IBVJow4Pf0/YyRo
        4othQRBpwb1+Yo0=; b=Mae+TRl+Qa40lpJa1D8xGbOS2KX2ghn7osN2XWfybcPC
        mmzyaoTxoi2RhbpAwprR0oEto4eI9qEYYn7kRUgBjONX4cdvRri5n7WHxnQtHAe/
        92zE8Uag/+IpqIDnuQGB8An2CgaKUHLkgN/ajYXguW78nFEmgvErCfg16BYewwNG
        WcTlK4MZlHQ/g/Y29Kpo9u6cW7fK8HdNTXdcOuEV8xKLDxkCdmXUnElMsFqwqk5h
        PI4F5dWczc1HD+qMhH5zqOc8NrkF3lLkgpRDylQtKU3KB4PdO5IxzdnLUBlEhg+n
        jXK41OfT4UTEomLWzl+2JEc8AgraMPLqZPlJX2wEVQ==
X-ME-Sender: <xms:9JXVYuatAtLaBdW_ZdhInAvnk2XFcM5YxIbA00gTApjSm4oxFUMzsg>
    <xme:9JXVYhbLXt890-x1qgTGjew7uHB2wzs-TG1p7JZ96JtIRQ56UqTI57NoujLq2SjGW
    2oeanAUvgvOfIv3hwo>
X-ME-Received: <xmr:9JXVYo-Ueom2PzA-JMrIq_kePMTn6vKq4rVTM_4IFCseHrh-PDiQxjM8Px1AxfYCQD72fPV9WgyhX4wvBRFqL_FGml7Ssg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekkedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    ephedthfevgffhtdevgffhlefhgfeuueegtdevudeiheeiheetleeghedvfeegfeegnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:9JXVYgonYeWhlaKsuQNBPYcWx0nqkCps1VMHFPnFFtbOB2iUEMnZzA>
    <xmx:9JXVYppf7Nit75uptR37OIwnOtBYH_CttnJtqQFGQMaEctMBWJPdIA>
    <xmx:9JXVYuSsZ-mEwbyChq6_4sAlDxhy2dT2QFbXgVSwknFHuCV5Roig6Q>
    <xmx:9JXVYoQUCk3F8EUAFwqD-Qcg6gvVjKOgQVeXGzpKuENIuNCpQsWxWw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Jul 2022 13:18:44 -0400 (EDT)
Date:   Mon, 18 Jul 2022 10:18:43 -0700
From:   Boris Burkov <boris@bur.io>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: add support for tabular format for
 device stats
Message-ID: <YtWV8xZ823vCC7qb@zen>
References: <20220718113439.2997247-1-nborisov@suse.com>
 <20220718113439.2997247-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718113439.2997247-2-nborisov@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 18, 2022 at 02:34:39PM +0300, Nikolay Borisov wrote:
> Add support for the -T switch to 'device stats" command such that
> executing 'btrfs device stats -T' produces:
> 
> Id Path     Write errors Read errors Flush errors Corruption errors Generation errors
> -- -------- ------------ ----------- ------------ ----------------- -----------------
>  1 /dev/vdc            0           0            0                 0                 0
>  2 /dev/vdd            0           0            0                 0                 0

Works for me, and the output looks nice. One little weird thing was that
for me, without naming a device it errored out. Maybe I haven't rebased
my kernel recently enough? Works great when I name a device like:
'btrfs device stats -T /dev/foo' # works
but not like this:
'btrfs device stats -T' # error

I find the code flow of sticking in "if tabular" everywhere a little
unpleasant, so I was thinking it might help to try using function
pointers for the print function that you set when you process the
options. Having the little "prepare context" step makes it a little more
annoying since you need two functions. Food for thought, at least.

> 
> Link: https://lore.kernel.org/linux-btrfs/d7bd334d-13ad-8c5c-2122-1afc722fcc9c@dirtcellar.net
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  cmds/device.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 103 insertions(+), 6 deletions(-)
> 
> diff --git a/cmds/device.c b/cmds/device.c
> index feffe9184726..926fbbd64615 100644
> --- a/cmds/device.c
> +++ b/cmds/device.c
> @@ -27,6 +27,7 @@
>  #include "kerncompat.h"
>  #include "kernel-shared/ctree.h"
>  #include "ioctl.h"
> +#include "common/string-table.h"
>  #include "common/utils.h"
>  #include "kernel-shared/volumes.h"
>  #include "kernel-shared/zoned.h"
> @@ -572,6 +573,7 @@ static const char * const cmd_device_stats_usage[] = {
>  	"",
>  	"-c|--check             return non-zero if any stat counter is not zero",
>  	"-z|--reset             show current stats and reset values to zero",
> +	"-T                     show current stats in tabular format",

what do you think about --tabular for the long name?

>  	HELPINFO_INSERT_GLOBALS,
>  	HELPINFO_INSERT_FORMAT,
>  	NULL
> @@ -642,17 +644,75 @@ static int _print_device_stat_string(struct format_ctx *fctx,
>  	return err;
>  }
> 
> +
> +static int _print_device_stat_tabular(struct string_table *table, int row,
> +		struct btrfs_ioctl_get_dev_stats *args, char *path, bool check)
> +{
> +	char *canonical_path = path_canonicalize(path);
> +	int j;
> +	int err = 0;
> +	static const struct {
> +		const char name[32];
> +		enum btrfs_dev_stat_values stat_idx;
> +	} dev_stats[] = {
> +		{ "write_io_errs", BTRFS_DEV_STAT_WRITE_ERRS },
> +		{ "read_io_errs", BTRFS_DEV_STAT_READ_ERRS },
> +		{ "flush_io_errs", BTRFS_DEV_STAT_FLUSH_ERRS },
> +		{ "corruption_errs", BTRFS_DEV_STAT_CORRUPTION_ERRS },
> +		{ "generation_errs", BTRFS_DEV_STAT_GENERATION_ERRS },
> +	};

Can you avoid duplicating this?

> +
> +	/* skip header + --- line */
> +	row += 2;
> +
> +	/* No path when device is missing. */
> +	if (!canonical_path) {
> +		canonical_path = malloc(32);
> +
> +		if (!canonical_path) {
> +			error("not enough memory for path buffer");
> +			return -ENOMEM;
> +		}
> +
> +		snprintf(canonical_path, 32, "devid:%llu", args->devid);
> +	}
> +	table_printf(table, 0, row, ">%llu", args->devid);
> +	table_printf(table, 1, row, ">%s", canonical_path);
> +	free(canonical_path);
> +
> +	for (j = 0; j < ARRAY_SIZE(dev_stats); j++) {
> +		enum btrfs_dev_stat_values stat_idx = dev_stats[j].stat_idx;
> +		/* We got fewer items than we know */
> +		if (args->nr_items < stat_idx + 1)
> +			continue;
> +
> +	table_printf(table, 2, row, ">%llu", args->values[stat_idx]);
> +	table_printf(table, 3, row, ">%llu", args->values[stat_idx]);
> +	table_printf(table, 4, row, ">%llu", args->values[stat_idx]);
> +	table_printf(table, 5, row, ">%llu", args->values[stat_idx]);
> +	table_printf(table, 6, row, ">%llu", args->values[stat_idx]);
> +
> +	if (check && (args->values[stat_idx] > 0))
> +		err |= 64;
> +	}
> +
> +	return err;
> +}
> +
>  static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  {
>  	char *dev_path;
>  	struct btrfs_ioctl_fs_info_args fi_args;
>  	struct btrfs_ioctl_dev_info_args *di_args = NULL;
> +	struct string_table *table = NULL;
>  	int ret;
>  	int fdmnt;
>  	int i;
>  	int err = 0;
>  	bool check = false;
> +	bool free_table = false;
>  	__u64 flags = 0;
> +	bool tabular = false;
>  	DIR *dirstream = NULL;
>  	struct format_ctx fctx;
> 
> @@ -665,7 +725,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  			{NULL, 0, NULL, 0}
>  		};
> 
> -		c = getopt_long(argc, argv, "cz", long_options, NULL);
> +		c = getopt_long(argc, argv, "Tcz", long_options, NULL);
>  		if (c < 0)
>  			break;
> 
> @@ -676,6 +736,9 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  		case 'z':
>  			flags = BTRFS_DEV_STATS_RESET;
>  			break;
> +		case 'T':
> +			tabular = true;
> +			break;
>  		default:
>  			usage_unknown_option(cmd, argv);
>  		}
> @@ -703,11 +766,35 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  		goto out;
>  	}
> 
> -	fmt_start(&fctx, device_stats_rowspec, 24, 0);
> -	fmt_print_start_group(&fctx, "device-stats", JSON_TYPE_ARRAY);
> +	if (tabular) {
> +		/*
> +		 * cols = Id/Path/write/read/flush/corruption/generation
> +		 * rows = num devices + 2 (header and ---- line)
> +		 */
> +		table = table_create(7, fi_args.num_devices + 2);
> +		if (!table) {
> +			error("not enough memory");
> +			goto out;
> +		}
> +		free_table = true;
> +		table_printf(table, 0,0, "<Id");
> +		table_printf(table, 1,0, "<Path");
> +		table_printf(table, 2,0, "<Write errors");
> +		table_printf(table, 3,0, "<Read errors");
> +		table_printf(table, 4,0, "<Flush errors");
> +		table_printf(table, 5,0, "<Corruption errors");
> +		table_printf(table, 6,0, "<Generation errors");
> +		for (i = 0; i < 7; i++)
> +			table_printf(table, i, 1, "*-");
> +	} else {
> +		fmt_start(&fctx, device_stats_rowspec, 24, 0);
> +		fmt_print_start_group(&fctx, "device-stats", JSON_TYPE_ARRAY);
> +	}
> +
>  	for (i = 0; i < fi_args.num_devices; i++) {
>  		struct btrfs_ioctl_get_dev_stats args = {0};
>  		char path[BTRFS_DEVICE_PATH_NAME_MAX + 1];
> +		int err2;
> 
>  		strncpy(path, (char *)di_args[i].path,
>  			BTRFS_DEVICE_PATH_NAME_MAX);
> @@ -724,7 +811,11 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  			goto out;
>  		}
> 
> -		int err2 = _print_device_stat_string(&fctx, &args, path, check);
> +		if (tabular)
> +			err2 = _print_device_stat_tabular(table, i, &args, path, check);
> +		else
> +			err2 = _print_device_stat_string(&fctx, &args, path, check);
> +
>  		if (err2) {
>  			if (err2 < 0) {
>  				err = err2;
> @@ -734,12 +825,18 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  		}
>  	}
> 
> -	fmt_print_end_group(&fctx, "device-stats");
> -	fmt_end(&fctx);
> +	if (tabular) {
> +		table_dump(table);
> +	} else {
> +		fmt_print_end_group(&fctx, "device-stats");
> +		fmt_end(&fctx);
> +	}
> 
>  out:
>  	free(di_args);
>  	close_file_or_dir(fdmnt, dirstream);
> +	if (free_table)
> +		table_free(table);
> 
>  	return err;
>  }
> --
> 2.17.1
> 
