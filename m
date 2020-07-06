Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FE52158BE
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 15:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgGFNp0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbgGFNpZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 09:45:25 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657CBC061755
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 06:45:25 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t11so15112295qvk.1
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jul 2020 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4V9sZ/JZfHGbpWvTZV77UMkPCz5+/Etvpo6oHetpu4U=;
        b=GGnf1lWoy4WDMeMF1vETvHZo9v7cGBZNUly8ubmTQzLdE2oZgi0em61t27oAogjzjq
         OlRsA+HCuDp/GPNxwmQIxIbYdKZdYBbD1JaQ3lXo7MCvmAKbs+qdqj02NPDNSJkYcgzP
         RkEziVU4puFPbwR7CNrungNGQvvZW72luQP+zsMcmYQnM/YE5iF3jJajkMEl+8YEMSzS
         iItZofeR/OpXJOQ+OQcbjVdutBJ2HphOuewYZurQZOcjo9viDcizsC78I7y8wyvmlhad
         zqFwjq39jCq1/C/rdXwnFe8FCkEQc1sT7Mqr2FmS6GZIQabmE9Dmz12/iDIjq7oBj8rm
         1Yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4V9sZ/JZfHGbpWvTZV77UMkPCz5+/Etvpo6oHetpu4U=;
        b=ouKjroaWRRTXAE8tSLdzhBR1vl3gZGOQctI2XkI44apZ+lRALhPmXEHY0nZEDirl8z
         zVC9dxSAiOfpV9jTdQdL5ogdssfqoHOYskHIJXo57Wx3g+OG6JlMag9EFloIVSNeKNDC
         CEFOcqWOIJWfvsgCYRqN5MPyg8Fp5YwrgPb3mGCzgCoI4+Lamov+ShVkSAcDJX9UVZKa
         kfnLUYQ5rdfVo20+yulbslfYLbeyPZ+efmvMVKIazuRPl6QzqKzqE/e+szVjMRNlLKgH
         rEtehvHziwgZwbDd9panCOtFQzLyCrBZLa8G+lc8LJqhN6eaEGz/VXeAIIBVLluI4+UU
         QtAw==
X-Gm-Message-State: AOAM532afCL5pOXxvOvOBaKgJgaEKB+pILnR0mHpb1CcWvnu5XnLcn+/
        4XeYNSZX3wy0m+u0p3Ym7B0ylc70VipPbw==
X-Google-Smtp-Source: ABdhPJyOYhsThoQSY0xN3VNGVDFdvtb6Xi7Iz0aVfJAMbYgv6/fl53n52u9g4J5IVG1nhCVFwbDCTA==
X-Received: by 2002:a05:6214:3ac:: with SMTP id m12mr43011077qvy.18.1594043124355;
        Mon, 06 Jul 2020 06:45:24 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i26sm19043139qkh.14.2020.07.06.06.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 06:45:23 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] btrfs: relocation: Allow signal to cancel balance
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200706074435.52356-1-wqu@suse.com>
 <20200706074435.52356-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <911e0685-490c-7062-a4e5-e849d51c53d1@toxicpanda.com>
Date:   Mon, 6 Jul 2020 09:45:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706074435.52356-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/6/20 3:44 AM, Qu Wenruo wrote:
> Although btrfs balance can be canceled with "btrfs balance cancel"
> command, it's still almost muscle memory to press Ctrl-C to cancel a
> long running btrfs balance.
> 
> So allow btrfs balance to check signal to determine if it should exit.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
