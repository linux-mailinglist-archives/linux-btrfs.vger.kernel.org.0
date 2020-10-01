Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECC3280979
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 23:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgJAVgA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 17:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgJAVgA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Oct 2020 17:36:00 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B62C0613D0
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 14:36:00 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w16so7486185qkj.7
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Oct 2020 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OBw+jmv0A+M+S6qpk3p3pfrcIq3fxdUKCqJwaR+CdII=;
        b=SuBN8I9uVJNb06sdnAoZdA2Xjc63pDmWjYWgTGgFcjiiUA7Njo/azCbs2fvS3QsuVo
         +cvpXhAwAcG92kdcB2TR7JdPlcsQRzT2AB9yW/7iEuDBd3zV3rx/CcmMH95m7pIFCXn6
         5I3O0Rr4GT9yrdoKqN2ohyZ59I0jrMWccPgap8Rte1H4hVkCPGstVagkN5sT7nDZFku1
         1E0KgtMya9v7qdAkUv/y0NYKSQrFBFa2iAKc8uY0sgUvmaZvZ88ezlKyNXMghUEuRiwT
         uImKYdhoGHew8uzA5af4mxQBW9Su5fOwjiAR8ailvNpxnVazTIK/TuYCbeKp90plHLn4
         rFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OBw+jmv0A+M+S6qpk3p3pfrcIq3fxdUKCqJwaR+CdII=;
        b=YybcFh6eiuYlOEXJQH1DXyHYrwSXHAIc+qKkWnCbTCCtUHkpdkiEf6kt7c/nNwbjF3
         0xabRJHtUCLiMAtYlU7eDxgE+LWZVlUFpgWaARsOSS4oQTiqpL3pjPbPfwU8B4A8jXie
         OJkZepaavbFZO85YwiMk0XB2dUcvDnFwqPDqdYE9JHFZ14ennEtaxqzWkzaGeoUPAPRS
         gvKgCNFVOre+17sfVKDk3Uf3HrFu8y5qI2MOHVLnxqpSSVgs55LauPSOwehEsodyOM++
         WMM3Hni6Kg5RuUcJiA/rxgJjWUry/sJTcsYXBmW6qkqv5rDItE/ZHfEgpzaf5D2KDT8y
         zhkg==
X-Gm-Message-State: AOAM531+melBiCM28ee6oI7mV/tr1/gNFNb5pLvGDwtMgZ2TpoYC4sIM
        ttlIsM1jKoo+q35/beuWZLaV2Q==
X-Google-Smtp-Source: ABdhPJzR4ALapJ62L5KZtR6E510olOE/q8+qEjOOJfYHnNCb3BnCX109yEf/5uVknKRm29g6rQ0P9g==
X-Received: by 2002:a37:c403:: with SMTP id d3mr9456600qki.196.1601588159702;
        Thu, 01 Oct 2020 14:35:59 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u23sm7958095qka.43.2020.10.01.14.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 14:35:59 -0700 (PDT)
Subject: Re: [PATCH 2/9] btrfs: improve preemptive background space flushing
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1601495426.git.josef@toxicpanda.com>
 <fc525d2a6a15a701d688b4f9f62f23caa51023bb.1601495426.git.josef@toxicpanda.com>
 <efe49176-1eba-df6a-ffdf-47031c5acf36@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <01e8925f-5b4b-74aa-f3e6-0faae52a4d3b@toxicpanda.com>
Date:   Thu, 1 Oct 2020 17:35:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <efe49176-1eba-df6a-ffdf-47031c5acf36@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/1/20 9:19 AM, Nikolay Borisov wrote:
> 
> 
> On 30.09.20 г. 23:01 ч., Josef Bacik wrote:
> <snip>
> 
>> When I introduced the ticketed ENOSPC stuff this broke slightly in the
>> fact that we were using tickets to indicate if we were done flushing.
>> No tickets, no more flushing.  However this meant that we essentially
>> never preemptively flushed.  This caused a write performance regression
>> that Nikolay noticed in an unrelated patch that removed the committing
>> of the transaction during btrfs_end_transaction.
> 
> I see, so basically the patch which I biseceted this to was really
> papering over the initial bug since the logic in end_transaction, sort
> of, simulated pre-emptive flushing... how subtle!
> 
> <snip>
> 
>> +	spin_lock(&space_info->lock);
>> +	used = btrfs_space_info_used(space_info, true);
>> +	while (need_do_async_reclaim(fs_info, space_info, used)) {
>> +		enum btrfs_reserve_flush_enum flush;
>> +		u64 delalloc_size = 0;
>> +		u64 to_reclaim, block_rsv_size;
>> +		u64 global_rsv_size = global_rsv->reserved;
>> +
>> +		/*
>> +		 * If we're just full of pinned, commit the transaction.  We
>> +		 * don't call flush_space(COMMIT_TRANS) here because that has
>> +		 * logic to decide whether we need to commit the transaction to
>> +		 * satisfy the ticket to keep us from live locking the box by
>> +		 * committing over and over again.  Here we don't care about
>> +		 * that, we know we are using a lot of space and most of it is
>> +		 * pinned, just commit.
> 
> nit: That comment is a mouthful, I think what you are describing here is
> really this line in may_commit_transaction:
> 
> if (!bytes_needed) return 0;
> 
> Which triggers if we don't have a ticket, if so there simply say :
> 
> "We can't call flush_commit because it will flush iff there is a pending
> ticket".
> 

Yup I'll reword.

> <snip>
> 
>> +		/*
>> +		 * We don't have a precise counter for delalloc, so we'll
>> +		 * approximate it by subtracting out the block rsv's space from
>> +		 * the bytes_may_use.  If that amount is higher than the
>> +		 * individual reserves, then we can assume it's tied up in
>> +		 * delalloc reservations.
>> +		 */
>> +		block_rsv_size = global_rsv_size +
>> +			delayed_block_rsv->reserved +
>> +			delayed_refs_rsv->reserved +
>> +			trans_rsv->reserved;
>> +		if (block_rsv_size < space_info->bytes_may_use)
>> +			delalloc_size = space_info->bytes_may_use -
>> +				block_rsv_size;
> 
> What about  :
> 
> percpu_counter_add_batch(&fs_info->delalloc_bytes, len,
>                        fs_info->delalloc_batch);
> 

Because that's the total data bytes, not how much metadata is reserved for the 
data bytes, which can be very grossly different things.  For example, one 
contiguous MAX_EXTENT_SIZE data extent is only like 1mib of metadata 
reservations, but if we used delalloc_bytes here we'd think the delalloc size 
was dominating the metadata reservations.  Thanks,

Josef
