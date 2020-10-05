Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFC6283635
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 15:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgJENGC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 09:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJENGB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Oct 2020 09:06:01 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63B1C0613CE
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Oct 2020 06:06:00 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v123so11711787qkd.9
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Oct 2020 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ejlxU7t45j+JrlQcmMGNw6GylppzdX/HeiDq8x94pdQ=;
        b=bhFOEatZtzgjAeRA6+soXZ/47cU+94hXbCFrrVMCkKuTXsGfc1GQNnydRfvgkBd6ax
         q2RCoQJmhtmKVo5MyiDA5hUglu9WAznzGunderUv8SrZfhX/OAIuW9a7WWSNK2fOOu/Y
         /IXyp+XTTvcDliguBKqDmc2IF5vedX13q+/CAUcJ1xWKHREgtCuj9VoTnzfXyNQ84GHE
         6BJbH5TE7VWhljzuMOFMw7BPJkL2Jdhf66YeYK33UP+RZlx4RcC985KXsDPNsFxprdY7
         dXcX5wTc4qOk1woAmDTyaaj4ZPxxF8xV/mT/yUZ2LjTs/Vz+t6effMuzoMrACTvG63TP
         Eppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ejlxU7t45j+JrlQcmMGNw6GylppzdX/HeiDq8x94pdQ=;
        b=e6I8j/tn9uNf7UJM8GOEWc5NhK9TC0WbQVyX2si1WDfiwO4S1W4sGnneIQ5uha7GBv
         FIklvANFy9hWmIFlqtL9Kub63cqFZ5M2updF20nfcgjjNcCow9DWtC/WFo5eRJkRw86W
         wpbIG0t2OXh4A/bAXlnR7M7O8ZDbOZCqSULAa73sJu76YZFlSfVUS4elTVPXMsNIJ3re
         O7GuXLjhMIbE02rEe/7AyjnhLrcKPsxNMJDObZ8onX+M13a5PQL+kmsGD94OavrID4UK
         8ocMBGjGf6QIiL9vgoWAG97VZal1+FFGAUII4rM4yKgXimm10bP9gFdaD4ADoPLJWyFY
         X/5w==
X-Gm-Message-State: AOAM532YS5bRzOEQAv6LxMt/QtS0OqjXeRtT2OgrjyaAwO9tZkbmDdBw
        cQH09QLu03O2YWCUS73RJiUO0w==
X-Google-Smtp-Source: ABdhPJyZTQ3rJbyw0EgDdjTpTes4VlT1Xl7CoRIIoxAYwi0CLqhLCSKbWXOuDFQ14tRw8nkzZI/lKA==
X-Received: by 2002:a37:8e82:: with SMTP id q124mr14384082qkd.297.1601903159878;
        Mon, 05 Oct 2020 06:05:59 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y77sm1570992qkb.57.2020.10.05.06.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 06:05:59 -0700 (PDT)
Subject: Re: [PATCH] btrfs: workaround the over-confident over-commit
 available space calculation
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20200930120151.121203-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <54c0fa16-ed85-50bb-2267-0aff6276b4e2@toxicpanda.com>
Date:   Mon, 5 Oct 2020 09:05:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200930120151.121203-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/30/20 8:01 AM, Qu Wenruo wrote:
> [BUG]
> There are quite some bug reports of btrfs falling into a ENOSPC trap,
> where btrfs can't even start a transaction to add new devices.
> 
> [CAUSE]
> Most of the reports are utilize multi-device profiles, like
> RAID1/RAID10/RAID5/RAID6, and the involved disks have very unbalanced
> sizes.
> 
> It turns out that, the overcommit calculation in btrfs_can_overcommit()
> is just a factor based calculation, which can't check if devices can
> really fulfill the requirement for the desired profile.
> 
> This makes btrfs_can_overcommit() to be always over-confident about
> usable space, and when we can't allocate any new metadata chunk but
> still allow new metadata operations, we fall into the ENOSPC trap and
> have no way to exit it.
> 
> [WORKAROUND]
> The root fix needs a device layout aware, chunk allocator like available
> space calculation.
> 
> There used to be such patchset submitted to the mail list, but the extra
> failure mode is tricky to handle for chunk allocation, thus that
> patchset needs more time to mature.
> 
> Meanwhile to prevent such problems reaching more users, workaround the
> problem by:
> - Half the over-commit available space reported
>    So that we won't always be that over-confident.
>    But this won't really help if we have extremely unbalanced disk size.
> 
> - Don't over-commit if the space info is already full
>    This may already be too late, but still better than doing nothing and
>    believe the over-commit values.
> 

I just had a thought, what if we simply cap the free_chunk_space to the min of 
the free space of all the devices.  Simply walk through all the devices on 
mount, and we do the initial set of whatever the smallest one is.  The rest of 
the math would work out fine, and the rest of the modifications would work fine. 
  The only "tricky" part would be when we do a shrink or grow, we'd have to 
re-calculate the sizes for everybody, but that's not a big deal.  Thanks,

Josef

