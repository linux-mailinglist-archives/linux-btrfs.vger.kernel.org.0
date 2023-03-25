Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445A06C8FAD
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 18:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCYRGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 13:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYRGy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 13:06:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FBF7AA9;
        Sat, 25 Mar 2023 10:06:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49535CE08C7;
        Sat, 25 Mar 2023 17:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9F3C433EF;
        Sat, 25 Mar 2023 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679764008;
        bh=SOBww+4Lg5ifGwbM/KYI/nuwOi8qD/cFUcLWWrCTl/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tGZ1kXozD2SWl5aKpv1GAzbeoj1LP5sGZM1Jj5lkcxL3zNqKNDp+KEelrMhj74C2r
         7QTK1Rab73bZNugp7aE/AMTQNWCMmG51cJ+82oduax09zW4uAwEAksgoICDKZLV4mB
         RKD+vOgPcWIxdDJQ9OSbKuAu0y175MtZjQQSzKjKdIKoZF2+DbZ7/v1dZqK1zSZLpj
         NpPXX7GQsBngxhb9jHLflrzcNrH3cl6Wwq6K0WP1uFMAsg4lXxTrtgD/XGT4zIs8gT
         t78GrnmU6eEIVqWxr4RSHxcVYYBUiE9ZwdZRZ4QRti3YZf/hGXPfMNBAedF9FEjv+L
         2CLR9xl/jahxg==
Date:   Sat, 25 Mar 2023 10:06:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] fstests: btrfs/012 don't follow symlinks for populating
 $SCRATCH_MNT
Message-ID: <20230325170647.GA16170@frogsfrogsfrogs>
References: <8d1ac146d94eec8c77f08a6d04cd8d5248dc8dc8.1679688780.git.josef@toxicpanda.com>
 <ZB6ubFfBIvFLqs73@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB6ubFfBIvFLqs73@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 25, 2023 at 01:18:52AM -0700, Christoph Hellwig wrote:
> On Fri, Mar 24, 2023 at 04:13:19PM -0400, Josef Bacik wrote:
> > /lib/modules/$(uname -r)/ can have symlinks to the source tree where the
> > kernel was built from, which can have all sorts of stuff, which will
> > make the runtime for this test exceedingly long.  We're just trying to
> > copy some data into our tree to test with, we don't need the entire
> > devel tree of whatever we're doing, so use -P to not follow symlinks
> > when copying.
> 
> Btw, if you're touching this test can you make it _notrun if the
> directory doesn't exist?  This test always fails for VMs without
> any modules.

If you just want some filler content for the "old" ext4 filesystem, why
not simply copy something that's guaranteed to exist like /etc or /var?
And perhaps use timeout(1) to control the cp runtime?

(I don't have the symlink problem, but I occasionally watch this test
suddenly take forever if I accidentally turn off module compression
and/or slim debuginfo...)

--D
