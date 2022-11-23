Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85417636428
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 16:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbiKWPlf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 10:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbiKWPlQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 10:41:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6696CC604E;
        Wed, 23 Nov 2022 07:41:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FF5921CA3;
        Wed, 23 Nov 2022 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669218062;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Tkv/wUeovm+g785WU68pgukgNkdG4W+ZcAq+o65074=;
        b=dN3EJ5oO1SiF3WT2Oh5BsZnhUv13vFKpqL4nZ0NYFIWwbiQWqsfX2ca5smn+mANuHCoykQ
        MGS0l7CoiQPYLPhSfqN75xdF4t6ir7HnL6SxSb7P0IA76g7+vAqnAjxzi27v+sU6Bh8/i2
        u8Wyhhc0lKVaBqofPkkBWVTY53cOu8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669218062;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Tkv/wUeovm+g785WU68pgukgNkdG4W+ZcAq+o65074=;
        b=Gdysfd9jN51jI6epNGlV38lUKkYjOijSs0oWuGbzm45qDbx2bmJ2nDYL83RMApqBIPGZtb
        8eU9J5t/eM85cgDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE7AB13A37;
        Wed, 23 Nov 2022 15:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4hljNQ0/fmN/RQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 23 Nov 2022 15:41:01 +0000
Date:   Wed, 23 Nov 2022 16:40:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     void0red <void0red@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, eriri <1527030098@qq.com>
Subject: Re: [PATCH] btrfs: avoid use-after-free when return the error code
Message-ID: <20221123154031.GL5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221123143945.2666-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123143945.2666-1-void0red@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 23, 2022 at 10:39:45PM +0800, void0red wrote:
> free_extent_map(em) will free em->map_lookup, so it is
> wrong to use it when return.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216721
> Signed-off-by: void0red <void0red@gmail.com>
> Reported-by: eriri <1527030098@qq.com>

Added to misc-next with updated changelog, thanks.
