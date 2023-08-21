Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3426E782FFA
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 20:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbjHUSIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 14:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjHUSIq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 14:08:46 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2C011C
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:08:43 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-579de633419so42881027b3.3
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692641322; x=1693246122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYVUhHD6dudzsepCSdN4uHZzxrx7CdEtQcU/ayg1z5Y=;
        b=Sf7usMxlYSSc0bpmTp6ok6M29bQ6u4tZTdfVT/wxAMmc8MyURjVEeKjurqTrH6e26S
         snofd1dTi5yOQIwYuvasQg8IB8gTvSy29WbQcYg2pJolNUZ2oNUX0901e3smLWICziCd
         YdrBHiEGKr+Bk1acUazPvOhwBkQGps+b/jaZO7didNBf3uX+Sjgp2PWBu2k2xKgel7RT
         OQZIAP8sKlFTg4K8pbzoJ1uRvHkxJppBG1L9Vhf5jVc24RQ49PdQ4Na6J6znrjSsiNLw
         YiGurF55kWEGwppF4cMGqe5kfo3CYCh6rMXMAoQBZw6JPLuY24TQmWyqsFT3WdztpQJg
         /3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641322; x=1693246122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYVUhHD6dudzsepCSdN4uHZzxrx7CdEtQcU/ayg1z5Y=;
        b=TA5TH/gisoMka5ZqZq6ZgDymB5Rd7n9lYKdjob3fONb2gZjHThocA0DIcQx2vKYp8k
         YxKkvHW54cPRPrmCuidmdmg/gDIqzRUb/AMGBuJfJqk4SzTOVVwItYEAA/heWogkmfpK
         990GlknVm1FharibCdX4+1IyJpG3MGzwn6U3QTgs8yCE8WdtqGR8pGbqgtZ/2eEH76+S
         loG+oSGToabmdyUqf6LXLWrfxZtoqBKQqkPdUkH8ffOdXOcIX+G90Y+O0YSaEnrQLxF4
         eGI6hDW1ByQw8fxjp23Dn47ds+KrPZCZJodHduBvrAHTELFO8btzfXfwUW7D26KwkMoE
         dQdA==
X-Gm-Message-State: AOJu0YxnYIx/ndMc1GoLrHnm7t2CgqE+rljVj86v1HMr6jHqvOjPY8vc
        U0NcXqjsNh1+kwLRHnK62ifPdw==
X-Google-Smtp-Source: AGHT+IG38e6hSFZSCMxXVfPF+WvOEPsaZ1l/h9UmNyXi4fAzQi2rMokw04JquxFlkrsIqdRKYJwWSg==
X-Received: by 2002:a5b:dc3:0:b0:d62:bc43:426e with SMTP id t3-20020a5b0dc3000000b00d62bc43426emr6936524ybr.43.1692641322420;
        Mon, 21 Aug 2023 11:08:42 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v17-20020a259111000000b00d74b8fa3497sm636237ybl.20.2023.08.21.11.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:08:42 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:08:41 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 13/18] btrfs: record simple quota deltas
Message-ID: <20230821180841.GI2990654@perftesting>
References: <cover.1690495785.git.boris@bur.io>
 <749ea44143d910a3aeef915f2cb19081ac8d2ede.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <749ea44143d910a3aeef915f2cb19081ac8d2ede.1690495785.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:13:00PM -0700, Boris Burkov wrote:
> At the moment that we run delayed refs, we make the final ref-count
> based decision on creating/removing extent (and metadata) items.
> Therefore, it is exactly the spot to hook up simple quotas.
> 
> There are a few important subtleties to the fields we must collect to
> accurately track simple quotas, particularly when removing an extent.
> When removing a data extent, the ref could be in any tree (due to
> reflink, for example) and so we need to recover the owning root id from
> the owner ref item. When removing a metadata extent, we know the owning
> root from the owner field in the header when we create the delayed ref,
> so we can recover it from there.
> 
> We must also be careful to handle reservations properly to not leaked
> reserved space. The happy path is freeing the reservation when the
> simple quota delta runs on a data extent. If that doesn't happen, due to
> refs canceling out or some error, the ref head already has the
> must_insert_reserved machinery to handle this, so we piggy back on that
> and use it to clean up the reserved data.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
