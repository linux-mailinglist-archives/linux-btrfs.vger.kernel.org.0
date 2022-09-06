Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3175AF05B
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 18:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiIFQ05 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 12:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiIFQ0i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 12:26:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D0AA6C1F
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 08:56:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52E1E33939;
        Tue,  6 Sep 2022 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662479803;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WdNONZ6JYgSOyf83i5KxJxbKmH2UFUmYlSyiJ+TczUw=;
        b=KBMZLJE83xmg7LnsLIbgaZ7t+7eIkdDUTQXwp01L9pNEtKKkjl82KTgcCM7h/BMOOt1iUz
        q+gBrqr0UhtAEQk1I4KBw31UCaTQeaV01g+p1BujZkQRHjFvGLW7h/amLcOAkmVVo7W5bX
        ugfYhOIQ9yehKuDNFcN5EAlxlywAZrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662479803;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WdNONZ6JYgSOyf83i5KxJxbKmH2UFUmYlSyiJ+TczUw=;
        b=V5t76I5gKCbmUAgZ3jSVvlTy2M67zMGpFlkEAZiOhyMymJ5Mx6GYhVOYh88q7i0Prx9sXu
        VDiPNJKY+9Y7nQBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3823613A19;
        Tue,  6 Sep 2022 15:56:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WCTLDLttF2NeKQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Sep 2022 15:56:43 +0000
Date:   Tue, 6 Sep 2022 17:51:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix API misuse of zone finish waiting
Message-ID: <20220906155120.GO13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7f579ef2f4d4ab38577bd9768f4e38ac4d00fc48.1661921714.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f579ef2f4d4ab38577bd9768f4e38ac4d00fc48.1661921714.git.naohiro.aota@wdc.com>
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

On Wed, Aug 31, 2022 at 01:55:48PM +0900, Naohiro Aota wrote:
> The commit 2ce543f47843 ("btrfs: zoned: wait until zone is finished when
> allocation didn't progress") implemented a zone finish waiting mechanism to
> the write path of zoned mode. However, using wait_var_event()/wake_up_all()
> on fs_info->zone_finish_wait is wrong and wait_var_event() just hangs
> because no one ever wakes it up once it goes into sleep.
> 
> Indeed, we can simply use wait_on_bit_io() and clear_and_wake_up_bit() on
> fs_info->flags with a proper barrier installed.
> 
> Fixes: 2ce543f47843 ("btrfs: zoned: wait until zone is finished when allocation didn't progress")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.
