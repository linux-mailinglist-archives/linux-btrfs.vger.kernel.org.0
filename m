Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28773691101
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 20:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBITJl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 14:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBITJk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 14:09:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8347766FAF
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 11:09:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52493379F7;
        Thu,  9 Feb 2023 19:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675969776;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJvYwxt2zMG7t6kxh3DU+R95pgOYloTQAzcUre6+YVI=;
        b=zrU22xmgtrlUKNZUP9V/fdDi5AAU2ImTihoa+SCGGcBsPwpOfBFmRna0cXeJ0MHe/jFuGJ
        JyAnzGmYMyhYitcoVDc00iQNjg/jHz4d3rdFKbVGFNNHeX9+v6FdrA8hbZXTxmkqPKhGaS
        X6JcL51BoTwFvSJj3pp1/JJfqPloAUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675969776;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJvYwxt2zMG7t6kxh3DU+R95pgOYloTQAzcUre6+YVI=;
        b=tVVTOVCR5QhTpjRgdwMTh3BYqcVanZxZyQJwmEj/18qNRLO113WT3dPLF8ycq0ypxZNCCf
        vVmtjgj3Y0NY4vCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C530138E4;
        Thu,  9 Feb 2023 19:09:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W5GtBO9E5WNiKQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 09 Feb 2023 19:09:35 +0000
Date:   Thu, 9 Feb 2023 20:03:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs-progs: receive: fix a corruption when
 decompressing zstd extents
Message-ID: <20230209190336.GM28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <556529ebcca0b5404ef0ce284d5ecccd2e2ae660.1675353238.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556529ebcca0b5404ef0ce284d5ecccd2e2ae660.1675353238.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 02, 2023 at 03:59:01PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Before decompressing, we zero out the content of the entire output buffer,
> so that we don't get any garbage after the last byte of data. We do this
> for all compression algorithms. However zstd, at least with libzstd 1.5.2
> on Debian (version 1.5.2+dfsg-1), the decompression routine can end up
> touching the content of the output buffer beyond the last valid byte of
> decompressed data, resulting in a corruption.
> 
> Example reproducer:
> 
>    $ cat test.sh
>    #!/bin/bash
> 
>    DEV=/dev/sdj
>    MNT=/mnt/sdj
> 
>    rm -f /tmp/send.stream
> 
>    umount $DEV &> /dev/null
>    mkfs.btrfs -f $DEV &> /dev/null || echo "MKFS failed!"
>    mount -o compress=zstd $DEV $MNT
> 
>    # File foo is not sector size aligned, 127K.
>    xfs_io -f -c "pwrite -S 0xab 0 3" \
>              -c "pwrite -S 0xcd 3 130042" \
>              -c "pwrite -S 0xef 130045 3" $MNT/foo
> 
>    # Now do an fallocate that increases the size of foo from 127K to 128K.
>    xfs_io -c "falloc 0 128K " $MNT/foo
> 
>    btrfs subvolume snapshot -r $MNT $MNT/snap
> 
>    btrfs send --compressed-data -f /tmp/send.stream $MNT/snap
> 
>    echo -e "\nFile data in the original filesystem:\n"
>    od -A d -t x1 $MNT/snap/foo
> 
>    umount $MNT
>    mkfs.btrfs -f $DEV &> /dev/null || echo "MKFS failed!"
>    mount $DEV $MNT
> 
>    btrfs receive --force-decompress -f /tmp/send.stream $MNT
> 
>    echo -e "\nFile data in the new filesystem:\n"
>    od -A d -t x1 $MNT/snap/foo
> 
>    umount $MNT
> 
> Running the reproducer gives:
> 
>    $ ./test.sh
>    (...)
>    File data in the original filesystem:
> 
>    0000000 ab ab ab cd cd cd cd cd cd cd cd cd cd cd cd cd
>    0000016 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
>    *
>    0130032 cd cd cd cd cd cd cd cd cd cd cd cd cd ef ef ef
>    0130048 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    *
>    0131072
>    At subvol snap
> 
>    File data in the new filesystem:
> 
>    0000000 ab ab ab cd cd cd cd cd cd cd cd cd cd cd cd cd
>    0000016 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
>    *
>    0130032 cd cd cd cd cd cd cd cd cd cd cd cd cd ef ef ef
>    0130048 cd cd cd cd 00 00 00 00 00 00 00 00 00 00 00 00
>    0130064 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    *
>    0131072
> 
> The are 4 bytes with a value of 0xcd instead of 0x00, at file offset
> 127K (130048).
> 
> Fix this by explicitly zeroing out the part of the output buffer that was
> not used after decompressing with zstd.
> 
> The decompression of compressed extents, sent when using the send v2
> stream, happens in the following cases:
> 
> 1) By explicitly passing --force-decompress to the receive command, as in
>    the reproducer above;
> 
> 2) Calling the BTRFS_IOC_ENCODED_WRITE ioctl failed with -ENOTTY, meaning
>    the kernel on the receiving side is old and does not implement that
>    ioctl;
> 
> 3) Calling the BTRFS_IOC_ENCODED_WRITE ioctl failed with -ENOSPC;
> 
> 4) Calling the BTRFS_IOC_ENCODED_WRITE ioctl failed with -EINVAL.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to devel, thanks.
