Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A519F719208
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 07:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjFAFAx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 01:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFAFAw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 01:00:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DB5125
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 22:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685595644; x=1686200444; i=quwenruo.btrfs@gmx.com;
 bh=R66q9ixlP39/gw4FqqFesurK9rvS25qwKqcpmdiqJTk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GkkWnKUnEG1f9/raZbtuB8lUoiMJV8u1Hw0ZEm3jog1ZjXYDu2Nqz2YNARnHDQ9wROHhxa8
 y3F1PIsniHcjtgS6k4bOodP0TpuRv61Jef6N34vYLh2JxZMKkMMSE7H9U08Yd2DdP8KLrY6lj
 gF03xdJx13Tsa1R5oMcCJwkETHb9TvNQ6m4FcnUs0e7BP3gpySC1JwN/cJZNB8LCN57YA97L6
 EDnussGyXtYyJy0ErrTiTvxB+RZNCqeGIKawr/4A57ZF6S9Z/qRs2dFJU65JCYYNWIMpSWJS0
 Mve0WkwGiNAbvbiVw075db2sBj1jRGjq4t1EP8nfCvADv6/ukvbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbRfv-1qc0Ic39Uv-00bqfP; Thu, 01
 Jun 2023 07:00:44 +0200
Message-ID: <dcc61893-c48d-e8d9-3161-7f7b965b8e8b@gmx.com>
Date:   Thu, 1 Jun 2023 13:00:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: new scrub code vs zoned file systems
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20230531125224.GB27468@lst.de>
 <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com>
 <20230531132032.GA30016@lst.de>
 <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com>
 <20230531133038.GA30855@lst.de>
 <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com> <20230531141739.GA2160@lst.de>
 <134e56ed-1139-a71c-54d7-b4cbc27834a9@gmx.com>
 <20230601044034.GA21827@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230601044034.GA21827@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FzEyNCel8Gh8gI/MemXQhjNZtns+86vmHGfkjVvxMZsQTtlmVxK
 kC/8ecLxmBtLuleYh5/i0PRtvxx1FVrzC3P8hsyQcNgqUNUbp2aGAButMTCbj5uRSVfCcFP
 ZOxNEeX1q9OsRMKLUdq8QtD2QtYCyg1lI7nq++BPPcsrFPj7ED64FIoXNlrf5lUzMaPoIwI
 wL1e9Q13Aulmde3mVHtWQ==
UI-OutboundReport: notjunk:1;M01:P0:ldDp7IGr6rs=;A/WP43sNNS64q2dTWLVzgjXwm3H
 yIr8l37Bn+NubDjY4PrVJLgiRc+DHHvloVQ2jNOydel51eoAKMZOf0vAsDmH6smN6GeirTgka
 6lS74yFL4JCkpeet3CHW3NjT45Pa9upoxJGnExMwJH/CmSq2U74gp8ijsglx9KXgn5Trr8n1+
 zMbxRrnFLcMDvHbRsj+KhfO4SMHpn+wh7QI5hcH9/jkjDbfzPuHIjDw4QTWdBWHBtMj9MOc6H
 9X1IRWW+XEHOGR51XQMzE3Ll+CyjVXq1oisK4w5HDLRf2eFQG1XyrsURqO6BATZvGR67ylD2E
 gbf2ASFOg2rAjtP+nDRzltXz97xZzdJAIaQ8WIsZdJ7PVAORyCZ2MXCc/uTMZvYPtcQ8BBqt6
 qKaAC2XbMRXBuTSLivJ3/jEiyDAcTcMOxu/CC/+a/fJ3VSkFYw7A4A4B4xqHE+UlraDye8Wis
 3TFBTQnzYiN4V3Od0Djj3vv2722Bh0ZKoIFfMA85bFGkaMEE5Y1K+lV6Y8PYkskB8WE/ntvxv
 daefdIoXPC2EEqIrcj3pueQ081qtjIq3x+0nUWOqY/i2lC5tD3n8DhXcuFddPK0DJ9clNMFom
 K4rrHvGnA+ejkkxxU8M04WL+Nw/zw/zRb2ic8Mxp5Nmrzh3I3dWUtwKf9nXeUJQU487Ey3CXs
 kqBIdBXa7P2JtTYvf38r98yp9ggWGa+0LjuaNYf3RY8ZowHheKuw0tMwiASCeWv4ZeXvE88za
 mOEVcp5106LUO0fMWIAUFRgjjJBFqnjC8ZU/ejsr4DqwrCg8OdIBf4qpWL5toCPyoYOIqrO/N
 90cQvQFpYIVd5jr9QbsReLyoHZYw4iY6fG9X8jKaBW4AE+FlICnaMVW6LuCGJQqhn/vXoJKon
 rR6v4/caLqmD9Mthu7oJ+OB8QUcmd1SZhG+OTaaphcdjLMyeQ7KyYU9kZHTNSOar/qqeygj+S
 Ko1XAPVGp5FdA7Ta5Ne5ip2OMTg=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/1 12:40, Christoph Hellwig wrote:
> On Thu, Jun 01, 2023 at 10:09:24AM +0800, Qu Wenruo wrote:
>> So far the various wrapper around the write operations work as expected=
,
>> and hide the detailed well enough that most of us didn't even notice.
>>
>> E.g. all the zoned code is already handled in scrub_write_sectors().
>>
>> The crash itself is caused by the fact that end io part is relying on
>> the inode pointer, that itself is a simple fix.
>
> But the reason why it is relying on the inode pointer is that it needs
> to record the actual written LBA after I/O completion.  So it's not
> just a case of just add a NULL check, it needs a way to adjust the
> logical to physical mapping from the dummy added before the I/O.

That's all handled by scrub.

For scrub we're doing the writes just like metadata, with QD=3D1, aka,
always write and wait (and know where the write would land), and for the
gaps we would call fill_writer_pointer_gap() to fill them.

Thus we don't need to do any adjustment (unless you're talking about
RST, but I believe that's a different beast).

>
>> But I'm more concerned about why we have a full zone before that crash.
>
> I think this is happening because we can't account for the zone filling
> without the proper context.

I believe it's a different problem, maybe some de-sync between scrub
write_pointer and the real zoned pointer inside the device.

My current guess is, the target zone inside the target device is not
properly reset before dev-replace.

Thanks,
Qu

>
>>>    b) don't create a new relocation thread per zone, but run it from
>>>       the scrub context.
>>>
>>
>> That's a little too complex, the problem is that relocation is a
>> completely different beast, too different from the scrub code.
>>
>> But I agree the repair part for zoned needs some rework, it's not
>> working from the day 1 of zoned support, but shouldn't need that a huge
>> change.
>>
>> E.g. we just record that we need to relocate the bg, then after the
>> scrub of that bg is fully finished, queue a relocation for it.
>
> Yes.  That's what the read repair already does, and also the scrub
> code, although in a somewhat sub-optimal way.
>
>>
>> Thanks,
>> Qu
> ---end quoted text---
