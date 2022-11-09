Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0930622F77
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 16:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiKIP4Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 10:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiKIP4N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 10:56:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4680193CD
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 07:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668009314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=28Ccszi1P3T+ZnzNRGtbuUBqePx/ieU7H+4uG5/z258=;
        b=JZW8Isyaudx/ZLxpBiuD8shGTwpZoHRwLhXvRMW8D7664aS9k05ihrGP2PVNWLaXp5ydJe
        Gd/uWoErYYy27aBOGiD9I2ULr5c2c9Yg2EMd1KArsHuNaFqCAXIrPqYunZM7Rofobu0MPD
        Xiwj3QedfutLCy/wpm93NfxJJogMTRk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-MLabrBaMNjGc1tM0cQXsvw-1; Wed, 09 Nov 2022 10:55:11 -0500
X-MC-Unique: MLabrBaMNjGc1tM0cQXsvw-1
Received: by mail-pf1-f200.google.com with SMTP id k11-20020aa792cb000000b00558674e8e7fso9011974pfa.6
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Nov 2022 07:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28Ccszi1P3T+ZnzNRGtbuUBqePx/ieU7H+4uG5/z258=;
        b=WfiLB6ZjTiHmO0VUpkiDm+fJ2S55t4dHTSzzoF4/qhPBHtx0nNQ3kIwehYns9JSij5
         ps7tpnhIyZHU/cSxpvMeJWm2tcuA6jzZXyDhPH+mn5thk08GQAZdAlk86Gl7rPcMDbTA
         Gs44We6c2imC5VI2s5H+Y2jx6gK7N/E1gTinYAv78gQU3PPOjV69zLacDKlQV0UJevwb
         YbIKdWsZkQePsAVWvgDSidU/V124Qn22Tgs+LNUWqOALsp1/jef5JUsbkFC8hmVuiOeA
         ZYcjstBDGlen667jWCqJkPWfTHJiLrWZfWsjCAj6v6AjJKqCNIqQIAPHpVtCyMUk41mi
         kGSA==
X-Gm-Message-State: ACrzQf0V3wO6pzjDE3cTSmmf4ZfN5/eq8O6+ba6+XmeLwYw7HdkdISU9
        6kQVv7aa6F88IzkxkQXv32fuu3sg4OnvCpoxKn2HjN08f4udSO6czpsCbcZZdReRNuwWr9p0gLk
        ZQ7jfw28ulKmLdg1Q7Z9w2T0=
X-Received: by 2002:a17:90a:e593:b0:212:f0e8:46ca with SMTP id g19-20020a17090ae59300b00212f0e846camr79970464pjz.144.1668009310516;
        Wed, 09 Nov 2022 07:55:10 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5JDa2W97WzCL9+HYj081LXkyOo8bMu+bLtxofTCA9SZ2GG3DFor+tz0J4k30ndtuPSd6uPyw==
X-Received: by 2002:a17:90a:e593:b0:212:f0e8:46ca with SMTP id g19-20020a17090ae59300b00212f0e846camr79970451pjz.144.1668009310223;
        Wed, 09 Nov 2022 07:55:10 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a428700b001fe39bda429sm1375608pjg.38.2022.11.09.07.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 07:55:09 -0800 (PST)
Date:   Wed, 9 Nov 2022 23:55:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/3] btrfs/053: fix test failure when running with
 btrfs-progs v6.0+
Message-ID: <20221109155505.yki6xwqk4p4mhky6@zlang-mailbox>
References: <cover.1667993961.git.fdmanana@suse.com>
 <a97dca4502e29bdd56f711060416a5992dcaea73.1667993961.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a97dca4502e29bdd56f711060416a5992dcaea73.1667993961.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 09, 2022 at 11:43:35AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In btrfs-progs v6.0 the --leafsize (-l) command line option was removed,
> so btrfs/053 always fails with v6.0+.
> 
> The change was introduced by the following btrfs-progs commit:
> 
>   f7a768d62498 ("btrfs-progs: mkfs: remove support for option --leafsize")
> 
> Change the test to use --nodesize (-n) instead, since it exists in both
> old and new btrfs-progs versions.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/053 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/053 b/tests/btrfs/053
> index fbd2e7d9..c0446257 100755
> --- a/tests/btrfs/053
> +++ b/tests/btrfs/053
> @@ -44,7 +44,7 @@ send_files_dir=$TEST_DIR/btrfs-test-$seq
>  rm -fr $send_files_dir
>  mkdir $send_files_dir
>  
> -_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
> +_scratch_mkfs "--nodesize $leaf_size" >/dev/null 2>&1

We you said this case starts to fail on btrfs-progs v6.0, I'm wondering how it
fail (I don't doubt it fails), at least not fails at here right?

Actually I recommend mkfs output to .full file at here, especially when you use
specified mkfs options to _scratch_mkfs helper. That really might fail, and
the case might keep running (with old fs on SCRATCH_DEV), and we hard to notice
that if no message output and no return value checking.

The _scratch_mkfs doesn't _fail if it fails, it just return nonzero and output
error message. So generally I recommend writting likes this (or other proper way
which can detect mkfs failure):

  _scratch_mkfs "--nodesize $leaf_size" >>$seqres.full 2>&1 || _fail "mkfs failed"

especially if there's specified mkfs options.

Thanks,
Zorro

>  _scratch_mount
>  
>  echo "hello world" > $SCRATCH_MNT/foobar
> @@ -72,7 +72,7 @@ _run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
>  _scratch_unmount
>  _check_scratch_fs
>  
> -_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
> +_scratch_mkfs "--nodesize $leaf_size" >/dev/null 2>&1
>  _scratch_mount
>  
>  _run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
> -- 
> 2.35.1
> 

