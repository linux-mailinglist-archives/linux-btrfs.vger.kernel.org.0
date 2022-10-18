Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B6602DDD
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiJROEy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJROEX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:04:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73065F85
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:04:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4232D207EF;
        Tue, 18 Oct 2022 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666101860;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rNjupSfSkbDFLegIi9H1gE6xRh2cCeHpJfLtFa6piVc=;
        b=0Ll62nUM7LXq74vnar1gRpFFxuundIkpBQ8dpelquK4BZ1o0OWvKSkRGfO0auoUjhKy48u
        MywXD244SA5TgSlzSeMXD67eqL2ikjWnJ8SLc8c+QX1GXRFNJtxmpT9dmpDHD8DIMwukLQ
        jViPLnKw93H0henYlY+QS6hTzg1dq9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666101860;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rNjupSfSkbDFLegIi9H1gE6xRh2cCeHpJfLtFa6piVc=;
        b=xtYDz8GS345T/Q2LrJyF4XIR2IDtlFe0t4UArI+aeTuTW4EUNp7gEzDVliLbA0wT9zYYuT
        rdx7ao7+kBkYI5CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19C8313480;
        Tue, 18 Oct 2022 14:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 61coBWSyTmPCMQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Oct 2022 14:04:20 +0000
Date:   Tue, 18 Oct 2022 16:04:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: print-tree: follow the supported flags when
 printing flags
Message-ID: <20221018140410.GZ13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <37ed8ecbbc23d66955faf5b944be153db38e1dd7.1665487509.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ed8ecbbc23d66955faf5b944be153db38e1dd7.1665487509.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 11, 2022 at 07:25:12PM +0800, Qu Wenruo wrote:
> Currently we put EXTENT_TREE_V2 incompat flag entry under EXPERIMENTAL
> features, thus at compile time, incompat_flags_array[] is determined at
> compile time.
> 
> But the truth is, we have @supported_flags for __print_readable_flag(),
> which is already defined based on EXPERIMENTAL flag.
> 
> Thus for __print_readable_flag(), we can always include the entry for
> EXTENT_TREE_V2, and only print the flag if it's in the @supported_flags
> 
> By this, we can remove one EXPERIMENTAL macro usage.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
> @@ -1731,7 +1729,7 @@ static void __print_readable_flag(u64 flag, struct readable_flag_entry *array,
>  	printf("\t\t\t( ");
>  	for (i = 0; i < array_size; i++) {
>  		entry = array + i;
> -		if (flag & entry->bit) {
> +		if (flag & supported_flags && flag & entry->bit) {

		if ((flag & supported_flags) && (flag & entry->bit)) {
