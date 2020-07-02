Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723E2212560
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgGBN4X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgGBN4U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:56:20 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A82FC08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:56:20 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j10so21236868qtq.11
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Y9pKiPZA9IXYietjKKd2iVGFkxSxIzZMftZ5JwXZ5j4=;
        b=eLanU/vABCeZ7d8hJAeKPoV26zxB8zeyIrvhBinkbzqO0oVZOk86z3cOUrKBmFKcxC
         +ETeZwU2i7y6aU7P1ymSJjMmqUENKMhxaOnBg4JrC9zIhXa9bu9/isUTCH3JSfILzTXH
         hsV/GmSULtqN9+ez0A+6gCm8KstovTTeAYVb40TNeWnM0QOMuKQ7jtdtbSIo6IezwucH
         1GBnCoZ7faCWefSwZNP7k4SOWTtD2V3Os3p36bzr+/cp1JtahLJfRUUiB21a5u55C7qV
         4qP1I2ByfEDv69AUxzCKA9cLKFN/azCi5y0PsvLVFnmcV79eHBVrrTJ4PrU2Rm6uWeMU
         TXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y9pKiPZA9IXYietjKKd2iVGFkxSxIzZMftZ5JwXZ5j4=;
        b=dbMhsh/zR7tc99N2aoQwwBVlVHLgW1t7vgzx8B/FiCZ0Ai4jsd7O8dgxaWUYJUaTwZ
         l+HdXluiiPd7pSVqel2Ib3BKfBOQzFowMtwz7RNBnMOzmLWEX0seyR81xsKUm0PG1/Bk
         rS34NnimelbrIF4gjOULXCFRDKJO08Cd1odOJQ6+ekuajPEcOjBqvf8MiImbTz7bSNGw
         cWIsvvy1eqPbXntyOChKAxx/DEy5DyWl3aVYoYeCYuDzzkCW8HH70KNOuQyuQcefnQJv
         g7qWsJbmWLVjjmItIKLOP039+0Yy6BsTsofByvQ/609BrwsreSBDZphVgSpS08kWkJ85
         5ADA==
X-Gm-Message-State: AOAM53231MeioXyN4rTwfAAAKotT83jQqmTx+7RAslNPyPWEKBA+WKph
        8X47K4gyEFprH1CNGFzw38CpUndNoxl++g==
X-Google-Smtp-Source: ABdhPJycOC5KE7sTAaq6mb5AqkYcpuS3Rzs8pNwRez4mHHZtT3PCHxMgR6d/ODCgc1DUSboJaRwx8A==
X-Received: by 2002:ac8:53c1:: with SMTP id c1mr31680165qtq.193.1593698178741;
        Thu, 02 Jul 2020 06:56:18 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z19sm9504406qtz.81.2020.07.02.06.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:56:18 -0700 (PDT)
Subject: Re: [PATCH 1/3] btrfs: Introduce extent_changeset_revert() for qgroup
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702001434.7745-1-wqu@suse.com>
 <20200702001434.7745-2-wqu@suse.com>
 <b716bb32-b5e6-54a5-ac42-ca559dfd2d3a@toxicpanda.com>
 <55b63978-fab1-bb2c-bd0a-66fc29af5f26@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1f9fe912-72d4-01a5-a5a1-90e87df33037@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:56:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <55b63978-fab1-bb2c-bd0a-66fc29af5f26@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 9:50 AM, Qu Wenruo wrote:
> 
> 
> On 2020/7/2 下午9:40, Josef Bacik wrote:
>> On 7/1/20 8:14 PM, Qu Wenruo wrote:
>>> [PROBLEM]
>>> Before this patch, when btrfs_qgroup_reserve_data() fails, we free all
>>> reserved space of the changeset.
>>>
>>> This means the following call is not possible:
>>>      ret = btrfs_qgroup_reserve_data();
>>>      if (ret == -EDQUOT) {
>>>          /* Do something to free some qgroup space */
>>>          ret = btrfs_qgroup_reserve_data();
>>>      }
>>>
>>> As if the first btrfs_qgroup_reserve_data() fails, it will free all
>>> reserved qgroup space, so the next btrfs_qgroup_reserve_data() will
>>> always success, and can go beyond qgroup limit.
>>>
>>> [CAUSE]
>>> This is mostly due to the fact that we don't have a good way to revert
>>> changeset modification accurately.
>>>
>>> Currently the changeset infrastructure is implemented using ulist, which
>>> can only store two u64 values, used as start and length for each changed
>>> extent range.
>>>
>>> So we can't record which changed extent is modified in last
>>> modification, thus unable to revert to previous status.
>>>
>>> [FIX]
>>> This patch will re-implement using pure rbtree, adding a new member,
>>> changed_extent::seq, so we can remove changed extents which is
>>> modified in previous modification.
>>>
>>> This allows us to implement qgroup_revert(), which allow btrfs to revert
>>> its modification to the io_tree.
>>>
>>
>> I'm having a hard time groking what's going on here.  These changesets
>> are limited to a [start, end] range correct?
> 
> Yes, but we may be only responsible for part of the changeset.
> 
> One example is we want to falloc range [0, 16K)
> And [0, 4K), [8K, 12K) has already one existing file extent.
> 
> Then we succeeded in allocating space for [4K, 8K), but failed to
> allocating space for [8K, 12K).
> 
> In that case, if we just return EDQUOT and clear the range for [4K, 8k)
> and [8K, 12K), everything is completely fine.
> 
> But if we want to retry, then we should only clear the range for [8K,
> 12K), but not to clear [4K, 8K).
> 
> That's what we need for the next patch, just revert what we did in
> previous set_extent_bit(), but not touching previously set bits.
> 

Ok so how do we get to this case then?  The changeset already has the range 
we're responsible for correct?  Why do we need the sequence number?  Like we 
should have a changeset for [4k, 8k) and one for [8k, 12k) right?  Or are we 
handed back the whole thing?  If we fail _just_ for the [8k, 12k) part, do we 
know that?  Or do we just know our whole [0k, 16k) thing failed, and so we need 
all this convoluted tracking to be able to retry for the range that we fucked 
up, and this is what you are facilitating?  Thanks,

Josef
