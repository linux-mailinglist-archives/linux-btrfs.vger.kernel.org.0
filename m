Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546336DA8BE
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Apr 2023 08:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjDGGKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Apr 2023 02:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjDGGKc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Apr 2023 02:10:32 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E55420F
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 23:10:28 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pkfIo-0007gf-8M; Fri, 07 Apr 2023 08:10:26 +0200
Message-ID: <dbd7d712-0c46-7a18-d8fc-fc263f4de6e9@leemhuis.info>
Date:   Fri, 7 Apr 2023 08:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on
 ext4
Content-Language: en-US, de-DE
To:     dsterba@suse.cz,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, boris@bur.io
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <1334e2af-b55f-3bb2-6e1a-6ab0b0ef93f0@leemhuis.info>
 <20230406154732.GV19619@twin.jikos.cz>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230406154732.GV19619@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1680847828;6fcac817;
X-HE-SMSGID: 1pkfIo-0007gf-8M
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06.04.23 17:47, David Sterba wrote:
> On Wed, Apr 05, 2023 at 03:07:52PM +0200, Linux regression tracking #adding (Thorsten Leemhuis) wrote:
>> [TLDR: I'm adding this report to the list of tracked Linux kernel
>> regressions; the text you find below is based on a few templates
>> paragraphs you might have encountered already in similar form.
>> See link in footer if these mails annoy you.]
>>
>> On 15.02.23 21:04, Chris Murphy wrote:
>>> Downstream bug report, reproducer test file, and gdb session transcript
>>> https://bugzilla.redhat.com/show_bug.cgi?id=2169947
>>>
>>> I speculated that maybe it's similar to the issue we have with VM's when O_DIRECT is used, but it seems that's not the case here.
>>
>> To properly track this, let me add this report as well to the tracking
>> (I already track another report not mentioned in the commit log of the
>> proposed fix: https://bugzilla.kernel.org/show_bug.cgi?id=217042 )
> 
> There were several iterations of the fix and the final version is
> actually 11 patches (below), and it does not apply cleanly to current
> master because of other cleanups.
> 
> Given that it's fixing a corruption it should be merged and backported
> (at least to 6.1), but we may need to rework it again and minimize/drop
> the cleanups.
> 
> a8e793f97686 btrfs: add function to create and return an ordered extent
> b85d0977f5be btrfs: pass flags as unsigned long to btrfs_add_ordered_extent
> c5e9a883e7c8 btrfs: stash ordered extent in dio_data during iomap dio
> d90af6fe39e6 btrfs: move ordered_extent internal sanity checks into btrfs_split_ordered_extent
> 8d4f5839fe88 btrfs: simplify splitting logic in btrfs_extract_ordered_extent
> 880c3efad384 btrfs: sink parameter len to btrfs_split_ordered_extent
> 812f614a7ad7 btrfs: fold btrfs_clone_ordered_extent into btrfs_split_ordered_extent
> 1334edcf5fa2 btrfs: simplify extent map splitting and rename split_zoned_em
> 3e99488588fa btrfs: pass an ordered_extent to btrfs_extract_ordered_extent
> df701737e7a6 btrfs: don't split NOCOW extent_maps in btrfs_extract_ordered_extent
> 87606cb305ca btrfs: split partial dio bios before submit

David, many thx for the update; and thx Boris for all your work on this.

I kept a loose eye on this and noticed that fixing this turned out to be
quite complicated and thus required quite a bit of time. Well, that's a
bit unfortunate, but how it is sometimes, so nothing to worry about.
Makes me wonder if "revert the culprit temporarily, to get this fixed
quickly" was really properly evaluated in this case (if it was, sorry, I
might have missed it or forgotten). But whatever, for this particular
regression that's afaics not worth discussing anymore at this point.

Again, thx to everyone involved helping to get this fixed.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: let me use this opportunity to update the regzbot status

#regzbot fix: btrfs: split partial dio bios before submit
