Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB4C2B19A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 12:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgKMLIy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 06:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgKMLGi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 06:06:38 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B628C061A4A
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 03:05:23 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so8360576qkc.12
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 03:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yfrOoML514/4co/mqAqTIQvWl3bJ6Cd2O6DFCjq1prs=;
        b=I52DB1El6XsD57qG3TZRqIBjutfbZLzzdmwGI9SThqiQ8yTF5ZDy610+p9wBEVdedA
         2Qi+dt3UOflM+MXOfTp9D+LBthufP5Otc/GHfi9O2Sp9gWK0tZYMi6EQQJ/h2livJnC0
         VOENg+Cs0bwnY5eMkI1Xalxa45iHuUgvd0fgjyI+pv+Z6oIdnlpqxHuMDpdTy6k5o+7D
         QQy6mPsL+NxuQVHNZOJ/omCdPDiTlOAyuASV5ZE+Mj3LhW+teQPncmq2CvkoQH0VKHP7
         dDS6G7/vlAedXuVrTP9kVecsmniAa+WFhMzWVHC340g3LF6fEj9NzsNxlNB7JJ6vxdgr
         ucww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yfrOoML514/4co/mqAqTIQvWl3bJ6Cd2O6DFCjq1prs=;
        b=WxVd88XQVJaj2DlAcj3dlZ9vRhKm+bgocNGXZEdD581dS3wiMnCaFoC/lzB3WeYSa0
         nvA/9J0yMNRIZH3pi+M4M91WdLIzEbGCHc/GQgVNO/o34sYw5W5XBb2HmrNrqBeHCC6j
         5e3ObIxhuS3+Fki9nmFDPVioxi0ue0X3lFxsnCk7C7/rEXKg53jYEOROebvhPURtwJDq
         J5R0SSVBfNOs8j/Rkuayz1O/KFxkU8ifTILBSYtSCAIuIPaBES3rYEtsGiH3xbQmCCn7
         nOs00azNWYcc9zStepTHD+a/dlnp8qRd99UWz6RWv8LGXYfSsXF6aYvgxUxzfuk5Rxlj
         TkPg==
X-Gm-Message-State: AOAM533kPxXNpSfPLW0WTrRt33P0BpnDzxKkVRKc+nlt+2nHawt6O6Mq
        VO8UX9ocBAsaWHnjAmq5CAsW8ygQBU3gdQ==
X-Google-Smtp-Source: ABdhPJw5/eF7D7Us9T9PJAwMBKIaaGkHc4/CB7jBabj/1tgw1VK9Fmz1puPT82ce9v4/5YpHCKemFg==
X-Received: by 2002:a37:4854:: with SMTP id v81mr1401972qka.20.1605265522584;
        Fri, 13 Nov 2020 03:05:22 -0800 (PST)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 207sm1752396qki.91.2020.11.13.03.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:05:21 -0800 (PST)
Subject: Re: [PATCH 01/42] btrfs: allow error injection for btrfs_search_slot
 and btrfs_cow_block
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1605215645.git.josef@toxicpanda.com>
 <d4d168d0a592fa8f828174b3f93fa463b922d492.1605215645.git.josef@toxicpanda.com>
 <1f01b959-ad54-106f-4364-77b6cdbd6c0a@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5a052e77-607f-d408-154d-1877dbbcc94e@toxicpanda.com>
Date:   Fri, 13 Nov 2020 06:05:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1f01b959-ad54-106f-4364-77b6cdbd6c0a@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/12/20 7:02 PM, Qu Wenruo wrote:
> 
> 
> On 2020/11/13 上午5:18, Josef Bacik wrote:
>> The following patches are going to address error handling in relocation,
>> in order to test those patches I need to be able to inject errors in
>> btrfs_search_slot and btrfs_cow_block, as we call both of these pretty
>> often in different cases during relocation.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/ctree.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>> index d2d5854d51a7..a51e761bf00f 100644
>> --- a/fs/btrfs/ctree.c
>> +++ b/fs/btrfs/ctree.c
>> @@ -1493,6 +1493,7 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
>>   
>>   	return ret;
>>   }
>> +ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
>>   
>>   /*
>>    * helper function for defrag to decide if two blocks pointed to by a
>> @@ -2870,6 +2871,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>>   		btrfs_release_path(p);
>>   	return ret;
>>   }
>> +ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
> 
> This concerns me a little.
> 
> For error case, wouldn't we also free the path?
> But if we just override the error, the path is not freed by anyone,
> neither caller nor btrfs_search_slot() would free the path.
> 
> Or did I miss something?
> 

You're missing that the caller is responsible for free'ing the path, 
failing btrfs_search_slot isn't going to leak anything unless there's a 
bug with the caller.  Thanks,

Josef
