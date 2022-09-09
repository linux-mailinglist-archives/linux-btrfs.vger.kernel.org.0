Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1B25B3BBD
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 17:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiIIPW5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 11:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiIIPW4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 11:22:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247BB13F6A
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 08:22:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA09D22339;
        Fri,  9 Sep 2022 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662736974;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0S7f9Bbo3d3X68tJwbpKeV5ODdW8uUTc5sm5ZwUeAmY=;
        b=Ilc8tt6RkB01DGnRENs0HFCHK6XoLpQew/hRIyBg2+ebx1VQV7EtkTvad5fHsH7/e2sL7I
        EEbNFwpIu/27rPBsDBsddpyvki5wLGlhjtVuXsRMuxfjgrNVj/ZPrkhibBHclTbR9W2ikK
        PvGwmQro1wZRH+Y/BQ3SMBTo0WyxDz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662736974;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0S7f9Bbo3d3X68tJwbpKeV5ODdW8uUTc5sm5ZwUeAmY=;
        b=2BPN6aASRCo4XBLWu5YbjUMyHFDND5fCmkxCaZT/I1bmd+L/5bnoVWfsfG8EmoxJgFvKXO
        5W0YJ3nF1nShU9AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FC8E139D5;
        Fri,  9 Sep 2022 15:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7QUWJk5aG2OwbwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 09 Sep 2022 15:22:54 +0000
Date:   Fri, 9 Sep 2022 17:17:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: zoned: wait extent buffer IOs before finishing
 a zone
Message-ID: <20220909151730.GD32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3c6d8c45b61b6977f3bb2e5f8534ca844e291d90.1662706550.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c6d8c45b61b6977f3bb2e5f8534ca844e291d90.1662706550.git.naohiro.aota@wdc.com>
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

On Fri, Sep 09, 2022 at 03:59:55PM +0900, Naohiro Aota wrote:
> Before sending REQ_OP_ZONE_FINISH to a zone, we need to ensure that ongoing
> IOs already finished. Or, we will see a "Zone Is Full" error for the IOs,
> as the ZONE_FINISH command makes the zone full.
> 
> We ensure that with btrfs_wait_block_group_reservations() and
> btrfs_wait_ordered_roots() for a data block group. And, for a metadata
> block group, the comparison of alloc_offset vs meta_write_pointer mostly
> ensures IOs for the allocated region already sent. However, there still can
> be a little time-frame where the IOs are sent but not yet completed.
> 
> Introduce wait_eb_writebacks() to ensure such IOs are completed for a
> metadata block group. It walks the buffer_radix to find extent buffers in
> the block group and wait_on_extent_buffer_writeback() on them.
> 
> Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
> CC: stable@vger.kernel.org # 5.19+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
> v2: Added __rcu mark to fix build warning.
>     https://lore.kernel.org/linux-btrfs/202209080826.AuNlP9ys-lkp@intel.com/

It should go to -rc6 but I'd appreciate a review, until then it'll be in
for-next. Thanks.
