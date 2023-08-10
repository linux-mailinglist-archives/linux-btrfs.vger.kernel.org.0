Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DCE777EBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 19:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjHJRDT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 13:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjHJRDS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 13:03:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046982705
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 10:03:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ABDAD21873;
        Thu, 10 Aug 2023 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691686996;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8g5pBqyFCo+XhZ4WaOFr/hYhDxHJdN4AH3M6VdXDLmg=;
        b=F9D+Ft1X1LS+MWJPNjQgulQ9vJWiD5o7mrNNaaeEz1SHhInTFJMWrBltdkAoeAzxAgHqhl
        SgnO/soBkl9E+2STKOTGeDJzZ+lHipoY5zCkfmecObAbdvVCm7JWhAfLMnjwMUUFv9Fcu4
        xhrhokgWrs0/NuHsUAuafYfbKBS6dh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691686996;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8g5pBqyFCo+XhZ4WaOFr/hYhDxHJdN4AH3M6VdXDLmg=;
        b=CzSlqNbFOT0D+C93Njt5GxiQBOVE8TpglBI0Q+hqQAFUdZK8jYUfcOj/QFHKa0ecVe/bCZ
        47tsMgti24pmwEDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86349138E0;
        Thu, 10 Aug 2023 17:03:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3SPzH1QY1WQxSAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Aug 2023 17:03:16 +0000
Date:   Thu, 10 Aug 2023 18:56:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs NOCOW fix and cleanups
Message-ID: <20230810165651.GH2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230724142243.5742-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724142243.5742-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 07:22:37AM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> this series fixes a (found by code inspection) bug in the error handling
> in btrfs_run_delalloc_nocow, and then cleans up a bunch of things in
> btrfs_run_delalloc_nocow to allow me to actually undestand the logic
> there, and in case of the last patch signigicantly simplifies it.
> 
> The series is on top of the for-next branch as that includes previous
> work not in misc-next yet that the series relies on.
> 
> A git tree is also available here:
> 
>     git://git.infradead.org/users/hch/misc.git btrfs-nocow-cleanups
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-nocow-cleanups
> 
> Diffstat:
>  inode.c        |  143 +++++++++++++++++----------------------------------------
>  ordered-data.c |   24 ++++++++-
>  2 files changed, 67 insertions(+), 100 deletions(-)

Patches 1-4 added to misc-next, the remaining two will be in for-next.
