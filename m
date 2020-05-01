Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BE51C0D82
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 06:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEAEsL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 00:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728184AbgEAEsJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 May 2020 00:48:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E624C035494
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 21:48:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so3279987plo.7
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 21:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZHMCEpwk3Gfxi7IUuw0Zfoz1WS9SG5hoHgDvPf96Zag=;
        b=ay+WH+tzmDLiNY2UpTpaLLB/7KVrmuPhuwKSlnqersafx2wAgR+Vh5HGS7OSgKGZwh
         U2dNQHdt+f8NQUMUqNqXJPdsMqhY2f67CcjaLcKUNQt4SiwO/lHRJLhUg3xOwmu00DC5
         wozyqgCWNyqJ3fGEL16IujL+++U851q2XmGembAeVImVa3oM4yqCvXkpPCtgb9EXgqLZ
         ij0197vQPNIdiMG7nR7eB9TBsEGAiuGyK5njgGRT8kMAKn1Jq/X00Jag1XFz2bBONvJg
         lpft41puObcFPB/OaasNAbypwotdY35SqOx42ajZIY6a3/g0cLfWhjMABWj6UACLgTJv
         GVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=ZHMCEpwk3Gfxi7IUuw0Zfoz1WS9SG5hoHgDvPf96Zag=;
        b=mj+E0Wz8UVUmYSt3paGOK6F6BgYvWlA128aQYXqrCa6SRKT6WIPUNBSpkbAAXqxJjs
         TwZwGQRlAh+xF+fhMUHJlDwoZSFaA+BgZTjXFYREoSmkRdkOrE1BJcrrrcl44fXIzJYP
         YV5JzJsabJDpjcHlkaj27DVDWmL9rTrYv+l1wwaROh9UrPASzJV+yuijbF/17q1Dmept
         26j+4X+1lt6g0obOuBMVmv5/wmxA43ub0Dx/L7tIVB/ylI8uS0E+5YpqIyuhhyPz1lco
         pqsJNaHimgFNb2+z3HCA3CAqHxZV/c7XkHtFtb41Y6IwmkHYhiVZ6+KvLZa/q03eMKEs
         NrWw==
X-Gm-Message-State: AGi0PuaDb/V6lKt6GKjbq71uOAAr7AXvp+5r3AVGM4oQJUrgc9W6uUiX
        nCWGUoeAcBhVBcebeMcJyPnRlg==
X-Google-Smtp-Source: APiQypJmu68dD4JccpKqjR/ReSlZ449JvlKo3aTgoawxodRSFn9I/qB+GpCjSRhciO5sCgJL7KMESg==
X-Received: by 2002:a17:902:b948:: with SMTP id h8mr2567286pls.309.1588308488499;
        Thu, 30 Apr 2020 21:48:08 -0700 (PDT)
Received: from selma.local ([2605:e000:1c0e:43f7:b590:149f:4376:a841])
        by smtp.gmail.com with ESMTPSA id d18sm1148562pfq.177.2020.04.30.21.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 21:48:07 -0700 (PDT)
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <CAJCQCtQqdk3FAyc27PoyTXZkhcmvgDwt=oCR7Yw3yuqeOkr2oA@mail.gmail.com>
 <bfa161e9-7389-6a83-edee-2c3adbcc7bda@ka9q.net>
 <20200501024753.GE10769@hungrycats.org>
From:   Phil Karn <karn@ka9q.net>
Autocrypt: addr=karn@ka9q.net; keydata=
 mQENBEw2mJ4BCADELiPsLFHDwapoSU7d2xNHxmwzzrFUCZWhO34kM6G5+o9GUNmGgMQ0BmXp
 I6hx77HHnrj9FC6kWh/bxBt3+o8HW+NTWzJSvf6kW7ThaNt7v9iewkS23JOMarAZs4qy6MhT
 1RW1/yWY7RimWxrmkKPTKKa0Ad4CWT6fcP3t+doqGslSQIeoTh0C33ZT+LY59Wcr224iXohN
 4Uu/nFe4yAHjtA+4Sesveo3Tyi8cbOgkcO6vij+pXesCcuhtGMlnE2dxRqbenrfVGLUVxNug
 LkQdLWezaGGm+dcjWYk1xjtaDnsCpVaYCMsfYNADQPJAjAFu37pVdoXhseVXfzOUN2EXABEB
 AAG0GVBoaWwgS2FybiA8a2FybkBrYTlxLm5ldD6JATgEEwECACIFAkw2mJ4CGwMGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheAAAoJEPFOQ1TtRjRGU98H/Atsb/N4lNbzNdzdIRcHD9XgCEa1
 UdR4mxgjwvLxS1nYRNdHwfTxvA5nxWfMx/0CB26VaNFdI3lkg/S0vYsSUu6M7l8Zb8v4JMyU
 4B4yvkFHZ3II5oilzIMa3e2cMfDz7TSwO1JcXyI5y9vHnvH65/LQF+QojDgzf3vXKiNdTXJp
 3nEa5IgMAB0rcSNsXFx8xbHi8s5niL9+1I7XTPvVMeXrMe8h4AG1nM/dK96WwmV+tLyXKYXn
 xVeb9F4X9CNQbkn/xAH+egvKHHT3V7K9cAhrDfu9Qwpo7zKk/akBpLWG2kmkTOfhXjm3UQhv
 MVgDmpeQIYa1HgAsKrsDQMzrIFm5AQ0ETDaYngEIAJmFdm0MmENzLEosD1FvGPJleWDYb0ah
 8dOk4XUug1RhW40f7AsugT75pKs9PolXt92920GdU727X3Jpgdj4kLDtIQA0KZrOXiEOZjIZ
 WcROAyvTGyMs/P7Um1AGNM161Ga6/Wtlc076FN7EUQtzPbthH26M3lGWUX0Ccls/8Ep4qbnF
 IrMRBxjaxKbqfKPTeU10pDykzA7s5hiNe7qaegvqD6YLseZ+6FqCn988YnLiIaFeNbWxUY5G
 spjAsfesnAmpn5vhUqAGiizkNlAMIN31xvpLd93oM4/vORszIuN1UP2RlxL3s30BncZl2XOd
 Mk1/59Sy70zVqF1ANyMrA18AEQEAAYkBHwQYAQIACQUCTDaYngIbDAAKCRDxTkNU7UY0Rszt
 B/9ZPH9xw47lPkVJRbhgf0G7fdsxsyiuouAqOKklUNFSy4+qeGomjwE6YvdMybwGtaUGla7t
 2mDzrva+7Gzb0inXIgmahQPmM16F3GVxGoFL+QJ+7gD8Hco6e0/2kju7ZREDE7SOEwKb3lhD
 eNLccfX2AqAHfCT/LVLbgBpMRmwUJQThM+33Z2L9BqIM3awj2mOTmeDumpxiDfroU90mGc9c
 pXe4YrNIkL/N8eMzLe1bpu+mpPCiIrEO+dFA7N8jjVcOCQ4Lr8sU6cOsEdkaACZiNFKT99eb
 NkKigK8sEkDZc/AKhPCEsnaZpwBZPScOL88LLi7FHj9Osznt+uhWfbLe
Subject: Re: Extremely slow device removals
Message-ID: <b2cd0c70-b955-197c-d68b-cf77e102690c@ka9q.net>
Date:   Thu, 30 Apr 2020 21:48:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501024753.GE10769@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/30/20 19:47, Zygo Blaxell wrote:
>
> If it keeps repeating "found 1115 extents" over and over (say 5 or
> more times) then you're hitting the balance looping bug in kernel 5.1
> and later.  Every N block groups (N seems to vary by user, I've heard
> reports from 3 to over 6000) the kernel will get stuck in a loop and
> will need to reboot to recover.  Even if you cancel the balance, it wil=
l
> just loop again until rebooted, and there's no cancel for device delete=

> so if you start looping there you can just skip directly to the reboot.=

> For a non-trivial filesystem the probability of successfully deleting
> or resizing a device is more or less zero.

This does not seem to be happening. Each message is for a different
block group with a different number of clusters. The device remove *is*
making progress, just very very slowly. I'm almost down to just 2TB
left. Woot!

If I ever have to do this again, I'll insert bcache and a big SSD
between btrfs and my devices. The slowness here has to be due to the
(spinning) disk I/O being highly fragmented and random. I've checked,
and none of my drives (despite their large sizes) are shingled, so
that's not it. The 6 TB units have 128 MB caches and the 16 TB have 256
MB caches.

I've never understood *exactly* what a hard drive internal cache does. I
see little sense in a LRU cache just like the host's own buffer cache
since the host has far more RAM. I do know they're used to reorder
operations to reduce seek latency, though this can be limited by the
need to fence writes to protect against a crash. I've wondered if
they're also used on reads to reduce rotational latency by prospectively
grabbing data as soon as the heads land on a cylinder. How big is a
"cylinder'' anyway? The inner workings of hard drives have become
steadily more opaque over the years, which makes it difficult to
optimize their use. Kinda like CPUs, actually. Last time I really tuned
up some tight code, I found that using vector instructions and avoiding
branch mispredictions made a big difference but nothing else seemed to
matter at all.

>
> There is no fix for that regression yet.  Kernel 4.19 doesn't have the
> regression and does have other relevant bug fixes for balance, so it
> can be used as a workaround.

I'm running 4.19.0-8-rt-amd64, the current real-time kernel in Debian
'stable'.

Phil



