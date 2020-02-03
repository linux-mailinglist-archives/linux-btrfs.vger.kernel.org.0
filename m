Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26EF2150B1D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 17:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBCQYl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 11:24:41 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46018 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgBCQYk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 11:24:40 -0500
Received: by mail-qt1-f193.google.com with SMTP id d9so11835417qte.12
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 08:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=D7Hfq7h+TBo9ktsiIFQd41E6RyZRUL1j84nHkm1NwLE=;
        b=eDMD8uIUwaqU+QeiyiilzWM08XSSYpND3kiSQEQI+8x9ofrX0GrISuM2UjZx8BkTUr
         eGXn4TFx9Pz86mYrpox5tImlqOPoC8el4HCKCRDcpkBr+l94LRlwTvNDNp0UUFSdhanS
         onmzzdYlUiBAEg/gktzWL3NY0wcrbvwBWMMxkVHpJaW0kpVr6kYk8SHx8aH+CKyDfZtr
         itQKpYbXiMQzSYqIlatICHXdIVsl+9vivb5NkwET0zA/jO1m4GSYysxiDCKoljGzJslH
         Ovnubm1rgwkcEy60EdCqXVOZHbTvrQkMJ418+495rfZA+2jyQT2A+xPoXjv6yWZY8o2v
         agjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D7Hfq7h+TBo9ktsiIFQd41E6RyZRUL1j84nHkm1NwLE=;
        b=Ys0IaRDI1RjuV1X6/Tr2bNjxaYN6JQUgIRl775/HkNwHJIGz/zDRi9cmkGZp5olwBq
         iCEmJrZvecn9Yfx7olcrzfgVHfjcfS+2xS0L5A5ZK5dtTHAbGrEdibVxNl/5FQ5HQ7m/
         S4ONJjfBDh4XsI18PIGAhg21HRNDK21Z+W8UjpT7tX6ctjb8B1cCV85DBaavnTbSi6un
         h3SxnpkATYiMq7uRegvWnqN2wXPP4tMugO4aO4fpUhtFSPn0d9rHX5tz/pAcXmVOt8zV
         fhrc1F5ixbNAKkcD+/crP3OO8jQL/85kAGJanBNFYGKIUh+4wVMk3uVdJ9GQMDXSp/og
         Iotw==
X-Gm-Message-State: APjAAAW0YND17nPEfD09vtQP9WgbiKeC0mudqMQaBI8NuY0KA8aQt9YW
        Gy5GIeESqrQA2ExcWiqmOkiFX2WOaoSTVw==
X-Google-Smtp-Source: APXvYqyI5GFh6FCCscKZQkJqluQCdaKI+zC7WBdby2G2qSnO16e7AUZl+ja1zq4Ysd99aEslX4nyiA==
X-Received: by 2002:ac8:1635:: with SMTP id p50mr25028804qtj.13.1580747078827;
        Mon, 03 Feb 2020 08:24:38 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o10sm9906914qtp.38.2020.02.03.08.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 08:24:38 -0800 (PST)
Subject: Re: [PATCH 22/23] btrfs: flush delayed refs when trying to reserve
 data space
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200131223613.490779-1-josef@toxicpanda.com>
 <20200131223613.490779-23-josef@toxicpanda.com>
 <582cc578-6c48-67ed-bf74-856d1d6c2567@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <29028d50-2050-fd87-dc4e-a87a7fd9e56e@toxicpanda.com>
Date:   Mon, 3 Feb 2020 11:24:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <582cc578-6c48-67ed-bf74-856d1d6c2567@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/3/20 11:16 AM, Nikolay Borisov wrote:
> 
> 
> On 1.02.20 г. 0:36 ч., Josef Bacik wrote:
>> We can end up with free'd extents in the delayed refs, and thus
>> may_commit_transaction() may not think we have enough pinned space to
>> commit the transaction and we'll ENOSPC early.  Handle this by running
>> the delayed refs in order to make sure pinned is uptodate before we try
>> to commit the transaction.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Actually wouldn't it be better if the stages are structured:
> 
> FLUSH_DELALLOC which potentially creates a bunch of delayed refs,
> FLUSH_DELAYED_REFS which in turn could free some reservations. Then IPUT
> to process anything from delayed refs running and finally committing
> transaction to reclaim pinned space?
> 

It's more about doing the least amount of work for the largest chance of success.

Flushing delalloc will reclaim space in one of two ways, first the compression 
case where we allocate less disk space than we had reserved, second the free'ing 
of extents we drop when overwriting old space.  In order to get that free'd 
space we'd have to wait on delayed refs to make sure pinned was uptodate before 
committing the transaction.

Running delayed iputs only reclaims space in the form of delayed refs flushing 
and then committing the transaction to free that pinned area.  So at this point 
we have to run delayed refs.  Running delayed refs isn't free, so I'd rather 
just coalesce these two operations together and then run delayed refs so we're 
completely sure we need to commit the transaction if we get to that point.  Thanks,

Josef
