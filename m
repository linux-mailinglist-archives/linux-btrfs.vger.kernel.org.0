Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AD17150B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 22:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjE2UsK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 16:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjE2UsJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 16:48:09 -0400
Received: from mail.as397444.net (mail.as397444.net [IPv6:2620:6e:a000:1::99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D445C7
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1685391661; h=In-Reply-To:From:References:To:Subject:From:Subject:To:Cc:
        Cc:Reply-To; bh=xFhJ+IxkmsECvLOnwYfUXPF7P5oV8zOf81DgL8OhjsI=; b=Ix3hLzMvukSTP
        0fihY5UBuFRC1Hwf97H7ObIWflhRqCu6+bY1lKrZQwhGsvRgFbI/swLnjnyeowyZ2I7n+bXE4Ye+N
        0BnB5h0Rp/z7sXtJG5eXNrw8I1q4oNPnJfDZ0+EskGaQKtNWy1nYbacqlw1IFaYpaD4zgKNUbAGWC
        IxlMvsqrWB1droiz+7drOw6ugfEUvW27KBLBqREr3OTWNYPeBbSTHChs18Ler6CXLBzDSHwkQhzRc
        kRrKPBdPfMjJD9dSHVd61fMiUuADPlz8Y9mdpDorJfUJbaolCvXdfcZUuLbyQtXDZi9X413f0e0hS
        uStk7rczDe/UUHrt6kM4Q==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1685391663; h=In-Reply-To:From:References:To:
        Subject:From:Subject:To:Cc:Cc:Reply-To;
        bh=xFhJ+IxkmsECvLOnwYfUXPF7P5oV8zOf81DgL8OhjsI=; b=MEDLEWSPrsVBjuUf/ULMeNxnsf
        XiiHAULYjS8RasuhJETQfYYbXgetsxTy7MH5fX7EtYljJpeXCjPJO3QHGaStT7whyFgrTYTDL/VEf
        Nz9/5ImO1govBHQZ/cIojk1c5Fv/D8rgpMqmlyAyn2EazS/t8Z+Ye76bxlcC5hB16BXZHv/Lw1BPX
        pWJlqKpeBsuGLpef0IVUaZytMO5J6qcOxv8XcK+epZaU5Zl5XcaUaDVDSkbxJaUdZ3E4/Efl9OgpV
        lVCKkLuPMKlJU2nTg4YSoRwy4pdCuIjuvO7AwL88d0YpcOsZ7C1MoOHuZ1/7earuKMBkF7o8Y9Y15
        qT3FsQOQ==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1q3jmh-002vKX-0s;
        Mon, 29 May 2023 20:48:07 +0000
Message-ID: <9d6b2ad9-24cb-54aa-2dc9-5039f9eca76f@bluematt.me>
Date:   Mon, 29 May 2023 13:48:07 -0700
MIME-Version: 1.0
Subject: Re: 6.1 Replacement warnings and papercuts
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <4f31977d-9e32-ae10-64fd-039162874214@bluematt.me>
 <2a832a70-2665-eb9e-5b66-e4a3595567e9@bluematt.me>
 <62b9ea2c-c8a3-375f-ed21-d4a9d537f369@gmx.com>
 <2554e872-91b0-849d-5b24-ccb47498983a@bluematt.me>
 <5d869041-1d1c-3fb8-ea02-a3fb189e7ba1@bluematt.me>
 <342ed726-4713-be1f-63dc-f2106f5becc1@gmx.com>
 <fa6ebdfe-acf0-e21b-5492-9b373668cad0@bluematt.me>
 <82b49e3f-164d-a5b4-0d19-b412f40341b9@bluematt.me>
 <07f98d39-de57-f879-8235-fb8fe20c317a@gmx.com>
 <add4973a-4735-7b84-c227-8d5c5b5358e6@bluematt.me>
 <6330a912-8ef5-cc60-7766-ea73cb0d84af@gmx.com>
 <b21cc601-ecde-a65e-4c4e-2f280522ca53@bluematt.me>
 <e82467d6-2305-da7c-7726-ec0525952c36@bluematt.me>
 <b22bbb5f-9004-6643-09ea-ee11337a93f0@gmx.com>
 <e0107d51-57fa-6581-88c8-77f88f6effd6@bluematt.me>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <e0107d51-57fa-6581-88c8-77f88f6effd6@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_ABUSE_SURBL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/29/23 9:37 AM, Matt Corallo wrote:
> 
> 
> On 5/29/23 3:15 AM, Qu Wenruo wrote:
>> Sorry, I still failed to reproduce the bug, at least with my 64K page
>> sized aarch64 machines.
>>
>> I updated the debugging patch and submitted to upstream, with better
>> output for all the different bitmaps.
>>
>> But never really triggered that assert_eb_page_uptodate() here even
>> once, and also failed to see any location where metadata can be read
>> without going through the regular btrfs metadata read path.
>>
>> Unless there is some other mechanism which can read the pages and mark
>> it uptodate, without the involvement of the fs, then I failed to see how
>> this bug can happen.
>>
>> Sorry for the inconvenience, but mind to do more debugging especially
>> with ftrace?

I could try,

>> I can craft a patch which would record every metadata page read from
>> btrfs, and save them into ftrace buffer.
>> Then setup the system to crash when that assert_eb_page_uptodate() get
>> triggered, with all the ftrace buffer dumped at that timing.

Is it not easier to just have some utility that's constantly fetching that buffer in userspace and 
write it out when an issue gets hit?

I could run something but given this doesn't seem to actually be corrupting anything it'd be nice if 
I didn't have to panic when this happens...also the machine isn't *that* fast that I could tolerate 
a complete performance implosion, but some regression would be fine.

I don't have a debug serial handy but do have an IPMI to be able to at least see output after a panic.

> Sadly I've finally finished the months-long process of converting `cp -a --reflink=always` rolling 
> backups to `btrfs subvolume snapshot` rolling backups, so I don't have any more huge metadata trees 
> to remove.


I take that back, this seems to happen on ~any unclean unmount, see the "Transaction Aborted 
cancelling a metadata balance" thread :(.

Matt
