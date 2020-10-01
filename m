Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5861028098D
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 23:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbgJAVl3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 17:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgJAVl2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Oct 2020 17:41:28 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E64EC0613D0
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 14:41:27 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c62so7513871qke.1
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Oct 2020 14:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LC5jrxjI+bNkWJIGasoKM01O+ZFtsRQMEGkkCnTqfcU=;
        b=zmFPYKM15cqDTOYdHKGvOkmtDzM4jAq70FsUsU+yhlBxLTXAce5Bd0tMjMNTlb9725
         mf1dN0L5Z+izve71/cTK0o6dyNTpQJwmwVcxRRXQ/K/nwE4nfSuHmrxT7OdEDgJiTNSw
         V3RzNqXZ9fH5Rp2iJGImJHaKkgmMZHYuKsR/kQE5kSxCg3qwwDW4yCs7Ho+wbdp4rVHN
         zd6cagL7Nj9xuWs0AhQapHHimb+I0Vhn0nhFEggLUCZLF+EaWSlTPuD3s7rQ7HP39tLC
         cztqWTDusXe+dTJbmvCOBvAGRpv/X45zkAKVH6HK1noZ582r/kYJDm/XcqCXA4vBCWjf
         SQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LC5jrxjI+bNkWJIGasoKM01O+ZFtsRQMEGkkCnTqfcU=;
        b=eT0t6X4pzwtm5TsS+RXEGKC9ojFifgjgPjNb4Lk6ZibCeDdNM3XbGx1fMF3KVLatzN
         pAnG2eCHFGYnsrEZGFQMmfA3DlUyw2sX0PdsKnhgfoHu9s1Yho7ilcfk8rk/oux1Sw0P
         9i/xV3uytV3mLYaZ5oS0t+pkmNTUq2qjCmE95LHMbN///c2ixetRtPJbq5u5/4sUlqYM
         OYOKWKL2rv+UkSCvKWfwfIwjh/toL5nXiOQlGhn/dzuuSepH1/bXDbZn57mjslKKFQw4
         +QGnLeu8HF0djZII/cMuX3+QewJU+CnpPfNu1Q54dZYeBvz9x2vxdg6FN7SxgMqSWda9
         tyRw==
X-Gm-Message-State: AOAM5306+kTYg2pys5V7jeu3s/dwAbjw8gdF5MuK2350KuSEsVrkPFTQ
        tMuvLeg7bahmvbNKGkhcUDRDXn11PtcaYfNV
X-Google-Smtp-Source: ABdhPJw0h6/c7FDlhDFdsGT9761gZY62DoxD4opxnuAb4Itl13aloqyi9jllkEiiNVXeaJJnyIhbXw==
X-Received: by 2002:a37:9142:: with SMTP id t63mr9680341qkd.50.1601588486342;
        Thu, 01 Oct 2020 14:41:26 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m10sm8093052qti.46.2020.10.01.14.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 14:41:25 -0700 (PDT)
Subject: Re: [PATCH 7/9] btrfs: implement space clamping for preemptive
 flushing
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1601495426.git.josef@toxicpanda.com>
 <629f3b0d6b9a100ae2a9ec5826c20cef28eb6b0d.1601495426.git.josef@toxicpanda.com>
 <74509cfa-1a09-10aa-c2d6-e272afb225d4@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <89210794-b325-18d2-90c4-5c63168a1d2d@toxicpanda.com>
Date:   Thu, 1 Oct 2020 17:41:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <74509cfa-1a09-10aa-c2d6-e272afb225d4@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/1/20 10:49 AM, Nikolay Borisov wrote:
> 
> 
> On 30.09.20 г. 23:01 ч., Josef Bacik wrote:
>> Starting preemptive flushing at 50% of available free space is a good
>> start, but some workloads are particularly abusive and can quickly
>> overwhelm the preemptive flushing code and drive us into using tickets.
>>
>> Handle this by clamping down on our threshold for starting and
>> continuing to run preemptive flushing.  This is particularly important
>> for our overcommit case, as we can really drive the file system into
>> overages and then it's more difficult to pull it back as we start to
>> actually fill up the file system.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> nit: IMO it would be worthile to very briefly describe the threshold
> calculation, essentially it will be 2^CLAMP and we start with 1. So in
> the best case we'll preempt flush when we have allocated more than 1/2
> (50%) of the freespace and in the worst case 1/256th 0.4 %
> 

Yup I'll reword, thanks,

Josef
