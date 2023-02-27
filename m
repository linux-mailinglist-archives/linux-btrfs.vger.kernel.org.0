Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F0D6A4D5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 22:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjB0Vhz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 16:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjB0Vhx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 16:37:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B72428841
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 13:37:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD80F21A27;
        Mon, 27 Feb 2023 21:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677533865;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFw4dvXqNZIuLaLL0yWyBW0ShAPoy4+ika+MO86DEi8=;
        b=buj7tawBFk6f5jc0E4Bw7qJk7rA7HaujkB8a3DnVRmitLn+8XA8mdAj3ILhS2PGFAmHx6L
        vhF+QJrEHkLj2+zhrrnZ1YijYtic7QPmxhHclf5B7rw3oRMDw3MHu+GfsfRJGnh7ZPCz4n
        fjK4ZX/tWA4c5cDmTm9mgHlWsET38jA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677533865;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFw4dvXqNZIuLaLL0yWyBW0ShAPoy4+ika+MO86DEi8=;
        b=N4RNyeu3CBFxtpJZDEBkP4GHhuDnl5Me2ZvHAShmE8fdi67rUEftvw/6o3lmStuOPVkS3x
        XOVmEGPm3Ds9abDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92E1013A43;
        Mon, 27 Feb 2023 21:37:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q6+NIqki/WOCQQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 27 Feb 2023 21:37:45 +0000
Date:   Mon, 27 Feb 2023 22:31:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        hch@infradead.org
Subject: Re: [PATCH v2] btrfs: sink calc_bio_boundaries into its only caller
Message-ID: <20230227213146.GK10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9c8a6815c5cfd36dbf2a45a80fea31c052bbb318.1676996243.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8a6815c5cfd36dbf2a45a80fea31c052bbb318.1676996243.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 08:21:04AM -0800, Johannes Thumshirn wrote:
> Nowadays calc_bio_boundaries() is a relatively simple function that only
> guarantees the one bio equals to one ordered extent rule for uncompressed
> Zone Append bios.
> 
> Sink it into it's only caller alloc_new_bio().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> 
> The resulting diff looks a bit ugly, but when applied the code looks
> sane again.

Yeah but in vimdiff it's clearly visible how the two functions get
merged.  Added to misc-next, thanks.
