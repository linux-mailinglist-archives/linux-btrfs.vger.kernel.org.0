Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35716ACD66
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Mar 2023 20:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCFTBG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Mar 2023 14:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCFTBE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Mar 2023 14:01:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EEA83CF
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Mar 2023 11:00:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 46F041FDE4;
        Mon,  6 Mar 2023 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678129185;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZcqpZjFDYR2EtSv7BBvPf8zmUFvUrleWpXUKvyMSGrc=;
        b=uVk/rRJCpeIUJGeunJ67lVZNpJH8Bw7h6G/xyM9ycYc2tHLYPiBheLtBpLmPem2IqQs4RL
        O7MCcm0qcffUhsP31c7cspqjDk12b/rQGSmLR4JseSiHZu0c7ibTnOSuXXwbgWznJvnxvc
        AUkMAqGUaE+nzET3DdgZw+BGWkBpncg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678129185;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZcqpZjFDYR2EtSv7BBvPf8zmUFvUrleWpXUKvyMSGrc=;
        b=VSPN2dYspZN3qFZYcGZAXfMMmp72evXAuqwU6YEaee+MhT9Sh+scotVTfmdS0Zrex2W0+Y
        70zPAGbqIsI6zUCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FC2A13A66;
        Mon,  6 Mar 2023 18:59:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZDRpAiE4BmS7IwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Mar 2023 18:59:45 +0000
Date:   Mon, 6 Mar 2023 19:53:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid repetitive define
 BTRFS_FEATURE_INCOMPAT_SUPP
Message-ID: <20230306185342.GE10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ab23cf2ea306080a7d2be5e67bd22b6f7a9105d7.1678091761.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab23cf2ea306080a7d2be5e67bd22b6f7a9105d7.1678091761.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 06, 2023 at 09:28:09PM +0800, Anand Jain wrote:
> BTRFS_FEATURE_INCOMPAT_SUPP is defined twice, once under
> CONFIG_BTRFS_DEBUG and once without it, resulting in repetitive code. The
> reason for this is to add experimental features under CONFIG_BTRFS_DEBUG.
> 
> To avoid repetitive code, add a common list BTRFS_FEATURE_INCOMPAT_SUPP_STABLE,
> and append experimental features only under CONFIG_BTRFS_DEBUG.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
> ---
> Also,
> Would it be advisable to add a new Kconfig define labeled as EXPERIMENTAL?
> I don't believe it is, since if no new features are introduced, removing
> the Kconfig would not be a viable option.

I don't think we need another config option for that, that it's required
to have debug should be sufficient. Each config option increases the
number of possible configurations.  In case some experimental feature
would be too intrusive even for the debug build then we could add a
separate one.
