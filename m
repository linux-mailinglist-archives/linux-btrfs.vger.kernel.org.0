Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A6B272703
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 16:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIUO3h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 10:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIUO3h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 10:29:37 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601EEC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:29:37 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id j3so7394258qvi.7
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0yB3brJnv3h3rN/PnVNRp77qwEfWE0K3KYu7D5vWvg4=;
        b=OFdZG6bHqEmwDXBJ+L/cchCM5AkBjpmULtSGOS+IYe0WxHuI6nwg/mLTuJJrPlsjur
         NeRUrgzXgIHlzQF/Lw8DUr3nMaopbryYPR4i7LMdNU9u2E4wAcg1DqSR0qxKBH01b73H
         b9FL1/5piNHDHhLbq9hYOocW/e9JhD2ur3NEbCzM5GmWDntd9Lp24brV6UUsV3IxNNYH
         4ctqksmjDmles5i2y6Qdk1j96KIImQecprjN2XW2oRLpPrdom6CbDxp6BUymB0DbXF3M
         +5mg64oyqBUdkhoY6hfIEzWt2JDxPRkMyRXV9qwZAi81yXWonnwPs2TNKHNCMhn6tOqW
         HFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0yB3brJnv3h3rN/PnVNRp77qwEfWE0K3KYu7D5vWvg4=;
        b=ca3k6lXhIPNAnVHI/05qywYJqJw7kCDd/DDyPSO+DGT1yBDe8EBNwbkluSzMfEICQU
         hi+ZpYrbzK40bVtIVVTF3P87Q9qTkq4kfFP/zEZShGrLke9YT+zAFkI9OYmUz5ecPC5g
         WOquJ+uFWT0T7PM3R6VK5S2Itta0VIuwT70+oATSQVhd8YJWGHW9O6vEEYYo0tCEtbeP
         O26mOIqPhMRE8N/JgO4aoAXsq64QqvY60JEHjtb7KcuuHotKTlzRNcqdFfyxm+8/tsEh
         oQVgRSj/WGLj3PxMRVHWwpA9lR7uu2KVzbjJj3ak55RPS/pRzAaSo+MrGFeKqwqvY/wq
         AFCw==
X-Gm-Message-State: AOAM531MMyMMrQD22U/UZVKSFnc6uVX1kK/2mnEKWi70Twbgei25hRWY
        PsytHpn79vNQeri0WpEyOtxq1r0rVLRLhaX/
X-Google-Smtp-Source: ABdhPJyqY9xsFm1b3HPhvqR5ZnrUiAJu73XBc/aPEEOnXGrb8mTq+0rpRUClkoIOKOtsxluti8N/Jg==
X-Received: by 2002:a0c:8645:: with SMTP id p63mr159461qva.21.1600698575896;
        Mon, 21 Sep 2020 07:29:35 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k185sm8930411qkd.94.2020.09.21.07.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 07:29:34 -0700 (PDT)
Subject: Re: [PATCH 0/2] btrfs: send, fix some failures due to commands with
 wrong paths
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1600693246.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <26720bed-d4f6-987d-f36a-190b215f9a99@toxicpanda.com>
Date:   Mon, 21 Sep 2020 10:29:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <cover.1600693246.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 9:13 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Incremental send operations can often fail at the receiver due to a wrong
> path in some command. This small patchset fixes a few more cases where
> such problems happen. There are sporadic reports of this type of failures,
> such as [1] and [2] for example, and many similar issues were fixed in a
> more distant past. Without having the full directory trees of the parent
> and send snapshots, with inode numbers, it's hard to tell if this patchset
> fixes exactly those reported cases, but the cases fixed by this patchset
> are all I could find in the last two weeks.
> 
> [1] https://lore.kernel.org/linux-btrfs/57021127-01ea-6533-6de6-56c4f22c4a5b@gmail.com/
> [2] https://lore.kernel.org/linux-btrfs/87a7obowwn.fsf@lausen.nl/
> 
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
