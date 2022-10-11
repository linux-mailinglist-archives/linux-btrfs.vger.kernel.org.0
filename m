Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025EB5FB3F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 15:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiJKN5E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 09:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJKN5C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 09:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E747184E43
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665496621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8mHIWcLJcuFzKyDfOzGZAyY0Sq5ZgGQGzYlm0xYrvX0=;
        b=VmLpZbupSj16MJa97oXmRxbzxaCHH0IDw7xraJ8jpgJhz90axb9LZl4yqWc9Dsjm3ewLae
        ks1STG2Z2ENodzojAIojWJ4UC+qJQPSRIyMeUGOeobvm+nFmz3HVHAjpW5V06LYOMUDgk9
        Z1V21al+tu4OblKvtqBh0fTtg9Fb+0w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-4zubGiQ8OyKbiXVkmIDHLg-1; Tue, 11 Oct 2022 09:57:00 -0400
X-MC-Unique: 4zubGiQ8OyKbiXVkmIDHLg-1
Received: by mail-qt1-f197.google.com with SMTP id b12-20020a05622a020c00b003983950639bso5117652qtx.16
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 06:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mHIWcLJcuFzKyDfOzGZAyY0Sq5ZgGQGzYlm0xYrvX0=;
        b=qkW2XPfGarQ3XnSmJbNW1eVzqquhErqEIrgHr8Zlx/Lmf0SGLdMVhfQeyS3QTeClVr
         pdmJ/Ht1awuNQtpJVDGmDsL1jMoTvGeX8DYg4Ifnw2TcJPbIugHkYHQfXi2Y7O9mIJw/
         M8Jz4uz4yxthugO0872SXD9jCQ2R0BhCd/VtVV/wknNKqpEUylCaOotZx+7iCowbT1SF
         wmWgioMc4YW/CA7/2JjTeLLuk/Z859AKVKNo69T+MNjU41AcjsITxKEGpuSi81pvcvAO
         ZM7hzh29di7wUXWe16Mvpf64aI2V1oM0W1RvR2IcWlagtNg1esokt2ZGS6/++S+W65y+
         HWIQ==
X-Gm-Message-State: ACrzQf30TMP8zKxEFIAIdguX8pFtFkdeRslLQdVRwD6iqCwmGxJoj06p
        QaK/ZRI3Cacnz/sY4FkR0Tr4OgdtFMu7mmQRS/E9s2GkfGvv3yq4w8T5EYkyXKzQ5Vn37jD8UnH
        G6MNnLEv21e9bZWKmILwafRQ=
X-Received: by 2002:a05:6214:d08:b0:4b1:7127:f615 with SMTP id 8-20020a0562140d0800b004b17127f615mr19203959qvh.92.1665496619537;
        Tue, 11 Oct 2022 06:56:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5kd8mWSIB5jIu7wHgeuz2NSrCnZWG5XNeKD1BEPyHCZAzIpvCn7isu2ye6KZ7Hi8MQSieKZw==
X-Received: by 2002:a05:6214:d08:b0:4b1:7127:f615 with SMTP id 8-20020a0562140d0800b004b17127f615mr19203945qvh.92.1665496619309;
        Tue, 11 Oct 2022 06:56:59 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q4-20020a05620a2a4400b006ee74cc976esm3156201qkp.70.2022.10.11.06.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:56:58 -0700 (PDT)
Date:   Tue, 11 Oct 2022 21:56:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/3] fstests: add missing require of xfs_io fiemap
 command to some tests
Message-ID: <20221011135654.zc6vrfvjqqmanpao@zlang-mailbox>
References: <cover.1665150613.git.fdmanana@suse.com>
 <f10f9fb7fe2ba35d651150f891aec3d996731a96.1665150613.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f10f9fb7fe2ba35d651150f891aec3d996731a96.1665150613.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 07, 2022 at 02:53:35PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs/257, btrfs/258, btrfs/259 and xfs/443 use the fiemap command of
> xfs_io but don't do a '_require_xfs_io_command "fiemap"'. So add the
> missing requirement.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Make sense,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/257 | 1 +
>  tests/btrfs/258 | 1 +
>  tests/btrfs/259 | 1 +
>  tests/xfs/443   | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/tests/btrfs/257 b/tests/btrfs/257
> index 3092495f..87f9e0b2 100755
> --- a/tests/btrfs/257
> +++ b/tests/btrfs/257
> @@ -33,6 +33,7 @@ _require_btrfs_no_compress
>  # Needs 4K sectorsize
>  _require_btrfs_support_sectorsize 4096
>  _require_xfs_io_command "falloc"
> +_require_xfs_io_command "fiemap"
>  
>  _scratch_mkfs -s 4k >> $seqres.full 2>&1
>  
> diff --git a/tests/btrfs/258 b/tests/btrfs/258
> index da073333..be61d039 100755
> --- a/tests/btrfs/258
> +++ b/tests/btrfs/258
> @@ -17,6 +17,7 @@ _begin_fstest auto defrag quick
>  # Modify as appropriate.
>  _supported_fs generic
>  _require_scratch
> +_require_xfs_io_command "fiemap"
>  
>  # Needs 4K sectorsize, as larger sectorsize can change the file layout.
>  _require_btrfs_support_sectorsize 4096
> diff --git a/tests/btrfs/259 b/tests/btrfs/259
> index 92d0b9a6..36f499f9 100755
> --- a/tests/btrfs/259
> +++ b/tests/btrfs/259
> @@ -18,6 +18,7 @@ _begin_fstest auto quick defrag
>  # Modify as appropriate.
>  _supported_fs btrfs
>  _require_scratch
> +_require_xfs_io_command "fiemap"
>  
>  _scratch_mkfs >> $seqres.full
>  
> diff --git a/tests/xfs/443 b/tests/xfs/443
> index f2390bf3..de28b85b 100755
> --- a/tests/xfs/443
> +++ b/tests/xfs/443
> @@ -30,6 +30,7 @@ _require_test_program "punch-alternating"
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "fpunch"
>  _require_xfs_io_command "swapext"
> +_require_xfs_io_command "fiemap"
>  
>  _scratch_mkfs | _filter_mkfs >> $seqres.full 2> $tmp.mkfs
>  _scratch_mount
> -- 
> 2.35.1
> 

