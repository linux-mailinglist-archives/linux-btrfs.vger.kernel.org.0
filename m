Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A05123114
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 17:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfLQQFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 11:05:54 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34313 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfLQQFy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 11:05:54 -0500
Received: by mail-qk1-f196.google.com with SMTP id j9so7714178qkk.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 08:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EFEFxSK3HGS7nPpt2QAaz9NcOWmtR/rAGiAfbCvCH1k=;
        b=Nfi3HOY8xTjyadBjb8Wh+8agO5Jc+goojt2jwxQQR1vuWK2D58hEDRRIRrfJUxvMxJ
         AlYGZjqnIhMKWClApJZehLK12tHD9490Fzntu8UKcAtZG5fQh3JF2mrBuKn9CNCXSaqU
         iynPtT2lupdOABZ2QZZbb+4Yqw0NnoAuBUq15XPxtgSqFGOUyM8TBpId4N7Noqwgj7qf
         azkHfkqHwzzfaBTFkterrWEhJle00Gt0GsnxGGq2m5z54ZpawaUZzgqgPnx6IODasZUQ
         6yz8odsUDX0xxQxrHzwjgoz4cwFjda2Bd3ZIjw3KOkmlc70nwU0rndMn0kC2oSEAaD4C
         ku5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EFEFxSK3HGS7nPpt2QAaz9NcOWmtR/rAGiAfbCvCH1k=;
        b=PXtTHTsO2cHY1/s6c20MGU73WJW05jNrBGjGq88Lv3Jb59/Mu4nepN+u13ODdsnIm0
         keQcBH09bDuhWW7A4dFE3X6ORvpO4Gqa5F82JzCRuHv3+8c6OuP2nb4/nPcIEloQN1t0
         dTsH6ThOAV7wlTmOIUrMlYsv+i8fy48cruBK9RKAXA4RI73yGW/5f6+AF1/AV9oc1jlt
         By3RmS0wUSGDD5fp/UvhcWN4hJJzosdtpZ2WvPkMEUg61HBajZg6Yr79CIftuJTM3inN
         Fov5MYi9b3cD6LYrN/TorQJ6Y3oLqyxXDdu6Vuz6tF3oBdKQJxYOOOTOu80dy2Dc+d0a
         NjAQ==
X-Gm-Message-State: APjAAAUtAfSUFt5ehP2i/c9L0Jc83BQQI16HT0zRiMyjcZ2hmFXU/zsB
        FmQNga0TsBNVLWCvP3XOflsW3A==
X-Google-Smtp-Source: APXvYqwf6T6nl1LBbdtCyZHH73+XZek8zOscdeVMNsPiGpHkeqDsOP3JX/5ASrbZdyFP74rjvj6E6Q==
X-Received: by 2002:a37:a8d4:: with SMTP id r203mr5843395qke.394.1576598753248;
        Tue, 17 Dec 2019 08:05:53 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t2sm7105143qkc.31.2019.12.17.08.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 08:05:52 -0800 (PST)
Subject: Re: [PATCH] btrfs: super: Make btrfs_statfs() work with metadata
 over-commiting
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Tomasz Chmielewski <mangoo@wpkg.org>,
        Martin Raiber <martin@urbackup.org>
References: <20191216061226.40454-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <488111c4-03e3-2211-a8fe-5bab7c0f030b@toxicpanda.com>
Date:   Tue, 17 Dec 2019 11:05:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191216061226.40454-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/16/19 1:12 AM, Qu Wenruo wrote:
> [BUG]
> There are several reports about vanilla `df` reports no available space,
> while `btrfs filesystem df` is still reporting tons of unallocated
> space.
> 
> https://lore.kernel.org/linux-btrfs/CAJCQCtQEu_+nL_HByAWK2zKfg2Zhpm3Ezto+sA12wwV0iq8Ghg@mail.gmail.com/T/#t
> https://lore.kernel.org/linux-btrfs/CAJCQCtSWW4ageK56PdHtSmgrFrDf_Qy0PbxZ5LSYYCbr3Z10ug@mail.gmail.com/T/#t
> 
> The example output from vanilla `df` would look like:
> Filesystem  Size  Used Avail Use% Mounted on
> /dev/loop0  7.4T  623G     0 100% /media/backup
> 
> [CAUSE]
> There is a special check in btrfs_statfs(), which reset f_bavail:
> 
> 	if (!mixed && total_free_meta - SZ_4M < block_rsv->size)
> 		buf->f_bavail = 0;

Why not just read fs_info->free_chunk_space and take that into account?  The 
point is we want to tell the user there's no room left if we can't allocate a 
new chunk and we only have the global reserve space left.  So just subtract the 
global reserve size from the total f_bavail as long as free_chunk_space is 
sufficient, otherwise fall back to the original calculation.  Thanks,

Josef
