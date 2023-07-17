Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58E37570AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jul 2023 01:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGQXxS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 19:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGQXxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 19:53:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4B091
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 16:53:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 628212192D;
        Mon, 17 Jul 2023 23:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689637991;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3o0Jb56E++Dt0Si4R1PBLZZzmgn3pGOJFlWo7RAXOzo=;
        b=fMtzrviSGkcW/Byvg1TztYgRkpq+ac9AY5cmk2wqU7BuGXbkFMbwcP998EhOjCw44qKTxh
        xcCXZWioY8fDeb7DRK4OjJ5xD3N04huUvN9EQs5D4h0sFq2MQt0v30xWkKA3OE/xQgVXF3
        td9hoZLhM3HdBSWIXF3UMWiL6U0KR0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689637991;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3o0Jb56E++Dt0Si4R1PBLZZzmgn3pGOJFlWo7RAXOzo=;
        b=dLceY4UzHAe6+QjQiHOSFa6zoaIaemRayVCYz4nthgDBbXz9yhV3T2FjBtX/NIo7Xonk9L
        FWLUVFRJG76t+oCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32F42138F8;
        Mon, 17 Jul 2023 23:53:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id scmHC2fUtWSwVAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 17 Jul 2023 23:53:11 +0000
Date:   Tue, 18 Jul 2023 01:46:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org,
        syzbot <syzbot+5b82f0e951f8c2bcdb8f@syzkaller.appspotmail.com>
Subject: Re: [PATCH] btrfs: fix ordered extent split error handling in
 btrfs_dio_submit_io
Message-ID: <20230717234632.GL20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230714084241.548739-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714084241.548739-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 14, 2023 at 10:42:41AM +0200, Christoph Hellwig wrote:
> When the call to btrfs_extract_ordered_extent in btrfs_dio_submit_io
> fails to allocate memory for a new ordered_extent, it calls into the
> btrfs_dio_end_io for error handling.  btrfs_dio_end_io then assumes that
> bbio->ordered is set because it is supposed to be at this point, except
> for this error handling corner case.  Try to not overload the
> btrfs_dio_end_io with error handling of a bio in a non-canonical state,
> and instead call btrfs_finish_ordered_extent and iomap_dio_bio_end_io
> directly for this error case.
> 
> Fixes: b41b6f6937dc ("btrfs: use btrfs_finish_ordered_extent to complete direct writes")
> Reported-by: syzbot <syzbot+5b82f0e951f8c2bcdb8f@syzkaller.appspotmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: syzbot <syzbot+5b82f0e951f8c2bcdb8f@syzkaller.appspotmail.com>

Added to misc-next, thanks.
