Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A95C2323A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgG2RrR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 13:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgG2RrR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 13:47:17 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70938C061794
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 10:47:17 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b2so676073qvp.9
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 10:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=n8PPXnw0/kPN3rOTipgu8z60LFjYMDQJETK+C5o3u20=;
        b=m2AFJzBz/1NX0dY7Z25rLNn1Ngs8s4LWXrsCBaYfbaMsJjBkbUUTiWN2FY2lutopjA
         nZHZt8Nknx+uTRNGrzt4+AFinBopOxP7k2FVZLjPRXnqW5IeVjRnjGRgctRFeNu04fJl
         2bE815b3muVKL0EHgAOIUENPQ4+IWDBu0895KikJ+LKBzHkofqhUysVi3aFewsvjMoHD
         kU1XvNpsYasNJvolJB3wOLRBMrwV26lEYdsWedvzG+BNxxkvaK/BTsqOF2SJlBZdLQUb
         PWXeg4IQmGwpWU5cXB/vh/TXsDVevbe36eyahhz+oFLgydGcLlbCVyzJnnwuPWzffvRV
         kgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n8PPXnw0/kPN3rOTipgu8z60LFjYMDQJETK+C5o3u20=;
        b=TuaE+VGim3jjIBbA/0EBWX/BXDLQjx6S7G05a+rnefm+7Osomw9VQKHETF6yLSBa/7
         skmdIO24P6gYPQA0k0uS9/R8eNNcWjv+7NNoU0gysCMlc/S3bOv0UltmZI8aNlcomqAJ
         QZkuDpi9ggjEPJU1OltAyqiM3nDaG7Q6tYGKZ3kkTqOsLIXa7YK1v/CbohJN3SBzj0zY
         G15GUp+/+qXL1N7DnAg1lYDlinzTrWHaUg56pC7Nrma/JvY1xC/RsIELQsd7VbOmBlsD
         Wl8fyaUAJc5IpJo1yC+ywMvhpuXrkIS/CM4PtIfnaG2V8mBra6VSbUOhfZnfd1mPqs2P
         WqNw==
X-Gm-Message-State: AOAM531ZGIP4cP3GzENBmreH3QK7k0+HV2UaC7gKmzgGl/d85+xwlY9O
        VPhza04pu5m9w1y4dughEfiZ99D47yKeEA==
X-Google-Smtp-Source: ABdhPJxTq65tiTqL+u6sZmSj4+MJ3nIl5GdgIi7OWNrM06TkYEzu+IlgjoPISYuUPtTkC0tKGY8qEg==
X-Received: by 2002:ad4:46e1:: with SMTP id h1mr17169251qvw.129.1596044836482;
        Wed, 29 Jul 2020 10:47:16 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::10a7? ([2620:10d:c091:480::1:2ed9])
        by smtp.gmail.com with ESMTPSA id k5sm2149117qke.18.2020.07.29.10.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 10:47:15 -0700 (PDT)
Subject: Re: [PATCH] btrfs: indicate iversion option in show_options
To:     Eric Sandeen <sandeen@redhat.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200729164656.7153-1-josef@toxicpanda.com>
 <48ad9fc0-dbdd-60f3-c1ab-f0152f6e3230@redhat.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e8a98d4d-505f-de47-d469-c0cdaac5351c@toxicpanda.com>
Date:   Wed, 29 Jul 2020 13:47:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <48ad9fc0-dbdd-60f3-c1ab-f0152f6e3230@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/29/20 1:42 PM, Eric Sandeen wrote:
> On 7/29/20 9:46 AM, Josef Bacik wrote:
>> Eric reported a problem where if you did
>>
>> mount -o remount /some/btrfs/fs
>>
>> you would lose SB_I_VERSION on the mountpoint.  After a very convoluted
>> search I discovered this is because the remount infrastructure doesn't
>> just say "change these things specifically", but it actually depends on
>> userspace to tell it fucking everything that needs to be set on the
>> mountpoint.  This led to the fucking horrifying discovery that
>> util-linux actually has to parse /proc/mounts to figure out what the
>> fuck is set on the mount point in order to preserve any of the options
>> it's not actually fucking with, so in this case iversion.  If we don't
>> indicate iversion is set, then we get iversion cleared on the mount,
>> because util-linux doesn't pass in MS_I_VERSION as it's mount flags.
>>
>> So work around this fucking insanity by spitting out iversion in
>> /proc/mounts so we get the correct flags passed to us in remount.
> 
> Hmmm:
> 
> # mount -o loop,noiversion btrfsfile mnt
> # grep btrfs /proc/mounts
> /dev/loop0 /tmp/mnt btrfs rw,seclabel,relatime,iversion,space_cache,subvolid=5,subvol=/ 0 0
> #
> 

Ugh that's because we just set it unconditionally like XFS does, but don't 
actually pay attention to noiversion otherwise.  I'll fix that separately.  Thanks,

Josef
