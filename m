Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC3E1F1BD8
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 17:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgFHPR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbgFHPRZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 11:17:25 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984DBC08C5C2
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Jun 2020 08:17:24 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c14so17554073qka.11
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Jun 2020 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JiOvxiTPa1kcYy+dNKUF0vBf7Nwbv27ar6+ILNkkmVo=;
        b=JvfzO5HKDlaJ1ADKD+oDDtW8QqVXOnAYlNO2SWNHy1ysSU0ASyP8uWlpgtig4Jp4Hu
         5MmJwzI44JRwyirHMNofCcPFeu/PKaDbwvlAf3v+nbpDHcFXfnCbg6aYX8bYN9iAEczF
         0lNDOVfkPUpywunbMlZd6XGiqXrHzZJ0LKgtvCVttecVJ7b5iMUwagkvMI0MA4TuBpQP
         Mp3Gir5icAGsacRZDpSAkdDlVGBhDgAxdi09r4rZkql2A6JfiILxXT5KOaQnoOZIy95n
         b7ir4wLi0zwWNSYAdWDL1mNwYGk3hnijEWw2daMRTiUf+i8qRIDcQvChft47SFwEc+HR
         jnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JiOvxiTPa1kcYy+dNKUF0vBf7Nwbv27ar6+ILNkkmVo=;
        b=J6HdW5AeNU/ia/PydkzbzX06lqKTypwddizC7bBXDOnf0ciNQJzgqF0PvfmnKC0Jde
         v9nV0g+4jenuCVA1duTGb2GfAUxJwuWeXvijyntlTwOIrWwxtpFUN0z462zNMwOZhHKi
         JCJhU4tWBP+xSOFoTj1XZwtyv9GluSi7IuD8yR+R+Y3iSF/rcEgzAe5B+uyyu9eam7mU
         Xa1ab3fPG2iQmMPEHDCXl3oCb9frhaI34Rxxa3F41XFgIbtoHe39OiYlnrwYVXUDLi9Z
         NK9crcMYh90om4BwraP5xoDAZUpkWFcN2+4Npra/osdx1loXecpN2ozVOegh33ZOXsHK
         K38A==
X-Gm-Message-State: AOAM532dmlbBtW7ONr+B+6crsZtYTAUrs92S28FtozYlO00AujRDJnej
        IA/cI5geVX463DOX4GiamxljiZkirG+XHw==
X-Google-Smtp-Source: ABdhPJxaYr++SmgRYAVWQXVKJX6Kub2cOZrufcmVUFfA/tTnYypyt4Es8lSqQPIMsci80izimSez2w==
X-Received: by 2002:a37:a08:: with SMTP id 8mr23677657qkk.388.1591629443059;
        Mon, 08 Jun 2020 08:17:23 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10a4? ([2620:10d:c091:480::1:ae5a])
        by smtp.gmail.com with ESMTPSA id u25sm7704592qtc.11.2020.06.08.08.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 08:17:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] btrfs: extent_io: fix qgroup reserved data space
 leakage when releasing a page
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200607072512.31721-1-wqu@suse.com>
 <20200607072512.31721-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2d098492-b927-fc01-d33e-9f89452d26fa@toxicpanda.com>
Date:   Mon, 8 Jun 2020 11:17:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200607072512.31721-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/7/20 3:25 AM, Qu Wenruo wrote:
> [BUG]
> The following simple workload from fsstress can lead to qgroup reserved
> data space leakage:
>    0/0: creat f0 x:0 0 0
>    0/0: creat add id=0,parent=-1
>    0/1: write f0[259 1 0 0 0 0] [600030,27288] 0
>    0/4: dwrite - xfsctl(XFS_IOC_DIOINFO) f0[259 1 0 0 64 627318] return 25, fallback to stat()
>    0/4: dwrite f0[259 1 0 0 64 627318] [610304,106496] 0
> 
> This would cause btrfs qgroup to leak 20480 bytes for data reserved
> space.
> If btrfs qgroup limit is enabled, such leakage can lead to unexpected
> early EDQUOT and unusable space.
> 
> [CAUSE]
> When doing direct IO, kernel will try to writeback existing buffered
> page cache, then invalidate them:
>    iomap_dio_rw()
>    |- filemap_write_and_wait_range();
>    |- invalidate_inode_pages2_range();
> 
> However for btrfs, the bi_end_io hook doesn't finish all its heavy work
> right after bio ends.
> In fact, it delays its work further:
>    submit_extent_page(end_io_func=end_bio_extent_writepage);
>    end_bio_extent_writepage()
>    |- btrfs_writepage_endio_finish_ordered()
>       |- btrfs_init_work(finish_ordered_fn);
> 
>    <<< Work queue execution >>>
>    finish_ordered_fn()
>    |- btrfs_finish_ordered_io();
>       |- Clear qgroup bits
> 
> This means, when filemap_write_and_wait_range() returns,
> btrfs_finish_ordered_io() is not ensured to be executed, thus the
> qgroup bits for related range is not cleared.
> 
> Now into how the leakage happens, this will only focus on the
> overlapping part of buffered and direct IO part.
> 
> 1. After buffered write
>     The inode had the following range with QGROUP_RESERVED bit:
>     	596		616K
> 	|///////////////|
>     Qgroup reserved data space: 20K
> 
> 2. Writeback part for range [596K, 616K)
>     Write back finished, but btrfs_finish_ordered_io() not get called
>     yet.
>     So we still have:
>     	596K		616K
> 	|///////////////|
>     Qgroup reserved data space: 20K
> 
> 3. Pages for range [596K, 616K) get released
>     This will clear all qgroup bits, but don't update the reserved data
>     space.
>     So we have:
>     	596K		616K
> 	|		|
>     Qgroup reserved data space: 20K
>     That number doesn't match with the qgroup bit range anymore.
> 
> 4. Dio prepare space for range [596K, 700K)
>     Qgroup reserved data space for that range, we got:
>     	596K		616K			700K
> 	|///////////////|///////////////////////|
>     Qgroup reserved data space: 20K + 104K = 124K
> 
> 5. btrfs_finish_ordered_range() get executed for range [596K, 616K)
>     Qgroup free reserved space for that range, we got:
>     	596K		616K			700K
> 	|		|///////////////////////|
>     We need to free that range of reserved space.
>     Qgroup reserved data space: 124K - 20K = 104K
> 
> 6. btrfs_finish_ordered_range() get executed for range [596K, 700K)
>     However qgroup bit for range [596K, 616K) is already cleared in
>     previous step, so we only free 84K for qgroup reserved space.
>     	596K		616K			700K
> 	|		|			|
>     We need to free that range of reserved space.
>     Qgroup reserved data space: 104K - 84K = 20K
> 
>     Now there is no way to release that 20K unless disabling qgroup or
>     unmount the fs.
> 
> [FIX]
> This patch will fix the problem by calling btrfs_qgroup_free_data() when
> a page is released.
> 
> So that even a dirty page is released, its qgroup reserved data space
> will get freed along with it.
> 
> Fixes: f695fdcef83a ("btrfs: qgroup: Introduce functions to release/free qgroup reserve data space")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This seems backwards to me, and not in keeping with the actual lifetime of the 
changes.  At the point that the ordered extent is created it is now in charge of 
the qgroup reservation, so it should be the ultimate arbiter of what is done 
with that qgroup reservation.  So fix try_release_extent_state to not remove 
EXTENT_QGROUP_RESERVED, because it's going to get dropped elsewhere.  Thanks,

Josef
