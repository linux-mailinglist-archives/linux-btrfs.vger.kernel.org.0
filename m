Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9AE673836
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 13:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjASMTo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 07:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjASMTN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 07:19:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C57C6EAB
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 04:19:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD92921D10;
        Thu, 19 Jan 2023 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674130749;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6RuMqRkG2Q+B7Z7lEROy/yme3AK7nNRzZOCg4v1Nv8w=;
        b=u/fLiH1xujv1Ik6g/CFiMwRMEM3VwrmZ21fhellnGPJNRElILHLTCBtefkzekTkLpEt2k8
        8TnvJ83eJJf4Xg2lbG8/YOVCJct7VNdrEe3FouTURjL/xBnyVfCiROy+Gu/Jy0Vz0cyraA
        E8NWG50wJL2enXKzD9D++Sv0uHKhuKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674130749;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6RuMqRkG2Q+B7Z7lEROy/yme3AK7nNRzZOCg4v1Nv8w=;
        b=M+SAIQRbHjE5UEcQF8iuX4WgZpa5i8oSoXdjEv0qAmJ8y72VEYvdC3pqCgkFQDwkJnZKbD
        FhP68NZY2rHTb0Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5CFA139ED;
        Thu, 19 Jan 2023 12:19:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0hCCJz01yWOxWgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 19 Jan 2023 12:19:09 +0000
Date:   Thu, 19 Jan 2023 13:13:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: split extent_buffer handling into a separate file
Message-ID: <20230119121330.GI11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230118175127.296872-1-hch@lst.de>
 <ea62d04c-61db-fbe6-6c51-c0acad5e868e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea62d04c-61db-fbe6-6c51-c0acad5e868e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 19, 2023 at 08:46:07AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/1/19 01:51, Christoph Hellwig wrote:
> > The code dealing with the extent_buffer structure for file system
> > metadata shares very little logic with the rest of extent_io.c that
> > deals with data I/O.  Split it into a separate file.
> 
> Pure code move is fine.
> 
> And I agree the extent buffer read/write path is indeed better separated 
> out.
> 
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   fs/btrfs/Makefile        |    2 +-
> >   fs/btrfs/extent_buffer.c | 2632 +++++++++++++++++++++++
> >   fs/btrfs/extent_io.c     | 4347 ++++++++------------------------------
> >   fs/btrfs/extent_io.h     |   41 +
> >   4 files changed, 3524 insertions(+), 3498 deletions(-)
> 
> But the chages itself is a little too large for a single patch.
> 
> Is there any better practice on such code move?
> Or it's just unavoidable?

There was one attempt to factor out extent_buffer and I have basically
the same answer as before, see https://lore.kernel.org/linux-btrfs/20190927154244.GX2751@twin.jikos.cz/

And with the recent experience of large code movement the backporting
has become more tedious, people have complaned and it's becoming harder
for me to evaluate new patches for stable as well.

So the plan is to batch code movement to a single release and given that
we've done that in 6.2 the next stop is somewhere at 6.6 if not later.
Incremental refactoring can be done but "3524 insertions(+), 3498
deletions(-)" is out of proportion.
