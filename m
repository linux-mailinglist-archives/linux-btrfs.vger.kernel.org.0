Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F098C41FA2D
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Oct 2021 09:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhJBHHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Oct 2021 03:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhJBHHI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Oct 2021 03:07:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6A6C061775
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Oct 2021 00:05:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m3so47025003lfu.2
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Oct 2021 00:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ouMtmNsvfuf9w/XQR6PYGX4r+B/1/ZVrMZ+0k722Zm4=;
        b=pcMJH/iSZC00tQpKOsVvUN48ePO5tIkA4aKCMOCYznMLQjAnHwsTYob+kVoJG0cBcu
         vGCqNRwrqlZr2IaSSZ0NdxULG/CIoJwR+4gXc/RgyaDgOb3Luv1QyxAlXtlBLWx+vSbW
         j8qnNdhSEeaRmvdKk1VF6DWxvDgZF4xE/RyJxt3l+R2Soye4jWPo9moftMEYif7X0zC6
         oO/uYYRbIW9v7kjvyqwdg3Z8GBowUTtA1awEwcFC2KjwtfqLuhK9flRM/dKKPgdEZYE/
         F9ShZNJIG7rw39gCnR6NZAqjVk+b+N7ofjGNfIQb1yarPUBCFkzJb1X36UhrFNdgyhBa
         quzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ouMtmNsvfuf9w/XQR6PYGX4r+B/1/ZVrMZ+0k722Zm4=;
        b=TOmF/ddBc2po/gsR4btXULxrPDGJYlANml/qEYvRB9pljkX856A3KPeO+t0cyln0xl
         43oJAkMQCT8LZHykYgkkFzrpXutYoNze2dFs3J4VmUeZs8yZ0RxTX1rqSWUaKj1Ct3Cv
         Nr1JBP95Ty5USodp+bpxH/iPRilXD0kEhykqNgbKiVFwI1H6WuajoOYaCmY35UxwEEqX
         Yi+7ugC8sUbwYM9Y9HLr1AHyTeuLKgwun08kRK9KBFm0T7OL+3vUZ/kbA9g1lwHobXgX
         TwTeM5X9qIR83lWMJUtaLLsv36uBqDolJm4aI6L0FTACUPWvb30bUaWhUhmHBZLVy8VC
         ae8Q==
X-Gm-Message-State: AOAM531KFaLB3OyQroFfprp8sg9niQSzuYKOlMtqqOxuwlbDu0tLtwWY
        qOv2HSdhvinlt/nkQgHJbb2OL3tHJnY=
X-Google-Smtp-Source: ABdhPJzVlNkgthK96Kh5kIOW/HHgGvRoMyymTBujFo+IEcTrsw1wECSZrhlCImJ5+AFcEqDT7zQVIg==
X-Received: by 2002:a05:6512:acd:: with SMTP id n13mr2440484lfu.247.1633158321430;
        Sat, 02 Oct 2021 00:05:21 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:ceb2:544e:22a0:6fa3:2d83? ([2a00:1370:812d:ceb2:544e:22a0:6fa3:2d83])
        by smtp.gmail.com with ESMTPSA id r3sm965307lfc.114.2021.10.02.00.05.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 00:05:20 -0700 (PDT)
Subject: Re: [PATCH 4/5] btrfs-progs: property: ro->rw and received_uuid
To:     linux-btrfs@vger.kernel.org
References: <cover.1633101904.git.dsterba@suse.com>
 <4c02eb0d00433fa95b77befecafcdf147c230f21.1633101904.git.dsterba@suse.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <cf04c434-c95d-eb88-770d-ca564a97dcb3@gmail.com>
Date:   Sat, 2 Oct 2021 10:05:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4c02eb0d00433fa95b77befecafcdf147c230f21.1633101904.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01.10.2021 18:29, David Sterba wrote:
> Implement safety check when a read-only subvolume is getting switched
> to read-write and there's received_uuid set.
> 
> This prevents accidental breakage of incremental send usecase but allows
> user to do the rw change anyway but resets the received_uuid in that
> case.
> 
> As this is implemented entirely in userspace, it's racy and using the
> raw ioctl won't prevent it nor reset the received_uuid.
> 

Is it feasible to add "force" flag to ioctl itself?
