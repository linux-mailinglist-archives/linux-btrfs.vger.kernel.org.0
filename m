Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5046C27BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 03:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCUCEY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 22:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCUCEW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 22:04:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5216E88
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 19:04:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02420219EA;
        Tue, 21 Mar 2023 02:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679364257;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FEQy1Ij9RFzNY03cqIU8rzM1J0uug7QG1FBJkMFNUoc=;
        b=i09GAd5AVNN6Dtnrnf66cID43A50y7zGKrueahbUmQ0ibHVuSgBFteQrzQPYeEcYWkc15b
        5deMG97jjn09ZlI7gDVA9wuUT3Sr+z3zDDCQVvpUOGvZ797mUPHwFwXZtnzDfkkakKDoD9
        KbKqnaTdo5agplQhjKdUni4gYVY5dzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679364257;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FEQy1Ij9RFzNY03cqIU8rzM1J0uug7QG1FBJkMFNUoc=;
        b=uV4ZfRdKN5mhzZ9D72u4JDWBaVyN7ipPwhPI4NgWdJV5ThAJF2/+06TsWcpm/Wpcj05buP
        yxOQYQDvQD1EkzBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D094A13451;
        Tue, 21 Mar 2023 02:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UgK4MaAQGWR+cAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Mar 2023 02:04:16 +0000
Date:   Tue, 21 Mar 2023 02:58:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: sync ioctl from kernel
Message-ID: <20230321015807.GP10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4fbc61d726ee1830d3e24313b7bf6f8a763951a1.1679098064.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fbc61d726ee1830d3e24313b7bf6f8a763951a1.1679098064.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 18, 2023 at 08:07:50AM +0800, Qu Wenruo wrote:
> This sync is mostly for the new member, btrfs_ioctl_dev_info_args::fsid.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
