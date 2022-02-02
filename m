Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91244A6910
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 01:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiBBAHa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 19:07:30 -0500
Received: from mout.gmx.net ([212.227.15.15]:47607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbiBBAH3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Feb 2022 19:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643760446;
        bh=PGJXaYIKuBOVZ5Ui0U+Qx6WzRo1bn6zdl/eRd6n3Kk0=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=RCcNjM/IkDgbxafDTVhgkI17E62cl5vN6PC1kaiCbS5dGI79TFUdVd9bxF1OO971B
         sftMbXQ2oLBmUQdhcq94FWSvJ+wVWQ3XA4XG9fbhkhAny8zF34fbSRaeVHFDXmVITy
         +Xv23Lm+XQ9daKl0JzXFYpG0ZUCntCmG5PAuz65g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7zBR-1mBAju0u0J-0153Az; Wed, 02
 Feb 2022 01:07:26 +0100
Message-ID: <9d3b5405-2d76-dd2e-1b1b-a404d3cb4db1@gmx.com>
Date:   Wed, 2 Feb 2022 08:07:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] btrfs: add test case to verify that btrfs won't waste
 IO/CPU to defrag compressed extents already at their max size
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20220127055306.30252-1-wqu@suse.com>
 <20220201151439.GR14046@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220201151439.GR14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9L9JVEuiX17JWyYtn3bFXjiIXOI5/k8jYH77n4L4mR3Z9j3MQJq
 S+xQ3yUfRzQikNdwKaTb+mp+n0kYLn7Zcsof7LM/AMSjujF7hNHcOUWzN+nI77so590NI8b
 PF1kPWcxs2BBapgJehayttEieKL6AEv3hpieOZi0BRIXmt03BYuYUIyFKHxGnWP2we7gp23
 FeUDoe8BAIT8iW5ySGU6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t1+TYKKwDRM=:2R2czcv+qxFE41jOu4iq8p
 pcCXmXgzTug/5pR0CbRGWwOSNA9p9w3ZK/A1KhFLK2v35iGM8snXyShItV6B1jc12EYidrjzP
 DYsEM2CjBV8ZJnQ04ysXM9V4sZbM+DQViN2Bf9cm3djtGp5fNF6l8+0J0jZD7xPtLC88OLnI6
 snVjKRCgvIdwd3zvESUTxbJcC6O5J94lcc2HExGntNYvD4sd/zPtipbKo51HQGSjpzLOf1svW
 edY7cwhs8m6CibBS1mLtTPqSpBsOdQrS2keZwJAn/arHAh79JXf524LZOVG59a06HRmq2tfcL
 N3UemA54UgfgG2SpvLhNF5u9M9hqOd6xv54mArvgUanBhE98T2eEflEfTszPEPJMMHPXICqm9
 9/Wb4rjDVlEbFFxsbcAIJYjnU3VhcfI283lcpO498CuhxePDanDjt+1EG7t00AJ5ofWmC+pki
 G1p14hPbg+dny/HeBO17HGkLT3wqCMaMVy9R+LPRJ83y5UVJ6KkDcV5uFrY3PtpUVgYWFWIqY
 rvP8bumGw2rH2w9yTlTxMkk2uQ17zU2MvCvbGZCBiqZ9Z5kv39pSf/1yLM0DlMpoLIAEV+sWa
 EewpRLNWecsIF5fmfSx3EL7n4quUYYXnK5hbX+vAMG4R28FcZ1DJL+hrzW0jhZ5j5Vx9cgttz
 tilSIdtTgn6m6Gic0EuV5X5v4QHbXnzCy6+ywg4qK8IdungrAFVG33FIY9tfR4eA+ccJdiSkp
 QbpNfe6OHUa+9kt6amcIW7iZhMawhCorSX4O6JtSfn3eZoolpv6TJcqL+r30wQ1ymE0r8sKhl
 44AVaIY05dYsa7g3eEne2ITpovHLr3mtuKRVNUP04q3/jMClqexe1Y3dfOLg8ggeU7b9mqPGj
 dpfM5f8GxikmBiOAB4pJBdN6gxtbZxgkedQhbZ6bmkSC1qLWKg8KM5bC6baRR/czEwU/O3wCn
 L8+AHLrEsutVYocP13NX1I8tWlXb+uyi6ki0CvaEJRQzPn1Zos+9n+r8q1Kic9SN/HaaFsibn
 CfuTyJL3fbfMqyrMFICCJJaHtNMQiKePMxuZpKcohzJvxJxJedt6vdn+HHmRVR3jjzDqi+LTI
 lpOnJ4WhoWcjLs=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/1 23:14, David Sterba wrote:
> On Thu, Jan 27, 2022 at 01:53:06PM +0800, Qu Wenruo wrote:
>> There is a long existing bug in btrfs defrag code that it will always
>> try to defrag compressed extents, even they are already at max capacity=
.
>
> As commended under the patch, this not considered a bug, because the
> defrag ioctl is expected to reshuffle the extents, with or without
> compression and improving the compression ratio if asked to recompress
> with hither level. What is not perfect is the kernel side that could try
> harder to merge extents into bigger contiguous chunks, but as long as
> the compression is involved it's not possible to decide if the extents
> should be skipped or not.

What I can do is to add extra test to make sure if "btrfs fi defrag -c"
always defrag the file no matter whatever.

To me, these two factors don't conflict with each other at all.

Thanks,
Qu
