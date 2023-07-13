Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1CE75250D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 16:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjGMOVA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 10:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjGMOUo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 10:20:44 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617533599
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:20:04 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-cb7b6ecb3cdso138054276.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689258003; x=1691850003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X30PAAzab4VkU/c4CdCG70NwbTvAlKXHGrG96IHFfAU=;
        b=Hl1tLEv5SV6Zn++LXlorKFIoAt1n9Hb9sz3BiXvUuRkwysQOJLPJ6oTshwYa4gE1TJ
         5EULihkSDCIsJnBzYLj44pTtXVvI1Pf8W58BZ7/UrJes2LSg4jqCytmpbq+x/sKBtnL7
         +wDEgAYVPI89F/2erfaRwZF91qCL75wAM8F4caapiKjIwIgf3L4C05ps+tlzr9+Zd7Wh
         2aKIvuDyZkSXoaza38mPZV3/R7+tRELDHIVX9vsSanZh4J58G6lHaFOZHN2syVvDN8NX
         b+iyfyODfU2qB29dCI0ykusvYt8LvP3B2TeDEIgjat4EsM9iZL4agk9d9WUp+beiOmGm
         SLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689258003; x=1691850003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X30PAAzab4VkU/c4CdCG70NwbTvAlKXHGrG96IHFfAU=;
        b=SkiJ8I2HGi28TWISWHLNpxjN+dUN0IxBi5dZ4m/hD8erZ9nqgjFIohdzjbGerAmsRv
         10OZbG+wWd36/gixbU2Oy9wvykk6EtUdPsV1iDspIbeil1zZvkmH5EO3eADV9i93Pw+H
         RsnErqtaFYIZ5D19hiABvt7S5+/STHGBbQ6MAPFy/M00EzldZLLQ6y9JdPbhHV9CKpw/
         yqOm77w+5s+f+QHkkv7UNVjJGazvUI4v3wlf2Ro95r5XzzOZGvTj5gnNtlCEZxFIaivn
         CXj+KQ1mx4Uk5k/GotaF2BSV9Z2IuJHpuL7VCiKx6MX8pWixDI7/KFUEsKmn0CtwDmzJ
         +tOw==
X-Gm-Message-State: ABy/qLblCemEe8CByJgbg+AOJ5ER6pEGj+z0oDJVPEuQRk8r+zBIG/P5
        L/5EiwTi3oR61lm3HzHIhvWMdcOUlrQ+VlGIkhIuEA==
X-Google-Smtp-Source: APBJJlEW6O3q1caRTuq8XjsqJevyTOwmSLS57JEPEeuGXE9GVwPV7Js+LpvnRjvCO0gzKNIuHap+Bw==
X-Received: by 2002:a25:6941:0:b0:c80:804d:cf79 with SMTP id e62-20020a256941000000b00c80804dcf79mr1540803ybc.14.1689258003132;
        Thu, 13 Jul 2023 07:20:03 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x23-20020a25ac97000000b00bcd91bb300esm1423350ybi.54.2023.07.13.07.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:20:02 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:20:01 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 06/18] btrfs: flush reservations during quota disable
Message-ID: <20230713142001.GF207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <0886b85983e4c7ab74574665fb25c9f2f81542bf.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0886b85983e4c7ab74574665fb25c9f2f81542bf.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:43PM -0700, Boris Burkov wrote:
> The following sequence:
> enable simple quotas
> do some writes
>     reserve space
>     create ordered_extent
>         release rsv (store rsv_bytes in OE, mark QGROUP_RESERVED bits)
> disable quotas
> enable simple quotas
>     set qgroup rsv to 0 on all subvols
> ordered_extent finishes
>     create delayed ref with rsv_bytes from before
> run delayed ref
>     record_simple_quota_delta
>         free rsv_bytes (0 -> -rsv_delta)
> 
> results in us reliably underflowing the subvolume's qgroup rsv counter,
> because disabling/re-enabling quotas toggles reservation counters down
> to 0, but does not remove other file system state which represents
> successful acquisition of qgroup rsv space. Specifically metadata rsv
> counters on the root object and rsv_bytes on ordered_extent objects that
> have released their reservation as well as the corresponding
> QGROUP_RESERVED extent bits.
> 
> Normal qgroups gets away with this, I believe because it forces more
> work to happen on transaction commit, but I am not certain it is totally
> safe from the ordered_extent/leaked extent bit variant. Simple quotas
> hits this reliably.
> 
> The intent of the fix is to make disable take the time to clear that
> external to qgroups state as well: after flipping off the quota bit on
> fs_info, flush delalloc and ordered extents, clearing the extent bits
> along the way. This makes it so there are no ordered extents or meta
> prealloc hanging around from the first enablement period during the second.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
