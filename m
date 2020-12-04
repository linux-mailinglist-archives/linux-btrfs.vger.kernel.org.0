Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D715A2CF520
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 20:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbgLDTxR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 14:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730895AbgLDTxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Dec 2020 14:53:17 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABF5C061A4F
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Dec 2020 11:52:37 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 1so6636336qka.0
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Dec 2020 11:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6AcjSBvkSQoCryUzo1jdG6rTuHSfL5eQANkAChmN9TM=;
        b=yvfIogD9M/hHZkcAKH7BuNnLquj7ENBShlA20frp/cxxbdUUl4LA7QEpY8QnrONsCz
         KZvxOSF7JdwNRDaZkwjQlTLom4JDZHt+/pBcutl59QvH+s2HItnECD7iKm4s9V0jz+Fr
         qdlFRofwr+eN6nygu8D9ntP3h9bEr7jq+kpqHWKMtN8cljM31rOho/cUgHnw5iCMlSh6
         4lF+ODSJjJlcLFPWJnNifBDeIJpvVo1zaHYPYxKfhAgYHHeilJbgJ/a8qjIhMh+JEBBt
         Z0ct9cTibsVQwx+xo7aCcB/XM2Ez8STbM57PPtVvNr6vFZzVcpSGxZZmweb10wdrdhVv
         v0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6AcjSBvkSQoCryUzo1jdG6rTuHSfL5eQANkAChmN9TM=;
        b=Jb36n3ZCKnRy5Cg1UGJ2LVDfyaT4qQE1Q/L+dttUW3NZA7rvEWhzueHWhlQ26OQd5i
         dx8w8ElVfeHIJXmA+uku/HPQOcpN1bAtxKzsb8iT/NGibGF3Xt/TV3kKYW7Ng9ds2z0+
         UIn8pk9hhAlJCaqkoHhjLSKHWw6WmoeEREXRLxQzwER1f2c92dBdkZD9ijpx3diqUlob
         bmIwysoVXoCzB+kZbn5XVhdylXwdH3g90x16Y/elX9jVd949vDsb8g8kZkiB+SPzK44y
         ewf5y8Rrcq9Mk6YeKKD3iNTUct5+xoPN4fn7XslF4beH2EtnBBLHcX2FNYcLcgrCykC6
         PiMg==
X-Gm-Message-State: AOAM533bPnkS0TjlCm9MH5pMdoKe7sZN1OaZZJAyxYZTBQkO5GsuS5fA
        dlNR5kEmC0nDhPyODryMZnOlHA==
X-Google-Smtp-Source: ABdhPJwImGh7kqfIfuPkRlrwFcoMGEcPV269+AbXHimEeEm7Q/COwLZesttA3iaiZ/i7/2N29kcWbw==
X-Received: by 2002:a37:a2c5:: with SMTP id l188mr10867701qke.343.1607111556053;
        Fri, 04 Dec 2020 11:52:36 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i203sm6008227qke.49.2020.12.04.11.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 11:52:35 -0800 (PST)
Subject: Re: [PATCH] btrfs: fix error handling in commit_fs_roots
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <29f468ffe7b19dbebae2201f10307ec4f34f1c88.1606834393.git.josef@toxicpanda.com>
 <20201204165217.GV6430@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7358ceca-01e1-c30e-a81c-baacc173553d@toxicpanda.com>
Date:   Fri, 4 Dec 2020 14:52:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201204165217.GV6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/4/20 11:52 AM, David Sterba wrote:
> On Tue, Dec 01, 2020 at 09:53:23AM -0500, Josef Bacik wrote:
>> While doing error injection I would sometimes get a corrupt file system.
>> This is because I was injecting errors at btrfs_search_slot, but would
>> only do it one time per stack.  This uncovered a problem in
>> commit_fs_roots, where if we get an error we would just break.  However
>> we're in a second loop, the first loop being a loop to find all the
>> dirty fs roots, and then subsequent root updates would succeed clearing
>> the error value.
>>
>> This isn't likely to happen in real scenarios, however we could
>> potentially get a random ENOMEM once and then not again, and we'd end up
>> with a corrupted file system.  Fix this by moving the error checking
>> around a bit to the main loop, as this is the only place where something
>> will fail, and return the error as soon as it occurs.
>>
>> With this patch my reproducer no longer corrupts the file system.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/transaction.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>> index 1dac76b7ea96..b05f75654b16 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -1328,7 +1328,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
>>   	struct btrfs_root *gang[8];
>>   	int i;
>>   	int ret;
>> -	int err = 0;
>>   
>>   	spin_lock(&fs_info->fs_roots_radix_lock);
>>   	while (1) {
>> @@ -1340,6 +1339,8 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
>>   			break;
>>   		for (i = 0; i < ret; i++) {
>>   			struct btrfs_root *root = gang[i];
>> +			int err;
> 
> I'd rather get rid of 'err' for the return values, in this case we can
> reuse 'ret'.
> 

Sure, I'll fix and respin.

>> +
>>   			radix_tree_tag_clear(&fs_info->fs_roots_radix,
>>   					(unsigned long)root->root_key.objectid,
>>   					BTRFS_ROOT_TRANS_TAG);
>> @@ -1366,14 +1367,14 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
>>   			err = btrfs_update_root(trans, fs_info->tree_root,
>>   						&root->root_key,
>>   						&root->root_item);
>> -			spin_lock(&fs_info->fs_roots_radix_lock);
>>   			if (err)
>> -				break;
>> +				return err;
>> +			spin_lock(&fs_info->fs_roots_radix_lock);
>>   			btrfs_qgroup_free_meta_all_pertrans(root);
> 
> Do we need to call btrfs_qgroup_free_meta_all_pertrans before returning?
> 

It doesn't look like it, and we'd miss any existing roots if we did.  It doesn't 
appear that any qgroup accounting gets cleaned up in the case of an error, so it 
must work out already?  If not then we need to address that separately, because 
if we're relying on the cleanup to happen here we'll mess up if the error 
happens before we even get to commit_fs_roots.  Thanks,

Josef
