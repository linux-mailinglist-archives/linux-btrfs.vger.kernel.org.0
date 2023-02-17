Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE3269A6B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 09:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBQIPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 03:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBQIPx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 03:15:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D31B5ECB9
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 00:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676621716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QbS7911hScRu2MaDwz0qjzrdGp+96HgI0J1ybBnU28c=;
        b=QHE3yDMhgNCuRdfgL5sRhOvLeZQyymBEwwa94p/gt3NKhFYaqOWeAg0qykmYx1eRkf9etZ
        QQp5IjCPpd4TWwqIQ3qBXYg02uIboYEXksco/1uRn9Pn9DA50zxMGGAOTL8HKfvcSRLZJp
        shN0SJGdz3UPnhgUaZzYJcGVrvd8Kc4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-417-bnDmgkuWP26Yji65nuo2zg-1; Fri, 17 Feb 2023 03:15:14 -0500
X-MC-Unique: bnDmgkuWP26Yji65nuo2zg-1
Received: by mail-pf1-f199.google.com with SMTP id cm17-20020a056a00339100b005a8ee90fbc6so366588pfb.4
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 00:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbS7911hScRu2MaDwz0qjzrdGp+96HgI0J1ybBnU28c=;
        b=02zBeekK8fMtWMTlF/VdVpjx+WGgiHQ0t0HsgEdzpaiu+Uuz2c+lOKSea5n5LJyiCx
         xrPsTbP/5MF8U2IjHdHC0TkWHn9rdAHj2Xl1DuL/UKj4IctIXlqatX+9ttnoYokyvec5
         1472xykFZ+9cGbSvYGtwuRz6oiTTDPnkQccEeuSIdQQBu+I4UYx5drcAF4APmXA49Itb
         2Et/Y9xSaVKUk2LRwSonU8vOrqdkr3fwhcitSJKT6ZxDD3niEDk9pe/8XLzZr4Vv+zT0
         AvGA713Tse/GNL7evgZW56ypFp9WnfPMyRujPkrrAwHH+CGYh97/HNG+xkBl7Y5vch2V
         WTlg==
X-Gm-Message-State: AO0yUKWNwGNPt/RGuA5NoSPb/17DWmV23TABukYvjsGSbqbU2B41lvfe
        qcV/FwNz+y5BQmlRM8Z4lZNQ9sUKI6/wOu+myD3i71Co4ibiovN92qh7SAzLqbv2ApLTKV6QYpZ
        WXFZ9ePu2RO7y6TTEJLgydHs=
X-Received: by 2002:a17:90a:e7ce:b0:233:bd59:5719 with SMTP id kb14-20020a17090ae7ce00b00233bd595719mr5366141pjb.0.1676621713546;
        Fri, 17 Feb 2023 00:15:13 -0800 (PST)
X-Google-Smtp-Source: AK7set+oiPN2g1rzO+fZ9kUvMHirlL2J4UxJHHsGxGHpTYl+WDpPYp2aAoLOHQdVeTuRcXeyHrronw==
X-Received: by 2002:a17:90a:e7ce:b0:233:bd59:5719 with SMTP id kb14-20020a17090ae7ce00b00233bd595719mr5366127pjb.0.1676621713194;
        Fri, 17 Feb 2023 00:15:13 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id gx11-20020a17090b124b00b002309279baf8sm4393423pjb.43.2023.02.17.00.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 00:15:12 -0800 (PST)
Date:   Fri, 17 Feb 2023 16:15:08 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/604: fix test to actually create dirty inodes
Message-ID: <20230217081508.gpsmhgxbdli4gtwu@zlang-mailbox>
References: <4dd1c7d583289c12d2acf8bfee3b555307399220.1676564465.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd1c7d583289c12d2acf8bfee3b555307399220.1676564465.git.fdmanana@suse.com>
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

Thanks for catching and fixing this issue.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  done
>  _scratch_unmount &
>  _scratch_mount
> -- 
> 2.35.1
> 

