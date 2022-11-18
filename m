Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B5862F9F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 17:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242025AbiKRQMR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 11:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241915AbiKRQML (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 11:12:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A768E0B6
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 08:12:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 77A6A1FD0F;
        Fri, 18 Nov 2022 16:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668787928;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ogDyTDOUOcmlLxVdglSg4cdk8Hdzs0MCwoznXYYQqM=;
        b=ym+bw4Mzxhjm5gwm209LlXlTtZlhN51grai9pID/f9k7VDvThZlthREd30n1/55mVtMXrQ
        hIc3XjkU60/iieFitAAtGHAiPWK7EnZCLU/DUcaWiWobq2QqLZhglLrGVL9axMaock7xqY
        yWaklXDrxCCPY7JXSx1PZY3KVSMCMug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668787928;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ogDyTDOUOcmlLxVdglSg4cdk8Hdzs0MCwoznXYYQqM=;
        b=YlwNk9GRp9NovWOQnZuoRfIR0vWVQIWZpkOpqr2/DlyjGxx8Xfd+fvy1kz0qVBnORkQjpi
        +xalWhjSrOpoi/Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5693513A66;
        Fri, 18 Nov 2022 16:12:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iukIFNiud2OMfgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 18 Nov 2022 16:12:08 +0000
Date:   Fri, 18 Nov 2022 17:11:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: avoid unaligned encoded writes when
 attempting to clone range
Message-ID: <20221118161140.GS5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1eb4a70a884ed958177a5164aadd11f9a1d8ac52.1668529729.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb4a70a884ed958177a5164aadd11f9a1d8ac52.1668529729.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 04:29:44PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When trying to see if we can clone a file range, there are cases where we
> end up sending two write operations in case the inode from the source root
> has an i_size that is not sector size aligned and the length from the
> current offset to its i_size is less than the remaining length we are
> trying to clone.
> 
> Issuing two write operations when we could instead issue a single write
> operation is not incorrect. However it is not optimal, specially if the
> extents are compressed and the flag BTRFS_SEND_FLAG_COMPRESSED was passed
> to the send ioctl. In that case we can end up sending an encoded write
> with an offset that is not sector size aligned, which makes the receiver
> fallback to decompressing the data and writing it using regular buffered
> IO (so re-compressing the data in case the fs is mounted with compression
> enabled), because encoded writes fail with -EINVAL when an offset is not
> sector size aligned.
> 
> The following example, which triggered a bug in the receiver code for the
> fallback logic of decompressing + regular buffer IO and is fixed by the
> patchset referred in a Link at the bottom of this changelog, is an example
> where we have the non-optimal behaviour due to an unaligned encoded write:
> 
>    $ cat test.sh
>    #!/bin/bash
> 
>    DEV=/dev/sdj
>    MNT=/mnt/sdj
> 
>    mkfs.btrfs -f $DEV > /dev/null
>    mount -o compress $DEV $MNT
> 
>    # File foo has a size of 33K, not aligned to the sector size.
>    xfs_io -f -c "pwrite -S 0xab 0 33K" $MNT/foo
> 
>    xfs_io -f -c "pwrite -S 0xcd 0 64K" $MNT/bar
> 
>    # Now clone the first 32K of file bar into foo at offset 0.
>    xfs_io -c "reflink $MNT/bar 0 0 32K" $MNT/foo
> 
>    # Snapshot the default subvolume and create a full send stream (v2).
>    btrfs subvolume snapshot -r $MNT $MNT/snap
> 
>    btrfs send --compressed-data -f /tmp/test.send $MNT/snap
> 
>    echo -e "\nFile bar in the original filesystem:"
>    od -A d -t x1 $MNT/snap/bar
> 
>    umount $MNT
>    mkfs.btrfs -f $DEV > /dev/null
>    mount $DEV $MNT
> 
>    echo -e "\nReceiving stream in a new filesystem..."
>    btrfs receive -f /tmp/test.send $MNT
> 
>    echo -e "\nFile bar in the new filesystem:"
>    od -A d -t x1 $MNT/snap/bar
> 
>    umount $MNT
> 
> Before this patch, the send stream included one regular write and one
> encoded write for file 'bar', with the later being not sector size aligned
> and causing the receiver to fallback to decompression + buffered writes.
> The output of the btrfs receive command in verbose mode (-vvv):
> 
>    (...)
>    mkfile o258-7-0
>    rename o258-7-0 -> bar
>    utimes
>    clone bar - source=foo source offset=0 offset=0 length=32768
>    write bar - offset=32768 length=1024
>    encoded_write bar - offset=33792, len=4096, unencoded_offset=33792, unencoded_file_len=31744, unencoded_len=65536, compression=1, encryption=0
>    encoded_write bar - falling back to decompress and write due to errno 22 ("Invalid argument")
>    (...)
> 
> This patch avoids the regular write followed by an unaligned encoded write
> so that we end up sending a single encoded write that is aligned. So after
> this patch the stream content is (output of btrfs receive -vvv):
> 
>    (...)
>    mkfile o258-7-0
>    rename o258-7-0 -> bar
>    utimes
>    clone bar - source=foo source offset=0 offset=0 length=32768
>    encoded_write bar - offset=32768, len=4096, unencoded_offset=32768, unencoded_file_len=32768, unencoded_len=65536, compression=1, encryption=0
>    (...)
> 
> So we get more optimal behaviour and avoid the silent data loss bug in
> versions of btrfs-progs affected by the bug referred by the Link tag
> below (btrfs-progs v5.19, v5.19.1, v6.0 and v6.0.1).
> 
> Link: https://lore.kernel.org/linux-btrfs/cover.1668529099.git.fdmanana@suse.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
