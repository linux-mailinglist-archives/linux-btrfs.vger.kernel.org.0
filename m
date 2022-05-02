Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FBE517A42
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 01:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiEBXDy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 19:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiEBXDx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 19:03:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD40F01
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 16:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651532411;
        bh=bDVy6XECsfuj8RQXIUeCr8tiHYTDTGnDFgsHAitSgRQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lkxfSNkD5ivpu71zwo9I8AXn1OdXEQs81DM/bclrCKyPJE9yVIUHp3XOuyIaENRCi
         pi6P8+NgI3SEDAKuqPSyDNIdKpVsMPvKM6FIqnzaY2HDgS4qOiD3UJfzPPMiclKRLc
         /1gTKYrRaW34u6sV1F82aq5AocelEovaXBSBSCqA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5if-1nVNC02duf-00J1GF; Tue, 03
 May 2022 01:00:10 +0200
Message-ID: <42f778f0-18ab-ad99-ba01-d4adb7b55c9c@gmx.com>
Date:   Tue, 3 May 2022 07:00:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v2 05/12] btrfs: add a helper to queue a corrupted
 sector for read repair
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1651043617.git.wqu@suse.com>
 <a136fe858afe9efd29c8caa98d82cb7439d89677.1651043617.git.wqu@suse.com>
 <2fd10883-5a4d-5cbd-d09f-7a30bb326a4a@suse.com>
 <YmqaOynJjWS2XB76@infradead.org>
 <4ac0c01f-73f6-e830-f3bc-6281bd79b7d2@gmx.com>
 <YmwAzU+UORfX92Te@infradead.org>
 <32e7a9c3-00b8-9e59-276c-ce5965ccb92a@gmx.com>
 <YnAKrM+i5V2iOzB1@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YnAKrM+i5V2iOzB1@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PE66mtpT0XRsSj0yBPHWQLsHTqg5w7htBQ9UcX/GCNHZsT7eTUi
 AR2X+mk94V/9EAHG9WjI3n3u79gxHj344ayTxIAVbyvRsc4qPwqR1liTVWaXIXoVol0zVsE
 Jz52qnkwvohhnoaNABgt9DXuKK2WpZYjzHGIohoH3WqA3ktw+ikOGU5X4CfHcBA5Qc8uvo0
 Nx5BoIzUcGySREn7Ajxtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g0QM+S2bQHs=:fpIQ++BRyh4WJcQ5qekpb7
 k92jUVGNwxi5BdFZByMce39l0OyKISTBsytwryonOwj/QLdjQy8Uf+VzCoMYoAqtcpAkh0MMm
 sP/xq/mdIl81pYwRqpbqbnpIdMkMEMe3BFOGXfVlgBHyL7+RmHWSlk2TLxG9AGUu8qvEacqhO
 AkWX12bnhjYmeSluo17n0/djq8i/thVid4MYj+x+GjGZPOx29/v1ttt58s8K/fVzyaYu2gmA8
 I6HeoOhhaqHi643OLFIaP2aj4AITU7zxjmm3qOK96QhcV41OL5liATUH0TgwlHXh8SUZMhGzU
 UjQgj6z5t5pjz2TugdKa1F5uqrnPkZy7QVCCN8M9own4Z/FVQyfAbChCIs0NlExlvMspEfdVU
 DbbHmFJ6e2YgVFOM0v/NyY3nhI4V6GQsTFpAgc1XCub4DNPVviiK79m4H5L9ki6Adu9jO5CrG
 EdmBdpxyVEuDfQq4sGH28myWGxJ1dh/7wU9YdAhhjvwUTBlj6koxeTHN7ZjNQOgThBg+GRE2i
 rJ32j8aEu4J5XzfvwP06jdX9p41zBIYoa7Q4wDJlSz8IYm8/HIxnmS6YP1+BpYkr8z4OnInly
 vDKXmH/nzgSrwmkWw3zxJ/0SsCzYN9jqguPLbQdcD9sF+edt1BvpW3gllmD+exl/kRAPznsEW
 LkyE1xyh54l8Ih5YBZ71iBopTd/qkhNkWh9Eo09E0z0/zUQSq+wALWEYxHDjE/IT/0D1408UA
 Q8Z/yakQCdfjAk3YxAlzHFFSKhCHh51KNdk8mB/wgtWOFlBjAHOtiVy6dRDm1ofaey/jMNIZG
 DPZ9UARVKvjVhvjcaJazjpJOS5zyAqVfmA0EFvl4I8yXunrSqs/JTPOWvC2N7MTHBUuA8V5fA
 F6Pt44H+YuCx/wD0MVccmtJuf/T44dBLQhXiAsAlWMwMlnj8vHmSL4hMRiTmgqso0lAOqBAT1
 gFBkDbgaM5x1lCjfll85feC1hSx4MHiHuVan+NRa8ZGI0/EwW4p8bjzdDLiHGxEMmNdGdsvZs
 Bq3fuo5ALDFaT40QUEqWunnPE3/WbxDqOD4ssGIsqIOyZdnZpg8VyONRsAbbVCBknB6fmUCnb
 0/oE9tVZozxDXg=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/3 00:45, Christoph Hellwig wrote:
> On Mon, May 02, 2022 at 07:59:43AM +0800, Qu Wenruo wrote:
>> So with your previous mention on mempool, did you mean that we allocate
>> another mempool for read repair only?
>>
>> With the extra read repair mempool, even we exhaust the last btrfs bio
>> in the pool, we still have something like btrfs read repair bio?
>> (And we can get rid of the extra members unused in btrfs bio, since wha=
t
>> we really need is just a logical bytenr and pointer back to
>> btrfs_read_repair_ctrl).
>>
>> This sounds pretty good to me then.
>
> I primarily meant a separate mempool for the actual read_repair_ctrl
> structure with embedded bitmaps.

For this, I kept the path of on-stack read_repair_ctrl, but for bitmap I
pre-allocate it for every data read bio at btrfs_submit_data_bio().

If we failed to pre-allocated the bitmap, we direct error out the bio.

Not confident about variable length bitmap to be allocated from mempool.

Thanks,
Qu

>  But yes, bios also do need to be taken
> care off, and a different bio_set might work very well there.
