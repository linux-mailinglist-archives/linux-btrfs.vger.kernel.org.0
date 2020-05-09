Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15E21CC49F
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 23:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgEIVBj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 17:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgEIVBj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 May 2020 17:01:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62AFC061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  9 May 2020 14:01:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a7so5833175pju.2
        for <linux-btrfs@vger.kernel.org>; Sat, 09 May 2020 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nuuqKIef0dkAhdyafInT3psd0fQzs7IX2Q6WtONmTO8=;
        b=Iw8Qecz4kCtD1rvtLj5l3Qd0NSpzyhQwqK3QUIuNj82FucRDv377bV6fZ+lKOFGjc0
         LT9csz0sVgsLNKSXI7EWZ+4xgcyYFajA09fGXjqDsyLv/6kRg5sFh0Kr0f7aptnSRBMB
         OZOHp2JD8uFjmSj1Mlk9LYuqTYnHaCBPuuH4LH5KqFm2rmS6qUO0E6xbQwxn1/0qkutr
         P7WRibe4ieCkjkW7SRbsUh8H8TJi8/wT+0e/YwutrOpwpySz9B+NnAyPjhOfoITiii3+
         RDIt8T/UTUfxzCJYUBroCNRHckijXOMxR732PhGK+ZoVu6lEc1MhOWCU6u4r83ifp4qN
         71Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=nuuqKIef0dkAhdyafInT3psd0fQzs7IX2Q6WtONmTO8=;
        b=pnYBufNjq3sUhXhYpXjAN7VE/eG922PyaDlOTQ2PnSmGxE9CQMRlYTvonSl2y1TBC7
         Eer45eF24ctK4VvI2nWdaY/JXUOOryKEIrmA/eHSPBWtdAle6HpV0+0FysR0YQcHbqzM
         bb822qvo/uMQ3SkQjfceOC5Aa34t+YWtndyeWwiH3NA9Tb9kv1W3FYdZjgEpMfi07U/X
         SWLv0C04rihUmh4aas+SBfzftThDiool+e3k4Tg4ICdNLJxBXQhprijLoHdqp9NOrMjB
         R4LcXZ1GuYe/5YlL3OR1Uj8Yk47dQo0FTXll8NZjyy+DYJIAQnaYz7ZhBcY+uVFbgeD3
         +vLg==
X-Gm-Message-State: AGi0PuZbjC72pNQZmWqQ0r2eEjVPyH9ocBCHSC8lsjxOsJwWNX+7ntDy
        VoCVG2soX4Rv9iMrz5fTLpa2rg==
X-Google-Smtp-Source: APiQypIiouZFdUo1azF3eShVtnXkM9+WWE906R1r93uwBrf249LPDgRHfBSggklMALrZ/PPj7kiLww==
X-Received: by 2002:a17:90a:e2d0:: with SMTP id fr16mr13156409pjb.146.1589058097034;
        Sat, 09 May 2020 14:01:37 -0700 (PDT)
Received: from selma.local (cpe-76-167-209-94.san.res.rr.com. [76.167.209.94])
        by smtp.gmail.com with ESMTPSA id 82sm5230617pfv.214.2020.05.09.14.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 14:01:35 -0700 (PDT)
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Rich Rauenzahn <rrauenza@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
 <20200504230857.GQ10769@hungrycats.org>
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
Subject: Re: Western Digital Red's SMR and btrfs?
Message-ID: <f7ae0b64-048d-3898-6e2d-5702e2f79f47@ka9q.net>
Date:   Sat, 9 May 2020 14:00:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504230857.GQ10769@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/4/20 16:08, Zygo Blaxell wrote:
> The basic problem with DM-SMR drives is that they cache writes in CMR
> zones for a while, but they need significant idle periods (no read or
> write commands from the host) to move the data back to SMR zones, or
> they run out of CMR space and throttle writes from the host.

Does anybody know where the drive keeps all that metadata? On rotating
disk, or in flash somewhere?

Just wondering what happens when power suddenly fails during these
rewrite operations.

>
> Some kinds of RAID rebuild don't provide sufficient idle time to comple=
te
> the CMR-to-SMR writeback, so the host gets throttled.  If the drive slo=
ws

My understanding is that large sequential writes can go directly to the
SMR areas, which is an argument for a more conventional RAID array. How
hard does btrfs try to do large sequential writes?





