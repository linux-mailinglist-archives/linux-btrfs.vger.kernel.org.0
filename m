Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55567536A72
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 May 2022 05:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353521AbiE1De2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 23:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353259AbiE1De2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 23:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2811FC4ED
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 20:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653708864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jB1DK1q2s3BlKBZNF/Ej3i3x5zmDMJnEC8DqO9F8Gkw=;
        b=R4zHknWrG8eellEGnqIgUlTotmCtQoeof9Xqs43ZDAZ/kQBNOGHHm7OkMmICEraICwAEUQ
        irjhAwmVPpngodh7fU1KhqWCc++PrvcfQVWaa9I4huSLCtO+yz3v6hAyZd8IpQtIOtBMxu
        dGYj7bwN/J59xBYuE6+C6ZtUZPFxnjE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-d12fMW56MoeZbYxwBCD00w-1; Fri, 27 May 2022 23:34:21 -0400
X-MC-Unique: d12fMW56MoeZbYxwBCD00w-1
Received: by mail-oo1-f69.google.com with SMTP id a2-20020a4a8dc2000000b0040e6caf521cso3229737ool.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 20:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jB1DK1q2s3BlKBZNF/Ej3i3x5zmDMJnEC8DqO9F8Gkw=;
        b=R8S7Z4IloYCp5s579NPajg6IZobuD/ggS56txsABRI6bEzriv8gHr0HbrQeQgcUfWp
         8FyRj5GuA7vBt2PTcGbfuLo+rzQBGd1JSzJ4iz9Qzt4EMkW9xRFOf3K4Y7WzG/pTD3BP
         So0OlFicLbitukoK+cw6wT6sqYyf/DAhQtI37N7Rx7KTx9G7M7UB9ZHfdlzLaYUOt+J4
         d4dek7QIcg4uJkn+baKrA9lkSGJguYPRUnmQUIn42ZulefhHuGpyMJdp0ZcjlOlgHY8w
         Z4FWEHcOjP6VPggtPUk+awZaqSoknBJEzJ/JrVcJT3+oCJAc+glcinAKmktfMVsk4D3q
         r6FQ==
X-Gm-Message-State: AOAM533qZzpzdPaiXyMPdMqb40KsWnFAbaSDeWjJHeEu4jqRUVsfCHuk
        ZD1IRh0UXRXlQFRksOmVUVT4q/NbnqoCCI7RYZ7mDRhttAW34yeZ9XfCL1o5jRTVzDEtJv1tVfR
        AqiMSGyfGwhQQJlTYUs/v1lY=
X-Received: by 2002:a05:6808:4d1:b0:32b:da0:46fc with SMTP id a17-20020a05680804d100b0032b0da046fcmr5045920oie.151.1653708860776;
        Fri, 27 May 2022 20:34:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeakOhFrkPd6d0arC1+v+ruQY5Ap+g1kRvzY5fc/ZpUSpqkCw7jcsbpsprmN5MT2ORIOc5wA==
X-Received: by 2002:a05:6808:4d1:b0:32b:da0:46fc with SMTP id a17-20020a05680804d100b0032b0da046fcmr5045912oie.151.1653708860540;
        Fri, 27 May 2022 20:34:20 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i8-20020a056808054800b00325cda1ff9fsm2562094oig.30.2022.05.27.20.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 20:34:20 -0700 (PDT)
Date:   Sat, 28 May 2022 11:34:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/10] btrfs: add a helpers for read repair testing
Message-ID: <20220528033414.qdzmvjpfen6ob6ix@zlang-mailbox>
References: <20220527081915.2024853-1-hch@lst.de>
 <20220527081915.2024853-2-hch@lst.de>
 <20220527145445.fyrp3anncqdxb7sl@zlang-mailbox>
 <20220527150306.GA1534@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527150306.GA1534@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 27, 2022 at 05:03:06PM +0200, Christoph Hellwig wrote:
> On Fri, May 27, 2022 at 10:54:45PM +0800, Zorro Lang wrote:
> > You can send a single fixed patch for this one
> 
> I could do that, but I also need to fix up the comments in 266 and 267
> to say 64k instead of 4k.

Hi Christoph,

I can help to do this change when I merge this patchset, if you don't have
more changes need to do. Actually I'm trying to wait this patchset for this
weekend fstests release, due to it's almost done. I need to do a regression
test today before pushing these patches on Sunday (if no exception:)

Thanks,
Zorro

> 

