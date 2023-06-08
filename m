Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784BB727F7F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 13:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbjFHL5L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 07:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjFHL5K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 07:57:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAE92103
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 04:57:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A05CB21A43;
        Thu,  8 Jun 2023 11:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686225427;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVJTq3W6XdlQm5TLNBZN/In5RWNV9OXS4rTKDjHa/Xk=;
        b=cf294edjEVNf39Oi5mKc0qWOa2s6gQak35RrUnFnvjTOKLEiaecCgxGK7Ey1j/pD212Rpd
        tHlcF0Zk7BNmXYrtXE8YlfSQLUFIIfSrLV4ImFEQUl8XY4Q6/3tTwFTsni5fCZFIpuaXBg
        oFeObBaAXuYvCUX7W5Yfqv4zeMiT+hE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686225427;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVJTq3W6XdlQm5TLNBZN/In5RWNV9OXS4rTKDjHa/Xk=;
        b=eDQtbAghPPwyVFfYW8ZWvLh/2++T6fCpsLg4qzi+nSVZAprVbFOWF71gWKsXm97/yfNpaY
        TU4BBPlPt4cMnACQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 491F4138E6;
        Thu,  8 Jun 2023 11:57:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3rvJEBPCgWTAMgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 08 Jun 2023 11:57:07 +0000
Date:   Thu, 8 Jun 2023 13:50:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naota@elisp.net>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 0/4] btrfs: fixes for reclaim
Message-ID: <20230608115051.GB28933@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1686028197.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686028197.git.naohiro.aota@wdc.com>
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

On Tue, Jun 06, 2023 at 02:36:32PM +0900, Naohiro Aota wrote:
> There are several issues on the reclaim process out there:
> 
>  - Long-running reclaim process blocks removing unused BGs
>  - Belonging to the reclaim list blocks it goes to the unused list
>  - It tries relocation even when FS is read-only
>  - Temporal failure keep a block group un-reclaimed
> 
> This series fixes them.
> 
> Naohiro Aota (4):
>   btrfs: delete unused BGs while reclaiming BGs
>   btrfs: move out now unused BG from the reclaim list
>   btrfs: bail out reclaim process if filesystem is read-only
>   btrfs: reinsert BGs failed to reclaim

Added to misc-next, with the fixups, thanks.
