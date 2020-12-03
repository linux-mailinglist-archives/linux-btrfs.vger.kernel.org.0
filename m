Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0928F2CDB30
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 17:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgLCQ10 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 11:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgLCQ10 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 11:27:26 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFC8C061A4E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 08:26:44 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id q7so1198083qvt.12
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 08:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Vl5ikh+r0C25IpvG8L4g72KuJvV3+5K7iZkpjtTVu6Q=;
        b=AFNimxxFqIYWOZi5wW6LA+1FFR/2Caw912ul2jj8OFur7EgwlHtrOCAY3ZP8+YSp2V
         oRMR+FDOALadYrCbjPUjY/HnqCHP1IuEjoffAB0Cfczc3KXxyyeqaSnvGZT2fbfMMUOc
         wTRNqR6Q2CheWJUQaGrlpGcZQ/x6feUHqfimllwaNi2P8oJn92dgp76WyWv0d/OBJlta
         DP9taulsy0a4cslWV66HIQkfy5FBg2o1TpI6HIKZNPCTYwh8izVS9Q7jvSdguGIj6nMr
         rMjxf7cq0TpmVf8P5nYSTnPH59tmOG/g4a26oDAb6ec3UsPKhHIz2k4XClddUXZGHfXN
         8SFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vl5ikh+r0C25IpvG8L4g72KuJvV3+5K7iZkpjtTVu6Q=;
        b=bAWPP3FkRzURorAnK3wJZTcsqWstglHqFoxyUPZdvi66ZX2/qzyhYI98kZRJBxcX58
         bI4Aq9bF2ZEzsAef3q5+Oye+vyPkqHN8ebkk7fEieH/ND6vWFZ8X5T9AvVRjKqw+bgsD
         XzaSM/riqLsMkHl8XnD2EB+fJoNe/Qt78IdSkhw1xTLMMOkPVVudzKSo+Xkx9US0j3+l
         rmnLKQ1LCKw9khOQ5eRz/P6+FSSBpmkizqksH9LCyqkK5yv8lcScl/M+G8etrBqrPON8
         mW6bq7AOh/VGh1+xBiwrx2D4JxYV34I1lTWgKam5SygYOTKbBWRuKd1S5XxycpdvfiWt
         PIZw==
X-Gm-Message-State: AOAM531qQm0/EzsaFVE+828QnoTG3vv44KlYlfe+/eO6i13GaYfpKQ2v
        WTgtC1iFOAAlVYKKX5QXtxAdhw==
X-Google-Smtp-Source: ABdhPJxJbXCCVJDbLYttuo0mJPh+NwKIPpd/9Ap45AF0laHwa9HmEKk2iaRRsE/p7aQ1Y2tEJzpWoA==
X-Received: by 2002:a0c:ffd1:: with SMTP id h17mr3999544qvv.20.1607012804111;
        Thu, 03 Dec 2020 08:26:44 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s134sm1945680qke.99.2020.12.03.08.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 08:26:43 -0800 (PST)
Subject: Re: [PATCH v3 41/54] btrfs: handle extent reference errors in
 do_relocation
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <fe755664856dd75359962c132d7398b0e69a3f22.1606938211.git.josef@toxicpanda.com>
 <a5a5d6d0-0cb2-18c6-3eac-976176811d9e@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <96954177-fa84-356c-ea43-718899d124ea@toxicpanda.com>
Date:   Thu, 3 Dec 2020 11:26:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <a5a5d6d0-0cb2-18c6-3eac-976176811d9e@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/3/20 12:15 AM, Qu Wenruo wrote:
> 
> 
> On 2020/12/3 上午3:50, Josef Bacik wrote:
>> We can already deal with errors appropriately from do_relocation, simply
>> handle any errors that come from changing the refs at this point
>> cleanly.  We have to abort the transaction if we fail here as we've
>> modified metadata at this point.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/relocation.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index ef33b89e352e..3159f6517588 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -2433,10 +2433,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
>>   			btrfs_init_tree_ref(&ref, node->level,
>>   					    btrfs_header_owner(upper->eb));
>>   			ret = btrfs_inc_extent_ref(trans, &ref);
>> -			BUG_ON(ret);
>> -
>> -			ret = btrfs_drop_subtree(trans, root, eb, upper->eb);
>> -			BUG_ON(ret);
>> +			if (ret) {
>> +				btrfs_abort_transaction(trans, ret);
>> +				goto next;
>> +			}
>> +			btrfs_drop_subtree(trans, root, eb, upper->eb);
> 
> Wait for second. Now we don't handle the error for btrfs_drop_subtree()
> completely?
> 

Lol I saw this yesterday and cleaned it up already, idk how the hell that 
happened, thanks,

Josef
