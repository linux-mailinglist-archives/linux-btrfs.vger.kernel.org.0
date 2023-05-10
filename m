Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B436FE2F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 19:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbjEJRD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 13:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbjEJRDZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 13:03:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4398132
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 10:03:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1D5431F8AC;
        Wed, 10 May 2023 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683738185;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=brmMaLkzWJd2mgFAyt7MfNuRGxsMf/A+F3nNUumZmdc=;
        b=V632Qk2a7IINRewVg1RNYGijlPkzWtYN8e2qcA/lJXaWPK0RgpEmmMMu0Z48IhbOgz4h5x
        UJ7Yc3ZVd/RrQSCrIonAmoBFz/mliIwjEBpsMyVEgi9dC5CM1iGAmOb9H0/txSliX29W8n
        f1r4EjxXLgY3PvjA2P+qUlf8Nsk6bEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683738185;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=brmMaLkzWJd2mgFAyt7MfNuRGxsMf/A+F3nNUumZmdc=;
        b=8jysrXTxWItMgaYHyhdn6e3D4/+GOzNnnukbB615WmOB9XxOiltDt4zX5/UwJnSiz6ODDm
        QQ15+ZaHa99td7AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEB27138E5;
        Wed, 10 May 2023 17:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T2ScOUjOW2QwAwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 10 May 2023 17:03:04 +0000
Date:   Wed, 10 May 2023 18:57:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 3/9] btrfs: track original extent subvol in a new inline
 ref
Message-ID: <20230510165705.GV32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1683075170.git.boris@bur.io>
 <7a4b78e240d2f26eb3d7be82d4c0b8ddaa409519.1683075170.git.boris@bur.io>
 <c10a17cb-506a-2540-eb19-c79c6c00f788@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10a17cb-506a-2540-eb19-c79c6c00f788@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 03, 2023 at 11:17:12AM +0800, Qu Wenruo wrote:
> On 2023/5/3 08:59, Boris Burkov wrote:
> > In order to implement simple quota groups, we need to be able to
> > associate a data extent with the subvolume that created it. Once you
> > account for reflink, this information cannot be recovered without
> > explicitly storing it. Options for storing it are:
> > - a new key/item
> > - a new extent inline ref item
> > 
> > The former is backwards compatible, but wastes space, the latter is
> > incompat, but is efficient in space and reuses the existing inline ref
> > machinery, while only abusing it a tiny amount -- specifically, the new
> > item is not a ref, per-se.
> 
> Even we introduce new extent tree items, we can still mark the fs compat_ro.
> 
> As long as we don't do any writes, we can still read the fs without any 
> compatibility problem, and the enable/disable should be addressed by 
> btrfstune/mkfs anyway.

There a was a discussion today how the simple quotas should be enabled.
We have 3 ways, ioctl, mkfs and btrfstune. Currently the qgroups can be
enabled by an ioctl and newly at mkfs time.

For squotas I'd do the same, for interface parity and because the quotas
are a feature that allows that, it's an accounting layer on top of the
extent structures. Other mkfs features are once and for the whole
filesystem lifetime.

You suggest to avoid doing ioctl, which I'd understand to avoid all the
problems with races and deadlocks that we have been fixing. Fortunatelly
the quota enable ioctl is extensible so we can add the squota
enable/disable commands and built on top of the whole quota
infrastructure we already have.

In addition the mkfs enabling should work too, like for qgroups. I think
we should support the use case when the need to start accounting data
comes later than mkfs and unmounting the filesystem is not feasible.

This also follows the existing usage of the generic quotas that can be
enabled or disabled as needed.
