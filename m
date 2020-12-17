Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AC02DD31F
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 15:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgLQOkB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 09:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbgLQOkB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 09:40:01 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4FBC061794
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:39:20 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id w79so26494940qkb.5
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=A6AstZi0SA/84WXNtLxzSnyBOgEI+S3seDXtSYJBtQ8=;
        b=Nr8AEU7wlfkdpQeXXqwX2byYsravS6fXpxFKfdRcMHuqmfil4lasibFFXnGzgCaEhf
         s9AV/o5LylCl+JS/QI8rIL4+pQGsPv2q5NGIHnjQ/Nx1lQWKNQ1KS7B459EmLngWobPr
         6tEFKa65rLTcN9wEqaZu7qqD9lfiz9PiGmnGKTxAkE3wqZ0UOfVLglotreSBZZpboNvO
         jB75QsFFvFICAPlEnd5tPzfMDa61l+GGdk3peCHgL4XaeqqTnlHwP7qoXb143sp7e6+n
         eWj07mKUZKy9MomZ6E9qaZg87Q4mIlJverudlgktBEmvz5ulVoCEsK4kN0YJHnECc7eF
         ljpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A6AstZi0SA/84WXNtLxzSnyBOgEI+S3seDXtSYJBtQ8=;
        b=QJrztqhm6qDA9mqbi1O/hesN6yW2ksqXEJpePFVYAGCC+k1k6cX/9ZvQPUMcLka6l9
         rkBcGM+a5mhn8SUEI6kmvCJ1/6DIb8O2KMVzAShuOJHhiQCEhX2Pr5KvGV5FFMrHSotB
         WX3m8L1zd6wPj0J9JOQuseEME/GhGfo8egBbyT9rKsX9m2QoKKG11AHSLYIpDl9s3vMv
         VNmqxFEw9sugSfPrJ0FLe2jrGQesbSEYc4pvSPgZpe7lneiqbrreW0OWysmbwcEJrcyo
         9qRnUX7XNPufkQBDhzwPBf6c+qLWXMNf7KVyGIZthn0GeFH6WQ9E0lHvT5h9yYl4A+Oa
         RtvA==
X-Gm-Message-State: AOAM531Z3MN8FO5z9fUpxEllYJof9cKF3SJTQvjEY4/n7FT5gcU42uXP
        zE1zVHWFCRTjDVOOUF8dCE0J+g==
X-Google-Smtp-Source: ABdhPJxu5GfhGuDLZEin86+eDP0R6gyGm992MKqCi2gHIgDi6y76+s+eEse5zAMMzXOvBFzl6c3rzQ==
X-Received: by 2002:a37:a796:: with SMTP id q144mr21175766qke.38.1608215959801;
        Thu, 17 Dec 2020 06:39:19 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h26sm3180651qtq.18.2020.12.17.06.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 06:39:18 -0800 (PST)
Subject: Re: [PATCH] btrfs: initialize test inodes location
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <7d1759263b14140254494b1ae49fe69aff099dc1.1608051618.git.josef@toxicpanda.com>
 <20201217124103.GN6430@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c779da25-61f3-85fb-b593-fdd614ab8931@toxicpanda.com>
Date:   Thu, 17 Dec 2020 09:39:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201217124103.GN6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/17/20 7:41 AM, David Sterba wrote:
> On Tue, Dec 15, 2020 at 12:00:26PM -0500, Josef Bacik wrote:
>> While testing other things I was noticing that sometimes my VM would
>> fail to load the btrfs module because the self test failed like this
>>
>> BTRFS: selftest: fs/btrfs/tests/inode-tests.c:963 miscount, wanted 1, got 0
>>
>> This turned out to be because sometimes the btrfs ino would be the btree
>> inode number, and thus we'd skip calling the set extent delalloc bit
>> helper, and thus not adjust ->outstanding_extents.  Fix this by making
>> sure we init test inodes with a valid inode number so that we don't get
>> random failures during self tests.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/tests/btrfs-tests.c | 7 ++++++-
>>   fs/btrfs/tests/inode-tests.c | 9 ---------
>>   2 files changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
>> index 8ca334d554af..0fede1514a3e 100644
>> --- a/fs/btrfs/tests/btrfs-tests.c
>> +++ b/fs/btrfs/tests/btrfs-tests.c
>> @@ -55,8 +55,13 @@ struct inode *btrfs_new_test_inode(void)
>>   	struct inode *inode;
>>   
>>   	inode = new_inode(test_mnt->mnt_sb);
>> -	if (inode)
>> +	if (inode) {
>> +		inode->i_mode = S_IFREG;
>> +		BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
>> +		BTRFS_I(inode)->location.objectid = BTRFS_FIRST_FREE_OBJECTID;
>> +		BTRFS_I(inode)->location.offset = 0;
>>   		inode_init_owner(inode, NULL, S_IFREG);
>> +	}
> 
> As this is adding more statements to the if-block, I'd rather rewrite it
> as
> 
> 	inode = new();
> 	if (!inode)
> 		return NULL;
> 
> 	inode-> ...
> 

Agreed, I've updated it locally, I'll wait for comments for the rest of the 
series and then resend.  Thanks,

Josef
