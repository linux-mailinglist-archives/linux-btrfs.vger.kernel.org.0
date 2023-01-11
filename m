Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC64666596
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 22:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjAKVZM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 16:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbjAKVYx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 16:24:53 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5845C42E07
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 13:24:51 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id jr10so7636142qtb.7
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 13:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gRqpF2wgyHkFEpcJK60Wiqsz5VbfVz+t7nXng27ZngU=;
        b=5wuxKwc+/2xNAu28DvSJsHQ6S6R2z5cPK6yrXCAVlCxdxDnzmsGNQPipXnTzhhQXQa
         SDqcSvJFZySm5KSWhByhaluppcLxeWjJ6lYvUTnwHOhZEc5U+vWlezeqUTbJ3Mlzvvg/
         hQQU2okSvYmhTZXuJxMa8NiXKdWuCnbjpzeYNLjLQWJS4AB90NvFqlqm0c9z4GB/iyHg
         buOvViKQQxfxiocXETXO6pdlHISd6Rd7yj2KXMpVAOyrPKRqsJfXGu04tB36kddUZNkm
         3Tt0c6SirZASQa1/QEj0UIE2e7WJdU4DT+wmxPDDTPrdiJTs4LQOH4SPzgc+4YexkO5l
         e+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRqpF2wgyHkFEpcJK60Wiqsz5VbfVz+t7nXng27ZngU=;
        b=PcKuNF8Xyv96DP46n3jJy/IkzWB5gTDQHwHdeWwUWLPMq0tefPezOIw2dbePZRB1UY
         SNkCCHCJ9miy2NhBZF1tfMll5wCJv7tn2RzcUa+b+ufzUfuzSm2S4SOt4Kp6WCj6h0FK
         2njivnS4+IsWGHLvdNr4NDZvREs/M172ecBl43CcvIgzpT8vXjABwKddZvtL38OWUmm4
         v6UzpsKej74i8kkwiWJWNhpfN08I1Nzm2BWT//Mopvpizb8L5AjQjZdThYmg/C50zmIx
         PxP86vvCBPQjcZ1t8KcZgAgo/yp96c8c0xArRreznPDHtv067YJ6A+JNPz7zJMxNu12+
         0PPQ==
X-Gm-Message-State: AFqh2koZW5h4de46Bg6BKemmgd889RtDCT+D07mBaWMLYGeq/XBRNn4w
        uMR96sdwMRavlu+Ed9j5en0Rhfb1WF0QAqIf8ik=
X-Google-Smtp-Source: AMrXdXsRyjnTYH+gk4dxyfDc7TIAVD0cD2fsezaBipBvAYH3nZl1XMpdAiff7syxbalny0pX8uUhoQ==
X-Received: by 2002:ac8:67d2:0:b0:3ac:1bd5:b7ad with SMTP id r18-20020ac867d2000000b003ac1bd5b7admr21194060qtp.33.1673472290268;
        Wed, 11 Jan 2023 13:24:50 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s13-20020ac85ecd000000b003a69de747c9sm8106833qtx.19.2023.01.11.13.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 13:24:49 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:24:48 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs: some log tree fixes and cleanups
Message-ID: <Y78pIJ33voFIVG90@localhost.localdomain>
References: <cover.1673361215.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673361215.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 10, 2023 at 02:56:33PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some fixes mostly around directory logging and some cleanups (the last
> three patches).
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
