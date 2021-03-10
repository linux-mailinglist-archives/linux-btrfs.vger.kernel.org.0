Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EEC334288
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 17:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhCJQJ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 11:09:56 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:45167 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233045AbhCJQJy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 11:09:54 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D5C552612;
        Wed, 10 Mar 2021 11:09:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 Mar 2021 11:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:cc:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=V
        W6fmXcS/MtnhMGI7NADUuLdgWR4B96niA/sXIIdbmQ=; b=gpVVV4uNYTiWp2P+G
        7A4YSZ3mxj1dJs6AtVqKeUgTTys/yN8QCAH0boPuOiS3Kj1kLi48/bL6+0S5UizN
        RtyVBcE/2PTN8ia9Gp9enu/uaId6vU6D2KtmgqB36tAOMRrwFtFKAy0hviy7MhIj
        beSkZnxmq3PE7LXeJBn76ldQ+JKuApFZX7cAJnnGK8or3MSIiL4PRWrmajhNpSTJ
        FQIEgVsEbBqqtiZzqGqueMUwhM40yS5Um8dU+tgWEJ4aGWLxL/7GwgWPKMGcqEs2
        4Gb/xPRO/AvGl4/EC9afa9MKM/Hx0q5uR7x/t7+cjA3Iown3/XxknTpvRnXw0bu9
        5vOig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=VW6fmXcS/MtnhMGI7NADUuLdgWR4B96niA/sXIIdb
        mQ=; b=IO3//tIBxHvSyJEFYrl570AoEP38PrfCQ50oGkb8L+UwisrnjCXnTJlop
        2sby4XkzjCmk5FeZMmwHksc97lABD208MjGbiI6rM2ar3QtwN75dVXCA8DXMjzbT
        VFWyuF79MCH8fOAVoZrp9Eia207jWAKUpxCZaJyWoDuSnf590CC+RUNAJ1YkR8b1
        NfTdy2jdXu/guUYazDkU64P0YXYuP1MkETgvimc2IkLB9nMBEmCvz0ZJ5DamSXux
        SEFoiIaPG2LZB60s1lphyGpQ1IuuVVDc8Dljz9gn6+qenU+6HBZgbDBG0mpPUquW
        nkgnZ7Yz5nGDajHw4W4qY/FKrDKaA==
X-ME-Sender: <xms:Ue9IYNClDVoes3Xyig0li-qD3szShdBCY6LL_18yONmQcGUtSnZwHw>
    <xme:Ue9IYAENBLmYvQ3PAD-5digSCoqNDkSkGEueegx_7LkOBkdbtVTiJUmB2nx3K7Bbc
    QyTcYAvPcqDIA-gMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddukedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtke
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhephfdtueehgeevheettdehjeffgf
    etffeuudethefhveffteevhfdvffduudduiedvnecukfhppeduledvrddtrddvfeelrddu
    fedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprh
    gvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:Ue9IYFvvNIb14KK-DiTEKaL3d3EyoEYxJ3HADdZnE7MtWld4uw5QzQ>
    <xmx:Ue9IYOk8NYjK-cExp0u5U3GEYWQm8sqmuiXJionS3xFQtwZHbBalXg>
    <xmx:Ue9IYANaZY-sU4lUylL4b6s25ujH0-3VGSNfcsyVQG4WBr85cT7vuA>
    <xmx:Ue9IYHtD_2226CKqBR9Q3A2GnxpTBGAsWyBmnSM3Ce7hFeobiHIYmw>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0108C240064;
        Wed, 10 Mar 2021 11:09:52 -0500 (EST)
Subject: Re: Aw: Re: no memory is freed after snapshots are deleted
To:     telsch <telsch@gmx.de>
References: <trinity-e300b8c5-315a-4823-8664-4f663481461c-1615378067176@3c-app-gmx-bs66>
 <3f1ef2ea-04db-479d-d1cd-f64892de6ef1@cobb.uk.net>
 <trinity-a0ab6866-d05a-4626-8bb3-833e89b6d5cf-1615391386529@3c-app-gmx-bs58>
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
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <13a7fd3d-d304-94c0-97bc-8b2411019071@georgianit.com>
Date:   Wed, 10 Mar 2021 11:09:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <trinity-a0ab6866-d05a-4626-8bb3-833e89b6d5cf-1615391386529@3c-app-gmx-bs58>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-03-10 10:49 a.m., telsch wrote:

> 
> Any other ideas to fix this?
> 


We can check that there are, in fact, no unexpected subvolumes.

btrfs sub list /

In particular, I wonder if you have subvolumes/snapshots hidden behind
the mounted subvolume.

Also, I don't think it's really the case here with only 16GB reported by
du,, but do you have any large, heavily fragmented files, such as VM
virtual disks?  Without defragmentation or compression, I've seen those
consume more than twice their reported file size on btrfs.






