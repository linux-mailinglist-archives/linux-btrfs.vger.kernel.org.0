Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35DF714B2B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 15:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjE2N4W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 09:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjE2N4F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 09:56:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582FB10F8
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 06:55:20 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4604F21AA0;
        Mon, 29 May 2023 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685368449;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chOVlblAAthZBXKQ8hTDf0UISS9EU7JqImvjY9Tx4aY=;
        b=w2+s9x9T2dOpebSPZY9avmTXJI+tBexUvpklDugAVtMxx5v9vekvOxiMMvx9u9YAnlO/W1
        X7QoPrEdzI+XPMB8+MzmT0Bnua3wdxIpiOcVmeOYR8NC/e4oZp++YacfVVOotDiv3JmG4c
        o5chnBxJ57TLKb68QHWBUNAeCjbo0Bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685368449;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chOVlblAAthZBXKQ8hTDf0UISS9EU7JqImvjY9Tx4aY=;
        b=PxfQEA06surbRTi4b1PrY/PyZNocLCehhnyirVEJ9aAl2eMXFi1+1GfvbQmJEi77D9QWn1
        vUe3PI0dfIW0bQCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1FDE513508;
        Mon, 29 May 2023 13:54:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id OnD1BoGudGS4ZwAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Mon, 29 May 2023 13:54:09 +0000
Date:   Mon, 29 May 2023 15:47:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: please fold some fix into misc-next(btrfs: print assertion
 failure report and stack trace from the same line)
Message-ID: <20230529134758.GF575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230528060227.AF10.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528060227.AF10.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 28, 2023 at 06:02:28AM +0800, Wang Yugui wrote:
> Hi,
> 
> please fold some fix into misc-next(btrfs: print assertion failure report and stack trace from the same line).
> 
> Because 'btrfs_assertfail' become macro(inline), we should drop it from objtools.
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index f937be1afe65..060032cfb046 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -170,7 +170,6 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
>  		"__reiserfs_panic",
>  		"__stack_chk_fail",
>  		"__ubsan_handle_builtin_unreachable",
> -		"btrfs_assertfail",

If this is not in objtool, does it produce any warning? I'm not sure if
I want to do the change in the same patch and last time I checked
objtool was fine with the listed function not existing.

>  		"cpu_bringup_and_idle",
>  		"cpu_startup_entry",
>  		"do_exit",
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/05/28
> 
