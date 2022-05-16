Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF0E5287CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiEPO7A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239281AbiEPO65 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:58:57 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6913B3C1
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:58:49 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id kj8so12296033qvb.6
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ijZ+l+nKugLFDITXjbRs2tl/iQPm/uOdQDG9f0Q6Nhk=;
        b=ZB83MSb8klp8/7xH2RHmLY101Q1RujXdxw1MPmPt5WhRMCLsqVVVN9uIoQEcTMLIJG
         6qMqvks2a+8DIU4SGynkA6Fg9SJ+WrxLl7rYaFjuE4HRMNbtZCjml7KEzAM+NVs/Z4nq
         nZXChZG6qh8eJppd0nG4sWqze2U1wPwn4a4O+3s2ydKBR6i8apn/TFwWBuNqIPDidehK
         5GMj/dOfZSLgt3OiGwJtcB8p32oU6AHZauJAxM/iuXSHwlGTQav/Kvx5uKZYR1ayQnym
         kTgvWJTFcPwLFSScfia/Stn73pkll+IE3OQHllZu4xBWdMf5SH7/eUeMvB175NrG0eXo
         sOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ijZ+l+nKugLFDITXjbRs2tl/iQPm/uOdQDG9f0Q6Nhk=;
        b=nteUvk5hrYMIYBzl0JzGqhRqT/rg4ljGqNGGdKqQSSM/ke7c25vofVWBfcn1gnbksp
         8O3F6mwVIGK0T7ZfRqXujySQT9NH845ar4kGl7MXje9/cRLQe0628KJGY/+a/4p2II30
         hi+MzPgJYguz/2NWqn+t6cLnfhvxfyFtbVUYo5hUF2O0RdbYocroiIMwZhyfOqquBw0+
         gKb1Y2XSyQhPZ9PBYgBAP9pdR/1i9URkWPFrj54RrMdnDKkOXUOAgkQsxVvlEsIVSuiM
         MAQ4uG8q9IdDaftInsdVt/ysybNg4Bhu/1JWVkC0hJVDH6XuXPY2Vek2rYw1FhbzmGXw
         MlWw==
X-Gm-Message-State: AOAM532JumsLnmeB1r/Kkg0+liKea+c3j6XpC0WuuRRfmO3ge4lNjcFe
        EtLNIosC6F9/kAU9qImLqqYzEZocRFaofQ==
X-Google-Smtp-Source: ABdhPJyium8UxBArzMOHMBWbCY8dgz8kMUgp0f33zNG/vw4eRPn/fPh82rJZ3Ux6h4hTPMzfW571Og==
X-Received: by 2002:a05:6214:21af:b0:45b:694:47ce with SMTP id t15-20020a05621421af00b0045b069447cemr15630073qvc.33.1652713128806;
        Mon, 16 May 2022 07:58:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i13-20020a05620a150d00b0069fc13ce246sm5653684qkk.119.2022.05.16.07.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 07:58:48 -0700 (PDT)
Date:   Mon, 16 May 2022 10:58:47 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC ONLY 0/8] btrfs: introduce raid-stripe-tree
Message-ID: <YoJmpxKoIUKWyevt@localhost.localdomain>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1652711187.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 16, 2022 at 07:31:35AM -0700, Johannes Thumshirn wrote:
> Introduce a raid-stripe-tree to record writes in a RAID environment.
> 
> In essence this adds another address translation layer between the logical
> and the physical addresses in btrfs and is designed to close two gaps. The
> first is the ominous RAID-write-hole we suffer from with RAID5/6 and the
> second one is the inability of doing RAID with zoned block devices due to the
> constraints we have with REQ_OP_ZONE_APPEND writes.
> 
> Thsi is an RFC/PoC only which just shows how the code will look like for a
> zoned RAID1. Its sole purpose is to facilitate design reviews and is not
> intended to be merged yet. Or if merged to be used on an actual file-system.
>

This is hard to talk about without seeing the code to add the raid extents and
such.  Reading it makes sense, but I don't know how often the stripes are meant
to change.  Are they static once they're allocated, like dev extents?  I can't
quite fit in my head the relationship with the rest of the allocation system.
Are they coupled with the logical extent that gets allocated?  Or are they
coupled with the dev extent?  Are they somewhere in between?

Also I realize this is an RFC, but we're going to need some caching for reads so
we're not having to do a tree search on every IO with the RAID stripe tree in
place.  Thanks,

Josef 
