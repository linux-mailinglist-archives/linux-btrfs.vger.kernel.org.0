Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4765AA56F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 04:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiIBCAn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 22:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbiIBCAm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 22:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3CA50195
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 19:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662084039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nchLC9q9Cqj8zfIGBjKbwfzCwDv99l0+65Juf1id85I=;
        b=Ohctx6peNsC5SzaJQQ6rc/ZUO1qgamSLND3Jd/XG6mBydkfZMXH0VPvEVKra13PhRSLCpL
        m3zCUQYqXIvHVKR55VnY589k1puWbbS059pG2Djp/RIlr6ztEpylM7Y9DJngVcQsndwgMO
        6hcsHbK1m/UqpFiGn8Tq9o/hNcAoBP0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-evDTzfv9OtS2AyC5a84SlA-1; Thu, 01 Sep 2022 22:00:38 -0400
X-MC-Unique: evDTzfv9OtS2AyC5a84SlA-1
Received: by mail-qk1-f200.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso809755qkp.21
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 19:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nchLC9q9Cqj8zfIGBjKbwfzCwDv99l0+65Juf1id85I=;
        b=ThlcRbHJ+q/Agr9J8zIVFKtTaP7fpQkSdjSZZOHBI9eW5HZubtihTvMLEosKf7cLXo
         8RiD+MXpEkgIHGDBSGvl7q4864QUlc293Z8sYoU5zEKDKgHUWCIvYdhrdh3nIERpxgx5
         VxDGTXmQiUKKLWzG9uxCiEsQrgoCXtEzBxTRF+lmCMx9opjWRYy8Bxy8ZdKMMjW0cxQF
         XhwFoZ0yrxnt7iKshSpzHz3r0gu9WGD0subRruvzQHmWRXAU13fGxGRAhFJFpc8c4dw4
         AvS9o41gJaVFpQWBW//JSXO5BNRqVOPYN4nGSdSJy+5g2VsfqkIKBHt+IKyMJGTwuG2z
         Ei0Q==
X-Gm-Message-State: ACgBeo3cB0CqYMS5q0r9SFmAyhyiOs1E/Kf1UbN81JE1mZLgrumMuqG2
        q6T+PcDT3Ftbt9vkLdYIanbU2w576kBtOZoeoHndiPglFxXMm/Fsg2bs1iEDxmaRsKla16nh7YS
        PSaSOIJgL/BvNVVuyI4Z+gpM=
X-Received: by 2002:a05:6214:3013:b0:496:dd8c:84bb with SMTP id ke19-20020a056214301300b00496dd8c84bbmr26788378qvb.23.1662084037914;
        Thu, 01 Sep 2022 19:00:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5LrlBWGvT+dqH7zwskvoviWdW2m+JCvy03JbdW+7x1IjizFc+jEwEF02r7BGYwusx2/aID1g==
X-Received: by 2002:a05:6214:3013:b0:496:dd8c:84bb with SMTP id ke19-20020a056214301300b00496dd8c84bbmr26788358qvb.23.1662084037575;
        Thu, 01 Sep 2022 19:00:37 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b006b929a56a2bsm472748qkg.3.2022.09.01.19.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 19:00:37 -0700 (PDT)
Date:   Fri, 2 Sep 2022 10:00:30 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: remove 'seek' group from btrfs/007
Message-ID: <20220902020030.oho6ssdrdzjy66pw@zlang-mailbox>
References: <bc7149309a8eca5999f22477a838602023094cb8.1662048451.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc7149309a8eca5999f22477a838602023094cb8.1662048451.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 05:12:25PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs/007 does not test lseek, it tests send/receive and lseek is not
> exercised anywhere in this test. So just remove it from the 'seek' group.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

This 'seek' group is brought in by below commit:

  commit 6fd9210bc97710f81e5a7646a2abfd11af0f0c28
  Author: Christoph Hellwig <hch@lst.de>
  Date:   Mon Feb 18 10:05:03 2019 +0100

      fstests: add a seek group

So I'd like to let Christoph help to double check it.

Thanks,
Zorro


>  tests/btrfs/007 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/007 b/tests/btrfs/007
> index ed7d143a..c4a8d9d0 100755
> --- a/tests/btrfs/007
> +++ b/tests/btrfs/007
> @@ -13,7 +13,7 @@
>  owner=list.btrfs@jan-o-sch.net
>  
>  . ./common/preamble
> -_begin_fstest auto quick rw metadata send seek
> +_begin_fstest auto quick rw metadata send
>  
>  # Override the default cleanup function.
>  _cleanup()
> -- 
> 2.35.1
> 

