Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D79C760143
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 23:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjGXVfm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 17:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGXVfh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 17:35:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78087D8
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690234526; x=1690839326; i=quwenruo.btrfs@gmx.com;
 bh=wiO2y2ATrjVN77Q0nBBqlS4ozxc+kuMyqKRIyRmtYpU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Tci8HkuC6HDCcqsFzg7gzGpjYLiqWQufE1GHjKUJ4yVPKKzA6T7Os0JhzFNB39/PfwkHU9R
 iVztxZ8CD9hAStVNBEOW3/lMzdZOylw2ibMtO27yiQReD+69PAzoY6n54JlUmjD/eM8AvI8ea
 45j8Zsvtu49/e71siZ2yWPKfGElgoDFQemXiOoR6lduzwuRsnxyPgYfUWXRzY6ewVXU90MmIs
 f8Og3pxFIDIWfs7xGgzEzW7+GFLUOsZU7QstZggasWRCqnsxEIKtB/vd/FSO8tkOpaJXKxnj6
 QafHY6ZEyZ1qViCuxNjPwEaebmimTosi8cFYP7dXDMJ3apO/GQDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QS8-1qJfUT1Eem-004Rx0; Mon, 24
 Jul 2023 23:35:26 +0200
Message-ID: <6cba4ae2-3e48-0905-3245-b9e2be4486a0@gmx.com>
Date:   Tue, 25 Jul 2023 05:35:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: warn on tree blocks which are not nodesize aligned
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <fee2c7df3d0a2e91e9b5e07a04242fcf28ade6bf.1690178924.git.wqu@suse.com>
 <ZL6GvIvyaX7CzT0N@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZL6GvIvyaX7CzT0N@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7oYK6cRSX9eW8wTZzPNLseP2Sq2+LyeHZ2ciJ0l8qIIPE846F0t
 Ypdjx5Dsf4D9yUJ02aN6YIwc47wFtyDFYKHLCoYG10LHlb6jSzPmg39/qe/UL1GefvmDKSX
 fCQ0z4DB4FJvcvj7UO/+kuL6gse1MhqtCdqAOqY2051iZI7iud7YLiqvvBVGmjBvvedUYMs
 o3hBEnQHECdSJrCvAtcLg==
UI-OutboundReport: notjunk:1;M01:P0:CZag3sOLd0U=;fkKO0BwaFGw7kRhnf4sT/nNylU4
 S9yiY5XaX7YhQWb+ac/m/r5Rj7wnQBmc2QYd97zR4+FwchgP8G7eQlc+O/jzMPQ3mglP9fBjH
 A/93iearnBr+K/E8Ok/TLmAmEMTgRamKMeBPySmwQt90vHi8g/tspEMdYx+/eIlJ3k7xfKuxL
 ZoakVaONa9PcTZqFgO+ZTGxJT/wNoueLpXF5olLzEUxXQKG39//Vn5CPHXWmFfZYTIK5nFryQ
 a7VOdIitrtVZXYgr0L7vZAUyR6R9eTpjE854HeQeLMT5x457/4TjtjdN3RbamW7EtvAE4x0we
 vIkTe/R0T3kcwgAn+t8PqHsAKAY/sM8hPET+CdPHhoJPNcW9xEzo8MhCDUAbgsl/xzdPsiJam
 ADAyL5jcorz0SjbK20I3mLzTfKG/Rl+50aeKX7x1bpiiDogZlQjJ1NLylwzw3T1aEp8gDvsNi
 U/CkAWkbqfwon+TcfEEHMltTmcATvaifl+nIxqt3X0PCgsvthNGJa/MyzOSoT07SS0ksafG6B
 UV0zBDmu16UWxMMpL82sHT+t0FmYrEAn8/vgQJyxSV6wIbcB7AkSNagTU6tBSDTny35ZKPDB8
 +lyT3IB+J0ApKROVKjGYXXuEsT1UhP2sGmzZKdPPx+ZoN+cCz3Y9upgPyVxtfOrPQURFPaeoj
 XrLHYESxg5wWybjDOhmgSARNR+5X7FR+Av2c9dv64LILEY/oOmvVRZXKuzjYwKDEt90y7HsCK
 6NLAEkTnh2KPz5TTLBgqsuvz/vV9WHOE4VFPs+NrptE5QMFaAv5m8jrcvBHpf4KQWLjIeDUdx
 MITXZRQCho1yBasMFKmPxukapqVN1RvxmvH0lO4HzpKImXZdDwjlba8LbwY5QHXsP56S9nVub
 zPQSfL0c4gvueJE3qdA8sqkIvLsX77qbdloBW2fycNDq31SPC/AhRWgMa/NwL0sReajVP4u3b
 KDTl0yTHc+UwRxsp11VLSgWIv7I=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/24 22:12, Christoph Hellwig wrote:
> A _warn level printk seems pretty excessive for something that was
> perfectly legal and created by earlier implementations.
>
At least we have a valid workaround, and this partial aligned tree block
is already checked and warned by btrfs-check for a long long time.

Thanks,
Qu
