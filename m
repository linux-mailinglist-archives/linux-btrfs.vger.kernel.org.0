Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A69478F18
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 16:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbhLQPIW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 10:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbhLQPIV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 10:08:21 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C35C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Dec 2021 07:08:21 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id js9so2591701qvb.12
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Dec 2021 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eqFQ7i3QDcyqT2Ls6j3G58hfc9FCQlrooRih/ePV+Y8=;
        b=2s0tZ+9NjSOnziq2qqozAhdaGvifSsd52xOlCH9NGlMvsli7W7C1hVx671en2ldxJv
         rRlgFGTkVlq+Z2CHUWK1Z1jV2I0tqHm3YP2OJPEkhpb7Xfga9JaTXrzZoJv+yZ63z7/h
         luydyd1UKZOhKflAP6tOSta0kswQn3GL8H8XxkANmQJ4XjriRtIJSckUpqBmwrhdEq8d
         axuhg1pg+P89RPHn/cOJzAj91c+fg3dBrxsDrk1IhgIwlDx8cv8CtopbYNhkjKZiNCeS
         aX872VR3dMMuOt4pnBlgXwo9AUrs7zbL35GpiVYEsNVlHi9EhdAfa0gVZszVN3dcFaCV
         qJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eqFQ7i3QDcyqT2Ls6j3G58hfc9FCQlrooRih/ePV+Y8=;
        b=FqQUVERalfHAvEo12CnRQ5OxQi9QoeBUZeUMZZ6Oqsneoap7kgzqngolIxJYXselTL
         xveXKR462VeMqx7w1E1WrM3tgy7qcx+z4Cnggw+0p6DoLxV+tJpyhJU26K0t7Lb75qh6
         IaKRiN2eRq148pBNC0tBC2fK0Rd5lr1bHkt+R2VstXlA+B+4Y8Bv30ofEX7zeG65tVVK
         OWekINToZYKrwI7ZyaQaSgaNchMH5FQfnVy9KTjF3CGDCUQOHe5II/1+6weCbC+FpTzP
         mNEplatcVm5gD17XGsvfFkwGKQTNUKr5AeqjBnC0soKpaz3Q29d8eNRctGtd3W2kPyKV
         n+wQ==
X-Gm-Message-State: AOAM531tIn8zxgKcuWIwZVQsGG+yWsl8FgyzqElO8En2AFsy+BwgphNv
        1ll4ts+NUjWfDLQ5y7m2n5Gqnw==
X-Google-Smtp-Source: ABdhPJw0xPhCiTDe4W5jCBhnIX8MEzW7DCn+UP1w1MoAMf7qv7Ms7ZU/S+PZ8PXJa3YWiEaJ2RTJMg==
X-Received: by 2002:ad4:4eac:: with SMTP id ed12mr2836052qvb.59.1639753699813;
        Fri, 17 Dec 2021 07:08:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d11sm6695181qtj.4.2021.12.17.07.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 07:08:19 -0800 (PST)
Date:   Fri, 17 Dec 2021 10:08:17 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: respect the max size in the header when
 activating swap file
Message-ID: <Ybyn4VfgnlXVHdUW@localhost.localdomain>
References: <639eadb028056b60364ba7461c5e20e5737229a2.1639666714.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <639eadb028056b60364ba7461c5e20e5737229a2.1639666714.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 16, 2021 at 03:00:32PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we extended the size of a swapfile after its header was created (by the
> mkswap utility) and then try to activate it, we will map the entire file
> when activating the swap file, instead of limiting to the max size defined
> in the swap file's header.
> 
> Currently test case generic/643 from fstests fails because we do not
> respect that size limit defined in the swap file's header.
> 
> So fix this by not mapping file ranges beyond the max size defined in the
> swap header.
> 
> This is the same type of bug that iomap used to have, and was fixed in
> commit 36ca7943ac18ae ("mm/swap: consider max pages in
> iomap_swapfile_add_extent").
> 
> Fixes: ed46ff3d423780 ("Btrfs: support swap files")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Validated it to make sure it fixes the problem, you can add

Reviewed-and-tested-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
