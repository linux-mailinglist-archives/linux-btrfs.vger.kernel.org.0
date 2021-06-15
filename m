Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070973A8081
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jun 2021 15:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhFONkf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 09:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhFONjs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 09:39:48 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C330AC0613A4
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jun 2021 06:37:36 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id u20so11214185qtx.1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jun 2021 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=goev78KTRwSihvJJ4DbK1rkMP7cZKBvVkokgGMEXEzA=;
        b=KV83j3dWZzmGTNEvAPX5b+XerPcy3fxDd1Rv3W+WAJlZr2P1guBFa8QLVJuo2lMXnX
         EHRw/9BbE3OPZIgWZ/BhWJ8WzNgkWxg6OTuk6jVJqbwCAc5ralS3DAoURVkWBN5Z65m8
         sFgbKIo7XqYYhPjSVYTubu1LnRcTtOJW+2pAAaF5gaA3tYp+tpN4sE9NTU/WIWJvhARP
         PlWtuMUwpVZtg3EXtK8XGyx3hZu7gU0OvH5M2B5uC4W1Q5Do8MkG2ERtdETxAET/PTVu
         8+bPoj1rtAQDRrrmSwG9y5abIOQ/SX8FruCKaN54dV937aL8n2Pne2LGL0mbef3zIWrk
         gziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=goev78KTRwSihvJJ4DbK1rkMP7cZKBvVkokgGMEXEzA=;
        b=qj9vDj8H4bz9yknhR3Jb5qFZPhJknSGPsKYe30aMhsL5cymZoOgdY0rlDif8PEL5XI
         qPdAQr6OAnuFX36QfalLMoIson4phJVSqb2IuV4fy0b3BiTlRRAvYblj1Gl86se8XeiT
         0THJvZCpIgtFYmQJw/ZX3cE4hwTFxBtI3ZSgvSDtvy4+4+xEDtFC1jXW8iTV3qU1P2Dq
         Q+tnf5HQFRKe5VPn9tFy8CHrWpCpLf4XiqiDMkekrzbDNPDvzt5V5JV4iTUWeo0wGFar
         JSHkr5bfzOYr6xYd0uJxw4JkONmsCrmKucmWSUXrJxi1JRTwkQhg0SrlPsCAd0LBQC++
         bMsQ==
X-Gm-Message-State: AOAM5337vlyLBHtg7ltjn+ybTW3KIS9HHL63rxxAZRCVsnuI/ZNrTG1x
        mhQ6tkhpgvW5lss5q4t02X3b4g==
X-Google-Smtp-Source: ABdhPJzmluXTaG6pJx2CXk/UgEJkDy5ar4iZmE16H1+RGZl3otHGMYxenjUlq2lHi2qRcthfpAZ6MQ==
X-Received: by 2002:ac8:7516:: with SMTP id u22mr21766856qtq.160.1623764255653;
        Tue, 15 Jun 2021 06:37:35 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r22sm7392667qtm.82.2021.06.15.06.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 06:37:34 -0700 (PDT)
Subject: Re: [PATCH 3/4] fs: add a filemap_fdatawrite_wbc helper
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1623419155.git.josef@toxicpanda.com>
 <b7ce962335474c7b0e96849cd9fb650b1138cbb3.1623419155.git.josef@toxicpanda.com>
 <83038b23-71df-962c-167f-db0b21b83025@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8c1d5edb-8149-f0e3-6170-2b25fdaa4e9f@toxicpanda.com>
Date:   Tue, 15 Jun 2021 09:37:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <83038b23-71df-962c-167f-db0b21b83025@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/14/21 6:16 AM, Nikolay Borisov wrote:
> 
> 
> On 11.06.21 г. 16:53, Josef Bacik wrote:
>> Btrfs sometimes needs to flush dirty pages on a bunch of dirty inodes in
>> order to reclaim metadata reservations.  Unfortunately most helpers in
>> this area are too smart for us
>>
>> 1) The normal filemap_fdata* helpers only take range and sync modes, and
>>     don't give any indication of how much was written, so we can only
>>     flush full inodes, which isn't what we want in most cases.
>> 2) The normal writeback path requires us to have the s_umount sem held,
>>     but we can't unconditionally take it in this path because we could
>>     deadlock.
>> 3) The normal writeback path also skips inodes with I_SYNC set if we
>>     write with WB_SYNC_NONE.  This isn't the behavior we want under heavy
>>     ENOSPC pressure, we want to actually make sure the pages are under
>>     writeback before returning, and if another thread is in the middle of
>>     writing the file we may return before they're under writeback and
>>     miss our ordered extents and not properly wait for completion.
>> 4) sync_inode() uses the normal writeback path and has the same problem
>>     as #3.
>>
>> What we really want is to call do_writepages() with our wbc.  This way
>> we can make sure that writeback is actually started on the pages, and we
>> can control how many pages are written as a whole as we write many
>> inodes using the same wbc.  Accomplish this with a new helper that does
>> just that so we can use it for our ENOSPC flushing infrastructure.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   include/linux/fs.h |  2 ++
>>   mm/filemap.c       | 29 ++++++++++++++++++++++++-----
>>   2 files changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index c3c88fdb9b2a..aace07f88b73 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -2886,6 +2886,8 @@ extern int filemap_fdatawrite_range(struct address_space *mapping,
>>   				loff_t start, loff_t end);
>>   extern int filemap_check_errors(struct address_space *mapping);
>>   extern void __filemap_set_wb_err(struct address_space *mapping, int err);
>> +extern int filemap_fdatawrite_wbc(struct address_space *mapping,
>> +				  struct writeback_control *wbc);
>>   
>>   static inline int filemap_write_and_wait(struct address_space *mapping)
>>   {
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 66f7e9fdfbc4..0408bc247e71 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -376,6 +376,29 @@ static int filemap_check_and_keep_errors(struct address_space *mapping)
>>   		return -ENOSPC;
>>   	return 0;
>>   }
>> +/**
>> + * filemap_fdatawrite_wbc - start writeback on mapping dirty pages in range
>> + * @mapping:	address space structure to write
>> + * @wbc:	the writeback_control controlling the writeout
>> + *
>> + * This behaves the same way as __filemap_fdatawrite_range, but simply takes the
> 
> That's not true, because __filemap_fdatawrite_range will only issue
> writeback in case of PAGECACHE_TAG_DIRTY && the inode's bdi having
> BDI_CAP_WRITEBACK. So I think those checks should also be moved to
> fdatawrite_wbc.
> 

Yeah I'll move those into _wbc

> In fact what would be good for readability since we have a bunch of
> __filemap_fdatawrite functions is to have each one call your newly
> introduced helper and have their body simply setup the correct
> writeback_control structure. Alternative right now one has to chase up
> to 3-4 levels of (admittedly very short) functions. I.E
> 
> filemap_fdatawrite->__filemap_fdatawrite->__filemap_fdatawrite_range->filemap_fdatawrite_wbc
> 
> which is somewhat annoying. Instead I propose having
> 
> filemap_fdatawrite->filemap_fdatawrite_wbc
> filemap_flush->filemap_fdatawrite_wbc etc...
> 

Yeah I'd like to clean this up at some point, but that's outside the scope of 
this patch.  I want to get a helper in without needing to run it by everybody, 
we can take up cleaning this up at a later point with input from everybody else. 
  Thanks,

Josef
