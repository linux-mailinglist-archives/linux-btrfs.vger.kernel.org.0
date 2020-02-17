Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007B416195C
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 19:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgBQSFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 13:05:15 -0500
Received: from zaphod.cobb.me.uk ([213.138.97.131]:57920 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgBQSFP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 13:05:15 -0500
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 8D7819C3AE; Mon, 17 Feb 2020 18:05:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1581962713;
        bh=RSrFtLYDm97qzF6z41Vo6tV3C2Am+SbON6R4Ugy9kpk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=PtCi381NUOk2Jt2Ga7Oc1nsaJtXZ0/gnnvp6Ts+0BTsjVWBTeKEIcWtbTJwdKSZQX
         MEQOBFtdG1xPNJYD6tJZ5d4QTQKkT5DjN4RrizPBblIcxTIG/rQwQf+XT2gYhDIAC9
         IcBzyPHow1z1qVILkMb8LldOKvY4PjIbbEiHfufHuNhXR0XziCP9BtP+PzzQvc/JwO
         ce/68VRzYw+XJjbWbuoQMp1ls9Hmeod9a+i4C1u+hAuSEN5Vh+n5ax/lUO95Xc1nsd
         vMeCFJIyymjehJWJjOvadYItCZe8abgFTD5JnEDSZmK7NWteHpbA1CkUe52NT+th8R
         ZMagkepvLFhIA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id BA3BB9B9B1;
        Mon, 17 Feb 2020 18:05:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1581962710;
        bh=RSrFtLYDm97qzF6z41Vo6tV3C2Am+SbON6R4Ugy9kpk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=sB2+mCKk/+E+USFkl7I5oTsX1yMAJIdqn5FyFBgmddNBZIjbykdy8f47hzNvtKbOW
         nmLflqCjpjU1+9wolM4uFQxfP+auTW1ZQVqOItrJ+C6DxU6FzUJAnLA1ul8FYIYdI5
         Jljx54IPUous21SQZ8T/oDZLMNNkEBuCFpvogcq+DHgDhIw2FZiKiCtgdrjyZVq/Vn
         BEAl0dKgTpQT/NqMCVews/QA2a3VObcKJM9M9hGB6Nvw2avn2E9sd3d5SMjAAV1HHy
         YXokxMf5gyaulYCHE/khEqDNkvcaccnmrdmi/NW+bWb3ioTgXEPx1dtQB/sif5Re11
         UJWaDdyacaZ4A==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 6C1C6C62B0;
        Mon, 17 Feb 2020 18:05:10 +0000 (GMT)
Subject: Re: btrfs: convert metadata from raid5 to raid1
To:     Menion <menion@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAJVZm6ewSViEzKRV4bwZFEYXYLhtx2QFvGiQJOD1sNdizL4HjA@mail.gmail.com>
 <641d8ba2-89c1-83ac-155f-f661f511218a@petaramesh.org>
 <CAJVZm6f6ntgnTuC76Juz9tkro1ybQaVLCV2xmPqyt5_9tPQP1Q@mail.gmail.com>
 <baa25ede-ee93-b11e-31e9-63c9e458e6e1@petaramesh.org>
 <CAJVZm6dyD1w6i6oRECGMhVOZcEH7OQvS_fP5bOyC3C7ZEi6Omg@mail.gmail.com>
 <20200217141708.GE1235@savella.carfax.org.uk>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <a42ef272-3ea7-5d44-8261-6665fa1d4a60@cobb.uk.net>
Date:   Mon, 17 Feb 2020 18:05:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200217141708.GE1235@savella.carfax.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/02/2020 14:17, Hugo Mills wrote:
> On Mon, Feb 17, 2020 at 03:12:35PM +0100, Menion wrote:
>> ok thanks
>> I have launched it (in a tmux session), after 5 minutes the command
>> did not return yet, but dmesg and  btrfs balance status
>> /array/mount/point report it in progress (0%).
>> Is it normal?
> 
>    Yes, it's got to rewrite all of your metadata. This can take a
> while (especially if you have lots of snapshots or reflinks -- such as
> from running a deduper). You should be able to see progress happening
> fairly regularly in dmesg. This is typically one chunk every minute or
> so, although some chunks can take much *much* longer.

Also, you can watch what is happening by using "btrfs filesystem usage
/your/mount/point". You should see "Metadata,RAID5:" going down and
"Metadata,RAID1" going up. I often leave:

watch -n 10 btrfs fi usage /mount/point

running in a window while doing these sorts of things so I can see how
things are going at a glance.


