Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3A91C2965
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 May 2020 04:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgECC3A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 22:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726544AbgECC27 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 22:28:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87B3C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 19:28:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f8so5339802plt.2
        for <linux-btrfs@vger.kernel.org>; Sat, 02 May 2020 19:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=u+XnCy7+6Zp6eFo/6HxaetusSiv7fv+3YD7tpdTlr9g=;
        b=b384xmkJh2bY7dKvMV1MRo0pRr5FOTcb6f8Is6fvMIzvUJFcWCygvlmaVa9dutKaCh
         Fht1Jq2d0Pe5iPHXwMe7pCNbx6jSiGYWdxmQ/kA/zg7D/KA2GzQ5V4iqoLghKXmTHPKw
         cVbpoCn+gUrOAomOG7OMkkezirsDLoYeGRyAqpyxXuhetw+Nc72Frdo2ldzSXcxRvIDk
         ACCQKK4Aw1Jm+7VdwDB9SL2ji8x1JGTLf005zKrLs6+MYvJdk26j8qVcRqvY0/MLNmWz
         TCu1b5/sck+efzE3w1otvT87MZTDRpLOjGca9bshYYj9XFi3n7evrAhH7EU5kblKpK4P
         k5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=u+XnCy7+6Zp6eFo/6HxaetusSiv7fv+3YD7tpdTlr9g=;
        b=HjvpnQXF08V3BkUYJkCzdyFwcdSeGw8s7oRSx8vawSUhL4yZ3T/qSb3OoKvQ7Q7zqV
         ys21YnZUCyekd6Z9pTzz6SUfDG24Z97a2eqPdXt+Ljof9Vn2Hwtxiq1gDJ/95LiJt6SY
         TX4dk39aw/yUu+I7pZ6KEt1EahXi+VOjeR1omyTSrP5aLo5MDI5FlyO8QXOxB17PzoYl
         zOYaWSKl5OoLhbtjMv1roIcTVFd/5SdcJTjs6nvfSWpECaXAXc2PCRATXSMw6EwT+3w5
         VRbS0kRcK63dEQefpR3Pwd6zLScIwYNlqUOpQjI61oBeBqwjbZ2PGlNBXLgAa4t4mFpt
         wqDw==
X-Gm-Message-State: AGi0PuZ0lt86EH2EUogWU4L2riS51vx46pSZgR2OoKneaaZzUGhAjXXB
        DYRN8fh2rcHE498NzT4U0oItltHNAqtIEw==
X-Google-Smtp-Source: APiQypK/NgXO1BN4Z81q0DFXEtEOYXIiBjoKINAiKq/ibnFeiMkfrJhwRtDK3Pz2vy1NEW1OVxQJew==
X-Received: by 2002:a17:90a:23e2:: with SMTP id g89mr9014261pje.105.1588472939067;
        Sat, 02 May 2020 19:28:59 -0700 (PDT)
Received: from selma.local ([2605:e000:1c0e:43f7:55e4:6827:c5ab:4f6f])
        by smtp.gmail.com with ESMTPSA id q14sm4888150pgq.60.2020.05.02.19.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2020 19:28:57 -0700 (PDT)
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Alexandru Dordea <alex@dordea.net>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <CAJCQCtQqdk3FAyc27PoyTXZkhcmvgDwt=oCR7Yw3yuqeOkr2oA@mail.gmail.com>
 <bfa161e9-7389-6a83-edee-2c3adbcc7bda@ka9q.net>
 <20200501024753.GE10769@hungrycats.org>
 <b2cd0c70-b955-197c-d68b-cf77e102690c@ka9q.net>
 <6F06C333-0C27-482A-9AE4-3C0123CC550A@dordea.net>
 <bc37ccb3-119e-24da-4852-56962c93fd2d@ka9q.net>
 <20200502041826.GH10769@hungrycats.org>
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
Message-ID: <f8435e33-686c-e9c0-313e-a00e526a2b49@ka9q.net>
Date:   Sat, 2 May 2020 19:28:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200502041826.GH10769@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/1/20 21:18, Zygo Blaxell wrote:
>
> Also, in large delete operations, half of the IOs are random _reads_,
> which can't be optimized by write caching.  The writes are mostly
> sequential, so they take less IO time.  So, say, 1% of the IO time
> is made 80% faster by write caching, for a net benefit of 0.8% (not rea=
l
> numbers).  Write caching helps fsync() performance and not much else.
Thanks for everyone's help, but listening to everyone else also talk
about taking weeks or months to delete a drive, with terrible
performance for other applications because of all the background I/O, it
really looks to me that despite the many theoretical advantages of
integrating raid into btrfs, it simply doesn't work in the real world
with real spinning disk drives with real and significant seek latencies.
Btrfs is too far ahead of the technology; its drive management features
look great until you actually try to use them.

Maybe I can revisit this in a few years when SSDs have displaced
spinning drives and have made seek latencies a thing of the past.
Spinning drives seem to have pretty much hit their technology limits
while SSDs are still making good progress in both size and price.

In the meantime I think I'll return to what I used to use before I tried
btrfs several years ago: XFS over LVM, with LVM working in large
contiguous allocation chunks that can be efficiently copied, moved and
resized on real spinning disks regardless of how the file system above
them allocates and uses them.

I do give btrfs considerable credit for not (yet) losing any of my data
through all this. But that's what offline backups and LVM snapshots are
also for.

Phil



