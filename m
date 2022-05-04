Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1189D51933B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 03:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239400AbiEDBQl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 21:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiEDBQk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 21:16:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF02B75
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 18:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651626775;
        bh=S6iPdF0fCJ59dN+trk4G4WSfCkB+PAsH4YreSpPqujg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=e4sVrzRQYsbesrF5nWq+L7wC08GIxVbbNA61cpEtguD2r66QvQ5D+i+MaBErGTOjB
         AmOjJGR1PCu9g3mjptXdfdVCJu4GasquL4ING93CmzHplBAOFjrBT0lpUHKas8AUyT
         Zp9nnlH3xDdJvLg2+EgsKUMBm0+H/bWx3aHYZ4yg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBUqL-1ngsNl0k1v-00Czr7; Wed, 04
 May 2022 03:12:55 +0200
Message-ID: <dac4707a-04f4-f143-342b-cd69e0ffcd80@gmx.com>
Date:   Wed, 4 May 2022 09:12:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 05/13] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1651559986.git.wqu@suse.com>
 <3f9b82f1bcc955fbb689a469e749cf1534857ea1.1651559986.git.wqu@suse.com>
 <YnFE62oGR5C/8UN2@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YnFE62oGR5C/8UN2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vk8W10l9Yk9W7K2nP7S2ag7CaM/HnZn/joNQmpTS9yWTvkJgyFw
 q4cxDCVoWgdou6PoGzwIILX3XRl51cnflYSb14e6UctU2RZ4BWlSLmirZVfZ+taqcFBaP8A
 neP2/PGiIcfw/0gzCyodF6vCoNo5cv6mpD1AeAj9RkmQebmML7cZcBA6Yc0hI3BX2OQWXfe
 nMduZHm/fJQoB0AiBHaSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0gL8XZLz6Q8=:l8430xLxaof1oOXko2KZax
 AbNnNUBlmbffKaLuAiw5QL5DTOjelLtwJUh1FN9EnvceMxViqJrfMCMKiSFiTNM0B34CGmnTd
 z5rVtXnzK43yJzMSFh/FficzgrGqPglteySqYS4zXCh9nKcCQC9FZCByDo/mv61a9OEWHCnoK
 sfczy4jKvA1mDOdNU99MxZU58dr5OlZ+FTbU4gveNkcRrMrFaUhSsMY/z4rRmdlGCyP03hXbJ
 v9d0ZsclT6Xy0rJ5DXfHBTXlDFQZy0+FSf4vIEYCTheYUJyhtsyU9Adn+8khVxh5r7KyO1rEO
 7LJD4iqZ6rLpBWBJrescRqqBrNdaC2xNlEUbBED8/vKwP2rh4WMgicHb2g7ZpPccRy2VhXEmI
 Aoj/V7L8UGxa6rCZm9RFle7NaRc3zv33aIh5po5KjjBA/hY4LWjWrNs25zwC/5Gb7Y9O2HNu2
 PAivjdOP8VT6dkQD85gpV5Gr/C++QFDlqQqEPnbm6SGJiCWb9wZJlozyIodFQdlxt1xg6gsfT
 oyGAE6oDI5dK3qFtW6zVxwGIog1/gwoeUrw2arugHlerSLdbgb/GEqo12fu0zmaNMhlnfyNLb
 zK6IPaHX/+LzkogoCDekayOCbUF6iDe+UDuMwbiycVtS2FZY5PqDyq0kNFDwekFjVq8nXKe53
 s4mekQGU6J+5wZmGRRU6LC9ruV0Crw7uznnnbYAWeNZ5XTwYRcbgohC5NIeIxFMhA5VFqkd67
 zqK9zXUHXabd5+quCJ/EL5nWcL/uXrGp457mhRao1WQljxfi+WgWsM/8Ob2d5lUWJwioayBMh
 pSxLeFfFiVreEKDpgbnI1eKLOhhb8Aq6b0ndiuE6sxWP0pXyPlIpEaq9Q4aT94t2N4k7hRUVF
 OrE3+zvT845A3gD0/dT+RFxHzcyL9q5jb5LVWnvJXY90SJs3J54eeCKQq+LVwjXgBE/Yhgj1M
 ZZaeASAY0xBqrbP8hSrwFpzSwhjdXRwFyxHGnu6mLlckQqUA/8vCruckt2yfrU4L9HqDIFI4m
 qLNb0mzOZCNLrFxM6k1K6zZaNyuvoa45OxbsG06OXQay7LBHfaVfPVd9XGzmcn2SDHa68/uIN
 cr77OzHiee/Rsg=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/3 23:06, Christoph Hellwig wrote:
> On Tue, May 03, 2022 at 02:49:49PM +0800, Qu Wenruo wrote:
>> - For the extra bitmaps
>>    We use btrfs_bio::read_repair_{cur|prev}_bitmap.
>>    This will add extra 16 bytes to btrfs_bio.
>>
>>    This is unavoidable, or we need to allocate extra memory at endio
>>    function which can be dead lock prone.
>>
>>    Furthermore, pre-allocating bitmap has a hidden benefit, if we're
>>    submitting a large read and failed to allocated enough memory for
>>    bitmap, we fail the bio, and VFS layer will automatically retry
>>    with smaller read range, giving us a higher chance to succeed in
>>    next try.
>
> This is a really bad idea.  Now every read needs to pay the quite
> large price for corner case of a read repair.  As I mentioned last time
> I think a mempool with a few entries that any read repair can dip into
> is a much better choice here.

The problem is, can mempool provide a variable length entry?

Thanks,
Qu
