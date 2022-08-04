Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2CF589FE3
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 19:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiHDRaU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 13:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiHDRaS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 13:30:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA6C19C28
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 10:30:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 14EC11F904;
        Thu,  4 Aug 2022 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659634215;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hIfYP6eJeVB72NSioAIY6ZwB1rD3X90IsmvamIxHmOY=;
        b=WI6VnnV1fX43vYzXkz7CE62Ci0ggKgByQEaJIs6jPT2iIUdBOvTuHKN6DGtmgpV+nWXsqp
        1fc4NCUDZW7qIKm8Rbyk5ZzcX/k0JjNX4eRT44ISFmw2ELMNZio6BexCntVO1R/ksSEmgK
        K80K2oN6NQJcldhp6Y4b8G76wuBrq9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659634215;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hIfYP6eJeVB72NSioAIY6ZwB1rD3X90IsmvamIxHmOY=;
        b=gdV05/Opb61Rx3JuKnIzynCDvrig5ji/NTX9a955LpzB56o6gc+7SD1CNC1RuL1Mqo5oaU
        VCikM/JQzfCtUYDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3CA913A94;
        Thu,  4 Aug 2022 17:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XYmaNiYC7GIzQAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 04 Aug 2022 17:30:14 +0000
Date:   Thu, 4 Aug 2022 19:25:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/9] btrfs: block group cleanups
Message-ID: <20220804172511.GW13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1657914198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657914198.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 15, 2022 at 03:45:20PM -0400, Josef Bacik wrote:
> v1->v2:
> - I'm an idiot and didn't rebase properly, so adding the two other cleanups I
>   had that I didn't send.
> - Rebased onto a recent misc-next and fixed the compile errors.
> - Realized that with the new zoned patches that caused the compile error that
>   btrfs_update_space_info needed to be cleaned up, so added patches for that.
> 
> --- Original email ---
> 
> I'm reworking our relocation and delete unused block group workqueues which
> require some cleanups of how we deal with flags on the block group.  We've had a
> bit field for various flags on the block group for a while, but there's a subtle
> gotcha with this bitfield in that you have to protect every modification with
> bg->lock in order to not mess with the values, and there were a few places that
> we weren't holding the lock.
> 
> Rework these to be normal flags, and then go behind this conversion and cleanup
> some of the usage of the different flags.  Additionally there's a cleanup around
> when to break out of the background workers.  Thanks,
> 
> Josef
> 
> Josef Bacik (9):
>   btrfs: use btrfs_fs_closing for background bg work
>   btrfs: simplify btrfs_update_space_info
>   btrfs: handle space_info setting of bg in btrfs_add_bg_to_space_info
>   btrfs: convert block group bit field to use bit helpers
>   btrfs: remove block_group->lock protection for TO_COPY
>   btrfs: simplify btrfs_put_block_group_cache
>   btrfs: remove BLOCK_GROUP_FLAG_HAS_CACHING_CTL
>   btrfs: remove bg->lock protection for relocation repair flag
>   btrfs: delete btrfs_wait_space_cache_v1_finished

Good cleanups, added to misc-next, thanks.
