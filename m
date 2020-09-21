Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32904272918
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 16:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgIUOu2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 10:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbgIUOu2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 10:50:28 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BFAC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:50:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o16so15257410qkj.10
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ch+q2yT3PhvbcHLCWPrgiCC5mGh6Pcs+SHbQs7XiA8k=;
        b=D8ylqwdEQ2qeHUvmOwyA+1MJP1oNKoR+DFHgeEg6Au2siHpN4o/et1ctRetRxFOV95
         AvNMRtcGB/E61S19qBcB1qiIZ6+FdsEkszWZQJXfBI7m3JCOAkQOvVEhVb9J35jwU35x
         ObmB9+yH57vQm/5U6BZGZyH01pUyLfbDFOneBqO0KV3L4SBuXvw5IATheaXHvdVJ5tEX
         uTuCpNxRfAnDdVrf7QmZl9gFrTpGAgWgQPiDjtZMLUv534iHkKtXN5C59pI3lVUZp+wb
         Nikq7aqDWjnc8Ptq8FwpeUsuR5jjuvQyEKiQk2EYz8/quMPigLagv4JrosdyZc2Pr5Wi
         YDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ch+q2yT3PhvbcHLCWPrgiCC5mGh6Pcs+SHbQs7XiA8k=;
        b=jp/yiJqLiBbMPyVYd2DVwKR6rVB219nlKtLawRUe7OX0vwQK3yzR5ToDC3pVgoGFLX
         gcn+vW6pboa3GxJLmTft52/NtiXLAD6DLIGHZDd4BVwv8iM7R+hdKubF5AM5kuTyv9Tb
         pB2fQs+uQFRkbySfh0xonahdtGvhVzaqkN459g6uu2kJ2ScSLB/+Hoq6Dthy/Jg70Tdn
         8IXb7jVG9xSF3tipMoV/UjnpBISc8rzbQmBe+dtiRHrMMJuFmygwsNwJI7Vlt8e7bNIP
         NrMoq2ifTMCtnHCkrgSI+/SAqQW8lbYhfiVKiZoCQcXhRgI/XD7fNWqEe5mnFxOvnTXz
         YLfQ==
X-Gm-Message-State: AOAM532snwtGufE9OI49m1IZhTjYJubjvg3u+9Wn0MGA7OzN3mWqgy4x
        DTJcFcT2521M/cD6EHLgDmf7lg==
X-Google-Smtp-Source: ABdhPJzid8A0XFBshaTadsbqCv3MJsofRZrQgRPBc0ssfadz/Nvhv1oeDnZLKsHexWbqPG4Ik3Kq6g==
X-Received: by 2002:a05:620a:1107:: with SMTP id o7mr123471qkk.191.1600699827112;
        Mon, 21 Sep 2020 07:50:27 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f8sm9876520qtx.81.2020.09.21.07.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 07:50:26 -0700 (PDT)
Subject: Re: [PATCH 2/4] btrfs: use sb state to print space_cache mount option
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600282812.git.boris@bur.io>
 <e7fe51d3013637cfe2bc9581983468d5940fdce5.1600282812.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bae2283f-ed1e-d09c-55bd-afedabe9b3f3@toxicpanda.com>
Date:   Mon, 21 Sep 2020 10:50:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <e7fe51d3013637cfe2bc9581983468d5940fdce5.1600282812.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/17/20 2:13 PM, Boris Burkov wrote:
> To make the contents of /proc/mounts better match the actual state of
> the file system, base the display of the space cache mount options off
> the contents of the super block rather than the last mount options
> passed in. Since there are many scenarios where the mount will ignore a
> space cache option, simply showing the passed in option is misleading.
> 
> For example, if we mount with -o remount,space_cache=v2 on a read-write
> file system without an existing free space tree, we won't build a free
> space tree, but /proc/mounts will read space_cache=v2 (until we mount
> again and it goes away)
> 
> There is already mount logic based on the super block's cache_generation
> and free space tree flag that helps decide a consistent setting for the
> space cache options, so we just bring those further to the fore. For
> free space tree, the flag is already consistent, so we just switch mount
> option display to use it. cache_generation is not always reliably set
> correctly, so we ensure that cache_generation > 0 iff the file system
> is using space_cache v1. This requires committing a transaction on any
> mount which changes whether we are using v1. (v1->nospace_cache, v1->v2,
> nospace_cache->v1, v2->v1).
> 
> References: https://github.com/btrfs/btrfs-todo/issues/5
> Signed-off-by: Boris Burkov <boris@bur.io>

Dave already took this, but next time I'd prefer if we'd keep logical changes 
separate.  So one patch to change /proc/mounts, one patch to deal with clearing 
the free space generation field if we're not using it.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
