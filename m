Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4387F58026B
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 18:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbiGYQHG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 12:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiGYQHF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 12:07:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9F4266D;
        Mon, 25 Jul 2022 09:07:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB01C1FE30;
        Mon, 25 Jul 2022 16:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658765222;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j2rdihiE/N0eDGx4EBeUKYn5OpjSdkVwi6MAi9vthxo=;
        b=S1q/IZUGtir2dybfQ/018iuJ3eJmRvGVTWt+5U/6qT/eTtbN8iyGDPPBv20U1ypXFT2NYp
        Z17V4LbBLdoY1um/Jxjyw3XGnfVUdOmc0QU9YPfK4ENDBtKH3zp/5sL4cHms1XjDJhi5v2
        ZeUZm436zFJdEPvXE151w7TO0MqUPXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658765222;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j2rdihiE/N0eDGx4EBeUKYn5OpjSdkVwi6MAi9vthxo=;
        b=PW+kC87BBah3uorpW2Cir7Zu6Nw0eqk9HzkM/KX3MTbAwlmaT6WnVX3Tq2EhNhmRLCwhF4
        UNnJ7F1RGc+hjIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC5AA13ABB;
        Mon, 25 Jul 2022 16:07:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sQAQKaa/3mL5QwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Jul 2022 16:07:02 +0000
Date:   Mon, 25 Jul 2022 18:02:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix unused variable in load_free_space_cache()
Message-ID: <20220725160205.GA13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nathan Chancellor <nathan@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220722163854.1189931-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722163854.1189931-1-nathan@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 22, 2022 at 09:38:54AM -0700, Nathan Chancellor wrote:
> When CONFIG_LOCKDEP is unset, there is a warning about the mapping
> variable being unused:
> 
>   fs/btrfs/free-space-cache.c:929:24: warning: variable 'mapping' set but not used [-Wunused-but-set-variable]
>           struct address_space *mapping;
>                                 ^
>   1 warning generated.
> 
> lockdep_set_class() does not do anything with the first parameter to the
> macro when CONFIG_LOCKDEP is not set so just eliminate the mapping
> variable and use inode instead, which is always used in the function.
> 
> Fixes: 22d85ab1af7d ("btrfs: Change the lockdep class of struct inode's invalidate_lock")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1672
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Folded to the patch, thanks.
