Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D147363F7C0
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Dec 2022 19:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiLASxD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Dec 2022 13:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiLASxC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Dec 2022 13:53:02 -0500
Received: from libero.it (smtp-34.italiaonline.it [213.209.10.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEF61CFC4
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Dec 2022 10:52:50 -0800 (PST)
Received: from [192.168.1.27] ([84.220.133.23])
        by smtp-34.iol.local with ESMTPA
        id 0ofwpQ4hb8ofC0ofwpZ5Vg; Thu, 01 Dec 2022 19:52:49 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1669920769; bh=U65+5pMJ4vndtPCts5yitI73zGSj9lB9+C6HRKRhDaw=;
        h=From;
        b=fE2g7wewbajTVK0RTY3l6t6bsgCoUkBwM2W7fH7eFciekCc9ajEPhH0ymFifs4IWI
         GDSazgj1071zp3NuQ3hsLKPTt2HTk2ZBbwwi9StKnlU4HmGRv4oEe1n0ZRURHRaX1A
         K5Opu8GHjTyBIECqzRrdyqVVvar5ACB7gxSFAx92Znt4MfFupnntCle9CI1WWMqhcL
         NpyNieYbgFrdf5HEE+hErHRD+4o/HUGrTkhv/f5liKKC9rB3UVKZ2pDr1jw+iyWN4r
         uRcaIfYRaIBkusDxklr3n8A06OxGqeKyt4O7tf8HxhoePNzMXq5zgEU1OWlRLRHg1D
         PkZ8tERyLCP6g==
X-CNFS-Analysis: v=2.4 cv=aqZ3tQVV c=1 sm=1 tr=0 ts=6388f801 cx=a_exe
 a=rvSxRzAfB0ei0akfwnAvLw==:117 a=rvSxRzAfB0ei0akfwnAvLw==:17
 a=IkcTkHD0fZMA:10 a=IhCOHh_9kW28DbZItusA:9 a=QEXdDO2ut3YA:10
Message-ID: <15a497f7-f4f0-6b17-0f90-58b5420aaaaf@libero.it>
Date:   Thu, 1 Dec 2022 19:52:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: kreijack@inwind.it
Subject: Re: BTRFS RAID1 root corrupt and read-only
Content-Language: en-US
To:     Nathan Henrie <nate@n8henrie.com>, linux-btrfs@vger.kernel.org
References: <debfa7c5-646c-4333-a277-62e98a78a47e@app.fastmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <debfa7c5-646c-4333-a277-62e98a78a47e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEx/WKUi0qqgQTv7xkZQkhQAK8QuCMEbk7/NH+jF3dohtdTiBZ9271o8IVYYMgsv3oQK3JiBSxftXeGz/72ZeAUmabJlb/vFh3MhRDU5yMqcVQ8kisiP
 HR9KFQE+knyLgHW8hVh3+eaEwjNTQXKmYYNdR45fKQR9Bp8bFEr8F8jqYnkekKtIdnpbWZeS7mmP3VCbNrKIKr2nyUcVYWQQqYQWL195Sn5ob3LBUCh093pp
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/12/2022 19.27, Nathan Henrie wrote:
> Hello all,
> 
> I've been happily running a BTRFS RAID1 root across 3 x 1TB NVME drives on my Arch Linux machine for a few years with minimal (mostly quota-related) issues.
> 
> I ran balance a few days ago that failed, and then my root went read-only. I found some smartd errors in one drive, so I 

[...]
> [99537.333018] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: wr 0, rd 0, flush 0, corrupt 12, gen 0
> [99537.333023] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: wr 0, rd 0, flush 0, corrupt 12, gen 0



I am not sure how is related; but from the above excerpt of dmesg, I see that both nvme0 and nvme1 have errors (== corruption). If this is true, raid1 is not enough to protect against these.


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

