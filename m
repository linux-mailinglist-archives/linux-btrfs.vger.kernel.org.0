Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474EC453473
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Nov 2021 15:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhKPOmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Nov 2021 09:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbhKPOmG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Nov 2021 09:42:06 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4DAC061766
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Nov 2021 06:39:09 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id s9so13851617qvk.12
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Nov 2021 06:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y4rp4w5g9tOzCpXDISGho0PwFxWvI4HiScgXtcD8GSI=;
        b=KcXz+XspLWE0D9OZhl56ZNPDd5Nfez19xW9KQslO8B/cFfwF8l1tzeJ3FX/ksvc7oe
         B33mjB8jKy6OudmtcX44bERerfNSD2xKONzvG9sd7kqGOrJ0dOlGgGAK4rwDkcgBoH8C
         J43JDGK2vJBrAQ60ZZw7oXihfFAAsl7PwRSX1qVT3+jKJAcmvH14o7wk7mQxjyJ+hu55
         aZ9aei49dzFOppve+3P2wuEij0YqTbFzPuvoG+RPWgERoI2dViRKUrqslNIE3ugFQ+Vs
         YpuUxG3ZBEnukhaFzW2YfXSWSaghf+iV+5w0y1j+c7Nj5MasTeNL3nR7Giph/32pcE78
         rPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y4rp4w5g9tOzCpXDISGho0PwFxWvI4HiScgXtcD8GSI=;
        b=batIBoPINv75yYEOwDAEgaV6Vcuz8Gal+T9chPlwylYDxAPFIDAfdq2cQORNzaqD22
         dnnSBRHj1w9hm1qzkjH4AYR9+s/0tQZmU1tb3jI60WAZZziiSg8lx5m2DfdA4jGMQhOm
         IkNX94zaloO/25UFmDXGZdXovSZTNOrmqXPQbNyx9kK4BXFKLtQ8gZhsFpZS293By6CM
         P41X7bBj6b1e+nn6QeK8O4X2Ihh0aSovRoiapVGPKQBjIxutmufEoWLmL8HyOxTsV7xJ
         q2fGwA5vRVuzKSY9EqPQyYZ91i08mNOnQiJHwa4yZyg6YRGtcnLsnD/nayEpE+BYYVLZ
         uUhg==
X-Gm-Message-State: AOAM533kQ+gYn8XTYvqQTbIUBTvukN4qQS1yZsSR66iGjdJ14KjKDJ5C
        kch/fUA8CYEKO6g2ItuNWLQ3bw==
X-Google-Smtp-Source: ABdhPJxiQSK6ABFQXLym44q0Nv8IwKGU/aSiRa1a1s8ekccvD8w8TV08iAyjWListMEM8apF8zGCjg==
X-Received: by 2002:a05:6214:1cc2:: with SMTP id g2mr45809594qvd.56.1637073548011;
        Tue, 16 Nov 2021 06:39:08 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p18sm4964819qtk.54.2021.11.16.06.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 06:39:07 -0800 (PST)
Date:   Tue, 16 Nov 2021 09:39:06 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix error pointer dereference in
 btrfs_ioctl_rm_dev_v2()
Message-ID: <YZPCii3nsASV6Ofz@localhost.localdomain>
References: <20211116115025.GC11936@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116115025.GC11936@kili>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 16, 2021 at 02:50:25PM +0300, Dan Carpenter wrote:
> If memdup_user() fails the error handing will crash when it tries
> to kfree() an error pointer.  Just return directly because there is
> no cleanup required.
> 
> Fixes: 1a15eb724aae ("btrfs: use btrfs_get_dev_args_from_path in dev removal ioctls")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
