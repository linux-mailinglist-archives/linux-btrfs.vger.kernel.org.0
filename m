Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8974F714E94
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 18:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjE2QjH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 12:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjE2QjG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 12:39:06 -0400
Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 617E0127
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1685376061; h=In-Reply-To:From:References:To:Subject:From:Subject:To:Cc:
        Cc:Reply-To; bh=c2gA5x9iZBErtPV9dOvSy2Snl1Edh6ct6AGuhpcRksM=; b=rwhbYy+cHR/dn
        euU+WsvnHOd5F+avSJb1JhGEAajHTyuxwv65Tk9C38mOL0uHnbjJO6iqp/TpTj+UbDUZ8wdnwksAB
        KLDOjHDJhMjAXAyIzsEK+q7Wprj3SK9ibZIQdX/BN2AmMOVKmTCcjp16FYl3/GKhhnpdVsBDLf2Ho
        JdbDqZE/zAKCGC+eycOHNeOB/yHIX3S/2c51k/GOw7R2EMkU18ia+F1mbGeSN9K6gAF4SeAdbBSuw
        r1ub8dHPHFNXM3F284aDilbD22DcJ20DGAKX5F+oMyqeMeQXj9BlGc+C67HCvxN3OeClkmmDc7h9W
        oUPnrYcIiF5bd6m0EBBAg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1685376063; h=In-Reply-To:From:References:To:
        Subject:From:Subject:To:Cc:Cc:Reply-To;
        bh=c2gA5x9iZBErtPV9dOvSy2Snl1Edh6ct6AGuhpcRksM=; b=HK6ElbA1JfN9KBtdmWsarnqYXR
        39XNLmNN20O4XfZ29jtfUk/OA36WcPyoj5EFl5a+GqtYtBRQ5mtuEgAs+SnO/k4UqDfhz2oGh+U7S
        rwmqcPmW3DgmpNaP0y4Ax6hTluSrUYHMe3t3d29BsyIw1hzp8DKQ43ru8H62DslQ83QyxbtKAVJuo
        ioKyLz++u9CTTuxXEkBIBjEMUfRDUDX1jNDNz0aIaZK0xd6CLYK1seYWtmSpBucAxmX/+Hx12Pnsw
        M1I5B9m6y1N7vESVLY/+FTW4ubqPG0l6ux4j3cPuFX6V/W3bPCt+Z9Ou/4shHyyc18z4qWfghSqc6
        IHfuO/AQ==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1q3fsd-002sjx-1c;
        Mon, 29 May 2023 16:37:59 +0000
Message-ID: <e0107d51-57fa-6581-88c8-77f88f6effd6@bluematt.me>
Date:   Mon, 29 May 2023 09:37:59 -0700
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
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <b22bbb5f-9004-6643-09ea-ee11337a93f0@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_ABUSE_SURBL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/29/23 3:15 AM, Qu Wenruo wrote:
> 
> 
> On 2023/5/16 01:50, Matt Corallo wrote:
>>
>>
>> On 5/14/23 7:02 PM, Matt Corallo wrote:
>>>
>>>
>>> On 5/14/23 5:44 PM, Qu Wenruo wrote:
>>>> Full debug mode kicked in.
>>>>
>>>> Would you mind to apply the attached patch and let it trigger?
>>>>
>>>> After the regular paper cut, there would be extra warning lines (no
>>>> btrfs prefix yet), so please attach the warning and the following two
>>>> lines for debug.
>>>>
>>>> Thanks,
>>>> Qu
>>>
>>> Will build and see if I can reproduce. May be reproducible on your
>>> end, basic scenario is:
>>>
>>> (a) mount -o commit=300,noatime (may or may not matter) on a subpage
>>> (ppc64el) system
>>> (b) have too much RAID1C3 metadata from a million files in some
>>> maildir on spinning rust
>>> (c) rm -r said maildir
>>> (d) lose power before we finish rm'ing
> 
> Sorry, I still failed to reproduce the bug, at least with my 64K page
> sized aarch64 machines.
> 
> I updated the debugging patch and submitted to upstream, with better
> output for all the different bitmaps.
> 
> But never really triggered that assert_eb_page_uptodate() here even
> once, and also failed to see any location where metadata can be read
> without going through the regular btrfs metadata read path.
> 
> Unless there is some other mechanism which can read the pages and mark
> it uptodate, without the involvement of the fs, then I failed to see how
> this bug can happen.
> 
> Sorry for the inconvenience, but mind to do more debugging especially
> with ftrace?
> I can craft a patch which would record every metadata page read from
> btrfs, and save them into ftrace buffer.
> Then setup the system to crash when that assert_eb_page_uptodate() get
> triggered, with all the ftrace buffer dumped at that timing.

Sadly I've finally finished the months-long process of converting `cp -a --reflink=always` rolling 
backups to `btrfs subvolume snapshot` rolling backups, so I don't have any more huge metadata trees 
to remove.

Matt
