Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E098581052
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbiGZJtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238535AbiGZJti (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 05:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40FD831DFD
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658828976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njmXR/tl6Yv4H7DqdHRc9Thiis+e3nUQsXGdK+eV/4k=;
        b=jPbx39x/0ZyALp/Dm3+d1UDn66/cBDYIsnk4plxtQy8T12knyIaon7Ze7A6PtU/DBlGcRe
        QQDrc3HASZH17+pXPX1sJdBAja4Aiv1YJZJkQ5U62Y+y/etZhUXiknXTQXjWmktro7YjWU
        Hb9Dn7qESIzTm1+i2B7Ye6uPFmvv98w=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-RzAiPM-KODWQ6LhXDFzCuQ-1; Tue, 26 Jul 2022 05:49:34 -0400
X-MC-Unique: RzAiPM-KODWQ6LhXDFzCuQ-1
Received: by mail-oi1-f200.google.com with SMTP id s19-20020a056808209300b0033ac2da4062so3824687oiw.13
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 02:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=njmXR/tl6Yv4H7DqdHRc9Thiis+e3nUQsXGdK+eV/4k=;
        b=ZZ7fH+zlROSK69hOFCcxi4ez3JEAHeWy+NpSuSBoZmv41B8A2ui22e8wdUUiVT2JiU
         w3PQa9SYSLyQz/pvDnb8QX/YPtv18CScRT96KXk+SY/lyu9Bm6UohPLNnWvUlUJc9sye
         l6v2LQEPe+7Rk+ilS85JIanDVH3JUirIv39XILOsw/BQ01hS9H7wCIXL3KVkbSLIhkJl
         WR8j2CA203zq1uU229NkXzhaPOgLkG7fY691kuu/xneFNSED4Jf2RfalINEP1Q93GXKf
         OpKwiJocqWHwRLI7KkHZgXSEQS2G3oDSZgn1ApWq8Uo8r5pQ3p0tUwUNBMEGTjEE0yDL
         ITfQ==
X-Gm-Message-State: AJIora+d9cw/7ac94fBPG21rkOeQrdVJj81o3LbvHIzNTAWLwazDJye8
        tgUGWhWFFLg2R/TQ4XM8qYFdamyKUmqTsKmcDm+YKOtEr8xkYCnVSRAJEX40Uw5EGqu8V57/B9v
        RTlW+nnk4FQMdm5DGVu58lzY=
X-Received: by 2002:a05:6830:3101:b0:61c:bd29:3043 with SMTP id b1-20020a056830310100b0061cbd293043mr6253370ots.125.1658828973775;
        Tue, 26 Jul 2022 02:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vpXJ9KmpFv0EvnoDdSi9zeklf33OQ9+NZAMX9Mk653AjqKPJ7c00t/uGd671E5+e08bQCp0w==
X-Received: by 2002:a05:6830:3101:b0:61c:bd29:3043 with SMTP id b1-20020a056830310100b0061cbd293043mr6253365ots.125.1658828973519;
        Tue, 26 Jul 2022 02:49:33 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x81-20020a4a4154000000b00425ce891cd8sm5794802ooa.34.2022.07.26.02.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 02:49:33 -0700 (PDT)
Date:   Tue, 26 Jul 2022 17:49:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/253: skip on zoned mode as we cannot change the
 chunk size
Message-ID: <20220726094928.ovz42mjoanhtinbe@zlang-mailbox>
References: <20220726075759.3155494-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726075759.3155494-1-naohiro.aota@wdc.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 04:57:59PM +0900, Naohiro Aota wrote:
> On zoned mode, we have a fixed chunk size which is equal to the zone size.
> So, we cannot change the chunk size, and running this test results in a
> failure with below.
> 
>     --- tests/btrfs/253.out     2021-12-10 04:33:53.000000000 +0000
>     +++ /host/results/btrfs/253.out.bad 2022-07-26 05:58:10.000000000 +0000
>     @@ -2,9 +2,16 @@
>      Capture default chunk sizes.
>      First allocation.
>      Second allocation.
>     +./common/rc: line 4670: echo: write error: Invalid argument
>     +./common/rc: line 4670: echo: write error: Invalid argument
>      Calculate request size so last memory allocation cannot be completely fullfilled.
>      Third allocation.
>     ...
> 
> It is no use to test this feature on zoned mode. So, just skip it.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---

Make sense to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/253 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/btrfs/253 b/tests/btrfs/253
> index fbbb81fae754..c746f41e9264 100755
> --- a/tests/btrfs/253
> +++ b/tests/btrfs/253
> @@ -81,6 +81,8 @@ alloc_size() {
>  _supported_fs btrfs
>  _require_test
>  _require_scratch
> +# The chunk size on zoned mode is fixed to the zone size
> +_require_non_zoned_device "$SCRATCH_DEV"
>  
>  # Delete log file if it exists.
>  rm -f "${seqres}.full"
> -- 
> 2.35.1
> 

