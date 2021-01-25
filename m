Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A2B3026FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 16:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbhAYPdr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 10:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729853AbhAYO5W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 09:57:22 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586DEC061786
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 06:56:21 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z6so9851881qtn.0
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 06:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WALdTvAnsF62a5xpo+oc1MFazpjeIGdgjD70rPGToPM=;
        b=GdG46ZatdQxS4V4xjEeVdLTZ5n1UqAt+vKlgJ1X/S7PiX//5h9cymAsv/YaYqj0Bl3
         TAY4OUEiuuhBbYgIfwV46jAvOf3c1MnM9QMUiM41uwwAUTMmGcpkm/fqlNcSzfXPdRuG
         IxwgkyB7nTri6fIcOfoBAA11TUPVJpBHwEXrjyG2NWc6XRxYSUeqTKIr0zltwdO9SzkN
         qKVdv/ghJn7osWRdMh72PNGvGSrCt1umK7/suVO9Xw+WSo0xtutcDkh6aUbQdxawAKTu
         P5S+5E1HGOajvv5Tv4KMA+wS71NUN0WAeKMmxIjlN/VnWRsjmSrtQQcxTh25owJa16Wc
         nuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WALdTvAnsF62a5xpo+oc1MFazpjeIGdgjD70rPGToPM=;
        b=i1gAbGZ/nkKfPsRfbu95Kb/qfhpA2tkpRV6Qd7o1VaH+cQnIacleCKtceVLYcmVQPv
         imzyfFrZLw9LRo7BaukYLkErboxiTRFv2d5xEkGWtcd3g8i9NEVPkuEDgG/2q+IFocsm
         xEdeV/26pVzzgRXqBL/0oilzzTCEAdOZfVtLGJT9JCTOffX2WxmYKvIFogRhVh+X2iU3
         WqcopRc0U+bck+RZKOBxeIP+AMmyKwrHLDlFNBQBWoL4418zjd5mFMFbqXH9b7KG+9Tn
         E4WLhMC1Ypy27MR9ag1FxeQCkRvEWaq5jWYYMzy6z0LaL/dMewULe5J6p3SP+5rdcT8z
         o+BQ==
X-Gm-Message-State: AOAM532DIPqPJ6QtIhw6SG1hXW07XsM2l8kEMN7rfRablJ9TpA7VHa6T
        GrWEvsGUNPe+8nSwjszBt0XB7w==
X-Google-Smtp-Source: ABdhPJwTcwFyh05QMPTlOm/3//vOKHEZD5GG08MkZMnbsEWpeVkzcRkD9KT9cWwW1F/BC+UqgpcLaA==
X-Received: by 2002:ac8:7a74:: with SMTP id w20mr775886qtt.169.1611586580200;
        Mon, 25 Jan 2021 06:56:20 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v19sm2337854qkj.48.2021.01.25.06.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 06:56:19 -0800 (PST)
Subject: Re: [PATCH v3] btrfs: fix possible free space tree corruption with
 online conversion
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        stable@vger.kernel.org
References: <c3b7d56951de1a9163b96a8ce90ef71b3532ec71.1610745887.git.josef@toxicpanda.com>
 <20210124131404.GH1993@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9766bb71-29a5-13b6-2813-b03c8bb35d65@toxicpanda.com>
Date:   Mon, 25 Jan 2021 09:56:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210124131404.GH1993@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/24/21 8:14 AM, David Sterba wrote:
> On Fri, Jan 15, 2021 at 04:26:17PM -0500, Josef Bacik wrote:
>> While running btrfs/011 in a loop I would often ASSERT() while trying to
>> add a new free space entry that already existed, or get an -EEXIST while
>> adding a new block to the extent tree, which is another indication of
>> double allocation.
>>
>> This occurs because when we do the free space tree population, we create
>> the new root and then populate the tree and commit the transaction.
>> The problem is when you create a new root, the root node and commit root
>> node are the same.  During this initial transaction commit we will run
>> all of the delayed refs that were paused during the free space tree
>> generation, and thus begin to cache block groups.  While caching block
>> groups the caching thread will be reading from the main root for the
>> free space tree, so as we make allocations we'll be changing the free
>> space tree, which can cause us to add the same range twice which results
>> in either the ASSERT(ret != -EEXIST); in __btrfs_add_free_space, or in a
> 
> Still no stacktraces but at least this gives some pointer to the code
> which assert is hit.

Sorry I meant to put this in the changelog for the patch but forgot.  I tried to 
reproduce the problem for a day on a couple of boxes but couldn't, and I had 
lost the original logs.  Next time I'll capture the stacktraces themselves, but 
I remembered which ASSERT() it was so just noted that in the log.  Thanks,

Josef
