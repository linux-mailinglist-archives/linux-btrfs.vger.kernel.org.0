Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92733C5CF2
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jul 2021 15:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhGLNJT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 09:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbhGLNJS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 09:09:18 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA35C0613DD
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jul 2021 06:06:27 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 7BB629C395; Mon, 12 Jul 2021 14:06:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1626095185;
        bh=EFVdc9xGmTukCUbPxhyUBNJf1wD2SSYO6QV35An+Uwo=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=hT479BkayhXhNUjX/wiFiGkBORhMW8FD7u026W0vrLWksGu4i/P7D14pJtYFL1umc
         FYa/+BpHhU3rX4lygr3s2KYIqBIrfJZauOph3dF/VL2v8vbsymk4TOSol+tI4/drli
         hHjRSjfz1nNemL7PT14JG0A9eFg2GJ2e+7Xs/us5eNHjh6210xQNGpCXF0X7yAadF6
         snQ/MPCoqKcaTOxi/S5Ejx/+Hwy96ZP2AvU1wO2I9pis4DL/wwtvnSo0zfsBuo4Kfd
         F7mQd3omCEYHoRGal4dTUWeTO5goRqJqTTmhtA+/oLaft94kiIGDuP5q44lth0zk2e
         dji9JmZbzPE8w==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-4.5 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 6AC6C9B953
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jul 2021 14:06:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1626095183;
        bh=EFVdc9xGmTukCUbPxhyUBNJf1wD2SSYO6QV35An+Uwo=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=AT1BIf+M1UoY62h62Qrb7Gu/wcWe19JQnwoc/VvdtzBfR6yItv1PHSl4zMBwuLrK2
         G8SMM8dhDV7LTFfAQqw62f4E11PTQvt2m0GwHUNAnRHjRnhP0lO2QSgpSYHN4RIqAr
         BeEspUL38FfYoaiJSYzfw3/5p/uErjvbRI/46/uxQPtF1jKr03IcirRqismnNdJak5
         BQeMaGC/n/PdArbolPs6gR//ZItUX8nnGTGEnJrg11jvLH08w5Thb6nbSEeZ56zrXC
         cRl9Rad2cmodRpOyvq38p4yyJcW5/KSMM8OLkoMyl9MZbIcNr/H7RXE3LVKxXthHZD
         n9BPDdr5dpQRg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id D1C7826EC86
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jul 2021 14:06:17 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de>
 <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
 <20210709065320.GC8249@tik.uni-stuttgart.de>
 <CAJCQCtQvak-28B7eUf5zRnAeGK27qZaF-1ZZt=OAHk+2KmfsWQ@mail.gmail.com>
 <20210710065612.GF1548@tik.uni-stuttgart.de>
 <CAJCQCtQn0=8KiB=2garN8k2NRd1PO3HBnrMNvmqssSfKT2-UXQ@mail.gmail.com>
 <20210712072525.GI1548@tik.uni-stuttgart.de>
Subject: Re: cannot use btrfs for nfs server
Message-ID: <294e8449-383f-1c90-62be-fb618332862e@cobb.uk.net>
Date:   Mon, 12 Jul 2021 14:06:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712072525.GI1548@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/07/2021 08:25, Ulli Horlacher wrote:
> On Sat 2021-07-10 (16:17), Chris Murphy wrote:
>> On Sat, Jul 10, 2021 at 12:56 AM Ulli Horlacher
>> <framstag@rus.uni-stuttgart.de> wrote:
>>
>>> root@tsmsrvj:# snaprotate -v test 5 /data/fex/spool
>>> $ btrfs subvolume snapshot -r /data/fex/spool /data/fex/spool/.snapshot/2021-07-10_0849.test
>>> Create a readonly snapshot of '/data/fex/spool' in '/data/fex/spool/.snapshot/2021-07-10_0849.test'
>>
>> I think this might be the source of the problem. Nested snapshots are
>> not a good idea, it causes various kinds of confusion.
> 
> I do not have nested snapshots anywhere.
> /data/fex/spool is not a snapshot.

But it is the subvolume which is being snapshotted. What happens if you
put the snapshots somewhere that is not part of that subvolume? For
example, create /data/fex/snapshots, snapshot /data/fex/spool into a
snapshot in /data/fex/snapshots/spool/2021-07-10_0849.test, export
/data/fex/snapshots using NFS and mount /data/fex/snapshots on the client?

> /data/fex/spool/.snapshot/2021-07-10_0849.test is a simple snapshot of
> the btrfs subvolume /data/fex/spool
> 
> 
>>> We cannot move the snapshots to a different directory. Our workflow
>>> depends on snaprotate:
>>>
>>> http://fex.belwue.de/linuxtools/snaprotate.html

Won't snaprotate follow softlinks? ln -s /data/fex/snapshots
/data/fex/spool/.snapshot

>>
>> OK does the problem happen if you have no nested snapshots (no nested
>> subvolumes of any kind) in the NFS export path?
>>
>> If the problem doesn't happen, then either the tool you've chosen needs
>> to be enhanced so it will create snapshots somewhere else, which Btrfs
>> supports, or you need to find another tool that can.
> 
> Without snapshots there is no problem, but we need access to the snapshots
> on the nfs clients for backup/recovery like Netapp offers it.
> But Netapp is EXPENSIVE :-}

My server snapshots data subvolumes into a different part of the tree
(in my case I use btrbk) and exports them to clients and the clients can
access all the snapshots over NFS perfectly well.

