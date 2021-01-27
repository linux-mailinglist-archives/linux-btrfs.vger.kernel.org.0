Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F64D305CBA
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 14:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbhA0NOM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 08:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343746AbhA0NL0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 08:11:26 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C74C06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 05:10:34 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bl23so2572082ejb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 05:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Whvqbb41dytwuURUKI7jrzkIAo/FtTo6aKsGqHtatnA=;
        b=LhhwShEuNl3VS4Op5sQWhyXEq1zdL0DE5UrEm9+P7ZigeDfDqMuYuyfsEj5XviBkMc
         3+KPdWBHFBwDCPQBuJ5FNSJLneBGsJ6bKztcBwVG+8ygGNJ7wHSSzKeFfWoZ2fc6XHCu
         MzZ2Td4pGNliwlVXkdn06VjBJGyvQ7wQu7iEXbQTP1cJhn2aF/2T1O+gwpjSoAaRAJXb
         hBQKtkJWNxi/j7rrhYbmMrXXDyhm2uGhi7dXqKsruukoumFmzWdwuZXFLL2fPqK/d3rY
         rfKlrUGyqD/fFwQw9t0rdw1uSF5KRyqtkLucg9rnXVsqUCScmOpO6PAQL8ToIBTD+4As
         +lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Whvqbb41dytwuURUKI7jrzkIAo/FtTo6aKsGqHtatnA=;
        b=r5J0YRIpJyAp+Y16GZr04q1D8rCVzngexghc9Kh9KvUqUyy+5J0ShmnRW9/mPD49dq
         x4sZDX9YfLDu6SG/BWGNzur+gg1tIC3j9MnAIS53pc9leeZAi9MRHncPPMD30q707OXk
         Fq2Lvcdspv21AflIxHBa9W/aOEetsllHih76B6mQ5NcvzlZjk8Ex18uHYRknlnW4UqPB
         OOQgG7+vbsX5RhVQvpq9HG9ZZzXPaKuoAvXYqtNRj+TxHVnEloVnaKsm9IybOBifHq97
         rCG7DrjEfh9tmbNAdIJucbEeI77hIuLMd20blBKxwroh1K/EwO2O3gzPyjdMu03A9Qhc
         Togg==
X-Gm-Message-State: AOAM5321i66WPg58Mv4uz0OvRo2yw3rfBVSlhK49tYe/bjkoEZaAm3eJ
        XOosUPE3OU87/f9XEaEeHszFKKW2Tw+Q
X-Google-Smtp-Source: ABdhPJxYw/j023VGeL+yR9T+tfi1kKrpVnU/Na+bb5gCKXWHACgjR6J3n+HieCW15yIQcfm+xEaZGg==
X-Received: by 2002:a17:906:278b:: with SMTP id j11mr6783375ejc.438.1611753032897;
        Wed, 27 Jan 2021 05:10:32 -0800 (PST)
Received: from ?IPv6:2001:a61:12bd:4801:f4ba:f461:eb0a:d0a6? ([2001:a61:12bd:4801:f4ba:f461:eb0a:d0a6])
        by smtp.gmail.com with ESMTPSA id p15sm815944ejd.121.2021.01.27.05.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 05:10:31 -0800 (PST)
Subject: Re: Only one subvolume can be mounted after replace/balance
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <b693c33d-ed2e-3749-a8ac-b162e9523abb@gmail.com>
 <CAJCQCtSwC--k1agUzBcGgdCZZu426fVoUw-V3m8C4XjeN7yQaA@mail.gmail.com>
From:   =?UTF-8?Q?Jakob_Sch=c3=b6ttl?= <jschoett@gmail.com>
Message-ID: <bfbe313c-4f4d-eeab-1a6b-10d58b5b4b91@gmail.com>
Date:   Wed, 27 Jan 2021 14:10:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSwC--k1agUzBcGgdCZZu426fVoUw-V3m8C4XjeN7yQaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you Chris, it's resolved now, see below.

Am 25.01.21 um 23:47 schrieb Chris Murphy:
> On Sat, Jan 23, 2021 at 7:50 AM Jakob Sch=C3=B6ttl <jschoett@gmail.com>=
 wrote:
>> Hi,
>>
>> In short:
>> When mounting a second subvolume from a pool, I get this error:
>> "mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda,
>> missing code page or helper program, or other."
>> dmesg | grep BTRFS only shows this error:
>> info (device sda): disk space caching is enabled
>> error (device sda): Remounting read-write after error is not allowed
> It went read-only before this because it's confused. You need to
> unmount it before it can be mounted rw. In some cases a reboot is
> needed.
Oh, I didn't notice that the pool was already mounted (via fstab).
The filesystem where out of space and I had to resize both disks=20
separately. And I had to mount with -o skip_balance for that. Now it=20
works again.

>> What happened:
>>
>> In my RAID1 pool with two disk, I successfully replaced one disk with
>>
>> btrfs replace start 2 /dev/sdx
>>
>> After that, I mounted the pool and did
> I don't understand this sequence. In order to do a replace, the file
> system is already mounted.
That was, what I did before my actual problem occurred. But it's=20
resolved now.

>> btrfs fi show /mnt
>>
>> which showed WARNINGs about
>> "filesystems with multiple block group profiles detected"
>> (don't remember exactly)
>>
>> I thought it is a good idea to do
>>
>> btrfs balance start /mnt
>>
>> which finished without errors.
> Balance alone does not convert block groups to a new profile. You have
> to explicitly select a conversion filter, e.g.
>
> btrfs balance start -dconvert=3Draid1,soft -mconvert=3Draid1,soft /mnt
I didn't want to convert to a new profile. I thought btrfs replace=20
automatically uses the same profile as the pool?

Regards, Jakob

