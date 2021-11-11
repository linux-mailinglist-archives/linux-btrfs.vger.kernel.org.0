Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC5844D837
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 15:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhKKO3Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 09:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhKKO3Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 09:29:16 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E57FC061766
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 06:26:27 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id e64so3352588vke.4
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 06:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R/CuNq6orK8U02qrMj9aZ/FkS9S0n/SmKIfHH5i+dTk=;
        b=NhlntobB/c07TBq6ruXuZi9C48iu1a5etffAbhUHUyXwp3/9bZ3XlZExpZWiFLeX0E
         A4/W+CFJpPOinaiy0YnE1Ge0ExwdaTS4PXZXPQZ/fLa552dCEDQIqQVVKIae/oOOIjOy
         Y96AE+JimAK/uxoM6aNKAqK5/7HavG0SFhKHUIfuDCpZfgcK6R3gH0Ooc6ZQZXraMDDl
         EvEdqpRFOzFrab/6eE8B2WWJg/Fc89dtSHd1HMxf4w3WA08BL8n8uK58HQdZy5fIF0/h
         U2rtwIZbvgSwq/dq1mnysvs5DHekYxC4iXHx6bJeqIj2wv35N1qDuE8+ci/W22dGIrhT
         eiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R/CuNq6orK8U02qrMj9aZ/FkS9S0n/SmKIfHH5i+dTk=;
        b=GiGLkkousrWxmjELsclpvsrghy1Uhm5w6XFUMsopnRDjZ9tF1Ns/wHi1flIJlcM2Zv
         t/sl+Jkpv+NUMFdC7pEYybSz0o3KXyHVH5IDv9rAv/ojKItxGkRSue2PTnWFT7eNsc7n
         CFRo/62n+SV+RnJZeEw595uyrjhK96vBu77ZM/93v7tJljXLmRcz9kqFZrWXugkU6lp8
         W5tsKM/NJ4QitPdj/bb/+cfHnhDwk1tgDywaTMMRKSunXMHriYbVIFLBcTqRP8Mb6eeh
         wJao0/U9E0f1xVR4qCvgBhQwWLc5HX6YBO5zGRbS5B15nkFUMZv4X55bcnmgf7m4FKWB
         Dbaw==
X-Gm-Message-State: AOAM533jFCb7pQ+8i8SOvW00IYM1d9p/Upxc1odWNgp/tJvNNmQcIVpY
        EfJcWhAQwQhEGzPRBKm/p9B3C9VO6n8=
X-Google-Smtp-Source: ABdhPJwTWbycprXT1oQnYApEajzFxu2GO4LD1ebUXrSZa9/71aSkYb44MtoFjeHpwx1xYyUXBXlMiw==
X-Received: by 2002:a05:6122:201e:: with SMTP id l30mr11795064vkd.10.1636640786060;
        Thu, 11 Nov 2021 06:26:26 -0800 (PST)
Received: from ?IPV6:2800:370:145:9a30:6737:e27b:1ad4:800? ([2800:370:145:9a30:6737:e27b:1ad4:800])
        by smtp.gmail.com with ESMTPSA id c23sm2123331vko.8.2021.11.11.06.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 06:26:25 -0800 (PST)
Message-ID: <92cb15b5-e97e-10ea-acc2-fc5c1510cb38@gmail.com>
Date:   Thu, 11 Nov 2021 09:26:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Firefox/88.0
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
Cc:     Rosen Penev <rosenp@gmail.com>
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
 <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
 <179e61f7-82c9-0a5f-1a05-7c0019b4f126@gmail.com>
 <76156d73-9d4c-a473-4dd2-105a905d3d1e@gmx.com>
 <c94ecfa2-752b-9952-9483-ae3dd04f6c02@gmail.com>
 <a5e0ebf7-68d5-9a2b-f053-4392106bb9f9@gmail.com>
 <CAKxU2N9hC8ha-M1RV27Km3p24t2Dg32t0B9JEbbStr1i+s0BqQ@mail.gmail.com>
From:   "S." <sb56637@gmail.com>
In-Reply-To: <CAKxU2N9hC8ha-M1RV27Km3p24t2Dg32t0B9JEbbStr1i+s0BqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/11/21 01:20, Rosen Penev wrote:
> On Wed, Nov 10, 2021 at 9:25 PM S. <sb56637@gmail.com> wrote:
>>
>> Oh, and I forgot to report that memtester didn't find any errors. I ran it one more time too, I think I managed to request up to 210M before the OOM-killer intervened:
> I bet the actual issue is some 32-bit problem...

That's what I'm thinking too.
