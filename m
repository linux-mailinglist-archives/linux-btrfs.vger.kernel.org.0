Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29992DFFD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 19:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgLUSd7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 13:33:59 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:39829 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgLUSd6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 13:33:58 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E74EF893;
        Mon, 21 Dec 2020 13:32:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 21 Dec 2020 13:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:cc:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=d
        m2YQ/+xM3pzUm8SVGDrEjnGpynJ8hqGn/z78OAFZZk=; b=4mSgxduFdKIDUP4/u
        uFp/DDLaVqzSGYciJilHy9/x9FDX1Dsxpq+PyAW/qMEDZAnA1S2XFZFmJb/hRNQg
        042O42+0AxAWbVgmHX6niB3BdN4x0LQg9f/+tYPquWzNG89dUrKqqDFmZ2SjbJ2f
        qfn5AxwJHZzoI6KsX2XLm5Ma4o6xCvqfARL/ZkDDJOfea7ImifGatKYnxHNVh/qE
        l9LP1F+7MK+LFJji0/ysQlRYinwYQZ7ATQUPfKBU+m/vtLjjaSXh1rL4h7gXDXou
        uiRJOVQ/gF1R4UBq1InJhiMB+41nbF/zODDQsaeIPEc+ggESGFpLv94UQDpNt1eE
        YwiIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=dm2YQ/+xM3pzUm8SVGDrEjnGpynJ8hqGn/z78OAFZ
        Zk=; b=MpY1tRFC3jAjTNLdSZQTix7xnZtT6GooMCx4lWJQJZd/RP6Kl2a2gO+10
        T9xsZYMOPf2y+FIAV0wxLWpBDAR8tjKe7yISmdUZIY/DkYUHdTraf0ZDY9RtZnYL
        fq0FDLrtMvC47/xIoHh9OCq1XJ8pktAzsj6YyGAILR5AmMSpyGEapiL9SxxUiQk1
        lYuTSlJCyvX+J1fK5zO5+tPpKyJBf4Tnc5bs3kURxol6C1Cg8yAbSJDGOuvsS7eg
        E10Oo1sUCA/v//F7S41WICtbzFQWJkZ5WrVeEdXO/ujou7oNBoY8dc6JPj1nExbh
        6LWZHNBgvAFI0qk2imgZgJ0uqCzlw==
X-ME-Sender: <xms:VOrgXxhztwrdnesfQO5xUJZWU-2o8GeMfilErvuENZVN0orMBS-MFw>
    <xme:VOrgX2CtmZNrBSouzh_cRne159Kih_Y0GfUuQk4nN6J9g7SkDK7pDSNTrnwZNX5Zf
    iFE_lsySs6GovdyRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtvddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeftvghm
    ihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecuggftrf
    grthhtvghrnhephffgfeeutddtudfhudejkeejudevledtudeufffhhfeukeejkeekiedt
    fffhffeinecukfhppeduledvrddtrddvfeelrddufedtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdr
    tghomh
X-ME-Proxy: <xmx:VOrgXxFqE_YJdzfDUHM7vOjdesJeUMdgmJa8MDznRp9nH3M32l3gUg>
    <xmx:VOrgX2TbHgLSIFJYGyTiVP5OvDXaXb8tn_nhdxa0ZjFbMX2iVB7yOA>
    <xmx:VOrgX-wFs9Tnes3gJQyK_uyLXL_R49sq2BAKTX-8KeLY7gZ79WrbUw>
    <xmx:VOrgXzssIphEiLDyAAUhC1MtHPmKetAwIMB-uvhNjsQQ2qJlSUOC0Q>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id F128E108005B;
        Mon, 21 Dec 2020 13:32:51 -0500 (EST)
Subject: Re: AW: WG: How to properly setup for snapshots
To:     Claudius Ellsel <claudius.ellsel@live.de>
References: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>
 <AM9P191MB1650AE92A25D9618163309E5E2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
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
Message-ID: <d93610c2-e8b8-0b79-90fe-ae8104130d96@georgianit.com>
Date:   Mon, 21 Dec 2020 13:32:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <AM9P191MB1650AE92A25D9618163309E5E2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-12-21 1:04 p.m., Claudius Ellsel wrote:

> 
> I still doubt that a bit, `sudo btrfs subvolume list /media/clel/NAS` (which is where I mount the volume with an fstab entry based on the UUID) does not output anything. Additionally I read (I guess on a reddit post) that in this case one has to create a subvolume first. That might have been problematic information, though.
> 
>

Ok, you got me there.  Technically, the file system root is not a
*Sub*volume, because it's not *sub* to anything... but you can still
make snapshots of it, just as I described.
