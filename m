Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13042B23E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 19:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKMSkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 13:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgKMSkT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 13:40:19 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBA1C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:40:19 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id ek7so5075041qvb.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MIrf3eiySkYMXbCvmJL5+wkWPJs96qmaqxyVqcFtipo=;
        b=vo69ixuPJ5kXeYx3w25bstTnIjvB1JTx/HUD6z1mnYeJAJUomdtGt/QzyHNnz+Ob5/
         WjMZSVIWi6kHy+KXgRPiEBYyHitH13MtUGIq7/89YkYTKx1VZ+QexUV+fBoqhxlb6+5n
         TfiFtcV8YgldpD75umRV8oXMtr5syPtdGlKkESn1pkLYgdO2TfQIPnmcrU1SSoPqlET/
         X4MGwLWKyo0qV1wtKvieug+iEkXO9AjQ0POX3gJxzKZOVlYu2XX4PLR2XrjMaDOQIFmk
         MP9TnLu82QE01gFxKB4rW3A/9OlvRQkZ4KHlCq+81FSxlusnpXPTSk5yQBe1aE4TtuGj
         XkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MIrf3eiySkYMXbCvmJL5+wkWPJs96qmaqxyVqcFtipo=;
        b=aDsHI9rRqUMF43DkmybSBy7XukiJ694FYmq20mpIjXedfODOclJYfu+vKm6v9Rv/AR
         OiFX7/Yh+ZMThXGD6PHPF98yWTlYN0S5dBwxfvh6gyV5p7EsllQknTVRD60/DYRP9naI
         uUNpewweMxIE0sl764Wrvx0t1JV+znPBMeIWYkD5MWSQiRo4VrcjnOwhyU5PYc9yPbQ8
         hU2YsoYgUjoPw77iIb6I7thctfV/EnykthkZcmimX0/T0/wQb8NpXrq5O89U3hP25nA1
         wGfkPWz5queh2mDi0b0DaHKNOi+nEcOG2nGdYPBZs7X+2j5KjomeyY9s7QrBehKnE8zm
         2MpA==
X-Gm-Message-State: AOAM530vw3yg6/sfQZnDTrpAQZGDCVysA3nplY1e7Gg0iQGJLyPDiWmc
        fQWltSy0cxIAJWBL3CN6BwkRuEUa6e9QQQ==
X-Google-Smtp-Source: ABdhPJwLkD0yx3Z97aa2Oe1AB3PDFlX35U/68Y05ULadwhq9/IXlUo8hdMbJ4tIAlwV0cXQsoMJc2g==
X-Received: by 2002:a0c:d6cb:: with SMTP id l11mr3759337qvi.9.1605292818424;
        Fri, 13 Nov 2020 10:40:18 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a206sm7157514qkb.64.2020.11.13.10.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 10:40:17 -0800 (PST)
Subject: Re: [PATCH v2 15/24] btrfs: extent-io: make type of
 extent_state::state to be at least 32 bits
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-16-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <dcbb7f2a-1387-35dc-d828-95cd993e7604@toxicpanda.com>
Date:   Fri, 13 Nov 2020 13:40:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113125149.140836-16-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/13/20 7:51 AM, Qu Wenruo wrote:
> Currently we use 'unsigned' for extent_state::state, which is only ensured
> to be at least 16 bits.
> 
> But for incoming subpage support, we are going to introduce more bits,
> thus we will go beyond 16 bits.
> 
> To support this, make extent_state::state at least 32bit and to be more
> explicit, we use "u32" to be clear about the max supported bits.
> 
> This doesn't increase the memory usage for x86_64, but may affect other
> architectures.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This failed to apply cleanly, I'll review everything up to this.  Thanks,

Josef
