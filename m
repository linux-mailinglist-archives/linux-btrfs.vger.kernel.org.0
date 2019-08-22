Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2AC79936D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 14:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfHVM2z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 08:28:55 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:38660 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfHVM2z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 08:28:55 -0400
Received: from tux.wizards.de (pD9EBF359.dip0.t-ipconnect.de [217.235.243.89])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 2A0AF4160376
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 14:28:54 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id C70F95C9997
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 14:28:53 +0200 (CEST)
Subject: Re: [PATCH v2 0/4] Support xxhash64 checksums
To:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190822114029.11225-1-jthumshirn@suse.de>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <ed9e2eaa-7637-9752-94bb-fd415ab2b798@applied-asynchrony.com>
Date:   Thu, 22 Aug 2019 14:28:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822114029.11225-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/22/19 1:40 PM, Johannes Thumshirn wrote:
> Now that Nikolay's XXHASH64 support for the Crypto API has landed and BTRFS is
> prepared for an easy addition of new checksums, this patchset implements
> XXHASH64 as a second, fast but not cryptographically secure checksum hash.

Question from the cheap seats.. :)

I know that crc32c-intel uses native SSE 4.2 instructions, but so far I have
been unable to find benchmarks or explanations why adding xxhash64 benefits
btrfs. All benchmarks seem to be against crc32c in *software*, not the
SSE4.2-enabled version (or I can't read). I mean, it's great that xxhash64 is
really fast for a software implementation, but how does btrfs benefit from this
compared to using crc32-intel?

Verifying that plugging in other hash impls works (e.g. as preparation for
stronger impls) has value, but it's probably not something most
users care about.

Maybe there are obscure downsides to crc32c-intel like instruction latency
(def. a problem for AVX512), cache pollution..?

Just curious.

thanks,
Holger
