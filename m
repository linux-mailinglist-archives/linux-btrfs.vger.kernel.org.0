Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE253740C37
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 11:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbjF1I7a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 04:59:30 -0400
Received: from mout.gmx.net ([212.227.17.20]:36691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235995AbjF1Inf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 04:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687941813; x=1688546613; i=quwenruo.btrfs@gmx.com;
 bh=n/kG85ixYznJAQSKWz1bABjqAOiIQrjDkvwl29E03Tk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=SDvsHAzgOVW2kB4/Oh4yfrFzDZfmqEL2dVNUWrUFg1iZL33KrOxu5gFFMWFE1EwJ3G+0Pww
 JRWxoEgcbxQtDrbitOBCJ/wYye8IzNMul2AzhPOoycoIpfgYPDQE5/XobAZuYrqqVHpK0vod1
 E3nW3yStbjgP2WaoNXAzIXchWJk0FgmV5RO0jlMXVOaJx6IF/+GRt2tVBh6DJSjc1Hmwmxtm0
 W4f/AR6+rzePttUfvaV2pyjq2Ouvd3+yk7D/ImbOkdSk6syUFAcg/RBie8/ESE7EIdFgJ6QuS
 UineTkO9N9jMfvbrx3D09fHEBNApqwDVYn6ZVMsb5mTEIi4Xpgyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeMt-1qZY6i0k31-00VgJ7; Wed, 28
 Jun 2023 07:59:31 +0200
Message-ID: <2cd154eb-580d-2548-a9ef-0cb3ccde9496@gmx.com>
Date:   Wed, 28 Jun 2023 13:59:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: add comments for btrfs_map_block()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <4564c119bf29d7646033a292c208ffcab6589414.1687851190.git.wqu@suse.com>
 <ZJsJRMQx3oNSaEOk@infradead.org>
 <286ad810-f239-5fd8-92e3-fbf5f7c387a2@gmx.com>
 <ZJu+QbMPrvoqZpij@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZJu+QbMPrvoqZpij@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+S0tjh+BzPd+kan1glNUqecu8AHfSHmaC5HbeNCTqa2/c+ni/Uf
 Set6SSgy8F5orHCFDrrgp08arcj+31jtr2wjHNfi7A7ZRVpJwlPN7owdZ6xgkIQRmbcHxu1
 oGOiOKQ8QD9DEdPba9+gUxWvNso7nVH+QKgaaSWiYj+W2kyKXVsZT5uOE7hrr/2PBAN7BWO
 55c4AmSBNsFRbZ0eIy7lg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mnoRCi4/qZs=;F1EBo0vHOiKBgdcD+aoCLntWazb
 a6aqK2X8A/A5TVjokVsoR4icoYCRubuGnLSL42H3cpegk1JateYmrbY9GokFEa4ZeOa1moisA
 m6zvDgWKJ+Tve9bjQoBIbzFiAeDZCJTRTT+5Ea42NuugAkA4oOUqAEhzzMGSknh18opklJeqo
 w9XOon9eKo4tueclnOxiByw1dW9USL5/pAOH96h4aE6YXcbIzvHgIaXzndfNHGUUjh7YujaQ+
 vITTIA8aeZmodFk3pevNPWe94I2s40c+dO8tiyK9IlP8SUO4PVNBkDS6kdRDMpLt6o0Q51WMZ
 PzZRYG6TPESCxVFkHyKHVkWLHT3Vgs9sIDGbWGX/o/Me+Fg+uUxsqfpvCzV0toDzBz12Eado0
 8M8Tw1mpo2rz+LvKG5yCApSH7UkDbKxFyotM2b6ky9beckO46tJg4f48SaSBWcMW/c053jamO
 GanC62qV61GUUgIFJDKtg2yFrrxNR1sbbIe1qgSSYfi0rNl/INFrqj1g9npJ46WThLVf9Ezb7
 WjhvDu4u1EmUH4+bP0NsSptZ8m7j1Cc41Zetd2QaNPGrYu4w3qAdyeEBr9t/iFFRc95VeXfbW
 z8DLV19VLftkRQL7Jxj2aFsu0/+xJoGnZ0Qe0FWp2M33deB+kx1V3gABVUeJO6bOVZS2rTZiU
 t+vwNC92C8vif7GLRURRF/qsHg1Q/JGApqw/ZhYD0aePV7SlQs4vZsJInDvYYIkDUdVQ24yO8
 +XGQ3yOxBg19B1rycgJU+JOb7rDTh1IftREZHGkNzQu4x7fvn4yIQcLtJlhyqcpSkuzUkqFmT
 CuU+Y/2F+nfsr+2GgvIey4KlXvD+0jfXWkNJK6RqJ/n2fzWiVgXC/8fE3Kx/91Z3YGVF8IaMQ
 cAN6fLTdwYLjbA+sli4Rl2bYS7vAdzY14cP8Fl3C526GT0c6Ab21ZkKB7131XebJIdm0NAEPP
 OlzEm+RkYnngRS86zJHaQPdVjAA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/28 12:59, Christoph Hellwig wrote:
> On Wed, Jun 28, 2023 at 06:00:56AM +0800, Qu Wenruo wrote:
>> Really it's btrfsic_map_block() the only exception.
>>
>>>   Maybe add a follow on patch to just
>>> remove the paramter and waste the little bit of extra effort to build
>>> the raid map for btrfsic_map_block?
>>>
>>
>> Well, I'd prefer to remove btrfsic_map_block() and the check_int thing
>> completely.
>
> I'm perfectly fine with removing it.  But I don't see why that needs
> to delay dropping the raid_map argument.
>
If we're dropping check_int completely, wouldn't it make no sense to
update the only caller of @need_raid_map?

We can just wait the check_int drop, then safely drop @need_raid_map
argument.

Thanks,
Qu
