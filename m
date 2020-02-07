Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE4BF155BE3
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 17:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBGQfZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 11:35:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38325 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgBGQfZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 11:35:25 -0500
Received: by mail-qt1-f194.google.com with SMTP id c24so2297454qtp.5
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2020 08:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zFOZSNHpNpnFRKvlfwNfkPa6a+lqoE0EPRjJKkfQn2Y=;
        b=WZ7iN51xFF48so5HyJ2gbeyE7uJHlk7Qm6jD17P8eh0w+Y4EEr9O/hdPCxxIeoD3B0
         Io0Ot0Y5FU5s3rCnB3ghUoyiQP0/mxd74WQGCI4yHhaMsx6eI7HvDAfXN/jVig4iHm52
         qdE+s2CK5CYCR+PvG2gV2C9N1tbn3MlPZ1VQD4avQ3UhMUPcpBtWhMa6IxxnB2a+5q7m
         7phfSXmfHFH4932AORpF9e/NIxvuKSgFeA1JttsNa/m+DEVyWrgAbZlZjRV4yiY0Nr/A
         rV/cnZCGA7WERtZwIWI/u9v2EZ90E1n3+wJR9zMeqo3MxQpAgHVVezGrRyjkQ4SgOLnr
         GYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zFOZSNHpNpnFRKvlfwNfkPa6a+lqoE0EPRjJKkfQn2Y=;
        b=SiwGGFdqlue6Wsn0RSdLIfI0eZRXgMJAbsjQeCIFYVOT7qJg3Bfg3XvpwkXbQ3GUeM
         yJcYq4TbIvbqs7/7a+EZYgN5VyyYkB3Mf12hPszmPfISW6l1XTuNW8aNP3MP/ZmxxSrA
         fbTWC7YDww06U/4uDyX8Bu31M2IHiOHjFfZ6GK+GrdmwbfPPwRKD+h5HmgEi6h3XGnvc
         x8EPKXd6shujw3TPRsT4GXuZ/keZ2lbMpcQNWPgomiwC6GgiB2TIvZq1U4sPdUKVDiY/
         kk4GpvHcJDXWqlJ3SZWZbb1YBLJ8KC+QBHPzXXdN6z3tSZV3eCT7xJaaG9tOJn+Sx/nD
         M6SQ==
X-Gm-Message-State: APjAAAWYN1LE8aAFGj5QRU7/tKudOtBKv89FD3MjXX7TREDeAni6Nkp/
        f32uQQ/B/QA3RC4eg/qTpoC+rheytSY=
X-Google-Smtp-Source: APXvYqwkePqM1lFS93Dh55EDkr+YN2uxvNtIiz0xmxnl2vciM83MATvyJsiAGsLojSAQMLDAIIxonA==
X-Received: by 2002:ac8:4a10:: with SMTP id x16mr7923289qtq.371.1581093322630;
        Fri, 07 Feb 2020 08:35:22 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 4sm1561304qki.51.2020.02.07.08.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 08:35:21 -0800 (PST)
Subject: Re: [PATCH 2/4] btrfs: backref, not adding refs from shared block
 when resolving normal backref
To:     ethanwu <ethanwu@synology.com>, linux-btrfs@vger.kernel.org
References: <20200207093818.23710-1-ethanwu@synology.com>
 <20200207093818.23710-3-ethanwu@synology.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <62c53217-ea16-c439-1df3-10461891d3d7@toxicpanda.com>
Date:   Fri, 7 Feb 2020 11:35:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207093818.23710-3-ethanwu@synology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/7/20 4:38 AM, ethanwu wrote:
> All references from the block of SHARED_DATA_REF belong to that
> shared block backref.
> 
> For example,
> item 11 key (40831553536 EXTENT_ITEM 4194304) itemoff 15460 itemsize 95
>      extent refs 24 gen 7302 flags DATA
>      extent data backref root 257 objectid 260 offset 65536 count 5
>      extent data backref root 258 objectid 265 offset 0 count 9
>      shared data backref parent 394985472 count 10
> 
> block 394985472 might be leaf from root 257, and the item obejctid and
> (file_pos - file_extent_item::offset) in that leaf just happends to be
> 260 and 65536 which is equal to the first extent data backref entry.
> 
> Before this patch, when we resolving backref:
> root 257 objectid 260 offset 65536, we will add those refs in block
> 394985472 and wrongly treat those as the refs we want.
> 
> Fix this by checking if the leaf we are processing is shared data backref,
> if so, just skip this leaf.
> 
> shared data refs added into preftrees.direct have all entry value = 0
> (root_id = 0, key = NULL, level = 0) except parent entry.
> Other refs from indirect tree will have key value and root id != 0, and
> these value won't be changed when their parent is resolved and added to
> preftrees.direct. Therefore, we could reuse the preftrees.direct
> and search ref with all values = 0 except parent is set to avoid
> getting those resolved refs block.
> 
> Signed-off-by: ethanwu <ethanwu@synology.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
