Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277BC21D79E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 15:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgGMNzs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 09:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgGMNzs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 09:55:48 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8238CC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 06:55:48 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e12so9926162qtr.9
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 06:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pym8zKF/xcHU9Vtf33IxANWsxymj7mgpGZg9Pb3sYQQ=;
        b=HDVTuJPnR1tjB3bUxJkpofcwHw+ZyN/zvIhITTTHMlNB4eV9yqR8gTQFYSYb0Q/eU/
         9V3Y+mDcv2rUgmFYERQztBN2tk17Ufk+wILJ4imiiElGpMj4CqaQZ/zEI0n8ZZeD9Fyd
         vjYTZvBjCNCDH5xLWRkcENK0+ufn0ikgC01t3mMrv/3EC190kH2aUJK+C15qTpP2+o4Q
         UE9u+Y5dawUa2qU3KkN8BzMvNtKD2et+9wgp/dlB2pFAz6+1I5Wd3W0YuacyJaMtwTeu
         UFEUwGwZXg/4bL4ttnTaa/5lGGNkxgMGPoCRn8glbWj407XooyxJAqmVqJXr1HHFxSse
         t4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pym8zKF/xcHU9Vtf33IxANWsxymj7mgpGZg9Pb3sYQQ=;
        b=nLvreeOZEETJ0TG0c3xHTvDJh/FbGmGsDv8A7vN/j6z7Q45jSEZUtUhtHBKKoXSalv
         TniI/pjM/kwEeP/m3LUQMYtwNxR/jNESeF6yJLPQEztZfYynmGfakA/kuWUHmUu38ATx
         /sPSJm/45iVE2AiVhtzIJCCV1+PD03aqJBRDiL6RrLBDYe3sKUDIFa7N4sCeGRPlD2ff
         s6BdOdZKL4vcLm53MIqXLkfaGo2c7yYqmlmiSF/Sf/Q8U7+X8Ku4IfIRIKRWkkZ1D1Ac
         0Y8i+lypGym99SQiMgSgihxIMjltW9ohtCVLmaB+KqEWv6j7HRbVnSam9cEdGO36XtZQ
         zkig==
X-Gm-Message-State: AOAM5314O3J45tlN8xmCbgtISqY2uXxayUlBzWtLLHTT1aY+SP43pv7p
        R8xOjJJgOIVNpACsi65Trb84sEwNbfPg8A==
X-Google-Smtp-Source: ABdhPJyjK2ubGwPNge3I0o8lwXB1mF3mfGgUqKDNnvtrbHV10McLBuow+Gy23pZvD7KDYjcM1sQ24A==
X-Received: by 2002:ac8:7208:: with SMTP id a8mr88447177qtp.355.1594648547697;
        Mon, 13 Jul 2020 06:55:47 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h41sm19896259qtk.68.2020.07.13.06.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 06:55:47 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: prefetch chunk tree leaves at mount
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
References: <20200710131928.7187-1-dsterba@suse.com>
 <20200713121324.3667-1-dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0a90d1dd-59f6-47d9-9d5d-c2aebccfbb94@toxicpanda.com>
Date:   Mon, 13 Jul 2020 09:55:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713121324.3667-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/13/20 8:13 AM, David Sterba wrote:
> The whole chunk tree is read at mount time so we can utilize readahead
> to get the tree blocks to memory before we read the items. The idea is
> from Robbie, but instead of updating search slot readahead, this patch
> implements the chunk tree readahead manually from nodes on level 1.
> 
> We've decided to do specific readahead optimizations and then unify them
> under a common API so we don't break everything by changing the search
> slot readahead logic.
> 
> Higher chunk trees grow on large filesystems (many terabytes), and
> prefetching just level 1 seems to be sufficient. Provided example was
> from a 200TiB filesystem with chunk tree level 2.
> 
> CC: Robbie Ko <robbieko@synology.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
