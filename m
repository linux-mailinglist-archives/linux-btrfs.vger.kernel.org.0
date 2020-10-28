Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A7529D805
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 23:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387490AbgJ1W24 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 18:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387485AbgJ1W24 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 18:28:56 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4933C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 15:28:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l2so568669qkf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 15:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8WdrC0bpF4tFlHyMtFYzlPHBLfVs2D04nj2RnmKTHQk=;
        b=inTgUhUYTGHGXfqSSxO7oW/rvknosCU1f9zE03wYcYe6xBfFcwAC1EIzsU52eu5/uF
         TBp/4z7E/QqTFg6QLGDPiiO0bYLbGenruxGxj8jcCqg3xqRTDpaKT1WeTTi8NwwE6Vtm
         xB2mHLHZzh9GBdZFWv90YtT98qPk21zLysQdPysn2cQ8bwmdXx8lhMtD20JcqWAqWgSO
         +dBQGNs7oXSpTioN+W31l14MUc23xVHvtK1sQLz6MQF+lNNMOgpqBvlFOSDxhjpY7eo4
         mkPzl1i2leNcNfxkx6/IqBqsaC4H2JdJXMJCn72MH/7RZluZHezJ8+0xg/c4HR+I3OkW
         1mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8WdrC0bpF4tFlHyMtFYzlPHBLfVs2D04nj2RnmKTHQk=;
        b=RLhmSVNY4WTRBGcfcJuuTAIGv8Q6bPzgwut98OOXz6cP393Vxgr8f1p6XFTsQew7qk
         UCxjg3ddwzq7mIBZ0xcw++1r7P+Cb/8GuLUgB0aTSw4lrm54w52J74miXiTtt2OfEEeX
         dLweP8ejd9IBcvLL6nbkB2QUkrlnBzm5k98lyzRbV2/z6WYjbVrSf5p8SgfM1Z/orHIl
         TqpaP1q0gIK7P0VJgyXX8f3ilcJzjULyqx+nidFAZR/bBkauDvLsW6Rqe4rRsJJ5bhjL
         StdTfD4ahc8B//mEqrYsT38xF6GCFYFXQ9Gz1YNegghNcNLwx0uxtBNPcwMtgloUqVtg
         ODIg==
X-Gm-Message-State: AOAM530jB04wDuk4ZEnhSJ0zmJTHBAEz7XLT4GuxLtKYxBXfgmkdkqZ/
        PnyXy6sN4CqOid2wclMgVAwEHXlxnFTUGjaW
X-Google-Smtp-Source: ABdhPJz/84D5AkdWCupjO7pfsTnekCCiBAD7DVgiLB73Ft77SewCasOKWizbds05tzDkoBy3DveJyQ==
X-Received: by 2002:a37:a68b:: with SMTP id p133mr6936051qke.272.1603893524855;
        Wed, 28 Oct 2020 06:58:44 -0700 (PDT)
Received: from [192.168.1.210] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i18sm2880003qtv.38.2020.10.28.06.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 06:58:44 -0700 (PDT)
Subject: Re: [PATCH v5 04/10] btrfs: clear oneshot options on mount and
 remount
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1603828718.git.boris@bur.io>
 <7b316bb772e15d62df1553c50c8bb4c50cc63c51.1603828718.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <317783de-5d56-01dc-c631-b6f37a350300@toxicpanda.com>
Date:   Wed, 28 Oct 2020 09:58:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7b316bb772e15d62df1553c50c8bb4c50cc63c51.1603828718.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/27/20 5:07 PM, Boris Burkov wrote:
> Some options only apply during mount time and are cleared at the end
> of mount. For now, the example is USEBACKUPROOT, but CLEAR_CACHE also
> fits the bill, and this is a preparation patch for also clearing that
> option.
> 
> One subtlety is that the current code only resets USEBACKUPROOT on rw
> mounts, but the option is meaningfully "consumed" by a ro mount, so it
> feels appropriate to clear in that case as well. A subsequent read-write
> remount would not go through open_ctree, which is the only place that
> checks the option, so the change should be benign.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

This one fails to apply cleanly on misc-next.  Thanks,

Josef
