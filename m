Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E719646D5AB
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 15:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhLHOdU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 09:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbhLHOdQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Dec 2021 09:33:16 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9D9C061746
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Dec 2021 06:29:44 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id i9so2098900qki.3
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Dec 2021 06:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UHD7FxYsl6l2bo9S9jY86Ac7vNcRSTImbH9fJDc0Nkg=;
        b=ftT1sM5w8nhkqiD2RgYc6VuteJ3alZiz/NE3nrjyHAa8SwIdfs1yw6T/pGeSaO3keg
         JO11DyhLl37N0AcXNLNesZHQmn3M+x5SRmNSn615trsZ9e7xbajNZmJAlkeyfZNO+gYK
         lWpj6wnX1njTH59GGAblZ5ctpXcaiwG+idccZnGIFk1LTnR6Wyqre5wcdOxfG7GFXfrn
         MT97GfbqamaenbZfDFrPiVHAwwy+D6XFj1WVXwg8CCDUffqPBbTo6AX8sIRdACBq43/b
         NcWIdwB2M6KjulbUylb5/FW8BL//3EKb5dLSAXLPmgHTnLrCSwoeyoVdWE15/laxBxvt
         g/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UHD7FxYsl6l2bo9S9jY86Ac7vNcRSTImbH9fJDc0Nkg=;
        b=N+h7GX+UZJihvxtSc1edrOSDROWf9FG8CGN2ID7EKHWvy+mDYiCOcCygABQEoZ3uaP
         i1ZSfBEcD6XPsWsiiVIjD5UmNg/ybNqZ8K0n48roztwN/5SbC8WS/ipTWqw0nvOzv4Rk
         tzVPLvHpGiZtKnQoF3Wk6gupVQGtpeff3+C6qiHyShrTcri46VGe5+SPDlkr4U+3LGzP
         9OwtqT07xAB+OtKVkTsCURqZWpkRJJrSalUqqIsMil/n9/Y7vJUw2xvVK0MpazRWEPpJ
         l7rafEFhpTcs7t4yp/YcCxJShmSIv2D0bwgq2o2b9z5MUAeIyv7M9wa/GS6Ns3scBvzV
         /vag==
X-Gm-Message-State: AOAM530HeZGSk24jKq2ITa7U+fS/rDnwkjSpW0PZ9PLG+1kCeh5QeQe+
        Kt7TwYNqp6xWPGHtYm8UFUuteuVE0OQuQw==
X-Google-Smtp-Source: ABdhPJwXh0cGmVjxh4+n6KIgikFpKi6q85qDrgYsNcthstMAAguHRT/jGptlL4ZNwdPEDfiV17t4nw==
X-Received: by 2002:a05:620a:a50:: with SMTP id j16mr6843757qka.766.1638973782687;
        Wed, 08 Dec 2021 06:29:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k18sm1690528qta.24.2021.12.08.06.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:29:42 -0800 (PST)
Date:   Wed, 8 Dec 2021 09:29:41 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: harden identification of the stale device
Message-ID: <YbDBVeyJ8YhOw+Bt@localhost.localdomain>
References: <166e39f69a8693e5fe10784cdbd950d68f98d4fb.1638953372.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166e39f69a8693e5fe10784cdbd950d68f98d4fb.1638953372.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 08, 2021 at 10:05:29PM +0800, Anand Jain wrote:
> Identifying and removing the stale device from the fs_uuids list is done
> by the function btrfs_free_stale_devices().
> btrfs_free_stale_devices() in turn depends on the function
> device_path_matched() to check if the device repeats in more than one
> btrfs_device structure.
> 
> The matching of the device happens by its path, the device path. However,
> when dm mapper is in use, the dm device paths are nothing but a link to
> the actual block device, which leads to the device_path_matched() failing
> to match.
> 
> Fix this by matching the dev_t as provided by lookup_bdev() instead of
> plain strcmp() the device paths.
> 
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

We already have the bdev for the device in most of the callers here, the only
exception is btrfs_forget_devices.  Can we change this up to pass in the dev_t
of the device we're trying to remove, that way we don't have to do the lookup
over and over for the path of the device we're trying to forget?  Thanks,

Josef
