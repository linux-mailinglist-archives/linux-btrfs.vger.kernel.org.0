Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8B1A9BEE
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Apr 2020 13:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896832AbgDOLPk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Apr 2020 07:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896826AbgDOLPO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Apr 2020 07:15:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D06C061A0C
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Apr 2020 04:15:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z6so18542162wml.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Apr 2020 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PZcgfE7EJkAoWFHO9zrorc0YS7vtu9wk5BHGqD7tZTY=;
        b=UiEKSTO43+2isFk+VqIalLMvbLZTR8d4az349WCyEVsLT7JpEdGDVXmHRf5oDgu3RW
         drLWSdzG7mGtzcrrXac9uc5d58kkppK3J8OGiL78YZrCf4/Yuzl3J8VnZm8yUxY9N//P
         UP1DvhcqgW9wy19mOqcSxeB2k/vdNtpsGhowK9yDsz2zqdQRHfINYSZAPsrbnHYQFsKF
         3frJ0GjLv8K5iVgRkZm6VYJc05oV33uuKadwUtriFYGcbBVQKVLE5W1szi1vkUQDIgAL
         oqdpdZPcZaziJtQeKZ/PDUYBLDDZrfJ8TnWL6EjBMe2JBkdkHndUlGX8LPe+OVRgi3iP
         gpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PZcgfE7EJkAoWFHO9zrorc0YS7vtu9wk5BHGqD7tZTY=;
        b=RuR6yE7BjVpP1dMI8OY/l2o9FFMC5pZwwzPm1C4mF3bztDmlNXF3HpWY4bt7p7Luup
         o5nQ0XtTTCR+riho5weiZDP2biuOPf2QtK+qPDPe7ILIc8vkLMULqtqgQt+JRSqCs2MO
         yzRo77sA+ziGD7dJyAPKj1D+HkHViNF9x949LXiCrhDp64rpdlZd4qAIa4N8wr12BepB
         ZBg/vExuhyPWxDw5chXRQv3YTdRMiYDXjYtOziuoV0z7htjIT0Eo94GbHM5RQ9B+1spb
         07n0fpa9MU7eGATaj6QFSewAZW8dzSvIQYHpFkyfNjgfFBfe52UDjKvC5TozaVVTMLLT
         7G+Q==
X-Gm-Message-State: AGi0PuZ1W4o/OcI2wcyjSxtDjsdZOTppOruJEWjYspbqE45Xw3Z2O2FD
        qdBz0bwoHiNlaLfTJQYFUfMsSKYN
X-Google-Smtp-Source: APiQypKRtcAY31oCrzVYIyq5BAf4NwdTUITfkyXfVW61JOAPDrvutADvobYyYQ2wtZX7C+5S1OVh7A==
X-Received: by 2002:a05:600c:4096:: with SMTP id k22mr4369503wmh.99.1586949297591;
        Wed, 15 Apr 2020 04:14:57 -0700 (PDT)
Received: from ?IPv6:2001:984:3171:0:126:e139:19f1:9a46? ([2001:984:3171:0:126:e139:19f1:9a46])
        by smtp.gmail.com with ESMTPSA id q10sm19214873wrv.95.2020.04.15.04.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 04:14:56 -0700 (PDT)
Subject: Re: btrfs freezing on writes
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <6a1c8ce0-ce2a-698d-dcc6-0657a125dae4@gmail.com>
 <20200409043245.GO13306@hungrycats.org>
 <e1ed482f-158a-650a-f586-d8ad0310157d@gmail.com>
 <20200409230724.GM2693@hungrycats.org>
 <a4c5fcd2-c6cd-71e2-560e-9c7290e0c47d@gmail.com>
 <20200411202134.GN2693@hungrycats.org>
From:   kjansen387 <kjansen387@gmail.com>
Message-ID: <920dd953-74b5-2ab5-ed10-7e9d9c18ec26@gmail.com>
Date:   Wed, 15 Apr 2020 13:14:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200411202134.GN2693@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

OK thanks. I did try 2g on top of 172g, that didn't work, but after 
playing with 'limit' it did, all disks now have 3GB metadata.

On 11-Apr-20 22:21, Zygo Blaxell wrote:

> The purpose of resize -2g was to make a little less unallocated space
> on one drive compared to all the others, starting with all the drives
> having equal unallocated space.  The purpose of resize -172g was to
> make the extra unallocated space on sdd go away, so it would be equal to
> the other 3 drives.  You have to do _both_ of those before the balance.
> Or just add the two numbers, i.e. resize -174g.
> 
> If you really want to be sure, resize by -200g (far more than necessary),
> then balance start -mlimit=4,devid=4.  The balance is "I know there are
> exactly 5 block groups now, and I want to leave exactly one behind,"
> and the resize is "I want no possibility of new block groups on sdd for
> some time."
> 
