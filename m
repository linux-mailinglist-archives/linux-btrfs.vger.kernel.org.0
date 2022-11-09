Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863AE622F24
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 16:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiKIPj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 10:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiKIPjY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 10:39:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE425C4E
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 07:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668008295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i1movnRqeUiSUaPBdyR4UD6IKNUM5EsJmslMyB9trwo=;
        b=BaIWQBYiW6krp/A5C7uCABArDNvQIeDZjKIgxS/72H9sX+iJ4DKh/tsf15MYSw1XY6+tzY
        3rqyLAQECCPDAHm0j/yMNdQtifutOwm+vVjD+WmkJGch1lQ/2dbuGippSZWXxhZwuu958z
        sqEwWhCfyQcZ34ne2csNJub45YzeTt8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-454-v6psduXYNKC4xqC_KuhxqQ-1; Wed, 09 Nov 2022 10:37:56 -0500
X-MC-Unique: v6psduXYNKC4xqC_KuhxqQ-1
Received: by mail-pf1-f197.google.com with SMTP id m6-20020aa79006000000b0056bc283f477so9057507pfo.19
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Nov 2022 07:37:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1movnRqeUiSUaPBdyR4UD6IKNUM5EsJmslMyB9trwo=;
        b=Z5iCz2ZCg9B0WUXTE6L1zvK7vLtl8ROOwJXEZI7Gt/2Witpw+F2APiQZHP/R3R8R/n
         xlDAqGiTHvs4Yzto7LN76joWiNQ40tN0b/NyRgqtmtI8xjDQNB4rCss90XmDVoeULQ82
         oIOEMIq3B8ZD+HcRHR92NRFxK+V7ZPlbO2jlZGy8vSr76MDQ/cx9qfTR3LZ/xEuAci1B
         ZoLaf7pQ3DI5IfwaCCDe36S+E5JG+7aLcU4LN/pFphuItcMWj61VqPGVbHZz/RrGnr4y
         Er68u6RdN9U3fu8iAQCc21NerkzdDl5c+RvIQPcLrllMZywZOI71jdWMrAMOsvJMp6oN
         /s8A==
X-Gm-Message-State: ACrzQf0XfUbvVLXvIL4T0hx+VGb4GDJuu0e9y+/jOF1iIRO54o83b7fP
        a2mQ2bHhLeN7HHxuQJWymCTm9oyklMUrqzH69ZO7dZ2H9v4Rtgky2wwvwQmuM/h4UT5Lgn/yLx9
        9S+DvMPjcjzBRX+0gTRqw3g4=
X-Received: by 2002:a05:6a00:1582:b0:56d:4bc6:68c7 with SMTP id u2-20020a056a00158200b0056d4bc668c7mr54749658pfk.31.1668008275558;
        Wed, 09 Nov 2022 07:37:55 -0800 (PST)
X-Google-Smtp-Source: AMsMyM74zuHNNzMlLuEzXK3S5MxIvdQKQhUOwOYeYamK2jixRTgK4yA60CSXXkV1W6v9qorHlj1F1Q==
X-Received: by 2002:a05:6a00:1582:b0:56d:4bc6:68c7 with SMTP id u2-20020a056a00158200b0056d4bc668c7mr54749637pfk.31.1668008275244;
        Wed, 09 Nov 2022 07:37:55 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b00186a6b63525sm9203068plb.120.2022.11.09.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 07:37:54 -0800 (PST)
Date:   Wed, 9 Nov 2022 23:37:50 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/3] btrfs/003: fix failure on new btrfs-progs versions
Message-ID: <20221109153750.p6jgtm5a2zc4id7f@zlang-mailbox>
References: <cover.1667993961.git.fdmanana@suse.com>
 <62ef22111c9cb654e6e5e50f7337105b9ef804d7.1667993961.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ef22111c9cb654e6e5e50f7337105b9ef804d7.1667993961.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 09, 2022 at 11:43:34AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Starting with btrfs-progs version 5.19, the output of 'filesystem show'
> command changed when we have a missing device. The old output was like the
> following:
> 
>     Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
>             Total devices 2 FS bytes used 128.00KiB
>             devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>             *** Some devices missing
> 
> While the new output (btrfs-progs 5.19+) is like the following:
> 
>     Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
>             Total devices 2 FS bytes used 128.00KiB
>             devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>             devid    2 size 0 used 0 path /dev/loop1 MISSING
> 
> More specifically it happened in the following btrfs-progs commit:
> 
>     957a79c9b016 ("btrfs-progs: fi show: print missing device for a mounted file system")
> 
> This is making btrfs/003 fail with btrfs-progs 5.19+. Update the grep
> filter in btrfs/003 so that it works with both output formats.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

OK, make sense,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/003 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/003 b/tests/btrfs/003
> index cf605730..fae6d9d1 100755
> --- a/tests/btrfs/003
> +++ b/tests/btrfs/003
> @@ -141,8 +141,9 @@ _test_replace()
>  	_devmgt_remove ${removed_dev_htl} $ds
>  	dev_removed=1
>  
> -	$BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV | grep "Some devices missing" >> $seqres.full || _fail \
> -							"btrfs did not report device missing"
> +	$BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV | \
> +		grep -ie '\bmissing\b' >> $seqres.full || \
> +		_fail "btrfs did not report device missing"
>  
>  	# add a new disk to btrfs
>  	ds=${devs[@]:$(($n)):1}
> -- 
> 2.35.1
> 

