Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF591C0F1A
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 10:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgEAIFY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 04:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgEAIFX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 May 2020 04:05:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A633AC035494
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 01:05:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 145so1285693pfw.13
        for <linux-btrfs@vger.kernel.org>; Fri, 01 May 2020 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ozg91nPOjwomhxhkNPS7B3yszNnO5hyAkRvs4HAJNcI=;
        b=RresMSuWU5R7r1ZYLXbQ2FMm3fjZ2mRwWc3bwxgkzGUJ3dV8bPXUWgMin8gSbYleJU
         47u1rAq8IrlDzcdTNtv0m7cJ9GstxitQCnLymWJEaogUDTvNfk3R0WB3Js0cHxqKYIbe
         B6irmWLsUztT/IzhK/mc/E1UHnQc2HYTu6CuzjBX36L3IQow7/HOCynOdqaToODtOZ+G
         9TRMaQ4Abrnr1LnVvytwFsEPAuRO9TQAI8pS7QzqaYRy3wktsEhrdK7JG/aY3GQpaSTc
         MWo9dEWWLxXluAaxmkgZfJdKNESrhlaEITHaPPZQa3JzQ9xurM8tf/Bu/p5jJdUxujQc
         EJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ozg91nPOjwomhxhkNPS7B3yszNnO5hyAkRvs4HAJNcI=;
        b=fgFIBx6s5uk07aGnjJyoRyl3g1EtGDB5ZG6isxcEMWrB8cquRuhr3WqKIiHeGxa/UD
         IDZwi1Qic7POVfeYHPoYXBEA9rcuYrfweUj5NnDSKTrmHqjDA+rTvHTId50gy5M5+FXm
         qyN3J23NzI5M/1y0nhX5JKpcggin8FEW8tbSLyI8UDMv1GQ3yPEWlNjmvhIdfJbEuJgl
         pdl44Lu4UHhnC6NJ3t4fCGWBLD9SyFPFOSjy1v/6tT4kAYYqJzfHsx0Sa0yyFpp+RG2D
         OKEp6od0aTPDjmRajseMUrtvZjoIKC2NBoLKbJ5PEqPNlzTZj6BYCDepMEWy4eKoNdS/
         Q7yg==
X-Gm-Message-State: AGi0PuZmnxLbkjcR6DmldauziPABLiVbNgvqF1O2OkQ6ZuvgKYWZHxk8
        XAj8GDOau6t8+OXMvAUqe9xKgg==
X-Google-Smtp-Source: APiQypKvFcYxdtmshN00PClsNPPP/dM+6VslaLY27KST++Bo+/ChnhjpTTKHmfHmsw945SOnBF1sjw==
X-Received: by 2002:a63:1c1:: with SMTP id 184mr3135453pgb.203.1588320323165;
        Fri, 01 May 2020 01:05:23 -0700 (PDT)
Received: from selma.local ([2605:e000:1c0e:43f7:b590:149f:4376:a841])
        by smtp.gmail.com with ESMTPSA id s9sm1681100pfc.179.2020.05.01.01.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 01:05:21 -0700 (PDT)
Subject: Re: Extremely slow device removals
To:     Jean-Denis Girard <jd.girard@sysnux.pf>,
        linux-btrfs@vger.kernel.org
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net> <r8f4gb$8qt$1@ciao.gmane.io>
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
Message-ID: <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
Date:   Fri, 1 May 2020 01:05:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <r8f4gb$8qt$1@ciao.gmane.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/30/20 11:13, Jean-Denis Girard wrote:
>
> Hi Phil,
>
> I did something similar one month ago. It took less than 4 hours for
> 1.71 TiB of data:
>
> [xxx@taina ~]$ sudo btrfs replace status /home/SysNux
> Started on 21.Mar 11:13:20, finished on 21.Mar 15:06:33, 0 write errs, 0
> uncorr. read errs

I just realized you did a *replace* rather than a *remove*. When I did a
replace on another drive, it also went much faster. It must copy the
data from the old drive to the new one in larger and/or more contiguous
chunks. It's only the remove operation that's painfully slow.

Phil


