Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8882CDAD5
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 17:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436725AbgLCQHv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 11:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgLCQHu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 11:07:50 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B29CC061A4F
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 08:07:00 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id k3so1177098qvz.4
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 08:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fxaf6kXPIW3RCd3ey28VaMrkdXIDkCc2M24lh112y+8=;
        b=EnFi91n+8ewXRNBBNF162tTiF3tUGabPLWKYw25Yp+EtIUOa2NFvL5N3AV4Axj+XYB
         dtwxnJtWB/BRRwS80P+zhTZaLrRYAxVsNmeORLBMYGZKguW05l+eCnvIOWrs0PLMvVhK
         OinLlOsyVysBVzRaMkzG2svtLKZfcIi0PT6sztSAMLN9ypcyz1rC8WGvjyw14Xg9rNxN
         WpbY2/pFj317hppRl9hOMZnT7IpEz9Ld93rSO//gIF9M/7iPgd+jL78xJWubEUFOmDem
         UzyPk3uPNb+TcFkht1OdMBVNuERn3h+Uh85oIN1F9mmz/jTrb3qMYs+uiCa6W0Arswcn
         0FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fxaf6kXPIW3RCd3ey28VaMrkdXIDkCc2M24lh112y+8=;
        b=L4Rpb3zehXxEFoGmF5q4tYzTMsne8yuZlOIPBQucQMdPPOFkNjBsmif1ny1+TP8v/E
         8uPAqKvNuCbcfyDjcZzaLht0BvZEjysne39ttsZDMWACz1XpUm7U6GuAN6Ka3F0al3eC
         uKF1S/iHXSAZkIB4kGf7JVdJpBvsE+7PFFzKMHFgq/FJkQilQIkA9/FKlBVff9isb8sS
         tCfZ61pK3cZBffxUki5/dNAltMW4EKEK/J88QEpOD/pRmY0RGIL+AoJ+trYVhgpBw5lM
         RAlWSE4Sw6SzFuylE77dIWF3I9dtZbdRRjSytmV38jehLuh7hkro1DbzRLLICA9Ca0y6
         C/MA==
X-Gm-Message-State: AOAM531vOVxuFOmPDy8pX/2uckEVgOO6fqbkV8ZKPwYqe4Fy1Qk3l523
        YtE4IEydsfcjofBMF7e8Trhdcg==
X-Google-Smtp-Source: ABdhPJwoD6SR2IsNdiRd1flMsSBwCJeEVCO2R70VcLT0XNaVAOuiE7FDC8ugR1b93JK5FR9MrdVKyA==
X-Received: by 2002:a0c:ef49:: with SMTP id t9mr3911620qvs.37.1607011619387;
        Thu, 03 Dec 2020 08:06:59 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k46sm1656405qtb.93.2020.12.03.08.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 08:06:58 -0800 (PST)
Subject: Re: [PATCH v3 21/54] btrfs: handle btrfs_record_root_in_trans failure
 in create_subvol
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <8da8919da73bdaf0e652f03d59391e7710da6e5c.1606938211.git.josef@toxicpanda.com>
 <a8f6422c-c33c-46aa-abd0-c634316935e0@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <79147ec8-8767-9d73-fe4f-29c759a80c0a@toxicpanda.com>
Date:   Thu, 3 Dec 2020 11:06:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <a8f6422c-c33c-46aa-abd0-c634316935e0@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/2/20 9:43 PM, Qu Wenruo wrote:
> 
> 
> On 2020/12/3 上午3:50, Josef Bacik wrote:
>> btrfs_record_root_in_trans will return errors in the future, so handle
>> the error properly in create_subvol.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/ioctl.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 703212ff50a5..ad50e654ee64 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -714,7 +714,11 @@ static noinline int create_subvol(struct inode *dir,
>>   	/* Freeing will be done in btrfs_put_root() of new_root */
>>   	anon_dev = 0;
>>   
>> -	btrfs_record_root_in_trans(trans, new_root);
>> +	ret = btrfs_record_root_in_trans(trans, new_root);
>> +	if (ret) {
> 
> Dont' we need to call btrfs_put_root()? Or since we're going to abort
> transaction anyway, it doesn't matter that much any more?
> 

Nope you're right, and in fact it's a little broken without this patch as well, 
I'll fix the existing brokenness and fix this mistake as well.  Good catch!

Josef
