Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEEA31FBA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 16:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhBSPE2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 10:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhBSPEO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 10:04:14 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD319C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 07:03:31 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id ba1so3523293plb.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 07:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=znTzbqFTaXxlyZ4X5JmsabF5FMFcaQRUUyVTExfdb50=;
        b=D3joHeUA4zQBPXF6DDmWOxvlDoiDxA+/HQK+GAmWB/zEXcpiWJOBp1LRKG7QYyg0ib
         Nr0fpLAHcBLB3a85/l43oCGOso4WksA8WwHPM7sBqiPghMVTzvTJzEJ14ap+bpK6Ny2x
         fM5Xnfc9bheAUYl+iuX46/lWeZZUBKF6syFO2q9/2PwjCz3j4zWQl4mEyz/g0G8wGgoI
         XdfLqcUTrKTe0M5hdpnt5fVzKq6NJn4BKwcg4tv2wg+Jkxbi0D2tLUUqIwFa40lercV0
         YQIr6AoKxdiMMLZ+uIRx/C56tcCHJV91Ho5SZ5xUq/eC/3lhgULmQZ4NEuMBBCYTMW/A
         E4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=znTzbqFTaXxlyZ4X5JmsabF5FMFcaQRUUyVTExfdb50=;
        b=UEQCzTmtSWbSZ9U1pug6WOq9XQymRhNaQLpA+qhs8HOlPDXMNd9ECNeDzB7oBsCSQR
         xxC2NhwlrF8rzsDegYhqNBc6AVPaVkCGgWdKFuciPa0yJ4IXPWa3CR4Q9rOFrpx+bwYI
         p+wTts1Ts56S7fUd+M3Gi/OCN0MgU2qZp7j0K6c/cWMsciz7WRpC6Y5BYcI/EI+PHVMM
         g/txrnogCtXgT4obU7RyhYMtWkqsVF44irTBGz4R4M6797ukQ+25QrEulVaiJrXVSzh/
         wJQj4MINys7NZPUB854NA2deqTA7oxIBj1wMqEAjCOhH4fR17dn9O+WN1NRvsF8LUZfz
         fylQ==
X-Gm-Message-State: AOAM530uP395c0xzg0YoQZHAEBFn8h0imomFLHJChUhX+08ri+k8TaFo
        T28O0WRF8WFq5c5okktu/UkCbgSEHZM=
X-Google-Smtp-Source: ABdhPJzRJEXuWIkvP12fqXRUji+lb9E9wvFThEPumgra33xNXAalmyW2x3Ib7tZXvniGoxWywWoNqQ==
X-Received: by 2002:a17:90b:3596:: with SMTP id mm22mr1407579pjb.73.1613747010986;
        Fri, 19 Feb 2021 07:03:30 -0800 (PST)
Received: from ddawson.local ([2602:ae:1f30:4900:7285:c2ff:fe89:df61])
        by smtp.gmail.com with ESMTPSA id np7sm8460742pjb.10.2021.02.19.07.03.30
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 07:03:30 -0800 (PST)
Received: from localhost.local ([::1] helo=ddawson.local)
        by ddawson.local with esmtp (Exim 4.94)
        (envelope-from <danielcdawson@gmail.com>)
        id 1lD7JZ-0005LN-JA
        for linux-btrfs@vger.kernel.org; Fri, 19 Feb 2021 07:03:29 -0800
From:   Daniel Dawson <danielcdawson@gmail.com>
Subject: Re: corrupt leaf, unexpected item end, unmountable
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <83750bf0-19a8-4f97-155c-b3e36cb227da@gmail.com>
 <CAJCQCtQGyHJjPwmKxwxCBptfeb0jgdgyEXF=qvGf-1HBDvX1=w@mail.gmail.com>
 <80058635-0bd9-05cc-2f5e-b4986a065be3@gmail.com>
 <CAJCQCtTCKSC46kNaoENdEpCNTxB1_MeD6PHwbmtRnJdbGWBswA@mail.gmail.com>
Message-ID: <31ab01c3-ab49-4528-d73e-e90da28d4e67@gmail.com>
Date:   Fri, 19 Feb 2021 07:03:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTCKSC46kNaoENdEpCNTxB1_MeD6PHwbmtRnJdbGWBswA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/18/21 9:03 PM, Chris Murphy wrote:
> Once everything else is figured out, you should consider converting
> metadata to raid1c3.

Got it.

> The new replacement is devid 0 during the replacement. The drive being
> replaced keeps its devid until the end, and then there's a switch,
> that device is removed, and the signature on the old drive is wiped.
> Sooo.... something is still wrong with the above because there's no
> devid 3, there's kernel and btrfs check messages saying devid 3 is
> missing.
>
> It doesn't seem likely that /dev/sdc3 is devid 3 because it can't be
> both missing and be the mounted dev node.

It seems I was unclear. I removed the old drive prior to the
replacement, hence degraded mode.

A while ago, I imaged the drives, to see what I could do without risk
(on another machine). Turns out I was able to mount the filesystem using
-o ro,nologreplay,degraded and copy almost all files. A small number
were unreadable/un-stat-able. Fortunately nothing critical, though the
OS may well be unusable.

(Also, in case you were wondering, memory testing has revealed no errors
so far.)

> If a tree log is damaged and prevents mount then, you need to make a
> calculation. You can try to mount with ro,nologreplay and freshen
> backups for anything you'd rather not lose - just in case things get
> worse. And then you can zero the log and see if that'll let you
> normally mount the device (i.e. rw and not degraded). But some of it
> will depend on what's wrong.

That doesn't work. It gives the same errors as when I tried to run
check, but repeated once each for extent tree and device tree. It just
can't get past this problem.

At this point, I think it's best to just reinstall with a fresh
filesystem, and not make the same mistakes. Thanks for the help, once again.


