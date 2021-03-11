Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9042B337C02
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 19:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCKSKb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 13:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhCKSKF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 13:10:05 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B6CC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 10:10:05 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id l15so2975265qvl.4
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 10:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+dlD9LVCQAekOaVIqriBxcF1ZQxQpG7TEikQltrDoTw=;
        b=vGpHehLiPTaBkloDer4u06VRxh1WXD7ugAaCRiN7PRmjpv9SoTYPTAdcI/snes8Cq6
         eq42N2C6oEPN3UY8stLJeQRKEwauIlKnA++aJHAPyPwAZqMeCASFXP5/ONmqrpdk8GT9
         14k6BE8sHKVIvPGdutEzkhxqPDnzAWVkecZtn5QD/6B9G6ZpF6KN11t92Avtqb1jbbaE
         DoZaVRmHhepfQb9TADibWiW53ofcNyE0EXoGPoM1Dh6C39bUzIrUuhNPCV8FtPinc42M
         zpyTnzXo5ZeX34a4/inW2cRDc9uqKjYajBfOAvEKpEPbUjeWyibdH+B1EKa9963epjDn
         pTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+dlD9LVCQAekOaVIqriBxcF1ZQxQpG7TEikQltrDoTw=;
        b=aeVvHiBqmpJ0B9ArzZKSgzUfV0Ae+8avdq/LBiJ6GmGVQfhR9jlNm4FvZAj9GhGWOF
         Z/QSZBDtdV8iSGDl83LBBNBBn2xtMQviEQtmKMxzC25NNUTcoQPnFp6donJFOFj17rXc
         s4iFbBs859KwoAwaI/Kb3pV1IpEE+GwltxkayelrFXHh9Zuvd9Rf1ozyyzWUJzmzfef0
         NXn1toBAl5CtRMaUkXNxnALJOieHU+LZaCWKkMYVeFY4prx/jKvrzaSK7fKB0geEIQhT
         zhFqq9N+WFJh7t8nMh5y0Ofy6IdCG4Ld4C6spABLt2G1DrbGXrBeWBVBgo9uxKw+Q1/X
         WxgA==
X-Gm-Message-State: AOAM530ywPnHAGLIJWmh0IzY8zHh6C2SsgXfQYC7jsvp9p4KpuDprl47
        fEcajXZN9sl2os5l2ehBEL8OAQ==
X-Google-Smtp-Source: ABdhPJy1trEdsocxglTvfqoYywaYt/84Ar7meBvpzKY6JvzGRjeUIsNIvCrTCqRmxZAN8MPEWECnAg==
X-Received: by 2002:a05:6214:1c47:: with SMTP id if7mr8790619qvb.50.1615486204623;
        Thu, 11 Mar 2021 10:10:04 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b21sm2477134qkl.14.2021.03.11.10.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 10:10:04 -0800 (PST)
Subject: Re: [PATCH v7 03/38] btrfs: handle errors from select_reloc_root()
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1608135849.git.josef@toxicpanda.com>
 <aa44497f5c2b8c96ca1229daa4dfdb6503971f31.1608135849.git.josef@toxicpanda.com>
 <20210226183059.GP7604@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e0865e88-903c-e9b5-7ebb-daeca69fcac9@toxicpanda.com>
Date:   Thu, 11 Mar 2021 13:10:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210226183059.GP7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/26/21 1:30 PM, David Sterba wrote:
> On Wed, Dec 16, 2020 at 11:26:19AM -0500, Josef Bacik wrote:
>> Currently select_reloc_root() doesn't return an error, but followup
>> patches will make it possible for it to return an error.  We do have
>> proper error recovery in do_relocation however, so handle the
>> possibility of select_reloc_root() having an error properly instead of
>> BUG_ON(!root).  I've also adjusted select_reloc_root() to return
>> ERR_PTR(-ENOENT) if we don't find a root, instead of NULL, to make the
>> error case easier to deal with.  I've replaced the BUG_ON(!root) with an
>> ASSERT(0) for this case as it indicates we messed up the backref walking
>> code, but it could also indicate corruption.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/relocation.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 08ffaa93b78f..741068580455 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -2024,8 +2024,14 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
>>   		if (!next || next->level <= node->level)
>>   			break;
>>   	}
>> -	if (!root)
>> -		return NULL;
>> +	if (!root) {
>> +		/*
>> +		 * This can happen if there's fs corruption or if there's a bug
>> +		 * in the backref lookup code.
>> +		 */
>> +		ASSERT(0);
> 
> You've added these assert(0) to several patches and I think it's wrong.
> The asserts are supposed to verify invariants, you can hardly say that
> we're expecting 0 to be true, so the construct serves as "please crash
> here", which is no better than BUG().  It's been spreading, there are
> like 25 now.

They are much better than a BUG_ON(), as they won't trip in production, they'll 
only trip for developers.  And we need them in many of these cases, and this 
example you've called out is a clear example of where we absolutely want to 
differentiate, because we have 3 different failure modes that will return 
-EUCLEAN.  If I add a ASSERT(ret != -EUCLEAN) to all of the callers then when 
the developer hits a logic bug they'll have to go and manually add in their own 
assert to figure out which error condition failed.  Instead I've added 
explanations in the comments for each assert and then have an assert for every 
error condition so that it's clear where things went wrong.

So these ASSERT()'s are staying.  I could be convinced to change them to match 
their error condition, so in the above case instead I would be fine changing it to

if (!root) {
	ASSERT(root);
...

If that's more acceptable let me know, I'll change them to match their error 
condition.  Thanks,

Josef
