Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4F27B43E
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgI1SQh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1SQh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 14:16:37 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185A0C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:16:37 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id x201so1486142qkb.11
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MYN8HU2TwmH9v1tpAA13P6OjgtwK5XRZnBgTrZCQWYY=;
        b=XfrFowBBSC8QELsTXqXRBsKK3y0jlpOBxf7IZMYIcvnLM/piLEFApebOnlDa3o6swI
         5rYm8Z7/zQpYiQdAiWcesPxV3GKfUW+cz0UWaOq7FITXDe9JvJ0XKD3FUOi9Dpslj+lx
         60Li11C2nWh4frcOGZNTwVw16YRzcHzJLx5gQTEe5e9/n7O8ECbpA6SYpV518Pq4uboS
         oFItOKF1RMhRdSyMfR1Rxuz+9XItMQCjLdtm2XTvIXEqnLSxG3J+indsfxsBcpwDwRD8
         bMnVGd9/1sWQSDywECVncCuh3QwsYVJ+3v2kqrN9QEBUVusgQd1d33wiBAxzbhIU3VLf
         fRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MYN8HU2TwmH9v1tpAA13P6OjgtwK5XRZnBgTrZCQWYY=;
        b=VCa1iHCsL7vpobT4Cc+ggWjQMOgzne/an8lLMVnbEeUdVzO+EVTwBjirMNynU+4Jso
         gKUT42rKNRCgl0qFilSaBYuVXBRdEFBHuVc61A9kJxiTJQwetc7w+X/eqHUXDK88NU5Y
         +KdeNgH7mtPHEUjiTwbi8tTmKpZQ7khPZigTUTrboOxAcYR7+J4e3tNU4MiS/91yaNfm
         kpq6sAfe5PBVwFdaVBLRMeiQ0L9jIDcGO0QfT6rERrH7R4CYeV9b+0Bw2VMv4Pc6XWoE
         RmvgQOvTbvsIjUGxy83ggoHECdadYB7LudQyNGSOGNEg373vg9v/5F/NeBXo9LDi8Mr/
         XC9Q==
X-Gm-Message-State: AOAM533l3f760wreuu7bJnVjZkFTKYVXHRcJYO//col40m9Lzo2yMyXk
        1dju/eXhIdMNCoRLre7Qt9uX0B0+AAmDaY3E
X-Google-Smtp-Source: ABdhPJyCJ8+ZZX2m38otMBtNXyVgfQ/qZUn+V5W2X79irZVxYAzOyyJrD9X3Hs2u21Cvssfc5T6AHQ==
X-Received: by 2002:a05:620a:13f6:: with SMTP id h22mr743612qkl.9.1601316995802;
        Mon, 28 Sep 2020 11:16:35 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 5sm1776818qkj.135.2020.09.28.11.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 11:16:35 -0700 (PDT)
Subject: Re: [PATCH] btrfs: add a warning to check on the leaking device close
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <8ad72827dc32542915f87db73cbb6b609f24dce4.1600074377.git.anand.jain@oracle.com>
 <20200916101003.GM1791@twin.jikos.cz>
 <52013ea3-fd54-5dbd-5c4d-3c5f41fdbf93@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c1ff087a-26e6-f2d1-eeac-73d65d3a432e@toxicpanda.com>
Date:   Mon, 28 Sep 2020 14:16:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <52013ea3-fd54-5dbd-5c4d-3c5f41fdbf93@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/16/20 7:51 AM, Anand Jain wrote:
> 
> 
> On 16/9/20 6:10 pm, David Sterba wrote:
>> On Mon, Sep 14, 2020 at 05:11:14PM +0800, Anand Jain wrote:
>>> To help better understand the device-close leaks, add a warning if the
>>> device freed is still open.
>>
>> Have you seen that happen or is it just a precaution? I've checked where
>> the bdev is set to NULL and all paths seem to be covered, so the warn_on
>> does not harm anything just that it does not seem to be possible to hit.
>> For that an assert would be better.
> 
> There is an early/unconfirmed report [1] that after the forget
> sub-command a device had partition changes and the new partitions failed
> to recognize by the kernel.
> [1]
> https://lore.kernel.org/linux-btrfs/40e2315e-e60e-6161-ceb7-acd8b8a4e4a0@oracle.com/T/#t 
> 
> 
> The mount thread can't use device_list_mutex (because of bd_mutex),
> and we rely on the uuid_mutex during mount.
> 
> The forget thread used both uuid_mutex and device_list_mutex.
> 
> So there isn't race between these two.
> 
> As of now we don't know. So the warning will help to know if we are
> missing something.
> 

It is clear that it can't really happen, but if we're worried about it I'd 
rather it be an ASSERT().  Thanks,

Josef

