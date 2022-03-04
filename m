Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FA24CE113
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Mar 2022 00:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiCDXkm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 18:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiCDXkl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 18:40:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8450053B4A
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Mar 2022 15:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646437190;
        bh=3982PgZHLi73PD0n/eVkGH8sPaUf+2P/YCxFooTWWPo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=EhhFgwoVZSvso32lqB0EpJeJ1xmBuX/HYSgVKFPXtQ8xewdvI2qDUcGbUfxiiSRd4
         INixCSslrKe9jGFi9dumL7Vm/b67K/NffnmkuFMuCLZqebFrVGGyvM233DgBieT33T
         WDPVu5r0dJl30lQrUoLYgdGKR70Yh5g3AI0eHCg0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxUs7-1oNuQe1msD-00xqNe; Sat, 05
 Mar 2022 00:39:50 +0100
Message-ID: <2e9ee21e-65aa-9fb5-1d1c-1d6dea93eb12@gmx.com>
Date:   Sat, 5 Mar 2022 07:39:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Is this error fixable or do I need to rebuild the drive?
Content-Language: en-US
To:     Jan Kanis <jan.code@jankanis.nl>, linux-btrfs@vger.kernel.org
References: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2qQEJJ/P1qN2BA1Q4K+QolojqGE/aQ+XTFMyhJ9xg+BQvF58ahN
 OmhuJKjIQEIvUd+uAVclzirINhfv9yU+tG4YMDtVYqfdeT6cAJ2dCYWcwiKVrwOotNGGOm7
 Wb/rnW9tpe+u06c8YZd+RTIj7ooeDRbtzmk6NfDT82XUYzg+OGDl3vGbYb55ec5A7ShSbmG
 V84IiGSAReG78mccCR+fA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cKRYQ3jcNYg=:ahCC3EdjKq8M5LygWYzaxe
 3PTCoO92IhvkEw50JTvYWAxkbz7tQPXCuPaOXYaRn7EXT3XAC5+SYY9iMriIncdoCC8KqGcN8
 ttq5hxbB93BMFk37Tm5EF1aebrMSFwCbxwsWM9ml1hVx9bDAuaOjr8OxNHWqbJP8DuWHGVR1g
 9cr0GxqCBtLh8D37LIEBgbozPbtCJX6rLnNJg/kdkJnSCAVrpkvyGs0KWDRJNPi9YbKd+2qR1
 g8/ld8cupwUpk9lkSf4cIMFGfZxKhHjI3UdAyQHJNUFhGEIpnaMf6zAcCMrtOodLwntWURcJT
 EE7yk+Kko/Vpp9ajI5LV6s2IqxrHQ9sU0ZPsBMjtFPd6z80nKOKyKO7uxnCD25XmdDqgb7n8A
 jCvyAiDrJg/GILODrn5Nwen/Rvu07U55mOb5ZQzPMxcDGqvh9PXxGVRxmdCq0IfyzvrNy2iox
 TW8zs/i/9i+fEpOwiN2MV+8TQpJG6IsxjTkWJ1cSw/ZqmhgJl8Rd/NM+L8r7/a7E0mIp3UWB+
 qKgZ3KzUFGTtiltafJCiakmSVinXGGI/pwVvHAVlevO2ZGMuiOjmQJX1atmBE6sHXRlIHrphL
 otWql8wVejwRb/bhQJ6NZ/yu8d1nfvtHabnTNY3USxUvpSCmjdSTPomMhxdAT17sDkJqaBgHU
 hLVt3Ya1GxY3OJ3lc9JE1D1A5VctgCjHIWYFyaMheQ5EQOJV1rZc4WlWXnwtjIOLdXYsif8Ff
 54vSfLKPPTul8pv5npOIHcXChU68lEYbCIcnmHJ+Rszh4LT+0kVzNaLLhiKr8cY3te2aLMNnp
 HsjigzoCTIiI2yJmaD+3k3ewYil2vDrj4+yvaUiJkQF5Xn3mHiEie7zaugGzOea/a28hCxS7O
 AI9yi6XEFNg0RxoEP8CLE4VrkACYWAp5UjTFD3cIsPpyauFoozpUhHty19w85eg2JuiGLWRAt
 f6y6RrSB+zYtR9brgH1qxfqAlBRyPH2BpIvylW8yqxggZJj5ueaTqvC/IWACoy7JsPh7dqOUS
 O9H4roHu5THot+V41vtI34I/kfKxD/4LwqACKgYtHa+jpgRIzyb8dbFjCoMeeGNSW49WIlyA4
 MDp7+twGuXWXDI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/5 07:33, Jan Kanis wrote:
> Hi,
>
> I have a btrfs filesystem with two disks in raid 1. Each btrfs device
> sits on top of a LUKS encrypted volume, which consists of a raw drive
> partition on a SMR hard disk, though I don't think that's relevant.
>
> One of the drives failed, the sata link appears to have died, if I'm
> interpreting the system logs right. As it's a raid 1 the system kept
> running and I didn't notice the dead drive until some time later,
> during which I kept using the filesystem.
> Something wasn't behaving right, so I decided to reboot. After the
> reboot the btrfs filesystem didn't come up and one of the drives was
> dead. I was able to mount from the remaining device with
> degraded/read-only, all data seemed to be there.

One thing to keep in mind is, degraded/read-only is always good.

Btrfs is not good at handling split-brain cases yet (meanings two device
get degraded mounted each, and new data writes happen for both devices).

So great you didn't do write to the devices.

> I took out the dead drive and put it into another system for
> examination. After some fiddling the drive came up again, so it wasn't
> permanently dead after all. I was able to mount it degraded/read-only.
> It looked good except for missing the latest changes I made to some
> files I was working with, so it was a bit out of date. A btrfs scrub
> showed no corruptions.
> I put the drive back in the original system, thinking that btrfs would
> either refuse to mount it or fix it from the other copy. The
> filesystem automatically mounted rw without a 'degraded' option, and
> the filesystem could be used again. The logs showed some "parent
> transid verify failed" errors, which I assumed would be corrected from
> the other copy. Attempting to mount only the drive that had failed
> with degraded/read-only now no longer worked.
>
> It's now some days later, the filesystem is still working, but I'm
> also still getting "parent transid verify failed" errors in the logs,
> and "read error corrected".

'Cause your workload may not yet fully CoWed the whole metadata.

Thus sometimes you will still hit out-of-sync data from the old device.

  So by now I'm thinking that btrfs
> apparently does not fix this error by itself. What's happening here,
> and why isn't btrfs fixing it, it has two copies of everything?
> What's the best way to fix it manually? Rebalance the data? scrub it?

Scrub it would be the correct thing to do.

For read-write mount, scrub will try to read all data/metadata, and
check against their checksum.
Any mismatch will result btrfs to write back the data using a good copy.

Thus it should solve the problem.

We may want to do an automatic scrub for out-of-sync devices in the near
future.

Thanks,
Qu

> delete, wipe and re-add the device that failed so the mirror can be
> rebuilt?
>
> best,
> Jan
