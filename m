Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72362D7CF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 18:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392761AbgLKRc7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 12:32:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:45114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395272AbgLKRco (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:32:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ECEAAACF1;
        Fri, 11 Dec 2020 17:32:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D52CFDA7CF; Fri, 11 Dec 2020 18:30:25 +0100 (CET)
Date:   Fri, 11 Dec 2020 18:30:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH v3 2/2] btrfs-progs: device stats: add json output format
Message-ID: <20201211173025.GO6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20201211164812.459012-1-realwakka@gmail.com>
 <20201211164812.459012-2-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211164812.459012-2-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 11, 2020 at 04:48:12PM +0000, Sidong Yang wrote:
> Add supports for json formatting, this patch changes hard coded printing
> code to formatted print with output formatter. Json output would be
> useful for other programs that parse output of the command. but it
> changes the text format.

I did not realize that before, but we can't change the output like that.
That would break fstests.

> Example text format:
> 
> device:                 /dev/vdb
> devid			1
> write_io_errs:          0
> read_io_errs:           0
> flush_io_errs:          0
> corruption_errs:        0
> generation_errs:        0

But at least it's just one more switch that keeps the printf and json
format inside the loop, the rest can stay.

> Example json format:
> 
> {
>   "__header": {
>     "version": "1"
>   },
>   "device-stats": [
>     {
>       "device": "/dev/vdb",
>       "devid": "1",
>       "write_io_errs": "0",
>       "read_io_errs": "0",
>       "flush_io_errs": "0",
>       "corruption_errs": "0",
>       "generation_errs": "0"
>     }
>   ],
     ^

I've verified that the comma is really there, it's not a valid json so
there's a bug in the formatter. To verify that the output is valid you
can use eg. 'jq', simply pipe the output of the commadn there.

  $ ./btrfs --format json dev stats /mnt | jq
  parse error: Expected another key-value pair at line 16, column 1

> }
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v3:
>  - use fmt_print_start_group with NULL name
> ---
>  cmds/device.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/cmds/device.c b/cmds/device.c
> index d72881f8..204e834b 100644
> --- a/cmds/device.c
> +++ b/cmds/device.c
> @@ -36,6 +36,7 @@
>  #include "common/path-utils.h"
>  #include "common/device-utils.h"
>  #include "common/device-scan.h"
> +#include "common/format-output.h"
>  #include "mkfs/common.h"
>  
>  static const char * const device_cmd_group_usage[] = {
> @@ -459,6 +460,17 @@ out:
>  }
>  static DEFINE_SIMPLE_COMMAND(device_ready, "ready");
>  
> +static const struct rowspec device_stats_rowspec[] = {
> +	{ .key = "device", .fmt = "%s", .out_text = "device", .out_json = "device" },
> +	{ .key = "devid", .fmt = "%u", .out_text = "devid", .out_json = "devid" },
> +	{ .key = "write_io_errs", .fmt = "%llu", .out_text = "write_io_errs", .out_json = "write_io_errs" },
> +	{ .key = "read_io_errs", .fmt = "%llu", .out_text = "read_io_errs", .out_json = "read_io_errs" },
> +	{ .key = "flush_io_errs", .fmt = "%llu", .out_text = "flush_io_errs", .out_json = "flush_io_errs" },
> +	{ .key = "corruption_errs", .fmt = "%llu", .out_text = "corruption_errs", .out_json = "corruption_errs" },
> +	{ .key = "generation_errs", .fmt = "%llu", .out_text = "generation_errs", .out_json = "generation_errs" },
> +	ROWSPEC_END
> +};
> +
>  static const char * const cmd_device_stats_usage[] = {
>  	"btrfs device stats [options] <path>|<device>",
>  	"Show device IO error statistics",

The usage help text should also advertise the formats, so this needs the
helpinfo stubs:

--- a/cmds/device.c
+++ b/cmds/device.c
@@ -527,6 +527,8 @@ static const char * const cmd_device_stats_usage[] = {
        "",
        "-c|--check             return non-zero if any stat counter is not zero",
        "-z|--reset             show current stats and reset values to zero",
+       HELPINFO_INSERT_GLOBALS,
+       HELPINFO_INSERT_FORMAT,
        NULL
 };
---

> @@ -482,6 +494,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  	int check = 0;
>  	__u64 flags = 0;
>  	DIR *dirstream = NULL;
> +	struct format_ctx fctx;
>  
>  	optind = 0;
>  	while (1) {
> @@ -530,6 +543,8 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  		goto out;
>  	}
>  
> +	fmt_start(&fctx, device_stats_rowspec, 24, 0);
> +	fmt_print_start_group(&fctx, "device-stats", JSON_TYPE_ARRAY);
>  	for (i = 0; i < fi_args.num_devices; i++) {
>  		struct btrfs_ioctl_get_dev_stats args = {0};
>  		char path[BTRFS_DEVICE_PATH_NAME_MAX + 1];
> @@ -548,6 +563,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  			err |= 1;
>  		} else {
>  			char *canonical_path;
> +			char devid_str[32];
>  			int j;
>  			static const struct {
>  				const char name[32];
> @@ -574,31 +590,36 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  				snprintf(canonical_path, 32,
>  					 "devid:%llu", args.devid);
>  			}
> +			snprintf(devid_str, 32, "%llu", args.devid);
> +			fmt_print_start_group(&fctx, NULL, JSON_TYPE_MAP);
> +			fmt_print(&fctx, "device", canonical_path);
> +			fmt_print(&fctx, "devid", di_args[i].devid);
>  
>  			for (j = 0; j < ARRAY_SIZE(dev_stats); j++) {
>  				/* We got fewer items than we know */
>  				if (args.nr_items < dev_stats[j].num + 1)
>  					continue;
> -				printf("[%s].%-16s %llu\n", canonical_path,
> -					dev_stats[j].name,
> -					(unsigned long long)
> -					 args.values[dev_stats[j].num]);
> +
> +				fmt_print(&fctx, dev_stats[j].name, args.values[dev_stats[j].num]);

So the switch goes here

>  				if ((check == 1)
>  				    && (args.values[dev_stats[j].num] > 0))
>  					err |= 64;
>  			}
> -
> +			fmt_print_end_group(&fctx, NULL);
>  			free(canonical_path);
>  		}
>  	}
>  
> +	fmt_print_end_group(&fctx, "device-stats");
> +	fmt_end(&fctx);
> +
>  out:
>  	free(di_args);
>  	close_file_or_dir(fdmnt, dirstream);
>  
>  	return err;
>  }
> -static DEFINE_SIMPLE_COMMAND(device_stats, "stats");
> +static DEFINE_COMMAND_WITH_FLAGS(device_stats, "stats", CMD_FORMAT_JSON);
>  
>  static const char * const cmd_device_usage_usage[] = {
>  	"btrfs device usage [options] <path> [<path>..]",
> -- 
> 2.25.1
