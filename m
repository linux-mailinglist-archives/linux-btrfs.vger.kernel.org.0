Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1702650EE12
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 03:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiDZB1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 21:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbiDZB1s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 21:27:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FAC11F949
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 18:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650936273;
        bh=izw8WLtlzi+e1qatV0hKMFD1xV1kRpUGNllZFuR3uCE=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=kouTjqp7Ed/pEWwuzmmcdV3Edw7QmFOzqdFSoQrMLkCz/008p1ypwXoBKGP4HYAQO
         GWZ9KsYWqC/finOjj/Vgb0THqKblMBlUcL0Tob8zBe6j8yRfF+kyrnrvweFP9r9hCW
         KqLzGMlKfjY4imFhSLag6QAGBCoBzsgkhGi0a88Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MsHns-1o2TBC1xOM-00toK0; Tue, 26
 Apr 2022 03:24:33 +0200
Message-ID: <2912410e-6b45-7058-dc3b-4cfaee07e8a2@gmx.com>
Date:   Tue, 26 Apr 2022 09:24:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220425075418.2192130-4-hch@lst.de>
 <62f71a43-8167-f29f-8e9f-d95bc6667e0e@gmx.com>
 <20220425091920.GC16446@lst.de>
 <458ba4e0-15f3-93e4-bc17-ae464bdf13e7@gmx.com>
 <20220425110928.GA24430@lst.de>
 <bade7fa8-d95b-e0e8-0af8-e40fec341789@gmx.com>
 <20220425111925.GA25233@lst.de>
 <af44fee8-deb9-a3e2-a04f-06dbcc16b6c0@gmx.com>
 <20220425113458.GA26412@lst.de>
 <9d6e5424-e872-7767-e1c7-6eb35d53250e@suse.com>
 <20220425171701.GA16295@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 03/10] btrfs: split btrfs_submit_data_bio
In-Reply-To: <20220425171701.GA16295@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OT3GvHlrpDpDq1CEBDRxJGd/FmcY/RW2ZbMz7+qJOLJ3iVc+fty
 GP4cyrG+a69jJSOL6EsdlSlYwT0Hz6wkSrcaFUPicq7szSMkZ01zcwoHZ0KeP5vlfbh7zrB
 UnT96q3dlcliw/IbFIx8GXhB22YiaGZ2VXgJjHj20v+sx+yG3s4ObxFWrcpOeV5F1f9mUfy
 Iqe1UaOauvWUMWugh70Gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bBsyEmTpIjc=:CL4PM+rqgiwlNva5mvEWXi
 lacVQb37VKsReqMq3GIAVr1Y7Pn/ZQS+Y7oNriQvpRpW5m3Zqk9sJGc9tm5d6GoAdKwnrTKiW
 BGC6AUIVMZu4LNhgPMe4vfqux9p//eHjZj2vInWEzfFshkFiNDNBgsQapKHXD7w0MP/uCdw0m
 JSGPUfcbAcaV1FAcO9GKJBknEmqtmB/3GbFkc/RlWawdDx/hpF9WAXdHfCtWyMjiL7uPaRwZv
 Kd2mmRta1r2lJS3lAHhEu04vpbFWmcWgjmKS1hV49srS8mlFuOEH4CcZqGfFSMz116LR7Pzim
 5uJyKb/QytY9cUNtpIxz+tcps7eXyg/yVLXWKGYFYEgJNv+2H8yc26Bq7ihErtXSDfo+OwFEa
 99RPKXzNUw9qF+wH4D5uMSddYL4dFZWAgXO7JX/hy1RUvESFcbQpR8/4SIW2VnpKsQ8PXSxme
 iQHn01okdkFDAGcPrn+t+Cgc+sx2qKRta7dNkSKKxsf6zazMq17aZamrKd+ZDyf4aWbqrRWp2
 TGC0SW1iGfG7yWXTXfea+WTY8+RldKHOj35g8x6BqHu2X9ILYvWfQmYnEXx+GD2eYWM+I9wls
 s/VGyTGyt9xFgRrVeetvR0tJ1ZXDP76RQgC5KURqzJv+UuCObPl3MtQsQ42uv34rP3OnZGeQg
 /9ghqUVxQwmP/6fhWsTiX03PH8UV+x/FW7bDENST+35qFbIOWYUezBY8IPsFdBYPUJx11nupd
 LQHBfT48W+drJ+Y2C8D89AqzOWiBO7Ge4cugTKPChM48mUTG4omysPuC7e1tHps0g+/waXtld
 c8mP1dlZdpwRXJpGpgRH1jn/iMw+S1Xtin1p8tTaA28xwFm93jtAGZg2D2Hp0Z0SpIxJT3wz9
 AxfrMUAYlrueyp1FZTBqjXXCXmfC4+BxHUjLhfzobpd/P1SZKIylZfeMrqdUygUqt6lESkcPz
 XRdTwnGkOwioDtwRlNVwFvwtNo4hIwajc8VzJQPuQqg3F2n2cUfHk7/2N7BGDpxPmr8FcwLsw
 f+CaoRm9EPe8TrXBNWyE0Bhkl6QJLktxwckR9rhKmE/cW6bhIYPeezilez/8lDtd0AFitKhWz
 VVHvJyDsLUzn9Q=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/26 01:17, Christoph Hellwig wrote:
> On Mon, Apr 25, 2022 at 07:40:40PM +0800, Qu Wenruo wrote:
>> That's only for RAID56, aren't you going to remove btrfs_bio usage
>> completely for all write (including buffered, non-compressing write)?
>
> There are just two uses of bbio->iter in the current btrfs for-net
> tree.  One is index_one_bio, which is removed by the patch I posted,
> and the other one is btrfs_check_read_dio_bio, which is clearly read
> specific.
>
> FYI, this is the next batch that's currently being tested:
>
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-bi=
o-cleanup-part4

My bad, I forgot the fact that, my *READ* repair is only for read, no
need to use btrfs_bio for write time.

So your cleanup is completely fine, my head just short-circuited last nigh=
t.

Thanks,
Qu
