Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E893946D424
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 14:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhLHNNc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 08:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhLHNNb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Dec 2021 08:13:31 -0500
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26A4C061746
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Dec 2021 05:09:59 -0800 (PST)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id D57205F7;
        Wed,  8 Dec 2021 13:09:56 +0000 (UTC)
Date:   Wed, 8 Dec 2021 18:09:55 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Rory Campbell-Lange <rory@campbell-lange.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: trouble replacing second disk from pair
Message-ID: <20211208180955.170c6138@nvm>
In-Reply-To: <YbCnrqxHJxYPATj9@campbell-lange.net>
References: <YbCnrqxHJxYPATj9@campbell-lange.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 8 Dec 2021 12:40:14 +0000
Rory Campbell-Lange <rory@campbell-lange.net> wrote:

> We're trying to upgrade the disks in a btrfs pair, and I have successfully replaced one of them using btrfs replace. I presently have 
> 
> Label: 'btrfs-bkp'  uuid: da90602a-b98e-4f0b-959a-ce431ac0cdfa
> 	Total devices 2 FS bytes used 700.29GiB
> 	devid    2 size 2.73TiB used 1.73TiB path /dev/mapper/cdisk4
> 	devid    3 size 2.73TiB used 1.75TiB path /dev/mapper/cdisk2
> 
> I'd like to get rid of cdisk2 and replace it with a new disk.
> 
> However I'm unable to mount cdisk4 (the new disk) in degraded mode to allow me to similarly replace cdisk2 as I previously did for cdisk3. Is this because some of the data in only on cdisk2? If so I'd be grateful to 
> know how to ensure the two disks have the same data and to allow cdisk2 to be replaced.

Looks like you need to ensure everything is RAID1 first:

  btrfs balance start -dconvert=raid1,soft /bkp
  btrfs balance start -mconvert=raid1,soft /bkp
  btrfs balance start -sconvert=raid1,soft /bkp

It might warn you about operating on system chunks, but I believe this still
needs to be done. 

If still unable to mount after that, then post what mount command do you use
and which messages you get in dmesg.

-- 
With respect,
Roman
