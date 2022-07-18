Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63118578821
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 19:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiGRRLm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 13:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGRRLl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 13:11:41 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC47E2B24A
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 10:11:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A381332006F5;
        Mon, 18 Jul 2022 13:11:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 18 Jul 2022 13:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1658164295; x=1658250695; bh=WxVgk38qHE
        m22ifi+9UEghSS56VY/gUeMZg3AcL/7oA=; b=DzQw6zzs94xDTxL0ZddBHt2j37
        6bw6NPzY+sqeREJ8/pzqn8IPXCNvfPJt5OIs0rtoZTEkMs2CY1RKEe4YJk9daosK
        +X9ilRtDn0PtCkT73Ds9pGzhgmkIOMRXsPBM/ZAzALaH701kMKMiqb2TXl9Qp+ka
        OivANRJ5gPqPFVMtOhwZocuPo9EGQ0EtyjcFPBgRS4rYDjeD6WzRRGqQoNva5YSx
        jeFOiQlH/w5SzJp81ldyGkTEnuqYowxb6WhrHqMqBsSjl4iHFm5Tpz79Z4PlGjF1
        shBv9WyVeFZPklRyHGvmtanEtcXnv+tG8UE23rToFa11jXb3b5hV1kOoOUiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658164295; x=1658250695; bh=WxVgk38qHEm22ifi+9UEghSS56VY
        /gUeMZg3AcL/7oA=; b=si3ufad4gUTzfsvp1WYO5gAfWul8UuEDQd+JVJ5XrTov
        otLydu2dm3RkPLZVX/0tcFR0D2EcQ/7LPHLxaMtVCGrgQqhH7TMZdp37+PbghsFM
        xmd/DS3V1QZKY2j+hbW7e7r8GLLEV7+sP2DYZVHdTWzDX2ld4ebJCrRqv8BHSZ8n
        VokNtlRysuqFu1fgpYFMMFuJMNKYgDdrYHqWP+fQ8NUky5xkI2XOSlXYYFj5m3IG
        Awu621PWkgK45JTLsNp0uFG6v+eQIln4MrUi5jldKjaQLWWJXsL+hyFzYWCXzk54
        TSFU79Z+86eCKA7gUdPnWhsd45quZy3xMaxs+wmATQ==
X-ME-Sender: <xms:RpTVYmVgtBWv8S_mIK9vX1w-XlsupRsqNYkJaMVd1ajIa5EkZPsYLw>
    <xme:RpTVYinleQd7n5qMbAVsBS6rn1PCsWjQWbmN0MK-0xStdXlg26xxxIFTalg7WV4x0
    5Z_thSUeyoP_lR6EYA>
X-ME-Received: <xmr:RpTVYqbA9XnrfkReDQhZ32PHZf8iLf1Pqvi9Xwcktdq1YrJ9UgTHQzohQH8i4u2vS-yZagaltnNalkyprqcSju8adSyoIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekkedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:RpTVYtWWo4rFgphijTk7EChz7sCRxq90_1crMO7Yotqbl9qnR3Z5pA>
    <xmx:RpTVYglbyv9CtIgAlizyrLc-GONQnwXvhO4Ryw48YeIgIopRva6jlw>
    <xmx:RpTVYid1JfJMLrF7URHzZUo1ZQtilOXpk6hLR-iR-tcIGlLdSwM4lw>
    <xmx:R5TVYnsMoHVnI0zP95OiGi7DcdjHw-jK3JHpk1U0BOvbNeAmKqPExw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Jul 2022 13:11:34 -0400 (EDT)
Date:   Mon, 18 Jul 2022 10:11:32 -0700
From:   Boris Burkov <boris@bur.io>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: factor out device stats printing code
Message-ID: <YtWUOeKWYQa8c1Em@zen>
References: <20220718113439.2997247-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718113439.2997247-1-nborisov@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 18, 2022 at 02:34:38PM +0300, Nikolay Borisov wrote:
> This is in preparation for introducing tabular output for device stats. Simply
> factor out string-specific output lines in a separate function.

LGTM, and works fine. I mentioned a few nits inline.

> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
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

Documenting the return value seems valuable, since it has different
semantics for positive/negative

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

I believe the old code didn't actually set err to ENOMEM in this case. I
assume this is an improvement, but figured it was worth noting.

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

now that err starts at zero and gets returned, |= doesn't really do
anything here, compared to just =, does it?

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
> 
