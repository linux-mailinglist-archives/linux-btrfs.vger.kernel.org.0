Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94352E02F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Dec 2020 00:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgLUXe4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 18:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUXez (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 18:34:55 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1AEC061793
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Dec 2020 15:34:15 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id EFE299C031; Mon, 21 Dec 2020 23:33:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1608593608;
        bh=mdYV38YC/SbB7828eCpUoLQ8D2ccOqAOonnLBsGFA/E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cix4RZY8B7QEhU57CmEgJu9X3FfDjPPgvMXE4qCEwFg+htlod6h9fuIH6xx6ZBebg
         Vy26sb6yDv5tFw+w2HZRevgyxLOJVSSwidh7zJ1EK3z1rarPqvlBV9OXf/j1akCRCk
         4A+Zoj3bUQz55kTeIaGzWRWShEwxyfO79CyKM8nCIZ8XGOzBZ9AN6QEahqvl3ROBzD
         Tyq/FMUf9r4YIkQTD6jNTa55A6C3M+4L+HEVwQ2FXUH+mspAkz2NzW0bFvfvD89rNi
         IJmnIOKBY9Qsps5RE7h0aBA6AHJkwztEvSvPFny1ZPUjDn8tjcrQu6LawVGIPAlFJM
         DR+i0MTTmG88Q==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-4.2 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A autolearn=unavailable
        autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id D97909BAB3;
        Mon, 21 Dec 2020 23:33:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1608593603;
        bh=mdYV38YC/SbB7828eCpUoLQ8D2ccOqAOonnLBsGFA/E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WKk5+5yMFvfaYE8fIxdSQPCTPijmmRV/SHlVpbvdD0vzk4+ewTVA1+X+p21gvThak
         Jmvl3h/Em/HEHFxxUfCZD7JWQRT/phmIPwYj0e071YIFo2tkasu9vmqUMGahhv7ABd
         F10S3sevsyGjMcC0XfoeRgmDqQNxR4Oafm/hYOVeE6sDIMiELfF4oU8i+MxX/wL+JZ
         8uj/kuEbDDWMSf5UANF5IL6KfWTbZmAjCSnWk2mlSlT0KRm3EgQ6ukGu3pcmEM/RQm
         /kQ4rzodC+xEbNgSqBOn5kXQUHkQbqfbu/LmxJ9RxERfMnNDBuyWCK0jnLv8nyJMjN
         w1hxMijQ0MEHw==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 5DF1C1BDE7F;
        Mon, 21 Dec 2020 23:33:22 +0000 (GMT)
Subject: Re: AW: WG: How to properly setup for snapshots
To:     Claudius Ellsel <claudius.ellsel@live.de>,
        Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>
 <AM9P191MB1650AE92A25D9618163309E5E2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16502C509C161C5827FC1686E2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <28c839e8-4d4f-031c-ee3e-3e676e344db3@cobb.uk.net>
Date:   Mon, 21 Dec 2020 23:33:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <AM9P191MB16502C509C161C5827FC1686E2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/12/2020 20:45, Claudius Ellsel wrote:
> I had a closer look at snapper now and have installed and set it up. This seems to be really the easiest way for me, I guess. My main confusion was probably that I was unsure whether I had to create a subvolume prior to this or not, which got sorted out now. The situation is apparently still not ideal, as to my current understanding it would have been preferable to set up a subvolume first at root level directly after creating the files system. However, as this is only the data drive in the machine (OS runs on an ext4 SSD) it is at least not planned to simply swap the entire volume to a snapshot but rather to restore snapshots at file / folder level, where snapper can also be used for.
> 
> One can possibly also safely achieve the same with only using btrfs commandline tools (I made the mistake of not thinking about read only snapshots when I wrote about my fear to delete / modify mounted snapshots). Still I have a better feeling when using snapper, as I hope it is less easy to screw things up with it :)

I have never used snapper but I know it is a popular tool. But there are
many other tools - with their own advantages, disadvantages and ways of
working. You may want to experiment with several of them. Personally I
use btrbk for automation of snapshots.

Just remember that btrfs snapshots are not a backup tool. At best, they
are a convenience tool, for quickly restoring deleted or modified files
(or full subvolumes) to an earlier (snapshotted) state without having to
access your backups. But they are completely useless if a hardware or
software problem (kernel bug, disk problem, system memory error, faulty
cable, etc) corrupts the filesystem. You don't have a backup solution
unless you are copying the files to another physical disk, preferably on
a different system. btrbk can help with that as well (but it is just
automating btrfs send and btrfs receive underneath).
