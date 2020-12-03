Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3039C2CDBBC
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 18:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbgLCRFH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 12:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgLCRFG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 12:05:06 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4D1C061A4E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 09:04:20 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id b9so1861868qtr.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 09:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+mqIN3+ha25t5SRHcbxcDqX87JLBVajC/zi6CkG6mMU=;
        b=iQCWSMqAmRIvoVcXUzkWpGeSt49HVp2P0f/b44mSIeth1oei36rPPV0+qu82jW5aZo
         XSYDnSSijwSz/eqd5D88MGq/UMVCRvsv3rnBwfxQ4UoRGtutHw/kpJjt8Va+0dAc8NAJ
         kEfLGj63CYWplCO6VbBVolAGUgiT3tRM/HeCoOTggGV95r9W2bcVGzqOORaDcBfc9cq2
         oremPDltyAyMTx5Yd/exex1uFApyX9mxgAmzemhuFrlOzGDrQWa54vLMHCG7E7hW3odc
         IcyecCQBOdiF4vTX/hdDkatFX1QgZlj4mTvpuOJY0MDNWV9LD5WNFUDSIW1AcwFdzwXu
         wCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+mqIN3+ha25t5SRHcbxcDqX87JLBVajC/zi6CkG6mMU=;
        b=s3N7CPUS31Bs/O17jHEjhcFiKwEojD8CYdkjcoqUABWoHvFht94GRY7BLhPibYBi92
         1whrVs1tdwtQ7Y3ITrtPUkrLHsE+gowKNsOPN5mLQJBWB5y4AUcnjYXPr6piNoAsWb9b
         u8VPbVLB29NI8yAJU9LdRBCWyqnzPJkvjGllfBbxN1x1OM5CpoxpoaKJcGuLv+sF4TOz
         /137WR+QQQuN4Evw3nBniUSSjVYgUxse/RJYN3//MZTgbBO//lX0J3M7dmMIZ7GBmWCj
         qqHiTWOs759AKnuXycalc3+WwwkqVtJaKdsXI+GyP5VG6HUuKl0xuFwFR6Nnu/Xt099v
         pnpw==
X-Gm-Message-State: AOAM532p3ZiWeUTZrdOSPhZ+xyAEIWalrNr6U5HdI2J4ZPt9HZ4y6psD
        DqBTr6tOYm4uPSs7o3Ww45XoLg==
X-Google-Smtp-Source: ABdhPJwQyjEURunu5LWDxvrq+QfICjZmdWV0P25oJRTN4clh8ThXid46Qr56QpmIOH0m+unsqoO3xw==
X-Received: by 2002:ac8:130d:: with SMTP id e13mr4174951qtj.228.1607015059778;
        Thu, 03 Dec 2020 09:04:19 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k70sm1825219qke.46.2020.12.03.09.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 09:04:19 -0800 (PST)
Subject: Re: [PATCH v3 05/54] btrfs: noinline btrfs_should_cancel_balance
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <4657a485af5665a07682c4d7a5eb14ef241995a5.1606938211.git.josef@toxicpanda.com>
 <98f78cfc-f623-5ee1-fb09-c8ab8c44f587@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <90fc99f2-9423-0c9d-4342-6e8a5e6a7b06@toxicpanda.com>
Date:   Thu, 3 Dec 2020 12:04:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <98f78cfc-f623-5ee1-fb09-c8ab8c44f587@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/3/20 4:00 AM, Nikolay Borisov wrote:
> 
> 
> On 2.12.20 г. 21:50 ч., Josef Bacik wrote:
>> I was attempting to reproduce a problem that Zygo hit, but my error
>> injection wasn't firing for a few of the common calls to
>> btrfs_should_cancel_balance.  This is because the compiler decided to
>> inline it at these spots.  Keep this from happening by explicitly
>> noinline'ing the function so that error injection will always work.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/relocation.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 2b30e39e922a..ce935139d87b 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -2617,7 +2617,7 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
>>   /*
>>    * Allow error injection to test balance cancellation
>>    */
>> -int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
>> +noinline int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
>>   {
>>   	return atomic_read(&fs_info->balance_cancel_req) ||
>>   		fatal_signal_pending(current);
>>
> 
> I'd really like to not pay the cost of non-inlining in case error injection is disabled. How about you introduce a new noinline_for_err  define that would add noinline in case error injection is enabled or be optimized away when injection is off. Alternatively, though that would be slightly more work, the ALLOW_ERRO_INJECTION macro can be modified so that all functions that want error injection could be declared as :
> 
> ALLOW_ERROR_INJECTION(ftdec, fname, _etype)
> // same body as before
> //
> //
> //
> 
> noinline ftdec
> 
> 
> so functions could be defined as :
> 
> 
> ALLOW_ERROR_INJECTION(int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info), btrfs_should_cancel_balance,  ERRNO)
> 
> Though that seems a bit unwieldy TBH.
> 
> I'm making the case that we shouldn't introduce extra overhead when it's not required.
> 

This is something we could address later on a global scale, but this isn't a hot 
path function.  Alexei had to do something similar for 
__add_to_page_cache_locked, for now lets stick with this and I'll work with the 
bpf guys to figure out a reasonable solution.  Thanks,

Josef
