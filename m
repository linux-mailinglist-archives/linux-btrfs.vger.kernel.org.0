Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8075363D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 16:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351047AbiE0OMx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 10:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344015AbiE0OMu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 10:12:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C83F1FCCB
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 07:12:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E7F271F889;
        Fri, 27 May 2022 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653660767;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wj2YC637e7FYYE65jm3gYHYAgXAcmS8vH4Jwyy+7fzg=;
        b=UBPn7BErInC1UDKKvkfFRLA2JcjgViA+ak/sz2qv/v7MxaoJK8QTGCybMsNW8/Vo1c4VgC
        X+JE0KCmS7RrLssWYUQTz68pYJtO+7f0LpOnYSLjsxswCfqDm2uk/qpMOMj5KurI4JRkhp
        XUzS6ht0pElZAUh8UkkQ0dfZ4NInMlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653660767;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wj2YC637e7FYYE65jm3gYHYAgXAcmS8vH4Jwyy+7fzg=;
        b=F03HavK7xZL4DNtOyaqkONWfa3UtwF1CG8kkSufWrAYnCcsthZCT92+VEuth8xmYEoWITY
        b3o4bJ2++D4irPAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB506139C4;
        Fri, 27 May 2022 14:12:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TrTDLF/ckGIQWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 27 May 2022 14:12:47 +0000
Date:   Fri, 27 May 2022 16:08:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: raid56: reduce unnecessary parity writes
Message-ID: <20220527140824.GC20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1653636443.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1653636443.git.wqu@suse.com>
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

On Fri, May 27, 2022 at 03:28:16PM +0800, Qu Wenruo wrote:
> If we have only 8K partial write at the beginning of a full RAID56
> stripe, we will write the following contents:
> 
>                     0  8K           32K             64K
> Disk 1	(data):     |XX|            |               |
> Disk 2  (data):     |               |               |
> Disk 3  (parity):   |XXXXXXXXXXXXXXX|XXXXXXXXXXXXXXX|
> 
> |X| means the sector will be written back to disk.
> 
> This is due to the fact that we don't really check if the vertical
> stripe has any data (aka, range from higher level bio) for parity
> stripes.
> 
> The patchset will convert it to the following write pattern:
> 
>                     0  8K           32K             64K
> Disk 1	(data):     |XX|            |               |
> Disk 2  (data):     |               |               |
> Disk 3  (parity):   |XX|            |               |
> 
> This is done by fully utilize btrfs_raid_bio::dbitmap which is only
> utilized by scrub path.
> 
> Now write path (either partial or full write) will also populate
> btrfs_raid_bio::dbitmap, and then only assemble sectors marked in
> dbitmap for submission.
> 
> The first two patches is just to make previous bitmap pointers into
> integrated bitmaps inside the bbtrfs_raid_bio and scrub_parity.
> 
> This saves 8 bytes for each structure.
> 
> The final patch does the most important work, by introducing a new
> helper, rbio_add_bio() to mark the btrfs_raid_bio::dbitmap.
> Then in finish_rmw() only add sectors which has bit in dbitmap marked to
> change the write pattern.
> 
> 
> Qu Wenruo (3):
>   btrfs: use integrated bitmaps for btrfs_raid_bio::dbitmap and
>     finish_pbitmap
>   btrfs: use integrated bitmaps for scrub_parity::dbitmap and ebitmap
>   btrfs: only write the sectors in the vertical stripe which has data
>     stripes

Added to a for-next/topic branch, thanks.
