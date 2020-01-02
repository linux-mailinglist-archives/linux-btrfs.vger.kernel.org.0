Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F4912E89D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 17:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgABQUs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 11:20:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44165 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgABQUr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 11:20:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id w127so31697580qkb.11
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 08:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=No1HWxNXIZLuXkmhCqpAdNeB8m1n3AHhzYJ6CjDjGvs=;
        b=t6qrDsOxQiSQYIOIFb8qawyg1OfbJMqp/Rk8Ni8on1MEze1HqTBO2rm5q/8BJztaGP
         XDpPzyG2okWBxHGZ2XGZ+s/WcDCOE1gR5L9oAoOVCuh5tIm5RnYwRYHEe9m5HI/2hlJu
         0eXXV3dwv5uC23JOB8HhxqYz/EfGrRILd5fyYfmtz3+J6k2atWoxmQRtc5UFrTjoVY3W
         +nlt35o9VVyYOm9IcFG8yTnd8HO+qHgTSE95sj8+il3pofDWdYkHC4xb4dvbvFvYKUyp
         Xeo03TeyMZZksw1C9GkOVQHELwZyNQrDBLUCLFwxzqaC4iJ/4ibbrysj/cYcXXajF/Ch
         dLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=No1HWxNXIZLuXkmhCqpAdNeB8m1n3AHhzYJ6CjDjGvs=;
        b=Tismgyxu9V/FkgyNccJZHrln960LTKR96l0JrL+h7JxcwBJBnBgvM7t98VRoOcesMc
         pyIsNz99Gn5WWQtsVUjGKiNqXBVPyld2azOb8+FcqPWrw9WWZaW6cKhC5Ea9ib/cWo5e
         nnSA8IjIp9rtDRHjKXf0KbiweaL35jSddt9Eg1XwkO5N6on4fw9UywaarXQ8Z2ANsrcb
         LZDgikSZdqnbzyeDKAStBrW0+YT7bH0A/Cpbvid/6UYTy3EXaunSzgsk2mvRgfTtHdeF
         RdPe/GthyboNGhkvxOlZpLgoYUOnOcy0lXnttT9dD3KWpGx2wZryaiP7s/aqpV4z7I98
         vpcQ==
X-Gm-Message-State: APjAAAXLeDS13BIOvEJNacFZVbMRZB5CZ9cRvmZs14m47ijZukSzXUVI
        LZR6O/NCqQexiDlZwSU9wYnD75U0geGfkQ==
X-Google-Smtp-Source: APXvYqyXGTC9K2+uS9SB2Zs1JZCwXhBGH/VjR0eevksAs0oZRcxhz+Fhe5smP8bFCvpbGITuC/5YZw==
X-Received: by 2002:a37:693:: with SMTP id 141mr66462361qkg.134.1577982045077;
        Thu, 02 Jan 2020 08:20:45 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::be95])
        by smtp.gmail.com with ESMTPSA id g18sm15169234qki.13.2020.01.02.08.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 08:20:44 -0800 (PST)
Subject: Re: [PATCH v2 4/4] btrfs: statfs: Use virtual chunk allocation to
 calculation available data space
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200102112746.145045-1-wqu@suse.com>
 <20200102112746.145045-5-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6b836ff3-29ab-9a06-b76f-114cb0a5cb5b@toxicpanda.com>
Date:   Thu, 2 Jan 2020 11:20:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200102112746.145045-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/2/20 6:27 AM, Qu Wenruo wrote:
> Although btrfs_calc_avail_data_space() is trying to do an estimation
> on how many data chunks it can allocate, the estimation is far from
> perfect:
> 
> - Metadata over-commit is not considered at all
> - Chunk allocation doesn't take RAID5/6 into consideration
> 
> Although current per-profile available space itself is not able to
> handle metadata over-commit itself, the virtual chunk infrastructure can
> be re-used to address above problems.
> 
> This patch will change btrfs_calc_avail_data_space() to do the following
> things:
> - Do metadata virtual chunk allocation first
>    This is to address the over-commit behavior.
>    If current metadata chunks have enough free space, we can completely
>    skip this step.
> 
> - Allocate data virtual chunks as many as possible
>    Just like what we did in per-profile available space estimation.
>    Here we only need to calculate one profile, since statfs() call is
>    a relative cold path.
> 
> Now statfs() should be able to report near perfect estimation on
> available data space, and can handle RAID5/6 better.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Can you put a comparison of the statfs call time for the old way vs the new way 
in your changelog?  Say make a raid5 fs for example, populate it a little bit, 
and then run statfs 10 times and take the average with and without your patch so 
we can make sure there's no performance penalty.  You'd be surprised how many 
times statfs() things have caused problems for us in production.  Thanks,

Josef
