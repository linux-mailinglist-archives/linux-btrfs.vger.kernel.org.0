Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E6F3897D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 22:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhESUX5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhESUX4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 16:23:56 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC04C06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 13:22:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id v4so11153460qtp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=32mdhE3OaqDhtjymgOz7MwAkrOjhMnRwyTAT46xs2Us=;
        b=ATDyc5vnbcXdtaReq2LX+Jcdt9CkvgzQVqNWRUcVTIL2kW9/UQ0BTYvzjKNK/F2Zo/
         A5LCQrsvstdx3TfUqtHhK6wT4ewym63PQTV5G+db+pifygLJKMphLBpWPnWu95x5d28c
         WCjNhe8n+I70Ds4bYBt2ThPtCGW6OKsZZ+NYhG7AkcfumTplQQ6QYOjgw8lKiA/g0nVp
         uZ93xrjZn+9U/azupj9Fo4Y+u8Ga/k8UQ7C53N7zTASyRa0rzSl8Bo0rX+TxxpFxHi38
         Feoq8U8Usy7ME90TRQeVpLQH+wovW82JC4f4xLj0Wcy+8WXPVS7oFpT4UBtmJBeV9Pwg
         wPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=32mdhE3OaqDhtjymgOz7MwAkrOjhMnRwyTAT46xs2Us=;
        b=khH9zMkFkuVLaukm8VD0b6sqk3/+qN13B7leDqt8uKiTuUotVrs8it5bQq6VRPPOhy
         2+KTNfSO3LIBcUdvDlRcRBXvi5Q+Rm7eNF362j4U2L9MtEnKmTiXhN5DCbITMkZNHar8
         HZce4wNR7JFrW56/gvHU7gQJ7BKe50sOHwJD4aJVtxO6SSTIyspkFHmdOdwt9cbhrgg0
         L6VLe+ceOCeGqRlIn2Atqn5tXhI77SnJlk18mh/H64t3L+g1tBkJcgnpXW+KoRLaRoNH
         PcnjeAwNDXHmxkVbwAWhkULzw32vgjF13C9CTX9+RIl8TyeBRi5kXHdb8hU08XSAuxy1
         rolQ==
X-Gm-Message-State: AOAM532ZNxNW+H/0H5Ny8NbiXqjJtoLc7m/QLSQIxIYylMrBAZM9eeSa
        r0qmYp/Jf/UwWHJKmRriTO8k/Q==
X-Google-Smtp-Source: ABdhPJwkXGZWChu5BUXecCsetvT+Xj97ajaUMtIxfl+kjMiyFF+HI1b6oTg9bg0KG5PBDc61oVdECw==
X-Received: by 2002:a05:622a:486:: with SMTP id p6mr1485708qtx.98.1621455755793;
        Wed, 19 May 2021 13:22:35 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::116c? ([2620:10d:c091:480::1:f365])
        by smtp.gmail.com with ESMTPSA id n21sm567532qka.114.2021.05.19.13.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 13:22:35 -0700 (PDT)
Subject: Re: [PATCH] btrfs: abort the transaction if we fail to replay log
 trees
To:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <9513d31a4d2559253088756f99d162abaf090ebd.1621438132.git.josef@toxicpanda.com>
 <PH0PR04MB7416EC2004FF7AB6B2F4D5339B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210519201551.GX7604@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1a3f7033-90be-4106-380b-8efca3a9e930@toxicpanda.com>
Date:   Wed, 19 May 2021 16:22:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519201551.GX7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/19/21 4:15 PM, David Sterba wrote:
> On Wed, May 19, 2021 at 04:22:20PM +0000, Johannes Thumshirn wrote:
>> On 19/05/2021 17:29, Josef Bacik wrote:
>>> During inspection of the return path for replay I noticed that we don't
>>> actually abort the transaction if we get a failure during replay.  This
>>> isn't a problem necessarily, as we properly return the error and will
>>> fail to mount.  However we still leave this dangling transaction that
>>> could conceivably be committed without thinking there was an error.
>>> Handle this by making sure we abort the transaction on error to
>>> safeguard us from any problems in the future.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>>   fs/btrfs/tree-log.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
>>> index 4dc74949040d..18009095908b 100644
>>> --- a/fs/btrfs/tree-log.c
>>> +++ b/fs/btrfs/tree-log.c
>>> @@ -6352,8 +6352,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
>>>   
>>>   	return 0;
>>>   error:
>>> -	if (wc.trans)
>>> +	if (wc.trans) {
>>> +		btrfs_abort_transaction(wc.trans, ret);
>>>   		btrfs_end_transaction(wc.trans);
>>> +	}
>>>   	btrfs_free_path(path);
>>>   	return ret;
>>>   }
>>>
>>
>> Hmm our Wiki's Development notes page says:
>>
>> Please keep all transaction abort exactly at the place where they happen and do not
>> merge them to one. This pattern should be used everwhere and is important when
>> debugging because we can pinpoint the line in the code from the syslog message and do
>> not have to guess which way it got to the merged call.
>>
>> But there are 6 'goto error;' lines in btrfs_recover_log_trees() and changing all of
>> them might be a bit too much.
> 
> Good point and I want to keep the abort pattern consistent so it should
> be called before the goto error's. Note that this function still uses
> btrfs_handle_fs_error which predates the transaction abort framework and
> should be replaced as needed.
> 

Yeah this is a good point, I assume since we're now going to get the transaction 
abort message for the spots I replace btrfs_handle_fs_error() we don't need to 
replace the message?  Thanks,

Josef
