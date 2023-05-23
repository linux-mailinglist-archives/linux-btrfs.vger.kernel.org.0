Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD2470DAE8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjEWKxC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjEWKxB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:53:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239FDFF
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:53:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C479922946;
        Tue, 23 May 2023 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684839175;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2OnEnqXBVXX2AOFd2IlSMO5V4zqHze9nB978p8OETCw=;
        b=dlrPIf7DnA1KUVeByj3Mk0PUpbyDbvpA2ohJ1+ZjZTJQ2n7WoHmPP2RW0pTK+IzaRWwNQK
        ys9S9nJ8EEfXZPAW6AHq6vs/ruYyx0T6ecOC+iFdl2uXMNiCzUvMDmprPM7BeliVFFAdp3
        x++8+lwWbzsk8t86b94cFABQq69L+m4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684839175;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2OnEnqXBVXX2AOFd2IlSMO5V4zqHze9nB978p8OETCw=;
        b=BcApURM/OCq9NxqQIkg7dBTN3kFsFp1souOt+S7uhoBZowBnE7id1OJXQ4ur/Dj2WayBmB
        ZjBZXJNBVPRm1sAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC8E213A10;
        Tue, 23 May 2023 10:52:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9AZXKQebbGQ+fAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 May 2023 10:52:55 +0000
Date:   Tue, 23 May 2023 12:46:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: tune: fix the leftover csum change item
 and add a test case for it
Message-ID: <20230523104648.GW32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684802060.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684802060.git.wqu@suse.com>
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

On Tue, May 23, 2023 at 08:37:11AM +0800, Qu Wenruo wrote:
> David's cyclic csum change tests exposed a bug even with the latest csum
> change code, that I'm a total idiot and forgot to delete the csum change
> item.
> 
> This results a bug that if we have run multiple csum changes to the same
> target csum type (e.g. CRC32C->SHA256->CRC32C->SHA256), the second
> conversion to the same type would fail due to the left over csum change items.
> 
> This series would do the fix and add a test case to cover this bug.
> 
> Qu Wenruo (2):
>   btrfs-progs: tune: delete the csum change item after converting the fs
>   btrfs-progs: tests/misc: add a test case for csum change

Added to devel thanks, no more errors reported.
