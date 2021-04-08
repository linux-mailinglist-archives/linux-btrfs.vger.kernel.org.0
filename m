Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E8F358BF2
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 20:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhDHSLq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 14:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhDHSLo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Apr 2021 14:11:44 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9321C061760
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Apr 2021 11:11:29 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id s2so2128339qtx.10
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Apr 2021 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QwlisBabfvfJ/B/am2Pd+ET2zaH686EtW/Qi+zqOA4U=;
        b=QwdXHh0KRiXaMaBdoCDSwfqGRyfAhNtP9J4/ZivAgcESU2M5zeH8WGrAABvodMXw4n
         KjmrPZtdL9/VwulfMvTdcjJ1Z8DufDxyTl3gQRKKutKVokO2wHKbPibr1Ef3LzvwEsQd
         pVVEF7ELWK+DUDnIveDcUicdxS0cJirxSFOfOXAYfoZw0cr0MTtbvsCXiKcEkxQep7E7
         AwA6ZyTEDbJbuprkBmfzdbew4/rrL3D2wC9B5hkFLMskEw1wRT7daX5+MfsHHIBup2sG
         z6X9fc8DQBkN0JL3+nbsUPZxzi1mKf6ciWHNwTmnYXxIISeOYHd9qHMCxVcqSVVo9frX
         0n3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QwlisBabfvfJ/B/am2Pd+ET2zaH686EtW/Qi+zqOA4U=;
        b=Phtxlqg4v+0ZmsR7ZXNgmzBkmWhFyRaDq571AiAKaJsJv/dKN67Zi+3gbvlPvYqhA9
         CqmznR6CtVIsC/PY7FoEtdbYEdwIMuhXklywh9rRr3jyVRZvxNnglPMCnX5jbrz1iP02
         BxvDAVgVuSzLtmznHY25XTTV46hMvAUa+9gn3V58t/aKY7kPCp4uaptaY+IzjlwqIDw+
         mD+9t7fCMxx32OtQfx6YAobzfFXnJ6x/ma2j0VRncq2wWnZDv0EELCKeQNtY2lwdhkC1
         mTyhRMCyGB07VvqfZgZ/j6Lo4FYcJsXs1RJZzF2MnHj6050N2TsS+bGMncO4AiZZmQzt
         KArQ==
X-Gm-Message-State: AOAM530cKdVTKAhuD9CGXyE3YwD9GK7fDaOfeEWNNkpKPhP1VSmGI4mT
        O2yLt75n49BX6VZmUu2gQ3bJ5YyJ8hmbHw==
X-Google-Smtp-Source: ABdhPJzkUqs56luN8qi8+FLuJC2p0y0NNK6pIl7Cq2hCzKx+NCfiiTpPsFQ5b7uM5Y0+R3DwYpMyOw==
X-Received: by 2002:ac8:5313:: with SMTP id t19mr8703647qtn.148.1617905489090;
        Thu, 08 Apr 2021 11:11:29 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::11cc? ([2620:10d:c091:480::1:a6d7])
        by smtp.gmail.com with ESMTPSA id h14sm143305qtx.64.2021.04.08.11.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 11:11:28 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: do more graceful error/warning for 32bit kernel
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Erik Jensen <erikjensen@rkjnsn.net>
References: <20210225011814.24009-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <94dc96e5-fd89-87de-c585-edaea3fc51d7@toxicpanda.com>
Date:   Thu, 8 Apr 2021 14:11:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210225011814.24009-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/24/21 8:18 PM, Qu Wenruo wrote:
> Due to the pagecache limit of 32bit systems, btrfs can't access metadata
> at or beyond (ULONG_MAX + 1) << PAGE_SHIFT.
> This is 16T for 4K page size while 256T for 64K page size.
> 
> And unlike other fses, btrfs uses internally mapped u64 address space for
> all of its metadata, this is more tricky than other fses.
> 
> Users can have a fs which doesn't have metadata beyond the boundary at
> mount time, but later balance can cause btrfs to create metadata beyond
> the boundary.
> 
> And modification to MM layer is unrealistic just for such minor use
> case.
> 
> To address such problem, this patch will introduce the following checks,
> much like how XFS handles such problem:
> 
> - Mount time rejection
>    This will reject any fs which has metadata chunk at or beyond the
>    boundary.
> 
> - Mount time early warning
>    If there is any metadata chunk beyond 5/8 of the boundary, we do an
>    early warning and hope the end user will see it.
> 
> - Runtime extent buffer rejection
>    If we're going to allocate an extent buffer at or beyond the boundary,
>    reject such request with -EOVERFLOW.
>    This is definitely going to cause problems like transaction abort, but
>    we have no better ways.
> 
> - Runtime extent buffer early warning
>    If an extent buffer beyond 5/8 of the max file size is allocated, do
>    an early warning.
> 
> Above error/warning message will only be outputted once for each fs to
> reduce dmesg flood.
> 
> Reported-by: Erik Jensen <erikjensen@rkjnsn.net>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This doesn't apply cleanly to misc-next so it needs to be respun, but otherwise

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
