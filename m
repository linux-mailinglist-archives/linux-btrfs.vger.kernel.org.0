Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40B97C734B
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 18:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347319AbjJLQnI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 12:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347324AbjJLQnG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 12:43:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB390C6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 09:43:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 42A851F8AB;
        Thu, 12 Oct 2023 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697128983;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2IvPK8cWvKxJERtQDwInMTXjrUZMNq1qDHI584G4Pbg=;
        b=R415Tt7nGQ7/BbQ3Y0qS6BtjGlTRtK50HwiwVkwQrbadFeEaDa28sTg2AfSLqWm6+eoyKm
        /Oke5sZxVnvbrrwUebaqVdwHV2mg2dThO1hMrv6AIyPkWbBbCMydWtbneD7zWA+OOSZgBV
        SFMfkqRlXx1lrNz1HUw0ZpuqagAgP1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697128983;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2IvPK8cWvKxJERtQDwInMTXjrUZMNq1qDHI584G4Pbg=;
        b=5S4dxEPRxB81tTVw9mG3sWUBl8Llv3hsSUC+Yt/A2aud+1HauQFpPJdg0cGyJmkz2tTA7P
        HE8eR7Wt1pyQsKBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E82D139ED;
        Thu, 12 Oct 2023 16:43:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j+weBhciKGWeWQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 12 Oct 2023 16:43:03 +0000
Date:   Thu, 12 Oct 2023 18:36:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: mkfs: do not enlarge the target block device
Message-ID: <20231012163616.GK2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8ce8ead459b46a5b6849077ee50cf526418263da.1697099461.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ce8ead459b46a5b6849077ee50cf526418263da.1697099461.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.80
X-Spamd-Result: default: False [-7.80 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWO(0.00)[2];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 12, 2023 at 07:01:04PM +1030, Qu Wenruo wrote:
> [BUG]
> When running mkfs.btrfs with --rootdir on a block device, and the source
> directory contains a sparse file, whose size is larger than the block
> size, then mkfs.btrfs would fail:
> 
>   # lsblk  /dev/test/test
>   NAME      MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
>   test-test 253:0    0  10G  0 lvm
>   # mkdir -p /tmp/output
>   # truncate -s 20G /tmp/output/file
>   # mkfs.btrfs -f --rootdir /tmp/output /dev/test/test
>   # sudo mkfs.btrfs  -f /dev/test/scratch1  --rootdir /tmp/output/
>   btrfs-progs v6.3.3
>   See https://btrfs.readthedocs.io for more information.
> 
>   ERROR: unable to zero the output file
> 
> [CAUSE]
> Mkfs.btrfs would try to zero out the target file according to the total
> size of the directory.
> 
> However the directory size is calculated using the file size, not the
> real bytes taken by the file, thus for such sparse file with holes only,
> it would still take 20G.
> 
> Then we would use that 20G size to zero out the target file, but if the
> target file is a block device, we would fail as we can not enlarge a block
> device.
> 
> [FIX]
> When zeroing the file, we only enlarge it if the target is a regular
> file.
> Otherwise we warn about the size and continue.
> 
> Please note that, since "mkfs.btrfs --rootdir" doesn't handle sparse
> file any differently from regular file, above case would still fail due
> to ENOSPC, as will write zeros into the target file inside the fs.
> 
> Proper handling for sparse files would need a new series of patch to
> address.
> 
> Issue: #653
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
> ---
>  mkfs/main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 5abf7605326c..7d0ffac309e8 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1567,8 +1567,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  			block_count = device_get_partition_size_fd_stat(fd, &statbuf);
>  		source_dir_size = btrfs_mkfs_size_dir(source_dir, sectorsize,
>  				min_dev_size, metadata_profile, data_profile);
> -		if (block_count < source_dir_size)
> -			block_count = source_dir_size;
> +		if (block_count < source_dir_size) {
> +			if (S_ISREG(statbuf.st_mode))
> +				block_count = source_dir_size;
> +			else
> +				warning("the target device is smaller than the source directory, mkfs may fail");

I've updated the message to also say the numbers:

WARNING: the target device 122683392 (117.00MiB) is smaller than the
calculated source directory size 114294784 (209.00MiB) , mkfs may fail
