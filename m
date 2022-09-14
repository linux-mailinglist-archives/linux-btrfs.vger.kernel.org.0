Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88B05B8773
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 13:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiINLq7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiINLq6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 07:46:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D8E7AC1E
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 04:46:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h8so18288575wrf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=R0+X/Vt8U/YJmmqx4EaockLsNUJKMLE86zCLujidRXk=;
        b=x896VLq/0T8z+7Ik2gVEyES3l8Hvh2btFLNkRDkyFPILpk8pTXgwHjASSECXNYjAWz
         /4nzKNwpCXNTkvMp3wIXm+yfyMEvJgbc0MMk3D9eqte3BBV33uNDi2zp5DN9H7jUKXIY
         QXvEQyfRrTQbfi9CRmk38OQyufCqNJxtBsi780ZltRwyVkT9bfkauohtiuVyIg+158uh
         +dFEzwIdSyjmXHrCx/K924lHgmJPmWJYLsCwaV9AGTR61qVUxaiMSZ2OhTc/JpkYvAPH
         4lWJuFbIHC8bixWnUFa+49kysfkp6O/h1VUzL+fvL4Iut0DY7EPkgG7OYYgpkJLQBkQf
         Dppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=R0+X/Vt8U/YJmmqx4EaockLsNUJKMLE86zCLujidRXk=;
        b=vgU8wki19riwKfHvt3V8mq1A2FdT6psdU2qEZasXwObr3SSTk/mrhE8tVk7min7UKw
         oJNrgohnq7Ut91VXg5bRPAp74KU3Hhp45fj9g82TJbk2vyl/hEqLkWdkIcTOBkTrkCQI
         H1Ahshdk3Qli/JlUAN8LV1S21OVpL2bRr5Xutm/+cIJabiMTPwGgoqc/jGPtBip6Gjyg
         aJS+HRXtT6h/7t5NyX9wvfAujOGIF7mHXecdO54Ef1anLDSqJo/Z4T0jck/fEDv2bVTr
         KScRDsk+EDK/X9tdE22/1m2u/rCtBYzrceibE+ejpbSpR6DJEkzEsyP0sg68HdCjUyKT
         lMXg==
X-Gm-Message-State: ACgBeo1R1/uLKGm+kNk9aUJD9EjGabtJGkBHD8b/AE90b4T9vyMhiCrf
        Vwmhml83bGw/r4/oVXWCYicAEw==
X-Google-Smtp-Source: AA6agR5rGXGDLe/tOLWmuZc+R9A3yuqUfg5LeZ1FohTf0HB09NHH8ytKek+mH6dzb5U83k4gaIwQ1A==
X-Received: by 2002:a5d:47aa:0:b0:226:dbf6:680c with SMTP id 10-20020a5d47aa000000b00226dbf6680cmr21226454wrb.581.1663156014968;
        Wed, 14 Sep 2022 04:46:54 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id y25-20020a05600c365900b003b483000583sm11359663wmq.48.2022.09.14.04.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:46:54 -0700 (PDT)
Date:   Wed, 14 Sep 2022 12:46:54 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/5] btrfs: add manual PSI accounting for compressed reads
Message-ID: <YyG/LlF7TbdHSCsm@cmpxchg.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-4-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 10, 2022 at 08:50:56AM +0200, Christoph Hellwig wrote:
> btrfs compressed reads try to always read the entire compressed chunk,
> even if only a subset is requested.  Currently this is covered by the
> magic PSI accounting underneath submit_bio, but that is about to go
> away. Instead add manual psi_memstall_{enter,leave} annotations.
> 
> Note that for readahead this really should be using readahead_expand,
> but the additionals reads are also done for plain ->read_folio where
> readahead_expand can't work, so this overall logic is left as-is for
> now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
