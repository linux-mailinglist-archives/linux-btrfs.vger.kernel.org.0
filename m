Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9CD5B8172
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 08:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiINGRs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 02:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiINGRq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 02:17:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B339A71712
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 23:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663136249;
        bh=ov8NvUf7HQt05/gN1bg0cbp7qVsOhU8t7crC1F2JZow=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=GXSJcHbPlZmcyDvbRyCrYSBSy/93ZSetQ9cshjJ1qaD+b48aOUOCLhIxl4jXeifEE
         n4JXsRU6s9Qt74MNjTE3chG8zYcG27HwXnd55gwezyMnpv16n/D/Lfzqg3AfclCFLc
         LXTLSlIbPGWP6zbG0ATnuUi6dkh4odyHk7PxGq14=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNbkv-1owkJX0Xr1-00P34o; Wed, 14
 Sep 2022 08:17:28 +0200
Message-ID: <1780f977-2717-8ea8-c5ec-6cf30d98d261@gmx.com>
Date:   Wed, 14 Sep 2022 14:17:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Linux Memory Management List <linux-mm@kvack.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Is it possible to force an address_space to always allocate pages in
 specific order?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iifkHPD2/yAxUeBnMNnBy8oMK6udJdq/vLDnfjI3j8fYkfwPEXZ
 WRI6vV2+dJtzaDGDWa+yK9OCk525uIa8LEbxpfSqmwcQZcOmkx0yodubEhKCkaULu1MH6dm
 42FAinWaQxMQ8UEeqitMwJrbt9HzWAfF1RGdQsBBuEHGC5/m0Nn5PbJjiAxtJfCNgxXCRuh
 5a5jaPBaeFN14TPvylKMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S1HoKguqP5k=:fiJiNg1Lu+s1Wlw+ETkIjP
 sXNyTqDeAiv9H8NfIvWxxKebkOAPtbaFHLhaO+NweNPJqE8EayPAK43YIFIqqXcnlWgqi3Q3m
 t8fk7O6Rp/WVRoYn9rEuNWjxoDxMAc1YOQWcGJ8ETq9nS7MjV32CLLk01JlX17TydRu6h0ucB
 lyXDknGZLO0sOc8q3SWm8FeJ8vpBubQlARZrSjrJjbQK2EyumBhTh+ArnmjUdaNwP3nMt8CpK
 gKFx1qijSW0sY5quqSBTDiRguF352Z84kOBF0ynYTR1ODMnyN7NdqSLPARGyipiKxzg02NYIq
 i2fCb26+JC8RUuD72aTVXKqM7VeZtW7CQ2//Mbaupu4OmzBsOH3mW9Hz40GiPh65Ura5DVhVB
 qLN043Ex7b7HoOIw5FqpAXhEuF29TPRXseV2KFT3HZmAOf33JZlFavYujTZKXNGJK88pHC8Xw
 K5P6DlPlLraJkPeyaKh3y15l8WnVSEnjh0Yrftc0vK7utGNEg4k5HXC+pGnjNxkBwTykNmgUq
 XsGGarArwJc8+rB6dif/yLyOumffFd6FWBkRDjUadZEZLvTCHgQ1DulSNfC9KYBbPDyPXJXIb
 p2CpuxFC6yt74Zq0otBXKjqlRHVJgUULpnXzrh8un4XtKROS27yroB9txOpQlITcn1Ip14T2T
 Dv6bzOb06rh+ASN1DMdz6dFSn69mrqBPC06eK1SRi7RooLsHa+2ynL3la4wcsvuG7tEcygFMp
 rfp4NkFlmQTcZNPNSJ7oihNN6aB/fJJJhuUzSQC2Yc4s7/xevOHjCxz0MjloKj/JmdqHCQWWV
 KjlcO5nsD9wZJv6Nrko9A7G7VhTZjTbRVvpiTjt1Nh0V47Dtz/T+A3+YpFhwTerw0ijsQSuTE
 9df8EG4ZgqAk115YQCME5K/5u/RSacekIqtpzNsISeQ9c9Rd4Fd5amcOa/cW2zd9YjREIPJVB
 ntKPGfTQqWbZBkOFZ1SW2HS7sodIDqm7q5ra4BcBsz8mBF57Z60vfv9QTAGNgsTHFeJWHsGS6
 JqyydAoHtL1ly/Fe7kQgpIgA1cWfvcz7l3TCBrALKPtUJ1zamEaZcSg/MG8jAolFcD5S38vZc
 eem/vxvpCB7YekxxoUJ+QlX4wzx3k+5TbrEBn100YfhmX61zU14j0u/FfJmUA8Qyz4NITGMJY
 qHrR63preakdwqnMkvPDCnMpcO
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

With recent folio MM changes, I'm wondering if it's possible to force an
address space to always allocate a folio in certain order?

E.g. For certain inode, we always allocate pages (folios) in the order
of 2 for its page cache.

I'm asking this seemingly weird question for the following reasons:

- Support multi-page blocksize of various filesystems
   Currently most file systems only go support sub-page, not multi-page
   blocksize.

   Thus if there is forced order for all the address space, it would be
   much easier to implement multi-page blocksize support.
   (Although I strongly doubt if we need such multi-page blocksize
    support for most fses)

- For btrfs metadata optimization
   Btrfs metadata is always using multiple blocks (and power of 2 of
   cource) for one of its metadata block.

   Currently we have to do a lot of cross-page handling, if we can ensure
   all of our metadata block are using folios, we can get rid of such
   cross-page checks (at a cost of possible higher chance hitting
   ENOMEM).

It looks like our current __filemap_get_folio() is still allocating new
folios using fixed order 0, thus it's not really possible for now.

Would it be possible in the future or it may need too much work for this
to work?
(Other than some folio order member in address_space?)

Thanks,
Qu
