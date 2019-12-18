Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88627124DEE
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 17:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLRQiW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 11:38:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35924 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfLRQiV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 11:38:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id a203so2453943qkc.3
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 08:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sbHXKAlGtJ4WoF+Wk5BJ7Ni9B2+fY69RTFn/n1ttSO4=;
        b=S2234Y6PzoYiAKpG5kfvgExKO7U4AEEPbmh0zbW+1C8PjTfHk/M7SihyDv5d7vq+Ru
         NArec1JjWWgRz8TRt7gvAmwkrhVxatpifjGd6KEal21z6iBnXvuaJpa8p2rgdska4HR8
         Vn1IWYv7095dx+9vEd1cUadyqjeeepD8aTciCzCnaWuF+oAzgmeS5QjeNn5Lmn37yzYh
         fx8cbejQT9OMRW+IDdq/E8ZiCAOt/V/VrtYz1g2GV3t5tROmmRq6/XCUz1KiqHH2I6V6
         egDx+E2dG2bhwjzHMvecHlewS40PCe32Ce/P5nAKGuyQaOZt6MhqmyR/N26znSJNXPBS
         zLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sbHXKAlGtJ4WoF+Wk5BJ7Ni9B2+fY69RTFn/n1ttSO4=;
        b=IVWM5qiflHfA2VYba3+5eezMVon2lLoJePqvBYy4+nAmsoY7OGqgk89zaDOPChPa14
         8mUXGFdKhoNZ5Y+R/6NqBKEZ5suMdv0VWAhViH9RCVIg1eJU/6NBJsoQd7dwigJvwzwM
         yos9LpK18NCHhg0c5I1Itfo1oq4jfIgQIlBqa+NwJf4WQFhv1103hz8ciUYdTCRP864s
         NNTw6iuWfQ+AkcwCsELvW1sn6OSriHBZbnfTtXBPomPZjeQB2DTbMhasRdeK+i2ZSqia
         1TyeVVcNkej6XxMrVssRFOdKp2DgJN9/BW5i0C4quj9vPRKJqllS6JwuEqD5pvAzL4hZ
         S3pg==
X-Gm-Message-State: APjAAAWSg+HlRRI/zLr80gU8JaHWaD75h1aVwn9tIgltC1g/tlt5nl7n
        ZbBOckTTkrJOBDsyCLZ/yRCs2A==
X-Google-Smtp-Source: APXvYqyi2DFONj1cNsqdqMvZd0EqSNs+bKVIC10ca2hMoPkHA/RPLR03EXtJv64Xk3ZmkgCRZBu+Tg==
X-Received: by 2002:a37:644:: with SMTP id 65mr3542626qkg.309.1576687100662;
        Wed, 18 Dec 2019 08:38:20 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::65a1])
        by smtp.gmail.com with ESMTPSA id q126sm812880qkd.21.2019.12.18.08.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 08:38:19 -0800 (PST)
Subject: Re: [PATCH] btrfs: remove BUG_ON used as assertions
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191215171237.27482-1-pakki001@umn.edu>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2f9d6549-47cf-fb71-3bff-50b51093e757@toxicpanda.com>
Date:   Wed, 18 Dec 2019 11:38:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191215171237.27482-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/15/19 12:12 PM, Aditya Pakki wrote:
> alloc_extent_state_atomic() allocates extents via GFP_ATOMIC flag
> and cannot fail. There are multiple invocations of BUG_ON on the
> return value to check for failure. The patch replaces certain
> invocations of BUG_ON by returning the error upstream.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

I already tried this a few months ago and gave up.  There are a few things if 
you want to tackle something like this

1) use bpf's error injection thing to make sure you handle every path that can 
error out.  This is the script I wrote to do just that

https://github.com/josefbacik/debug-scripts/blob/master/error-injection-stress.py

2) We actually can't fail here.  We would need to go back and make _all_ callers 
of lock_extent_bits() handle the allocation error.  This is theoretically 
possible, but a giant pain in the ass.  In general we can make allocations here 
and we need to be able to make them.

3) We should probably mark this path with __GFP_NOFAIL because again, this is 
locking and we need locking to succeed.

Thanks,

Josef
