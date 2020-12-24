Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967F22E28D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Dec 2020 22:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgLXVMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Dec 2020 16:12:31 -0500
Received: from mx.exactcode.de ([144.76.154.42]:38034 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbgLXVMb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Dec 2020 16:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:Content-Type; bh=L8c4T8Hfbj3DXeZxsv62xG86kR+TcHc0eON8YvrvLqM=;
        b=lX/YCo61TZbUyCcw0E3pgo9OW3+XhdG+JhTcgxIAJfMa/IRQDFfods4gN36g38GCIpN33hxWHJmlUen3wkKokTqNCItHlMICmUZhfbm/aiq5Yj6ZIQ3hiZLouTpLak+l8XO4q4Eck5ezc5xiuWElv7RhdATAfBdT+75l3jRzpI0=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.de>)
        id 1ksXuO-0007YB-8F; Thu, 24 Dec 2020 21:12:28 +0000
Received: from ip5f5af287.dynamic.kabel-deutschland.de ([95.90.242.135] helo=[192.168.0.15])
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.de>)
        id 1ksXjc-00075J-8t; Thu, 24 Dec 2020 21:01:20 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [BUG] 500-2000% performance regression w/ 5.10
From:   =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
In-Reply-To: <6df7ff08-b9bf-a06e-13a9-bf1c431920e4@toxicpanda.com>
Date:   Thu, 24 Dec 2020 22:11:39 +0100
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A2426D8D-893D-4B37-96CF-C9589730F437@exactcode.de>
References: <B4BB2DCB-C438-4871-9DDD-D6FB0E6E4F1B@exactcode.de>
 <6df7ff08-b9bf-a06e-13a9-bf1c431920e4@toxicpanda.com>
To:     Josef Bacik <josef@toxicpanda.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Spam-Score: -0.1 (/)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Josef,

> On 24. Dec 2020, at 19:09, Josef Bacik <josef@toxicpanda.com> wrote:
>=20
> On 12/21/20 2:45 PM, Ren=C3=A9 Rebe wrote:
>> Hey there,
>> as a long time btrfs user I noticed some some things became very slow
>> w/ Linux kernel 5.10. I found a very simple test case, namely =
extracting
>> a huge tarball like:
>>   tar xf =
/usr/src/t2-clean/download/mirror/f/firefox-84.0.source.tar.zst
>> Why my external, USB3 road-warrior SSD on a Ryzen 5950x this
>> went from ~15 seconds w/ 5.9 to nearly 5 minutes in 5.10, or 2000%
>> To rule out USB, I also tested a brand new PCIe 4.0 SSD, with
>> a similar, albeit not as shocking regression from 5.2 seconds
>> to ~34 seconds or=E2=88=AB~650%.
>> Somehow testing that in a VM did over virtio did not produce
>> as different results, although it was already 35 seconds slow
>> with 5.9.
>> # first bad commit: [38d715f494f2f1dddbf3d0c6e50aefff49519232]
>>   btrfs: use btrfs_start_delalloc_roots in shrink_delalloc
>> Now just this single commit does obviously not revert cleanly,
>> and I did not have the time today to look into the rather more
>> complex code today.
>> I hope this helps improve this for the next release, maybe you
>> want to test on bare metal, too.
>=20
> Alright to close the loop with this, this slipped through the cracks =
because I was doing a lot of performance related work, and specifically =
had been testing with these patches on top of everything
>=20
> =
https://lore.kernel.org/linux-btrfs/cover.1602249928.git.josef@toxicpanda.=
com/
>=20
> These patches bring the performance up to around 40% higher than =
baseline

I indeed tested the linux-btrfs for-5.11 and found the performance some =
50% better. I would hope that can be brought back to 5.9 levels sometime =
soon ;-)

> .  In the meantime we'll probably push this partial revert into 5.10 =
stable so performance isn't sucking in the meantime.  Thanks,

That certainly makes sense for the LTS kernel series.

Thanks for looking into this,
Merry Christmas,
	Ren=C3=A9 Rebe

--=20
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin, =
https://exactcode.com
 https://exactscan.com | https://ocrkit.com | https://t2sde.org | =
https://rene.rebe.de

