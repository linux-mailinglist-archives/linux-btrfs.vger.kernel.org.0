Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30D7358BE8
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 20:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhDHSFr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 14:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHSFq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Apr 2021 14:05:46 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C962C061760
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Apr 2021 11:05:34 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id z10so3124274qkz.13
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Apr 2021 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q+PWDcqSp6WFNPjOEgkOdUlBncRcn211sLoupJ3aHgs=;
        b=TKdLIUFP39F6tK3TPNYQEyXb8UzI3zzoLe9XiopaOGjZYomklkamBE/J1q4gyaBhjX
         n29cKGMVAwjxWC0pQxFdxaki7oUgSX6G5WBtXKQDWeSHB2MK4qj8oE9X0ZIkdtdxLsDk
         cspDd381ekk3sG+BjdPisIck1kG9zEDu5obg8pEfGaRFqgxLdpH8y+gA0Wc0lpW6AVYZ
         Sm+GD0eOMFDSI9j977+Zt0ap3Zenb1p1ejxp/7WdEEAoNLE3mCND2jgqjgQxpmn9atjP
         c2p4Ys+g78sm/zl1IpH3WsvBf1EHwyjzsnHZVoh0NlX5Lxd+dDyCSnrMQLFbWTxHX0ti
         wDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q+PWDcqSp6WFNPjOEgkOdUlBncRcn211sLoupJ3aHgs=;
        b=pPNRdvcFE40GTBFFgizNcj3XQPdI1PNNjyaUbwuhsziMYkha9Rh2wa93rMEDK4VpvR
         hYqN5JENNieJQ7PzPVevskarfEsVGqDkB29PJzW9wo+LcRY1DI/O5O2rvY2c6fOwwo3h
         AgQP5FnrE/t760YhlWCozudBUSQ4mnXDJ3RduHupQ7c91LlHalFsk84si9UgSAQ0fi3K
         Odxiv6FTQRn8ZK6gyf/oB0AouBdGY9naBc5EjYWzWod1sjph+wXh0owKvaROpij9NZjO
         KNv67y8uJ/Voo6xV3MUZkcL3YsVx8eJ3Z5Ks7AHJvt727DD9axnLXSuCYgQsdTKRePxa
         HUbw==
X-Gm-Message-State: AOAM5328MKUEk+y5SbMgQNPZ1J3GTVU4i7yDcPbki5vo8RHGJsrJxcly
        43RuHP6dEcgdNmuKqGswYw128Q==
X-Google-Smtp-Source: ABdhPJxNYnpeWR1bD1DSFoD6+bEbSlWPaDXUx4dSWjny9dv6+HSSSWc+j3fS6orCzM0ouq4KsAiLNg==
X-Received: by 2002:a05:620a:12ae:: with SMTP id x14mr9926502qki.25.1617905133632;
        Thu, 08 Apr 2021 11:05:33 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::11cc? ([2620:10d:c091:480::1:a6d7])
        by smtp.gmail.com with ESMTPSA id n6sm152236qtx.22.2021.04.08.11.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 11:05:33 -0700 (PDT)
Subject: Re: [PATCH] btrfs: Correct try_lock_extent() usage in
 read_extent_buffer_subpage()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>
References: <20210408124025.ljsgund6jfc5c55y@fiona>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e8e48fc0-0ceb-068a-ba1a-0ce505212d35@toxicpanda.com>
Date:   Thu, 8 Apr 2021 14:05:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408124025.ljsgund6jfc5c55y@fiona>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/8/21 8:40 AM, Goldwyn Rodrigues wrote:
> try_lock_extent() returns 1 on success or 0 for failure and not an error
> code. If try_lock_extent() fails, read_extent_buffer_subpage() returns
> zero indicating subpage extent read success.
> 
> Return EAGAIN/EWOULDBLOCK if try_lock_extent() fails in locking the
> extent.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
