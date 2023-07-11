Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA6574F99F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 23:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjGKVQk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 17:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGKVQj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 17:16:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA901709
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 14:16:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F023122633;
        Tue, 11 Jul 2023 21:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689110196;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=61UZLSEjhsNtDych+VIdeA3Oj7I5EBPGiyizteZW0cs=;
        b=t75+6QR5vTndWoHqEgyqyyCRqAGa6IOW+ABRS8o5siT9S2KMJ6sS83JhOVARtJcFBwk+JR
        gJ/S4tT502yDNkfsgpRVnPDV2GABA3KrRmIl6qISD4GqUb76EQC7DVT6MVlT0aDadqTuWv
        CyJQmlxh0ywUM/t//BrjOLoMIoBR6LQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689110196;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=61UZLSEjhsNtDych+VIdeA3Oj7I5EBPGiyizteZW0cs=;
        b=Iu3LXXm5HtWLxecZkONPmI1qIYshiBPc21+fV76wE3iEL11q7JFWj15+r9NtB4qDtQJ+4X
        IF1XJYV6UmGiBWDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9F381391C;
        Tue, 11 Jul 2023 21:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MbeFMLTGrWTMNAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Jul 2023 21:16:36 +0000
Date:   Tue, 11 Jul 2023 23:10:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: move subpage preallocation out of the loop
Message-ID: <20230711211001.GH30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0b506e836b9e614b02263014282495626f950052.1688886476.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b506e836b9e614b02263014282495626f950052.1688886476.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 09, 2023 at 03:08:18PM +0800, Qu Wenruo wrote:
> Initially we preallocate btrfs_subpage structure in the main loop of
> alloc_extent_buffer().
> 
> But later commit fbca46eb46ec ("btrfs: make nodesize >= PAGE_SIZE case
> to reuse the non-subpage routine") has make sure we only go subpage
> routine if our nodesize is smaller than PAGE_SIZE.
> 
> This means for that case, we only need to allocate the subpage structure
> once anyway.
> 
> So this patch would make the preallocation out of the main loop.
> 
> This would slightly reduce the workload when we hold the page lock, and
> make code a little easier to read.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix a possible (not that possible though) memory leak
>   If find_or_create_page() failed (which calls with GFP_NOFAIL), we
>   still need to release the preallocated memory.

Added to misc-next, thanks.
