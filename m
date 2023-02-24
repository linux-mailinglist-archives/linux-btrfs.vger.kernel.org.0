Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C456A1D11
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Feb 2023 14:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBXNlu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Feb 2023 08:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBXNlt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Feb 2023 08:41:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180AD58B41
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Feb 2023 05:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677246062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vxAeGMcximnxeonxM9d/wdloov2nu6QekQgZrg7SflU=;
        b=hH8+0I4xgozBUTGrUTL94vPx7X9vxlKVzCK3AvJ5XMAvlKx+59AO5j+o2oiHFemgHi1wKR
        DyoyfZdtAAzTMXJlKMg+j66wNlr0IkleukkM65G9aKDJJaHQWpO+J2UAIkemNfVysikgev
        saYTYYGPScA2cg36tomOX7+XK9zzmko=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-21-t3F7eu-MNbWiwvw5Z4SJeA-1; Fri, 24 Feb 2023 08:41:00 -0500
X-MC-Unique: t3F7eu-MNbWiwvw5Z4SJeA-1
Received: by mail-pg1-f199.google.com with SMTP id s3-20020a632c03000000b0050300a8089aso1374973pgs.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Feb 2023 05:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxAeGMcximnxeonxM9d/wdloov2nu6QekQgZrg7SflU=;
        b=wIF4MbdsoZDXXirxxbvWbffV+2ZgIiONdbJMyrNb5GuTDMaBD893Nn1u3d7MeKbFTK
         bfAr2ryN1vhA9jBK6xo0ZcuEG9F4P+JMuTFw24t495uohTH6HEX0OoqyDp0Uj5j9qOpv
         AnWHs0uGh2oHE6qaRGNqXmdAw+dIKjnAw0LWfg5/JUEivY0TfFEeHHpLsJoq11kDYAJc
         REqwaenvkNl+7ff0V/0ZspMiFCtnrb4X0CqLaj7WzSxvgbNvxOAPV5xVqfuco9HAKtYY
         UL7JxIixhc7p8Zr4nBTae0T1HR3Aonps2sPaR++oCF3PDoaIGGmFSEkOm/zVW2QQpjeI
         DCYg==
X-Gm-Message-State: AO0yUKVHRnJX0a6YzyiOybOn+RJfuWfoQUOvQme7/AgWU/rErTo/yTrd
        WQC8uIQ5ikCPzUxaGVxaeLQK6QQORQ7O+RtVd5FXLt03k1svJSCIho67t3cc/s2QCu3Q+AVdvbJ
        pNXnSP8HOQ6ZhQudsIa7ZvX/WRQqdmYQ=
X-Received: by 2002:a62:4e8e:0:b0:5d6:4ef8:8c6f with SMTP id c136-20020a624e8e000000b005d64ef88c6fmr7142032pfb.34.1677246059282;
        Fri, 24 Feb 2023 05:40:59 -0800 (PST)
X-Google-Smtp-Source: AK7set/y+MHXwPlwrjf+nzTJ6g1sSpCwpvKaE0z9xrGVABaKnz7tvMDOhR85LkevjZrQJO+cte9VvQ==
X-Received: by 2002:a62:4e8e:0:b0:5d6:4ef8:8c6f with SMTP id c136-20020a624e8e000000b005d64ef88c6fmr7142016pfb.34.1677246058830;
        Fri, 24 Feb 2023 05:40:58 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y5-20020a62b505000000b005df0c2b1b6asm2588383pfe.153.2023.02.24.05.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 05:40:57 -0800 (PST)
Date:   Fri, 24 Feb 2023 21:40:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: don't clear superblock for zoned scratch pools
Message-ID: <20230224134054.62lcl5tcqqitsxbr@zlang-mailbox>
References: <20230223154035.296702-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223154035.296702-1-johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 23, 2023 at 07:40:35AM -0800, Johannes Thumshirn wrote:
> _require_scratch_dev_pool() zeros the first 100 sectors of each device to
> clear eventual remains of older filesystems.
> 
> On zoned devices this creates all sorts of problems, so just skip the
> clearing there.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/rc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 654730b21ead..d763501be2b2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3461,7 +3461,9 @@ _require_scratch_dev_pool()
>  		fi
>  		# to help better debug when something fails, we remove
>  		# traces of previous btrfs FS on the dev.
> -		dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
> +		if [ "`_zone_type "$i"`" = "none" ]; then
> +			dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
> +		fi

Better to add some comments to explain why we need to check
[ "`_zone_type "$i"`" = "none" ] at here, even if only copy
your git commit log at here.

>  	done
>  }
>  
> -- 
> 2.39.1
> 

