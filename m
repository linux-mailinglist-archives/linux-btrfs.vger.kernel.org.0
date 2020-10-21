Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EBC295427
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 23:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506033AbgJUV0W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 21 Oct 2020 17:26:22 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:44201 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441532AbgJUV0W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 17:26:22 -0400
Received: from [192.168.177.174] ([91.63.161.114]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1N4i3d-1kOMYA1YtL-011f2y; Wed, 21 Oct 2020 23:26:17 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
Subject: Re[2]: parent transid verify failed: Fixed but re-appearing
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Date:   Wed, 21 Oct 2020 21:26:24 +0000
Message-Id: <emeabab400-3f6d-4105-a4fd-67b0b832f97a@desktop-g0r648m>
In-Reply-To: <20201021212229.GF21815@hungrycats.org>
References: <em2ffec6ef-fe64-4239-b238-ae962d1826f6@ryzen>
 <20201021134635.GT5890@hungrycats.org>
 <em85884e42-e959-40f1-9eae-cd818450c26d@ryzen>
 <20201021193246.GE21815@hungrycats.org>
 <em33511ef4-7da1-4e7c-8b0c-8b8d7043164c@desktop-g0r648m>
 <20201021212229.GF21815@hungrycats.org>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.38682.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:GyyAu4q3J/lKdz8oCCeO1+yNjhr+xqo53On7za0TWK6xyPPtEWZ
 NOt8BPazWYK1ss7hBAZDQfVhe0mW/WvqP4IuvHONJLD1wVt8MDV+6r3kwDEQzJlkxyfFW4F
 VYqJxZuG3UDv1IAqOhv5RgZGf6W1q6cZjA34sL1xY2NUNSHmw5jgKwhDf3MjO8gkwrUrB9V
 DyGlCFKakzhb8LfT3vnhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hQqve1JFcUQ=:UVxIeRA48d9M1gun5mGIks
 +luCZzff0Ooc4YgKRTcLP2YULT790CVPkyt8zpqVu3uV79ubtXfSOa9LPZtlIohE68X2U79CR
 bOMjVu7iYLd4YntQy9zyKAP4SphfhOT51mjY6kSuT9i76JIioNia4LctjBZAEleX4udkwmbJU
 FwHzPNkKL9eZ5fdkpZOlq7iZ+R6d6E59kiXEkFzvzflTuvxSLYRm7Mcvj9ywBMoC644GXIF/s
 8TweZpuI+jjCKzP0OVOQwGSkCTnkHltxuUGEgDPF4Mkan8ATZK0Z6uiU6YN68WhWM10Yet8as
 YIb85KSKyaJ7oZUrxXMjY5ww9OCUN8lDrg4tJUeuXtwNr1Rp2y3WlALfsWcblA4WC6fo/gVjX
 zdDkdTtRKr6s2WVcg3Jsj9Z7MEIlndA4bjtC/iD+HTgoVQCgqMZRXZg5gWR5eseO2p7JqQykA
 TymLuGwvuQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

thanks for your reply.

>>  So, what does the generation_errs tell us?
>
>Try btrfs dev stats on the filesystem mount point instead of the device.
>We want to see if there are generation errors on both disks or just one.
>
>This indicates there was a parent transid verify failure observed on
>that disk in the past.
>
btrfs dev stats /srv/DataPool
[/dev/sda1].write_io_errs    0
[/dev/sda1].read_io_errs     0
[/dev/sda1].flush_io_errs    0
[/dev/sda1].corruption_errs  0
[/dev/sda1].generation_errs  1
[/dev/sdj1].write_io_errs    0
[/dev/sdj1].read_io_errs     0
[/dev/sdj1].flush_io_errs    0
[/dev/sdj1].corruption_errs  0
[/dev/sdj1].generation_errs  0
>
So, on one of the drives only.
>
>If there is one on the other drive too then the filesystem may be broken,
>though I'm not sure how you're getting scrub to work in that case.
>
So, we are lucky, it seems?
>
>scrub already reports pretty much everything it finds.  'btrfs scrub
>start -Bd' will present a per-disk error count at the end.
>

So, should I do that now/next?
Anything else, I can do?

Regards,
Hendrik

>
>>  Greetings,
>>  Hendrik
>>
>>

