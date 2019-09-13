Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BB7B2564
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 20:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbfIMSva (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 14:51:30 -0400
Received: from know-smtprelay-omd-9.server.virginmedia.net ([81.104.62.41]:40348
        "EHLO know-smtprelay-omd-9.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389736AbfIMSva (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 14:51:30 -0400
Received: from [172.16.100.1] ([86.12.75.74])
        by cmsmtp with ESMTPA
        id 8qfIidErvVaV88qfIinGRE; Fri, 13 Sep 2019 19:51:28 +0100
X-Originating-IP: [86.12.75.74]
X-Authenticated-User: peter.chant@ntlworld.com
X-Spam: 0
X-Authority: v=2.3 cv=PcnReBpd c=1 sm=1 tr=0 a=RxXffCTTaIU9mOmmEQ6aGA==:117
 a=RxXffCTTaIU9mOmmEQ6aGA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=1LGEtIx6Vi61WSA5E5wA:9 a=QEXdDO2ut3YA:10
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     fdmanana@gmail.com,
        Christoph Anton Mitterer <calestyo@scientia.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
 <ce6a9b8274f5af89d9378aa84e934ce3f3354acd.camel@scientia.net>
 <CAL3q7H5qNE4rizN14qmgrAwtju9KRHspKxo3S-PoTcSUvXYuew@mail.gmail.com>
From:   Pete <pete@petezilla.co.uk>
Message-ID: <8c0f8fff-5032-07b6-182c-1663d6f3f94e@petezilla.co.uk>
Date:   Fri, 13 Sep 2019 19:50:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5qNE4rizN14qmgrAwtju9KRHspKxo3S-PoTcSUvXYuew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJTyUwDUNUEc0ni3DQ7NEaQIcsmpDMO+u/jjXO9QYKYgzROxf5Vzaw+qaK6FxfaXqn0x5uIOgR0gTcEIjfsptVHIFn3HVjqf1BJSSmEOTnGRSEyhGxTD
 cZkBv2CN+na/CdTBCkSEAxfvnXNZ71zZkLv7UdU2593Wg40SF0K9AFs8EDSc/7BggMUaKt91eJGkSlzlD7VyyV46iZC0fihmB1UW184pGGfUXeujmtfxkUxQ
 bOtuh1ofW8qJ2u4CpkkFSw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/12/19 3:28 PM, Filipe Manana wrote:

>>> 2) writeback for some btree nodes may never be started and we end up
>>> committing a transaction without noticing that. This is really
>>> serious
>>> and that will lead to the "parent transid verify failed on ..."
>>> messages.

> Two people reported the hang yesterday here on the list, plus at least
> one more some weeks ago.

This was one of my messages that I got when I reported an issue in the
thread 'Chasing IO errors' which occurred in mid to late August.


> I hit it myself once last week and once 2 evenings ago with test cases
> from fstests after changing my development branch from 5.1 to 5.3-rcX.
> 
> To hit any of the problems, sure, you still need to have some bad
> luck, but it's impossible to tell how likely to run into it.
> It depends on so many things, from workloads, system configuration, etc.
> No matter how likely (and how likely will not be the same for
> everyone), it's serious because if it happens you can get a corrupt
> filesystem.

I can't help you with any specifics workloads causing it.  I just
notices that my fs went read only, that is all.


