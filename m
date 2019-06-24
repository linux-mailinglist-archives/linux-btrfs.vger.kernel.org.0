Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 547EF4FF82
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 04:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfFXCpw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jun 2019 22:45:52 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54411 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726510AbfFXCpw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jun 2019 22:45:52 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 54DEB21B7C;
        Sun, 23 Jun 2019 22:45:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 23 Jun 2019 22:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=X
        Etz4xJYTciPLbiSPIJHaOr3iGsSSC8I5hEzp29hTLo=; b=mQVQ2uUCKi0HvlOzC
        3ipP/GEoajQW/gO+O+fvexBgS3sL2zGI7UzcQqK+Tjqb/Lx3cNcu9SPCT+/JI6XC
        PBiqlfRXzqzu+0hy5aSko8RNbJsjDopkQjHkQfdytah48e7uNrswilNzYV1T/MEB
        9DiR8bXUm96wYtJWz+mwfB1LL38o/ekt2E/PM49eytH54aOMRWvDHwiKvAh4fcvO
        tdAGLAWp0B9hoV5jwb5SUCK1SgI8VqB4gVF/rTKaYD3Wm6+IW+p+0D8olV/MrlNx
        A9PPEk7kwj2+fa1bebEWH4bqHb+W8NZspsp0ksQJgcr1IgXV7YO40isszbSFfhtV
        tLShA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=XEtz4xJYTciPLbiSPIJHaOr3iGsSSC8I5hEzp29hT
        Lo=; b=X2cs/6miNN7GmBVXBynOTH7gpO0D4+MDYCDs/PCVM66X8MNeLqUJeD9Qm
        jrATBtbH0fsYtQQssYnj9LqZ0d4zv46XBpaakV35SgZLUBcRZu7vPadXbYXliXNd
        23e0Xt1DWMS3IIhRU2225Glr0QqGbIkBUWIlsgJ03uNDWnQVke+FT9AEMjof7qJ/
        Y3Qe7iEc7LL4AWHiCjr4LYc7jdl4zpdCplVvB03GwwthKuVUhse2K19w/G4JC7t3
        Q4gSIsAgSEl4VxBwapGiPbDtlcalFha97EzbgQmBf3OGD7PyW/AO2AGVZFZirog+
        nW0/tAOn36jvpay+B75z8SD7bpm+A==
X-ME-Sender: <xms:XjkQXUqZ5qUg8b6YyWjRgrIfI6lnjEK-s5ds3ibJjbO2zxjtnGq7iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddugdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthejre
    dttdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhrghhi
    rghnihhtrdgtohhmqeenucfkphepudefhedrvdefrddvgeeirddufedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtohhmnecuvehluhhs
    thgvrhfuihiivgeptd
X-ME-Proxy: <xmx:XzkQXUBSYHF1SU08fM07vR-xyAnE9c2r9M442BADBuKi4-XtwCckKw>
    <xmx:XzkQXSUECzKrwQkrUmyNDYHuk8obQaBwa4b-aMCERJT-02QgjF2UwQ>
    <xmx:XzkQXe4vY1clXZCQqMB6tGLeVHu_79HlibNWblpJ_qYBxHxZPNGZpA>
    <xmx:XzkQXQY8XJSws8AwyCEaxlqArU9I4M5vmr35hFzpsNRFn4jHEJitww>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id AFA2F80059;
        Sun, 23 Jun 2019 22:45:50 -0400 (EDT)
Subject: Re: btrfs vs write caching firmware bugs (was: Re: BTRFS recovery not
 possible)
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190623204523.GC11831@hungrycats.org>
From:   Remi Gauvin <remi@georgianit.com>
Openpgp: url=http://www.georgianit.com/pgp/Remi%20Gauvin%20remi%40georgianit.com%20(0xEF539FF247456A6D)%20pub.asc
Autocrypt: addr=remi@georgianit.com; prefer-encrypt=mutual;
 keydata= mQENBFogjcYBCADvI0pxdYyVkEUAIzT6HwYnZ5CAy2czT87Si5mqk4wL4Ulupwfv9TLzaj3R
 CUgHPNpFsp1n/nKKyOq1ZmE6w5YKx4I8/o9tRl+vjnJr2otfS7XizBaVV7UwziODikOimmT+
 sGNfYGcjdJ+CC567g9aAECbvnyxNlncTyUPUdmazOKhmzB4IvG8+M2u+C4c9nVkX2ucf3OuF
 t/qmeRaF8+nlkCMtAdIVh0F7HBYJzvYG3EPiKbGmbOody3OM55113uEzyw39k8WHRhhaKhi6
 8QY9nKCPVhRFzk6wUHJa2EKbKxqeFcFzZ1ok7l7vrX3/OBk2dGOAoOJ4UX+ozAtrMqCBABEB
 AAG0IVJlbWkgR2F1dmluIDxyZW1pQGdlb3JnaWFuaXQuY29tPokBPgQTAQIAKAUCWiCNxgIb
 IwUJCWYBgAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQ71Of8kdFam2V1Qf9Fs6LSx1i
 OoVgOzjWwiI06vJrZznjmtbJkcm/Of5onITZnB4h+tbqEyaMYYsEIk1r4oFMfKB7SDpQbADj
 9CI2EbpygwZa24Oqv4gWEzb4c7mSJuLKTnrhmwCOtdeDQXO/uu6BZPkazDAaKHUM6XqNEVvt
 WHBaGioaV4dGxzjXALQDpLc4vDreSl9nwlTorwJR9t6u5BlDcdh3VOuYlgXjI4pCk+cihgtY
 k3KZo/El1fWFYmtSTq7m/JPpKZyb77cbzf2AbkxJuLgg9o0iVAg81LjElznI0R5UbYrJcJeh
 Jo4rvXKFYQ1qFwno1jlSXejsFA5F3FQzJe1JUAu2HlYqRrkBDQRaII3GAQgAo0Y6FX84QsDp
 R8kFEqMhpkjeVQpbwYhqBgIFJT5cBMQpZsHmnOgpYU0Jo8P3owHUFu569g6j4+wSubbh2+bt
 WL0QoFZcng0a2/j3qH98g9lAn8ZgohxavmwYINt7b+LEeDoBvq0s/0ZeXx47MOmbjROq8L/g
 QOYbIWoJLO2emyxmVo1Fg00FKkbuCEgJPW8U/7VX4EFYaIhPQv/K3mpnyWXIq5lviiMCHzxE
 jzBh/35DTLwymDdmtzWgcu1rzZ6j2s+4bTxE8mYXd4l2Xonn7v448gwvQmZJ8EPplO/pWe9F
 oISyiNxZnQNCVEO9lManKPFphfVHqJ1WEtYMiLxTkQARAQABiQElBBgBAgAPBQJaII3GAhsM
 BQkJZgGAAAoJEO9Tn/JHRWptnn0H+gOtkumwlKcad2PqLFXCt2SzVJm5rHuYZhPPq4GCdMbz
 XwuCEPXDoECFVXeiXngJmrL8+tLxvUhxUMdXtyYSPusnmFgj/EnCjQdFMLdvgvXI/wF5qj0/
 r6NKJWtx3/+OSLW0E9J/gLfimIc3OF49E3S1c35Wj+4Okx9Tpwor7Tw8KwBVbdZA6TyQF08N
 phFkhgnTK6gl2XqIHaoxPKhI9pKU5oPkg2eI27OICZrpTCppaSh3SGUp0EHPkZuhVfIxg4vF
 nato30VZr+RMHtPtx813VZ/kzj+2pC/DrwZOtqFeaqJfCi6JSik3vX9BQd9GL4mxytQBZKXz
 SY9JJa155sI=
Message-ID: <8e1b9a48-178b-4f93-6efd-e933ff1a4f54@georgianit.com>
Date:   Sun, 23 Jun 2019 22:45:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190623204523.GC11831@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-06-23 4:45 p.m., Zygo Blaxell wrote:

> 	Model Family: Western Digital Green Device Model: WDC WD20EZRX-00DC0B0 Firmware Version: 80.00A80
> 
> Change the query to 1-30 power cycles, and we get another model with
> the same firmware version string:
> 
> 	Model Family: Western Digital Red Device Model: WDC WD40EFRX-68WT0N0 Firmware Version: 80.00A80
> 

> 
> These drives have 0 power fail events between mkfs and "parent transid
> verify failed" events, i.e. it's not necessary to have a power failure
> at all for these drives to unrecoverably corrupt btrfs.  In all cases the
> failure occurs on the same days as "Current Pending Sector" and "Offline
> UNC sector" SMART events.  The WD Black firmware seems to be OK with write
> cache enabled most of the time (there's years in the log data without any
> transid-verify failures), but the WD Black will drop its write cache when
> it sees a UNC sector, and btrfs notices the failure a few hours later.
> 

First, thank you very much for sharing.  I've seen you mention several
times before problems with common consumer drives, but seeing one
specific identified problem firmware version is *very* valuable info.

I have a question about the Black Drives dropping the cache on UNC
error.  If a transid id error like that occurred on a BTRFS RAID 1,
would BTRFS find the correct metadata on the 2nd drive, or does it stop
dead on 1 transid failure?


