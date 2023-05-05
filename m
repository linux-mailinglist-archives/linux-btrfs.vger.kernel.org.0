Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC6B6F84A5
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 16:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjEEOPw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 10:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjEEOPq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 10:15:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0EE1891F
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 07:15:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 643FD22413;
        Fri,  5 May 2023 14:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683296116;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FqcABGkZxT0zL2W/2cSYjMXPdbhcjgbfChYqxYuBR+o=;
        b=ZiRGoDXy1pxLYkGlVxPviCLHV9CQ7mtSV2oFMb4hSMrkfHIvg4LEk7NiEasDQMsvDgj2xI
        XimHfvSrTnTKzbCLw/zetrAiY9IUEqq2qBBmacTdNBC2zppkPO/n+acjcXx5qcHKP1vunb
        sdZeqm/rr+7sLtmHgq1iWb91Qti/vI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683296116;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FqcABGkZxT0zL2W/2cSYjMXPdbhcjgbfChYqxYuBR+o=;
        b=ROv6FmH5/cIOtxSo7d/wvOb6h5sUq2B6nY7pKjajDpV6dFbOBrrtUW0oJhn0Sw2ltL1RSl
        Qj7HRTHi0rVopzAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A8ED13513;
        Fri,  5 May 2023 14:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Oht/DXQPVWTIbQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 05 May 2023 14:15:16 +0000
Date:   Fri, 5 May 2023 16:09:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: output affected files when relocation failed
Message-ID: <20230505140919.GP6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ad4e1c92f8d623557458d1968d76f755264e050e.1683088762.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4e1c92f8d623557458d1968d76f755264e050e.1683088762.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 03, 2023 at 12:40:01PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> When relocation failed (mostly due to checksum mismatch), we only got
> very cryptic error messages like
> 
>   BTRFS info (device dm-4): relocating block group 13631488 flags data
>   BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 csum 0x373e1ae3 expected csum 0x98757625 mirror 1
>   BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>   BTRFS info (device dm-4): balance: ended with status: -5
> 
> The end user has to decrypt the above messages and use various tools to
> locate the affected files and find a way to fix the problem (mostly
> deleting the file).
> 
> This is not an easy work even for experienced developer, not to mention
> the end users.
> 
> [SCRUB IS DOING BETTER]
> By contrast, scrub is providing much better error messages:
> 
>  BTRFS error (device dm-4): unable to fixup (regular) error at logical 13631488 on dev /dev/mapper/test-scratch1 physical 13631488
>  BTRFS warning (device dm-4): checksum error at logical 13631488 on dev /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, length 4096, links 1 (path: file)
>  BTRFS info (device dm-4): scrub: finished on devid 1 with status: 0
> 
> Which provides the affected files directly to the end user.
> 
> [IMPROVEMENT]
> Instead of the generic data checksum error messages, which is not doing
> a good job for data reloc inodes, this patch introduce a scrub like
> backref walking based solution.
> 
> When a sector failed its checksum for data reloc inode, we go the
> following workflow:
> 
> - Get the real logical bytenr
>   For data reloc inode, the file offset is the offset inside the block
>   group.
>   Thus the real logical bytenr is @file_off + @block_group->start.
> 
> - Do an extent type check
>   If it's tree blocks it's much easier to handle, just go through
>   all the tree block backref.
> 
> - Do a backref walk and inode path resolution for data extents
>   This is mostly the same as scrub.
>   But unfortunately we can not reuse the same function as the output
>   format is different.
> 
> Now the new output would be more user friendly:
> 
>  BTRFS info (device dm-4): relocating block group 13631488 flags data
>  BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 logical 13631488 csum 0x373e1ae3 expected csum 0x98757625 mirror 1
>  BTRFS warning (device dm-4): checksum error at logical 13631488 mirror 1 root 5 inode 257 offset 0 length 4096 links 1 (path: file)
>  BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
>  BTRFS info (device dm-4): balance: ended with status: -5
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Output the ino number using %llu
> - Add a description for the new data_reloc_warn structure
> - Use new comment format for the copied comments
> - Use a less serious output message if we failed to resolve filename due
>   to -ENOMEM
> - Replace btrfs_warn_in_rcu() with btrfs_warn()
>   As that RCU usage is from scrub output which grabs the device, but
>   for balance we don't need that RCU usage at all.

There was one more left to change to btrfs_warn_rl, otherwise the
messages look good. Added to misc-next, thanks.
