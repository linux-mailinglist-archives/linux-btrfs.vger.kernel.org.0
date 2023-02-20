Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF50C69D4F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 21:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjBTU0G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 15:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjBTU0F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 15:26:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4BE21A18
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 12:25:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 81791339B0;
        Mon, 20 Feb 2023 20:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676924700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=opnVP8FEuZJKgkPbGE3hfm2FyIVpnuvQtYdBWnx0Kvk=;
        b=KQ70AD/Ic4QuDaOt+kZtwiIxSCs0wQ5MCcsz6GXRQyAOsc5wnHLUYAlB2e1BI9mA/L9OAP
        GjOTeBTJHnFBufVdCw/E/ETd0mfWurBr6Lnz0Yh1xUnWAdD7aZAvTWOzFChjBmW7pVr4Uu
        GdAmpwt82e+7kOeEXVaIhTzy01kic7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676924700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=opnVP8FEuZJKgkPbGE3hfm2FyIVpnuvQtYdBWnx0Kvk=;
        b=HPUsjl+VVsXsajJ8aSwpVx3gUD7IaSE5CB8enGV/Bm05r1mA22t5iVTCAvijSZrspA2etY
        KbWoSZFn5H5N55AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52663139DB;
        Mon, 20 Feb 2023 20:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1GEfExzX82OsXAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Feb 2023 20:25:00 +0000
Date:   Mon, 20 Feb 2023 21:19:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move all btree initialization into
 btrfs_init_btree_inode
Message-ID: <20230220201905.GJ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230219181022.3499088-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219181022.3499088-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 19, 2023 at 07:10:22PM +0100, Christoph Hellwig wrote:
> Move the remaining code that deals with initializing the btree
> inode into btrfs_init_btree_inode instead of splitting it between
> that helpers and its only caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Added to misc-next, thanks.
