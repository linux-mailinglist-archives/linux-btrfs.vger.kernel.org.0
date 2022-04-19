Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09AF507AED
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 22:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346279AbiDSUaB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 16:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243543AbiDSU37 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 16:29:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92D536E32
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 13:27:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7057B1F74E;
        Tue, 19 Apr 2022 20:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650400034;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kq5aSnrto3mFbfJcP+CeZ4e1GOLSD+1R+HOJRQgphq4=;
        b=zw5U8bKYoQ7B34jvh8jsMkxvNImGWoYG8Ee8EW0lG58raf4QDndlviU/ZuuMp6naa1qyIV
        nM1azX5NFuRdLxUQvSRjyuVqCoHDflbLEwFI6EPSID40qXXxS7MRn1LSIzLujZhequWFeE
        L8EBLJPNCxqcFhpYUxjpYTVyDasfEOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650400034;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kq5aSnrto3mFbfJcP+CeZ4e1GOLSD+1R+HOJRQgphq4=;
        b=XCJi1R7XDsV53aNJUezqeh5Vgp5VOcMI3HuHKSxWs05jHSwlsgT+34sAJHVlmmalsO6xML
        hS0axnOkINSWOzDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DFF1139BE;
        Tue, 19 Apr 2022 20:27:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xLgeEiIbX2ICIwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Apr 2022 20:27:14 +0000
Date:   Tue, 19 Apr 2022 22:23:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Subject: Re: [PATCH v5] btrfs: Turn delayed_nodes_tree into an XArray
Message-ID: <20220419202310.GA1513@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Roman Mamedov <rm@romanrm.net>,
        Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <20220419155721.6702-1-gniebler@suse.com>
 <20220419210551.65db356b@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419210551.65db356b@nvm>
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

On Tue, Apr 19, 2022 at 09:05:51PM +0500, Roman Mamedov wrote:
> On Tue, 19 Apr 2022 17:57:21 +0200
> Gabriel Niebler <gniebler@suse.com> wrote:
> 
> > -	btrfs_init_delayed_node(node, root, ino);
> > +        do {
> 
> The "do" line appears one character off to the right for me, and upon
> examination that's because it uses spaces for indentation instead of TABs like
> all other lines. Did not check if this is the only place.

Thanks for catching it, git am did not complain about that so I checked
it manually, there was one more place, now fixed in my local copy.
