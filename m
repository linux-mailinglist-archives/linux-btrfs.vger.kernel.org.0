Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9257515205C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 19:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgBDSVE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 13:21:04 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:46382 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgBDSVD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 13:21:03 -0500
Received: by mail-qk1-f177.google.com with SMTP id g195so18883053qke.13
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 10:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qWQ2/l6mY3+RyFj6l43w4wSbZBuF4Ixr1q44j6cH9rI=;
        b=j2qbsJWN8YVrjo1gJh7CnEm+xhfYdiiD3jFVrAynjx4s0w2d/n2OXkhhYNXGC/Avrl
         86EDuqVL/lqhiEoQ6FwpNsb3zRx5iu/OA4zHTdZicb795cpZjK44YjlOWasQHdMHU74X
         OJiVvd7zCqyb2yxYGV9OSlwYwZRQ57KnFdC5V756HE068EfthGd4VS00etsRBYxwShVy
         fj3ugQ9f2yxses21ik7Vbz5k7G+6TyKWXRGtZ/M0cC6VJ/nyJKDffioif9cRag1He3LR
         utByF2BLjTZoc99blh6Tvz+68I29KpLwdOOhV5dwgtk9YGgd0rXfAiw8PwCAyAL52v86
         q7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qWQ2/l6mY3+RyFj6l43w4wSbZBuF4Ixr1q44j6cH9rI=;
        b=CwCoCGfFhiF1WuVHRZ7nTIguWnj9Wu40Cc1RasogkAyQf2AruCiZo5yrK1Pu9ASxko
         xW4g0h+97HKifXTwR/LNRRf2OS26Ap7JJinIUXTgb7LFfms/diKS3qkBqYbl5TZ2spy/
         c9o77N7lqOcZg9VklHLUpNPKAu1ZjRoIe6zBIAJ9B17dWjQ9T6whao2XMVSEuNaZJE5a
         tM9pU3dikfGX7HVodOsWBOqB/ktxhy+fVpKxJIs8kHAmRlGx6EFG14zsGr9mYZCC4ihW
         XDwk0ZdxrAlTH3u94YPrL20qOoCakWDgv8tOkNI1yritCTQWWJS4SbOwaDHTESeNqFCe
         0UaA==
X-Gm-Message-State: APjAAAV3zSudbrm19p74I26zoM3OjZru57hDx9QoI5O2TUa3LWGU6UAw
        nn3qHmJ84oho/2x+BfPti6I1lc8bH+hXOw==
X-Google-Smtp-Source: APXvYqzvv8mPtXX9lWmALwi/wGecvZO5JzHGRLm4XwGkjktPK7tqVBwwWKyJw5Oe4UrthiOPqzmMkA==
X-Received: by 2002:a05:620a:142c:: with SMTP id k12mr30055593qkj.207.1580840461131;
        Tue, 04 Feb 2020 10:21:01 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w1sm12445071qtk.31.2020.02.04.10.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 10:21:00 -0800 (PST)
Subject: Re: About stale qgroup auto removal behavior change
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <2dfbf017-9c82-1224-bdfc-73d0c0111e40@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4cc678c3-1472-1432-7314-53e22129f757@toxicpanda.com>
Date:   Tue, 4 Feb 2020 13:20:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <2dfbf017-9c82-1224-bdfc-73d0c0111e40@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/3/20 7:37 PM, Qu Wenruo wrote:
> Hi David,
> 
> This is the reminder of how we could handle the behavior change of
> staled qgroup auto removal.
> 
> [PROBLEM]
> If btrfs has dropped one subvolume, it will not delete the level 0
> qgroup automatically, leaving the qgroup still hanging there, with all
> numbers set to 0.
> This needs manual user interaction to delete all those staled qgroups.
> 
> [SOLUTIONS]
> There are several way to solve it, all with its advantage and disadvantage.
> 
> - Auto remove them by default, and no way to keep the the staled qgroups
>    Pro: Easy to implement (already submitted)
>    Con: User has no choice to keep staled qgroups. But I could argue that
>         no one sane would want to keep them anyway.

This should have been what was done in the first place.  Nobody is using qgroups 
right now anyway as they do not work, might as well do it the correct way now so 
when they are in use we don't have to worry about it.  Thanks,

Josef
