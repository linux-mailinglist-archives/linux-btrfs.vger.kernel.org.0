Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC864274A66
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 22:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIVUvu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 16:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVUvu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 16:51:50 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF4C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 13:51:50 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n18so16835044qtw.0
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zA6Z+2p/JUVWL8G7o88mdK4evR00/OIx0D0l0A3L3hY=;
        b=bLylQRnPah6nWbk6rdB7pcKzhuz0GQmPXm6p95L2sbsdVeoZA+uOhsDX72fmEB6Yar
         173gwD1G/a/9ihWb4XeIEihMQO4nY4yBlshzmqEKShuhvWxDc9dsd9aFdPhvRqwylcKH
         8dE6MlHI6klDFoYrwThuRaScZ84IjXPcecHTq/tQGJF7JEvQFvMJnQ3KrD/9MTl51tKS
         R95TcLtm4YsnTXs+P4hjhnUYcZ21ABc0Z+QfvA1zM4emd2OolWo6sIC1DhxO9N6Ywx0y
         rnHqlQUt4GsQv/CQAsoD5kwyvVlrDsNNjfjz5rpKg48tfmAKYg9sgA0/IGeq1bkbaS+F
         +ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zA6Z+2p/JUVWL8G7o88mdK4evR00/OIx0D0l0A3L3hY=;
        b=IOwFB4F/GnDxF+awjKZDgCu+8iFKbQOWopFZE4w7GNUtykxnbgdUYDj0TtCVY7kdyh
         +zb4kAuHZSUFdgCZYuPm6kuxWbMl5yl9ciWMRcWxYhJdHxBr9vHBs/lPaJfsPrJpBSgp
         et1WuQezjkMMXvkcLlQXAxV5qkaBuHMOyrJHU6MVszklQRlXN/8QZE3tDUFmy0UUNcy0
         Ny/VGcyCSdfKHPnh1uZsR2PugfMnuZ4jR6sFs/2bqOPEIvawYxusR/f8Q2n+DGPLh82r
         wJkwbJ8FvrxDutqGr53uBZl5RiJGCJpJ79vx/8R2D2fU9hqVPk4+SYNteXf3huWLn2sW
         zFYQ==
X-Gm-Message-State: AOAM533phOg7jSVbc81HzSn2VzJsU6R7OWExeaPcdZuYXXeXRS4ySDSO
        vNUUw/P/AvMRuw6ZVFekJwPyJBB8QlMUEIS8
X-Google-Smtp-Source: ABdhPJwgxxrPArNnkopQcWYoijOgu9kXx58tQsbBn8HnCFAjQJ7tx7NxEun0yhv38zqev7TK9HbZXA==
X-Received: by 2002:ac8:5341:: with SMTP id d1mr6703463qto.176.1600807909671;
        Tue, 22 Sep 2020 13:51:49 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z133sm12595687qka.3.2020.09.22.13.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:51:48 -0700 (PDT)
Subject: Re: [PATCH] btrfs: fix false alert caused by legacy btrfs root item
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Martin Steigerwald <martin@lichtvoll.de>
References: <20200922023701.32654-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <906ac89d-c01f-8bce-3a3c-6d0c476f1dd5@toxicpanda.com>
Date:   Tue, 22 Sep 2020 16:51:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200922023701.32654-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 10:37 PM, Qu Wenruo wrote:
> Commit 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
> introduced btrfs root item size check, however btrfs root item has two
> format, the legacy one which just ends before generation_v2 member, is
> smaller than current btrfs root item size.
> 
> This caused btrfs kernel to reject valid but old tree root leaves.
> 
> Fix this problem by also allowing legacy root item, since kernel can
> already handle them pretty well and upgrade to newer root item format
> when needed.
> 
> Reported-by: Martin Steigerwald <martin@lichtvoll.de>
> Fixes: 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
