Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41A664A7D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 20:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiLLTCX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 14:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiLLTBS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 14:01:18 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A29F183AF
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 10:59:57 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id h10so8837196qvq.7
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 10:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqU90PkBJp4/VPA2/Mvy+tpLgZVSeCw+RcAj8ZjLHq4=;
        b=8QlAE8mRnlbplRSnx1MP2eaVCgRtc2jlXvBFnDTF/N3LUH1U20XBsy3Fb6GRkoD0xU
         7eENssdftx+JUsHF+bWSMlWPEyCGZ6F33FK8Y8NQ9xCU5jRGsnAzqJR0L1jqhHkRdcXC
         Bza8FEk9LgGv+boW50f8LOnwsFGYwW7o5sI1yEdkvpzMOb45DPOCYHzvHaDX+2xx8Xqx
         pXV4iDFB1F/fPz9QtAn7C2Lf4zEigJ9ILGfDdXKmr0kgQF3oWE30cNyVybu2XgkYOGF1
         g/lmDMghA5juHFX0O7t4VSeTtEyYWuRQs+Q40BBB3JNiJ3b2NhIJ03tdEo+pWoXBaMyS
         T0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqU90PkBJp4/VPA2/Mvy+tpLgZVSeCw+RcAj8ZjLHq4=;
        b=CHz7ogk5CuRB7gs3fWB7oP5Yp0W+QqvAmVDK8QnSQqCNAQmDMl9r+eyCyVEk84NkXt
         9K6B57damBwvRBFonNdGpZLB5AXGQ6JjN2Q89LFW+rHPhGxTyzx1RI+kpmcAhAQE1ruE
         /N3oHt0PbFHPB4DTEBIDlKv1eUVYnlL9XZCWt3E7MuyQ2NGgEIQ59xOdOiWFWVlcBZog
         L2HQo/AKBr4ogBDh53uxHY3bR+F8w8RHYLfE6+lUbgUc2GCLNNrTEtljWWQJOIHhXcMv
         1QXPjLQxp+AKcB5AV5c/hL3k/RlrHiYAnc0PiXN+koT9Ty7z7IyvvVCcBF3ETJKz/6Bz
         RE6w==
X-Gm-Message-State: ANoB5pmoU0EChQIEu10LL2YmakSW4WEFGI+EjwNxwG5U/s9kC01W3A+2
        lAY8qkfYLNDfMDvoEVW2DwH1oQ2VNYtVKmQhbDU=
X-Google-Smtp-Source: AA0mqf7rrniMIY9lEkEprtKexE6t9rqOfmj0axr5yN9jnAe534TmPcUO3quMG6mkvpwVqP+HPQgCug==
X-Received: by 2002:a05:6214:568e:b0:4c6:f75d:3313 with SMTP id lm14-20020a056214568e00b004c6f75d3313mr28034519qvb.49.1670871595990;
        Mon, 12 Dec 2022 10:59:55 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y8-20020a05620a25c800b006fa8299b4d5sm6280605qko.100.2022.12.12.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:59:55 -0800 (PST)
Date:   Mon, 12 Dec 2022 13:59:54 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: small btrfs-zoned fixlets and optimizations
Message-ID: <Y5d6Kn3rn6/o7xiC@localhost.localdomain>
References: <20221212073724.12637-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212073724.12637-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 12, 2022 at 08:37:17AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this fixes a minor correctness issue and adds some minor
> optimizations to the btrfs zoned code.
> 
> It sits on top of the
> 
>   "consolidate btrfs checksumming, repair and bio splitting v2"
> 
> series.
> 

I had a couple of comments, the rest you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
