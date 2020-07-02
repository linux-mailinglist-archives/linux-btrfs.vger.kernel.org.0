Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D8221250E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgGBNo7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbgGBNo7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:44:59 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190D3C08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:44:59 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 80so25631206qko.7
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=puoFYvoJ1YpZ+ctelOp3Ex0tIRf2zdrSZde5gefaeqM=;
        b=dsKrdTtjqGpw59bY48DdsF0X1GGSTt2LpgmQMnRwktVAxEDnE1A052cSCqU+4HTwLy
         IMh8Uqwicg4+kJRFSe3ITSUBcNpcJRb6gRfbXqyVlAIWZRdrD2HEvSTvVGM87SJOtyYe
         nZotBgfC/BmGSkeWpOfCb0hsnbmti1phIx1lZB7FeDFQlTtvenIXHMFsDYy+OGD55Yvr
         ynKtJXumNV1YF/0pgIMcWcOm3nOnh+vj4txYqVKrRUHN/dhDkx18VO7muwktvRZyxfu0
         DUmNWN7BUgI0NoE9mwu1aVnj4Nd4JtuvS9YEfFBjiRcGlRM/ektX+Hf0Xfp1T+kpKO6c
         6WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=puoFYvoJ1YpZ+ctelOp3Ex0tIRf2zdrSZde5gefaeqM=;
        b=NXiG0mwj/Hc2JifWmscgKJd45Nejwfiph6RnCqgZqvZNP1Q5BE43o3rstRLuFK48Mi
         qKOWp5rSVqePotZLq2j/cCiJuoD20pbh3kMBvjXSzcpnrMXhktjinTkyxnsoAcgc73hU
         YjQAd1zzIXu5d3VcNhlM/8CmFPZo0eEYCKzKIlvv1Wtq0ldRZlbyClQ76XwusbTuKXvu
         K9zsZvccd8A3tjvLglSEq8H/Nz8DF8/bh2pX18KVMhQOewqYa4mpFsWAioJFGfWZZTSX
         ijf+W+7OW4e1YZ0ccjag7UiLjBSsy4cXJjQXxA4YYB/TY4vLVmww11st5nFguCE4WmBp
         kwWw==
X-Gm-Message-State: AOAM531Lh14xt6SiYc6sbt/Puad0vQg0PCc0rPviHkGqeau++6dNMS8X
        bfyv4C4GSJ9paql1V7ZTwlbvFv05J1s0Rw==
X-Google-Smtp-Source: ABdhPJwnHu/NT9oOHvDOUCllTC4DdjgG4P53+gbKpSCJkSXSeiacjqb1um6krF5KxeyaIVNPAkDLeA==
X-Received: by 2002:a37:7a42:: with SMTP id v63mr31185812qkc.258.1593697497818;
        Thu, 02 Jul 2020 06:44:57 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s71sm8283650qke.0.2020.07.02.06.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:44:57 -0700 (PDT)
Subject: Re: [PATCH 0/3] btrfs: qgroup: Fix the long existing regression of
 btrfs/153
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702001434.7745-1-wqu@suse.com>
 <ed428325-cd27-0c49-14d3-9a041fa9a8ab@toxicpanda.com>
 <20200702134142.GO27795@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <900e5d2c-91dc-5ed1-adb9-d110cd6fd49b@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:44:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702134142.GO27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 9:41 AM, David Sterba wrote:
> On Thu, Jul 02, 2020 at 09:28:30AM -0400, Josef Bacik wrote:
>> On 7/1/20 8:14 PM, Qu Wenruo wrote:
>>> Since commit c6887cd11149 ("Btrfs: don't do nocow check unless we have to"),
>>> btrfs/153 always fails with early EDQUOT.
>>>
>>> This is caused by the fact that:
>>> - We always reserved data space for even NODATACOW buffered write
>>>     This is mostly to improve performance, and not pratical to revert.
>>>
>>> - Btrfs qgroup data and meta reserved space share the same limit
>>>     So it's not ensured to return EDQUOT just for that data reservation,
>>>     metadata reservation can also get EDQUOT, means we can't go the same
>>>     solution as that commit.
>>>
>>> This patchset will solve it by doing extra qgroup space flushing when
>>> EDQUOT is hit.
>>>
>>> This is a little like what we do in ticketing space reservation system,
>>> but since there are very limited ways for qgroup to reclaim space,
>>> currently it's still handled in qgroup realm, not reusing the ticketing
>>> system yet.
>>>
>>> By this, this patch could solve the btrfs/153 problem, while still keep
>>> btrfs qgroup space usage under the limit.
>>>
>>> The only cost is, when we're near qgroup limit, we will cause more dirty
>>> inodes flush and transaction commit, much like what we do when the
>>> metadata space is near exhausted.
>>> So the cost should be still acceptable.
>>
>> This patchset fails to apply on misc-next as of
>>
>>       btrfs: allow use of global block reserve for balance item deletion
> 
> That's about 50 patches behind some recent snapshot of misc-next, the
> patches apply cleanly for me here.
> 

I misread the date on my tree, I just saw "Thu" and assumed my cron job was 
doing its job correctly.  Thanks,

Josef
