Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09029E22B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 03:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgJ1VhP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 17:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgJ1VhL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:37:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C805C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 14:37:10 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f38so600137pgm.2
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 14:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=40vIDzbBJL2YG1BHjdtTlSOizvz0UYT83jysfRFhNbY=;
        b=TS8UueenAjLD81BWZakHfIrlfzk+DA6sEB8mqKEKcIGAL7CvJp5QvS0ZDUYIUmlvuo
         cbxoaRx0jhbc+CO3seT+9L48/iA6j7KoWU+4gzbMYZF+rQM+zC0Mrkfy+99V64EK1JAm
         jXatGZ/J8M5HIGzQzO3cqoSBD9dW/w95BFgaJ2c9pln0JPaaBVIpopSuIMjV2MRlk27q
         v4BTvriwbwiouwow1UO/5qj7oiUaxAOEXmDqAP/AlE7HJ1APOkZFkBskSmijOQDzfs8Y
         OMt4QYLWAilndePGDUF95auPE2pzudaURn4ftlIVb2FVsEPvams7VMx5iac8CYUmclUI
         eKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=40vIDzbBJL2YG1BHjdtTlSOizvz0UYT83jysfRFhNbY=;
        b=OEA7yqMaf39IdoKI1tHiu3Lgws8i8L6JhsVv1nnCYBQtsfXAmIGCorsxcpUzlji8yX
         Txl0cPYwT5pJ7tDk/rvTeBySAjmIZEebWbRI4A1qdwh5hzrKvMYS2fiDBnYja2jNe7hR
         s5ObFADLEb0A1nHE12zjVFsF5Ksr9GTuYj5NSiFsptiXozGnNo7F6c1ABNN3FyFTNdHy
         3wkm8WOEmWRZRMGe7+Yy4mkY+kf0mFTqPPfWprpWYz1wzmpfVHWk1dD6+ZvoLnH2rAom
         Pi0OSRrFA0bkmGQbg5atwLrC8hYnf6HSHeKFLhzEDSZYnKhkxhIoSuA8WCgI10XjbWJS
         e2jw==
X-Gm-Message-State: AOAM5328rrQuerbSR031A5FHIk1332jRhWyJ3QFJYCQAAs+BEJJUx470
        06CoWcADDgLNOL+wiZpRrnpNEHMd/WUskyBU
X-Google-Smtp-Source: ABdhPJy1Vcphmfg7fNhbdgmk6F9Hm0b6qxw/PlQjOvJfckCcD5pFeT/qZjFGIH/bU2NSdv3w/Cwl/g==
X-Received: by 2002:a0c:aa1e:: with SMTP id d30mr7257586qvb.24.1603888902478;
        Wed, 28 Oct 2020 05:41:42 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 129sm2800879qkf.62.2020.10.28.05.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 05:41:41 -0700 (PDT)
Subject: Re: [PATCH RFC 4/7] btrfs: trace, add event btrfs_read_policy
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1603751876.git.anand.jain@oracle.com>
 <e6e5c40113cd3e939441ab3ece823282049a596f.1603751876.git.anand.jain@oracle.com>
 <eaf39974-65db-4a38-4342-f7dbea4d06bc@toxicpanda.com>
 <9e2c88d0-b13a-d175-38e9-7cd0e802acf8@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <03a9ac44-7735-cc5e-fdd7-66ca2f849555@toxicpanda.com>
Date:   Wed, 28 Oct 2020 08:41:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <9e2c88d0-b13a-d175-38e9-7cd0e802acf8@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/28/20 4:59 AM, Anand Jain wrote:
> On 28/10/20 2:22 am, Josef Bacik wrote:
>> On 10/26/20 7:55 PM, Anand Jain wrote:
>>> This patch adds trace event btrfs_read_policy, which is common to all the
>>> read policies.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   fs/btrfs/volumes.c           | 28 ++++++++++++++++++++++++++--
>>>   include/trace/events/btrfs.h | 20 ++++++++++++++++++++
>>>   2 files changed, 46 insertions(+), 2 deletions(-)
>>
>> Noooooo this isn't the way we do this.  Simply make a trace class with all the 
>> variations, and then add individual trace events that inherit from the class 
>> that print out the appropriate values.  Thanks,
>>
> 
> I added this mainly to debug the inflight thing. I was kind of not so
> successful in finding a relation between latency, queue depth, and
> inflight. As it is gone now, I doubt if we still need tracing. I am ok
> to drop this. Or we could add when we start digging anything around
> this?

If you were just using it for debugging then I say we just drop it and add 
something later if we need it.  Thanks,

Josef
