Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A8D752BA8
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 22:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjGMUak (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 16:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjGMUak (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 16:30:40 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5662715
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:30:38 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a36b309524so1035883b6e.3
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689280238; x=1691872238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=39txpBUCcuQ3c4p8/ix9ZxwfJot9Kz+g+t+rd2IqFAQ=;
        b=uv4uVM+P3aHmx9uKsi6ws9E4z2dlHpLa8W0i/V2IOfOjWqsiYoWum+C2zIl9Q+kNei
         U18sdQsnRV2RToymORiCiQrK0qZZ6USjHNjyAkkU5Z34492s2R78yRqW7JQFYKFQc84q
         w3gOxheowgpXJSzd1ZBN6aedV9+oz2WbYUnhyLXqj0hnQvNN1Coz/ieuhP/DCJ/S55s1
         rodosfmOWBJq6KRBaF5a9GyGFbK0tULm6zdHjhh/dlbDqw9ZiCCtbXnc1ZXNjzCDjuwj
         C3RuSQZ/8yd7Jq/tpe1Tg3RQRcrJnInJvrhee4kRCjuOB9Aq7CNaUfIC2NONjcPNV2wt
         0/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280238; x=1691872238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39txpBUCcuQ3c4p8/ix9ZxwfJot9Kz+g+t+rd2IqFAQ=;
        b=f2WArt9V4jbB5FPNrPyRoJPDtsRHf8josLcy9Jn/Z3CG4hswovyn/vcm/lic8uNzdA
         P0rsp9Xcqjh3z5Rz2hNToETCM2030KjyahgBaXQBEOnc2MW/BkdP2hs1QoP2laeWS7qy
         FNZ8pgSoFAxQ1xVW23WYlFqIjTscu3JsKV1nbjmZBVegP8LjIddT/YH2sZuffuZjeYrr
         vNsglJorCMWYWZZTmF13Q4qhqOyFMFyrmjueoMEFWjfA3u1KHCs5/QFiktSdo0huABhi
         w3sz8odp5LCEk4FG8+FQ58G9gWQHLiIqh5llceQesElk/ysaj5VqOuN9btUXZa3gIAmV
         e+YA==
X-Gm-Message-State: ABy/qLYK1UZSgws3Veg608QoJwpGfhr7l9FJmvdwyDpWQ92rHYljSRko
        UnIifciUewH4H+dZziXIOqlyzrdHMaCCkg6lDwe02w==
X-Google-Smtp-Source: APBJJlGvMD7joi4RHqcoLsfdAhZ8wScit7IjAs6MuwPBUK0GiC6HLcDRlYLJEvP/bLtrUpKbyvpKFw==
X-Received: by 2002:a05:6808:1308:b0:3a1:df16:2eed with SMTP id y8-20020a056808130800b003a1df162eedmr3853143oiv.30.1689280237920;
        Thu, 13 Jul 2023 13:30:37 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q9-20020a25f909000000b00c6135ffd2fcsm1498906ybe.15.2023.07.13.13.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:30:37 -0700 (PDT)
Date:   Thu, 13 Jul 2023 16:30:36 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH 3/5] common/btrfs: quota rescan helpers
Message-ID: <20230713203036.GA207541@perftesting>
References: <cover.1688600422.git.boris@bur.io>
 <0e9cb76f3ddad71bb36b70464b62423b77fd6399.1688600422.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e9cb76f3ddad71bb36b70464b62423b77fd6399.1688600422.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:42:25PM -0700, Boris Burkov wrote:
> Many btrfs tests explicitly trigger quota rescan. This is not a
> meaningful operation for simple quotas, so we wrap it in a helper that
> doesn't blow up quite so badly and lets us run those tests where the
> rescan is a qgroup detail.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  common/btrfs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 66c065a10..d88feaded 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -715,6 +715,31 @@ _qgroup_mode()
>  	fi
>  }
>  
> +_check_regular_qgroup()
> +{
> +	local mnt=$1
> +
> +	_qgroup_mode $mnt | grep -q 'qgroup'
> +}
> +
> +_qgroup_rescan()
> +{
> +	local mnt=$1
> +
> +	_check_regular_qgroup $mnt || return 1
> +	_run_btrfs_util_prog quota rescan -w $mnt
> +}
> +
> +_require_qgroup_rescan()
> +{
> +	_scratch_mkfs >>$seqres.full 2>&1
> +	_scratch_mount
> +    _run_btrfs_util_prog quota enable $SCRATCH_MNT
> +    $BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT || \
> +         _notrun "not able to run quota rescan"
> +	_scratch_unmount
> +}

Looks like whitespace errors here.  Thanks,

Josef
