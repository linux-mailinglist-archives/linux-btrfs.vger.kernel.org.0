Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F90216F65
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 16:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGGOyq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 10:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgGGOyq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 10:54:46 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04141C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 07:54:45 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e13so38359149qkg.5
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 07:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SeFbw9xAMoWOVWkdO6e1aHiZnm7EwaIvK57AdrDztI0=;
        b=1Xiy2CSxK9PMtqy+oo5fq4CWUc5qks/wymZcoTpCSplLbH/PNBaFlufKTrEISyvCnn
         doZYCbReYf8smOo95BHOxWroNSkKmiPGewdl/cgV2utzMyz4ER8v7EbIU3l6lfWbix/R
         oDkZMuOkZikoklWpK8O1YpcT0Znp9g1LTFNj2RFIgTdOIce44iB5sRtqn8KpiC3pQXVk
         h1k7zgmhxow09EsQbcyONxG0+cm50/HceQEnAvOlC2q1Z0HOALvW4SzQ3ptEZCUY53xB
         JFHS3JVgVxe1KUfiiP30rmb74/cDCN+TM0sfP1sJl+TtqsJwRuJelKEqnKCiXa5PstaN
         XPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SeFbw9xAMoWOVWkdO6e1aHiZnm7EwaIvK57AdrDztI0=;
        b=k9ZyKFewhYbGnSZvcM47WlswjgDDU0+OPojwjHZMJFabhgrQMA3TKY/7PPGSa6weD1
         tYMEUecEIxB7nyTIjgr2INo2saFpVPfaQpq/c3QzvAiop0om4bbqeFD0AJkhkuUeyxXR
         OwVtwoSKU+PC2s1GB+3uu/ym8JUrahqstOIMLdawWBvZiejTYVmGc8cYBnF9PuM2azEg
         AyO1Ii7IFNXftyfuVU5UwBkXyuL3EDIx/k+PqkNdbdSbD24UbWhNIeeVnhbxqTpbQXvC
         b7+ToxwpFIIWUNvKQJSWVdQK0LD2qXSAMru2x/13W4WKRI3Bp7eYxeA4BRj17Tazex9o
         QvmQ==
X-Gm-Message-State: AOAM530bH0vtMdyQ2xk13QOihjxFciNVnClgILcjt6vSfQc0v4eBvhGL
        9z5XCmE+noBwJm6By7aUyM8Zci7hH5gBug==
X-Google-Smtp-Source: ABdhPJytgS20KkZzbp2y2nlGdpGeGvSVtCJj5XQSEiNOJsfprBtAH9jluwr5J5DdtZcBFmtcZDHacw==
X-Received: by 2002:a05:620a:1007:: with SMTP id z7mr50146581qkj.443.1594133684950;
        Tue, 07 Jul 2020 07:54:44 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a6sm23930993qkd.69.2020.07.07.07.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 07:54:44 -0700 (PDT)
Subject: Re: [PATCH 13/23] btrfs: add the data transaction commit logic into
 may_commit_transaction
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200630135921.745612-1-josef@toxicpanda.com>
 <20200630135921.745612-14-josef@toxicpanda.com>
 <216b0050-3684-9c74-16e6-8a776a23f41e@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <dfc66141-64a9-7bbc-5355-422fea61be86@toxicpanda.com>
Date:   Tue, 7 Jul 2020 10:54:42 -0400
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
> 

Right, which is why there's this check

         /*
          * See if there is some space in the delayed insertion reservation for
          * this reservation.
          */
         if (space_info != delayed_rsv->space_info)
                 goto enospc;

before all of those checks.  The logic is the same, minus the delayed ref stuff, 
which is kept separate.  If you want I can make the comment a bit more clear, 
it's not very verbose.  Thanks,

Josef
