Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D652DFEBD
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 18:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgLURGp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 12:06:45 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59085 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgLURGo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 12:06:44 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 031B35C01CA;
        Mon, 21 Dec 2020 12:05:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 21 Dec 2020 12:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:cc:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=m
        twgHbYIXqD7C/5TZpxwJ+wyAHccYP7iHi4EGETM9mE=; b=OVevdtgj3rxQgC1z3
        Je7SqPngyOAKxak2+vQ35t/PItKiMyVgmfqn9gCIg6nKNmW9ykazrdeIZ+83WLqQ
        /cR0zbDM+rMqjips8Qsh+dLydsdzqEQQNQQtH5BYFK+3blxxZ229UgLWsnKYJDnr
        OadxJxEX+E8rYHi/1AI5meG/4slDBLRgYVN9ojtYFnLXfNsMVbU85ui07EvEImJg
        Up786KeHBF0/oyhp4ut9YtXM+MpVLtMahrWtro+bU3jnVopz7IN4lAVSbxObEX0d
        T/VPReQFavliEPm1XYgnwBSKUvl9NbhXy5ycqQ7547tq9YS2c8Gc4/8M2srMLZO/
        vLsTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=mtwgHbYIXqD7C/5TZpxwJ+wyAHccYP7iHi4EGETM9
        mE=; b=hoVSA8GFGpW0znWduOay854DFS4jNokuw3HEbpxc0EEhyaBX83WilMrJH
        ehNa+uGdLIddE3kMxuZLMPnsyWIyrC7iW0puuLkMRV4d8ISSnOyya3zSe5YTV/yy
        vo0FKR1rGxziUGUU4VUrys8N6+o4ZT8y6J+AHDPsaCUn+PR8XZY2k6m1fHuwJPpZ
        5hcRGydWyioFiVKLCW/CWZOazE4I/cgQPd7l3szGrPrQ+Nm5xyMSKiV/uKkMqMYv
        kKUfV0hOpTIx6g5JZDXY+MusKMnAux2yrrwTCkHD9O553gT+dg9CMspG3HpAoJSU
        iMOJQv1eKy+lJ4qnPv69CGb0UgxLw==
X-ME-Sender: <xms:4dXgX_dcetladxHJjCJe4G5ps7oeY01fIQmz_Y1VMcWZmWmdWD696g>
    <xme:4dXgX1ObSbZJvcXnkvK4MVHlYSKFPVUNa6PwEDd9bHPWRvhzBcjjO-lLe0vZmkKdZ
    29JAmPFGVPEZORa3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeftvghm
    ihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecuggftrf
    grthhtvghrnhephfdtueehgeevheettdehjeffgfetffeuudethefhveffteevhfdvffdu
    udduiedvnecukfhppeduledvrddtrddvfeelrddufedtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdr
    tghomh
X-ME-Proxy: <xmx:4dXgX4gMyOC70SUbCtAw1HjzahVQaAIe76hueVhTyX8BpkwMiXxA5Q>
    <xmx:4dXgXw_ysjLzmIugagwYIf726tTONL9XHYv51q6yXKRnQgJo7aN6Jw>
    <xmx:4dXgX7tOwr-9NW773t4wThhIVx4x7jQ9m81kIQGu7thfJwS51A8Z1Q>
    <xmx:4dXgX47FuKYPO05mmtwQYDtBQ6Xl1Mdg6dJCJIJ60jXsclrYM3pI5Q>
Received: from [10.0.0.6] (192-0-239-130.cpe.teksavvy.com [192.0.239.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 901201080064;
        Mon, 21 Dec 2020 12:05:37 -0500 (EST)
Subject: Re: WG: How to properly setup for snapshots
To:     Claudius Ellsel <claudius.ellsel@live.de>
References: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
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
Message-ID: <a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>
Date:   Mon, 21 Dec 2020 12:05:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-12-21 11:11 a.m., Claudius Ellsel wrote:

> Unfortunately I am already at a somewhat production stage where I
don't want to lose any data.
>

You should first and foremost make sure you have backups of everything.

> 
> The problem might be that I currently don't have any subvolumes set up at all. Am I still be able to create snapshots in this stage or do I have to create a subvolume first from which snapshots can be created afterwards?
> 

You have 1 subvolume, which is the root of your filesystem.  You can
make snapshots of it.. (and each snapshot will be a new subvolume)  To
make your life easier, as you start experimenting, I suggest making a
new Read/Write subvolume to put your snapshots into

btrfs subvolume create .my_snapshots
btrfs subvolume snapshot -r /mnt_point /mnt_point/.my_snapshots/snapshot1

(Note: You will not be able to move or rename the snapshot1
folder, but you *will* be able to move or rename the entire
.my_snapshots subvolume



> Also I learned about snapper from SUSE which sounds nice, but I don't want to break things while trying to use it.
> 

Snapper is an amazing tool... You should familiarize yourself and be
comfortable with the btrfs subvolume command first, (things will make
more sense if you know whats going on...), but Snapper makes it a.. snap
to automate the snapshots *and* the clean-up.




