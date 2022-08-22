Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F2559BF2C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiHVMCI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 08:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiHVMCH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 08:02:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B222DA83
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 05:02:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19F0D344ED;
        Mon, 22 Aug 2022 12:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661169723;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+FnxzNbftSUSFX2upl+4Rx9qbpxZq0KE0laQDUGyDpU=;
        b=vL7oB3s/zuTN9WuV16UOFkGG/FdX+X05YJ3XhAe4OcG5iDS8Os0RhVunsR1g2IaSmwMURO
        vPFnV+nk78nbQ+jIntBlGQV6U8SKyfBKmUbVdjz/wBMKKtVp0enTz2+qdrsu2tFRZWSViw
        up4mox7b0pC4aRTtnL4+HAuVOC9AJAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661169723;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+FnxzNbftSUSFX2upl+4Rx9qbpxZq0KE0laQDUGyDpU=;
        b=1sHNs22D5z9V1nnGoloVqw0ST4sLSdV6Yn3T0sAAAFGmCnBsj5W8Tto+JF2JblOOL+vYaY
        hOKDwgEUn8GArtDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDF1513523;
        Mon, 22 Aug 2022 12:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jTZBNTpwA2NePgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 Aug 2022 12:02:02 +0000
Date:   Mon, 22 Aug 2022 13:56:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     ethanlien <ethanlien@synology.com>
Cc:     linux-btrfs@vger.kernel.org, cunankimo@gmail.com
Subject: Re: [PATCH v2] btrfs: remove unnecessary EXTENT_UPTODATE state in
 buffered I/O path
Message-ID: <20220822115649.GS13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, ethanlien <ethanlien@synology.com>,
        linux-btrfs@vger.kernel.org, cunankimo@gmail.com
References: <20220819024408.9714-1-ethanlien@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819024408.9714-1-ethanlien@synology.com>
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

On Fri, Aug 19, 2022 at 10:44:08AM +0800, ethanlien wrote:
> From: Ethan Lien <ethanlien@synology.com>
> 
> After we copied data to page cache in buffered I/O, we
> 1. Insert a EXTENT_UPTODATE state into inode's io_tree, by
>    endio_readpage_release_extent(), set_extent_delalloc() or
>    set_extent_defrag().
> 2. Set page uptodate before we unlock the page.
> 
> But the only place we check io_tree's EXTENT_UPTODATE state is in
> btrfs_do_readpage(). We know we enter btrfs_do_readpage() only when we
> have a non-uptodate page, so it is unnecessary to set EXTENT_UPTODATE.
> 
> For example, when performing a buffered random read:
> 
> 	fio --rw=randread --ioengine=libaio --direct=0 --numjobs=4 \
> 		--filesize=32G --size=4G --bs=4k --name=job \
> 		--filename=/mnt/file --name=job
> 
> Then check how many extent_state in io_tree:
> 
> 	cat /proc/slabinfo | grep btrfs_extent_state | awk '{print $2}'
> 
> w/o this patch, we got 640567 btrfs_extent_state.
> w/  this patch, we got    204 btrfs_extent_state.
> 
> Maintaining such a big tree brings overhead since every I/O needs to insert
> EXTENT_LOCKED, insert EXTENT_UPTODATE, then remove EXTENT_LOCKED. And in
> every insert or remove, we need to lock io_tree, do tree search, alloc or
> dealloc extent states. By removing unnecessary EXTENT_UPTODATE, we keep
> io_tree in a minimal size and reduce overhead when performing buffered I/O.
> 
> Signed-off-by: Ethan Lien <ethanlien@synology.com>
> Reviewed-by: Robbie Ko <robbieko@synology.com>
> ---
> 
> V2: Remove set_extent_uptodate() from btrfs_get_extent(), and when we found
>     a inline extent, set page uptodate in btrfs_do_readpage().

Added to misc-next, thanks.
