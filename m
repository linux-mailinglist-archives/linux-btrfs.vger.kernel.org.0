Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3191754F9F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383109AbiFQPQL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 11:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383088AbiFQPQK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 11:16:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F453CFFB
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 08:16:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C873221B49;
        Fri, 17 Jun 2022 15:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655478968;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7BrJsrS59VRPDG7NPkr8MsEFTzC+6IaTQxQMxzbdZxg=;
        b=nCsmzJtakGDENDvrWT+tz2wdS+wO7qt/nin5XUYFHAMysvjUL21aqq40QDVFLEWqRWIVnY
        Y/HBuOFyi3ILKVk4Tm3g4TdkUsJvuOwWcd9UoZ62I/Qb9Yjh1TcDQrypzI3I9WvZJjTe/F
        mWbP8HzswyrpdXAwjPWnMjcsND+cAkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655478968;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7BrJsrS59VRPDG7NPkr8MsEFTzC+6IaTQxQMxzbdZxg=;
        b=ZTRr/5VziKZA26g2hxj46V6CVFO5AarHHr0j5HgYXLNPearNrb+UwBeizF3PaJGdyc742y
        TlVheG4gK5X9N2Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD8841348E;
        Fri, 17 Jun 2022 15:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dpl4KbiarGLoQwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 17 Jun 2022 15:16:08 +0000
Date:   Fri, 17 Jun 2022 17:11:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: Batch up release of reserved metadata for
 delayed items used for deletion
Message-ID: <20220617151133.GO20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220617125334.1067259-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617125334.1067259-1-nborisov@suse.com>
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

On Fri, Jun 17, 2022 at 03:53:34PM +0300, Nikolay Borisov wrote:
> With Filipe's recent rework of the delayed inode code one aspect which
> isn't batched is the release of the reserved metadata of delayed inode's
> delete items. With this patch on top of Filipe's rework and running the
> same test as provided in the description of a patch titled
> "btrfs: improve batch deletion of delayed dir index items" I observe
> the following change of the number of calls to btrfs_block_rsv_release:
> 
> Before this change:
> @block_rsv_release: 1004
> @btrfs_delete_delayed_items_total_time: 14602
> @delete_batches: 505
> 
> After:
> @block_rsv_release: 510
> @btrfs_delete_delayed_items_total_time: 13643
> @delete_batches: 507
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
