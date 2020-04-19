Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1091AFE1C
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Apr 2020 22:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgDSUce (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Apr 2020 16:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSUce (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Apr 2020 16:32:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0570C061A0F
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Apr 2020 13:32:33 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e26so8682100wmk.5
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Apr 2020 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=qSqsSs0rb0H1r9BkPiuZ1Ep6lM6NUuOWVUYglRsbmfk=;
        b=JuNDh96ICq4c4dBOlrwoLODjg93nj3QiNsfn7Jzpdj66pdrd/2otiyiuz9V+6piAnd
         sSeqiPrakUpmWArGDgGIn1Wt5MmdHsIIEaKBhMZ9smAdc1xR/doVoCu7n1K/W1dsbyHR
         sJcS0NnqAOgH5FpAhLXmqYK4LWoV9tvmHv0W0Da9xGfaom/F5bUZL3OeUqN7Tp2ryi8U
         RvqigA/tq8cShmAHKhF20A+CdxZnLahgPS6oVyD/K3ZXYYngA4f/twVqh0U/lTLYkhP+
         +hX/unY/KcCVKMK2bBh5jpqSeoD0piuaaJraQ21ulLL2NVgESq17UKJ8731NcAjopSYa
         WQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qSqsSs0rb0H1r9BkPiuZ1Ep6lM6NUuOWVUYglRsbmfk=;
        b=lm+KUgTFCIAjXVu+wHW3cvgezifAi8bXxGjxDzDAgO6aNCWLpNqmImgpISXQvJOCZT
         XXihaFp3qZIrirT2Z3FSxR5HNFsRD2tOFF3VwXjVmmyW+MMSbIxBQapBb2cgfS5fbGWX
         XXKtB2VPbUBqkkd9BKCIpKO2om57uym8thF6uoMHQ5lcrblm0yT3fvdmRKiHPWGI8iZY
         aEdGEgsCimY0e+Z8uYHpJJCmCfuUjMhCcWYZ1aUSAaXy4SmNo/pMzvPnqUd72jJ5kaJk
         IKDDmD6Z2WdXzY1XlfYjRljDnPBnB9+Jeo32xFO79tuNz7pi/zKM6bX85l6jEsHbYjxt
         vLQg==
X-Gm-Message-State: AGi0PuaouD1h/ok6Qx/gTmScIAYkrSv147ursQx9GMAPjafh5f1udqyT
        Hdd1MEwgQ1991Q1Z9UG07Ys2MEucx819zfX1
X-Google-Smtp-Source: APiQypJ6HblZpXPqGo2v53k1bFp3Fwcx5LyA3cT02QkPqILaqop4QI5ZO3jnNwYbk7vePk9pfnamlg==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr13303196wmg.147.1587328352353;
        Sun, 19 Apr 2020 13:32:32 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48da:6b00:34d4:fc5b:d862:dbd2? ([2001:16b8:48da:6b00:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id j13sm42797393wro.51.2020.04.19.13.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 13:32:26 -0700 (PDT)
Subject: Re: [PATCH 2/5] btrfs: call __clear_page_buffers to simplify code
To:     dsterba@suse.cz, linux-fsdevel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
 <20200418225123.31850-3-guoqing.jiang@cloud.ionos.com>
 <20200419194656.GA18421@suse.cz>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <57717269-b51d-179c-f4ea-7526f9b8b678@cloud.ionos.com>
Date:   Sun, 19 Apr 2020 22:32:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200419194656.GA18421@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19.04.20 21:46, David Sterba wrote:
> On Sun, Apr 19, 2020 at 12:51:20AM +0200, Guoqing Jiang wrote:
>> Some places can be replaced with __clear_page_buffers after the function
>> is exported.
>>
>> Cc: Chris Mason <clm@fb.com>
>> Cc: Josef Bacik <josef@toxicpanda.com>
>> Cc: David Sterba <dsterba@suse.com>
>> Cc: linux-btrfs@vger.kernel.org
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>>   fs/btrfs/disk-io.c   |  5 ++---
>>   fs/btrfs/extent_io.c |  6 ++----
>>   fs/btrfs/inode.c     | 14 ++++----------
>>   3 files changed, 8 insertions(+), 17 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index a6cb5cbbdb9f..0f1e5690e8a4 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/error-injection.h>
>>   #include <linux/crc32c.h>
>>   #include <linux/sched/mm.h>
>> +#include <linux/buffer_head.h>
> I'm not really thrilled to see buffer_head.h being added back, we're on
> the track to remove buffer_head usage completely and adding it just for
> one helper does not seem great to me.

Thanks for your reply, will drop this one.

Thanks,
Guoqing
