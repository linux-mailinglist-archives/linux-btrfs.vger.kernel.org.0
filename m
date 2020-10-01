Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8054828097A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 23:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgJAVgu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 17:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgJAVgu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Oct 2020 17:36:50 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61B0C0613D0
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 14:36:48 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ef16so142442qvb.8
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Oct 2020 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MMpmyKKUGG4tUzhLQGgl/U+iHv4dXGC5McXq1yZycoo=;
        b=qRen597X0gapAzlw6DXuejSjvM+Wj1pRj5c4bn971jHHOV873EBCwmqt3xLmbE+jAl
         8MpcBuFKq82hph5WTeeODgyMJbF59i18S/sF5JpR/A8gpeM6AG15d5kyV4hOD+NzmjE5
         RfMl6SjpKtqdoIvD2VJuWpuxCpJxp7pCU5KrB/qjdCX211Cw6RC6m5wqQMlcYidIS7H8
         uuwHm0UWKGZoci5kTwTIP5Bkzm5L9veodM+IqFvg5y75qf9rzgMA57GylIlumMX7fp/y
         0n690MwXO8wkFjAry4LFYg1hTEAFvxIHtBql0+EWgTExDOEkDjbJ2sL8Nlri7JsUqkIH
         DPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MMpmyKKUGG4tUzhLQGgl/U+iHv4dXGC5McXq1yZycoo=;
        b=RGlNoegkxRxz/zQ9e10RlfRGblEsXROgL1668dZi6xXOctXmXgGwnDWy/UAdwUFfso
         wLnBY7QfZXi1ZLf4kQO7dDikIHD1sX9MA9ShLKaz1fXxVJdYMY9C6SWiGy4f/6CCC4Ml
         baDMMUX1d10u/lP8FSxWzAXvAzUPJr5mk5M7zROyJTA4AwcOHi6C9hKzt6MqynaWd2Gn
         T0tfoavU1EyhZJWbnK0U8WGK96EU/qV0CDB8QuocbBVmBmD6jMCuT2IOSu/suh9pQVFj
         fmNiL3UaRGbHcQzNnlzBAjSuqjnuSY8DaWCWWNfmu6W4g7mTpkFkaQrNhFfdic96EDYq
         rbwQ==
X-Gm-Message-State: AOAM5310u7SDWd7j+41ynGVGvvZPgfZ6uldYu5NC33w55QNrb6OqrUBw
        +QPnzjOK80sG70DmidTKdxhhS1htN94K8XIy
X-Google-Smtp-Source: ABdhPJwPuGzycb+GBrSM+z2Jw4gTcDZbzp2GqXvhbXzifMEtiuBUkuQEpEZqmRpPlPYpb1qhJpbAZg==
X-Received: by 2002:a0c:a95e:: with SMTP id z30mr9730880qva.58.1601588207874;
        Thu, 01 Oct 2020 14:36:47 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q142sm7262419qke.48.2020.10.01.14.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 14:36:47 -0700 (PDT)
Subject: Re: [PATCH 4/9] btrfs: check reclaim_size in need_preemptive_reclaim
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1601495426.git.josef@toxicpanda.com>
 <855a8376fa0d8e63e066ac323a985fe7bc1e562f.1601495426.git.josef@toxicpanda.com>
 <3a3a2fc0-53fe-a080-e166-85b129db2ff1@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0194dbc5-4f7f-1a71-2acf-cc4c4db160b0@toxicpanda.com>
Date:   Thu, 1 Oct 2020 17:36:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <3a3a2fc0-53fe-a080-e166-85b129db2ff1@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/1/20 9:23 AM, Nikolay Borisov wrote:
> 
> 
> On 30.09.20 г. 23:01 ч., Josef Bacik wrote:
>> If we're flushing space for tickets then we have
>> space_info->reclaim_size set and we do not need to do background
>> reclaim.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> I'm fine with this but check my remak below.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>   fs/btrfs/space-info.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 98207ea57a3d..518749093bc5 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -805,6 +805,13 @@ static inline int need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
>>   	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
>>   		return 0;
>>   
>> +	/*
>> +	 * We have tickets queued, bail so we don't compete with the async
>> +	 * flushers.
>> +	 */
>> +	if (space_info->reclaim_size)
>> +		return 0;
>> +
> 
> nit: So where do we draw the line if this check should be in this
> function or in __reserve_bytes so that we eliminate the case where a
> preemptive reclaim is scheduled only to return instantly because of
> tickets. Though the 'if' in __reserve_bytes is getting slitghly out of
> hand :)
> 

Keep in mind this is also used by the background flushing thread to tell when 
it's time to stop flushing, which is why the check is in here.  Thanks,

Josef
