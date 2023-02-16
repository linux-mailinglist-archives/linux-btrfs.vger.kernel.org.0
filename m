Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5B699BB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 18:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBPR45 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 12:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBPR4p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 12:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB513508
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 09:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676570159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFrFEVmfvr17svCMGFko3g1/FP+2QWUtmi0Zysq3Bsk=;
        b=ESfAzLZp3qK/Ve8v8XWEarZ0IR2O+rUXSOwk0R2uLyO5OVVTqSzc8NnzYovrsMsSPucwfK
        kGq3S/3086tq1uvUysVEJqGKH0MDuQUmIIRnwVR+UEqqN6M9UvniMd4lcCbWPD3NxFQUGn
        9mLWYK+Xi8yIqSc5CyVQ+LYWszEVj3U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-ZWz405-qNEesiyi8Q_Em_w-1; Thu, 16 Feb 2023 12:55:58 -0500
X-MC-Unique: ZWz405-qNEesiyi8Q_Em_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06412811E9C;
        Thu, 16 Feb 2023 17:55:58 +0000 (UTC)
Received: from redhat.com (unknown [10.22.18.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC222140EBF6;
        Thu, 16 Feb 2023 17:55:57 +0000 (UTC)
Date:   Thu, 16 Feb 2023 11:55:56 -0600
From:   Bill O'Donnell <billodo@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/604: fix test to actually create dirty inodes
Message-ID: <Y+5uLFkce5waKBRI@redhat.com>
References: <4dd1c7d583289c12d2acf8bfee3b555307399220.1676564465.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd1c7d583289c12d2acf8bfee3b555307399220.1676564465.git.fdmanana@suse.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 16, 2023 at 04:21:50PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test case generic/604 aims to test a scenario where at unmount time we
> have many dirty inodes, however the test does not actually creates any
> files, because it calls xfs_io without the -f argument, so xfs_io fails
> but any error is ignored because stderr is redirected to /dev/null.
> 
> Fix this by passing -f to xfs_io and also stop redirecting stderr to
> /dev/null, so that in case of any unexpected failure creating files, the
> test fails.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
lgtm...
Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

> ---
>  tests/generic/604 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/604 b/tests/generic/604
> index 3c6b76a4..9c53fd57 100755
> --- a/tests/generic/604
> +++ b/tests/generic/604
> @@ -22,7 +22,7 @@ _require_scratch
>  _scratch_mkfs > /dev/null 2>&1
>  _scratch_mount
>  for i in $(seq 0 500); do
> -	$XFS_IO_PROG -c "pwrite 0 4K" $SCRATCH_MNT/$i >/dev/null 2>&1
> +	$XFS_IO_PROG -f -c "pwrite 0 4K" $SCRATCH_MNT/$i >/dev/null
>  done
>  _scratch_unmount &
>  _scratch_mount
> -- 
> 2.35.1
> 

