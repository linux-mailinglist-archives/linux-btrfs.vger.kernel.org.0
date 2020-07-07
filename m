Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2487B216F8F
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgGGPBn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgGGPBn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:01:43 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB5FC061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:01:43 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 145so35902412qke.9
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Px7K4x8DkVp8iK/OLek9QZCjvuachFinT2rsD1lTjBw=;
        b=rFRpuzjWCrk+D63d11TNbvXRUfly6ngszg33ik/1TV7RxlxR/LkNHC8wrAc3Vk6COA
         sjOPmrWSSsjR6FU/pqeRUut252GZgvDbJJ54d5/OqTWGJBLiwFHfgqy+DGVkdWySccYW
         KSRu0GIuTqQfAt11bVFZqDJ1IdRkiENdYAVrpd5OOmyV1omR8YPW1wbknNkCuO0RriSt
         +/cUC6orGedKDqQqxYx+f+Raj2EuYi+zEM3eMjtINP6KWF0m5cjLG4Dh/oiKBTrjTxAY
         eE/SoanjDOzNY8qmSErs7bJs6cFZGOT52yCn75GBbMFht1BvqSvmobtZtP4AxKYZWwBA
         /xOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Px7K4x8DkVp8iK/OLek9QZCjvuachFinT2rsD1lTjBw=;
        b=a05bpmtoHgvgPSl2yXhBUyLBwveUQbRXVL1Bfxloy3IhLYuNWa7fHR18PBxl6Blv8o
         dtY426Ua0Q8re4qrVr9jG6CIV8AT/qiZdPqdRzSg+cAD60tA3uyzO1iH3/ioTzfKb2UA
         bdZFGy70Kw4J3A7CgMzyKpQqp3ilrWnH0cMCjedb2huhrkw12VWA2VfHsuZ4xx0sxLCM
         HU9B5PHA2jn6wN9swIRRXhd060v1kdMjXsIty/NwDFFRYhjuVjhOvY7O3oShmF6tuMns
         W4ymrHXSD9uSmUxvsrTzpkhJ/F+O+JxEKOM6Q/zT/eNJ3ccNrU0EiFjKe3Ps/VPT+D+F
         zNHw==
X-Gm-Message-State: AOAM533RxJf8yVRG1C4fgrp1d40x6sN1dmI28KLr7KqJMDAaVT8X47bT
        /lOxRbzP6Dm/Js06jvehN0M/ig==
X-Google-Smtp-Source: ABdhPJzvO1yUH2l6PyrgrLF5KWBMaDB+bLw0+TWwYGcMkahrpMHZLnMAKI4PNYOLOHgK3LWfGaHOzw==
X-Received: by 2002:a37:e8c:: with SMTP id 134mr50190443qko.462.1594134102087;
        Tue, 07 Jul 2020 08:01:42 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g41sm28760007qtb.37.2020.07.07.08.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 08:01:41 -0700 (PDT)
Subject: Re: [PATCH 13/23] btrfs: add the data transaction commit logic into
 may_commit_transaction
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200630135921.745612-1-josef@toxicpanda.com>
 <20200630135921.745612-14-josef@toxicpanda.com>
 <216b0050-3684-9c74-16e6-8a776a23f41e@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <040d407f-53ab-9f62-05ac-3b85aa71ee0a@toxicpanda.com>
Date:   Tue, 7 Jul 2020 11:01:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <216b0050-3684-9c74-16e6-8a776a23f41e@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/7/20 10:39 AM, Nikolay Borisov wrote:
> 
> 
> On 30.06.20 г. 16:59 ч., Josef Bacik wrote:
>> Data space flushing currently unconditionally commits the transaction
>> twice in a row, and the last time it checks if there's enough pinned
>> extents to satisfy it's reservation before deciding to commit the
>> transaction for the 3rd and final time.
>>
>> Encode this logic into may_commit_transaction().  In the next patch we
>> will pass in U64_MAX for bytes_needed the first two times, and the final
>> time we will pass in the actual bytes we need so the normal logic will
>> apply.
>>
>> This patch exists soley to make the logical changes I will make to the
>> flushing state machine separate to make it easier to bisect any
>> performance related regressions.
>>
>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>> Tested-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> On a second pass through I'm now somewhat reluctant to merge this code.
> may_commit_transaction has grown more logic which pertain solely to
> metadata. As such I think we should separate that logic (i.e current
> may_commit_transaction) and any further adjustments we might want to
> make for data space info. For example all the delayed refs/trans
> reservation checks etc. make absolutely no sense for data space info.

Oooh I forgot another thing, the reason I did this is because I was trying to 
maintain the behavior while converting, and then change the behavior in 
subsequent patches.  I'm doing this specifically because we may have performance 
regressions, and I didn't want a bisect to show up at "Giant patch that changes 
all the things".  I want it to show up at the patch that actually changed the 
behavior, so we have a better idea of where to look.  So this intermediate step 
is a bit wonky for sure, but the end result at the end of the series is less 
wonky.  But I'm still going to update that comment.  Thanks,

Josef
