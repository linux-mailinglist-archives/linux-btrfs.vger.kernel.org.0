Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EA175A0D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 23:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGSV4H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 17:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGSV4D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 17:56:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278A71FD9
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 14:56:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C31D522292;
        Wed, 19 Jul 2023 21:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689803760;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Tr0/HEznzdqcMSzDLWttinlvI8+FTe+f24h0kpq5f4=;
        b=YZcjYxQKv5goFdueWyd/fD0qjx/h2+TZRqqn0NZkFA8EtZEYjV94Eb6vT5iPlvJK0Mx4KX
        GUd+QNr6kNx+pdg/YWrs3etZo5fR7blVp1LDFalj9B+O9EMlsEEL2ruYYD26tE8og02C+r
        HhVNh3CEMLW5uhaIwudXXsB+7WLLloA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689803760;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Tr0/HEznzdqcMSzDLWttinlvI8+FTe+f24h0kpq5f4=;
        b=T0fi7M+nMzDOq50PK7zsa5wzUdZDYKaQF+qrgu1SUrJfZa478sQa/1Fi8bECZesPUy/FnB
        0NXKK85JG+HQ4CAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 949FF13460;
        Wed, 19 Jul 2023 21:56:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ctRWIvBbuGTXHAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 19 Jul 2023 21:56:00 +0000
Date:   Wed, 19 Jul 2023 23:49:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/8] btrfs: preparation patches for the incoming
 metadata folio conversion
Message-ID: <20230719214920.GS20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689418958.git.wqu@suse.com>
 <20230718160108.GQ20457@twin.jikos.cz>
 <cd0ab358-9b77-24c1-264b-76ac2351a205@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd0ab358-9b77-24c1-264b-76ac2351a205@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 19, 2023 at 06:51:18AM +0800, Qu Wenruo wrote:
> On 2023/7/19 00:01, David Sterba wrote:
> > On Sat, Jul 15, 2023 at 07:08:26PM +0800, Qu Wenruo wrote:
> >> [CHANGELOG]
> >> v2:
> >> - Define write_extent_buffer_fsid/chunk_tree_uuid() as inline helpers
> >>
> >> v3:
> >> - Fix an undefined behavior bug in memcpy_extent_buffer()
> >>    Unlike the name, memcpy_extent_buffer() needs to handle overlapping
> >>    ranges, thus it calls copy_pages() which do overlap checks and switch
> >>    to memmove() when needed.
> >>
> >>    Here we introduce __write_extent_buffer() which allows us to switch
> >>    to go memmove() if needed.
> >>
> >> - Also refactor memmove_extent_buffer()
> >>    Since we have __write_extent_buffer() which can go memmove(), it's
> >>    not hard to refactor memmove_extent_buffer().
> >>
> >>    But there is still a pitfall that we have to handle double page
> >>    boundaries as the old behavior, explained in the last patch.
> >>
> >> - Add selftests on extent buffer memory operations
> >>    I have failed too many times refactoring memmove_extent_buffer(), the
> >>    wasted time should be a memorial for my stupidity.
> >
> > Seems that v3 has proceeded up to btrfs/143 that prints a lot test
> > output errors and following tests fails too. It's on top of misc-next so
> > it could be caused by some other recent patch. I'll do another round, if
> > this patchset turns out to be ok I'll add it to misc-next.
> 
> btrfs/143 has a known (?) regression that dm devices are not properly
> cleaned up, causing all later tests to fail (as scratch device is taken
> by the dm device, all later mkfs would fail).
> 
> I notice that is fixed recently in upstream for-next branch, you may
> want to update/rebase your fstests.

That's quite possible, thanks. I've updated the VMs and restarted tests,
we'll see.
