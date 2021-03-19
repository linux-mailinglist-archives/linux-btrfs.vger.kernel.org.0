Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892A83423A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 18:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhCSRuC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 13:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhCSRtb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 13:49:31 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123BFC06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 10:49:31 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id y5so2247094qkl.9
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H++gtvjTsSyA1pGx6l/EBbB5zQsg5TR4+h1+VDJOhMM=;
        b=LlfsQMul+z3OxPbNQijLzZk3IHFUUVwYVYz0A+q5rdYK76UbqGzUIw3SZZBUgwrIRF
         qqDThXUawoHrGwe/Z5drAeqx9ipJA929zZ0cssiHfgprlPJdYwBINP4fNRyoYiJ3kK+Z
         JFg+BD7ZQpHQkXYjR1P4bdPaw289iMcOeRad9xGfHgyX9bWQYFgdlTy880X0TTbxDzfJ
         XSHRvqWFLYkqnC2Yhj1QPIAjw06xHEnNmmFGvo706BLRufElyZCeJLLm0t2fms+iHnK4
         9rkwCkWoxo8gLgcf9FOdkAVp6dR1/cPxohZ2gHTRxU4BRxsIBzAE++Ca8gkXHe6Z3j/A
         y+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H++gtvjTsSyA1pGx6l/EBbB5zQsg5TR4+h1+VDJOhMM=;
        b=VkXI9az/AfQDP5xnTx0KgORUEIjf1hUIKT9BOJVN3u0czt51hzJN+q6pmQGdNu6xaP
         amaTkntqGmSFyq3vHFhHuM7UOwhH2PChwHbsRl9ZEJSNZLgwP3efEd9lwjRxk/BtDcuO
         rf0z0bBa3cc0ygKxA79fu0Fmpi44cv4s8RWhrIESabdgEhSewbiMR2wqMLFPMmLEQf5U
         tqR10+DMfwIkcdSgxVl86Gvmv7oj2dT2DsgN1o0q97KOs86tXOk/YWtq5CPdJQghREUl
         sF6+Cvf//4UL0uIx6qJXN1wMmgwJu0NkfxXEVRIkgSxL23Z6YMrCvh228u1p1iOM1NEX
         mqsA==
X-Gm-Message-State: AOAM530fz9bX/QV8chvx2tMVv5Lo3sCS88YdwX5tzYV+d/FncJeUNRiF
        l9svTIsrpt7kytlWh09Ccc1lNA==
X-Google-Smtp-Source: ABdhPJzpWTpoWkbODX15zyjt+E+9skuIt4G84VgGkyT22R1V5eSxYqUoG41QzztmujdKww6AoG4pvg==
X-Received: by 2002:a37:de14:: with SMTP id h20mr10451961qkj.34.1616176170158;
        Fri, 19 Mar 2021 10:49:30 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f12sm4260266qti.63.2021.03.19.10.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 10:49:29 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] btrfs: rename delete_unused_bgs_mutex
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1616149060.git.johannes.thumshirn@wdc.com>
 <e08335fd919473b3da296514c4148f9fc9461cfc.1616149060.git.johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <44769a6a-2ccd-67f0-48a0-7433a8dd4010@toxicpanda.com>
Date:   Fri, 19 Mar 2021 13:49:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e08335fd919473b3da296514c4148f9fc9461cfc.1616149060.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/19/21 6:48 AM, Johannes Thumshirn wrote:
> As a preparation for another user, rename the unused_bgs_mutex into
> reclaim_bgs_lock.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
