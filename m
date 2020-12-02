Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21AA2CC484
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 19:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgLBSFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 13:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgLBSFy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 13:05:54 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53481C0613D4
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 10:05:08 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d9so2097402qke.8
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 10:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=49c1gp+KKsYKeNjpUKodRRS9wKApm7v+zSrpRBFgqNg=;
        b=TTl4yzQDWPhQEBEbq3MFsFlR2qmwjYFiG9ZLdhjHvrCGfJRMJj1rr0byViGC6sUgWl
         ObLtgYJZyaZdAPgXG2SN30BbmdsmOFaUdtGpTrV/PnSanqef49rMXHciOVJiJmgNDrUD
         gLyHqYfR+SI4YR8sOm2bhrAL9QqqYW61PUNfcQi9+1T83fkhC3atvRfzAHclds3mgqQp
         8M6UhziiUeRlsCHtD3k455LNSRFU1vD3RYUHbB3pcgOHKUzLi5euY0wg7BKT65/bt74W
         8Aw5OKlt9VzVIw6ab6WcqpylwJei7AgodJ3fqIiGlvV6jog/QTzs7HzBaWgbHBaia0cp
         OtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=49c1gp+KKsYKeNjpUKodRRS9wKApm7v+zSrpRBFgqNg=;
        b=uf4FYwyVu5nD4RDInPzrqWmFYcQgisihkPq2gR2dVNdxy8e1WDRYfzfjdc70+OyJcv
         UrvI0Q9mbqYbheG+/kCy8G9D1L1kboFtLJe8dXNHifo1qoR6vzWb1j4U9hKKluUOxoy7
         inAWly+Pg9nOl7ksu9LqUHeXguByWh/e0a7RKPYrD0/ah6nEinceHyvAM+/wTcYlnsyp
         SHgFAw9ZpDqx+asRYHtnit3EHjng9ys/6gUffEqtK9dC53hrwA1RvC9AbPA2Rw0WrKQy
         DClIaSwwZMQPh9fBxneVUZrBBc5oVM3JN47ORdvh/UwHAsjGrLwU3548OWHcv4Qs9Zdl
         7FjQ==
X-Gm-Message-State: AOAM533tD4NLL4nE5fndG6QYPWeYn6XS6eegxMYUjhpAF+yinbow1wL9
        XQ4RfqK2OjQXiVJ0x0FTCVmQDA==
X-Google-Smtp-Source: ABdhPJxtpyU1YQvzq1kE5WTo3uMlxk4HavUaHRenVKopuvceZp/rfWmYDq/Bps35kRNoLInLcuC2rg==
X-Received: by 2002:a37:a546:: with SMTP id o67mr3803604qke.167.1606932307373;
        Wed, 02 Dec 2020 10:05:07 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::1348? ([2620:10d:c091:480::1:f2b1])
        by smtp.gmail.com with ESMTPSA id j19sm2566289qkk.119.2020.12.02.10.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:05:06 -0800 (PST)
Subject: Re: [PATCH v2 13/42] btrfs: handle btrfs_record_root_in_trans failure
 in btrfs_recover_log_trees
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1605284383.git.josef@toxicpanda.com>
 <8055a43c75716d186b29441c5c78f6bdf04d47ed.1605284383.git.josef@toxicpanda.com>
 <6512c611-097e-d49c-14c1-822c627f6882@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bc48588a-af2b-a96e-ed2c-12fcc893ff98@toxicpanda.com>
Date:   Wed, 2 Dec 2020 13:05:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <6512c611-097e-d49c-14c1-822c627f6882@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/24/20 7:37 AM, Nikolay Borisov wrote:
> 
> 
> On 13.11.20 г. 18:23 ч., Josef Bacik wrote:
>> btrfs_record_root_in_trans will return errors in the future, so handle
>> the error properly in btrfs_recover_log_trees.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/tree-log.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
>> index 955c9a36cfeb..1ad77e2399f7 100644
>> --- a/fs/btrfs/tree-log.c
>> +++ b/fs/btrfs/tree-log.c
>> @@ -6276,8 +6276,12 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
>>   		}
>>   
>>   		wc.replay_dest->log_root = log;
>> -		btrfs_record_root_in_trans(trans, wc.replay_dest);
>> -		ret = walk_log_tree(trans, log, &wc);
>> +		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
>> +		if (ret)
>> +			btrfs_handle_fs_error(fs_info, ret,
>> +				"Couldn't record the root in the transaction.");
>> +		else
>> +			ret = walk_log_tree(trans, log, &wc);
> 
> After handle_fs_error the filesystem is in RO state so in case of error
> simply call the function and goto error?

We are holding a ref on the destination root, so we have to do this in order to 
make sure the cleanup is done properly.  I'll note this in the commit log.  Thanks,

Josef
