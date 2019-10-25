Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04923E5222
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 19:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409866AbfJYRQX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 13:16:23 -0400
Received: from mail-yb1-f172.google.com ([209.85.219.172]:40340 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409850AbfJYRQX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 13:16:23 -0400
Received: by mail-yb1-f172.google.com with SMTP id d12so1144509ybn.7
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bjIP0T7Y1bpeCNrmaL1j2UhyivViNl89P5YTsutaSjA=;
        b=X8pKEGYqYDyGlmC63a+4LZrVOwlKPjBSs2JVUuGXMGWf9uEVmGigz3RokLflPftabW
         XUd4AjOktshnEElJWqfyGH1ST5UFOnLOTP6hPjb9db/ACvknyardeHkxSTrc6fDjKBxF
         MjuV6mM/PUS+H8st+8uc8C8Mhv3iDLSJ9ezEQYgc5QkJl7BPQZxZV5qy09IsdesdoMwW
         r1iIQ6mG+BP6bWyJwmsQYkdqTNGl94vNlF4kzZs/wwc9q1iQ9+qsNdhxu7BkRddWDFDi
         0Eb9j6NYImjdw9gZduKN/ElUJROCRWxGce35BgujtYtyjMRPhCjKwZ8e3jDbGz6abjOl
         ANFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bjIP0T7Y1bpeCNrmaL1j2UhyivViNl89P5YTsutaSjA=;
        b=BauCf2nQso8vour+V4RYkgqHeCIv3mKZO4NKxWGok6hNA2c+wlTLmnAd/47j6i5+jK
         zwXtLfjECZcAQPUvXsd8+En9sSM7wY9XiSO9+ULSvwj9xxvPls97hVGAYwbsUJcrPSn3
         xolcZXuHdBBE+UZD+iXAZv6MuEiHwpKYC5C0wGmFgpeRzgdBUhocqCO1mevPXIULvuY5
         ryK8esIyJjgCL3JUz8TnHBv+z8iy3nb0KXlXdX4K3cteKY6ylwA22u7O80d0VeiRpOuR
         XzqR+A75PfOa2at53GYqiSHUhCAkDa4L72c9TOQQwzW39+HWgTsscykXTQjfRco3D/O5
         NUsw==
X-Gm-Message-State: APjAAAVLV6oRSdF9+Uo05GRXb+H5VOIjJGNDESvDymf4nqJTWWKs7XX6
        YSQRq0Z841mNSvsKh3tk3adPGc2dbSU=
X-Google-Smtp-Source: APXvYqyjsOKHWDbJPN5n/YpVaaaPpyxd/2A9X80QH+mEBGIBVRfuh/cV3bIW+ivR+mlHopWac3VDMw==
X-Received: by 2002:a25:49c7:: with SMTP id w190mr4389102yba.440.1572023780712;
        Fri, 25 Oct 2019 10:16:20 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id z16sm1153120ywj.93.2019.10.25.10.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 10:16:20 -0700 (PDT)
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
 <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
 <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com>
 <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
 <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com>
 <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
 <0d6683ee-4a2c-f2ab-857b-c7cd44442dce@gmail.com>
 <CAKbQEqGoiGbV+Q=LVfSbKLxYeQ5XmLFMMBdq_yxSR7XE3SwsmA@mail.gmail.com>
 <043c2d26-a067-fd03-4c98-7ff76b081fed@gmail.com>
 <CAKbQEqHbh0pjT1+hPNuo_fKti0v9Mi-=gOUqm90v_tju1xSaxA@mail.gmail.com>
 <CAKbQEqGE6eBbqt7KZRtfmtpNL+YiaA6DF4t3NDm7_zfZtoYn_g@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <6d61f5b5-220a-a35e-c6bc-20eaba45e925@gmail.com>
Date:   Fri, 25 Oct 2019 13:16:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAKbQEqGE6eBbqt7KZRtfmtpNL+YiaA6DF4t3NDm7_zfZtoYn_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-10-25 13:05, Christian Pernegger wrote:
> P.P.S (sorry): Would using the DUP profile for metadata conceiveably
> be an extra line of defence in such cases (assuming the NVMe doesn't
> just eat the extra copies outright)? If so, is enabling it after fs
> creation safe and should system be DUP as well? Something like:
> # btrfs balance start -mconvert=dup [-sconvert=dup -f] $PATH
Yes, using the dup profile for metadata should help, provided it's not 
an issue with the rest of the system (if the metadata gets corrupted in 
memory, two bad copies will get written out).

On-line conversion is perfectly safe, and should not require explicit 
conversion of the system chunks (converting metadata will do that 
automatically).
> 
> Lastly ist $PATH just used to identify the fs, or does it act as a
> filter? IOW, can I use whatever or should it be run on the real root
> of the fs?
I think any path on the volume will work, though it's best to use it on 
an actual mount point so you know concretely what it's running on. Most 
of the ioctls are pretty forgiving like this, because it's not unusual 
to only have non-root subvolumes mounted from a volume.
