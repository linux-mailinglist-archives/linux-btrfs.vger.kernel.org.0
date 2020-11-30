Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD882C871E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 15:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgK3OvC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 09:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgK3OvB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 09:51:01 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D5AC0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 06:50:16 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id f27so8272088qtv.6
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 06:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+e/T6dFs7ooLgGuU4/j3JHvQstMVstI8GE6kboTtREs=;
        b=jFuWPTpvE6ibgRtzfA+qcbf+qe2vLkQrts52OAkY9aPN/HZ3pjMRWmjx6KkYM8CWrT
         SwA6qkSEWyeOscOp2xZ3KjxruucICBoSzTeb70Oc9xfm0X+/NyEyb5RGiuu1T/BP/o0a
         K0CJa/FUCZvyTc4YeRvsv5XWJqIVVtsXpmB7br5Pycjk8Ew/WIwWxFIpqDYc36KnLdbr
         7bdZ9eduMJenWAJceEuVvefecQ3asT9IufZnJNw8VkhbYGzFTSdpRlZjQ0UVFRm3T2Dc
         ewQ8G/+ieW7iLRUiC/b4ns5DXWflJfLdii1kZ7gg7eUhd0150emlyi/uPCe3vRWM78x/
         6tGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+e/T6dFs7ooLgGuU4/j3JHvQstMVstI8GE6kboTtREs=;
        b=sD2fxYCSFK3j6umCa+DaM7E1Uu1znYEJdMVsRv9xckdArY+oQeuqvpMO0Piyce+ols
         YbZee/LxG6RfGmsTixm+2mYuMnferQIugzkrgivnfTCT9P7lZy3MzehwrwhDYG+eyC1M
         KlHAvIlyxyvno1eVyGSXPECVoYA47nhaMtxE0xO5kje3e0+Bvl69j5UMEJWeXwpGAttR
         G446kZx7ey5SfjNdxC8t7kAeR/00e3apQjsFUbGo8nyC7aAZBxJuruZ7ptovnU7w8WKI
         TPtBnt2MJpqjM19igncRHl7Scek/ymRToreN/UqO4sex8XNqvbK/oB1clMDccKctl/Gb
         Ojjw==
X-Gm-Message-State: AOAM533xrCmqGdM7Ze2rrWwh2nmZ1RXR3ZtHeI4cGjx00MxUMCJIqVaV
        +E2yIcV0PAW//D8NM5JrGt1HVf7UPP6X8g==
X-Google-Smtp-Source: ABdhPJz8lOh7u9mtTaIJ1xejE85uZ8dQl5TMCVkK17wqUufbeB0vjVziy1xlsWCciUmPOIxQ5aLXxg==
X-Received: by 2002:ac8:7395:: with SMTP id t21mr22439401qtp.358.1606747815127;
        Mon, 30 Nov 2020 06:50:15 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v9sm15558265qkv.34.2020.11.30.06.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 06:50:14 -0800 (PST)
Subject: Re: [PATCH] btrfs: do not allow -o compress-force to override
 per-inode settings
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <a3cd057e747862eb7027ac6318bd26c6c36e0c49.1606743972.git.josef@toxicpanda.com>
 <20201130190805.48779810@natsu>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b92d0141-f68f-ce96-8099-e145ebc6f594@toxicpanda.com>
Date:   Mon, 30 Nov 2020 09:50:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130190805.48779810@natsu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/30/20 9:08 AM, Roman Mamedov wrote:
> On Mon, 30 Nov 2020 08:46:21 -0500
> Josef Bacik <josef@toxicpanda.com> wrote:
> 
>> However some time later we got chattr -c, which is a user way of
>> indicating that the file shouldn't be compressed.  This is at odds with
>> -o compress-force.  We should be honoring what the user wants, which is
>> to disable compression.
> 
> But chattr -c only removes the previously set chattr +c. There's no
> "negative-c" to be forced by user in attributes. And +c is already unset on all
> files by default. Unless I'm missing something? Thanks
> 

The thing you're missing is that when we do chattr -c we're setting NOCOMPRESS 
on the file.  The thing that I'm missing is what exactly we're trying to allow. 
  If chattr -c is supposed to just be the removal of +c, then btrfs is doing the 
wrong thing by setting NOCOMPRESS.  We also do the same thing when we clear a 
btrfs.compression property.

I guess the question is what do we want?  Do we want to only allow the user to 
indicate we want compression, or do we want to allow them to also indicate that 
they don't want compression?  If we don't want to enable them to disable 
compression for a file, then this patch needs to be thrown away, but then we 
also need to fix up all the places we set NOCOMPRESS when we clear these flags. 
  Thanks,

Josef
