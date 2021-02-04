Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F92C30FD8A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 21:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbhBDUAP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 4 Feb 2021 15:00:15 -0500
Received: from mail.eclipso.de ([217.69.254.104]:51256 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239931AbhBDT7P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 14:59:15 -0500
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 2C00B9AD
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Feb 2021 20:58:30 +0100 (CET)
Date:   Thu, 04 Feb 2021 20:58:30 +0100
MIME-Version: 1.0
Message-ID: <867a4658d076279f9b8c014835a161b4@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <Cedric.dewijs@eclipso.eu>
Subject: Re: Re: put 2 hard drives in mdadm raid 1 and detect bitrot like btrfs
        does, what's that called?
Reply-To: " " <Cedric.dewijs@eclipso.eu>
To:     <kreijack@inwind.it>
Cc:     <andy@strugglers.net>, <linux-btrfs@vger.kernel.org>,
        <linux-raid@vger.kernel.org>
In-Reply-To: <adf8adda-015a-59a9-fdb9-32cad9f9ea49@libero.it>
References: <f5d8af48e8d5543267089286c01c476f@mail.eclipso.de>
        <a2cd87208a74fb36224539fa10727066@mail.eclipso.de>
        <20210204105457.GI3712@bitfolk.com>
        <24e578627d205151df16b5aebe4a551e@mail.eclipso.de>
        <adf8adda-015a-59a9-fdb9-32cad9f9ea49@libero.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--- Ursprüngliche Nachricht ---
Von: Goffredo Baroncelli <kreijack@libero.it>
Datum: 04.02.2021 19:13:50
An: Cedric.dewijs@eclipso.eu, Andy Smith <andy@strugglers.net>
Betreff: Re: put 2 hard drives in mdadm raid 1 and detect bitrot like btrfs  does, what's that called?

[...]
> Hey Andy,
> 
> I would rather see performance figures for these setups:
> A) btrfs with 2 (or more) hard drives and one SSD in writeback bcache
configuration (unsafe against failure of the ssd):
> +-----------------------------+
> |      btrfs raid 1 /mnt      |
> +--------------+--------------+
> | /dev/Bcache0 | /dev/Bcache1 |
> +--------------+--------------+
> |   bcache writeback Cache    |
> |           /dev/sdk1         |
> +--------------+--------------+
> | Data         | Data         |
> | /dev/sdv1    | /dev/sdw1    |
> +--------------+--------------+

Doing that, you loose the protection of raid1 redundancy: now there is a
single point of failure /dev/sdk1. Writeback is even more dangerous...


Not really. if bcache is set to read cache, the SSD can die at any moment, without btrfs loosing any data. All written data has gone straight to the hard drives. I have not tried this scenario, but I would be very surprised if reading the data from /mnt is even interrupted for longer than a few seconds if the data cable from the ssd is pulled while data is written from another process.

You are correct about writeback cache, if /dev/sdk1 dies, all dirty data is lost, and even worse, both copies of the btrfs data are side by side on only the SSD. (But I already mentioned this in my previous mail: "unsafe against failure of the ssd")

Cheers,
Cedric

---

Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!


