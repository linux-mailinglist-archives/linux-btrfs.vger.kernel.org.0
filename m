Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B153061AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 18:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhA0RQR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 12:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbhA0ROv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 12:14:51 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0525DC061573
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 09:13:51 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id k193so2425087qke.6
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 09:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0h+XKL7NGfCwRp2NxwxQQf1BIYcf3FrtSTfsQ2l7EkQ=;
        b=M0hc9u2kP+aurxy3Xpqwa8l8EITz8uH75fWb5tan1PTAv7gojDAMbhK41YWHUkEy4t
         +Z6+sNkFmpl2gF/KjlrICDeuwnxHghGK6/lY4ljcJiEXyBKb/YefK29XV1qzgePfI8Ri
         TajXhN9RoMtJi0+zNnVBb7IKpEfg98y33FPuWl6dt3Ur2hit3vJ0/XUl61WLLGPdYZil
         MPQ63fHyCWZXQ+u52kztWgE16wkK3mHbnqLaL6UWPAE7J+wLA/wV0X7Aa70an0Dnb7sf
         +FMFUjRJD6Gp51aofOFZAM4V+uy6uykuDEFqn7qABMPGu7aQ0MYSVFNufgg99fb3QBXC
         jSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0h+XKL7NGfCwRp2NxwxQQf1BIYcf3FrtSTfsQ2l7EkQ=;
        b=GFjyNEmjeGh8vF2NzGkPwvIIXkRyWd2HbI8YnjDUsiqYIlIYGvEQswFYkTQBo1xBvp
         ehGkVh1IqEgXO97B9EXph4lCjzCJPNFQlLMZyo//vFMn8E/xlHj3TEP0ppipKN+VeT+T
         QdoVCGFrMTOwWfgMwj/U5FZy9hWM/c2DLKVDMA0MHD9lpggmwFZT/AYfk3sGXsSvyyfw
         wMk9PFKLUPvLONMDraAUSdsGnVbRLgRxH1kt2Crxju1xTB9xTOPlKsZ9Yl4gvkWrJggV
         AaxPP5XJylSd17rp010kq9Boit6cTR1EMGPcpVghRHj/md4bZyEBlLwN7cq+tq7GoNeW
         uPMQ==
X-Gm-Message-State: AOAM533BkwCPHITFryBRLcEkyZduNpAwQ55Qg8WOaT/YsRHQWdUIZOpv
        GKWkQzdShVrwcvvTwvZoQmBY6+VtVNwGeF5E
X-Google-Smtp-Source: ABdhPJxfSfWFCSDe71mXstbqFg9Pxqdn2KVhnJXDaaP3Em/NEJzbtj2aO3hFeA40+V39r2a2823XCA==
X-Received: by 2002:a05:620a:2ed:: with SMTP id a13mr11750843qko.226.1611767630204;
        Wed, 27 Jan 2021 09:13:50 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d192sm1580528qkc.65.2021.01.27.09.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 09:13:49 -0800 (PST)
Subject: Re: [PATCH v5 18/18] btrfs: allow RO mount of 4K sector size fs on
 64K page system
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-19-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <80d753fa-a7a4-7c59-c1ab-138a0126cb91@toxicpanda.com>
Date:   Wed, 27 Jan 2021 12:13:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-19-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:34 AM, Qu Wenruo wrote:
> This adds the basic RO mount ability for 4K sector size on 64K page
> system.
> 
> Currently we only plan to support 4K and 64K page system.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
