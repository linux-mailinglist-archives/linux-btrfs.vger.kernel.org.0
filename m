Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFE41FC254
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 01:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgFPXco (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 19:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFPXco (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 19:32:44 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9421EC061573
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 16:32:43 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dp10so172345qvb.10
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 16:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=J751bAyyLy3UrpT+hG0RJwX5/jzalty3iLsMBBScP5E=;
        b=QuSaGlUGJxWqMbY+wBVU9Id1LWKea6JxQdyWuzpkOeSWKFCOynvIZdfAdGy0NG2bU7
         kSpwYWYrXEZ0ju7aoy06cbc9thbN06Uwaac5hH5noTm5GrOL3/+JjqZEX9Xl1VCzZQjH
         5/4V/q+b4pxa//rUUrNZzUdRabHiUKln99bran78qeVrCp5m7jM+qzK2PUB0I7nNuYYG
         9aNt/wOrNU9fhZpJj+eNUtYwZDhJ2OyJ+Ppb8Oid4QIhvvwD6TZCvaeAm/rlspLsTORv
         /HDEraEtQ5BmTKALG3yz9t4rer4KTTmYpAsTVfyn36NQfjdW1ax81cZ4UrJZdEFEZH8g
         c28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J751bAyyLy3UrpT+hG0RJwX5/jzalty3iLsMBBScP5E=;
        b=rOMGABBWMspDPYlLOegnu+QIho8yRe8CCtRUzoM+5difX0J6t0YxaDuuUDW5kqhDJR
         zdaLnEUQLEKHNyEP4dwuVk9ZIn6UskRcyi/Kfh3Rt4gGp1hn76J0QZMt/VCkDCMfKep4
         xRX2nDq3uKH5+IDKwO6EiUxj7Ic/1j9dM8VFnLd1p/Xw2zrEH85qET5rUBzMJkX6utm4
         HcKhN5yiPVycTZox8MPZ5oD5HAK9jfBts4etXoHNZqNvFzc7ygFPZh+I14XJkQk8OxMv
         emwXsy7KjcXzO1Cc9osate/WCwjRcrpGvyO98N7sPSmEZy1K2wVUniRXoe7gwsISL512
         Zmxw==
X-Gm-Message-State: AOAM53326gCuIy+8uJ8sh9PVmjyJ7BGXFdUqeVPLsI5ZaeNaI2WA/k6m
        goI/v7tMie00Y94rLmZgdmfZ/Qx8vYyU9A==
X-Google-Smtp-Source: ABdhPJyww3tqv6jQpbugoeKZNjCaDFT/2gnF2V7vzPMlKxwlDw72Pf1PCElrxIBqiooLPpCTXG+Zlg==
X-Received: by 2002:a0c:ecc6:: with SMTP id o6mr4806934qvq.243.1592350362486;
        Tue, 16 Jun 2020 16:32:42 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::123e? ([2620:10d:c091:480::1:458f])
        by smtp.gmail.com with ESMTPSA id c4sm15517339qko.118.2020.06.16.16.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 16:32:41 -0700 (PDT)
Subject: Re: [PATCH 2/4] btrfs: detect uninitialized btrfs_root::anon_dev for
 user visible subvolumes
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-3-wqu@suse.com>
 <d17609b5-ac29-937c-763d-fc978e3f1bad@toxicpanda.com>
 <f1f940ba-3f1d-302a-0d28-5620286bcdc0@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a7417666-56a0-be6a-1691-e647802e1df7@toxicpanda.com>
Date:   Tue, 16 Jun 2020 19:32:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f1f940ba-3f1d-302a-0d28-5620286bcdc0@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/16/20 6:49 PM, Qu Wenruo wrote:
> 
> 
> On 2020/6/17 上午3:25, Josef Bacik wrote:
>> On 6/15/20 10:17 PM, Qu Wenruo wrote:
>>> btrfs_root::anon_dev is an indicator for different subvolume namespaces.
>>> Thus it should always be initialized to an anonymous block device.
>>>
>>> Add a safe net to catch such uninitialized values.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> Can we handle stat->dev not having a device set?  Or will this blow up
>> in other ways?  Thanks,
> 
> We can handle it without any problem, just users get confused.
> 
> As a common practice, we use different bdev as a namespace for different
> subvolumes.
> Without a valid bdev, some user space tools may not be able to
> distinguish inodes in different subvolumes.
> 

Alright that's fine then.  But I feel like stat is one of those things that'll 
flood the console, can we put this somewhere else that's going to be hit less? 
Thanks,

Josef
