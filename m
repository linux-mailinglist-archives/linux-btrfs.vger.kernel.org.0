Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6663F5070FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351904AbiDSOv2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 10:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352596AbiDSOv0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 10:51:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F360F2DA98
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 07:48:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B116C1F74E;
        Tue, 19 Apr 2022 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650379722;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rEohyBkevudrobHaykU0yqj76SusiPKy+Aq6aQnIR9Y=;
        b=MENMuWDeIVQv6C85wYAvGhUU3f+8/MS5M9NFvbJ/Gam3K4TG1VrBr9PzzkVS6Eb5iJzzoq
        Y8y/BxVyVkBorvwHs19vwY7Dj15rVwpSrgJvnLo6CFtw4j9Uzmz3ISNxs4Un6wsnxFcyVV
        0lWUXjHfh8MSJ/PSgV181zEfdBZJWnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650379722;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rEohyBkevudrobHaykU0yqj76SusiPKy+Aq6aQnIR9Y=;
        b=fYsPn1hNw735cuqRGJGGkEfl/piYCkrMYJHcwLCKbsdsxV7ApHSjuBVXC7E/ceYl1SNLmF
        YBFImqNYGbTprdCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85EB2132E7;
        Tue, 19 Apr 2022 14:48:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aAH4H8rLXmK5KQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Apr 2022 14:48:42 +0000
Date:   Tue, 19 Apr 2022 16:44:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Subject: Re: [PATCH v3] btrfs: Turn delayed_nodes_tree into an XArray
Message-ID: <20220419144439.GE2348@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gabriel Niebler <gniebler@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <20220414101054.15230-1-gniebler@suse.com>
 <d108b994-3583-e794-d14e-f07e4cc3d91a@suse.com>
 <17646325-5f22-9d5d-a507-813e23c4ff5c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17646325-5f22-9d5d-a507-813e23c4ff5c@suse.com>
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

On Tue, Apr 19, 2022 at 11:03:12AM +0200, Gabriel Niebler wrote:
> > nit: This could be turned into a return just because if someone's 
> > reading the code seeing the return would be an
> > instant "let's forget this function" rather than having to scan 
> > downwards to see if anything special
> > is going on after the loop's body.
> 
> You're right! I think I just kept the old logic here w/o thinking about 
> it, but doing a return is exactly equivalent and quicker to understand, 
> as you point out.
> 
> (It's funny: There are people who are very dogmatic about the idea that 
> "a function should only ever have a single return statement!". I'm *not* 
> one of them, but I've worked with such people and perhaps the attitude 
> has rubbed off on me - subconciously even. Maybe it's a Python thing - 
> is this thinking ever found in the C/kernel development space?)

We've settled on pattern regarding return statements that's somewhere in
between. If a function has some sort of quick setup/quick check sequence
that does not need any cleanup then the return follows. Once there are
loops, long function body, undo/cleanup functions then it's the goto
pattern. And there are exceptions eg. for short functions with loops
where the code flow is obvious.
