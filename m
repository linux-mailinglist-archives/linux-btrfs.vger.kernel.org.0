Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905B4251E50
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 19:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHYRbT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 13:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgHYRbR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 13:31:17 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEFDC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 10:31:16 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cs12so5883872qvb.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 10:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=am3xhiU0tY8+u6EJoa+V36GkJ31WEx/kwEjSvfFxVRc=;
        b=FhLYESQxXuuh14wxs3g8qm1wEaIQqyb4fAXJPJnEtNmKMJ29MiqPtsCop+aOVuEbAk
         gVlt/pSqJKFGXxWde7rtKgf0qoi2GVo3Tw0PuCAFuY+XuA4lWn/NJvJjnx64fyRJb31N
         SyClHtvTQGg11rjcGc9RmtI4xq7PHoIUrtlk4KeCdvF79d4y7+5+F5jvpqTbapK3jVtn
         NrUboaONZBmYVSp8dNcw7kfkrUJ17rAY+xJUd/uYDZrUhWzmr2ACITB9Evtik95dNGfq
         k7SG/qNxPghGEFuD/c9BZq4NBLpkl8Cc/3d4BZ29SP6GdjADyMjy53BneQmWbxVOc+oM
         fhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=am3xhiU0tY8+u6EJoa+V36GkJ31WEx/kwEjSvfFxVRc=;
        b=NtiSTVMOXnQkA6EeZfCjjhmVoM3C7L5WQW4G7tz8Z8FM2e+NzP3tH/9gRNF5w4qbVL
         SGg0OzP5Dv6V1cVlIX+fnojSwlHMk9ftLny1BBmeVq7qV0y2K7BkSIvDp+wrRbpZtWNS
         ud3ylvjaEEgsHEV+vElEkrKLP2ePHK9jGbFFkVIPyyZL9NLXkJkJR1R1/a4FUwnvFwva
         amaytJ6NU28N2rNP5UpOHI2qUiZymRIn7cEcs3m9422hqa5q5z8cXqvgBvk1QNbDBpzR
         mlDHWTbJY66LSifK2HxiQ6r1qKDb3R9RJcvqQRqrPZEwVwzZ3JJ57ppFDjT5wkp8aQUZ
         9j6A==
X-Gm-Message-State: AOAM533T72oQ9Scd+RPkKzfgXKegZdWiiT4cK7SAT6nUFNUyXyWtPrYG
        NoJhcH8qqg33DXGCNPBg3ngvvA==
X-Google-Smtp-Source: ABdhPJxXsUHeUMmQ7cgIM4ESiPGn2yC6F5Fe1fuaipcLjuAfFVDy4vsQL5MlMFyuRLnGtRIjznBLsQ==
X-Received: by 2002:a0c:ffc6:: with SMTP id h6mr10602345qvv.251.1598376674703;
        Tue, 25 Aug 2020 10:31:14 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::1120? ([2620:10d:c091:480::1:4729])
        by smtp.gmail.com with ESMTPSA id t12sm12113077qkt.56.2020.08.25.10.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 10:31:14 -0700 (PDT)
Subject: Re: [PATCH] btrfs-progs: add a warning and countdown for RAID5/6
 conversion
To:     kreijack@inwind.it, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <164e102b2a6179f9af35ded962c11d780ccf8400.1598375602.git.josef@toxicpanda.com>
 <969bf9a2-6635-d7a4-a4b2-ae1fa28c73ed@libero.it>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fa964001-f247-4176-ffd3-d31acc6efede@toxicpanda.com>
Date:   Tue, 25 Aug 2020 13:31:13 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <969bf9a2-6635-d7a4-a4b2-ae1fa28c73ed@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/25/20 1:28 PM, Goffredo Baroncelli wrote:
> On 8/25/20 7:13 PM, Josef Bacik wrote:
>> Similar to the mkfs warning, add a warning to btrfs balance -*convert
>> options, with a countdown to allow the user to have time to cancel the
>> operation.
> 
> It is possible to add a switch to skip the countdown ? Something like 
> "--balance-raid56-i-know-what-i-am-doing". I am thinking to the developers which 
> are doing some tests

Yeah I can do that, I checked xfstests and there's only one test where we do the 
convert to raid5/6, so we're just going to eat the timeout there.  Thanks,

Josef
