Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055414BBC04
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 16:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbiBRPXB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 10:23:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiBRPW7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 10:22:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6609E1FCBDB
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:22:42 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1FF6B219A9;
        Fri, 18 Feb 2022 15:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645197761;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HoOa6VSykMGjYbObhrUuShKG5VP4qBNjiIh7Uxh8SGY=;
        b=rH8r2Qlh89NvjQ7shA/FfreHjJfr5vbFYb0IgtSxjdaIfCQfnu7RD9Kpyu5WahOpdTcV49
        TmNTz6E1XviKBPQpFECXYZp/HJr3IepvCLU5P+9G1Mspkr9r8Fud4lX4ZoRupZ+qY9wW3c
        S5HBGs4Dz6tRiKv+rOvi4CVxtq+ajxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645197761;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HoOa6VSykMGjYbObhrUuShKG5VP4qBNjiIh7Uxh8SGY=;
        b=I1zxvINuFpnX/yKvUA9H/dpdjzC7aLKEYahvc7YpCL4HAAF09zL7mGRQDFCFhJY7Q3P0gh
        jlvVhHhqac0OsaCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 16276A3B88;
        Fri, 18 Feb 2022 15:22:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 65872DA829; Fri, 18 Feb 2022 16:18:55 +0100 (CET)
Date:   Fri, 18 Feb 2022 16:18:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v13 08/17] btrfs: add definitions + documentation for
 encoded I/O ioctls
Message-ID: <20220218151855.GW12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1644519257.git.osandov@fb.com>
 <b12e9cf224a1737ddb3090cc50e1e0f317cb8b65.1644519257.git.osandov@fb.com>
 <20220211181701.GC12643@twin.jikos.cz>
 <YgqrM6Kl/KclUU/+@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgqrM6Kl/KclUU/+@relinquished.localdomain>
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

On Mon, Feb 14, 2022 at 11:19:15AM -0800, Omar Sandoval wrote:
> On Fri, Feb 11, 2022 at 07:17:01PM +0100, David Sterba wrote:
> > On Thu, Feb 10, 2022 at 11:09:58AM -0800, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > +	 *
> > > +	 * For writes, must not be BTRFS_ENCODED_IO_COMPRESSION_NONE.
> > > +	 */
> > > +	__u32 compression;
> > > +	/* Currently always BTRFS_ENCODED_IO_ENCRYPTION_NONE. */
> > > +	__u32 encryption;
> > > +	/*
> > > +	 * Reserved for future expansion.
> > > +	 *
> > > +	 * For reads, always returned as zero. Users should check for non-zero
> > > +	 * bytes. If there are any, then the kernel has a newer version of this
> > > +	 * structure with additional information that the user definition is
> > > +	 * missing.
> > > +	 *
> > > +	 * For writes, must be zeroed.
> > > +	 */
> > > +	__u8 reserved[32];
> > 
> > This is 32 bytes, so 4 x u64, that's not bad but for future expanstion
> > I'd rather add more than less. Now the structure size is 96 bytes, so if
> > it's 128 bytes then it's a power of two and we'd get 64 reserved bytes.
> 
> That seems reasonable. This changes the ABI (including the ioctl request
> number), so we should probably have it finalized soon.

Technically we have the whole development cycle to get the API/ABI
right, so it's not a big deal (yet).

> Would you like me
> to send another version with this change and the others you mentioned,
> or will you fix it in for-next?

I'll fix the issues in the local topic branch, I made more changes
(coding style) so resending would need more work.
