Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED94A44C2B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 15:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhKJOJP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 09:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhKJOJO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 09:09:14 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC934C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 06:06:26 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id f20so1864421qtb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 06:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c/bLpxSY06zx4+wEd5036OcDao2/x4wMjIncfTYGPxA=;
        b=UMNC3cFdu9oSVTapZaeuWVImXFK06FfQDjE8GLPHOCQNa4GPS4p16Hz0br+EEPzyNp
         UokdWWDYDK9KslZvUUpO5hF32dMQj5SzrTYbYxNOwK3suwSK0eJgUYiA9jnAy3BOfjpD
         HPkY2KvfYIIJpEEmMyEa5eqxvhUwJ6TRl6FeRtTIol6iU+/lRFRQrGGEr2U3kg6v/uoL
         OGSJBJO0C1olR2owQhSqDZgfjMfp6fHCJ8BayuTLjjPttOgz++awM70lSsFzKFlXbbqa
         kzco98O3pTPvPi8xJBaxi61GEuBbFuiu6x0l/htyjl6N0hjE5odvm/xaOunMoBrSz+Hn
         GEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c/bLpxSY06zx4+wEd5036OcDao2/x4wMjIncfTYGPxA=;
        b=EdXSGV8tk+qNQM3Jp86oOGawg9rVEOepgVd2STEds6YFjlbgSK7B7UdjJJyTEC0CRx
         Pm9hJO1fBwDnSsBDnCsjMrH4Qi4pCNzj7uJlHlb4houR86v5V96gq1cQahzOSEl7310S
         WOeGA4UP2M+UaowjB8Th3QGKL0xxltKW8wEnZf7UkuqcFSq1SlIHX6leNDuNXFn3XyL+
         zUtzXhRbwoH/35s3++epcT63MtHLLaEI/LKMP2ftL5IoAqCFeZrEKf5iNxhQXz0IHQd9
         JxcviDtULto6xHQS3auo2h19Y/WdQ63xMgDtu/Dshkovk4Fu8tlEQD5xCRmGUhy2RfLY
         sbvQ==
X-Gm-Message-State: AOAM53103s+swzuIFfzTyyod4g+V3Nlvh7Z+fR+Xbghe0tjqGnNv15Pt
        FJRRiTAJH11rcyWnhg6jxvdq5kvCebEw1g==
X-Google-Smtp-Source: ABdhPJwEapcTUm9JOpQyyrPs6Dq9E1LXxW/hHjOeP9LOmXkxS+olbw3CfLGdn4rtkDEXTFfKtv5j+Q==
X-Received: by 2002:ac8:4d87:: with SMTP id a7mr17915265qtw.410.1636553186015;
        Wed, 10 Nov 2021 06:06:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r10sm14471767qta.27.2021.11.10.06.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 06:06:25 -0800 (PST)
Date:   Wed, 10 Nov 2021 09:06:24 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Deprecate BTRFS_IOC_BALANCE ioctl
Message-ID: <YYvR4NmVNb350BUU@localhost.localdomain>
References: <20211110114104.1140727-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110114104.1140727-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 01:41:04PM +0200, Nikolay Borisov wrote:
> The v2 balance ioctl has been introduced more than 9 years ago. Users of
> the old v1 ioctl should have long been migrated to it. It's time we
> deprecate it and eventually remove it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
