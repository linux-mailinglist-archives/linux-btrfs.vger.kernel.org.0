Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C143F5091
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 20:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhHWSp3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhHWSp2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 14:45:28 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FBDC061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 11:44:45 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t190so20308774qke.7
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dtTN6sXbqT6fwOdnZWz2TmRo4jJvatmNmgcYHN31oHc=;
        b=M0zCpYkZb73DANkXmktlYaG7dnMkm2dQG6jLtjSOBO3iPuBGBuQRLYYqTfRRTaMh+J
         K6xFHBVjV4H40FeKWzjbAmN7mF957WFrlV0FXQioKtWHlGWAn/YLaoo8uEP9YtbSntTw
         4NPZjyYfwar2nKynrm+xCpJPsWIIxk9gxaI+8ZwEz7ltKwhvGWtrV2vMOX++EejdPQEg
         Q+XwJNKI4pThdNwvtdakgM12EnbVNRBEd1c76+7uP/RqlqQgJ953LEzwqGCg/E7Sl2aZ
         9NM67gnNEK2d+Dt36iQonZl9uF2ggymq015IzQYSi3z5bpNyxXTANxuT7OzklR+FQChC
         b6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dtTN6sXbqT6fwOdnZWz2TmRo4jJvatmNmgcYHN31oHc=;
        b=kMYWYZa3bjB/PZbaR1SIj+jQcgzvXu7IqleYOftRzieGjg69aeidUanMJjVFH05apA
         GQjA3fmLv1BKWo5eeMGOk7dnIirEIDwc6ctTHcxI1iMtiOA7WLSsQRp4N1Q5HjNnz8U1
         wELMi5xfDtSi7LQkQGjnkvsFH+x5UBA+Nr5fm0tQ8vAP4YHNDLe6X/oemuKI/x0o1RQ+
         JQ39aQjsSGeudXgZHTF4Ye/FJ0dUMr/y9vuX2kSTrOu+yE9wM/9riKK3DmUvYqG97ZeT
         QSx7nkQgE4RyP/ghMrnDZOJAa7ZZNqNJnGp+KCrNLOialGlB2oRfoFydFohehh1FIyUZ
         pKYQ==
X-Gm-Message-State: AOAM531WwnX5VO8ImBINWrjxa6qtTG06Pnle1tAlBMF4lO5OgDAhGAiY
        KnGu++QF/SsnNHpmPv/Adpc08g==
X-Google-Smtp-Source: ABdhPJwXVdfKh2jknb+d8g62FbtmqCFXuBoYLdve58Im4gCupHKjperva6AUT3ZWtgjOtuN5ciMtHQ==
X-Received: by 2002:a37:d54:: with SMTP id 81mr22215480qkn.103.1629744284925;
        Mon, 23 Aug 2021 11:44:44 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l14sm7016241qtj.26.2021.08.23.11.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 11:44:44 -0700 (PDT)
Subject: Re: [PATCH v2 02/12] btrfs-progs: do not infinite loop on corrupt
 keys with lowmem mode
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1629322156.git.josef@toxicpanda.com>
 <aaaf2cadf66d9e573e2dbcc3e8fab7984ce42f99.1629322156.git.josef@toxicpanda.com>
 <05f2cfc1-ab2f-0e92-13ef-488a9e7d716c@gmx.com>
 <20210823150408.GD5047@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <029e900b-500c-937f-322e-1d64b3259355@toxicpanda.com>
Date:   Mon, 23 Aug 2021 14:44:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210823150408.GD5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/23/21 11:04 AM, David Sterba wrote:
> On Thu, Aug 19, 2021 at 01:42:39PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/8/19 上午5:33, Josef Bacik wrote:
>>> By enabling the lowmem checks properly I uncovered the case where test
>>> 007 will infinite loop at the detection stage.  This is because when
>>> checking the inode item we will just btrfs_next_item(), and because we
>>> ignore check tree block failures at read time we don't get an -EIO from
>>> btrfs_next_leaf.  Generally what check usually does is validate the
>>> leaves/nodes as we hit them, but in this case we're not doing that.  Fix
>>> this by checking the leaf if we move to the next one and if it fails
>>> bail.  This allows us to pass the 007 test with lowmem.
>>
>> Doesn't this mean btrfs_next_item() is not doing what it should do?
>>
>> Normally we would expect btrfs_next_item() to return -EIO other than
>> manually checking the returned leaf.
> 
> That's an interesting point, I think we rely on that behaviour
> elsewhere too.
> 

This is the result of how we deal with corrupt blocks.  We will happily 
read corrupt blocks with check, because we expect check to do it's own 
btrfs_check_node/btrfs_check_leaf().  The problem here is that if the 
block is corrupt it's still in cache, and so btrfs_next_leaf() will 
return it because the buffer is marked uptodate.

It looks like search does the extra check_block() specifically to catch 
this case, so I'll fix next_leaf to do the same thing as well.  Thanks,

Josef
