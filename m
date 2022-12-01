Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9656A63F885
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Dec 2022 20:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiLATmt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Dec 2022 14:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiLATmk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Dec 2022 14:42:40 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8FB13F9F
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Dec 2022 11:42:39 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A8E293200786;
        Thu,  1 Dec 2022 14:42:38 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute2.internal (MEProxy); Thu, 01 Dec 2022 14:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8henrie.com; h=
        cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669923758; x=1670010158; bh=0x2lEM/rQa
        08A7K7c+V8DEtdNY4DQyYob5fv5icysew=; b=ZHS54cyTtkaPs49Y5ziCVkENIB
        xDl39L0/cE2gjy3n2ApskLFKgT4+d0pLxFqoLWTUbg6bRwuoSoy+me+2piabjfMi
        WO9DdFOfVorqm0WZmXE1s4f9hpew1YJX1VVkzkz0wF2tyiPJ0wksIJTfFEo8yRRq
        qxDLhh1AWbZUcaF4lLeQY7wVHIQ3OBUrN40tUQ/Iu/PX4wr0B6bWGf4ZVCnhT1ny
        a2xSyNFMijcqwo00rzu9G7Hnwd0OOe8xuEF5TRZFvLmpDf1JIgl6AmeRqu5QgpQg
        aZyHRRNyRMnCf6uTMg9MbmZjuzOJft7a9nui5EigBTDl5Y6lLfL8kglrszsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669923758; x=1670010158; bh=0x2lEM/rQa08A7K7c+V8DEtdNY4D
        QyYob5fv5icysew=; b=Dd8Q+GbezBrJ6xPo8IHuZZZCuyAnQaVEtvYI+9ugxu96
        /OyX+no0G+0bA10woQ80hhWeeQIxazh1ii1KbIpy799/y9+kWmH/XxpX49f54LXl
        uqMiWsd9aBE2LwnkBsTMwiB7OXvs35VaBEPgUYJFmUjOnR4dVSK8yHdkMUPJIoJN
        ie4OLd8CRbJn9FOYrJ2yeJsmxFn4IwHdO7o834tRj2++th/fEituI8zzzkkhL/Gk
        cV+Z/gjKYEhK4UUfKEY8k/3qpzFE/SOfWKQoq06a7yqtCm8+0jhu9qzFfNYZOv1i
        pVMrpJYlGait97MZidweUE9GHZCMxOpHNEpZz/dAHA==
X-ME-Sender: <xms:rgOJY-k7DCCOkPzUKVSpGGHBoBe-NyTcJpM1YzMR2x3Fg_QgtovIfw>
    <xme:rgOJY130yjNVc0TFeIvVdjyBfRaVLwkizjLJilwUT1mRgSN1Blw-csw-l3YGeyw09
    S868eY5RfnzsSe1ACc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdehgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpedfpfgrthhhrghnucfjvghnrhhivgdfuceonhgrthgvsehn
    kehhvghnrhhivgdrtghomheqnecuggftrfgrthhtvghrnhepffeivefhfeeileejgeeuhf
    fhgeeihedtkeevvdevjefhkeetfeeftedtlefhveeinecuffhomhgrihhnpehsmhgrrhht
    mhhonhhtohholhhsrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepnhgrthgvsehnkehhvghnrhhivgdrtghomh
X-ME-Proxy: <xmx:rgOJY8rxEUgDOJnREs4GgJHD131g7r5c5_1u_RcRa9-AxoGRuUL2QA>
    <xmx:rgOJYynb-iWNnVmlDdnpW5w8lUTJ68F3_qQs3o_kzFGVwrvPkpzTbw>
    <xmx:rgOJY83qxWBL2QRZJ34-SUV-kXya7EPEw1vPhHBEiZNX6E3RtTfqnw>
    <xmx:rgOJY9h1JD_eU60qVn-fyHiWEPYMrgl-rqsbg00jjQGJ6EQg48zwQA>
Feedback-ID: iffd94604:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 09514B60089; Thu,  1 Dec 2022 14:42:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <c2d3f00f-5c0b-4dcc-bfcf-2a6e596c6bdf@app.fastmail.com>
In-Reply-To: <69614c04-38e3-4b8a-8285-706c1bbc4618@app.fastmail.com>
References: <debfa7c5-646c-4333-a277-62e98a78a47e@app.fastmail.com>
 <15a497f7-f4f0-6b17-0f90-58b5420aaaaf@libero.it>
 <69614c04-38e3-4b8a-8285-706c1bbc4618@app.fastmail.com>
Date:   Thu, 01 Dec 2022 12:42:17 -0700
From:   "Nathan Henrie" <nate@n8henrie.com>
To:     kreijack@inwind.it, linux-btrfs@vger.kernel.org
Subject: Re: BTRFS RAID1 root corrupt and read-only
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hmm, perhaps. The devices were `/dev/nvme[0-2]` (at the time of that log all 3 were showing up but one has now dropped off). The two that are visible are not listing any SMART errors, so I hadn't suspected a problem, but that does look suspicious.

```
[root@nixos:/tmp]# smartctl -l error /dev/nvme0
smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.15.79] (local build)
Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org
=== START OF SMART DATA SECTION ===
Error Information (NVMe Log 0x01, 16 of 256 entries)
No Errors Logged

[root@nixos:/tmp]# smartctl -l error /dev/nvme1
smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.15.79] (local build)
Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org
=== START OF SMART DATA SECTION ===
Error Information (NVMe Log 0x01, 16 of 256 entries)
No Errors Logged

[root@nixos:/tmp]# smartctl -l error /dev/nvme2
smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.15.79] (local build)
Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org
Smartctl open device: /dev/nvme2 failed: No such device
```

Nate

On Thu, Dec 1, 2022, at 12:29 PM, Nathan Henrie wrote:
> Hmm, perhaps. The devices were `/dev/nvme[0-2]` (at the time of that log all 3 were showing up but one has now dropped off). The two that are visible are not listing any SMART errors, so I hadn't suspected a problem, but that does look suspicious.
> 
> ```
> [root@nixos:/tmp]# smartctl -l error /dev/nvme0
> smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.15.79] (local build)
> Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org
> === START OF SMART DATA SECTION ===
> Error Information (NVMe Log 0x01, 16 of 256 entries)
> No Errors Logged
> 
> [root@nixos:/tmp]# smartctl -l error /dev/nvme1
> smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.15.79] (local build)
> Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org
> === START OF SMART DATA SECTION ===
> Error Information (NVMe Log 0x01, 16 of 256 entries)
> No Errors Logged
> 
> [root@nixos:/tmp]# smartctl -l error /dev/nvme2
> smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.15.79] (local build)
> Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org
> Smartctl open device: /dev/nvme2 failed: No such device
> 
> ```
> 
> Nate
> 
> On Thu, Dec 1, 2022, at 11:52 AM, Goffredo Baroncelli wrote:
>> On 01/12/2022 19.27, Nathan Henrie wrote:
>> > Hello all,
>> > 
>> > I've been happily running a BTRFS RAID1 root across 3 x 1TB NVME drives on my Arch Linux machine for a few years with minimal (mostly quota-related) issues.
>> > 
>> > I ran balance a few days ago that failed, and then my root went read-only. I found some smartd errors in one drive, so I 
>> 
>> [...]
>> > [99537.333018] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: wr 0, rd 0, flush 0, corrupt 12, gen 0
>> > [99537.333023] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: wr 0, rd 0, flush 0, corrupt 12, gen 0
>> 
>> 
>> 
>> I am not sure how is related; but from the above excerpt of dmesg, I see that both nvme0 and nvme1 have errors (== corruption). If this is true, raid1 is not enough to protect against these.
>> 
>> 
>> -- 
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>> 
>> 
> 
