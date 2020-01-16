Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2D013DFED
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 17:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgAPQVf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 11:21:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36731 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgAPQVf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 11:21:35 -0500
Received: by mail-qt1-f194.google.com with SMTP id i13so19324882qtr.3
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 08:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PFoORGe7WToxl331B28lIbG+QQPonJoJbxVLbS6J2S4=;
        b=htnGMGHaEPaEioAYvSZDtdWTgPAdm8CnwtcDafCuI+CAVUXQOv1MO8Trj+e77lxswu
         gjN3k8g1+5YQG4/RxC2rpv0XUH2ufWa68dfnPHGZkFtVqameNpZ5Vr28Fi0/dObcoGWy
         XrB5jwTfMpG+qpHE+tyUc+DnOys5MQY637luq9kFHmDuPbr/p/VQOECl4g2x8jMv4jYA
         tGAyFuaA8P/Q5up9T6CVmlbQEZjRgKIKHV3pP4gcfh0+gADtjwMA437Ad9ZjeEwab1qb
         FkDSXePryg8B4NEXhua5oKd+yvbRPQJNM/BygxOwCJ6GEQ5OvkOkPsvZqQvixwKqSjwo
         RXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PFoORGe7WToxl331B28lIbG+QQPonJoJbxVLbS6J2S4=;
        b=kqnWlAAhxhU6S9x42A8MhWaro9Ht8w5+sRZpoX0Pd+hE7lcixLZgmqT/RMGjWpWknJ
         fwyItIgCbz+UgtgNM33mUi85J4a/rPpmHdHAUVfdnYA7RxpeBsARI8q4XiztLAWwvcDn
         BxbZKAriDe2Sb+Pz3s+6a9EvrU0QgQn4e7zNm4+xMy7q6XuR8VXNQRBn0ueEHxG6xcFi
         eElowptIdT67ue3w9YGblBKTMBdm5vYmdQbU7e+NjeB2uqdwhVu75nT+WCSovTMC6ySA
         YjBhizS16bneGEv56/ObtTaDOp/j9Qz99F/HMDspaELyMwzSkE0RwMS5xc5HxwcO6fWd
         n+jw==
X-Gm-Message-State: APjAAAUNH6Mh2UvkBpM+u80hCu7yF1zeI66MUvKeQb/4JZVvmkXxZSEc
        018HySeSXa2CJJUKt3Hh+QfFIxgQbjA4Fw==
X-Google-Smtp-Source: APXvYqwPzJEEGJI7cVhZH+nEyckATb68fu0c1M8OsJQohiQEn/IPevy2/4mpuMGTvzrVu9rZWvyM+A==
X-Received: by 2002:ac8:1415:: with SMTP id k21mr3187818qtj.300.1579191693417;
        Thu, 16 Jan 2020 08:21:33 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6813])
        by smtp.gmail.com with ESMTPSA id q130sm10215551qka.114.2020.01.16.08.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:21:32 -0800 (PST)
Subject: Re: [PATCH v6 3/5] btrfs: statfs: Use pre-calculated per-profile
 available space
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200116060404.95200-1-wqu@suse.com>
 <20200116060404.95200-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fd33e06c-6e4b-9117-28e3-323c4e103aaf@toxicpanda.com>
Date:   Thu, 16 Jan 2020 11:21:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200116060404.95200-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/20 1:04 AM, Qu Wenruo wrote:
> Although btrfs_calc_avail_data_space() is trying to do an estimation
> on how many data chunks it can allocate, the estimation is far from
> perfect:
> 
> - Metadata over-commit is not considered at all
> - Chunk allocation doesn't take RAID5/6 into consideration
> 
> This patch will change btrfs_calc_avail_data_space() to use
> pre-calculated per-profile available space.
> 
> This provides the following benefits:
> - Accurate unallocated data space estimation, including RAID5/6
>    It's as accurate as chunk allocator, and can handle RAID5/6.
> 
> Although it still can't handle metadata over-commit that accurately, we
> still have fallback method for over-commit, by using factor based
> estimation.
> 
> The good news is, over-commit can only happen when we have enough
> unallocated space, so even we may not report byte accurate result when
> the fs is empty, the result will get more and more accurate when
> unallocated space is reducing.
> 
> So the metadata over-commit shouldn't cause too many problem.
> 
> Since we're keeping the old lock-free design, statfs should not experience
> any extra delay.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
