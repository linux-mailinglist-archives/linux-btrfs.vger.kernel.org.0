Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F111F32052C
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 13:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhBTMIl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 07:08:41 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38953 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhBTMIk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 07:08:40 -0500
X-Originating-IP: 87.154.210.199
Received: from [192.168.3.4] (p579ad2c7.dip0.t-ipconnect.de [87.154.210.199])
        (Authenticated sender: chainofflowers@neuromante.net)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 9D0A61C0005;
        Sat, 20 Feb 2021 12:07:53 +0000 (UTC)
Subject: Re: Access Beyond End of Device & Input/Output Errors
To:     Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org,
        quwenruo.btrfs@gmx.com
References: <5975832.dRgAyDc8OP@luna>
 <09596ccd-56b4-d55e-ad06-26d5c84b9ab6@gmx.com>
 <83f3d990-dc07-8070-aa07-303a6b8507be@neuromante.net>
 <5494566e-ff98-9aa9-efa3-95db37509b88@neuromante.net>
 <3a374bca-2c0b-7c95-d471-3d88fc805b57@gmx.com>
 <7a02dd5a-f7c0-69b0-0f07-92590e1cd65f@neuromante.net>
 <e179094e-8926-beee-92b7-0885f1665f89@tnonline.net>
From:   chainofflowers <chainofflowers@neuromante.net>
Message-ID: <76971f62-d050-fac2-1694-71d3115e1bf7@neuromante.net>
Date:   Sat, 20 Feb 2021 13:07:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e179094e-8926-beee-92b7-0885f1665f89@tnonline.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20.02.21 12:46, Forza wrote:

> Are you using fstrim by any chance? Could the problem be related to
> https://patchwork.kernel.org/project/fstests/patch/20200730121735.55389-1-wqu@suse.com/

Yes, that's what I mentioned in my first post.
Actually, it all started with the bug with dm, but some similar
behaviour persists even after that bug was fixed:
https://lore.kernel.org/linux-btrfs/20190521190023.GA68070@glet/T/

The only "maybe unusual" thing in my setup is that I use btrfs on the
top of dmcrypt directly, without lvm in-between, but I am not the only
one...

@Qu:
My RAM looks OK so far, I also thought of that, and I actually ran
memtest for 12+ hours and more than once. I would exclude that case.

I will do a "btrfs check --check-data-csum" and let you know.

In the meantime, I thought of a related question:
-> When a data-csum is corrupted (for whatever reason), is there a
chance that the corruption persists when I copy the whole file system
over to a new one?

As I said previously, I copied the whole fs to new, virgin SSDs more
than once with "rsync -avAHX", and I couldn't spot any issue related to
the copy itself...

(please help! ;-))

(c)

