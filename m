Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402456F5E58
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 20:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjECSn6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 14:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjECSnf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 14:43:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B027EDA
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 11:41:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 28D2C20645;
        Wed,  3 May 2023 18:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683139261;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XSquAbtjkVsAGhk0rx5ZGF2yiJRi8M+jAQSE8NTCnRg=;
        b=pKA0Q20DYJI3KLgTnH0sdrmzPfjU/OBclkIDO4SccK9QJlz5Sdgsizri6MsBTM/HhsgD8j
        4lTEW7WWYeCXIV6Q9jBnd7+La+CZ83SzlsU+qUk3wH+xM2TilSmP2UFVNkGsCYU+lRgYEG
        ePfYtt/0FGQLzkYWl/L6BYdkIYi5ZaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683139261;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XSquAbtjkVsAGhk0rx5ZGF2yiJRi8M+jAQSE8NTCnRg=;
        b=niR3zuVPnWsprvjuTFSIMOHnwbPnM2cDBJj1TnBM2uTdHvR/kOvYqaSk0ApO7fHJJHvtCT
        wnlLA8lFS+BLOeAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04C141331F;
        Wed,  3 May 2023 18:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IYNcAL2qUmRFRwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 May 2023 18:41:01 +0000
Date:   Wed, 3 May 2023 20:35:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/7] btrfs-progs: libbtrfs: remove the support for fs
 without uuid tree
Message-ID: <20230503183505.GD6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1683093416.git.wqu@suse.com>
 <6e07c5dd154bc70f9f0a1f9c31cede88dd564bb3.1683093416.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e07c5dd154bc70f9f0a1f9c31cede88dd564bb3.1683093416.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 03, 2023 at 02:03:38PM +0800, Qu Wenruo wrote:
> Since kernel 3.12, any btrfs mounted by a kernel would have an UUID
> tree created, to record all the UUID of its subvolumes.
> 
> Without UUID tree, libbtrfs send functionality has to go through all the
> subvolumes seen so far, and record those subvolumes' UUID internally so
> that libbtrfs send can locate a desired subvolume.
> 
> Since commit 194b90aa2c5a ("btrfs-progs: libbtrfs: remove declarations
> without exports in send-utils") we're deprecating this old interface
> already, meaning deprecated users won't be able to build its own
> subvolume list already.
> 
> And we received no error report on this so far.
> 
> So let's finish the cleanup by removing the support for fs without an UUID
> tree.

This changes is the only one that worries me, I saw the potential to
remove the code in the past but was hesitant to do so to avoid further
breakage caused by libbtrfs changes.

However, I'd like to get rid of the code too so let's do it. With the
past experience of breaking some 3rd party tools I now at least know
what to test in advance. Debian code search did not find anything
relevant for the removed struct members .h, nor
BTRFS_COMPAT_SEND_NO_UUID_TREE so this is good.
