Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D94A66E227
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jan 2023 16:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjAQP3F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Jan 2023 10:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjAQP2j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Jan 2023 10:28:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9382212B
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 07:28:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6ACD9387F9;
        Tue, 17 Jan 2023 15:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673969317;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jny8456ACj//FLLL7NFhq70h9Yo37GEnc4A+xcV/GRU=;
        b=AMAbElCsMVTp5Aby950ySSRcU00qGDxcWeu0mD5Q+3UmNA+H0/aXgS6bySKhyEoYUmN3Hi
        oRzydLcKT46IfRi8+7ECWkLozskh96Nr7CbRi50gKlBtpsox/0fa9O7tEFDt2PvSWhj5w6
        eD30vTo2NFYyiC4I9dJCkqzcuV5dn8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673969317;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jny8456ACj//FLLL7NFhq70h9Yo37GEnc4A+xcV/GRU=;
        b=6xOdJ+ZGr/1pbHZza5oQn3PyqO31hOPFAFizAMMj+ubHrV7xH2/aPxrDs9Rr543NsIfCp/
        2EvAgpHBU58xv9Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40F211390C;
        Tue, 17 Jan 2023 15:28:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hG3ZDqW+xmPTTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 Jan 2023 15:28:37 +0000
Date:   Tue, 17 Jan 2023 16:22:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check: enhance the error output for backref
 mimsatch
Message-ID: <20230117152259.GA11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1ecdbc90c7cc26f7f5b7a0af7683cf81717b6200.1670220414.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ecdbc90c7cc26f7f5b7a0af7683cf81717b6200.1670220414.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 05, 2022 at 02:07:30PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> Btrfs check original mode output is not that reader friendly already, it
> even includes pointer output:
> 
>   backref 15353727729664 parent 1140559929556992 not referenced back 0xc9133d70
>   tree backref 15353727729664 parent 14660022714368 not found in extent tree
>   incorrect global backref count on 15353727729664 found 3 wanted 2
>   backpointer mismatch on [15353727729664 16384]
> 
> In above case, the "0xc9133d70" is completely useless, as it's a pointer
> for the tree_backref structure.
> 
> And the term "backref" is quite abused in above case.
> 
> [ENHANCEMENT]
> To enhance the situation, let's use some output format from lowmem mode
> instead.
> 
> Now above example will be changed to:
> 
>   tree extent[15353727729664, 16384] parent 1140559929556992 has no tree block found
>   tree extent[15353727729664, 16384] parent 14660022714368 has no backref item in extent tree
>   incorrect global backref count on 15353727729664 found 3 wanted 2
>   backpointer mismatch on [15353727729664 16384]
> 
> And some example for data backrefs:
> 
>   data extent[12845056, 1048576] bytenr mimsmatch, extent item bytenr 12845056 file item bytenr 0
>   data extent[12845056, 1048576] referencer count mismatch (root 5 owner 257 offset 0) wanted 1 have 0
> 
>   data extent[14233600, 12288] referencer count mismatch (parent 42139648) wanted 0 have 1
>   data extent[14233600, 12288] referencer count mismatch (root 5 owner 307 offset 0) wanted 0 have 1
>   data extent[14233600, 12288] referencer count mismatch (parent 30507008) wanted 0 have 1
> 
> Furthermore, the original function print_tree_backref_error() is a mess
> already, here we clean it up by exacting all the error output into a
> dedicated helper, print_backref_error(), so the function itself only
> need to find out errors.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
