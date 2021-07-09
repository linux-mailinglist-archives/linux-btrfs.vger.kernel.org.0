Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561A93C227C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 12:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhGIKwN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 06:52:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58408 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhGIKwM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 06:52:12 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D3732028F
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 10:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625827768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTsBTGs8PXw75cWpzZzg3Hbh3uJTLQYhnTRsH9gGDGk=;
        b=KITVV6kBlQkvd+6A4fuQlg9Xj46EicMmj7aO93yG4gvi1/GWO1Ryv16nKOwc+jixadx5v0
        4+Oy8AqQN4NS6tUBt9qrFHizorZnQqIMB/gVGccb/I0ymMhC3RRL2iro/XN6imZnArEBAp
        auRY2KljSTGEXl0OgPbEdOIDpY2sSJo=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 52E4713457
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 10:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id WDhMEbgp6GC9PwAAGKfGzw
        (envelope-from <nborisov@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jul 2021 10:49:28 +0000
Subject: Re: where is the parent of a snapshot?
To:     linux-btrfs@vger.kernel.org
References: <20210708213806.GA8249@tik.uni-stuttgart.de>
 <0f03c92b-f3c6-bab8-fa37-ef1b489e2d38@gmail.com>
 <20210709071555.GD8249@tik.uni-stuttgart.de>
 <20210709072101.GE11526@savella.carfax.org.uk>
 <20210709073731.GB582@tik.uni-stuttgart.de>
 <20210709074810.GA1548@tik.uni-stuttgart.de>
 <eb210591-3d91-72c3-783f-ccedb9ef3359@georgianit.com>
 <20210709084523.GB1548@tik.uni-stuttgart.de>
 <b3d67963-7bb5-2fbf-f8a0-d7712925855a@suse.com>
 <20210709102653.GC1548@tik.uni-stuttgart.de>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b828b671-65db-c6d7-5622-83b8187c692f@suse.com>
Date:   Fri, 9 Jul 2021 13:49:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709102653.GC1548@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.07.21 г. 13:26, Ulli Horlacher wrote:
> On Fri 2021-07-09 (12:07), Nikolay Borisov wrote:
> 
>>> root@unifex:/# btrfs subvolume show /mnt/spool
>>> /
>>>         Name:                   <FS_TREE>
>>>         UUID:                   7f010d85-b761-45e7-8d4a-453f81bb10b2
>>>         Parent UUID:            -
>>>         Received UUID:          -
>>> (...)
>>>
>>> root@unifex:/# btrfs filesystem show /mnt/spool
>>> Label: none  uuid: 217ccc65-6ab9-44f0-b691-ec9bbcdd9496
>>>         Total devices 2 FS bytes used 209.81GiB
>>>         devid    1 size 14.55TiB used 161.02GiB path /dev/loop0
>>>         devid    2 size 14.55TiB used 100.00GiB path /dev/loop1
>>>
>>> The filesystem has different uuid than the root subvolume?!
>>
>> Yes, it's been like that forever.
> 
> No:
> 
> root@fex:~# btrfs version
> btrfs-progs v4.15.1

Which kernel version is that with?

> 
> root@fex:~# btrfs subvolume show /mnt/spool
> /
>         Name:                   <FS_TREE>
>         UUID:                   -
>         Parent UUID:            -
>         Received UUID:          -
>         Creation time:          -
>         Subvolume ID:           5
>         Generation:             85112
>         Gen at creation:        0
>         Parent ID:              0
>         Top level ID:           0
>         Flags:                  -
> 
> root@fex:~# btrfs filesystem show /mnt/spool
> Label: none  uuid: dfece157-dd48-4868-b4a3-51e539325aaa
>         Total devices 1 FS bytes used 1.85TiB
>         devid    1 size 14.55TiB used 1.90TiB path /dev/loop0
> 
> There is no UUID on the root subvolume!
> 
