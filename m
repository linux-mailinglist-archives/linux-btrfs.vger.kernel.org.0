Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2115AA5BE
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 04:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiIBC2F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 22:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiIBC2E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 22:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521C9559D
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 19:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662085679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YYdvjm5GB+jrMEGjl5J8cEs5EIE6VGdkpOoFW4clzEM=;
        b=DTySgtf+VarpTOf7Jq8yrg1fCLW5R8hTOQmzPOqeImxSaFc47UkdAGdbiJzNHg/oQMJMyh
        E2A82tsWVCt+2n6L+D6L8D+V+iR6CYsKOvCX9NcmN5yqQYyoRPDA2TFIsq9T1txky+n4+v
        Cu4zvcmbZIoq9AqhbOwrmIUZaRnvhLQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-215-mqZ_8SOuMyWVy8To1KrX-w-1; Thu, 01 Sep 2022 22:27:58 -0400
X-MC-Unique: mqZ_8SOuMyWVy8To1KrX-w-1
Received: by mail-qv1-f70.google.com with SMTP id d15-20020a056214184f00b00498efcf3965so426070qvy.15
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 19:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YYdvjm5GB+jrMEGjl5J8cEs5EIE6VGdkpOoFW4clzEM=;
        b=dAJazxDJUsS+slwkLfczyPv/1nabnQhXlbdzI5K/hjXev82aIP2ZDUSj+8KygyPyEK
         ouPAXI7cpFAeJdWgyt6hpXrr74LVuEhLqqPrwTY5980vgOig7Cn7q52FCeuPW0JbVaHx
         f/yAZCwPbl4wAfeEoZcTV9rZuNXdETsXsl5JWYJfVbxt5u9bX8SuFdpsbmMCE3gtfxA5
         N2RgTLHvnt3Ns8Yx2YQ0sG/Pjwp9knwiWWWi6+S/L3Dm55YJ+atTaA1nzWg9QxmhXC5m
         +AZ9G8b1cz9oaAm512r/9XI0HLEozR892lfumDoWehMFLdUl6l4/RjDjf4Y9C/zaVR5j
         zJMA==
X-Gm-Message-State: ACgBeo01igJAPnIUFMGDQY1GRe4Y00NIyG35ymzWAghKvdl22su29a6K
        8JnX+79HbrzxEOhdvI7Cx9/WsgtT3NfSS56ECvn9/KEFFpvSDOUrs9Qnhmfp1ewLnW9Ok6i6VgA
        57Iq1m5hkE9+HiEOktmfR9gs=
X-Received: by 2002:a05:620a:254f:b0:6bb:dcb6:4279 with SMTP id s15-20020a05620a254f00b006bbdcb64279mr22595343qko.79.1662085677675;
        Thu, 01 Sep 2022 19:27:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5uHBPnNZ/mj1TyVajLNwrfC6qXsehPkmNkagFeRkqd+VT37EA+DWngOWa9DPLutnlS7HIAHg==
X-Received: by 2002:a05:620a:254f:b0:6bb:dcb6:4279 with SMTP id s15-20020a05620a254f00b006bbdcb64279mr22595335qko.79.1662085677423;
        Thu, 01 Sep 2022 19:27:57 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c8-20020a37e108000000b006b9264191b5sm471918qkm.32.2022.09.01.19.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 19:27:57 -0700 (PDT)
Date:   Fri, 2 Sep 2022 10:27:51 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: fix btrfs/271 failure due to missing source of
 fail_make_request
Message-ID: <20220902022751.4q7uvzzljzstakg3@zlang-mailbox>
References: <62ccab661ea8591cbc5f8b936fc4e0a47f2bfc86.1662063388.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ccab661ea8591cbc5f8b936fc4e0a47f2bfc86.1662063388.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 09:17:02PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The recent commit 49272aacac850c ("common: refactor fail_make_request
> boilerplate") moved _require_fail_make_request() from common/rc into
> common/fail_make_request, but it forgot to make btrfs/271 source this
> new file, so now the test always fails:
> 
>   $ ./check btrfs/271
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/x86_64 debian9 6.0.0-rc2-btrfs-next-122 #1 SMP PREEMPT_DYNAMIC Mon Aug 29 09:45:59 WEST 2022
>   MKFS_OPTIONS  -- /dev/sdb
>   MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1
> 
>   btrfs/271 4s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/271.out.bad)
>       --- tests/btrfs/271.out	2022-08-08 10:36:20.404812893 +0100
>       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/271.out.bad	2022-09-01 21:12:29.689481068 +0100
>       @@ -1,4 +1,5 @@
>        QA output created by 271
>       +/home/fdmanana/git/hub/xfstests/tests/btrfs/271: line 17: _require_fail_make_request: command not found
>        Step 1: writing with one failing mirror:
>        wrote 8192/8192 bytes at offset 0
>        XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>       ...
>       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/271.out /home/fdmanana/git/hub/xfstests/results//btrfs/271.out.bad'  to see the entire diff)
>   Ran: btrfs/271
>   Failures: btrfs/271
>   Failed 1 of 1 tests
> 
> Fix that by sourcing common/fail_make_request at btrfs/271.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Thanks for fixing it! Looks like we missed the btrfs/271 ...

  $ grep -rsn _require_fail_make_request tests/
  tests/btrfs/271:16:_require_fail_make_request
  tests/btrfs/088:26:_require_fail_make_request
  tests/btrfs/150:25:_require_fail_make_request
  tests/generic/019:21:_require_fail_make_request

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/271 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/btrfs/271 b/tests/btrfs/271
> index c21858d1..681fa965 100755
> --- a/tests/btrfs/271
> +++ b/tests/btrfs/271
> @@ -10,6 +10,7 @@
>  _begin_fstest auto quick raid
>  
>  . ./common/filter
> +. ./common/fail_make_request
>  
>  _supported_fs btrfs
>  _require_scratch
> -- 
> 2.35.1
> 

