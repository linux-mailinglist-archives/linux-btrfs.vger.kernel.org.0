Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4257B2500E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 17:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHXPXe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 11:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgHXPX0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 11:23:26 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD28C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 08:23:25 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o64so1589552qkb.10
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 08:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LBi0uJZ5vfgtPsij29TTrjQQZTRVGwTN+VztmFqYI4s=;
        b=dBWHdfZ1i4v4AB6nz+us8DEuOVvnKxL3ucJGCKNaNm5Am3NrdFYRN4b34ppJur3PSH
         WDH/Sk7xaC4BSTIfiPn5z8enKXBdZ/FWz9J/IYDyazfyIw7AtLvcmhKc77w5oJxfL+Ed
         tz4vchRjVFBGfeKLxmvZM4Ig0hYv8otduDgOtNRCXEzlmlWYRFepmmVLEy7fXsG8GFWZ
         IteCNoSB/BCYI4OrO6m65Y+cIUZ/o92NWZ56LNf5VCCSTVApQoxlo7ZoaYzQVYuxscfX
         aZGRQQ+cN1R8l/NRW/6c+f+6NWg8WYyblJ2f27BXBYXWSFaZq8Ggbg/LBOs0u2qltxRj
         C4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LBi0uJZ5vfgtPsij29TTrjQQZTRVGwTN+VztmFqYI4s=;
        b=FlizkfDc1cci6Md+Js2tNHm4dUNT01C3pQvgQ7oTt+TRu1gPrUoOkFeZInbBmYHzNP
         9slKSxklt6QVxo0uoAXA8WpXR0gp5yQYtEZpROGwbLlDwT60t0H4JdtylPuldlZqBOus
         wlUekf/AwXg3aRZiwQ+wQj5W2AJCqsfYnNQyOmpMZTcIp31ZfHf0RdpjmV80kviIU1iA
         jiSY6riNrCQISSR9pRHu87KlZmb7gQUpMw+oMu4u0xuj0pnRke3VmUzYSD3qG5mZgnep
         AJhPxB7uzPgFH9NNLp4X5ScOGj0cBqOhfstiokax97S22jBBrpmBbCYRbmQiC6TyBmYR
         WTSg==
X-Gm-Message-State: AOAM533o09P+01jTlBT7TpJeTIeEnPczWDC9muVVFQPBK7XLyxcJaIWm
        uNL/7JCib7nYPlePIJMMZ2k0MkexksRtN3ct
X-Google-Smtp-Source: ABdhPJw3u6ZOFjigTHKBa0hkc4BjFn8+gbhWoaqr1L6ubw78NLSqvlU0mFIdNaC+7t21YyQKuD81MA==
X-Received: by 2002:a05:620a:7e9:: with SMTP id k9mr5315027qkk.415.1598282604625;
        Mon, 24 Aug 2020 08:23:24 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n15sm9476304qkk.28.2020.08.24.08.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 08:23:23 -0700 (PDT)
Subject: Re: [PATCH] btrfs-progs: check: Fix error reporting on root inode
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200824140049.28633-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <21a70505-74c8-8153-4652-fc07cd4aa69d@toxicpanda.com>
Date:   Mon, 24 Aug 2020 11:23:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824140049.28633-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/24/20 10:00 AM, Nikolay Borisov wrote:
> If btrfs check detects an error on the root inode of a subvolume it
> prints:
> 
>      Opening filesystem to check...
>      Checking filesystem on /dev/vdc
>      UUID: 4ac7a216-bf97-4c5f-9899-0f203c20d8af
>      [1/7] checking root items
>      [2/7] checking extents
>      [3/7] checking free space cache
>      [4/7] checking fs roots
>      root 5 root dir 256 error
>      ERROR: errors found in fs roots
>      found 196608 bytes used, error(s) found
>      total csum bytes: 0
>      total tree bytes: 131072
>      total fs tree bytes: 32768
>      total extent tree bytes: 16384
>      btree space waste bytes: 124376
>      file data blocks allocated: 65536
>       referenced 65536
> 
> This is not very helpful since there is no specific information about
> the exact error. This is due to the fact that check_root_dir doesn't
> set inode_record::errors accordingly. This patch rectifies this and now
> the output would look like:
> 
> 	[1/7] checking root items
> 	[2/7] checking extents
> 	[3/7] checking free space cache
> 	[4/7] checking fs roots
> 	root 5 inode 256 errors 2000, link count wrong
> 	ERROR: errors found in fs roots
> 	found 196608 bytes used, error(s) found
> 	total csum bytes: 0
> 	total tree bytes: 131072
> 	total fs tree bytes: 32768
> 	total extent tree bytes: 16384
> 	btree space waste bytes: 124376
> 	file data blocks allocated: 65536
> 	 referenced 65536
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
