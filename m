Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C004BBDB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 17:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbiBRQm0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 11:42:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiBRQmZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 11:42:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB671A0C09
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 08:42:09 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E31931F37F;
        Fri, 18 Feb 2022 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645202527;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tO+I2oSdWiLc3shnP7oB5AUy47vcnoxhns0WLJDwhKg=;
        b=Wmk8VxQPvwD/u81/o3BhnHwgeJtd6pxVlHc64AhOhQGQCarnv9HxgHJJMqH7uvlGoOQfvH
        b6mZgFA2eDdW3lcqJRdITgQDL6FGbwXguuziw0Hpk2tiML40yOUB0uokOin9cX1fSfZA3h
        z5JlbAiJwa5aEeJbUh9c2jDvEJ9xNIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645202527;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tO+I2oSdWiLc3shnP7oB5AUy47vcnoxhns0WLJDwhKg=;
        b=3ymdu9oZEmSYk9UV2O7B14Z4XA0HMbdFwfguwZoCNNqqv+1hAvNBY9jcz+r4KLp6tMrxCP
        Q0TYIhkA2tjeTvBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DC708A3B8B;
        Fri, 18 Feb 2022 16:42:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3AA63DA829; Fri, 18 Feb 2022 17:38:22 +0100 (CET)
Date:   Fri, 18 Feb 2022 17:38:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/8] Fix error handling on data bio submission
Message-ID: <20220218163822.GB12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1645196493.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645196493.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 18, 2022 at 10:03:21AM -0500, Josef Bacik wrote:
> v1->v2:
> - addressed the various comments, expanded on the comment about NODATASUM and
>   the DATA_RELOC inode since I had to look up why we even had that there.
> - Added the various reviewed-by's on the patches I didn't touch.
> 
> --- Original email ---
> 
> Internally we tried to enable a remediation to automatically re-provision
> machines that had checksum errors.  This was based on dmesg scanning, however we
> discovered that we were getting transienty csum error messages.  This came down
> to getting a transient ENOMEM while trying to lookup checksums while doing a
> data read (this was on memory constrained containers).
> 
> What we were doing was simply acting like there wasn't a checksum there, which
> would print a scary message about missing checksums.  And then we'd do the read,
> but because we didn't have a checksum we'd complain about a checksum mismatch.
> Neither of these things were actually what was happening, we simply got an EIO
> while looking up the checksums.
> 
> Fix this by properly returning an error and erroring out the BIO with the
> correct error.  This is actually correct, it allows us to skip the IO and also
> not erroneously tell the user that their checksums are invalid.
> 
> While testing this fix however I uncovered a variety of problems with our error
> handling when we submit.  So the first two patches are to fix the main problem I
> wanted to fix, and the next 6 are to fix problems that happen when injecting
> errors into the checksum lookup path.
> 
> With these patches I'm no longer getting csum mismatch errors when I fail to
> lookup csums, and I'm also able to survive a xfstests run while randomly
> injecting errors into this path.  Thanks,
> 
> Josef
> 
> Josef Bacik (8):
>   btrfs: make search_csum_tree return 0 if we get -EFBIG
>   btrfs: handle csum lookup errors properly on reads
>   btrfs: check correct bio in finish_compressed_bio_read
>   btrfs: remove the bio argument from finish_compressed_bio_read
>   btrfs: track compressed bio errors as blk_status_t
>   btrfs: do not double complete bio on errors during compressed reads
>   btrfs: do not try to repair bio that has no mirror set
>   btrfs: do not clean up repair bio if submit fails

Added to misc-next, thanks.
