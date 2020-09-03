Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B12425C5E9
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgICP4g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbgICP40 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 11:56:26 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02510C061247
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 08:56:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 60so2257018qtc.9
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hsdtYFNyp3/FmcU8uY3Hdq5TNN91d5fFstq4D47hpr0=;
        b=rK1MTFbjDHNICVzvGZkHhbHI4QTVQ3xHEv4T1PfpAPPEEMI6P7lbVQgU+XyBhnNiCx
         gW5oVed2AN2b7Ufy2HOjhn0+z14Ovp+sl9KKNl6hyZKSvwMbC9wT9DuKDVcz+qUocrD2
         VEAlQgmP3XDeHwg9PfZcvSGWFSDprwwuY/iFzsicmTLUhwsg35SWh8rTcE1EoZsg6lu7
         XSkjnXBXrpkPtogqT4Ny99Kj/VjG47GG/XArRgMQHUuON1t/rAFfcHHwPc/eJ+UfmmDi
         CwXnvfDSMeOYqnCII1iHvHQYzGXzKZI0rGt3clnpSfk0Nzu5aOilAdZ9awnhpm5PIq3b
         BV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hsdtYFNyp3/FmcU8uY3Hdq5TNN91d5fFstq4D47hpr0=;
        b=LxNDui/c0v/L6J2ac18MRt/hOMQQZ1rd18pWVKVKL2YF/+MPzqydoRLL7/I5QKnn6K
         yFByCvEjdJ1CKAVaSfWObOCXQbmSjg7aWbuaCwy+ztWgaZN81tXb4LceED9UqVwUrefJ
         JYwe2oTkoyWznOmZhoyokDmO54w2EHkePefi8MaACCnVZrfwPG/A/yxpEtWr2h0C4ySm
         o+/DleFoJEP1rZS9RA3+o8u9Roi77z2I7SQi+hEKVp3Sv3TSHxVSz3qOIxYmuZE/CIHi
         ia67g1PTp00dNUaTQ+FGL+eqMb9vqTNKM0utM0hKPImwKJwgWYW+Ytl8FIgFXzocQTB6
         ONbA==
X-Gm-Message-State: AOAM532F2jPqZt2Qus6GOo9CJC1DTTu9o5ly0L8qe7dyKapNS57hkdbc
        C5stnG/mlb750GB8yYQPUGKfa3AxGDLbWdzj
X-Google-Smtp-Source: ABdhPJzOy94UQcURINAYXbSBHRDsVhE8mJzsCehTkZT7ZCIogsgO/vGki4AAsDOH5O4b8hpfQot2AQ==
X-Received: by 2002:ac8:6d0e:: with SMTP id o14mr4047599qtt.31.1599148584840;
        Thu, 03 Sep 2020 08:56:24 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a3sm2311815qtj.21.2020.09.03.08.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 08:56:23 -0700 (PDT)
Subject: Re: kernel BUG at fs/btrfs/relocation.c:437!
To:     Johannes Rohr <jorohr@gmail.com>, linux-btrfs@vger.kernel.org
References: <28e01acb-a8b8-6801-ee49-94e56d7371aa@gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3ee07ef0-2712-09d8-df19-85fb920b0c82@toxicpanda.com>
Date:   Thu, 3 Sep 2020 11:56:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <28e01acb-a8b8-6801-ee49-94e56d7371aa@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/1/20 4:18 AM, Johannes Rohr wrote:
> Dear devs,
> 
> I tried to replace an SSD with bad S.M.A.R.T. status and since I don't
> have physical access to the server, I first wanted to remove it from the
> RAID 1 (which has 4 SSDs) and then erase it.
> 
> I ran "btrfs device delete /dev/sda2 /". After a while, the command
> terminated with a segfault and the system hung. I waited for 30 minutes.
> Fortunately, it could be resurrected with a hard reset.
> 
> dmesg, as this happened, reports that a block on a different SSD, on
> /dev/sdc can't be found.
> 
> See full backtrace here:
> https://gist.github.com/vasyugan/340d9cd2292e3122c1d7773df718a234
> 
> Now I am afraid that if sda is just removed physically, then marked as
> degraded and swapped for a new SSD using the btrfs replace command, this
> might also go bad  because of the block that can't be found.
> 
> Does any of you have advice on what to do? From the backtrace I don't
> even understand if the issue is a physical problem with sdc (whose
> S.M.A.R.T. values are just fine) or whether this is another btrfs bug
> and if you, if there is any way to work around it.
> 
> We are running Ubuntu 20.04, the kernel is 5.4.0-45-generic, Ubuntu's
> version number is: 5.4.0-45.49. It was released yesterday and was
> supposed to have a relocation relate bug fixed, see
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1889669
> 
> I suppose, this is a separate issue. Should I report a bug? If so, where?
> 
> Thanks a lot in advance for your support!!!
> 

This error message sounds like a corrupted file system.  However I fixed quite a 
few things in relocation recently, try a more recent kernel, 5.8 has all my 
recent fixes in this area.  If not then I'd try btrfs check /dev/whatever to see 
if it complains about your fs being corrupted.  Thanks,

Josef
