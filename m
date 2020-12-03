Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9422CDB58
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 17:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgLCQfW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 11:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgLCQfW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 11:35:22 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8C8C061A4F
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 08:34:42 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id x25so2654355qkj.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 08:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JDHqOMlR7t7kHNd6qD/G533NYqCAlTv7hfkObOMEPYY=;
        b=nKIRRXSB2ecKD1eWtvZ6sQsObJvOGLXgwyx/U8b9/9K4J3UFbBM4YZir8hI6CxcfhH
         a3Dc7MGnuHRhIYvnwQ8ujh7kYJO++yYJhjjyVpW3Q5xaXEeFa6NmMr0URyk43RZJZyW+
         w7ZG4mu0OoSnxHTFjwQonO4FaJTk3gJ8ImQr+8MivFO4ZRbw5wDL6CYuQJHCnv1k7a/K
         ALenKvfn2pAhszLRzQlzwcpcf9JDoKAiXcaWk2Du9x5UTa1iFO+BN+USLXbA3OomuAlV
         FExbatB8wRm66gDFV5HVO+WXv7/Tjc5crbDdiAvCBMDst/MtjltZx1a3rSfhIIs3We2A
         Dmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JDHqOMlR7t7kHNd6qD/G533NYqCAlTv7hfkObOMEPYY=;
        b=VHRdIsIJph3ISmoCKCI0M/VAp2sFVqIHpbPX5tOeiAdQhEAjjM+Vbys31FA9Y1tHmm
         6jPVZhxkgyQgXmUNyMWVE0xqlpKVS/+lZaLCd/gIsDOI3glxrCCFQYLmtTO1f5KKheet
         4Hkoi8kuepQIW+AIkGMM/oz0mbRS2Jj1ob4igkRqZ1e+vIZK7saPwbtVkseFbHEyOOAa
         DYJcGUIRRsEhxmj9ocm5WbElRtvI6asRSZw+ee+YMk0JpmkDDaSp/sCsvy8TjJCANmgN
         DatT9wSOYvLWiG0L3kqAGNtj2KNYdCCmA2xKmZ4fSjD2F/yP8zhdYcjYc6l+gaPEs8Zl
         4ekg==
X-Gm-Message-State: AOAM5306DmbtCgNSlvX9cpe538QvP7O1IVYMqAjzBG6Vzc5W9ICOyb9E
        66RKX0SmHfs9VkTgB1EBpee49g==
X-Google-Smtp-Source: ABdhPJwpulKR+27Vw7DnGX7gMZJIr3iitr2jL9RZFPQ9N1D1jVYuJk9DPs679TV0FCMOqyLvQWFauA==
X-Received: by 2002:ae9:dc06:: with SMTP id q6mr3658697qkf.310.1607013281408;
        Thu, 03 Dec 2020 08:34:41 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a3sm1578960qtp.63.2020.12.03.08.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 08:34:40 -0800 (PST)
Subject: Re: [PATCH v3 44/54] btrfs: do proper error handling in
 create_reloc_inode
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <497be2d1fd745d88d6cbeda5d77168781b5522df.1606938211.git.josef@toxicpanda.com>
 <9ec262a0-3dac-869d-5ed7-c0f69e9218e7@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fbe931a0-3794-f0d1-9e30-e3d98cc64914@toxicpanda.com>
Date:   Thu, 3 Dec 2020 11:34:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <9ec262a0-3dac-869d-5ed7-c0f69e9218e7@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/3/20 12:25 AM, Qu Wenruo wrote:
> 
> 
> On 2020/12/3 上午3:51, Josef Bacik wrote:
>> We already handle some errors in this function, and the callers do the
>> correct error handling, so clean up the rest of the function to do the
>> appropriate error handling.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/relocation.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 8f4f1e21c770..bcced4e436af 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -3634,10 +3634,15 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
>>   		goto out;
>>   
>>   	err = __insert_orphan_inode(trans, root, objectid);
>> -	BUG_ON(err);
>> +	if (err)
>> +		goto out;
>>   
>>   	inode = btrfs_iget(fs_info->sb, objectid, root);
>> -	BUG_ON(IS_ERR(inode));
>> +	if (IS_ERR(inode)) {
> 
> When error happens here, we have already inserted an inode item into the
> data reloc root, without the orphan item to clean it up.
> 
> It won't cause any problem, since we have u64 to store almost endless
> inodes in a mostly empty tree.
> 
> But I guess we'd still better try to delete the inserted inode item, or
> data reloc tree may one day become a landfill with all those inode items.
> 

Yeah we shouldn't be in the business of leaving random artifacts around, I'll 
fix this up.  Thanks,

Josef

