Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7EA261775
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 19:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgIHRe7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 13:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbgIHQPM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Sep 2020 12:15:12 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133F6C06137B
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Sep 2020 05:52:22 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so11710531qtv.12
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Sep 2020 05:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=a7mWytfrXx9VxhixW12fSf5IdG2zJ22PQsoK01S4qzE=;
        b=jSWSaIDtEXu1ExM3EYLbnG7Zye1ztPn+/lb43OIRl3abHpMXKmd4EYtn35VZeh08MP
         uIot0dbsiuPcxHyKHqLg6rL1tdp3p4nZtk7El2JYAQiNDvdG4OoRC0icPHUCuJ7E4P0x
         ckuBoUuJodEIwTJJQGqHf1DLAZlCjZs67vG1MhcLiWSb8B/u9VzwzPIj71uZVe3p3l7o
         aEa4TjNJCqwb62JtqLrMcZKkxqhv90RRlQwb9aazfaqXO+EGAq/YInxPvwsTxUXNS/Ti
         /eH/andDVeVCXV2sELo7XdXrYb7V/PMsjGfHAY2XCTpPU1pZt3DrWfs907dFHxPDfmqI
         1CWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a7mWytfrXx9VxhixW12fSf5IdG2zJ22PQsoK01S4qzE=;
        b=MOg0wa45htBT5z8vMcCaTO5qJoqH5mhUCGuRP8eOCWpFXPPInrnq68vs17nNnSUARA
         LWgIkzDf3hjA/wBoExab3QVzON+vEMxGgE9dr0QKY6FN/vPiJIL8e2Eb5PQFpc8SCASa
         KTUoPiDZ4z9bMSWaugUPk0+PjVaWXvPpudw+07lWQNKoqlrWvYe5nWuctSg4BUfXLlo9
         4I+GthJMXJEoDsv2GkUOde1NtNbAtQMjsC/QCzoPG6u1wk+UdaZjvb2IkDB4wABQCRYl
         ic+a6/7d7tAWojJqJZzX4LfVE9HIGSHG9hxxI3fcibOXOiaEsQ2h61AGSUsTVDcFq4KW
         NS2Q==
X-Gm-Message-State: AOAM5331/OUmLircEsGNIdlH2/DpJg46x5gJkp4zDefLXSNhnQyRR3/m
        N7yy/XRvRVyE3QdGsxfQvvkKOw==
X-Google-Smtp-Source: ABdhPJzP0QVwlleWfsUnxHxSj8b9pfoW1I6ai4xrC/f0LeXMAA5TV7qx8Pa7+8m2mNUCNtwKSh2tmA==
X-Received: by 2002:ac8:76cb:: with SMTP id q11mr24604777qtr.63.1599569540649;
        Tue, 08 Sep 2020 05:52:20 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k6sm14395162qti.23.2020.09.08.05.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 05:52:19 -0700 (PDT)
Subject: Re: [PATCH 4/4] btrfs: do not create raid sysfs entries under any
 locks
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1598996236.git.josef@toxicpanda.com>
 <2f140cd79a9738e72fc6da6ef4ba3635962dbf9c.1598996236.git.josef@toxicpanda.com>
 <20200908124003.GE28318@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ed683b7e-bd67-1f27-58ac-a979d8c97f90@toxicpanda.com>
Date:   Tue, 8 Sep 2020 08:52:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200908124003.GE28318@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/8/20 8:40 AM, David Sterba wrote:
> On Tue, Sep 01, 2020 at 05:40:38PM -0400, Josef Bacik wrote:
>>   	}
>>   
>>   	list_for_each_entry(space_info, &info->space_info, list) {
>> +		int i;
>> +
>> +		for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
>> +			if (list_empty(&space_info->block_groups[i]))
>> +				continue;
>> +			cache = list_first_entry(&space_info->block_groups[i],
>> +						 struct btrfs_block_group,
>> +						 list);
>> +			btrfs_sysfs_add_block_group_type(cache);
>> +		}
>> +
> 
> I had the previous version of the patch pass fstests, with no lockdep
> warnings and then realized it's not the v2 that depends on the 3rd patch
> removing RCU from this list traversal.
> 
> btrfs_sysfs_add_block_group_type does not seem to be conflicting RCU in
> this loop so now I'm undecided if v1 is ok or if we really need v2, sice
> the patch 3 removing RCU seems suspicious.
> 

It conflicts with RCU here because we could sleep, that's why I had to remove it.

Alternatively we could just loop a second time through the space_info's outside 
of the RCU to do the btrfs_sysfs_add_block_group_type(), and I can drop the RCU 
removal patch altogether.  It's up to you, but we still need v2 because the 
problem still exists without it.  Thanks,

Josef
