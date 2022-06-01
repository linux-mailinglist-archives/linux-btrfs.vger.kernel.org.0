Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2A153A5C3
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 15:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350825AbiFANQh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 09:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348085AbiFANQg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 09:16:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F6C3CFDC
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 06:16:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 58C1421AB0;
        Wed,  1 Jun 2022 13:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654089394;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w/zkStjuZkAUz1S12pmhWFyYWZK3NyhsdyIXqVW3+Tc=;
        b=atUxeZKZmbvwrjIf/X7tQYxJ+d/WqP6rRGeJ3uPem/Yg41SKruZb9cHMJCS+fHEDrs3I2m
        d+e9OJTidZIUrCsp9oKraEJLQp/qqog/7DVm1dRucyOa9ytZ91Rcyzav3UCjykWtAIMe1n
        8ACsF8WRzQkFn9x0ca91nXQlcCbsCq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654089394;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w/zkStjuZkAUz1S12pmhWFyYWZK3NyhsdyIXqVW3+Tc=;
        b=ce4FRlG55+mZWMq72tc/3AwAu80/566/KFEMkp36FJGKCp+dCh0HdpjqwJSiAw+0TQbJcF
        CapVoYKpK9qk8FBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BDD21330F;
        Wed,  1 Jun 2022 13:16:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uuicDbJml2I3bAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Jun 2022 13:16:34 +0000
Date:   Wed, 1 Jun 2022 15:12:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: raid56: reduce unnecessary parity writes
Message-ID: <20220601131208.GL20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1654048515.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1654048515.git.wqu@suse.com>
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

On Wed, Jun 01, 2022 at 09:59:05AM +0800, Qu Wenruo wrote:
> [Changelog]
> v2:
> - Cleanup the data bitmap after all the IO of the full stripe finished
>   This is to ensure a cached rbio will not put its old dbitmap for
>   the next one whoe uses the cache.
>   (only for the last patch)

Patch in misc-next updated, thanks. I've also checked the other patches
just in case but there was only one hunk adding bitmap_clear to
rbio_orig_end_io.
