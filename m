Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6409F1E831C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 18:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgE2QGV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 May 2020 12:06:21 -0400
Received: from syrinx.knorrie.org ([82.94.188.77]:34392 "EHLO
        syrinx.knorrie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2QGT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 May 2020 12:06:19 -0400
Received: from [IPv6:2a02:a213:2b80:f000::12] (unknown [IPv6:2a02:a213:2b80:f000::12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id 9EE9E609269E3;
        Fri, 29 May 2020 18:06:16 +0200 (CEST)
Subject: Re: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>
References: <20200405082636.18016-1-kreijack@libero.it>
From:   Hans van Kranenburg <hans@knorrie.org>
Autocrypt: addr=hans@knorrie.org; keydata=
 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
Message-ID: <a84d7342-47ed-e162-3047-f7ccdc77fdf1@knorrie.org>
Date:   Fri, 29 May 2020 18:06:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200405082636.18016-1-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Goffredo,

On 4/5/20 10:26 AM, Goffredo Baroncelli wrote:
> 
> This is an RFC; I wrote this patch because I find the idea interesting
> even though it adds more complication to the chunk allocator.
> 
> The core idea is to store the metadata on the ssd and to leave the data
> on the rotational disks. BTRFS looks at the rotational flags to
> understand the kind of disks.

Like I said yesterday, thanks for working on these kind of proof of
concepts. :)

Even while this can't be a final solution, it's still very useful in the
meantime for users for which this is sufficient right now.

I simply did not realize before that it was possible to just set that
rotational flag myself using an udev rule... How convenient.

-# cat /etc/udev/rules.d/99-yolo.rules
ACTION=="add|change",
ENV{ID_FS_UUID_SUB_ENC}=="4139fb4c-e7c4-49c7-a4ce-5c86f683ffdc",
ATTR{queue/rotational}="1"
ACTION=="add|change",
ENV{ID_FS_UUID_SUB_ENC}=="192139f4-1618-4089-95fd-4a863db9416b",
ATTR{queue/rotational}="0"

> This new mode is enabled passing the option ssd_metadata at mount time.
> This policy of allocation is the "preferred" one. If this doesn't permit
> a chunk allocation, the "classic" one is used.
> 
> Some examples: (/dev/sd[abc] are ssd, and /dev/sd[ef] are rotational)
> 
> Non striped profile: metadata->raid1, data->raid1
> The data is stored on /dev/sd[ef], metadata is stored on /dev/sd[abc].
> When /dev/sd[ef] are full, then the data chunk is allocated also on
> /dev/sd[abc].
> 
> Striped profile: metadata->raid6, data->raid6
> raid6 requires 3 disks at minimum, so /dev/sd[ef] are not enough for a
> data profile raid6. To allow a data chunk allocation, the data profile raid6
> will be stored on all the disks /dev/sd[abcdef].
> Instead the metadata profile raid6 will be allocated on /dev/sd[abc],
> because these are enough to host this chunk.

Yes, and while the explanation above focuses on multi-disk profiles, it
might be useful (for the similar section in later versions) to
explicitly mention that for single profile, the same algorithm will just
cause it to overflow to a less preferred disk if the preferred one is
completely full. Neat!

I've been testing this change on top of my 4.19 kernel, and also tried
to come up with some edge cases, doing ridiculous things to generate
metadata usage en do stuff like btrfs fi resize to push metadata away
from the prefered device etc... No weird things happened.

I guess there will be no further work on this V3, the only comment I
would have now is that an Opt_no_ssd_metadata would be nice for testing,
but I can hack that in myself.

Thanks,
Hans
