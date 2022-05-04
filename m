Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E238351B227
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 00:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379210AbiEDWqG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 18:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379089AbiEDWqB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 18:46:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B810153733
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651704114;
        bh=pJjIl4P76wwYeG2c5KsG89L42w9WeYD+KzVPQ+lR0v8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jfEducr7E94JQJN1nmBVfDSEYRRVg0Qrb+LYFAberK0JdfRUu5CHpcfMKYb72zRCU
         JU0vid9u91474dWGukyNfCbSDzPMmtpU8z56XoU++cHvSR3qR/7y/Ls0A8WwuVgG81
         hQeDIwPRsxjR5aTTLDCdzj8H49zeE5ogM5GNZHZs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McH5Q-1oP1tl3VD2-00cjz6; Thu, 05
 May 2022 00:41:54 +0200
Message-ID: <b9283134-54b4-5a9a-f8c4-099cdb5df6fb@gmx.com>
Date:   Thu, 5 May 2022 06:41:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 04/10] btrfs: split btrfs_submit_data_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220504122524.558088-1-hch@lst.de>
 <20220504122524.558088-5-hch@lst.de>
 <4b4e9991-3c1b-6758-3e1d-c6aafac61c13@gmx.com>
 <20220504140851.GA17969@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220504140851.GA17969@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/uItGDdATKoUqmIHQ0M4+Exn7/JFPZoLOJRKHYOvw3g+t84Wy+u
 ilK2Mks5Mw4c6dPMYd0MU7Js35NL8tuTDVZDS9FfYxP6SsT8dGbi81pP+6Lo8XF1mLWkOks
 U1IrArWc6C6ejTQzX9YvM0nanw2v+Wc4sAS8QUz2vEDKZphWpH6cyYbFAat4vm0cy1AtUt6
 rFP0hN0ci9SKOHV+s+xfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EO2ad3Nwo0Q=:f6SEB7Ok6R+gtAuMkOmut0
 z3+c+yws35lhb2vHyyylWrj1kmcBbEWvnAHIS3B3RhSnil1uGoFN11E3dNd/hjSf5DyfpSCrv
 kHc/NjVU5dj+YsHDHH18yePIrQpN93iOot0L9InTkHwCdY2H3CZut63w0x1tDjkEULCrQdoxH
 RvYH+Ukr306ysS40pRb6ZDIIETQ7aoY9dD3XMGWOXAPIYm/tniVlA1+IuXjxdgqZBnk41fzk/
 jqCFWLLhg3EbA+1b6poWuGwILYu7n4fyeMgnk2Vp6mpXAtVdu1a30mjDWyhCGQ7ltXL2IVS/N
 kfWKilkgn+y7bVREzo8+Rs/pS4sKNyjRoA9YU7v8eba9JzRwG79PaKPXf1UaGAlnx9r5BjeuF
 6g5pelNPh496O54BRggjqRHz6rSCOvtYPVx6HFjlRXTyMS6/uPyNbKrY+5XRcELEFL7p+3np3
 7eyDolyHWe+YxNzpPJs7+llIqpgQ96qMkgPMM+0WLsjvskHg7v5ruopYvaazcyCwQ3KOKYGy5
 L6DKU20jguH6dDxI9VY7k0mTSmyu6RfXDo+PXJanktjdi/RW7y6sDerstcbF9wPEi3XpR4hVR
 qzxMmtzZgD6nm+b4PxbxeeY9vV2Bzam8wnV5m0wucG8fPI0ZIgQIB6duMxrVc73hfQnJZAXAX
 dCPo2rnpqrN7438X9I/AVd42QHI06ae8kUz0JGh/yYrx2BLn6D7W3zmYP2/LBGbJHNlDiNQVu
 Z6I6t3DRnCMgspOpF1h2hLvBKRXj4djWewNZCu+/fmFW/LYcXSWt0rAr5MW0GA4FLJGbvz7Ic
 LhYkbmn6MuCZl7tqxcnKnul2bLFwtxQf6/FHQU/bTbYjIbWHCZnWxDN+X/ZCoUOWydB6BfkoI
 NAhQG814/+OhGKlxK+/f+Tg4HJGtSGV4Y1s2sEu39wT88k16z5NK1XqGaQK3tqLiyvxMGqbRP
 f93WnULJ7b0q7UC2m393btxo9xCYa4xo7Eyq85sj4oFonMs//eIfUFfU0hs3mca3+jbH5NFTo
 BvK1UqokBNEbyKQzBP7Je77/zXCR1WYdYMWFaVCILp2e37PcGa+zD/VWofQbXGhZl3Sl1ZnF2
 5dRsmF2l6MtGlk=
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/4 22:08, Christoph Hellwig wrote:
> On Wed, May 04, 2022 at 08:38:23PM +0800, Qu Wenruo wrote:
>>> +	struct inode *inode =3D tree->private_data;
>>
>> I guess we shouldn't use the extent_io_tree for bio->bi_private at all
>> if we're just tring to grab an inode.
>>
>> In fact, for all submit_one_bio() callers, we are handling buffered
>> read/write, thus we can grab inode using
>> bio_first_page_all(bio)->mapping->host.
>>
>> No need for such weird io_tree based dance.
>
> Yes, we can eventully.  Not for this series, though.

Looking forward to the new cleanups on various weird private member usage.
>
>>> -	if (is_data_inode(tree->private_data))
>>> -		btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
>>> -					    compress_type);
>>> +	if (!is_data_inode(tree->private_data))
>>> +		btrfs_submit_metadata_bio(inode, bio, mirror_num);
>>
>> Can we just call btrfs_submit_metadata_bio() and return?
>>
>> Every time I see an "if () else if ()", I can't stop thinking if we hav=
e
>> some corner cases not taken into consideration.
>
> I generally agree with you, but for this case I think it is pretty
> simple.  But a few more series down the road these helpers will change
> a bit anyway, so we can revisit it.
>
OK, that sounds good.

Just a little worried about how many series there still are...

Thanks,
Qu
