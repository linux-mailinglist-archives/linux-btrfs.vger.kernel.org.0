Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F201D59BB30
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 10:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbiHVIPO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 04:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiHVIPH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 04:15:07 -0400
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 01:14:56 PDT
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622FC1C105
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 01:14:56 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id AC9599B6AE; Mon, 22 Aug 2022 09:05:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1661155522;
        bh=CxLACLqkC92pED8R98uU4QAbKOSfdW0uQ70E40HsADg=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=emZn/c+4sd+edlq6bOqwuFrqU1CkNfaYpX3eThERcHLE+ombN0j9mJMia51y04X2x
         tx3CgvOgOtyS6aTf2g7driRbW+A4mM0uIXpsxDk/bJ91Z48MU4UDCwfnC344lO8WxF
         6YFiXhbpECKZCFWq5AT5gYcd9OPWjCe5BCSzw6fWcBK/KSVT7BHks0DWBb1bSjx4LN
         rAal7v9Y3O3YBciZG2USf8FuCNBvi792wSi7O0zrWnkGGaJbjaWhzplFyhgksOVSfh
         8/6d75Z64wI6tIHafWe0PGPRBlWLxbOsnfz2SGd+oFCg9mL1Hs0UfFcXE12IfIOkEe
         jGwprbMbki86w==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 9833F9B6AE;
        Mon, 22 Aug 2022 09:00:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1661155221;
        bh=CxLACLqkC92pED8R98uU4QAbKOSfdW0uQ70E40HsADg=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=nXSkcpl+NbYE94s0S305WEYW84ZTWxjv16WqUp8c8F0JQq1/Ns/ERArEBqApjDl0a
         Z4G3UoZPoI9dzCDPlcQEW4FQEfIhmTiM3lWtu5dM9fb1t3G+8K/SHA+ADPfwJrlyuO
         ya/0GbEya6uSK1JQKRWci+GucJtii0ZX8R9DBH5BYTqZ6VhCqozogGAjtYIQ/KcErN
         V2NqFWlnaf8rOPmq51Yj2672e1+yhSEb68pr/wcqsBprrqelxXNR6/meny6lTH6Jlz
         B9JWglDNhR5EKWGZFfgcO0y7trmiyVdcrEbC285D5wRlq2yInCwxaNIUnUz49Cq5hG
         zan2QWDoeg1PA==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 46B781D2FCE;
        Mon, 22 Aug 2022 09:00:21 +0100 (BST)
Message-ID: <8c703e22-3425-0e7a-23d3-41793d7ed6e7@cobb.uk.net>
Date:   Mon, 22 Aug 2022 09:00:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH] btrfs-progs: scrub: add extra warning for scrub on single
 device
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <7834c0cac7eaa195952b7450c4d4a150376ba21e.1661152421.git.wqu@suse.com>
In-Reply-To: <7834c0cac7eaa195952b7450c4d4a150376ba21e.1661152421.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/08/2022 08:15, Qu Wenruo wrote:
> [PROBLEM]
> 
> Command "btrfs scrub start" can be executed with single device or a
> mount point.
> 
> If executed with single device, it will only start a scrub for that
> device.
> 
> This is fine for SINGLE/DUP/RAID1*/RAID10/RAID0, as they are all
> mirror/simple stripe based profiles.
> 
> But this can be a problem for RAID56, as for RAID56 scrub, data stripes
> are treated as RAID0, while only when scrubbing the P/Q stripes or doing
> data rebuild we will try to do a full stripe read/rebuild.
> 
> This means, for the following case:
> 
> Dev 1:  |<--- Data stripe 1 (good) -->|
> Dev 2:  |<--- Data stripe 2 (good) -->|
> Dev 3:  |<--- Parity stripe (bad)  -->|
> 
> If we only scrub dev 1 or dev 2, the corrupted parity on dev 3 will not
> be repaired, breaking the one corrupted/missing device tolerance.
> (if we lost device 1 or 2, no data can be recovered for this full
> stripe).
> 
> Unfortunately for the existing btrfs RAID56 users, there seems to be a
> trend to use single device scrub instead of full fs scrub.
> 
> [CAUSE]
> 
> This is due to the bad design of btrfs_scrub_dev(), by treating data
> stripes just like RAID0.
> This means, we will read data stripes several times (2x for RAID5, 3x
> for RAID6), not only causing more IO, but much slower read for each
> device.
> 
> At least the end users should be fully informed, and choose their poison
> to drink (until a better ioctl introduced).
> 
> [WORKAROUND]
> 
> This patch will introduce the following workarounds:
> 
> - Extra warning for "btrfs scrub start <dev>"
>   If we detect we're doing single device scrub, and the fs has RAID56
>   feature, we output a warning for the user.
>   (But still allow the command to execute)
> 
> - Extra man page warning.
>   Now there is an extra section for scrub and RAID56.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> BTW there is a WIP new ioctl, btrfs_scrub_fs(), that is going to change
> the situation for RAID56, by not only reducing the IO for RAID56, but
> with better error reporting (including P/Q mismatch cases), and simpler
> and streamlined code for verification.
> 
> Thus in the future, we may switch to the new ioctl and in that case, the
> error message will no longer be needed for the new ioctl.
> ---
>  Documentation/btrfs-scrub.rst | 13 +++++++++++++
>  cmds/scrub.c                  | 29 +++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/btrfs-scrub.rst b/Documentation/btrfs-scrub.rst
> index 75079eecc9ef..bbf342d4b6c8 100644
> --- a/Documentation/btrfs-scrub.rst
> +++ b/Documentation/btrfs-scrub.rst
> @@ -48,6 +48,19 @@ start [-BdqrRf] [-c <ioprio_class> -n <ioprio_classdata>] <path>|<device>
>          configured similar to the ``ionice(1)`` syntax using *-c* and *-n*
>          options.  Note that not all IO schedulers honor the ionice settings.
>  
> +        .. warning::
> +                Using ``btrfs scrub start <device>`` on a RAID56 fs is strongly
> +                discouraged.

It isn't immediately obvious to the reader that you mean to distinguish
the single-device case from the mounted-filesystem case here. How about:

Using single device scrub on a RAID56 filesystem (``btrfs scrub start
<device>``) is strongly discouraged.

> +
> +                Due to the bad design of RAID56 scrub, single device scrubbing
> +                will tread the data stripes as RAID0, only for data recovery
> +                (data stripes has bad csum) or P/Q stripes we do full stripe
> +                checks.
> +
> +                This means, if running ``btrfs scrub start <device>``,
> +                corruption in P/Q stripes has a high chance not to be repaired,
> +                greatly reducing the robustness of RAID56.

How about replacing both the above paragraphs with:

The current implementation of single device scrubbing for RAID56
filesystems will only check data checksums on the specified device, and
will not check parity stripes on other devices, greatly reducing the
robustness of RAID56.

For full scrub and repair of RAID56 filesystems always use ``btrfs scrub
start <path>``.

> +
>          ``Options``
>  
>          -B
> diff --git a/cmds/scrub.c b/cmds/scrub.c
> index 7c2d9b79c275..a69de8c1402b 100644
> --- a/cmds/scrub.c
> +++ b/cmds/scrub.c
> @@ -42,6 +42,7 @@
>  #include "kernel-shared/volumes.h"
>  #include "kernel-shared/disk-io.h"
>  #include "common/open-utils.h"
> +#include "common/path-utils.h"
>  #include "common/units.h"
>  #include "cmds/commands.h"
>  #include "common/help.h"
> @@ -1143,6 +1144,7 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
>  		       bool resume)
>  {
>  	int fdmnt;
> +	int sysfsfd = -1;
>  	int prg_fd = -1;
>  	int fdres = -1;
>  	int ret;
> @@ -1188,6 +1190,8 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
>  	DIR *dirstream = NULL;
>  	int force = 0;
>  	int nothing_to_resume = 0;
> +	bool is_block_dev = false;
> +	bool is_raid56 = false;
>  
>  	while ((c = getopt(argc, argv, "BdqrRc:n:f")) != -1) {
>  		switch (c) {
> @@ -1242,6 +1246,9 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
>  
>  	path = argv[optind];
>  
> +	if (path_is_block_device(path))
> +		is_block_dev = true;
> +
>  	fdmnt = open_path_or_dev_mnt(path, &dirstream, !do_quiet);
>  	if (fdmnt < 0)
>  		return 1;
> @@ -1254,6 +1261,28 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
>  		err = 1;
>  		goto out;
>  	}
> +
> +	sysfsfd = sysfs_open_fsid_file(fdmnt, "features/raid56");
> +	if (sysfsfd >= 0) {
> +		is_raid56 = true;
> +		close(sysfsfd);
> +	}
> +
> +	/*
> +	 * If we're scrubbing a single device on fs with RAID56, that scrub
> +	 * will not verify the data on the other stripes unless we're scrubbing
> +	 * a P/Q stripe.
> +	 * Due to the current scrub_dev ioctl design, we can cause way more
> +	 * IO for data stripes, thus full scrub on RAID56 can be slow.
> +	 *
> +	 * Some one uses single device scrub to speed up the progress, but the
> +	 * hidden cost of corrupted/unscrubbed data must not be hidden.
> +	 */
> +	if (is_raid56 && is_block_dev) {
> +		warning("scrub single device of a btrfs RAID56 is not recommened.");

Recommended

> +		warning("Check 'btrfs-scrub'(8) for more details");
> +	}
> +
>  	if (!fi_args.num_devices) {
>  		error_on(!do_quiet, "no devices found");
>  		err = 1;

Graham
