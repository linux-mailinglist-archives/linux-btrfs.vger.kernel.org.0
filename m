Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097A06D84FD
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 19:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjDERe4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 13:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjDERez (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 13:34:55 -0400
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0856182
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 10:34:52 -0700 (PDT)
Received: from nvm (nvm.home.romanrm.net [IPv6:fd39::101])
        by len.romanrm.net (Postfix) with SMTP id 0536F400B1;
        Wed,  5 Apr 2023 17:34:49 +0000 (UTC)
Date:   Wed, 5 Apr 2023 22:34:49 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: set default discard iops_limit to 1000
Message-ID: <20230405223449.1904fcad@nvm>
In-Reply-To: <45f813c5fabdb32df67ba661c396c592b863ff25.1680711209.git.boris@bur.io>
References: <cover.1680711209.git.boris@bur.io>
        <45f813c5fabdb32df67ba661c396c592b863ff25.1680711209.git.boris@bur.io>
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

On Wed,  5 Apr 2023 09:20:32 -0700
Boris Burkov <boris@bur.io> wrote:

> Previously, the default was a relatively conservative 10. This results
> in a 100ms delay, so with ~300 discards in a commit, it takes the full
> 30s till the next commit to finish the discards. On a workstation, this
> results in the disk never going idle, wasting power/battery, etc.
> 
> Set the default to 1000, which results in using the smallest possible
> delay, currently, which is 1ms. This has shown to not pathologically
> keep the disk busy by the original reporter.
> 
> Link: https://lore.kernel.org/linux-btrfs/ZCxKc5ZzP3Np71IC@infradead.org/T/#m6ebdeb475809ed7714b21b8143103fb7e5a966da
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/discard.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 317aeff6c1da..aef789bcff8f 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -60,7 +60,7 @@
>  #define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60UL * MSEC_PER_SEC)
>  #define BTRFS_DISCARD_MIN_DELAY_MSEC	(1UL)
>  #define BTRFS_DISCARD_MAX_DELAY_MSEC	(1000UL)
> -#define BTRFS_DISCARD_MAX_IOPS		(10U)
> +#define BTRFS_DISCARD_MAX_IOPS		(10000U)

But the patch sets 10000?

>  
>  /* Monotonically decreasing minimum length filters after index 0 */
>  static int discard_minlen[BTRFS_NR_DISCARD_LISTS] = {


-- 
With respect,
Roman
