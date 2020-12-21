Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BB22E0189
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 21:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgLUU2r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 15:28:47 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:54063 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbgLUU2r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 15:28:47 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D7EFD9D7;
        Mon, 21 Dec 2020 15:27:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 21 Dec 2020 15:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:cc:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=R
        v00YtJ1PYG0SPds27KdQxWmrdkH8oJOZVHJAIHaGkE=; b=FXZe71dGsoiAhhKGn
        vnZ210Kmqt3jA8mjGjwlvDcFkLjQSmsqNXD6dN//bpD3eoAKdZlaszxAWw+SLp//
        EoG98as6WErq94RaV4QiORMNFhcG+3L9cCvGoeumNmjiSofNUFM1YLnFJi3+LbyJ
        vFd3r4sg8vqLOuLYLjGrspUs2l1f6W/U+Quof/zLTq7Y5ZarY4Bdt5ITrdoARPAU
        3VU9qbys8uZDV+syAl/Lfyiuocx2E1y44ETx3fIAE+0TCMUOCP9U14Cys3Ke5RgW
        oHUEAvVF8MJsIvBLQaAj/Q1fIGcmPtr2V1W7kj1RZd8zpdsnTbRJ9NSQPvGQorPr
        OsROg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Rv00YtJ1PYG0SPds27KdQxWmrdkH8oJOZVHJAIHaG
        kE=; b=oWa1vmNjz0s2chlOq6CH8fOlWpJfjDZaVAkP214OAuk6vKzylSg+u3Lwf
        FBbNowAO/mPl1N/GVhlaUUVwJxXIwJ62fhmdt1Y1PWZj5Uzr0SehAh9doT3TRtmQ
        I1md/yGzfKvGPvTDk3utmHPKIBNjN38OhpD+HB38vr0OQWzmLQBT0/DEDFDOo3lJ
        sZPKB8d2mlIVvsPHpSzROWtSoLxFsoZxQuPbqDEf9++zh1m4VQ8kk+p2MFvKNSV7
        C6me+eKd6tmTL7wBt4uE1t/1lXdTDcR35tMeO06EjaMkFhh7qfoIb2pvoccZYTq1
        0jzl878RSSuJUHJ4rP30ztCh8qc/w==
X-ME-Sender: <xms:PAXhX_DsE4OS4i7FeVPjvVsFnZtu_4qE-tFdw_nOF3I9XF1PWm5h4A>
    <xme:PAXhX1iekYve71y6PESuxy67KD9kx_yJ2izrVZF8PwF02HAF6kT1tfEfwn1L44rF9
    z3o_xytRTSO6UjB8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtvddgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesth
    ejredttdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhr
    ghhirghnihhtrdgtohhmqeenucggtffrrghtthgvrhhnpefhgfefuedttdduhfdujeekje
    duveeltdduueffhffhueekjeekkeeitdffhfffieenucfkphepudelvddrtddrvdefledr
    udeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hrvghmihesghgvohhrghhirghnihhtrdgtohhm
X-ME-Proxy: <xmx:PAXhX6nTw4F5i2LYECXTZvG7WZlEfaGkPOMbwEk8qo2kGKljrMsh3w>
    <xmx:PAXhXxxhOiOjoh2SQ27XxcMtog-30mBjH5CSbGSd0fTqU0XQSCTrDg>
    <xmx:PAXhX0RFLn0pG7h82kAdaL5srd14GK3PC6jeqtqUyM2gdBPNzhJ5-g>
    <xmx:PAXhXzNEmmnAj0472hyRvkaBjZCYj__x4mBQqP4SBAgVNrtmhDZaLg>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 098CD1080064;
        Mon, 21 Dec 2020 15:27:40 -0500 (EST)
Subject: Re: WG: How to properly setup for snapshots
To:     kreijack@inwind.it
References: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>
 <20201221223701.0845e9ad@natsu>
 <108a3254-f120-b5fe-2b7f-f363cbe34158@georgianit.com>
 <de2abd3d-1306-59b3-2ed6-23f03fc443df@libero.it>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Remi Gauvin <remi@georgianit.com>
Autocrypt: addr=remi@georgianit.com; prefer-encrypt=mutual;
 keydata= mQENBFogjcYBCADvI0pxdYyVkEUAIzT6HwYnZ5CAy2czT87Si5mqk4wL4Ulupwfv9TLzaj3R
 CUgHPNpFsp1n/nKKyOq1ZmE6w5YKx4I8/o9tRl+vjnJr2otfS7XizBaVV7UwziODikOimmT+
 sGNfYGcjdJ+CC567g9aAECbvnyxNlncTyUPUdmazOKhmzB4IvG8+M2u+C4c9nVkX2ucf3OuF
 t/qmeRaF8+nlkCMtAdIVh0F7HBYJzvYG3EPiKbGmbOody3OM55113uEzyw39k8WHRhhaKhi6
 8QY9nKCPVhRFzk6wUHJa2EKbKxqeFcFzZ1ok7l7vrX3/OBk2dGOAoOJ4UX+ozAtrMqCBABEB
 AAG0IVJlbWkgR2F1dmluIDxyZW1pQGdlb3JnaWFuaXQuY29tPokBTwQTAQgAOQIbIwYLCQgH
 AwIGFQgCCQoLBBYCAwECHgECF4AWIQSSAGs/9alRnpiyqu3vU5/yR0VqbQUCX0/x5AAKCRDv
 U5/yR0VqbQ7KB/4+uGx/8cGdUrEhF3z6uBzvGrEfRoPLC6rLzjYntv9WC/s5IvaN1JY21D0e
 eJ69jh6tWOUCsD9X3J2tqGGs7LoRsK7UASFp7yYBVAvnjk103rZur7whHiT57/Oc5DEghXHK
 xs6w6YW4kPlJpe4SiPKK99f3PoZKthCdmLApUGHz7ROCbOXumpxZR3Em2LaGU8MI/R1eMCwK
 agzPl3dQGxcVlerDyCAtF1MzMw7LS/pAT/jxuEoq6hbkZ9/ZnCQomQe4CgWkmoD5Ec7p1FCI
 jqU5RO467uF0vkeTU6F+n2/qA38M0FAhYwZU+/hlqP8OYey2X0PuHDzw03P95hcpEi52uQEN
 BFogjcYBCACjRjoVfzhCwOlHyQUSoyGmSN5VClvBiGoGAgUlPlwExClmweac6ClhTQmjw/ej
 AdQW7nr2DqPj7BK5tuHb5u1YvRCgVlyeDRrb+Peof3yD2UCfxmCiHFq+bBgg23tv4sR4OgG+
 rSz/Rl5fHjsw6ZuNE6rwv+BA5hshagks7Z6bLGZWjUWDTQUqRu4ISAk9bxT/tVfgQVhoiE9C
 /8reamfJZcirmW+KIwIfPESPMGH/fkNMvDKYN2a3NaBy7WvNnqPaz7htPETyZhd3iXZeiefu
 /jjyDC9CZknwQ+mU7+lZ70WghLKI3FmdA0JUQ72Uxqco8WmF9UeonVYS1gyIvFORABEBAAGJ
 ATYEGAEIACACGwwWIQSSAGs/9alRnpiyqu3vU5/yR0VqbQUCX0/x5AAKCRDvU5/yR0VqbdSW
 CADCAV68zw465qHEouJbrMLlm6jWFM7qNt0/us5KyDmxHm64x0dzHWNtlfklZ2OO3llgem9V
 8JqVU335usScXKfp9PERa8MfK06XCYC9+TgBwsH6N6XM3HuWlvRQctqg/tPj8JGvo+PnOnB7
 OpLaIsONJXJApKNKcQxu5ZazZB4Wa5MTgqta6A7Ue1zVkoIPI/fQXlIUuWLaL+x5SMisHeLr
 MYwpA4h8UI3Wj8m1uO8+GKcwe8O/77o2H6PufoLHc4/MmODExRgxNZ48F2DZFopBT8RQO8Hv
 2zadWA60y8/LX84GsNS7IPYrYZ10NCXOt8a1+wcSaCVYRm24Yc1/Fktj
Message-ID: <e4622aa3-2c38-f389-1e2a-aa29009f9b5e@georgianit.com>
Date:   Mon, 21 Dec 2020 15:27:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <de2abd3d-1306-59b3-2ed6-23f03fc443df@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-12-21 3:14 p.m., Goffredo Baroncelli wrote:

> A subvolume can be moved everywhere with a simple 'mv' command.
>

No, they can not,, try this again with a *read only* snapshot

