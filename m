Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A65C44D174
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 06:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhKKFYy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 00:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhKKFYy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 00:24:54 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96743C061766
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 21:22:05 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id d130so2669784vke.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 21:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=0FTlh0wY3O4S9HXjs0b+8puaV01leOXbx9cF2RZwH6s=;
        b=oixk/KU+cuvZRIUECNvc6uLcOzRBd/0qR7h6tc8nwsu8s28KX5bvMSl2SJw2BWTE6J
         7590XjfqwkUaJIQzYi/dKyLusSliUfNvnZvYaxtEodxLwrBGbFxj3C9vahN+tiL+9oDC
         O3JYsON03XXQfPNZE6emM7kpRHCIYIorUjbgPEA/a5qc95dsZoFcQKQ0P2DZuJlChi+7
         L5F5A8hSPjqtxbeO/SQX3RA15X533wYIeyKcM916wU5RJ6855giKcHORUkvUbx0Yas3g
         3FY7qx//KexI9hX80uzgjMFDeb69WyXXJmx2qwQVy5wERup/fWTWYDRuW/qSVScNV3mK
         KB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=0FTlh0wY3O4S9HXjs0b+8puaV01leOXbx9cF2RZwH6s=;
        b=7RyXjdufEmRI7cw17h1j54rrNQyRs6SOS+ohVzx1E4xo8D+VUd9j4fOfUjx9ot4qvN
         C/jTkVHfV1ktoB6Y0mqk8f1uAvFk01pRTtBN6TGv6QFP+lWO4Zf85UZbsFHNqhMlXifk
         b6Zg8vXYzMcGo5PmzgmNc+YfUFK3eaqdA5RMZi0UaCauk/cxjvj+QwsKT42cFCMSGeqn
         B811nGMnQC0txrfX8KGb/NauW2TPdvfq7hYtY3iDPjt//E7riioekkdLVqWRHdIj6wHD
         Ei9Rlpu6GIBghs2C092SMXchg6Wz6cb1NYgFvG5WkE5r0osswE45X+CBk8aOTwoaT4mT
         wuYQ==
X-Gm-Message-State: AOAM533RkwB3VB9Ip4rhe4NZsEJJaSaxxfgT6eEh0iiKgmEghlBkhmLC
        EIK27uwlnLThOmOJjA6AmPMsXbcvVRo=
X-Google-Smtp-Source: ABdhPJwAo6Ha8oKWBrRxToLV6lt5z1EuVd2E/J85+xk9a0bbIbFudsfYhj7CWfH1sQKHEnXXNn/6Tg==
X-Received: by 2002:a05:6122:920:: with SMTP id j32mr7371210vka.20.1636608124180;
        Wed, 10 Nov 2021 21:22:04 -0800 (PST)
Received: from ?IPV6:2800:370:145:9a30:6737:e27b:1ad4:800? ([2800:370:145:9a30:6737:e27b:1ad4:800])
        by smtp.gmail.com with ESMTPSA id 6sm1445302vsd.28.2021.11.10.21.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 21:22:03 -0800 (PST)
Message-ID: <a5e0ebf7-68d5-9a2b-f053-4392106bb9f9@gmail.com>
Date:   Thu, 11 Nov 2021 00:22:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Firefox/88.0
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
Content-Language: en-US
From:   "S." <sb56637@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
 <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
 <179e61f7-82c9-0a5f-1a05-7c0019b4f126@gmail.com>
 <76156d73-9d4c-a473-4dd2-105a905d3d1e@gmx.com>
 <c94ecfa2-752b-9952-9483-ae3dd04f6c02@gmail.com>
In-Reply-To: <c94ecfa2-752b-9952-9483-ae3dd04f6c02@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Oh, and I forgot to report that memtester didn't find any errors. I ran it one more time too, I think I managed to request up to 210M before the OOM-killer intervened:

---------------------------------

root@OpenMediaVault:~# memtester 200M 1
memtester version 4.5.0 (32-bit)
Copyright (C) 2001-2020 Charles Cazabon.
Licensed under the GNU General Public License version 2 (only).

pagesize is 4096
pagesizemask is 0xfffff000
want 200MB (209715200 bytes)
got  200MB (209715200 bytes), trying mlock ...locked.
Loop 1/1:
   Stuck Address       : ok
   Random Value        : ok
   Compare XOR         : ok
   Compare SUB         : ok
   Compare MUL         : ok
   Compare DIV         : ok
   Compare OR          : ok
   Compare AND         : ok
   Sequential Increment: ok
   Solid Bits          : ok
   Block Sequential    : ok
   Checkerboard        : ok
   Bit Spread          : ok
   Bit Flip            : ok
   Walking Ones        : ok
   Walking Zeroes      : ok
   8-bit Writes        : ok
   16-bit Writes       : ok

---------------------------------
