Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03343612AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 21:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhDOTFD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 15:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhDOTFC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 15:05:02 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F166AC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 12:04:38 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id h3so11475433qve.13
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 12:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=P1M2SnHejBQW/Vsf3D7hMTtLQO+GVo/uXA90a0+IZDU=;
        b=IU0opA+SIFZzrMwSAQCo+h2HOwx4LAiiImKr3d5hIUgo539yW6oO1w6FrnFWw9+kxq
         cAY0LmRoc2hxzWB0Tn9jFOnD11wgPM8HRkwEDDp1ljDIDTyCs7ScfTghDZqOHXLmn3qD
         f8fKG1wGefoRjMTcdtAp4be4+EPPbAdFIcIWPYbGVBZFBPWso8VxZu1Uh/k+SENwjgod
         H5DvsDH72oxJ55RBq8qeyVIN45PQDtt9WQ7TkxrbhH7Szx+PjzeInQm0urv+ySw8P3TK
         0kpGoSxSdwy107rmUeEQgW+SVJozC6PQTE71g3DALVn9aOoNzGgdXw+dANHEAsd9+kYI
         RQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P1M2SnHejBQW/Vsf3D7hMTtLQO+GVo/uXA90a0+IZDU=;
        b=cYmglmZhaaSNLhsNvIWgyHsz5x+wUTmysfsFSFu+OpR8mOoulXQD+1Xl8IcMMkPXyG
         h32/hbrwShyVHaUk3o3+gp1L6p75rkrL2Xq7IBuQL/+S3pr7juBSStDRDI4+OzyF42qY
         4gkB+O26NMMGScST4X8rMSVUVz88HdqxHxGUfOIqlzqiZVN8Fgp1F9l1vW1AryV8+jKO
         rfBBaLHSWm5ThaQ4GoRvvee/n8e6pOkeNKDsM6Y4V6nDp2ZUpgEZ6LKuLFPZ9jUR6wWC
         5Ybh0jx1cWkvgpPCklSTz73yaGWMMbtGsACqJcuvl48NLMtcXVpYCWQfTqzNLnG/rXpa
         EVDA==
X-Gm-Message-State: AOAM531a2ICLXs9Pixenm7jqry7a3CJzdRTMMpew9jVKpmuKhBvyOWIt
        470X2/MWbeLTiILI2ojiQGfSJvdDQ5ELnA==
X-Google-Smtp-Source: ABdhPJxdCoDA7ADknQUXvNeNM5eSv4CjToZ/b8drlPU98r7pc7SjQVt0fZlWbXsWFv1UI5F2bH9Edw==
X-Received: by 2002:a0c:cc91:: with SMTP id f17mr4912038qvl.1.1618513477940;
        Thu, 15 Apr 2021 12:04:37 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::1288? ([2620:10d:c091:480::1:2677])
        by smtp.gmail.com with ESMTPSA id 81sm2645674qkl.121.2021.04.15.12.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 12:04:37 -0700 (PDT)
Subject: Re: [PATCH 03/42] btrfs: make lock_extent_buffer_for_io() to be
 subpage compatible
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <59914a05-4dd8-3c7d-a630-72fb655ad5b9@toxicpanda.com>
Date:   Thu, 15 Apr 2021 15:04:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> For subpage metadata, we don't use page locking at all.
> So just skip the page locking part for subpage.
> 
> All the remaining routine can be reused.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
