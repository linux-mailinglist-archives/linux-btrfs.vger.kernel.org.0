Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9C71C03EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 19:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgD3Rbt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726285AbgD3Rbs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 13:31:48 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535E2C035494
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 10:31:47 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s8so3072968pgq.1
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:references:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Zk9o6RLHBWQ+gFH9WT3L9UGZ/xA+URtlRWc+RjhwztQ=;
        b=FN1NIgBA8XzAr472jrkTYKRcptDtfnlAuKms+C6pvZvFGDDcMe63BplIBP9bJvGgzL
         17J4n5DGG/QjOOWzrok53FvlGvJAjluaPeHuqJrkJ9XYSwO5mPs2zmPxnipwrGokcJdq
         SUsqyeeG7I7GZE9z4Y4RZlA23GnjAjHM3GGHNc8aAdvOGH8gMIxQQkFIqb8j2jH9ZgDR
         vR/b6P4S6DgWieN8XeA55mVPzp5q8SPUxPQBvlkwtASUcyGLSsjO0tsSEGCvHdAXxFuN
         tE1clCZiuhWRKPuyeaiamXWELWRvoTcuG9dk320tag6qHMOWsL/7u+eQxBShCjxk6LcO
         OS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Zk9o6RLHBWQ+gFH9WT3L9UGZ/xA+URtlRWc+RjhwztQ=;
        b=TXwE/Ky138grFm3lCTPIUarysRvN/cn86ePUcvhilUZFQ146Zs5gfuO7zReg7FmA95
         Lk6Bmrn2AIfZ9YfBvq3ANAgNyMwPtBcOa7wSqLvr0S4jtzWUl8+S+Dzetb3/Ipi9wLGs
         G4z09Dt3J+Wte5o5nzHtx1mBUZvwrGtRJhPNq6wWoDLfOZ0ruYlIpetjuoHuHIVtoGet
         9EGBhAX7iXuRwos+Sz2xzSbDhcdwcdIU0aRbVo/jeNJg96sQ5NAs52bm9btZjg9sfAC+
         7VitDz7DscW55M9V8+fg0oP6OVjbku3S4u5roadwCNtsKCRBneqN5Mff5iCJwn4D6hAR
         BsRQ==
X-Gm-Message-State: AGi0PuZBIGtDmZEAwni7sB/3AwkBaasYu8xADkiCE8gBQEwOwetI94Nl
        JgnFEoDFaUFIn+FXX3iiWGh+Dw==
X-Google-Smtp-Source: APiQypLjH3IXY3UI1oegsUibaJ2UpqcAxKwzZz1HGzjz7f1R5lkU6+o2rGEDtdNJQMxQY8po6n88lQ==
X-Received: by 2002:a63:745b:: with SMTP id e27mr4096166pgn.195.1588267906729;
        Thu, 30 Apr 2020 10:31:46 -0700 (PDT)
Received: from selma.local ([2605:e000:1c0e:43f7:85d2:c317:ef64:6afd])
        by smtp.gmail.com with ESMTPSA id kb10sm414206pjb.6.2020.04.30.10.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 10:31:45 -0700 (PDT)
From:   Phil Karn <karn@ka9q.net>
To:     linux-btrfs@vger.kernel.org
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
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
Message-ID: <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
Date:   Thu, 30 Apr 2020 10:31:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Any comments on my message about btrfs drive removals being extremely slo=
w?

I started the operation 5 days ago, and of right now I still have 2.18
TB to move off the drive I'm trying to replace. I think it started
around 3.5 TB.

Should I reboot degraded without this drive and do a "remove missing"
operation instead? I'm willing to take the risk of losing another drive
during the operation if it'll speed this up. It wouldn't be so bad if it
weren't slowing my filesystem to a crawl for normal stuff, like reading
mail.

Thanks,

Phil




