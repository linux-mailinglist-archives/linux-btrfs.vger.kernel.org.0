Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5342703E15
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 22:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbjEOUFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 16:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjEOUFO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 16:05:14 -0400
Received: from libero.it (smtp-32.italiaonline.it [213.209.10.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC035E707
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 13:05:11 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.135.124])
        by smtp-32.iol.local with ESMTPA
        id yeRQpAJeYRLtpyeRQpdIUq; Mon, 15 May 2023 22:05:09 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1684181109; bh=teHBlpxcbE1Xy3ZgnHkBnGdkIKUd3bduaBlyZHi7OmE=;
        h=From;
        b=e6LSyiTRxCGmnypJ3LVJMRQtDUWeb2aF6Y7zMmoJ4501c/bCsECA9uHsLidOELD72
         KoZEk20oKGgG8Z69vHUS1yY6G7f0L1UBUpjcTB+YirU2iOt23QguZr+3da92oGGNY0
         jDYdvojIsO13SrzInIASJ681IeDUhkrOAGe6bGbj9gBX16w8SWwkMc1aFwWFVCwje3
         RE97jExzlhCRUlB7MjPkJWFOO1SFyQK49tTEb2rq+Z4+pcA0Qc261IvBhMtTJS4qKj
         U0mRzz/CDKNzbI/tbkVJS92G8Lw9c6Rh1/LU4lre8BqEKmZQLYk7xA+kaTmB7cPWcB
         ZpAVNAk3Ccq7Q==
X-CNFS-Analysis: v=2.4 cv=B/h/kshM c=1 sm=1 tr=0 ts=64629075 cx=a_exe
 a=qXvG/jU0CoArVbjQAwGUAg==:117 a=qXvG/jU0CoArVbjQAwGUAg==:17
 a=IkcTkHD0fZMA:10 a=km124dZKGu9nMryo1IIA:9 a=QEXdDO2ut3YA:10
Message-ID: <c18fe3ed-6691-3930-7a8e-057a7f04cd85@inwind.it>
Date:   Mon, 15 May 2023 22:05:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: kreijack@inwind.it
Subject: Re: [RFC PATCH] Makefile: add library for mkfs.btrfs
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Stefano Babic <sbabic@denx.de>, linux-btrfs@vger.kernel.org
References: <20230514114930.285147-1-sbabic@denx.de>
 <69df9067-3986-b818-bba2-868946a039e7@libero.it>
 <CAEg-Je8of_psB==V+PH0rpDi6FCpvuKHFBz18qprx4m-y0yZ4w@mail.gmail.com>
Content-Language: en-US
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <CAEg-Je8of_psB==V+PH0rpDi6FCpvuKHFBz18qprx4m-y0yZ4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJCx3rWJAauQmFr/KQWTkv/XBYVeEhEpl8YqbvkLh9P2p3Ul7wcF0lvmz+KynNDuRFzQHWT5yfavAon9V/tr7x/SfMwIs+nVi4dhLbTGqt/9CeY9MpCV
 fQPm6bub5Bcw1B81Z3SJBVAxgS+34pe8242Lgf9B9OJtbEFi2h7Dc+VvB2B9ztdGBMhKwV9xz554ePZ2FaLDvgPUpFpkduSS5KG864Cs/ABpqH6vgs16NfWa
 0pGnrr9AVc8ONddmsbpJZA==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/05/2023 21.53, Neal Gompa wrote:
> On Mon, May 15, 2023 at 2:05 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>>
>> On 14/05/2023 13.49, Stefano Babic wrote:
>>> Even if mkfs.btrfs can be executed from a shell, there are conditions
>>> (see the reasons for the creation of libbtrfsutil) to call a function
>>> inside own applicatiuon code (security, better control, etc.).
>>>
>>> Create a libmkfsbtrfs library with min_mkfs as entry point and the same
>>
>> Really a minor thing; instead of libmkfsbtrfs, I think that it is better call it
>> libbtrfsmkfs or something like it; so all the btrfs libs are with the same prefix:
>>
>> - libbtrfs
>> - libbtrfsutils
>> - libbtrfsmkfs
>>
> 
> I think the idea is that we're *not* going to do that and instead look
> to expose filesystem creation features in libbtrfsutil.
> 

If it is possible, it would be better.

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

