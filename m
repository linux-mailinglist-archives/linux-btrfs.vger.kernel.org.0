Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDBC475A9C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 15:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbhLOOY1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 09:24:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36058 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhLOOY1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 09:24:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 30EBB1F387;
        Wed, 15 Dec 2021 14:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639578266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l2NpXvv3crte8xCey65F+mO2Zvh86h3npEZ2EO9DSyU=;
        b=E3NGx/nI/k+sIGjxRUhWGW+VWp9xIhTVkMA01KAfuxQQXtUXtWAJ9MScinEpj0qcKHC7gH
        wzENgR89GGGBnTUyYm5y1wCWO025s5clBlKOKCttcR79Itwt0BN0mXP4NCRaKvZ+GMF/GV
        /Ot6qqiJ7eH7BUO62GFMhGUALoeB3FQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17FF713B45;
        Wed, 15 Dec 2021 14:24:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aCMyA5r6uWHxZgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 15 Dec 2021 14:24:26 +0000
Subject: Re: BUG: btrfs confused by two different fs with the same UUID
 mounted in different moment
To:     kreijack@inwind.it, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <4ff00df9-6651-1643-15c3-ee3515c85b04@libero.it>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <cae46876-899c-579d-6434-6a5b0e309983@suse.com>
Date:   Wed, 15 Dec 2021 16:24:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4ff00df9-6651-1643-15c3-ee3515c85b04@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.12.21 г. 0:45, Goffredo Baroncelli wrote:
> Hi all,
> 
> I found this bug during a develop of a test for BTRFS. Steps to reproduce
> 
> 
> # create a filesystem with TWO loop-devices; mount it then *destroy it*
> UUID=292afefb-6e8c-4fb3-9d12-8c4ecb1f2374
> rm /tmp/d1
> rm /tmp/d2
> truncate -s 1G /tmp/d1
> truncate -s 1G /tmp/d2
> sudo losetup /dev/loop1 /tmp/d1
> sudo losetup /dev/loop2 /tmp/d2
> sudo mkfs.btrfs -U $UUID /dev/loop1 /dev/loop2
> sudo mount /dev/loop1 /mnt/btrfs1
> sudo umount /dev/loop1
> sudo losetup -d /dev/loop2    # <---- NOTE HERE
> sudo losetup -d /dev/loop1    # <---- NOTE HERE
> 
> # create a new filesystem with only ONE loop-device; mount it
> rm /tmp/d1
> truncate -s 1G /tmp/d1
> sudo losetup /dev/loop1 /tmp/d1
> sudo mkfs.btrfs -U $UUID /dev/loop1
> sudo mount /dev/loop1 /mnt/btrfs1
> 
> # BUG: now under $UUID/devinfo there are TWO devices
> # expected behavior: only one device is showed
> ls /sys/fs/btrfs/$UUID/devinfo
> 1  2
> 
> # under $UUID/devices there is ONE device1
> ls /sys/fs/btrfs/$UUID/devices
> loop1
> 
> 
> 
> Obviously this is caused by the fact that the two filesystem have the
> same UUID. However I think that in any case $UUID/devices and
> $UUID/devinfo should show the same devices.


You are right, this happens because essentially loop2 becomes stale from
the POV of the 2nd filesystem. One way to fix this would be to run

btrfs device scan -u - which will scann all devices and forget stale
ones. But in any case in the presence of stale devices we shouldn't be
adding one to devinfo. I will send a patch in a bit.

> 
> 
> BR
> 
