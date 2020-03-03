Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5E31783F3
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 21:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgCCU1U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 15:27:20 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34369 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729967AbgCCU1U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Mar 2020 15:27:20 -0500
Received: by mail-qt1-f194.google.com with SMTP id 59so2730009qtb.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2020 12:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3cOv5ohv6Ki8sCU+pB8Pasj18xLBR3CCEqLVdTgVDss=;
        b=MrnvDSFXRlkqaobS7YuW0v2E8JexMyeHXWLz8v8nNqw+QkxfF1lIaGKjjXpr/Tj8Oz
         9EYFWR66+8oDKBBFOO+gRTADV2osV/QjTc1W9awp3wzeonMXygUDxSq+ypUCJEeRScer
         7CXygDfpmUit1/x+iaQ7IvnxVkGKX8i/GAxgH5hExDbQoXcZlvyinfMBYuJgevZJ7M44
         2al7leOWDbQocLPPaxEclBX0THY3/Fr/BAFaLIQ+p5doPdnj1c6Uxd423+14JvI+LVr8
         stz0AoslaU2xTZyfvcgvyzolg7Vkdo5R33EqyIhWq1ELRV6VKQWfEMCj0F59bglZJT2w
         K4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3cOv5ohv6Ki8sCU+pB8Pasj18xLBR3CCEqLVdTgVDss=;
        b=No51z1Y6qstxIoCS76/OH829i0hMiikmVEN3D+sWF0mlCTKr2ZlF1Korw0sEyhi6hN
         Slbv+qEwOAbpcDW41IIrPDRWGiKcRodItUiTlIbhpcsH3oIYoWHXJM8LcrhlRgaXzXgE
         8mW1zyaEKQWIuwLvrFSRqmXajdoY23BX8WxcPu/RATD/+09T878kUNmrGL627YlOpAvx
         DvekIVbDUalY0j2/kHSqnLP664s2DfkrqPJ95mpgOFCZ6tr9MR/juDNBTT9GGwgtFdSs
         OIqpBHsXH1ssbJ+6LUGE5glAo8GIZQOnMywYLJrL5vOjDuHQ2M4FRBUpqFrQI5DMJYMp
         DKVQ==
X-Gm-Message-State: ANhLgQ1kN0vgLH2mAwjr1S7DU51o06q5GipWHSFKZyzuDnhdj3bCpmWG
        DuE3xYsJU+pQN9fBRpzzNyAZIIIGUXw=
X-Google-Smtp-Source: ADFU+vuz0KWbBepjoqO2u9kUYe/k/I9oxFeehvdm9uF5mA46dAv7/1y7SvvPVuhqa/iLXTHecx0Vng==
X-Received: by 2002:ac8:59:: with SMTP id i25mr6150092qtg.110.1583267238961;
        Tue, 03 Mar 2020 12:27:18 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k63sm8559861qtd.15.2020.03.03.12.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 12:27:18 -0800 (PST)
Subject: Re: [PATCH 1/7] btrfs: drop block from cache on error in relocation
To:     dsterba@suse.cz, kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-2-josef@toxicpanda.com>
 <20200303145950.GC2902@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4bf09699-6810-dfd2-a714-f94e48f2f600@toxicpanda.com>
Date:   Tue, 3 Mar 2020 15:27:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303145950.GC2902@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/3/20 9:59 AM, David Sterba wrote:
> On Mon, Mar 02, 2020 at 01:47:51PM -0500, Josef Bacik wrote:
>> If we have an error while building the backref tree in relocation we'll
>> process all the pending edges and then free the node.  This isn't quite
>> right however as the node could be integrated into the existing cache
>> partially, linking children within itself into the cache, but not
>> properly linked into the cache itself.
> 
> I'm missing description of what's the problem. Something is linked and
> then freed, followed by 'fixed by'.
> 
>> The fix for this is simple, use
>> remove_backref_node() instead of free_backref_node(), which will clean
>> up the cache related to this node completely.
> 
> So this means that some entries are left in the cache? Leaked memory or
> something else?

Yeah leaked memory and root references, I'll update the changelog to be more clear.

> 
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/relocation.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 4fb7e3cc2aca..507361e99316 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -1244,7 +1244,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>>   			free_backref_node(cache, lower);
>>   		}
>>   
>> -		free_backref_node(cache, node);
>> +		remove_backref_node(cache, node);
>>   		return ERR_PTR(err);
>>   	}
>>   	ASSERT(!node || !node->detached);
> 
> There's a similar pattern in clone_backref_node
> 
> 1317 fail:
> 1318         while (!list_empty(&new_node->lower)) {
> 1319                 new_edge = list_entry(new_node->lower.next,
> 1320                                       struct backref_edge, list[UPPER]);
> 1321                 list_del(&new_edge->list[UPPER]);
> 1322                 free_backref_edge(cache, new_edge);
> 1323         }
> 1324         free_backref_node(cache, new_node);
> 
> Does this also need to be fixed?
> 

No this is fine, this essentially does what remove_backref_node() does.  The 
build_backref_tree() cleanup just handles the local lists, not the edges 
attached to the node.  clone_backref_node does the cleanup properly.  Thanks,

Josef
