Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B115A66B2B6
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Jan 2023 18:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjAORFG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Jan 2023 12:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjAORFE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Jan 2023 12:05:04 -0500
Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA4F744
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jan 2023 09:05:02 -0800 (PST)
Received: from [192.168.1.27] ([84.220.128.202])
        by smtp-31.iol.local with ESMTPA
        id H6RJpHieLdtHlH6RJph8A7; Sun, 15 Jan 2023 18:05:01 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1673802301; bh=/5sk8ZNXvErYKE0R5lLYGQUNTjyAKkS2Vkmal9mYasU=;
        h=From;
        b=Qo9593ScC8bKCgxLDFH/nIP2RgMHSreK/Xc581UlUH2GTvHr7X8YUz6Kq6t2FwpJp
         iBn1zsbeS1fWg3A+wG+3yRu7YfqoL/sKGEphZLaAveWoNgo9qDFDhOlVVd2NmuBJI4
         WoaUmjgMZ1KSOVfnWuoS4MlT6LfiLskMaGxnJZEnBLoJPRrxgunx0DIz9vB+JgzJly
         Any0lNJRVMz+QrTZdR3T9+Vzxk4EuNAUIzhGPcmtG3pE9dB1FTadhHFkJmatsdaHK7
         8V52M5RczTs76oGj1K0VWXjQ1jgxhqRpRl1hvezjqPSUJBsMH6as5C+p9YQkIWKI7c
         4zsjNrLFU1/nA==
X-CNFS-Analysis: v=2.4 cv=S/0fgqgP c=1 sm=1 tr=0 ts=63c4323d cx=a_exe
 a=7XXxH8DXEs6J8bMFqK0LmA==:117 a=7XXxH8DXEs6J8bMFqK0LmA==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=rpzOG3aJTMbolMytGAAA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <6433005a-21c8-fc9b-6fbd-ae9727751ca5@libero.it>
Date:   Sun, 15 Jan 2023 18:05:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
Content-Language: en-US
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20210117185435.36263-1-kreijack@libero.it>
 <ef8a85ac-4d77-1842-2969-fdfa8b2691e8@toxicpanda.com>
 <83f2e6f7-2513-6da1-6078-56ca6420d8e5@libero.it>
In-Reply-To: <83f2e6f7-2513-6da1-6078-56ca6420d8e5@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCqgIEIIZlhf7GxqUPfknzfZTSW2J3j7GPS7NpfYUN71I9HC8PxBUAzKiDBL9afoM60KoXkjLSNg4IcxRFijAUq1txhUx6Er7nCsU3W7Yha+tOPSUXOE
 GdN/LETj0IwW/wtMM7woy8vpPS9mnxZ6fua4C1sxiRnDFg6wU6u6UMHvznYPVWeHUw4fiVyU2MgagAGLq4jYRV4HgQIhKde+o5AVxT8GzAz0EuLZHluwKqKw
 FjKKE9F4Ne1eppueoa0cVjvmg1eKbr5Z1T5OdN03TqY=
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/01/2023 18.00, Goffredo Baroncelli wrote:
> On 25/01/2021 16.21, Josef Bacik wrote:
> [...]
>> Ok this discussion is going in a few different directions, and there's a lot of moving parts here.  I don't want Goffredo to wander off and do V6 only to have us go off into the weeds on random particulars of how we think this thing is supposed to work.  To that end, I've opened a design issue in github
>>
>> https://github.com/btrfs/btrfs-todo/issues/19
>>
>> and filled out what I think are all the questions and points we've all brought up throughout these discussions.  Everybody please weigh in on the task, laying out what they think is the best way forward for some/all of these questions. Once we have an agreed upon design then Goffredo can go and do V6, and then we only have to argue about the code and not the design.  Thanks,
>>
> 
> Hi Josef,
> do you think that there will be interest in resurrecting this patches ?
> 
> I saw some form of interesting by MarkRose (see github https://github.com/btrfs/btrfs-todo/issues/19#issuecomment-1368377759)
> 
>> Josef

Ok, the latest updates was a V12 version:
[PATCH 0/5][V12] btrfs: allocation_hint

https://lore.kernel.org/linux-btrfs/cover.1646589622.git.kreijack@inwind.it/

> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

