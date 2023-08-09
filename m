Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6038D776081
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 15:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjHINUJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 09:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjHINUH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 09:20:07 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E902113
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 06:20:05 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-765942d497fso540259285a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Aug 2023 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691587204; x=1692192004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mhJSYFHUksYKVIz4jM1t/f9YaBXUFq+G4zB0CuP3O/w=;
        b=02fwpOEeRhUP8FGDU7QOWRWxiqigU2CBV39d838uGEIV1i0IhI48PELzwcCE1Qpkj4
         ShKiis1lutB4sGIWfP034PZIDeH2K2J2QA3WmsbIVVLGKAO02zBSeoLnvJsJ75qdHoMc
         kCkdoHYYnBC4sSF8zUGcsCd0qlIQA7/GsXeSVPeNoZPbIjzQlQ4s0c0ZSfhnIaLpZziG
         hfbCuUMpzqGtrhHNlaS4GIxWFn7RLuBjwqfC9D+uuWEERSUBQKlyL0QOcklRuD2+L51P
         2xWcrZituoYegRoBkQxRwYfFkKhOdIUcCwBvRTmnJK6aIpcOxyzbtT5X9bQNNHE8HMi6
         Y7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691587204; x=1692192004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhJSYFHUksYKVIz4jM1t/f9YaBXUFq+G4zB0CuP3O/w=;
        b=KX4jwqAG48nTOB6erKSyzTmSz4eNKKF6on+VESsaMTEpU1Xus00VM24FukStwUPJYp
         IfNv8atSdsLLB1LvFsEhY5YJtnolLJAgx78xPzwIlHKeZaEIyiwIF48XqH49Tdd3/HTv
         00zH+IVuNj7weAaU+jAMnC5LXzSEAdIO5a7va08VoKUKALMEO10tvpp8b244CLZ8DUPd
         U62sYhBFnmgzBqXC/iVQvvBKsOMnA7wq+nVLmnrTTtj84AkRcQR7Xrix6wxzDo7P915F
         p8EO/M8EaSNPTW/bn1hn2/dWoDulYqSdxCbyGcWRKFt8rekZ9tbvkr0MciTYyCRIyYgj
         5SDg==
X-Gm-Message-State: AOJu0Yy9+Xn317ttVKdhCZvGHOLZz9Q7IadNmQ131GZaazMywtxGYb6M
        +aKa2MrR2jfBAyzM1VjQRiWECP5otFZM7XH1YCwPVg==
X-Google-Smtp-Source: AGHT+IG4znc1HxWGDatvrHtewDDYEL4TWlWiYYJwm8pJQn5Q/3M7v54R45p/wTvMf7C8k+YcgYvQ7Q==
X-Received: by 2002:a05:620a:913:b0:76c:97a9:8ff0 with SMTP id v19-20020a05620a091300b0076c97a98ff0mr2524218qkv.77.1691587204689;
        Wed, 09 Aug 2023 06:20:04 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x16-20020a05620a14b000b00767d47eb29bsm4007445qkj.119.2023.08.09.06.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:20:04 -0700 (PDT)
Date:   Wed, 9 Aug 2023 09:20:03 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: handle errors properly in
 update_inline_extent_backref()
Message-ID: <20230809132003.GE2515439@perftesting>
References: <7a56e967d536bbb3d40c90def6e59e9970ef3445.1691564698.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a56e967d536bbb3d40c90def6e59e9970ef3445.1691564698.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 09, 2023 at 03:08:21PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> Inside function update_inline_extent_backref(), we have several
> BUG_ON()s along with some ASSERT()s which can be triggered by corrupted
> filesystem.
> 
> [ANAYLYSE]
> Most of those BUG_ON()s and ASSERT()s are just a way of handling
> unexpected on-disk data.
> 
> Although we have tree-checker to rule out obviously incorrect extent
> tree blocks, it's not enough for those ones.
> 
> Thus we need proper error handling for them.
> 
> [FIX]
> Thankfully all the callers of update_inline_extent_backref() would
> eventually handle the errror by aborting the current transaction.
> 
> So this patch would do the proper error handling by:
> 
> - Make update_inline_extent_backref() to return int
>   The return value would be either 0 or -EUCLEAN.
> 
> - Replace BUG_ON()s and ASSERT()s with proper error handling
>   This includes:
>   * Dump the bad extent tree leaf
>   * Output an error message for the cause
>     This would include the extent bytenr, num_bytes (if needed),
>     the bad values and expected good values.
>   * Return -EUCLEAN
> 
>   Note here we remove all the WARN_ON()s, as eventually the transaction
>   would be aborted, thus a backtrace would be triggered anyway.
> 
> - Better comments on why we expect refs == 1 and refs_to_mode == -1 for
>   tree blocks
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
