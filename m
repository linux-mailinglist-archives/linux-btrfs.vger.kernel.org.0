Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C194412FA83
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 17:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgACQfH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 11:35:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46486 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgACQfH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 11:35:07 -0500
Received: by mail-qk1-f195.google.com with SMTP id r14so34150130qke.13
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2020 08:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bdYa6RMr68En4RuoTprNfyMjOSJJLlbPLidHiHzcl8A=;
        b=eHIMNY9P7T+MCnddncWMtUB6NelJLtPmP6a3k3SF/MdpjkyCIBdHH5oqd/CY6jV0w/
         BRG/3TIUKL9Voz8Yxgq2dblR+fiohR5iz2id2v6UDU0B7xpBpnTbl7iE9oDQoxKpwxZ9
         auo3GGmupWuvBVikkK+vEklt7fQ064KpLXmLSmgg5my4UwQBPp0ZCGNxJgD/ijzBgkdY
         i5gQgUFDLdeSXxflpke9b2UONRuxaKSrQZHOiFcaVQa75+/A4gtgpovl/LxD+qrCrMRe
         y6aiuOU+6mxe+0KqBN1YGxsDgvhnWN+Xm+5QFuzuGDkZ6Je7ovHEEvvsxsxJrWSSUZl6
         gckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bdYa6RMr68En4RuoTprNfyMjOSJJLlbPLidHiHzcl8A=;
        b=LNUNQmv6zEJgNh9gNwOl5irUAUE1delDUFqnLy7v0APiGR9M7UcqktNe1JlczG9jm+
         0ZHlNAr2pzfwqxfNmdREAmJsdmRX1RDrJa4uPUjORwl/gOfhgSbnlGNBEhVfvje+BUTK
         ky0ZqacUNZPP9hFpLmffxc1YSJMFQtrFEHqvxbSzKfiqQn7Tb/ctY1bLzZg7+10mVinG
         v1+9hmVbNI2HXXpvNt+H2waUflunWu9LmK+W074B1BOS/ZjvGSx/qW3qfJNS+VgeMY6b
         3VhHGPpANRBvWP7qnJpCLm8eZh+sUjYTjHx36sunYis1TI2iyNlD+oeMO6rDIl/BSxaY
         c45Q==
X-Gm-Message-State: APjAAAUofC+Z7g/jcTnK7VrStJUt8HOh90POUFkO01CpN5n0xLskTE77
        B9iJJeowrpPJf4Vznrt/Cu6OYeE2QzB67Q==
X-Google-Smtp-Source: APXvYqwr7mpthDyvqowZVb46HNGoxEpRRVzjuv5H74uuoculc0X5X13r5BFEm2gR6sJJXPN0inwgLw==
X-Received: by 2002:ae9:f80d:: with SMTP id x13mr71818290qkh.226.1578069305622;
        Fri, 03 Jan 2020 08:35:05 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d8sm18337830qtr.53.2020.01.03.08.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:35:04 -0800 (PST)
Subject: Re: [PATCH v2 2/4] btrfs: Update per-profile available space when
 device size/used space get updated
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200102112746.145045-1-wqu@suse.com>
 <20200102112746.145045-3-wqu@suse.com>
 <c4f6ddfb-c52c-d376-4cef-26aebec4e288@toxicpanda.com>
 <5ec1095b-b62b-a267-392a-63e6a3f1eeb3@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f8c58c39-0519-b992-7e0e-ccdf9c358869@toxicpanda.com>
Date:   Fri, 3 Jan 2020 11:35:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <5ec1095b-b62b-a267-392a-63e6a3f1eeb3@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/3/20 4:52 AM, Qu Wenruo wrote:
> 
> 
> On 2020/1/3 上午12:17, Josef Bacik wrote:
>> On 1/2/20 6:27 AM, Qu Wenruo wrote:
>>> There are 4 locations where device size or used space get updated:
>>> - Chunk allocation
>>> - Chunk removal
>>> - Device grow
>>> - Device shrink
>>>
>>> Now also update per-profile available space at those timings.
>>>
>>> For __btrfs_alloc_chunk() we can't acquire device_list_mutex as in
>>> btrfs_finish_chunk_alloc() we could hold device_list_mutex and cause
>>> dead lock.
>>>
>>
>> These are protecting two different things though, holding the
>> chunk_mutex doesn't keep things from being removed from the device list.
> 
> Further looking into the lock schema, Nikolay's comment is right,
> chunk_mutex protects alloc_list (rw devices).
> 
> Device won't disappear from alloc_list, as in btrfs_rm_device() we took
> chunk_mutex before removing writeable device.
> 
> In fact, device_list_mutex is unrelated to alloc_list.
> 
> So other calc_per_profile_avaiable() call sites are in fact not safe, I
> shouldn't take device_list_mutex, but chunk_mutex which are much easier
> to get.
> 
>>
>> Looking at patch 1 can't we just do the device list traversal under RCU
>> and then not have to worry about the locking at all?  Thanks,
> 
> I guess we need SRCU, since in __btrfs_alloc_chunk() context we need to
> sleep for search dev extent tree.
> 
> And I'm not confident enough for some corner case, maybe some RCU sync
> case would cause unexpected performance degrade as the RCU sync can be
> more expensive than simple mutex lock.
> 

Sigh sorry I was reading it like we were doing fs_devices->devices, which is all 
handled via RCU.  But you're right, alloc_list is covered by the chunk mutex, so 
just make sure the chunk mutex is taken every where and you should be good to 
go.  Thanks,

Josef
