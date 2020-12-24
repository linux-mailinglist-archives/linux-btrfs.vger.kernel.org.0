Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE392E28A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Dec 2020 19:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgLXSxx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Dec 2020 13:53:53 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:52356 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbgLXSxw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Dec 2020 13:53:52 -0500
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.93.0.4)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1ksVjV-0003Ga-OE; Thu, 24 Dec 2020 19:53:05 +0100
Subject: Re: dm-crypt with no_read_workqueue and no_write_workqueue + btrfs
 scrub = BUG()
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        dm-crypt@saout.de, linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        kernel-team <kernel-team@cloudflare.com>,
        Nobuto Murata <nobuto.murata@canonical.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <16ffadab-42ba-f9c7-8203-87fda3dc9b44@maciej.szmigiero.name>
 <74c7129b-a437-ebc4-1466-7fb9f034e006@maciej.szmigiero.name>
 <20201223205642.GA19817@gondor.apana.org.au>
 <CALrw=nFRLxpG+Qzy=wki1m6HnQUqPK9CQFGEEnB1tjSF0ex4UQ@mail.gmail.com>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <f3b3c90e-90e6-9228-f2e5-172997eebf85@maciej.szmigiero.name>
Date:   Thu, 24 Dec 2020 19:52:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CALrw=nFRLxpG+Qzy=wki1m6HnQUqPK9CQFGEEnB1tjSF0ex4UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24.12.2020 19:46, Ignat Korchagin wrote:
> On Wed, Dec 23, 2020 at 8:57 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>>
>> On Wed, Dec 23, 2020 at 04:37:34PM +0100, Maciej S. Szmigiero wrote:
>>>
>>> It looks like to me that the skcipher API might not be safe to
>>> call from a softirq context, after all.
>>
>> skcipher is safe to use in a softirq.  The problem is only in
>> dm-crypt where it tries to allocate memory with GFP_NOIO.
> 
> Hm.. After eliminating the GFP_NOIO (as well as some other sleeping
> paths) from dm-crypt softirq code I still hit an occasional crash in
> my extreme setup (QEMU with 1 CPU and cryptd_max_cpu_qlen set to 1)
> (decoded with stacktrace_decode.sh):
(..)
> This happens when running dm-crypt with no_read_workqueues on top of
> an emulated NVME in QEMU (NVME driver "completes" IO in IRQ context).
> Somehow sending decryption requests to cryptd in some fashion in
> softirq context corrupts the crypto queue it seems.

You can try compiling your test kernel with KASAN, as it often
immediately points out where the memory starts to get corrupted
(if that's the bug).

Enabling other "checking" kernel debug options might help debugging
the root case of this, too.

> Regards,
> Ignat

Thanks,
Maciej
