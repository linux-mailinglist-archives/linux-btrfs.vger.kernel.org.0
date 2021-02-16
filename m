Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC3A31CCD2
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 16:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhBPPUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 10:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhBPPUg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 10:20:36 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965A3C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 07:19:55 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id c3so9046419qkj.11
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 07:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rBuytSH0T0JYMIKm5Qa/l+USAXl5wVVHXrsDfAGmIPE=;
        b=duqpKVjVXwMNBXry9obgf5QH+LAcFCnsaQBBbyNtxFVLfq8E4jCsOWrjvmSEIQd/lf
         4RdtR++z1/HBfjqlRmvVn6SfBF9lE328j7qFbltFz1EO2GP7nWW3kZLRCxtKocq3xVX1
         5DJgVexnn2nmumVNZZttJOji3Psjyzg5gY6uZYjNoGvI288O5lqG5HRPgpyMeX/YIcfK
         JIhDHtheRgJh8KJvBT/pngt5iE76CMGxT1ArLzwXXQ1S0Fi41eKoMGWk23Gl7t9ImU0n
         tZ1Tz38a64fZitcBegpn4NRm7HXLZGH74qgvf8GbinaCykEx6XzVjKBxSHfUmdNp9ygu
         lUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rBuytSH0T0JYMIKm5Qa/l+USAXl5wVVHXrsDfAGmIPE=;
        b=VvUEH3kLwwN8+coepxnQnGusnnHjbLPW838CElIOLSifjwzaqV8wnWtHO3LjiCTlaO
         qgHxzut1FotuNqy7oHAuI7m/Oa4lc05AHxXHhbwSybCj66QJEBekwg2Qg2Glg5iPAxzu
         7ES+h27aC0pLj3hRv3Vpl60wIAj4Tt6HXk+WrPsSUI0WaGfF1v/Y162hKThAjltp4kV8
         l4fcArP+XTGTOXuELGagQDNBO6/xrEzrgSdf+CgYt2qSSmZ6EGXVGvgwZ+m1qyfx2Ccn
         LgMCEqje0ZVvoaas7KnZILbyfADhSMlPcVyf/YJA7drxiDX5zrLubUBHAqdUHl5JqpEN
         Uwqw==
X-Gm-Message-State: AOAM5301+Xzr3sPHpuWywZQhTDZzMXGU5p1bRghFxryd1VvHzL/qNfjA
        3E3DyY3OyyWlI1vEuuAaHehjwqUALzZVId+v
X-Google-Smtp-Source: ABdhPJxZJr5wIlP4YApmi4mkWRviquy0EZtmNneR25iulQlf5R38ATAMnm4uiDM9N58p4Y5df0h52A==
X-Received: by 2002:a37:a151:: with SMTP id k78mr19043894qke.359.1613488794320;
        Tue, 16 Feb 2021 07:19:54 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h186sm8630420qke.129.2021.02.16.07.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 07:19:53 -0800 (PST)
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0c4701b2-23ef-fd7a-d198-258b49eedea8@toxicpanda.com>
Date:   Tue, 16 Feb 2021 10:19:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/14/21 3:25 PM, Neal Gompa wrote:
> Hey all,
> 
> So one of my main computers recently had a disk controller failure
> that caused my machine to freeze. After rebooting, Btrfs refuses to
> mount. I tried to do a mount and the following errors show up in the
> journal:
> 
>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): has skinny extents
>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
> 
> I've tried to do -o recovery,ro mount and get the same issue. I can't
> seem to find any reasonably good information on how to do recovery in
> this scenario, even to just recover enough to copy data off.
> 
> I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
> the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. I'm
> using btrfs-progs v5.10.
> 
> Can anyone help?

Can you try

btrfs check --clear-space-cache v1 /dev/whatever

That should fix the inode generation thing so it's sane, and then the tree 
checker will allow the fs to be read, hopefully.  If not we can work out some 
other magic.  Thanks,

Josef
