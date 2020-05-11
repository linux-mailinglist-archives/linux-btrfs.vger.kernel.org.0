Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674CD1CE85D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 00:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgEKWmt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 18:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727867AbgEKWmr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 18:42:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E812C061A0C
        for <linux-btrfs@vger.kernel.org>; Mon, 11 May 2020 15:42:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so5408166pfx.6
        for <linux-btrfs@vger.kernel.org>; Mon, 11 May 2020 15:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cxpi6+Ql8WyPn7pI41PjnRblY7F/8rNmhvOmT4usryA=;
        b=LBEZanI0T6OO+ol1WxK3gNqVdR1IlVBeMmyyerBRHt7HFZuX5MEgun5u30mCabKZYv
         +LxT7asKf43AXaAm+eKEo3peAyib7icpWNc0dKztU16tRkq9nLsQ/3nmsDRzvlPQZ/cX
         +P8U2kNHmqdQ9iKxbztJ+IQxwX6hlHoTbb5TChDH2kbgXfRiYSUyJagWXg4lvtSE4IOC
         n7pNb+pwvpYN/vv77fiU5Mee++W+3UkqUB9/bGv4dSbI0gRimKxol6+xQHzto7GtkT3R
         RU/4Fdkm0XdQQ1jO6AJ0ukylzSvJ4F/8t1wcpBvnEDJqJ1mDE8FoFNeRda3yTnjEn/ki
         zfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=cxpi6+Ql8WyPn7pI41PjnRblY7F/8rNmhvOmT4usryA=;
        b=pQSma6o34+osabr20NndkNMkLTLaeTi1s9e2/2kjjxLftg2l7nXN4cvNgdqyW1V3qq
         vCd1Qg1vdd6yvjQ9Kk4tig8D9Z69VJU+JAkNdvV2aqMMSW37wcdoUF2tuq+8CM+QLkOq
         QXXj6phz5bsf/mvFrcKF1/dM6PZJIjLRJGA4mRURUiveCu5WCg57obJvv1mr9hsNqamJ
         6nsI0cxs0PuisZ9EBhxV4KtsTU0UJ7Rofmm18Bqg/luw6qeoASjHLF7l+cLSS3OHE4Xq
         TGHS/y4FWxw6lsNLl1cQarJwj0MZQ85L0ZpXpn7yqD96G0J0M3paTY0NV/nXySIX6uOB
         oZ+w==
X-Gm-Message-State: AGi0PuYFPXGlwuSz+Fo0+6PJnkJ4U8tq4eTqg0zkJjfqCgLRfsuQWCSi
        YCLMyPuK55qd2D4MMyC/DxLXnA==
X-Google-Smtp-Source: APiQypLlCA9Nrwce8IWhMeN0GiXEwC3Pzh2tSV6h4tulRcYeS9rBiyCVjuslP0sxXO6HbydzZ1Ov5Q==
X-Received: by 2002:a62:fc82:: with SMTP id e124mr18545361pfh.126.1589236966947;
        Mon, 11 May 2020 15:42:46 -0700 (PDT)
Received: from selma.local ([2605:e000:1c0e:43f7:44f2:4528:c5d6:d9d4])
        by smtp.gmail.com with ESMTPSA id d4sm8269278pgk.2.2020.05.11.15.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 15:42:45 -0700 (PDT)
To:     Alberto Bursi <bobafetthotmail@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Steven Fosdick <stevenfosdick@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Rich Rauenzahn <rrauenza@gmail.com>
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
 <20200504230857.GQ10769@hungrycats.org>
 <f7ae0b64-048d-3898-6e2d-5702e2f79f47@ka9q.net>
 <CAG_8rEcdEK4XAx4D3Xg=O38zfs85YNk-xhT_cVtqZybnKXBkQg@mail.gmail.com>
 <20200511050635.GT10769@hungrycats.org>
 <bb237d74-49ab-27e0-0286-5bdd880dd2cb@ka9q.net>
 <69847faf-5fb3-9eac-b819-373a0f814044@gmail.com>
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
Message-ID: <9bbad15c-1bd1-e91a-ae50-bb1e643c19e2@ka9q.net>
Date:   Mon, 11 May 2020 15:42:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <69847faf-5fb3-9eac-b819-373a0f814044@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/11/20 14:13, Alberto Bursi wrote:
>
> Afaik drive-managed SMR drives (i.e. all drives that disguise
> themselves as non-SMR) are acting like a SSD, writing in empty "zones"
> first and then running garbage collection later to consolidate the
> data. TRIM is used for the same reasons SSDs also use it.
> This is the way they are working around the performance penalty of
> SMR, as it's the same limitation NAND flash also has (you can write
> only a full cell at a time).
>
> See here for example
> https://support-en.wd.com/app/answers/detail/a_id/25185
>
> -Alberto

Right, I understand that (some?) SMR drives support TRIM for the same
reason that SSDs do (well, a very similar reason). My question was
whether there'd be any reason for a NON-SMR drive to support TRIM, or if
TRIM support necessarily implies shingled recording. I didn't know
shingled recording was in any general purpose 2.5" spinning laptop
drives like mine, and there's no mention of SMR in the HGST manual.

Phil



