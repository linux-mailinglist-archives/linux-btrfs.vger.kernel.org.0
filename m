Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CFB362242
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 16:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhDPOdS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhDPOdS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 10:33:18 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84743C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 07:32:51 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 30so13494421qva.9
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 07:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=L5yeDuaAJaTvALgUb2InTynTAv4uY3u1nPVRmQkC0C0=;
        b=sb78y4WeFnXdzNUm8GxNGBr9GXNxlYfHlVIxeacRmZjIbTtv8cg5+wPirtGeJUTvrY
         NDa6ZTrhYQIgkxo6h++ykuqvq93RHq7BL+1e6crNiKxhi1NXtqjP17mhfU1K5IenEIGI
         dPZr4TlN+mb1AjlrcJbYBDc5iLRRuTts+V/pvXmIQWaiA0syGrUxuxULinwDwaDM7LYl
         nupCDiLIU3L04QOWNk32XW9FZ1bEOUc29MZllE03RXmMit0elVeSmVhtVwTM6bu0lnzS
         q/ODFlSbNj96QG7IAp7m56Z3FTsBos+bzrdm933eKV57uFirCM6sHAbIyHm2ieltaghG
         JiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L5yeDuaAJaTvALgUb2InTynTAv4uY3u1nPVRmQkC0C0=;
        b=hHEZ/wlKg1FI9U14HbD2TxBObRDYt+QzwFsWj7sIH+ir8T6i4o/3iTu4gF4tb36T5D
         1A67V1lT03x64IF23US1ahfrocntoP5q9Xzrd1pPGUpPrdLMpAYj+DzgC2mh9i00o7hI
         kIbQzwg3toZqzm3LdYmePBYyehyi+GmWJJzXmGdT4XxnJ/FnU7upawM1wELuj7KbjUb3
         q0XqBQd707xCciiCFSeVtIVhYR3M4mYXlzhC+oCW9f/tCi0AIEOZfLZYmdDc0Zo7mr/l
         tR8GQ7Wso1iWBPFzIz5bDpx+ZJ3aioeBG3wLk8T2O3Duim4z++8okg83zELYqiNVzIze
         e69g==
X-Gm-Message-State: AOAM5336U4TdDYgrtnVMxGa+/Zol+eEn5z+G7Khca2U/K9nTLeC/ElSo
        Mer3wgl5wDos7pRBjZ2omJOcWLndZzk12Q==
X-Google-Smtp-Source: ABdhPJzPzeF+VEENbWKxDOCnnq31Z/ebOC7LJKQnawyk6RiuZnU6iThMTf0xWL6Q+kmI9WUJ838JUw==
X-Received: by 2002:a0c:c1c8:: with SMTP id v8mr8677748qvh.42.1618583570284;
        Fri, 16 Apr 2021 07:32:50 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f185sm4292847qke.61.2021.04.16.07.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 07:32:49 -0700 (PDT)
Subject: Re: [PATCH 10/42] btrfs: update the comments in
 btrfs_invalidatepage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-11-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1edc9d3d-3d57-e4bd-6c9f-6d56921c45cc@toxicpanda.com>
Date:   Fri, 16 Apr 2021 10:32:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-11-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> The existing comments in btrfs_invalidatepage() don't really get to the
> point, especially for what Private2 is really representing and how the
> race avoidance is done.
> 
> The truth is, there are only three entrances to do ordered extent
> accounting:
> - btrfs_writepage_endio_finish_ordered()
> - __endio_write_update_ordered()
>    Those two entrance are just endio functions for dio and buffered
>    write.
> 
> - btrfs_invalidatepage()
> 
> But there is a pitfall, in endio functions there is no check on whether
> the ordered extent is already accounted.
> They just blindly clear the Private2 bit and do the accounting.
> 
> So it's all btrfs_invalidatepage()'s responsibility to make sure we
> won't do double account on the same sector.
> 
> That's why in btrfs_invalidatepage() we have to wait page writeback,
> this will ensure all submitted bios has finished, thus their endio
> functions have finished the accounting on the ordered extent.
> 
> Then we also check page Private2 to ensure that, we only run ordered
> extent accounting on pages who has no bio submitted.
> 
> This patch will rework related comments to make it more clear on the
> race and how we use wait_on_page_writeback() and Private2 to prevent
> double accounting on ordered extent.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
