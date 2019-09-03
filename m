Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D457A5F04
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 03:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfICB7y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 21:59:54 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:37052 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfICB7y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Sep 2019 21:59:54 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-02.dd24.net (Postfix) with ESMTP id 93F9C5FDB6
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2019 01:59:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id P3oFrMpvDfKX for <linux-btrfs@vger.kernel.org>;
        Tue,  3 Sep 2019 01:59:50 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-188-174-103-80.dynamic.mnet-online.de [188.174.103.80])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2019 01:59:50 +0000 (UTC)
Message-ID: <3d9835a24d818c8e0aae09be628ed96262d8f3df.camel@scientia.net>
Subject: Re: BTRFS state on kernel 5.2
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-btrfs@vger.kernel.org
Date:   Tue, 03 Sep 2019 03:59:49 +0200
In-Reply-To: <704e10b8-b609-281c-07cd-51fcc6f78445@georgianit.com>
References: <204b3c8c-2f29-2319-b69e-37426cf5c792@dirtcellar.net>
         <704e10b8-b609-281c-07cd-51fcc6f78445@georgianit.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2019-09-02 at 20:10 -0400, Remi Gauvin wrote:
> AFAIK, checksum and Nocow files is technically not possible

While this has been claimed numerous times, I still don't see any
reason why it should be true.
I even used to have a off-the-list conversation with Chris Mason about
just that:

me asking:
>> - nodatacow => no checksumming
>>   Breaks IMO one of the big core features of btrfs (i.e. data is either
>>   valid or one gets an error)
>>   I brought that up 1-2 times at the list, but none of the core
>>   developers ever respeonded, and just a few list regulars said it
>>   wouldn't be possible, though I don't quite understand why not...
>>   The meta-data is still CoWed anyway... and the worst that could
>>   happen is that in case of crash, data is actually valid on disk, but
>>   the checksums weren't yet... which is IMO far less likely than the
>>   other cases.

he replying:
>The reason why is because we need a way to atomically update both the
>data block and the crc.  You're right that after a crash the valid data 
>on disk wouldn't match checksums, which for new file data would be 
>unexpected, but not the end of the world.  Still, XFS caught a lot of 
>heat for this because they would allow new files to be zero filled >after 
>a crash.
>
>In our case it would be much worse.  You could have a file that was 10 
>years old, write 4K in the middle, crash, and those 4K would give
>EIOs instead of either the new or old data.


So yes, it's quite clear one could not atomically update checksums and
data the same time,... but so what?
This problem anyway just matters in the case of a crash,... and in this
case it's anyway pretty likely that the data is garbage.
Only for the case where the data would have been properly written
before the crash, but not the checksum, we'd have the case that valid
data would be considered invalid.

People would however have at least a chance to notice and recover from
this.


Cheers,
Chris.

