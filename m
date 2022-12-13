Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB0864AD34
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 02:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiLMBjd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 20:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiLMBjO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 20:39:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6071D65E;
        Mon, 12 Dec 2022 17:39:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E59B11F8D4;
        Tue, 13 Dec 2022 01:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670895550;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cajLCajPaDc8CWLPffOGHxb5630iyhqgwcYX5YPINOA=;
        b=WH4S6e9kfgpWLG43MvlTV3SAWD2h8cyKe3eCR0AZr3lQNQ5gn/sM8O0eFEjWZBnsJIqr9n
        I2YDDMtYLDR6PQdkKVo72yJLqVN+AV3dKgRPnTM54LR36CDra0YSN/41cnH5UkzuptCBjl
        pkXOwAO1DD04+kJGdHmClwX2xATxPX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670895550;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cajLCajPaDc8CWLPffOGHxb5630iyhqgwcYX5YPINOA=;
        b=OcDNNoreGwlKc0rIIsxqLkzoQ2dT2ZRQJeyQuyGcuR1a9ZIGjhD7jHyvPoPtCiGMr/AbzK
        UzXYKh7R00BvA9BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B044613456;
        Tue, 13 Dec 2022 01:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fxgCKr7Xl2P3cQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 13 Dec 2022 01:39:10 +0000
Date:   Tue, 13 Dec 2022 02:38:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 6.2 (updated merge log)
Message-ID: <20221213013829.GD5824@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1670873892.git.dsterba@suse.com>
 <09d56e5a-0e11-ca60-785a-7f06aedf1932@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09d56e5a-0e11-ca60-785a-7f06aedf1932@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 13, 2022 at 08:09:29AM +0800, Qu Wenruo wrote:
> > - raid56 reliability vs performance trade off
> >    - fix destructive RMW for raid5 data (raid6 still needs work) - do full RMW
> >      cycle for writes and verify all checksums before overwrite, this should
> >      prevent rewriting potentially corrupted data without notice
> 
> Unfortunately, the "RMW" term seems abused.

I used is as a shortcut but it's probably confusing, thanks for the
suggested updates.

> >    - stripes are cached in memory which should reduce the performance impact but
> >      still can hurt some workloads
> 
> The cache behavior is not changed in this big chunk of raid56 work, but 
> commit f6065f8edeb2 ("btrfs: raid56: don't trust any cached sector in 
> __raid56_parity_recover()") is still the main thing affecting recovery path.
> 
> Thus although we didn't change the cache policy, it will still be bad 
> for recovery cases (missing device, or some sector has mimsatch csum).

Yeah, there's no change but I felt it should be mentioned together with
the RMW as it'll be used more than before.

Linus, below is the complete merge log with the edits.

---
User visible features:

- raid56 reliability vs performance trade off
  - fix destructive RMW for raid5 data (raid6 still needs work) - do full
    checksum verification for all data during RMW cycle, this should prevent
    rewriting potentially corrupted data without notice
  - stripes are cached in memory which should reduce the performance impact but
    still can hurt some workloads
  - checksums are verified after repair again
  - this is the last option without introducing additional features (write
    intent bitmap, journal, another tree), the extra checksum read/verification
    was supposed to be avoided by the original implementation exactly for
    performance reasons but that caused all the reliability problems

- discard=async by default for devices that support it

- implement emergency flush reserve to avoid almost all unnecessary transaction
  aborts due to ENOSPC in cases where there are too many delayed refs or
  delayed allocation

- skip block group synchronization if there's no change in used bytes, can
  reduce transaction commit count for some workloads

Performance improvements:

- fiemap and lseek
  - overall speedup due to skipping unnecessary or duplicate searches (-40% run time)
  - cache some data structures and sharedness of extents (-30% run time)

- send
  - faster backref resolution when finding clones
  - cached leaf to root mapping for faster backref walking
  - improved clone/sharing detection
  - overall run time improvements (-70%)

Core:

- module initialization converted to a table of function pointers run in a
  sequence

- preparation for fscrypt, extend passing file names across calls, dir item can
  store encryption status

- raid56 updates
  - more accurate error tracking of sectors within stripe
  - simplify recovery path and remove dedicated endio worker kthread
  - simplify scrub call paths
  - refactoring to support the extra data checksum verification during RMW
    cycle

- tree block parentness checks consolidated and done at metadata read time

- improved error handling

- cleanups
  - move a lot of code for better synchronization between kernel and user space
    sources, split big files
  - enum cleanups
  - GFP flag cleanups
  - header file cleanups, prototypes, dependencies
  - redundant parameter cleanups
  - inline extent handling simplifications
  - inode parameter conversion
  - data structure cleanups, reductions, renames, merges
