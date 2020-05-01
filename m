Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F541C0ED6
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 09:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgEAH3z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 03:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgEAH3y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 May 2020 03:29:54 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23439C035494
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 00:29:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so2067277pjb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 01 May 2020 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1+CQ2qGbdFGpwZNB8QkyFli2y0KOrjYpLjYZV+rhhQs=;
        b=Ar5uBRdDgxTRWeLum9uP2/JAO0PRft0siD5uvv4cQ68RgsVHa3Da8NvrwY6LsaCUZF
         1px28AF7uL/UrJ2MLlK5rWxh4h8wX01Ynbi/dVwSA1bFPbQo6P3WqvGT+T7hToo6ddC6
         qvbeUe8x97FlSeh8VF7IsVHzz0X0adP9vYWDGl7kH87uIdFalt6MOySGJ7t/PFii5T2t
         Ix2mIocM/5ldpFZqhvORa5z97pSW0HRvv37oWd19idq4BlhQcBNuvLh992tHOKBNzruB
         3/6lskeSZGOgQ46UHrFJX26AnkYBqyRw/Kk8w5d7UbhdGyrYlZ1IKB9MdAXQFhuQ8EOb
         eeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=1+CQ2qGbdFGpwZNB8QkyFli2y0KOrjYpLjYZV+rhhQs=;
        b=IIoWNyCyw7DPyue3SkkoJWyFJ36z/1uGsIopJ0oJOxxRIq72zjHcP71nqKYQVI/e7N
         i/vllgYTV3Cv0TaJ23ywgK3cXJl1eMzZM1XpaQSgo+ZEAAr8czAbOiZixTQXXEmbuNG6
         4+p9vO10KOOwCSoJu0Gx7bLk2lerHV8z7oZQg9Fm41dr6hT7JNagXgghEbxTNWqfpfSt
         WFExJ4kkKmevctt0aX1NXZ2g39CNc8SRsuxThhRRNagCtxiNMIfY5P6EDditZPDDiMc+
         jQdV8tDYfg63T3YQ9OCKzzi+oryn+s5YhxOEUStMS1puV3/UPolq8lU9trWvP65qcRLy
         UbLA==
X-Gm-Message-State: AGi0PuYnkguClf9oDx3YIxS6GAn3CPPUOx+eg4nXcusScAFy8TsaRit1
        tQHLVesBYTcJkJFHtP5sBsojWA==
X-Google-Smtp-Source: APiQypJ1QLIMEvyyIrkSzW1DCy9SvYFrxmrcwP6dnNILMLBjU6dBIWq4e3iMb/jpvJrQe08G2dfdUQ==
X-Received: by 2002:a17:902:ec04:: with SMTP id l4mr3264758pld.6.1588318192568;
        Fri, 01 May 2020 00:29:52 -0700 (PDT)
Received: from selma.local ([2605:e000:1c0e:43f7:b590:149f:4376:a841])
        by smtp.gmail.com with ESMTPSA id c80sm1532390pfb.82.2020.05.01.00.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 00:29:51 -0700 (PDT)
To:     Alexandru Dordea <alex@dordea.net>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <CAJCQCtQqdk3FAyc27PoyTXZkhcmvgDwt=oCR7Yw3yuqeOkr2oA@mail.gmail.com>
 <bfa161e9-7389-6a83-edee-2c3adbcc7bda@ka9q.net>
 <20200501024753.GE10769@hungrycats.org>
 <b2cd0c70-b955-197c-d68b-cf77e102690c@ka9q.net>
 <6F06C333-0C27-482A-9AE4-3C0123CC550A@dordea.net>
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
Message-ID: <bc37ccb3-119e-24da-4852-56962c93fd2d@ka9q.net>
Date:   Fri, 1 May 2020 00:29:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6F06C333-0C27-482A-9AE4-3C0123CC550A@dordea.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/30/20 23:05, Alexandru Dordea wrote:
> Don=E2=80=99t get me wrong, the single 100% CPU is only during balance =
process.
> By running "btrfs device delete missing /storage=E2=80=9Dthere is no im=
pact on CPU/RAM. I do have 64GB DDR4 ECC but there is no more of 3GB ram =
usage.
3GB used for what, does that include the system buffer cache?
>
> I can see that @Chris Murphy mention that disabling the cache will impa=
ct performance. Did you tried that?=20
> On my devices I do have cache enabled and till now this is the only thi=
ng that I didn't tried :)


It didn't seem to make an obvious difference, which surprised me a
little since the I/O seems so random. Maybe btrfs is already sticking a
lot of fences (barriers) into the write stream so the drive can't do
much reordering anyway?

I've always left write caching enabled in my drives since my system is
plugged into reliable power. I assume the only reason to turn it off is
to reduce the chance of filesystem corruption in case I have to force
the machine to reboot while the operation is still going.

Down to only 1.99 TB now! Wow!

--Phil



