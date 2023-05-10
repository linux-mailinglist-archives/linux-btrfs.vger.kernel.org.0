Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87DE6FE651
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 23:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbjEJV3g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 17:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjEJV3e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 17:29:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842562716
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 14:29:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 223F121991;
        Wed, 10 May 2023 21:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683754170;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUBc/IZpLYH0gc896jEt5iZT7d8VWPvcccpFW21/H14=;
        b=PUQzjlpVVmATe3kLMmsB8AtcnjhdEMNx3sNIE4oodLGjPpdVRVN9clk6PpzM8+2KBA78Ek
        u+LjT1S63qAnHOSo1FRMu/7N60O0NhcjPNe5Aqe/EtlyLnSAxpd4mwufWAR3BeV/UArF5Z
        7YzZZjPIBnKIbc/apizg4LCvS9lvVSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683754170;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUBc/IZpLYH0gc896jEt5iZT7d8VWPvcccpFW21/H14=;
        b=+0LbiqJzSj6QUC11LV1UNyjFbJeP54wntpYhv9iFgObHUtSFVFaQJk5/lnU8R1vx/ydf2I
        VSu8HzxJeKGSeGCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1A74138E5;
        Wed, 10 May 2023 21:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ghNYOrkMXGRAdAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 10 May 2023 21:29:29 +0000
Date:   Wed, 10 May 2023 23:23:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: receive: output the parent subvolume uuid
 if it can not be found
Message-ID: <20230510212330.GW32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2aaffadeec6e3e6b03365e1bb20fd0e102801cf9.1682211774.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aaffadeec6e3e6b03365e1bb20fd0e102801cf9.1682211774.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 23, 2023 at 09:03:42AM +0800, Qu Wenruo wrote:
> It's a known problem that a received subvolume would lose its UUID after
> switching to RW.
> Thus it can lead to later receive problems for snapshotting and cloning.
> 
> In that case, we just output a simple error message liks:
> 
>   ERROR: cannot find parent subvolume
> 
> Or
> 
>   ERROR: clone: did not find source subvol
> 
> Normally we need to use "btrfs receive --dump" to know what the missing
> subvolume UUID is, which would cost extra time communicating.
> 
> This patch would:
> 
> - Add extra subvolumd UUID output
> - Unify the error messages to the same format
> 
> Now the error messages would look like:
> 
>   ERROR: snapshot: cannot find parent subvolume 1b4e28ba-2fa1-11d2-883f-b9a761bde3fb
>   ERROR: clone: cannot find source subvolume 1b4e28ba-2fa1-11d2-883f-b9a761bde3fb
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
