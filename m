Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE8759ED41
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 22:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiHWUYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 16:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiHWUYd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 16:24:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B64ED4BC0;
        Tue, 23 Aug 2022 12:51:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BDEB1F8AC;
        Tue, 23 Aug 2022 19:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661284310;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2RCUwt1b+lcpY49aMgbRIAVLt9QpUtE7/soKWVObSPU=;
        b=P8H/rWXj/Zjoc0NMM0FOcZpRJmCIUAK9pBQhVCZnIXqukc5vzCdZF17heyMqwFMuGr+SXI
        FLOPEwDY7nfgXm6NlfGbBCibvgduB3rrOZcF4amzZsh/kjUnAqak3izLa/kwcAkgx7cIkm
        7Ly4lZJF1bDIhS15wFd7o71RAJy0854=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661284310;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2RCUwt1b+lcpY49aMgbRIAVLt9QpUtE7/soKWVObSPU=;
        b=pavdNYUSyduIZiGeGrOST6NK7MGuRB5eV27vIpkmfD/oUluWAdFQUVnrSI8/Razi8VV6AQ
        r6CRyPwWtRlwKpBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B80F13A89;
        Tue, 23 Aug 2022 19:51:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rnopBdYvBWMQeQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 Aug 2022 19:51:50 +0000
Date:   Tue, 23 Aug 2022 21:46:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't print information about space cache or tree
 every remount
Message-ID: <20220823194635.GM13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ca82edf897ae4cbd71277e76f43c6631ffd26b5a.1661268435.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca82edf897ae4cbd71277e76f43c6631ffd26b5a.1661268435.git.maciej.szmigiero@oracle.com>
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

On Tue, Aug 23, 2022 at 05:28:20PM +0200, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> btrfs currently prints information about space cache or free space tree
> being in use on every remount, regardless whether such remount actually
> enabled or disabled one of these features.
> 
> This is actually unnecessary since providing remount options changing the
> state of these features will explicitly print the appropriate notice.
> 
> Let's instead print such unconditional information just on an initial mount
> to avoid filling the kernel log when, for example, laptop-mode-tools
> remount the fs on some events.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Makes sense, added to misc-next, thanks.
