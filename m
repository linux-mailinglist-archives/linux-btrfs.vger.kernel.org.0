Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ED75B877D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 13:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiINLsU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 07:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiINLsT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 07:48:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052557B7B6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 04:48:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n8so3858473wmr.5
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 04:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ekhj2cbi3pFqj5WaOvlPJtFmfVNyvuw6Du6P5WWhCmQ=;
        b=FuvRBy/YDM9LvorkFgZMIarw2akZH9vRnqqyhXP4k4jBOCqDTdBb19LVMnYiY8f/KT
         Ac8yoGMc0IM7/slzBhY+mUCg70lPo4PTje6o4SeKZfGlbpbep8XuBNqGbD1vPCk3SQ7/
         k0/fIt9gCA/7yY9b3TuFHeyaudSHRxPL8W/uv2JsW9w5PhZwyFvP66FkbmQ4vdMDliSF
         U6oj+1Ag2EPqDq3bYXfISpy8s7xWiAIIm70MSaPiR3gvV+pa1mKtP5n8Un8YJxCaXTsU
         +jehRcd4Tur+HMGOVDfj1OkDtsXFw1Ij31j8iYZdnQDYyNwrqDF6ajaYSf/hlAW+igEL
         tu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ekhj2cbi3pFqj5WaOvlPJtFmfVNyvuw6Du6P5WWhCmQ=;
        b=6oBsgngVWGui4Xx1yEeAP38FB9VI9EYUV2oavplluT9jCTVUXV5NB998yftH+eY4v3
         XTe4a8nZ5bNXThcJRROu4+bb8NoQdvi+eYZmgDTdshO4dYc86vgYeYimXzDobYfAD3Ki
         Fbgp6qdp+sP0J5Lghxt84sXRUYTeE+W/tRFDjLXq0S6k65afd6fAiSAUPNVDyxQdyUU2
         fZPgEQ5wMS8kFFWzh+3L/bw5h1KhS7miWyVANIt7FUVliJnxP1ja5oXZ2R1des9pUnAo
         bUOx+mRXZlNEAdktWviNhWAW+rhAOEv2pTffbBY4Rh4Zi2G2ndj1AJr5vIgnDcrqyJhu
         Ib4Q==
X-Gm-Message-State: ACgBeo1IrIg9iHHMRUusJJDIUSzdVePbi1qoNPJq+b6ABPTJm82PlGJR
        7ZOWaQJxFPL+MAickMR/IRWbHg==
X-Google-Smtp-Source: AA6agR5ezVjBKHmGNFAxhaPLrFFF0Krm6Pp93Ol6cKN8R23OK6bW1ticeztjxY3umNpndws1iPQzIA==
X-Received: by 2002:a05:600c:4793:b0:3b4:7276:1c5e with SMTP id k19-20020a05600c479300b003b472761c5emr2866737wmo.118.1663156096067;
        Wed, 14 Sep 2022 04:48:16 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c198c00b003b47e75b401sm13069133wmq.37.2022.09.14.04.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:48:15 -0700 (PDT)
Date:   Wed, 14 Sep 2022 12:48:15 +0100
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
Subject: Re: [PATCH 5/5] block: remove PSI accounting from the bio layer
Message-ID: <YyG/f5AjkcKcbC6K@cmpxchg.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-6-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 10, 2022 at 08:50:58AM +0200, Christoph Hellwig wrote:
> PSI accounting is now done by the VM code, where it should have been
> since the beginning.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
