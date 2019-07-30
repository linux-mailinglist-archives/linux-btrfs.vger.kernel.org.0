Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571637A3E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 11:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfG3JXD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 05:23:03 -0400
Received: from mail1.arhont.com ([178.248.108.111]:44138 "EHLO
        mail1.arhont.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfG3JXD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 05:23:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id 9FB8F36008B
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2019 10:22:59 +0100 (BST)
Received: from mail1.arhont.com ([127.0.0.1])
        by localhost (mail1.arhont.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ncE-M2jJu4JQ for <linux-btrfs@vger.kernel.org>;
        Tue, 30 Jul 2019 10:22:57 +0100 (BST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id ADFF43601C6
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2019 10:22:57 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail1.arhont.com ADFF43601C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arhont.com;
        s=157CE280-B46F-11E5-BB22-6D46E05691A3; t=1564478577;
        bh=vpVZB3Wxl/q8GsjH4KmftujPwNGYFi38hZNaTqwucqs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=2ceuvNHs4ktHizN7KVoEU+ll0n6fFnkDLvfOUDfnVIx64PS//LMSXD3Fg6UraKs5J
         vskplX2fMn/QgMIIT0zNxzKBCBFyqKtkOlGWen+NbZM45fzwOrLMsNVgOAdqhgXHdk
         s1ZzoAWAnWA2Jr5Oe6SRCaiFUHA5eL29dwuBy/tU=
X-Virus-Scanned: amavisd-new at arhont.com
Received: from mail1.arhont.com ([127.0.0.1])
        by localhost (mail1.arhont.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KUt_9p5_nJgy for <linux-btrfs@vger.kernel.org>;
        Tue, 30 Jul 2019 10:22:57 +0100 (BST)
Received: from mail1.arhont.com (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id 7F5F436008B
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2019 10:22:57 +0100 (BST)
Date:   Tue, 30 Jul 2019 10:22:57 +0100 (BST)
From:   "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
To:     linux-btrfs@vger.kernel.org
Message-ID: <400990062.28.1564478576016.JavaMail.gkos@xpska>
In-Reply-To: <1244295486.47.1564331283120.JavaMail.gkos@xpska>
References: <1244295486.47.1564331283120.JavaMail.gkos@xpska>
Subject: Re: how to recover data from formatted btrfs partition
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3803 (Zimbra Desktop/7.3.1_13063_Linux)
Thread-Topic: how to recover data from formatted btrfs partition
Thread-Index: WsemtFqvWDEe+P7XPsHhikn57KVObsjhy34N
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>>On Sun, Jul 28, 2019 at 10:36 AM Konstantin V. Gavrilenko
>><k.gavrilenko@xxxxxxxxxx> wrote:
>>
>> Hi list,
>>
>> I accidentally formatted the existing btrfs partition today with mkfs.btrfs
>> Partition obviously table remained intact, while all three superblock 0,1,2 correspond to the new btrfs UUID.
>> The original partition was daily snapshotted and was mounted using "compress-force=lzo,space_cache=v2" so I guess the recovery using >photorec would be troublesome.
>>
>> Is there any chance to recover the data?
>> Any ideas or advices would be highly appreciated.
>
>mkfs.btrfs doesn't write that much data, but does zero some other
>things out to avoid later confusion so it's plausible some of the
>previous btrfs has already been damaged by those overwrites. But if
>you ignore that, I bet you can reconstruct the old super and at least
>do a read only mount of the previous file system, and at least get a
>backup.
>
>The hard part is finding the start LBA for all the roots, and the
>physical address for the system chunk so that you can populate the
>system chunk array field in the super block correctly. It's mainly a
>question of time and effort, there's no tool that can do this for you,
>it's pretty much a manual process.
>
>
>-- 
>Chris Murphy


Thanks Chris,

frankly my knowledge of BTRFS internals is not that great, so I wonder if you can point me to the right direction.

From my understanding the system chunk items stored in the superblock at the default physical address 0x10000 and 2 others would have the address of the new system chunk that was created after the partition was reformatted. So how can I find the physical address for the old system chunk?


regards,
Konstantin




----- Original Message -----
From: "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
To: linux-btrfs@vger.kernel.org
Sent: Sunday, 28 July, 2019 6:28:06 PM
Subject: how to recover data from formatted btrfs partition

Hi list,

I accidentally formatted the existing btrfs partition today with mkfs.btrfs
Partition obviously table remained intact, while all three superblock 0,1,2 correspond to the new btrfs UUID.
The original partition was daily snapshotted and was mounted using "compress-force=lzo,space_cache=v2" so I guess the recovery using photorec would be troublesome.

Is there any chance to recover the data?
Any ideas or advices would be highly appreciated.


yours,
Kos
