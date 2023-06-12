Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE4D72C390
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 13:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjFLL7T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 07:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjFLL7S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 07:59:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8057BC0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 04:59:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0B9982195F;
        Mon, 12 Jun 2023 11:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686571153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UqkUHJ7uOJU+uMP5oyP+T+iS2swBhGhTuG62yI2sAic=;
        b=Plagji6KvP6Zag5/pAjYlciS3z0+XuIGHGA3lZYb/ZK1Qoo3LASS+/uB/c2GTdFFccg/m9
        u8/0cuGlQZwV6UAW8lEwhslKGm+ewLZsJ6Y42CPlCknEXk/8u8hSyyQbnW2w4MkGC58vyY
        kwTnZqNORdDb5NklM3xIi53MLIPgANk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686571153;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UqkUHJ7uOJU+uMP5oyP+T+iS2swBhGhTuG62yI2sAic=;
        b=dv58KtsyDgJDjplaswYKIWHK+x3DRyClC5ksESN7GA1+RqWSi5KHg7mmq5OHW7+5xOeXJ9
        j09QE/WqGEqbEiCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF6781357F;
        Mon, 12 Jun 2023 11:59:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0yaGHpAIh2TiVgAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Mon, 12 Jun 2023 11:59:12 +0000
Date:   Mon, 12 Jun 2023 06:59:44 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: check if page is extent locked early during
 release
Message-ID: <yf4fdeluhw4qdyk55p6gmh4f4ahhumtuadf6odhhjykxbniiho@cf3jndtmczed>
References: <sw3jkfih2ztq4jsjwmkfu3mh7msqvbfripxael24krfp3ablgw@tqwogynwdix6>
 <CAL3q7H51jrPGPPFs6YrsonEd2BOnHSjEfwzDBOi5oYStxT-BbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H51jrPGPPFs6YrsonEd2BOnHSjEfwzDBOi5oYStxT-BbQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14:46 09/06, Filipe Manana wrote:
> On Fri, Jun 9, 2023 at 2:36 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> >
> > While performing release, check for locking is the last step performed
> > in try_release_extent_state(). This happens after finding the em and
> > decoupling the em from the page. try_release_extent_mapping() also
> > checks if extents are locked.
> >
> > During memory pressure, it is better to return early if btrfs cannot
> > release a page and skip all the extent mapping finding and decoupling.
> > Check if page is locked in try_release_extent_mapping() before starting
> > extent map resolution. If locked, return immediately with zero (cannot
> > free page).
> 
> That is better if the most common case is having the range of the page
> currently locked in the inode io tree.
> Otherwise it's not better, we are doing one more search in the io tree
> than before, and the io trees can get pretty big sometimes.
> 
> Last time I checked, several years ago for a different optimization,
> most of the time, by far, the page's range is not currently locked.
> When it was currently locked, it accounted for something like 1% or 2%
> of the cases, and it mostly corresponded to the case where
> writeback just finished and btrfs_finished_ordered_io() is running and
> has already locked the range.
> 
> Have you made some analysis and found the case where the page's range
> is already locked to be the most common case?
> I doubt things changed radically to make it the most common case.
> 
> Do you have details of a workload that gains anything from this
> change, or benchmark results?
> 

So, this happens with lock inversion + iomap code. A memory pressure
keeps increasing until oom and further investigation reveals something
to do with page not being freed.

If required I will include the patch in the series. So, this can be
ignored for now.

-- 
Goldwyn
