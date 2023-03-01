Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8405C6A73BA
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 19:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCASqt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 13:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCASqr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 13:46:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C1049890
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 10:46:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CDCDE1FE32;
        Wed,  1 Mar 2023 18:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677696404;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AlNmM6pRM02vr2EK7+DJhhvebTtavcsfV7V7YDD3gQY=;
        b=gNbOj0nYXc9uBUC6u5QkgpHLzfznhgrkwPCcUSH+D3rBr1KNv+hJ5wum+E9m/VUOnphzYK
        fGCFcg1pFRqdShkgpYCCjBqVEVp0C9cnWWFxbAoVGsD2zpvjVpWLjiyB5jgKhc8F+r9QtO
        IyGPMj3jAkqiFvrJw66qE1Is7YFPUPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677696404;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AlNmM6pRM02vr2EK7+DJhhvebTtavcsfV7V7YDD3gQY=;
        b=U7KWT9AA7Ql9lIofRWPP1q0PV6mHABg1M9ML2imo9jIWgizQInOdbkrNGou2TeQFTEu8ni
        0dPsUUF1iM8C3hBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2AD813A63;
        Wed,  1 Mar 2023 18:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z8e9JpSd/2M+SAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Mar 2023 18:46:44 +0000
Date:   Wed, 1 Mar 2023 19:40:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: open_ctree() error handling cleanup
Message-ID: <20230301184044.GX10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3a0a3e3ff11bf19afdf600b4ae42f49acd71c9e3.1677545065.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0a3e3ff11bf19afdf600b4ae42f49acd71c9e3.1677545065.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 28, 2023 at 08:44:30AM +0800, Qu Wenruo wrote:
> Currently open_ctree() uses two variables for error handling, @err and
> @ret.
> 
> This is already causing problems in the latest misc-next once, and it is
> already causing more hidden problems.

Side note, information like this is not for the changelog, you may note
it under the "--" marker but from the long term POV it's irrelevant. A
reference to "latest misc-next" is meaningful now and may leave some traces
only in the mailing list. Right now is already obsolete because the bug was
fixed. The reason for this patch is to change it to less error prone style.

> This patch will fix the problems by:
> 
> - Use only @ret for error handling
> 
> - Add proper @ret assigning
>   Originally we rely on the default value (-EINVAL) of @err to handle
>   errors, but that doesn't really reflects the error.
>   This will change it use the correct error number for the following
>   call sites:
>   * subpage_info allocation
>   * btrfs_free_extra_devids()
>   * btrfs_check_rw_degradable()
>   * cleaner_kthread allocation
>   * transaction_kthread allocation
> 
> - Add an extra ASSERT()
>   To make sure we error out instead of returning 0.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
