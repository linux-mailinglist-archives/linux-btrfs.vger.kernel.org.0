Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAB96932D1
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Feb 2023 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBKRTN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Feb 2023 12:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBKRTM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Feb 2023 12:19:12 -0500
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5A8272A
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 09:18:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id EAF893F833;
        Sat, 11 Feb 2023 18:18:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.989
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VzpYAMR4knaf; Sat, 11 Feb 2023 18:18:53 +0100 (CET)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id E4E2C3F683;
        Sat, 11 Feb 2023 18:18:52 +0100 (CET)
Received: from 90-224-97-87-no521.tbcn.telia.com ([90.224.97.87]:41268 helo=[192.168.1.18])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1pQtWV-000H7G-Li; Sat, 11 Feb 2023 18:18:52 +0100
Message-ID: <f95ded14-ee9a-6e54-dd79-fe3811560513@tnonline.net>
Date:   Sat, 11 Feb 2023 18:18:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Never balance metadata?
To:     waxhead@dirtcellar.net, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <ad4de975-3d5f-4dbb-45a5-795626c53c61@dirtcellar.net>
Content-Language: sv-SE, en-GB
From:   Forza <forza@tnonline.net>
In-Reply-To: <ad4de975-3d5f-4dbb-45a5-795626c53c61@dirtcellar.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023-02-11 02:36, waxhead wrote:
> I have read several places, including on this mailing list that metadata 
> is not supposed to be balanced unless converting between profiles.
> 
> Interestingly enough there is nothing mentioned about this in the docs...
> https://btrfs.readthedocs.io/en/latest/btrfs-balance.html
> 
> Should one still NOT balance metadata? If so - please update the docs 
> with a explanation to why one should not do that.

There is no direct issue with balancing metadata chunks.

The recommendation to not balance metadata is because it can contribute 
to a ENOSPC (no free space left) error. This happens when Btrfs needs to 
allocate another metadata chunk, but there is no unallocated space 
available.

Because metadata usually only is a small percentage of the filesystem, 
it makes sense to simply leave it unless you need to convert between 
profiles or add/remove devices.

Btrfs uses a two-stage allocator. The first stage allocates large 
regions of space known as chunks for specific types of data, then the 
second stage allocates blocks like a regular (old-fashioned) filesystem 
within these larger regions.

There are three different types of block groups/chunks that Btrfs uses:
DATA: Stores normal user file data.
METADATA: Stores internal metadata. Small files can also stored inline.
SYSTEM: Stores mapping between physical devices and the logical space 
representing the filesystem.
UNALLOCATED: Any unallocated space. Can be used to allocate any of the 
three data types.

Balancing means compacting chunks to make them fully utilised by moving 
data from other chunks and release the empty chunks back as unallocated 
space. This has the effect of defragmenting the free space which 
improves sequential write speeds, especially on spinning HDDs.

The problem with balancing metadata (that leads to the recommendation to 
not balance metadata) is that when metadata chunks are full, Btrfs needs 
to allocate new metadata chunks to write additional metadata in. Many 
disk operations, including removing files and snapshots requires 
additional metadata. If this happens when there is not enough 
unallocated space to allocate another metadata chunk the filesystem with 
fail with ENOSPC. By letting metadata chunks be underutilised, this risk 
is lower, especially on very full filesystems.

- Forza
