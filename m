Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40482A246E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 06:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgKBFsQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 00:48:16 -0500
Received: from mailrelay1-3.pub.mailoutpod1-cph3.one.com ([46.30.212.10]:25107
        "EHLO mailrelay1-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgKBFsP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 00:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=Il77dYmzcqynTnngakLwmdXj733OHHPNJRLQLoLL8OE=;
        b=JZm9eXqtwd2Iz2L2uHkLOoAT8Zhp9f62CM39A0Y3DIK6Xh3pt/gD9rGiUtR8044TsZxar+cax07sL
         Dxm/VchTTFim8fs/6q/35Z6HQFAOQiYyQzBPdgJ0RmG2tQILp5aiuE1JBrjQUZiCUuP4Qq5bHKtRbK
         wdo188HNGwWrc7hd+MqyjW2LPP9JRkqCKZ8EUMKhWFP6wNb0UVMHn5yKhtKU7mrZ8dvX6K+IUb8Gab
         lZvxyexJzO9/+lik3aLnI+yrDh//Uf6EL2fPAk38OR3Ok9DhdDJbm4cH5wB2kpfiZVyFagtKAGZOx0
         NJL2UHwHe+jGv/lgMaalYctVlZw1ITQ==
X-HalOne-Cookie: 6cedc2aa79a2661e2f082985aeb8bc518697ea3c
X-HalOne-ID: fe6a2133-1cce-11eb-9651-d0431ea8a283
Received: from [10.0.155.198] (unknown [98.128.186.71])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id fe6a2133-1cce-11eb-9651-d0431ea8a283;
        Mon, 02 Nov 2020 05:48:12 +0000 (UTC)
Subject: Re: Switching from spacecache v1 to v2
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        waxhead <waxhead@dirtcellar.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <fc45b21c-d24e-641c-efab-e1544aa98071@dirtcellar.net>
 <20201101174902.GU5890@hungrycats.org>
From:   A L <mail@lechevalier.se>
Message-ID: <04d57bc4-c406-0d54-8299-662883fd48da@lechevalier.se>
Date:   Mon, 2 Nov 2020 06:48:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201101174902.GU5890@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> And
>> How do I make the switch properly?
> Unmount the filesystem, mount it once with -o clear_cache,space_cache=v2.
> It will take some time to create the tree.  After that, no mount option
> is needed.
>
> With current kernels it is not possible to upgrade while the filesystem is
> online, i.e. to upgrade "/" you have to set rootflags in the bootloader
> or boot from external media.  That and the long mount time to do the
> conversion (which offends systemd's default mount timeout parameters)
> are the two major gotchas.
>
> There are some patches for future kernels that will take care of details
> like deleting the v1 space cache inodes and other inert parts of the
> space_cache=v1 infrastructure.  I would not bother with these
> now, and instead let future kernels clean up automatically.

There is also this option according to the man page of btrfs-check:
https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-check

--clear-space-cache v1|v2
     completely wipe all free space cache of given type
     For free space cache v1, the clear_cache kernel mount option only 
rebuilds the free space cache for block groups that are modified while 
the filesystem is mounted with that option. Thus, using this option with 
v1 makes it possible to actually clear the entire free space cache.
     For free space cache v2, the clear_cache kernel mount option 
destroys the entire free space cache. This option, with v2 provides an 
alternative method of clearing the free space cache that doesn’t require 
mounting the filesystem.

Is there any practical difference to clearing the space cache using 
mount options? For example, would a lot of old space_cache=v1 data 
remain on-disk after mounting -o clear_cache,space_cache=v2 ? Would that 
affect performance in any way?

Thanks.
