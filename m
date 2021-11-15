Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F039451691
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 22:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhKOVbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 16:31:38 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49026 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352503AbhKOUyI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 15:54:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8E97E218CE;
        Mon, 15 Nov 2021 20:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637009470;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kosQS69Rm/kyehiO2SS1mdVfeJCIvsVtxfiujEL6YvQ=;
        b=UXysCV7cmV5uBYvj+0AMEyRuuXfiypWWpIK+QEoAfnRtODtGIRGpQS0z+0AUZxrbaRtgnz
        +Zdji2DPyDWL6dMb5ymmVRzrJYRB0oj3AID+H84VL9uvvxxcju1PcAhQ8JtGFoyDSqvwJn
        K8pJskuqaWb2ulcBcEE3RgS3X4yo+BQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637009470;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kosQS69Rm/kyehiO2SS1mdVfeJCIvsVtxfiujEL6YvQ=;
        b=UzvaArz/f+ROIgho6fzThuHuQHVviQlu/xMoD2u2DBtF1GfpNZ3c5Yh+O8nVwV7OOApLVO
        FqO3eH9H6MaIR6Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 87D75A3B87;
        Mon, 15 Nov 2021 20:51:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9C1A0DA781; Mon, 15 Nov 2021 21:51:07 +0100 (CET)
Date:   Mon, 15 Nov 2021 21:51:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 29/30] btrfs-progs: mkfs: create the global root's
Message-ID: <20211115205107.GO28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1636575146.git.josef@toxicpanda.com>
 <dc65e92db91bcdf238b17e53d3efdb8ec21a493e.1636575147.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc65e92db91bcdf238b17e53d3efdb8ec21a493e.1636575147.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 03:14:41PM -0500, Josef Bacik wrote:
> @@ -966,13 +1010,18 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	struct btrfs_mkfs_config mkfs_cfg;
>  	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
>  	u64 system_group_size;
> +	int nr_global_roots = sysconf(_SC_NPROCESSORS_ONLN);
>  
>  	crc32c_optimization_init();
>  	btrfs_config_init();
>  
>  	while(1) {
>  		int c;
> -		enum { GETOPT_VAL_SHRINK = 257, GETOPT_VAL_CHECKSUM };
> +		enum {
> +			GETOPT_VAL_SHRINK = 257,
> +			GETOPT_VAL_CHECKSUM,
> +			GETOPT_VAL_GLOBAL_ROOTS,
> +		};
>  		static const struct option long_options[] = {
>  			{ "byte-count", required_argument, NULL, 'b' },
>  			{ "csum", required_argument, NULL,
> @@ -996,6 +1045,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  			{ "quiet", 0, NULL, 'q' },
>  			{ "verbose", 0, NULL, 'v' },
>  			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
> +			{ "num-global-roots", required_argument, NULL, GETOPT_VAL_GLOBAL_ROOTS },

This will be good under the #ifdef EXPERIMENTAL too, so we don't
accidentaly expose it, the rest of the option handling code can stay as
it would be unreachable.

No need to resend, a separate patch is ok for that.

>  			{ "help", no_argument, NULL, GETOPT_VAL_HELP },
>  			{ NULL, 0, NULL, 0}
>  		};
