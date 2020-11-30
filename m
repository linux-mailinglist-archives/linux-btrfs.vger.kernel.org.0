Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF2C2C8777
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 16:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgK3PNB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 10:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgK3PNA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 10:13:00 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B9AC0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 07:12:20 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id y18so11017584qki.11
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Qeucfy1cKydAGONR74TsZh2K2ZV0gRTH4n3sQ8hti9E=;
        b=cHpXrdok2u2UN4suDRuJSYPF35SWIKKxBfADJU9RWZkyBdVbwzLLGWTDY0DpAVIp5p
         1EUuoY11PzC+ceR13pudqP1/Ea0FmXFLdI06C97JKDcPSl6hSB5zY6XbdOUjlqw0YzM9
         ERbqICFNcws5Lp7l2ayEh5kmUIlkYOE54y9HvAr33BP+vgTpzICZlExdoEatJJyLwEgB
         70VsVKbS/L2xSYVBRxS5ueRUmddW+Cvu0Hr4mYfg3l87gkLx+HiFnymKwWpA4ni4Cpu8
         D8lJ05TnEIOK9UESYJNSONKe4p7yQJcjoNimM2tAWhCtymt5KrxGtizoiXo02QY6MXP5
         PBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qeucfy1cKydAGONR74TsZh2K2ZV0gRTH4n3sQ8hti9E=;
        b=NNWSkelKUHQRDi00ysH7K8GFtNJOVDv6S2H/Q72rIj9lVVUjieVkDLB6mLm53nUQ6+
         gUGYk4UTNw1PG9P9PC9KM/5J4i/WI7niQ5QuQO2mE7YLov/Bf8L+yOdYMNViUnhmLqJw
         UfVsQLBo4V9Bxffcz4GYRfvLgXOSA/ogfBMB4tQJpY5Ztud1pPIoqJZvolvh9uAyb0fh
         gLDzjRRKItqcnncoYoYhJzoW/OHBC8Vxk9dqShkqAZI5BXG9wKjoUHOsSL1sLwfdTlH+
         0BobFC/P9MA67Ihp+9OFW/HOHHuoUmBCXCL+Q/DL0paExFd4QPQIpjp2HtWM71LBiVVv
         fEHg==
X-Gm-Message-State: AOAM5323062lc16re1t7WcW3tQqYriP0EX4NOKsJIKmVNUeBHXY0IQqT
        KAtaSr3nnlvDXP52Hy7rtNJDm21Rygtr9g==
X-Google-Smtp-Source: ABdhPJwQEDFoMvxylQBuoRqO1TrL7hUA1CIikdEMc4iY8GUHtOjyKHL1LmwLqmZhaQR6jOUkITzW0g==
X-Received: by 2002:a37:6546:: with SMTP id z67mr23269585qkb.22.1606749139688;
        Mon, 30 Nov 2020 07:12:19 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n21sm15803845qke.32.2020.11.30.07.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:12:18 -0800 (PST)
Subject: Re: [PATCH] btrfs: do not allow -o compress-force to override
 per-inode settings
To:     Hugo Mills <hugo@carfax.org.uk>, Roman Mamedov <rm@romanrm.net>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <a3cd057e747862eb7027ac6318bd26c6c36e0c49.1606743972.git.josef@toxicpanda.com>
 <20201130190805.48779810@natsu>
 <b92d0141-f68f-ce96-8099-e145ebc6f594@toxicpanda.com>
 <20201130150409.GH1908@savella.carfax.org.uk>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d76c2f7e-6596-0f9b-26ad-074e21b1cff2@toxicpanda.com>
Date:   Mon, 30 Nov 2020 10:12:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130150409.GH1908@savella.carfax.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/30/20 10:04 AM, Hugo Mills wrote:
> On Mon, Nov 30, 2020 at 09:50:13AM -0500, Josef Bacik wrote:
>> On 11/30/20 9:08 AM, Roman Mamedov wrote:
>>> On Mon, 30 Nov 2020 08:46:21 -0500
>>> Josef Bacik <josef@toxicpanda.com> wrote:
>>>
>>>> However some time later we got chattr -c, which is a user way of
>>>> indicating that the file shouldn't be compressed.  This is at odds with
>>>> -o compress-force.  We should be honoring what the user wants, which is
>>>> to disable compression.
>>>
>>> But chattr -c only removes the previously set chattr +c. There's no
>>> "negative-c" to be forced by user in attributes. And +c is already unset on all
>>> files by default. Unless I'm missing something? Thanks
>>>
>>
>> The thing you're missing is that when we do chattr -c we're setting
>> NOCOMPRESS on the file.  The thing that I'm missing is what exactly we're
>> trying to allow.  If chattr -c is supposed to just be the removal of +c,
>> then btrfs is doing the wrong thing by setting NOCOMPRESS.  We also do the
>> same thing when we clear a btrfs.compression property.
> 
>     If I'm understanding this right, there's more than two states
> here. There's a "default", and there's two "force" options -- forcing
> nocompress, and forcing/allowing compression. If there's no c flag
> set, the file could be in one of two states: default behaviour
> (presumably defined by the value of the mount options), and
> NOCOMPRESS. How do I tell which it is?

Yeah you can't really.  If you're mounted with -o compress-force then you won't 
get NOCOMPRESS set automatically, so you can sort of (emphasis on sort of) 
assume that if you have NOCOMPRESS set then it was done by some user specific 
action.  But it seems like we don't even really clearly define that this is an 
option, so we're probably better off just killing that usage everywhere.  Thanks,

Josef
