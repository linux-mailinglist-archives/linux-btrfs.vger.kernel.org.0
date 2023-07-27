Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B25765808
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 17:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjG0Pv2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 11:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjG0Pv1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 11:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA832686
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690473048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WLs83qTR2/0M8JlpqdviUB1R+uDjEqNfqfLlllpaFzc=;
        b=RXl2+UGyzsCMFEf60W9uP6B+GFCcrJr0YRiualhtZJUIdUj/D2+P0Vqc44XaXNGfrydEke
        cXw95fsvGVFhkmLFAI2t+KeYfRFgQncjJpXiNxLTc+F2ZxAcRkicce+AIhn6Xvkq0xZvnU
        qFJxJgEajV2v+qNhyJ/CoaiUBfq90rY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-Zc_DfYYKPxyVlthTSpV0mA-1; Thu, 27 Jul 2023 11:50:47 -0400
X-MC-Unique: Zc_DfYYKPxyVlthTSpV0mA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-686e29b0548so780740b3a.1
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 08:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473046; x=1691077846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLs83qTR2/0M8JlpqdviUB1R+uDjEqNfqfLlllpaFzc=;
        b=NzyzbeOvGLq/Mr6rGAT5RHQU9Iv/1cZgAh29Ui1my0plEqo98ce7pdC2M3LjFCXcWF
         3/xs4cgg5mgv/GEcFWp8Uv91Wr2cO+A8kQvnyyKqLKmmQKyxcBeWneiG0DXhmOWdqz6v
         OgcMaNoROqh6szyERcaakqaLtrcMSjTvDR8Nss427iwZ9DnWvbfDYBrGmU/U2M5rHYuE
         qFmCWKqB7qQGkZmblNEmYsriXKfsWg14DLmh9tWZaMLaU9mZh7MCoK3v5oPtHnUaICvE
         I9QnSkfENopsoe8dCj8KTeEcn7EWQUk0nwAumCDmC1YXGsGyB7oaSlvo3L6/CsBQt8s/
         eyzQ==
X-Gm-Message-State: ABy/qLao5Nyn2wefYGNG7qhZa4H4wADpAwJKC3KykRHRZw92NYwXPTbx
        x46WekBfTf/37IxFy7uwR88cLZU4Nm7sROR38d4VdlHLuzOVDb47JwixMwJdx/MKsH9WNMRmdlb
        fe+vqOBcYfx7dY0AffiLxuFI=
X-Received: by 2002:a05:6a00:1a12:b0:686:25fe:d575 with SMTP id g18-20020a056a001a1200b0068625fed575mr5447188pfv.11.1690473046108;
        Thu, 27 Jul 2023 08:50:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFzhLOdO4trU6+1ulijyC0esbB7AZHkuCQWaSKU7KZGTmNFu5dlH+/lT9Lkzk8pqiJw98KVpw==
X-Received: by 2002:a05:6a00:1a12:b0:686:25fe:d575 with SMTP id g18-20020a056a001a1200b0068625fed575mr5447175pfv.11.1690473045812;
        Thu, 27 Jul 2023 08:50:45 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d19-20020aa78153000000b0065da94fe917sm1657277pfn.36.2023.07.27.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:50:45 -0700 (PDT)
Date:   Thu, 27 Jul 2023 23:50:41 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/294: reject zoned devices for now
Message-ID: <20230727155041.u5yr3rtxneqhq2vl@zlang-mailbox>
References: <20230724030423.92390-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724030423.92390-1-wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 11:04:23AM +0800, Qu Wenruo wrote:
> The test case itself is utilizing RAID5/6, which is not yet supported on
> zoned device.
> 
> In the future we would use raid-stripe-tree (RST) feature, but for now
> just reject zoned devices completely.
> 
> And since we're here, also update the _fixed_by_kernel_commit lines, as
> the proper fix is already merged upstream.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Just check before next fstests release. This patch has been reviewed, but looks
like there're still more review points from btrfs list. So will you send a new
version to replace this patch?

Thanks,
Zorro

>  tests/btrfs/294 | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/294 b/tests/btrfs/294
> index 61ce7d97..d7d13646 100755
> --- a/tests/btrfs/294
> +++ b/tests/btrfs/294
> @@ -16,11 +16,15 @@ _begin_fstest auto raid volume
>  
>  # Modify as appropriate.
>  _supported_fs btrfs
> +
> +# No zoned support for RAID56 yet.
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
>  _require_scratch_dev_pool 8
>  _fixed_by_kernel_commit a7299a18a179 \
>  	"btrfs: fix u32 overflows when left shifting @stripe_nr"
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> -	"btrfs: use a dedicated helper to convert stripe_nr to offset"
> +_fixed_by_kernel_commit cb091225a538 \
> +	"btrfs: fix remaining u32 overflows when left shifting stripe_nr"
>  
>  _scratch_dev_pool_get 8
>  
> -- 
> 2.41.0
> 

