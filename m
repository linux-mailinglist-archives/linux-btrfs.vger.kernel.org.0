Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8223301611
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 15:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbhAWOtP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 09:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbhAWOtO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 09:49:14 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B36EC06174A
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Jan 2021 06:48:34 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j13so9934699edp.2
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Jan 2021 06:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=fJ3GZaxPNZCJGnmOIYCR9Wk9fNV3MPQbOZ8vWrxLPp4=;
        b=K0LObnpVWkkdSYxr5VrT/1oTEPgGE5DCBQdmchX05EH5y2Ic0ccNyqXCkH40TS7eY+
         pjT8Jqg8frzaW0UudbGbEsL8aHrgKFdvGBYskoOEX05TJn5vbayQeR7Nz89OZgIDzbKQ
         tkIXroaiPfnCd20fU8YvNu4l2I8AqKsPIDJ28W63haVVxnpi7wmW7QkbENy91GJOarDa
         rma9LBku5qBHz9Vk/LXC1hLjlT9q54vZRWs38VlVAXcOx6MNfmxiboLCJbXuKLQn+eXR
         lQCllEhHXCHL78O/XIkZ3M30Xu6Tp0peoSJZhtcSKcE2g53vM9rjCjlAWhUTYeqLfwOo
         G4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=fJ3GZaxPNZCJGnmOIYCR9Wk9fNV3MPQbOZ8vWrxLPp4=;
        b=BHj+R9S1d4diaTatXWUhA/X4/gkIHq9ubnPCRVdZvdetS5krXFZa1JH9ES2r8FCRFc
         VZ0gGdZwbCd6JGov7fBMBzt2A/yOeVkJGkk1WMzaP/LPNo02Fh1ttFkssam/8SSAV3KB
         pbDmodDgvKdWibrIoFzHFflnc6L0FAL05fLuxcV5GjvpGsDRDQphGlEemqwAeWRumHIX
         98nmE1RKULf9CBLIJpQRwAVh0SLwbR74aUsV4LwxupuVLYb6sYf1AgbNHOQSkcZ8WXW6
         OQCsnzWqjZH70OzoXM6dQWU+9FYA3N+MlUjgvCko9+SkFO1+AvrwlCjd+EoeP//zTOD+
         rh8Q==
X-Gm-Message-State: AOAM533N6kf/jmBvRicj1ZLsXgEzQe9IOXrcyeoWhfh0n2LsezO9F7K5
        43dJYGxWdF067sAynNitMWMLBLz7yqta
X-Google-Smtp-Source: ABdhPJzHKUraDOfR8M+KCncKshH/N+S4lwdwI/1/wUob8Ee15/v0S8Yo7Mvn21fqIdwAh+5lSIfnHA==
X-Received: by 2002:a50:fd12:: with SMTP id i18mr7206810eds.220.1611413312063;
        Sat, 23 Jan 2021 06:48:32 -0800 (PST)
Received: from ?IPv6:2a02:810d:413f:dea0:18de:8a50:20d7:c1dd? ([2a02:810d:413f:dea0:18de:8a50:20d7:c1dd])
        by smtp.gmail.com with ESMTPSA id x17sm7112697edd.76.2021.01.23.06.48.30
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 06:48:31 -0800 (PST)
To:     linux-btrfs@vger.kernel.org
From:   =?UTF-8?Q?Jakob_Sch=c3=b6ttl?= <jschoett@gmail.com>
Subject: Only one subvolume can be mounted after replace/balance
Message-ID: <b693c33d-ed2e-3749-a8ac-b162e9523abb@gmail.com>
Date:   Sat, 23 Jan 2021 15:48:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

In short:
When mounting a second subvolume from a pool, I get this error:
"mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda, 
missing code page or helper program, or other."
dmesg | grep BTRFS only shows this error:
info (device sda): disk space caching is enabled
error (device sda): Remounting read-write after error is not allowed

What happened:

In my RAID1 pool with two disk, I successfully replaced one disk with

btrfs replace start 2 /dev/sdx

After that, I mounted the pool and did

btrfs fi show /mnt

which showed WARNINGs about
"filesystems with multiple block group profiles detected"
(don't remember exactly)

I thought it is a good idea to do

btrfs balance start /mnt

which finished without errors.

Now, I can only mount one (sub)volume of the pool at a time. Others can 
only be mounted read-only. See error messages at top of this mail.

Do you have any idea what happened or how to fix it?

I already tried rescue zero-log and super-recovery which was successful 
but didn't help.

Regards, Jakob
