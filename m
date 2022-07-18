Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D9C5787FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 18:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbiGRQ6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 12:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiGRQ6n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 12:58:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340A72C12F
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 09:58:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D593334060;
        Mon, 18 Jul 2022 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658163518;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NfAcOhf+0B2+YlgomO7Kv2HrecoXw3Dk9eK1f9E765s=;
        b=q+XPCSjOK88BiwbrKvgrrnnp3+fE1gCXlkRAOIiQmyPxOKuvNFalNZ3t6WoYFRZPClIj5g
        unAgDOwcILCxK3PAtXaOxp7K4idhqNgdA1KSt0lqjf1ibj00y3JqmgMNdkmLMGwkV955k2
        PyAeM2RdIMknLBfdxE/rEbQo8AF5dC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658163518;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NfAcOhf+0B2+YlgomO7Kv2HrecoXw3Dk9eK1f9E765s=;
        b=S5uovDUs/ccxMqf3rlvSEQEBzt/sD5YHkNJZZU8pL+N2XRyi/klH3O9lJ2oIobD2DQy+a3
        BpNDZ80zINBw8JAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A73E113A37;
        Mon, 18 Jul 2022 16:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YReuJz6R1WJwBAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Jul 2022 16:58:38 +0000
Date:   Mon, 18 Jul 2022 18:53:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: factor out device stats printing code
Message-ID: <20220718165345.GJ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220718113439.2997247-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718113439.2997247-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 18, 2022 at 02:34:38PM +0300, Nikolay Borisov wrote:
> This is in preparation for introducing tabular output for device stats. Simply
> factor out string-specific output lines in a separate function.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  cmds/device.c | 141 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 76 insertions(+), 65 deletions(-)
> 
> diff --git a/cmds/device.c b/cmds/device.c
> index 7d3febff96c2..feffe9184726 100644
> --- a/cmds/device.c
> +++ b/cmds/device.c
> @@ -577,6 +577,71 @@ static const char * const cmd_device_stats_usage[] = {
>  	NULL
>  };
> 
> +static int _print_device_stat_string(struct format_ctx *fctx,
> +		struct btrfs_ioctl_get_dev_stats *args, char *path, bool check)
> +{
> +	char *canonical_path = path_canonicalize(path);
> +	char devid_str[32];
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
> +	/*
> +	 * The plain text and json formats cannot be
> +	 * mapped directly in all cases and we have to switch
> +	 */
> +	const bool json = (bconf.output_format == CMD_FORMAT_JSON);
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
> +	snprintf(devid_str, 32, "%llu", args->devid);
> +	fmt_print_start_group(fctx, NULL, JSON_TYPE_MAP);
> +	/* Plain text does not print device info */
> +	if (json) {
> +		fmt_print(fctx, "device", canonical_path);
> +		fmt_print(fctx, "devid", args->devid);
> +	}
> +
> +	for (j = 0; j < ARRAY_SIZE(dev_stats); j++) {
> +		enum btrfs_dev_stat_values stat_idx = dev_stats[j].stat_idx;
> +		/* We got fewer items than we know */
> +		if (args->nr_items < stat_idx + 1)
> +			continue;
> +
> +		/* Own format due to [/dev/name].value */
> +		if (json) {
> +			fmt_print(fctx, dev_stats[j].name, args->values[stat_idx]);
> +		} else {
> +			printf("[%s].%-16s %llu\n", canonical_path, dev_stats[j].name,
> +					(unsigned long long)args->values[stat_idx]);
> +		}
> +		if (check && (args->values[stat_idx] > 0))
> +			err |= 64;
> +	}
> +
> +	fmt_print_end_group(fctx, NULL);
> +	free(canonical_path);
> +
> +	return err;
> +}
> +
>  static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  {
>  	char *dev_path;
> @@ -586,7 +651,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  	int fdmnt;
>  	int i;
>  	int err = 0;
> -	int check = 0;
> +	bool check = false;
>  	__u64 flags = 0;
>  	DIR *dirstream = NULL;
>  	struct format_ctx fctx;
> @@ -606,7 +671,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
> 
>  		switch (c) {
>  		case 'c':
> -			check = 1;
> +			check = true;
>  			break;
>  		case 'z':
>  			flags = BTRFS_DEV_STATS_RESET;
> @@ -656,70 +721,16 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
>  			error("device stats ioctl failed on %s: %m",
>  			      path);
>  			err |= 1;
> -		} else {
> -			char *canonical_path;
> -			char devid_str[32];
> -			int j;
> -			static const struct {
> -				const char name[32];
> -				u64 num;
> -			} dev_stats[] = {
> -				{ "write_io_errs", BTRFS_DEV_STAT_WRITE_ERRS },
> -				{ "read_io_errs", BTRFS_DEV_STAT_READ_ERRS },
> -				{ "flush_io_errs", BTRFS_DEV_STAT_FLUSH_ERRS },
> -				{ "corruption_errs",
> -					BTRFS_DEV_STAT_CORRUPTION_ERRS },
> -				{ "generation_errs",
> -					BTRFS_DEV_STAT_GENERATION_ERRS },
> -			};
> -			/*
> -			 * The plain text and json formats cannot be
> -			 * mapped directly in all cases and we have to switch
> -			 */
> -			const bool json = (bconf.output_format == CMD_FORMAT_JSON);
> -
> -			canonical_path = path_canonicalize(path);
> -
> -			/* No path when device is missing. */
> -			if (!canonical_path) {
> -				canonical_path = malloc(32);
> -				if (!canonical_path) {
> -					error("not enough memory for path buffer");
> -					goto out;
> -				}
> -				snprintf(canonical_path, 32,
> -					 "devid:%llu", args.devid);
> -			}
> -			snprintf(devid_str, 32, "%llu", args.devid);
> -			fmt_print_start_group(&fctx, NULL, JSON_TYPE_MAP);
> -			/* Plain text does not print device info */
> -			if (json) {
> -				fmt_print(&fctx, "device", canonical_path);
> -				fmt_print(&fctx, "devid", di_args[i].devid);
> -			}
> +			goto out;
> +		}
> 
> -			for (j = 0; j < ARRAY_SIZE(dev_stats); j++) {
> -				/* We got fewer items than we know */
> -				if (args.nr_items < dev_stats[j].num + 1)
> -					continue;
> -
> -				/* Own format due to [/dev/name].value */
> -				if (json) {
> -					fmt_print(&fctx, dev_stats[j].name,
> -						args.values[dev_stats[j].num]);
> -				} else {
> -					printf("[%s].%-16s %llu\n",
> -						canonical_path,
> -						dev_stats[j].name,
> -						(unsigned long long)
> -						args.values[dev_stats[j].num]);
> -				}
> -				if ((check == 1)
> -				    && (args.values[dev_stats[j].num] > 0))
> -					err |= 64;
> -			}
> -			fmt_print_end_group(&fctx, NULL);
> -			free(canonical_path);
> +		int err2 = _print_device_stat_string(&fctx, &args, path, check);

Please don't define variables in the statement block.

> +		if (err2) {
> +			if (err2 < 0) {
> +				err = err2;
> +				goto out;
> +			} else
> +				err |= err2;
>  		}
>  	}
> 
> --
> 2.17.1
