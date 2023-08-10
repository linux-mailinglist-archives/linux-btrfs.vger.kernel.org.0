Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38B4778013
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 20:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjHJSPc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 14:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjHJSPb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 14:15:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C2C1703
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 11:15:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E33F21F74D;
        Thu, 10 Aug 2023 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691691329;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qbC4c992erTa/FwO/RQLo23krDrSes1cDS/AWbkOTNY=;
        b=Pd6dbHy5p9MrHkdGUsnMMIjQ3LCEWg6v+xpxdfbo3nlQXzCpB9Rctl+x6vNryO8+YsLkXX
        rCp3NoZ/yrML3gBApn44e4hV8oVUXLwH9hWAlNwd/Yka2S6r2yDBVlSbV6+6H5OdHkTgtq
        JJBlQtmopM23HfavmzaGsG+Bo7g/13k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691691329;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qbC4c992erTa/FwO/RQLo23krDrSes1cDS/AWbkOTNY=;
        b=CkWXup81Q/2tKbFghyX+wYkk1Hafd7UYiUllwY7X7eztLaWuDlaiLycG4pUxsMwh0T5piA
        fd0vWJm7xiGV4UAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C94F1138E2;
        Thu, 10 Aug 2023 18:15:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dr1aMEEp1WTMYwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Aug 2023 18:15:29 +0000
Date:   Thu, 10 Aug 2023 20:09:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] btrfs: scrub: improve the scrub performance
Message-ID: <20230810180905.GM2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1691044274.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691044274.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 03, 2023 at 02:33:28PM +0800, Qu Wenruo wrote:
> [REPO]
> https://github.com/adam900710/linux/tree/scrub_testing
> 
> [CHANGELOG]
> v2:
> - Fix a double accounting error in the last patch
>   scrub_stripe_report_errors() is called twice, thus doubling the
>   accounting.

I've added the series to for-next. Current plan is to get it to 6.5
eventually and then backport to 6.4. I need to review it more carefully
than last time the scrub rewrite got merged and also give it a test on
NVMe drives myself. Fallback plan is 6.6 and then do the backports.
We're approaching 6.5 final and even though it's a big regression I
don't want to introduce bugs given the remaining time to fix them.
