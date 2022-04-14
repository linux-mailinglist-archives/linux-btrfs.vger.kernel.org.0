Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE1F50188F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 18:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiDNQPq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 12:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350972AbiDNQE3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 12:04:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0DAF1ACC
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 08:47:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 624691F747;
        Thu, 14 Apr 2022 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649951269;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hOiuKLfbnMIt1KlqSlKhs2vInj0XEwQGE4Ez+op7AJo=;
        b=uCVRwAq6JNzF4/rlisppyYwSFQgH5nL6F59slhGDntF1+siXlkUwQhm3Mqe9EyaOR8qRef
        Q63a2u9FyXPAvVMHcZFnTSsgtXOLUi0Y/aZvO6FKz8m5MiZmPeQ6SrPjhzkCH8Y6Y67rce
        yk1tljsTEnlw44SSesO1cFKaom/j2yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649951269;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hOiuKLfbnMIt1KlqSlKhs2vInj0XEwQGE4Ez+op7AJo=;
        b=srg00ZFmkj0bClljRwOOYndlHycYe4lwt/HU2gdIGiU643gplmxcLcx3/t9+dKWay/hJ9i
        kkTb/tP5S0M/IODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 350CA132C0;
        Thu, 14 Apr 2022 15:47:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iA8NDCVCWGI+eQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Apr 2022 15:47:49 +0000
Date:   Thu, 14 Apr 2022 17:43:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 07/17] btrfs: make rbio_add_io_page() subpage
 compatible
Message-ID: <20220414154341.GP15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1649753690.git.wqu@suse.com>
 <d2873b5f3a00e9bb966150b4dd0253f4db107c12.1649753690.git.wqu@suse.com>
 <20220413191456.GN15609@twin.jikos.cz>
 <5b296828-65fb-b684-dedc-6f018e5ece4e@gmx.com>
 <5b190bf5-892c-0856-e623-f6f716985b28@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b190bf5-892c-0856-e623-f6f716985b28@gmx.com>
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

On Thu, Apr 14, 2022 at 08:43:45AM +0800, Qu Wenruo wrote:
> > Failed to reproduce here, both x86_64 and aarch64 survived over 64 loops
> > of btrfs/023.
> > 
> > Although that's withy my github branch. Let me check the current branch
> > to see what's wrong.
> 
> It's a rebase error.
> 
> At least one patch has incorrect diff snippet.

Ok, my bad, I did not do a finall diff check, I'll update the patchset.

> Mind to provide a branch for me to rebase my patchse upon?

It was is for-next I guess you found it already.
