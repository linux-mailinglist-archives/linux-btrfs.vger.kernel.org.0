Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F93F3E3C
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Aug 2021 09:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhHVHJ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Aug 2021 03:09:56 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:60210 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhHVHJz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Aug 2021 03:09:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 2747A3F4CB;
        Sun, 22 Aug 2021 09:09:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8F66PGz8gcfj; Sun, 22 Aug 2021 09:09:11 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id A418E3F4B4;
        Sun, 22 Aug 2021 09:09:11 +0200 (CEST)
Received: from [192.168.0.10] (port=58220)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mHhbT-0000vz-0w; Sun, 22 Aug 2021 09:09:11 +0200
From:   Forza <forza@tnonline.net>
Subject: Re: Support for compressed inline extents
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <afa2742.c084f5d6.17b6b08dffc@tnonline.net>
 <20210822054549.GC29026@hungrycats.org>
Message-ID: <1097af0f-fb9e-3c68-24b9-2232748ed77c@tnonline.net>
Date:   Sun, 22 Aug 2021 09:09:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210822054549.GC29026@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-08-22 07:45, Zygo Blaxell wrote:
> On Sun, Aug 22, 2021 at 01:25:48AM +0200, Forza wrote:
>> I'd like to see the option to allow compressed extents to be inlined. It
>> could greatly reduce disk usage and speed up small files by avoiding
>> extra seeks.
>>
>> I tried to understand why we don't allow
>> it but could only find this reference
>> https://btrfs.wiki.kernel.org/index.php/On-disk_Format#EXTENT_DATA_.286c.29
>>
>> "the extent is inline, the remaining item bytes are the data bytes
>> (n bytes in case no compression/encryption/other encoding is used)."
>>
>> Is the limitation in the disk format or perhaps in the compression
>> heuristics?
> 
> A far better question is "when did we _stop_ compressing inlined extents",
> and the answer is in v5.14-rc1: f2165627319f "btrfs: compression: don't
> try to compress if we don't have enough pages".  This check affects
> inlined extents, so they are never compressed after 5.14.  Oops.

I don't understand this comment as you say below we do not allow 
compressed (encoded) data inline? Do you mean we only used to compress 
data inline if the original uncompressed data would fit inline too?

> 
>> Not all use cases would benefit, and we'd have more metadata, which
>> increase the risk of enospc. But i think it could be very valuable
>> nonetheless. For example mail servers, source code/CI, webservers, and
>> others that commonly deal with many small but highly compressible files.
>>
>>
>> I did a quick test by copying all files smaller than 8192 bytes from
>> my home server. The filesystem has 90GiB used.
> 
> An 8192 byte file cannot currently be inline (on a 4K page size system)
> because the read code in btrfs assumes inline extents always fit inside
> one page after decoding.
> 
> What you're really asking here is "can we have an arbitrary length
> of compressed inline extent, as long as the encoded version fits in a
> metadata block" and the short answer is "not with this on-disk format,"
> because existing readers cannot cope with it.  If we are to consider this,
> it requires an incompatible format change.

Yes, this is what I meant. As long as the resulting data after 
compression would fit inline, we should allow it to be inlined.

> 
>> The result was 357129 files, 207605 inline. 792MiB disk usage, 1.0GiB
>> data size, or 1.1% of fs usage.
>>
>> Zstd compressed them, which gave 295419 files inline. Total data size
>> 500MiB. The size of the inlined files is 208MiB.
>>
>> Uncompressed the inlined files to see how much of the original data
>> could have been compressed and inlined. 599MiB total data with 501MiB
>> disk usage and 207576 inlined files.
>>
>> All in all we would save 501-208=293MiB, which is very good. Ontop of
>> this we'd have savings because we avoid padding up to 4kiB block size
>> due to inlining. Also my test only included files less than 8kiB. It
>> is possible that many files larger than this could be compressed to
>> less than max_inline size.
>>
>>
>> Thanks
