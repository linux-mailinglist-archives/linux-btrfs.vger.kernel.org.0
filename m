Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2470362162
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 15:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbhDPNr1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 09:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244243AbhDPNr0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 09:47:26 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7EDC061760
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 06:47:01 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id u8so20735622qtq.12
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oDMzGOipI5U82SUD/XWrWPbebCcIruYwdLgTVBpGm0M=;
        b=zHCQk6e97s39RVKWYfxmHsOUXMNGXXuMncSwXbe0IqgpektdtUukt41gnPgfxmZFsy
         hs4MrhEen+DdA3EroVuAOqDAUpqpdOzgcUNGxDDMOBcO+MADoDlsRhpSAcyUG18fdf0c
         mVpZVRU9xXTb9WUQMA55DixpQhub6GkFif+YZ9ArwU0S0c3ispqGQ2dtZkHCLj6hU4hb
         CwsaGrt7BIoryo9EWtebwgFK3CsPZabEaZLde2EQYMmj7Z+FhIgU4Z/dDrYvTByLlKRr
         3OeM9mk/MFun+eFvdlgudEnUmMOHVzWBYa9eP6k+8jHxvYhjzgTp6ZXzhW1SLyeutquk
         1ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oDMzGOipI5U82SUD/XWrWPbebCcIruYwdLgTVBpGm0M=;
        b=LEkB6tBBuELlW3U1c0p3gUZJZ3ltZiKAArh4d8QeGFKtOt1ONNeUEIoU1ISaS/96vV
         aW5d3+5d/m1y/x1wXVXwscukiDKjKTR3I4K6cpqHaQfF34C8Ykfc2hmLyMtP3PNeF1rz
         2tXQU3kuAnBrEFQ6lp8+fdQzZsrUOV3/NoW3njY/kYWW9Xu8tTYAsmeJq4ZLyVBv5dhZ
         03lSO4dSZrXqIVwPRZ+sTdeOjm8Fgcxf/ebM5asosgbyQ4nomSNPPYbCGor4RM+tA49I
         r//2+RFHQGetfZAb53IaYVFXT/IX/fIbpkq3ac9K6jMllnzM9hOWpI6lEHaRxVo9aPn7
         q59Q==
X-Gm-Message-State: AOAM533MDduco0tzR50FfcuBnXxsxuLzkh49pA9r/iikrrfE9W6nR/Mw
        J76sDhRF/Kt8r2j5Q2WhHHNRPbp/FSApuw==
X-Google-Smtp-Source: ABdhPJz79R+A4GyzgMaTCCL/TY5me4H/KXzQ47Lq7dD9bfWErjJs55Hc+j2lTEfwxgTOOymnX6zBTg==
X-Received: by 2002:ac8:7253:: with SMTP id l19mr7818311qtp.129.1618580820224;
        Fri, 16 Apr 2021 06:47:00 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w15sm3733647qtn.12.2021.04.16.06.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 06:46:59 -0700 (PDT)
Subject: Re: [PATCH 05/42] btrfs: remove the unused parameter @len for
 btrfs_bio_fits_in_stripe()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-6-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a241d0fe-2c1b-d9cf-55a1-473d257cbe37@toxicpanda.com>
Date:   Fri, 16 Apr 2021 09:46:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-6-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> The parameter @len is not really used in btrfs_bio_fits_in_stripe(),
> just remove it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
