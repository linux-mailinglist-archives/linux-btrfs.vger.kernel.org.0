Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE5A2423DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 03:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgHLBua (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 21:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgHLBu3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 21:50:29 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372B1C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 18:50:29 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so455411qtp.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 18:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FPCvydUbp+J2bKB51YGuSesSNLqyIdtKUyqyMwYZEys=;
        b=qUq+D5AleSm1QDMCsNkKsddnMsjC2bYL0uKPK9V2Q9oHcZt8zKk/IHz3oUWMAeAOre
         Kf7H8OZzeVuznkQX6UE4XAs1bOLomdkfBKiX/CO6CzN9Zu0XxUT12l8173U9iXndHruv
         VH+mqOVLOQRmceaM0rIKn9ONYHx4U2NLgKTYGHAQsjIWcCM5gxZbrkFNcl+nJxshkzE0
         TNd71NCdQvknJDJmbig+VbTTlMPLjMRj/CHaaKxvVLIENweSp3bIyG1dEab3k/NHGDCi
         2yXbxCknEgWRbiD9P35Oy7Pqc7kqX4QcRXLHAf4Uosl8/uBWC74albAAlQLTXNCQ6Udn
         pUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FPCvydUbp+J2bKB51YGuSesSNLqyIdtKUyqyMwYZEys=;
        b=PnAFIKufuGfGTpCB+q2wCHKhf9DQl+oNCkzPy3lImZr6hqf+Xgbhom+pfucUeE6wyj
         4Wt+6UDhXYcrt6pdC3i4BU/ZDu1VBFF6eMXAxinLXQ6t5pjVSBeCJVklkJBxrDZHHi2b
         60cci+1S+bF1BNvsCwW/dD2b4j3CxI+WloAsyFDLresWP3DKr40aMbVzEI7STRBx2FgE
         Hzk7KrdivhOOTTw4+bQPIbgh9SXHFTxDc/efnDf1BBkm6wW29sPHHUUAiZp0uZiqiqIp
         gnLlxhww6XxgGk3tH/5WYHzQiJNAysdPgRQk1HXRJCS/Aa9dzAbe3eMt8dBqWUgo97Jo
         IvgQ==
X-Gm-Message-State: AOAM531wIlU3dfGCFyP7d3zBoBO0gSmZcbKGCQm7SDorhJlu3uPa6H4Z
        iDrforif649ya5GyVUh6IQGfeQsFDXsz9g==
X-Google-Smtp-Source: ABdhPJyMIJImBDpI0P3iSaCJF2c42vfMc7jqo+JlgWsSGU/BxbF3K1I1sTIg4jRbUzl7PNCqOhhJSw==
X-Received: by 2002:ac8:568a:: with SMTP id h10mr4202740qta.239.1597197028019;
        Tue, 11 Aug 2020 18:50:28 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g136sm656981qke.82.2020.08.11.18.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 18:50:27 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200809120919.85271-1-wqu@suse.com>
 <20200809120919.85271-4-wqu@suse.com>
 <8d21ba85-52a5-5419-dc16-ceece8b0c3a8@toxicpanda.com>
 <dbe1176e-db46-7ff7-1231-ee69d7c3c5d1@gmx.com>
 <ee1203ab-444d-cc9d-0e00-2102bd02ecd2@toxicpanda.com>
 <fb4aea50-0e81-6444-ae9f-3e6c2df88c67@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <727019b8-254f-d2eb-f886-3f46e7b522c7@toxicpanda.com>
Date:   Tue, 11 Aug 2020 21:50:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fb4aea50-0e81-6444-ae9f-3e6c2df88c67@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/11/20 8:29 PM, Qu Wenruo wrote:
> 
> 
> On 2020/8/12 上午8:23, Josef Bacik wrote:
>> On 8/11/20 7:04 PM, Qu Wenruo wrote:
>>>
>>>
> [...]
>>>> Which I assume is the problem?  The generation is 19, is that >
>>>> last_trans_committed?  Seems like this check just needs to be moved
>>>> lower, right?  Thanks,
>>>
>>> Nope, that generation 19 is valid. That fs has a higher generation, so
>>> that's completely valid.
>>>
>>> The generation 19 is there because there is another csum leaf whose
>>> generation is 19.
>>>
>>
>> Then this patch does nothing, because we already have this check lower,
>> so how exactly did it make the panic go away?  Thanks,
>>
>> Josef
> 
> Sorry, I don't get your point.
> 
> The generation 19 isn't larger than last_trans_committed, so that check
> has nothing to do with this case.
> 
> And then it goes to the header_nritems() check, which is 0, and with
> first_key present, which is invalid and we error out, rejecting the
> corrupted leaf.
> 
> What's the problem then?


         /* We have @first_key, so this @eb must have at least one item */
         if (btrfs_header_nritems(eb) == 0) {
                 btrfs_err(fs_info,
                 "invalid tree nritems, bytenr=%llu nritems=0 expect >0",
                           eb->start);
                 WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
                 return -EUCLEAN;
         }

         /*
          * For live tree block (new tree blocks in current transaction),
          * we need proper lock context to avoid race, which is 
impossible here.
          * So we only checks tree blocks which is read from disk, whose
          * generation <= fs_info->last_trans_committed.
          */
         if (btrfs_header_generation(eb) > fs_info->last_trans_committed)
                 return 0;

         /* We have @first_key, so this @eb must have at least one item */
         if (btrfs_header_nritems(eb) == 0) {
                 btrfs_err(fs_info,
                 "invalid tree nritems, bytenr=%llu nritems=0 expect >0",
                           eb->start);
                 WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
                 return -EUCLEAN;
         }


This is the code, you have the exact same check above the header 
generation thing, and that's not the problem, so I don't understand why 
you have added this check.

Josef
