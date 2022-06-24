Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E85558D36
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 04:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiFXC0J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 22:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXC0I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 22:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8036755375
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 19:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656037566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kQRtRSOkA2bIK2861EWipnyNuVYwl1sEb+A44HUB5Cw=;
        b=a191hkbT/JnbrLe3xFTZWtOjsfeqNXjasOKWf5mqpoqrIgsnbg/72MyhwM4IBLuqmRP0ou
        zea6dcQkOD2H2tJOv/eDc/QQRl+KPZEaf2Vcn9wrGLUMC1w5urpoZq/RC85UKAZBSuGfdW
        wDSXQCBhsR4deMDHfpZoE3+p5KW09pE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-dtpRQtdBOmG87VJV5RLatA-1; Thu, 23 Jun 2022 22:26:05 -0400
X-MC-Unique: dtpRQtdBOmG87VJV5RLatA-1
Received: by mail-qk1-f197.google.com with SMTP id ay8-20020a05620a178800b006a76e584761so1179663qkb.13
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 19:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kQRtRSOkA2bIK2861EWipnyNuVYwl1sEb+A44HUB5Cw=;
        b=cbCf1i3ZC7NHvU7Opq1tHQyp5Xlql70wKZWzb6/DcQoY55NdY4pa6PuCwU93j19wI6
         afaPF0XbXDsDhevbzfQ49K8XmdlVXRtRXDfpzKqNraiTKZT2RAEiJLGJaL4+t3ErnCSW
         NnInxQ/Dus9w6/O5AflJCG9IREl/z4Z5DSL3keZXfozZAu9bExEoLKGmCdudaqg8dVd4
         SOu3JlCmyqCXYqLtyMmCO/uBpeQbYRlLupabQxHukIz8VyGHsGwLsGsfsh8pnSAowXQK
         NxUdHdRcltBB9nvKRla8gRs70DT5sVnC5D+ya8jCwqugr72tXm2EWvnYjDqGGm/8gFDn
         JFpg==
X-Gm-Message-State: AJIora/v3WsLaiKCJUte3RxEFVK77h6Ap+Ixl9+CyPX8EzuvLqFdu/rU
        sVXxZt9F6TnUYKsRxgnhrprybyXFfyrXyNxOAKrkrZ1EWH+PlOXplp+HCwHRkc2PDzNN68kMkgE
        rsm1HTjw3lDYy9tkZ2C2SxlI=
X-Received: by 2002:a05:6214:20a4:b0:470:2b47:a2f6 with SMTP id 4-20020a05621420a400b004702b47a2f6mr27697473qvd.85.1656037564234;
        Thu, 23 Jun 2022 19:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1umgALhSvRbML6BmQH6LeinNqce5XrwL4sfLQOXJ2vEp3PKpLvb9guuxiINx9Bm/Ko7yO7d5Q==
X-Received: by 2002:a05:6214:20a4:b0:470:2b47:a2f6 with SMTP id 4-20020a05621420a400b004702b47a2f6mr27697469qvd.85.1656037563975;
        Thu, 23 Jun 2022 19:26:03 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g19-20020a37e213000000b006a6bd7028d5sm979532qki.18.2022.06.23.19.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 19:26:03 -0700 (PDT)
Date:   Fri, 24 Jun 2022 10:25:58 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: test read repair on a corrupted compressed
 extent
Message-ID: <20220624022558.ds66n4bhaq6njkpl@zlang-mailbox>
References: <20220622045844.3219390-1-hch@lst.de>
 <20220622045844.3219390-5-hch@lst.de>
 <20220622092140.GA26204@lst.de>
 <20220622124118.mkawtc3n2quhi42l@zlang-mailbox>
 <20220622130745.GA29960@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622130745.GA29960@lst.de>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 22, 2022 at 03:07:45PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 22, 2022 at 08:41:18PM +0800, Zorro Lang wrote:
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
> >                    ^^^^^^^^^^^
> > Is it a wrong copy&paste ?
> 
> A lot of the test is copied from btrfs/141, so I wanted to keep the
> copyright intact.

Oh, there're some cases copy from old cases in fstests, but they are changed
a little to have different coverage. Generally they metioned they copy from
which one case (number). I don't mind if you'd like to keep original
Copyright name, but the copyright time is old for a new test case, I don't
know if we'd better to update it. Hmm... sorry, not good at these copyright
things...

> 
> > > +#
> > > +# FS QA Test 270
> > > +#
> > > +# Regression test for btrfs buffered read repair of compressed data.
> > 
> > If this's a regression test, I'd like to see the fix be reviewed/acked
> > at first :)
> 
> Heh.  Actually I'm not sure it is a regression, this was copy and
> pasted as well.  I think it actually has been broken since day 1.
> 

