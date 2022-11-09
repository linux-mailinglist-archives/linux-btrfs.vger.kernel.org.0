Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3165622F93
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 17:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiKIQCz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 11:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiKIQCy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 11:02:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E48411C3D
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 08:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668009713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XOi2FGf4rZW4D8n9u2ClcoGsnHVZ0DXtX4Ga2kZ1eHg=;
        b=GquFf6BNMqVLu4bXWpaCC0clSA+3/hYkpE/EZG5K4kV7ETrLYryxiG3vFcIjYzPW8DQINs
        6tth1rUPav244a17aaeUZ3p0dNjk7Gj2lsUjfQsGHMwuSsB7FGp2cSthYvCeEq2scnVopR
        +7UXkWSSVxsI/3Bg6pWkdoNL6ttvWB4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-175-gyMp-272MouTfBtcMYcy5g-1; Wed, 09 Nov 2022 11:01:51 -0500
X-MC-Unique: gyMp-272MouTfBtcMYcy5g-1
Received: by mail-pg1-f200.google.com with SMTP id 83-20020a630156000000b0046b208f6ae3so9639199pgb.16
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Nov 2022 08:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOi2FGf4rZW4D8n9u2ClcoGsnHVZ0DXtX4Ga2kZ1eHg=;
        b=2kkfD5x8+q9Vwu9ikQ4OTsJVO5E5hs1s4HWS6uBQ+CjqwYvOK/H/QE+JqR7+Jz0ZkB
         +HvTBaJvAohkaQqtricAseFwbCOS8z3J0JMVyjozHieFRiVFwZIDbyE86AZpsPexXCVN
         aErDt7ddNq3Wk4oKIpCHGk8QttbgS4tY1cbR5GWUTy/eVKxBO5Q1mhLm2VToi1Vm3HzD
         dZzPMBbjNtZJ12iHOCiuTAraZUAvWzEVA/77i5K8z2bfbq/6mjidQU1k60mSZB1VH59g
         8DsUH1/DExuhM2H1C+eMfF/SQELKHYcoY005B14xJ6cwEbxqaum4m8JfRE/TxpjP+HbA
         /v1w==
X-Gm-Message-State: ACrzQf1TAzNTo7XNErIE7pn42rOYfZdCMToiadqSuFuvLM/hTPjETNmD
        cJ7KlH77FbkjL6n5DxGcC5YXTtY0mpbfzoRjATrSBzjI8R6aC2zxXv7Zh/91x4+3FQhj9b8M635
        3FqLAticw6fZGx7M8splpdKc=
X-Received: by 2002:a17:90b:3b49:b0:213:854f:f796 with SMTP id ot9-20020a17090b3b4900b00213854ff796mr70676671pjb.216.1668009709776;
        Wed, 09 Nov 2022 08:01:49 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7TurAucO3FSB+f65BBCpBZ4eRoeE3A4Hslb7WxEkug9lsZqTkK6+a72U65YxOJgZOkxhV5GA==
X-Received: by 2002:a17:90b:3b49:b0:213:854f:f796 with SMTP id ot9-20020a17090b3b4900b00213854ff796mr70676640pjb.216.1668009709372;
        Wed, 09 Nov 2022 08:01:49 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ij22-20020a170902ab5600b0017f36638010sm9191146plb.276.2022.11.09.08.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:01:48 -0800 (PST)
Date:   Thu, 10 Nov 2022 00:01:44 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 3/3] btrfs: fix failure of tests that use defrag on
 btrfs-progs v6.0+
Message-ID: <20221109160144.rardxaglxxheyp4d@zlang-mailbox>
References: <cover.1667993961.git.fdmanana@suse.com>
 <d2723c3a1b0205c68f5e62ed5156672d93b2e270.1667993961.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2723c3a1b0205c68f5e62ed5156672d93b2e270.1667993961.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 09, 2022 at 11:43:36AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Starting with btrfs-progs v6.0, the defrag command now prints to stdout
> the full path of the files it processes. This makes test cases btrfs/021
> and btrfs/256 fail because they don't expect any output from the defrag
> command.
> 
> The change happened with the following commit in btrfs-progs:
> 
>   dd724f21803d ("btrfs-progs: add logic to handle LOG_DEFAULT messages")
> 
> So update the tests to ignore the stdout of the defrag command.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/021 | 4 +++-
>  tests/btrfs/256 | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/021 b/tests/btrfs/021
> index 5943da2f..1b55834a 100755
> --- a/tests/btrfs/021
> +++ b/tests/btrfs/021
> @@ -22,8 +22,10 @@ run_test()
>  
>  	sleep 0.5
>  
> +	# In new versions of btrfs-progs (6.0+), the defrag command outputs to
> +	# stdout the path of the files it operates on. So ignore that.
>  	find $SCRATCH_MNT -type f -print0 | xargs -0 \
> -	$BTRFS_UTIL_PROG filesystem defrag -f
> +		$BTRFS_UTIL_PROG filesystem defrag -f > /dev/null
>  
>  	sync
>  	wait
> diff --git a/tests/btrfs/256 b/tests/btrfs/256
> index 1360c2c2..acbbc6fa 100755
> --- a/tests/btrfs/256
> +++ b/tests/btrfs/256
> @@ -50,7 +50,9 @@ $FSSUM_PROG -A -f -w "$checksums_file" "$SCRATCH_MNT"
>  # Now defrag each file.
>  for sz in ${file_sizes[@]}; do
>  	echo "Defragging file with $sz bytes..." >> $seqres.full
> -	$BTRFS_UTIL_PROG filesystem defragment "$SCRATCH_MNT/f_$sz"
> +	# In new versions of btrfs-progs (6.0+), the defrag command outputs to
> +	# stdout the path of the files it operates on. So ignore that.
> +	$BTRFS_UTIL_PROG filesystem defragment "$SCRATCH_MNT/f_$sz" > /dev/null
>  done
>  
>  # Verify the checksums after the defrag operations.
> -- 
> 2.35.1
> 

