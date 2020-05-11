Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2041CE5A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 22:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbgEKUfL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 16:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUfL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 16:35:11 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09820C061A0C
        for <linux-btrfs@vger.kernel.org>; Mon, 11 May 2020 13:35:11 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r10so4592503pgv.8
        for <linux-btrfs@vger.kernel.org>; Mon, 11 May 2020 13:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Gf2pLzzl58WqUJk6BrV1pWD1t132/cJ4drhLlLm49ng=;
        b=njGOQphdzG2M8q9GDyv4o4IDUEhKLfa67PzxXM8n2+6/qip9ZkoT3QfcdT0K3yb0he
         aB1rnz3qo9e69Dc+BWhtyp+PL0NbiQbRsY+BNVKMLXo7pDYxyJAlooEPaCjvST59Li4I
         XrsF0vurArbF0q25KYfvbMmx4kCwu4g9dUIb4cmmeQChYkM7tovxhFHadLfRJ01N6AnU
         SsmKsfwmIyngJA8869RcfwqV0mNAAi2Oxmvo4QjltMLd+8Av4j9qOi4w+HpsHLpJNiUP
         +rlc9sL9FLOtT4oCM2BA+23mZmy6gMAOHcSdnQPpVr+NgG6MOx2JNGnwHetM+WD/wk9v
         7ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Gf2pLzzl58WqUJk6BrV1pWD1t132/cJ4drhLlLm49ng=;
        b=iPKAIBHhTovq1rxLTEUY9BcF2/E8ObCyG0vv9Www3I6EbRWAbH+UaLHxFM9fmRPOqy
         oRfeovCpXJUW9EPrZQdEu8nkmp+G5mReH841ilL1Y+pc8rLxZQefmeds39JP6mONkB1U
         Zip2VTLurALpTnIIFovHKetU4cFv4cT6BfFkEcut1ucEhvSn1+shJwPPCR/s6RXGan0c
         W+GJyWh1pZ24mC3RvarhxWi4AyEgkwG4Rn4U1UaRRXKLoTu6pEAEbP3lDQQRdW7+WCPG
         a2sDxrFQwAxy2xOigXJBKtlZ0AOoWdOd7ExUgcE4FWjN+2AZIxIhQxntPev0FB209AvD
         KZVQ==
X-Gm-Message-State: AGi0PuamMwiiSOm//4owIMJF5nXASrp8Z2J+W6hRlkQTYTO4j33lXqPm
        DtWAHEiCD9pPSLWR8rYf9eCIWQ==
X-Google-Smtp-Source: APiQypLLwA0aR5Rus11lwhwNXlqZgjVZGh2i9Nw53aJEdU4VbKxf6oj/dN7z0FkamsyWkm1lWvevUw==
X-Received: by 2002:aa7:8b42:: with SMTP id i2mr18467476pfd.21.1589229310459;
        Mon, 11 May 2020 13:35:10 -0700 (PDT)
Received: from selma.local ([2605:e000:1c0e:43f7:44f2:4528:c5d6:d9d4])
        by smtp.gmail.com with ESMTPSA id b8sm9681406pft.11.2020.05.11.13.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 13:35:09 -0700 (PDT)
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Steven Fosdick <stevenfosdick@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Rich Rauenzahn <rrauenza@gmail.com>
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
 <20200504230857.GQ10769@hungrycats.org>
 <f7ae0b64-048d-3898-6e2d-5702e2f79f47@ka9q.net>
 <CAG_8rEcdEK4XAx4D3Xg=O38zfs85YNk-xhT_cVtqZybnKXBkQg@mail.gmail.com>
 <20200511050635.GT10769@hungrycats.org>
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
Message-ID: <bb237d74-49ab-27e0-0286-5bdd880dd2cb@ka9q.net>
Date:   Mon, 11 May 2020 13:35:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200511050635.GT10769@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/10/20 22:06, Zygo Blaxell wrote:
>
> The exceptions would be data extents that are explicitly deleted
> (TRIM command), and it looks like a sequential overwrite at the _end_
> of a zone (i.e. starting in the middle on a sector boundary and writing=



Do these SMR drives generally support TRIM? What other spinning drives
support it?

I was surprised to recently discover a spinning drive that supports
TRIM. It's a HGST Z5K1 2.5" 5400 RPM 1TB OEM drive I pulled from an ASUS
laptop to replace with a SSD. TRIM support is verified by hdparm and by
running the fstrim command. There's nothing in the literature about this
being a hybrid drive.

Doesn't seem likely, but could it be shingled?

Phil



