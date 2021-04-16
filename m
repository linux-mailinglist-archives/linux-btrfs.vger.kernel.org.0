Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83303623C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 17:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343586AbhDPPVz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 11:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343523AbhDPPVL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 11:21:11 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6DAC06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:20:45 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id u8so20965983qtq.12
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=J9WS0AdN/tpaGGUijQEdMKTjpiVYz4b27hlCNvsD7Zs=;
        b=OVzu+vkGhnwbh/1fxoKQ5oz6xl/c73Cc+io0FTrbSoWaOAGMNdhcGTrY65dE4a2UjN
         h9La12PyBEaQZR/n2ilAiIPbh+1DwT4ApbA9w3uvGUOSRUcIbJDOYze5Lp7QO3awHpWO
         Uhdk9JYkySe72EzRjpCQJWj7fHeqVKe1cqptV0UqTgYA8koSL9gQTPkA1Ua/kjlRBnq2
         V6tYgFF/2rvQQlxUIQrd4iLdhfS1o5ekxaoiQfYGfUYgVaaSHKV5wdTs2Gu3FZg5tMvv
         K4gSqGgWwUtuq5Xip83zv+JRkv4VW0SXgcsTG8WXLZWpn570Sq560Nr8ZrEebN28e4F8
         P0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J9WS0AdN/tpaGGUijQEdMKTjpiVYz4b27hlCNvsD7Zs=;
        b=qV+QZbAkBysCqxpwBnIN75luKXbnv5DKICQaD+phRDbAx0055kiF2oZDFF/qf2ZGrC
         0eya2lCKDU+q8Wp9tuib8i8lSj3Juxbr2HTaR8sb5LmVqW/iSm8AAtSnWLubwnu0+AS4
         immGKT7VW+sqERySYBJS2/k/N0otzShLeGhZ2Z3whmhyNFbXy4X4Y66HLjru3z1zMZ5V
         lEiJPcOPQSRsvk773Y8ikLKww9nDML+6PBYUz9uW7GqjZ1ZbVU8Vmvp5ZZINNmMQoOZE
         wevnPTFxumvd7d6gIaasZhpD5rGaVhC/818cmAeQFoK1+17v4e8G0msL1xqtBaJ5KJmB
         vWiw==
X-Gm-Message-State: AOAM530GrKxrW6qDICi8hTC9PWBkc6M4FcVMPIx0YpotJ9KUitIyxFeq
        Q67NEDi4PTp8MsD2sjKP8F1SrsCPqzAetA==
X-Google-Smtp-Source: ABdhPJziOE1Dx/ffvFH1AJkXM4gXbdXVghfynwgEbeEy5rZGBzjFn459JLeo7S7vC468SLDynw2Vcw==
X-Received: by 2002:ac8:458c:: with SMTP id l12mr8178758qtn.296.1618586444349;
        Fri, 16 Apr 2021 08:20:44 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q6sm4374080qkj.50.2021.04.16.08.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 08:20:43 -0700 (PDT)
Subject: Re: [PATCH 19/42] btrfs: make __process_pages_contig() to handle
 subpage dirty/error/writeback status
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-20-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <805f34d9-2443-cf36-2ff3-ab437ab37ffa@toxicpanda.com>
Date:   Fri, 16 Apr 2021 11:20:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-20-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> For __process_pages_contig() and process_one_page(), to handle subpage
> we only need to pass bytenr in and call subpage helpers to handle
> dirty/error/writeback status.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
