Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF11F13BE5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 12:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgAOL2R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 06:28:17 -0500
Received: from smtp.mujha-vel.cz ([81.30.225.246]:46347 "EHLO
        smtp.mujha-vel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbgAOL2R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 06:28:17 -0500
Received: from [81.30.250.3] (helo=[172.16.1.2])
        by smtp.mujha-vel.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <jn@forever.cz>)
        id 1irgqM-0007HS-AF; Wed, 15 Jan 2020 12:28:15 +0100
From:   jakub nantl <jn@forever.cz>
Subject: Re: slow single -> raid1 conversion (heavy write to original LVM
 volume)
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <107f8e94-78bc-f891-0e1b-2db7903e8bde@forever.cz>
 <CAJCQCtSeq=nY7HTRjh0Y_0PRJt579HwromzS0NkdF4U6kn_wiA@mail.gmail.com>
 <2e55d20c-323f-e1a2-cdde-8ba0d50270e7@forever.cz>
 <CAJCQCtQhVQrnq7QnTd6ryDSg4SAGv55ceJ+H8LTM6MEYzQX4jQ@mail.gmail.com>
 <ce3fb06f-5a24-df55-f1b5-a0c2b176ec13@forever.cz>
 <CAJCQCtTijDTQiaO-SUPZ-R40dQbLmrfKhGLCifv6=fB2O6zxJA@mail.gmail.com>
Message-ID: <80b3a11a-484c-8920-1ee9-727e754fe5f1@forever.cz>
Date:   Wed, 15 Jan 2020 12:28:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTijDTQiaO-SUPZ-R40dQbLmrfKhGLCifv6=fB2O6zxJA@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15. 01. 20 3:23, Chris Murphy wrote:
> Jan  8 12:28:54 sopa kernel: [   13.552491] BTRFS info (device dm-0):
> disk space caching is enabled
> Jan  8 12:28:54 sopa kernel: [   13.803006] BTRFS info (device dm-0):
> bdev /dev/mapper/sopa-data errs: wr 420, rd 44, flush 0, corrupt 0,
> gen 0

these errors have to be  old, no signs of HW problem with orig disk. see
smartctl output https://pastebin.com/PgM84cGC

> Any idea what these are and if they're recent or old? This is the
> original device with all the data and there are read and write errors.
> Write errors mean writes have been dropped. It's usually an indicator
> of a device problem.
>
> Jan  8 12:59:40 sopa kernel: [  229.560937] Alternate GPT is invalid,
> using primary GPT.
> Jan  8 12:59:40 sopa kernel: [  229.560954]  sdb: sdb1 sdb2 sdb3

not a problem, I have  copied MBR to the new disk (dd) and fixed it
immediately by fdisk write...

is it still worth to wait for something to happen or should I reboot?

jn

