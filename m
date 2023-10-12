Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535177C730A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 18:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379594AbjJLQcO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379171AbjJLQcL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 12:32:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BC2CA
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 09:32:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ABD3D21883;
        Thu, 12 Oct 2023 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697128328;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OlnjhyZ7Ij+scgajAS3KDUkeCriyxIZO/yVHw39OhW8=;
        b=naNrDuGaODnWMaSQdv8eF/hMYjCiFYYLj9M0jmKFJ12y1F1++6wQP7Ey9HkiFA379szjt6
        rOWB0XEaj658xI7EpBYAoaDu1sZDDEgC6tmOtZbRMGwOA7nlOq3V+aNbbK4aGN9cP2M4yk
        EuYgDTjj36NNncWLs698BpvhpNIMrUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697128328;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OlnjhyZ7Ij+scgajAS3KDUkeCriyxIZO/yVHw39OhW8=;
        b=1uHAYyssA8Uxl5Uncnigdkz3UxynMP4qhA376kAnLWEmPL1/SP7/8g16QvxUZiKMUrRo9i
        25BjymqbF4K78lDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 825C0139ED;
        Thu, 12 Oct 2023 16:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1/wOH4gfKGVLVAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 12 Oct 2023 16:32:08 +0000
Date:   Thu, 12 Oct 2023 18:25:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: zoned: check existence of SB zone, not
 LBA
Message-ID: <20231012162521.GJ2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1697104952.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697104952.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWO(0.00)[2];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[42.36%]
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 12, 2023 at 11:19:28PM +0900, Naohiro Aota wrote:
> Running btrfs check can fail on a certain zoned decice setup (e.g,
> zone size = 128MB, device size = 16GB):
> 
> (from generic/330)
> yes|/usr/local/bin/btrfs check --repair --force /dev/nullb1
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> ERROR: zoned: failed to read zone info of 4096 and 4097: Invalid argument
> ERROR: failed to write super block for devid 1: write error: Input/output error
> failed to write new super block err -5
> failed to repair damaged filesystem, aborting
> 
> This happens because write_dev_supers() is comparing the original
> superblock location vs the device size to check if it can write out a
> superblock copy or not.
> 
> For the above example, since the first copy location (64MB) < device size
> (16GB), it tries to write out the copy. But, the copy must be written into
> zone 4096 (512G / zone size (128M) = 4096), which is out of the device.

I've added the text above to changelog of patch 2 as it's relevant for
the change.

> To address the issue, this series introduces check_sb_location() to check
> if a SB copy can be written out.
> 
> The patch 1 is a preparation to factor out logic of converting the original
> superblock location to SB log writing superblock zone. And, the second one
> implements check_sb_location() to write_dev_supers().
> 
> Naohiro Aota (2):
>   btrfs-progs: zoned: introduce sb_bytenr_to_sb_zone()
>   btrfs-progs: zoned: check SB zone existence properly

Added to devel, thanks.
