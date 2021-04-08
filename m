Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8C93587A7
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 16:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhDHO5q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 10:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhDHO5p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Apr 2021 10:57:45 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB17C061760
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Apr 2021 07:57:34 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y2so1584326qtw.13
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Apr 2021 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2Vx0rx4mb9BAQdFic1ksIEu8CDh6liJzmG7ndwItOFI=;
        b=zC3wTf6+Dsjy4z1pEpO4IPdYvZOAPiA9JWX5yI/2CMqMc4qmH893g/Q8xn4mQX7krE
         keDBitnFH+H7GvIreloK94W66lYTSUKcw58JQjFc7aB3PY/GLmkVzBOKJFr4ypOaMR7v
         bq4H5JRPNgt2NBMvBXSHb1wj/XwiggNVH3FS/RGhCd8qZjNYLXqwq+Oe4eV33Pexanpo
         X1ypCC8IntF57g0JZcQtUb3k4ofyUx6dp61Kee6Jq+pHRyZX6ET/W8LIl1NfsByr1YXs
         SEcME0nup6Qnt3gtg8jpKDs4ArLrX3lY1rt4F+Vk7ECItlmLP+hQ/nfc9lfjvKLcARZT
         Ah1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Vx0rx4mb9BAQdFic1ksIEu8CDh6liJzmG7ndwItOFI=;
        b=qIOBpqvm47XmfOVSLug3ijbCGS9I6lisNSdEZA/AQdrA6lvNi46NPSfLQdpeAztxSs
         f8AsUPRhQuPxO4FTgGCZpGn+V1bdqwqOCdCP46Qhk53KjDov1jbw4oWf6qj7ao4c3zHI
         GLnp8Mx0oVMeAzSTxJfNQpDwKKMJUgoqxz1ZZZpUvwW3nqcFE7FC9SPFeC2qRMXXZEtX
         bd+y4dHAFZ8m2BcWHdt7x0KTVZLO5CHMALkFo03OjvkUiHlBFVI+90Nn2cKngd4jiJVP
         5978D7iTez+8Km9nnfwGYfQJJqc2J+90f29L1meD+dObVLDzJNSg2SIubGdZOULRnGXr
         QnDg==
X-Gm-Message-State: AOAM533dM1HLvbQlmJWe8mj0ppjJv/jSuN5rVITdvUq2D+k5w/cBCozq
        lTzof17nGjcjl8tMJryaKIPtMA==
X-Google-Smtp-Source: ABdhPJwNteOrRWIDqyNsQNDuwpJkpp/vQw8R4eD1WB2nMno4tOW+iBAQ1UVOsvKLl5AFI3pZVnJ5hw==
X-Received: by 2002:a05:622a:18a:: with SMTP id s10mr7714207qtw.237.1617893853691;
        Thu, 08 Apr 2021 07:57:33 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e13sm495318qtm.35.2021.04.08.07.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 07:57:33 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: zoned: move superblock logging zone location
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <2f58edb74695825632c77349b000d31f16cb3226.1617870145.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d22f8dfc-5ca4-4dab-2733-61563475a4a5@toxicpanda.com>
Date:   Thu, 8 Apr 2021 10:57:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <2f58edb74695825632c77349b000d31f16cb3226.1617870145.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/8/21 4:25 AM, Naohiro Aota wrote:
> This commit moves the location of the superblock logging zones. The new
> locations of the logging zones are now determined based on fixed block
> addresses instead of on fixed zone numbers.
> 
> The old placement method based on fixed zone numbers causes problems when
> one needs to inspect a file system image without access to the drive zone
> information. In such case, the super block locations cannot be reliably
> determined as the zone size is unknown. By locating the superblock logging
> zones using fixed addresses, we can scan a dumped file system image without
> the zone information since a super block copy will always be present at or
> after the fixed location.
> 
> This commit introduces the following three pairs of zones containing fixed
> offset locations, regardless of the device zone size.
> 
>    - Primary superblock: zone starting at offset 0 and the following zone
>    - First copy: zone containing offset 64GB and the following zone
>    - Second copy: zone containing offset 256GB and the following zone
> 
> If a logging zone is outside of the disk capacity, we do not record the
> superblock copy.
> 
> The first copy position is much larger than for a regular btrfs volume
> (64M).  This increase is to avoid overlapping with the log zones for the
> primary superblock. This higher location is arbitrary but allows supporting
> devices with very large zone sizes, up to 32GB. Such large zone size is
> unrealistic and very unlikely to ever be seen in real devices. Currently,
> SMR disks have a zone size of 256MB, and we are expecting ZNS drives to be
> in the 1-4GB range, so this 32GB limit gives us room to breathe. For now,
> we only allow zone sizes up to 8GB, below this hard limit of 32GB.
> 
> The fixed location addresses are somewhat arbitrary, but with the intent of
> maintaining superblock reliability even for smaller devices. For this
> reason, the superblock fixed locations do not exceed 1TB.
> 
> The superblock logging zones are reserved for superblock logging and never
> used for data or metadata blocks. Note that we only reserve the two zones
> per primary/copy actually used for superblock logging. We do not reserve
> the ranges of zones possibly containing superblocks with the largest
> supported zone size (0-16GB, 64G-80GB, 256G-272GB).
> 
> The zones containing the fixed location offsets used to store superblocks
> in a regular btrfs volume (no zoned case) are also reserved to avoid
> confusion.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Thanks Naohiro, this makes it much easier to understand,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Dave, I know you're on vacation, this needs to go to Linus for this cycle so we 
don't have two different SB slots for two different kernels.  I don't want to 
disturb your vacation, so I'll put this in a pull request tomorrow to Linus.  If 
you already had plans to do this let me know and I'll hold off.  Thanks,

Josef
