Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A9E6C871A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 21:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjCXUxP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 16:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjCXUxC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 16:53:02 -0400
X-Greylist: delayed 384 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Mar 2023 13:52:57 PDT
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A262108;
        Fri, 24 Mar 2023 13:52:56 -0700 (PDT)
Received: from nvm (nvm.home.romanrm.net [IPv6:fd39::101])
        by len.romanrm.net (Postfix) with SMTP id 89E0F40041;
        Fri, 24 Mar 2023 20:46:28 +0000 (UTC)
Date:   Sat, 25 Mar 2023 01:46:28 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fstests: btrfs/012 don't follow symlinks for populating
 $SCRATCH_MNT
Message-ID: <20230325014628.0b18621b@nvm>
In-Reply-To: <8d1ac146d94eec8c77f08a6d04cd8d5248dc8dc8.1679688780.git.josef@toxicpanda.com>
References: <8d1ac146d94eec8c77f08a6d04cd8d5248dc8dc8.1679688780.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 24 Mar 2023 16:13:19 -0400
Josef Bacik <josef@toxicpanda.com> wrote:

> /lib/modules/$(uname -r)/ can have symlinks to the source tree where the
> kernel was built from, which can have all sorts of stuff, which will
> make the runtime for this test exceedingly long.  We're just trying to
> copy some data into our tree to test with, we don't need the entire
> devel tree of whatever we're doing, so use -P to not follow symlinks
> when copying.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/btrfs/012 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/012 b/tests/btrfs/012
> index d9faf81c..1b6e8a6b 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -43,7 +43,7 @@ mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
>  
>  _require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_PROG} '{print $1}')
>  
> -cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT
> +cp -aPR /lib/modules/`uname -r`/ $SCRATCH_MNT

But did you face the described problem in actual operation?

"man cp" says 

       -a, --archive
              same as -dR --preserve=all
...
       -d     same as --no-dereference --preserve=links
...
       -P, --no-dereference
              never follow symbolic links in SOURCE

So -a includes -d, which already includes -P that is now being added.

Moreover, even -R is redundant in the original line and could be removed.

-- 
With respect,
Roman
