Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C13A4E4CED
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 07:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiCWGxA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 02:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbiCWGwt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 02:52:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F0870F70
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 23:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648018271;
        bh=BWkencT+MQBKk1Oo9T3bLO5wpYM2B1XJRqEe0VFGuOI=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=FZhL8BsS9MBmaqPK1Uvd33Lgty1jqIAaHK7QoOIhM8ulz9GRHlPvZ27balOvIDYh7
         SUS1NqyyNgJvG3DbFGQEUOYO/pcMsyI1u5rrnTzx43n7bZyU3wDCyIMYCnWmHUA75H
         LkFkcdunMoj0UIbvxRHtjIYeZ0kgI9+ZqrQfA/wU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MA7GS-1nLPJk3khW-00Bf7k; Wed, 23
 Mar 2022 07:51:11 +0100
Message-ID: <0c7a1d26-8d89-f181-40a2-fae466b904b5@gmx.com>
Date:   Wed, 23 Mar 2022 14:51:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <27688f5ed1d59b26255f285843c4573322acfa39.1647926689.git.wqu@suse.com>
 <Yjq/bNLcB6uBU3I2@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC] btrfs: verify the endio function at layer boundary
In-Reply-To: <Yjq/bNLcB6uBU3I2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+VOeWVyuICz028qr8TAb3zZStvgJbCLTvNOwfjoFdrtDEfV6bZh
 aj9+VjKLH78KdU7VYMf/6NGBELGeaeNFbEW6yIE3P9HG3jQEFqbGIAE/8Ja9Rk/kwKgbAK/
 vmzmZ68Zf5NkXGN+WfIKArdXA6DAOkc1YXikbyE2xIm+sgCqFn/7X4+CMwkwy94y+432L1i
 sm9bE6ljAXs9Mn5hcmj+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l4O/pBMIoQU=:5bzFBKQc//GxwYt2bJHu6o
 ZH0lBH2sfzcaNLboyKFvfqG2IwvsOaoozKG/ddJ5B1vDYctURyfmCwtSVw99FlbZI1VLcD+Ly
 v+tkGsrSyawU0IbGLGBagEmSYN1x176rd6wQkSyxtzXfPV7i1MDLisiGyRPUG4MBeHbzRO6gC
 P6S7fh0VddhXu/8m4wfVJG8Sfrl1jHaDnuwbCLY8VF2eJz55HsSTtN7uGvhYzNXXsL268x1EF
 OlhBqw2J6a19H/utDfODPKz5OzZkA+7k1O+TJcLLG5O60jHENizj7t1V8bNg+9pcBVbRG2fgY
 zR2BOZ0/Hwaf3A1yV08yDZPbfCn7AfzDcFZbnzO54P+yYlyNfWwVDoVTkJKusQwVJq7bQn7vF
 Mkg6D7qOG2Gp7eGfu0zXSnPPBLSxhYUdpJppQH0r7zzmNEwLWkEOGSuPuMIiZoH3pBHD1Tc1Y
 Bw1uQx59yXTFgoNZBBrTQ3YiDOMS1MjMevhlJL/rT/o8W5mGhzFr7FhYy9/7bzuv1JiOwtk+C
 rkV2qW0XE/kcoLz6D9P/cguUh8GikUhhH9seXBOvf/GhSAirNQMA63Vg+0zcrXLsqr1fpvw9G
 Kqj69GJG+k7QCpxIgr22qe0++8NGwW8vpdJM8ABW00U74uLuD6i1AUGnkGaGygO+YL24z5Uwi
 6ruUmQi5LdgZ82zunBYDS+G/QbISAOEBO17h+LUaxzdO0r9ifyFy8VMusuRf+9/eheJtDTEDi
 5rwZW6NQgdnEUIgHUzoMKIKkBPt14eigSV1rm0YqT+eLgN9ey4uqpHtmWLP3oywwwroR0iMt2
 cvPxz7jkh3bFEllqRpK0EWeznwS9Tx1iH2IJZXieUCYfuYrxQrucu56ppXHvBrA3UE8OdmdE8
 oZrwOuWNKQsebgPUwi0WEIEF4aIrWC4Abu3gpoXPCAw/7Rb5+KS13Q2AvqEALOOAU8aCyM+HN
 pYU/ahI36K1EroE9kBNa7X+koAOVrfSeiVrkEg/bZVLqwmJnMu0Nx26dNUkZc0YZAT0c0fxAn
 bFPhYksZG2CTIfVcQg5/o0rxihhEAydS8HOxbt0kykaa4aQeh87KYcJllL7RuRgpdMo7jWqdC
 p2UO3ZMtuRoquM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/23 14:34, Christoph Hellwig wrote:
> So based on my staring at this area for a while I think the fundamental
> probem is that btrfs passes a struct bio in a lot of places where it
> should pass a btrfs_bio.

Totally agreed.

In fact it's Goldwyn's recent attempt to integrate iomap into btrfs
buffered read makes it more explicit.

All the btrfs tricks on mirror_num/repair should be only inside btrfs
logical layer, not exposed to the upper layer (aka iomap bio), nor the
lower layer (aka cloned bio for each copy/RAID56 etc).

>
> Basically all the layers that eventually call into btrfs_map_bio should
> all be working on a btrfs_bio.

Well I even want a better encapsulated entrance function for generic bio.

When calling that entrance, caller shouldn't care about things like
repair nor checksum.

And in that entrance function, we do our bio clone (to get extra btrfs
specific members, from num_mirror to csum), bio split for stripe
boundary, checksum verification and repair.

Thus I'm very happy on your on-stack bio cleanups, as it follows the
layer seperation.


>  The fact that the btrfs_bio contains
> a struct bio is an implementation detail that should be mostly invisible
> to the consumers of the btrfs_bio API.  That also means the "high level"
> end_io callbacks should take a btrfs_bio and we can just use good old
> type safety for this sanity check.  I have started this work, but as
> my bio cleanup series already got big enough I've not finished and
> posted it.

I guess this is what we have some difference here.

In fact the idea of exporting btrfs_bio API is against the layer separatio=
n.

Thus IMHO higher layer shouldn't care what the lower layer (btrfs or
stacked drivers) is doing.

Although making this clear layer separation needs way more work than
those cleanups.

Thanks,
Qu
