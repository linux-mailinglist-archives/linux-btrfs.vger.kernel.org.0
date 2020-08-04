Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FE323C210
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Aug 2020 01:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgHDXIi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Aug 2020 19:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgHDXIh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Aug 2020 19:08:37 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BADC06174A
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Aug 2020 16:08:37 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 77so7771287qkm.5
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Aug 2020 16:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iskp7L70C4I5t8yVE02myoDossrSMJlnG2RIi22QaNA=;
        b=oHwa3CCwq1i44Pkv9p5L28lFFHTXnZK1LlubMQr97hyAlSnNjc2CtSvfHHxOVt22Sp
         HH+N78IxALnW1/H9AFXCHIPSSN0D9tpdX95GF+GA2c2z6omsYvvSiYeo1UFi2/sIU8eu
         JarISR04D6uT2q0et05wwfquqpdAWKw5f2OCP56OA30ET3lU1FPZ3ZBCv2uciquF386Z
         mmuWm/uXYOnhfjTv3l4sDetO6J/EpfKOhspPF9mT9gEX1W6Eex44mjd493dTu+gRkd9Q
         ORFDdm6rB4layQ41x/gCWjeers1l1ccQ47FNCt52FIA2j8uyfEsqPJU+AzI6ZJ0+8se8
         0idA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iskp7L70C4I5t8yVE02myoDossrSMJlnG2RIi22QaNA=;
        b=NiT5/Q18d6eTiiQlnfAIxSO9GQ9wpQbk0iI6UUZL71b5tpJkue4TsRWFJ+RT6vB/1Y
         jyDHUtRvvcXFB9YBDjAMSv5NBRZRrVW3MIU9h+fXNm9xDAhImQG4kQ43ReNYkEBorvof
         c80UuFTWVcDeM2/a7otlkeZJL8Rp0fOl+TB0EwAaKAmiXb2G5bLFPUpCTMHx7STy48Gq
         Qc3/PZhk5wyA/yP3zoZmI3a6iax8uYz8RBHBY9HDrkUI7kroNVihkp0X1+AjWF/LFBDs
         /7lEYs+6VfEjAayxtJf/mHNumvVSp0APX+o8icNuDRw0xRXOHZFDaO/1PCdt6DnFtBzT
         xoKg==
X-Gm-Message-State: AOAM532uylTH1LPwoAKdLue76/GjvfMn+oZ+rTgU4puhq2Qc6V5vrpLH
        kzm4FNAG4hgsV5rCPqKORzyZFowj50YFCA==
X-Google-Smtp-Source: ABdhPJzx3KO/xS3kzMf6nn82l3VYEiXFFUBRTNcqBDXD15+EFgaiyzqE8VxW09rU7728ZKVe731gKg==
X-Received: by 2002:a37:71c2:: with SMTP id m185mr586294qkc.496.1596582516527;
        Tue, 04 Aug 2020 16:08:36 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k2sm169013qkf.127.2020.08.04.16.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 16:08:35 -0700 (PDT)
Subject: Re: [PATCH RFC] btrfs: change commit txn to end txn in
 subvol_setflags ioctl
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Boris Burkov <boris@bur.io>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200804175516.2511704-1-boris@bur.io>
 <86c25213-e961-790e-dc27-8c2a9aa118c1@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5c0b0cd7-b04d-7715-8d0e-6466f7e802a5@toxicpanda.com>
Date:   Tue, 4 Aug 2020 19:08:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <86c25213-e961-790e-dc27-8c2a9aa118c1@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/4/20 6:48 PM, Qu Wenruo wrote:
> 
> 
> On 2020/8/5 上午1:55, Boris Burkov wrote:
>> Currently, btrfs_ioctl_subvol_setflags forces a btrfs_commit_transaction
>> while holding subvol_sem. As a result, we have seen workloads where
>> calling `btrfs property set -ts <subvol> ro false` hangs waiting for a
>> legitimately slow commit. This gets even worse if the workload tries to
>> set flags on multiple subvolumes and the ioctls pile up on subvol_sem.
>>
>> Change the commit to a btrfs_end_transaction so that the ioctl can
>> return in a timely fashion and piggy back on a later commit.
>>
>> Signed-off-by: Boris Burkov <boris@bur.io>
>> ---
>>   fs/btrfs/ioctl.c       | 2 +-
>>   fs/btrfs/transaction.c | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index bd3511c5ca81..3ae484768ce7 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1985,7 +1985,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
>>   		goto out_reset;
>>   	}
>>   
>> -	ret = btrfs_commit_transaction(trans);
>> +	ret = btrfs_end_transaction(trans);
> 
> This means the setflag is not committed to disk, and if a powerloss
> happens before a transaction commit, then the setflag operation just get
> lost.
> 
> This means, previously if this ioctl returns, users can expect that the
> flag is always set no matter what, but now there is no guarantee.
> 
> Personally I'm not sure if we really want that operation to be committed
> to disk.
> Maybe that transaction commit can be initialized in user space, so for
> multiple setflags, we only commit once, thus saves a lot of time.
> 

I'm of the opinion that we shouldn't be committing the transaction for stuff 
like this, unless there's a really good reason to.  Especially given we're 
holding the subvol lock here, we should just do end_transaction.  Thanks,

Josef

