Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3AD4E49BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 00:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbiCVXrS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 19:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiCVXrR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 19:47:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF764C439
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 16:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647992737;
        bh=7abHtYMxdD0ap0NcLcuJnKI3lEx52D+UKqfYcEpD//g=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=WDGQom2gTBxwAdk4lh828IWK2cn1NXOxzG5EM2GrBiiMmP0H4VS7s3ft+G+lc2kfT
         qTwknbRr4MQCa9SwCtty3EUvJvhk83zsAJVFx/wrQnchg1usEOpcJ1TIqUDjYGFPRL
         EwNJ9pzKD3vkMmhR/ie1erpBo9eWIqX4OTve7KdI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MeU0k-1o7EsG1aOi-00aUrh; Wed, 23
 Mar 2022 00:45:37 +0100
Message-ID: <96e622b1-fffb-34ae-6055-49bd7a4ea23b@gmx.com>
Date:   Wed, 23 Mar 2022 07:45:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1647248613.git.wqu@suse.com>
 <Yjnu7yWxAforTGQF@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 00/18] btrfs: split bio at btrfs_map_bio() time
In-Reply-To: <Yjnu7yWxAforTGQF@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9/xXvUSSPS8/tb6DZF/fZnt3DQcMb83dmTN3juUIisUo0To35MJ
 QDSe0b2ZIA4DtZJNsRiVqODbe5agDGF2fSCwJKRqvPUTz+dMFn0dwAPyEZivQvw27tXHZZS
 mg+uWu4QX2UbVMm5+nDdzP+GferDLNMLSgMXB+z9bYkHTqJbhbcE8itoi3APXtiNkPY74PX
 ebMQv9lwFbNkkOzt5+Ijw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:znf/MN8eMuk=:z/hpR+f8fpP9ngAk/Yai1Y
 8qfQSasebjYTPQMhGp3gyCr/qRFaBzX3KCo7owRZ78NcCo09rT8L3esFtd5gbM4inv5dGMoMf
 vltdS7VuHttzhyuyzNKkUSpsWCvKnWUsZwoGaLCzhntXdca9MMyZrwGP4ZT9wlAVh2HSN7rMq
 JounRhUkSAqby8Cz6Ux0EUsBC8TfL//uZHB68YHxVg5WmCEzSwFRAFPgyItboeaD7aA9TNduP
 s2LOoOIeNPdDdoCXpvgongD/Y5MzxBJOqD8lt40SrM7gLaIEcHF/TRzDgk+H2u5/tg74zRqW6
 +PH5MpEVryyIlMFrkHI7ts/2jF8GF2GoRdpNBE94H4Vo2ktjEylFTFF9H2zIkYvvnWj6LY7b3
 sHQIaAVIyqScJ7lECQZ43/a/RNouvsXNQqAqUenYc328hQvMdiEJxHz9rOlYqLx//SJg+icWM
 JIQbdptiDqhZCvBhhuTeecZhefnZoa9Y9K/HbsZCVSsf5DS48G8+Nk2mrkm6E3bhXjm9fp7J4
 cmQcYX60wkB5+cDNpQ6b1Qb/U0Ymal6tAzPFWPXaIIdeV8wdwFGEbxsCYDHdBRMQvcV2Vryac
 NxZQJVMxJ2E0xt4/WEBF986uQDd2sAts0hJbUAcX9F4nxIpvBmX5iZooRSDHb9Lh/bjFbpBlF
 ofBUtpQexBQ6Usx8TE9aAaG+AfqZuJkMs7s+G3t/dLh2EwnEY47/smjdTb5LRKnQToI9gcjRF
 RG5Sw0LQdeRu+Lzfs21viqVzZViIfjVjiu/fPlS6gb6PUHAxjCNbQ8ta1k666uswxtYfrvPgL
 B8l1Kptcxoel1ang7SaqARDhWZpJaAi9qfxKly7kv/G638xp/UpTMExs12L9sQPYIDN7J1Qdj
 tvwxBQgcNDlzsdcbaxDUBFBD1jgOXmgXDl2dfKGn3DJoeIGUIvooRcpBTUHSWWhsDSryYw0E8
 o/Qh5VM5W4xQrjjEwcFufGLQrr5DZflOUxF3MFZjIUblY80OhXlIHYFnNufFgEuTqeOnJYJrb
 hnAP6mzq4O+mUyYtso/iKTh21GSMvRaKQDZy4UZpWe0ggYdpd7ptkyLqNcNpMR4X96ZEgVV/k
 tiYcJ/v+ZSk8oc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/22 23:44, Christoph Hellwig wrote:
> I spent some time looking over this series and I think while it has
> some nice cleanups, it also goes fundamentally in the wrong direction.

Well, at least I got some review, that's always a good news.

>
> The way bios are used is that the file systems always builds bios
> to it's own limits like extents,

That part is not changed. We still have extent limits.

> lower drivers split them up if needed.
> By building the bigger bios in btrfs a lot of the completion handling
> gets much more complicated.

The "bigger" bios is still limited by extents.

The work here is to mimic the stack driver behavior.

For dm-raid0, the fs only splits its bio at its extent boundary, then
the dm driver further split according to stripe boundary.

IMHO this behavior is simpler, and has better layer separation.
Thus it's worthy to do it the same in btrfs.

But you're correct about the complexity.
In fact I also find out that, we don't really need to do as complex as I
did in that series.

One thing to improve is the split bio handling.
We can do checksum verification later, after all data has been read from
disk.

Then we don't need the complex split bio handling.
>
> I had actually started a series a bit ago to clean up the btrfs bio
> usage bottom up, taking advantage of the newer bios interfaces.  I've
> spent some of my vacation time last week to finish this off and also
> add a few iomap improvements so that btrfs doesn't need to clone the
> iomap dio bios above btrfs_map_bio either.  I'll send it out in a bit.

Let me steal some tricks from your series.

Thanks,
Qu
