Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C522675D0E
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 19:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjATSu5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 13:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATSu4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 13:50:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB74D658D
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 10:50:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7DD57337C7;
        Fri, 20 Jan 2023 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674240654;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h0KCIrQtrr2VJsQpolQAjspN3cdcTwo4NwE5Dwfsz2M=;
        b=KBGRWyVBLtzGIVQc5HfU1ZaKev54zvAcV67gJrdz3EgXrpnbpLEuPhr0bIt+QdCqCyqS7F
        cfTl0sX5Pyn/oYguyq/XRHjhaf/pPbJ+5pd2Db7K1Txmsqqbm2ROuWuwMdCZJFWyCvK8mN
        FLJS+2fNF4Eavb0aqREu+Kmqa8JR2j4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674240654;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h0KCIrQtrr2VJsQpolQAjspN3cdcTwo4NwE5Dwfsz2M=;
        b=IFV3w9flwhUkUG76K1mt8ymihaYhSmHRhK+0GF1wJDzPg5CN2BZ2EwPp9P+y7HlDOk4IrC
        oPkN8x/BPTtW7bAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60938139C2;
        Fri, 20 Jan 2023 18:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9Tn5FY7iymOMbQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 20 Jan 2023 18:50:54 +0000
Date:   Fri, 20 Jan 2023 19:45:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/18] btrfs: some optimizations for send
Message-ID: <20230120184514.GM11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1673436276.git.fdmanana@suse.com>
 <cover.1674157020.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674157020.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 19, 2023 at 07:39:12PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This adds some optimizations for send and some cleanups, mostly around
> processing directories. Some of the cleanups are independent.
> 
> More details in the individual changelogs, and the last one contains
> results for a performance test.

The improvements are awesome, thanks.

> 
> V2: Dropped the patch that added the use of MT_FLAGS_LOCK_EXTERN,
>     it turns out it does not work how I expected it to, see:
>     https://lore.kernel.org/linux-btrfs/20230119151929.GA29005@lst.de/

Patches updated in misc-next.
