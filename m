Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0DB135BA2
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 15:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbgAIOqu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 09:46:50 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34169 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbgAIOqu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 09:46:50 -0500
Received: by mail-qk1-f196.google.com with SMTP id j9so6204002qkk.1
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jan 2020 06:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HqALP55yAIg4QWlhVObHKRdbb0jXrBFhMtOufadOoSk=;
        b=zEl6VeQPqukUA786H9gFOxdNMXVfNeu0mKzFAL8nxhGnCMcqQBfGEqprfQnkoNTgJs
         wr4oAUanrwIr6oYZVRh5mPILUV652aymWSIvRpBnerMnBoERDhQiQ/HTUQbyUSOPL5+V
         aGDOdYwgNtiytTwHAgHosbxLeceNbINjnlSUvNMlhp2FMYqakEsjAEVc+u5t1wb3+nCi
         sJIIhYK4xLyYmzgw3I4KQqAYvMel93W7NnhT1GNGoCBt4usr4lvhoMt3ciKnRr3YyxOT
         E7zMBOWB8iW/lLQTzkMMSDSq/d8w+PPO6uZEe7IPNyHcFBbUXPQE1SC+W+dNEedJb4LW
         nAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HqALP55yAIg4QWlhVObHKRdbb0jXrBFhMtOufadOoSk=;
        b=Dx0mzk6jQ+tSJFJI8UIvPsbZcAb+fKIecHne+XeYAyZ+whZJTOhr7IEvTtAcdDbfhF
         DzJwlqg5ON6PapSrGmNVWHsSaGEN1Ui4bAPEvHl11sgm1wX8vasZwfc+CRQktLMyi9Z9
         511Y85TfTzq4fylZCPo4lSeU2TE4bzZw/a+ocFchAD78MRQS8CNLTi9vpNmc2GB8apFn
         wLkn6wX8pUxox0vhv75decJzH1+pSgENRrzBQmU/jjPL2D5UnOidKgUOIBs4hpuEn4iF
         nC9EtkEh/h76o48uKaJT1HeQbYyynxuiBO2d3CTANm/g1oaQcwIZxp2sEtEhZdPC2LUU
         D/ag==
X-Gm-Message-State: APjAAAXvXgym0rRzhRoeMYwIh2dAo1R0B3Qf+kw+pcT/mRYrQietcjTi
        HtjzfI/hKe8bTMC/F2KlBkkJAkEV7+QyTA==
X-Google-Smtp-Source: APXvYqztG5W4DMvILf7RwF/gq7PWVSFID33IaNOatj4sOm1JuuY+lAkXQiAOlr2aaSySmQJn6GFh/w==
X-Received: by 2002:a05:620a:cef:: with SMTP id c15mr10034383qkj.352.1578581208378;
        Thu, 09 Jan 2020 06:46:48 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o55sm3465998qtf.46.2020.01.09.06.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 06:46:47 -0800 (PST)
Subject: Re: [PATCH v5 2/4] btrfs: Introduce per-profile available space
 facility
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200109071634.32384-1-wqu@suse.com>
 <20200109071634.32384-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <059d9f5d-3b64-4bdf-68c4-2f24c2d0106d@toxicpanda.com>
Date:   Thu, 9 Jan 2020 09:46:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109071634.32384-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/9/20 2:16 AM, Qu Wenruo wrote:
> [PROBLEM]
> There are some locations in btrfs requiring accurate estimation on how
> many new bytes can be allocated on unallocated space.
> 
> We have two types of estimation:
> - Factor based calculation
>    Just use all unallocated space, divide by the profile factor
>    One obvious user is can_overcommit().
> 
> - Chunk allocator like calculation
>    This will emulate the chunk allocator behavior, to get a proper
>    estimation.
>    The only user is btrfs_calc_avail_data_space(), utilized by
>    btrfs_statfs().
>    The problem is, that function is not generic purposed enough, can't
>    handle things like RAID5/6.
> 
> Current factor based calculation can't handle the following case:
>    devid 1 unallocated:	1T
>    devid 2 unallocated:	10T
>    metadata type:	RAID1
> 
> If using factor, we can use (1T + 10T) / 2 = 5.5T free space for
> metadata.
> But in fact we can only get 1T free space, as we're limited by the
> smallest device for RAID1.
> 
> [SOLUTION]
> This patch will introduce per-profile available space calculation,
> which can give an estimation based on chunk-allocator-like behavior.
> 
> The difference between it and chunk allocator is mostly on rounding and
> [0, 1M) reserved space handling, which shouldn't cause practical impact.
> 
> The newly introduced per-profile available space calculation will
> calculate available space for each type, using chunk-allocator like
> calculation.
> 
> With that facility, for above device layout we get the full available
> space array:
>    RAID10:	0  (not enough devices)
>    RAID1:	1T
>    RAID1C3:	0  (not enough devices)
>    RAID1C4:	0  (not enough devices)
>    DUP:		5.5T
>    RAID0:	2T
>    SINGLE:	11T
>    RAID5:	1T
>    RAID6:	0  (not enough devices)
> 
> Or for a more complex example:
>    devid 1 unallocated:	1T
>    devid 2 unallocated:  1T
>    devid 3 unallocated:	10T
> 
> We will get an array of:
>    RAID10:	0  (not enough devices)
>    RAID1:	2T
>    RAID1C3:	1T
>    RAID1C4:	0  (not enough devices)
>    DUP:		6T
>    RAID0:	3T
>    SINGLE:	12T
>    RAID5:	2T
>    RAID6:	0  (not enough devices)
> 
> And for the each profile , we go chunk allocator level calculation:
> The pseudo code looks like:
> 
>    clear_virtual_used_space_of_all_rw_devices();
>    do {
>    	/*
>    	 * The same as chunk allocator, despite used space,
>    	 * we also take virtual used space into consideration.
>    	 */
>    	sort_device_with_virtual_free_space();
> 
>    	/*
>    	 * Unlike chunk allocator, we don't need to bother hole/stripe
>    	 * size, so we use the smallest device to make sure we can
>    	 * allocated as many stripes as regular chunk allocator
>    	 */
>    	stripe_size = device_with_smallest_free->avail_space;
> 	stripe_size = min(stripe_size, to_alloc / ndevs);
> 
>    	/*
>    	 * Allocate a virtual chunk, allocated virtual chunk will
>    	 * increase virtual used space, allow next iteration to
>    	 * properly emulate chunk allocator behavior.
>    	 */
>    	ret = alloc_virtual_chunk(stripe_size, &allocated_size);
>    	if (ret == 0)
>    		avail += allocated_size;
>    } while (ret == 0)
> 
> As we always select the device with least free space, the device with
> the most space will be the first to be utilized, just like chunk
> allocator.
> For above 1T + 10T device, we will allocate a 1T virtual chunk
> in the first iteration, then run out of device in next iteration.
> 
> Thus only get 1T free space for RAID1 type, just like what chunk
> allocator would do.
> 
> The patch will update such per-profile available space at the following
> timing:
> - Mount time
> - Chunk allocation
> - Chunk removal
> - Device grow
> - Device shrink
> 
> Those timing are all protected by chunk_mutex, and what we do are only
> iterating in-memory only structures, no extra IO triggered, so the
> performance impact should be pretty small.
> 
> For the extra error handling, the principle is to keep the old behavior.
> That's to say, if old error handler would just return an error, then we
> follow it.
> If the older error handler choose to abort transaction, then we follow
> it too.
> So new failure mode is introduced.
> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
