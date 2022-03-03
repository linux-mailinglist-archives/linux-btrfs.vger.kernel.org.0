Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0194CC58C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 20:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiCCTBy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 14:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbiCCTBx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 14:01:53 -0500
Received: from libero.it (smtp-17.italiaonline.it [213.209.10.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBD819F47E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 11:01:06 -0800 (PST)
Received: from [192.168.1.27] ([78.12.27.75])
        by smtp-17.iol.local with ESMTPA
        id PqhAnbGvgPSXePqhAnUfPB; Thu, 03 Mar 2022 20:01:03 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1646334063; bh=KKIMmm8TehG9eKxETyrF6NtJuIONTPz6zwQ2ucLON5I=;
        h=From;
        b=rJZk7Q0dnPn0wkdxM4RuYQNlJ1n3ZbntF0qwLB1YI2hrLPE++uAWwTV3fXw3ShC7k
         iZv+uQgUVotGeUZmrxkfZiXJpOPL3bV16pV3xWt9ZyLT/kjZckfXonPbsiPUAkDZy8
         VPH1JxOLo77fGn8hsK3aCs87DLLVr+ALWhfu+yYCsOGTki/it32P9RzvUlq1oYH39D
         XjcYkxTYFlupUQO5JT6k2FO8CR7azNXYomca9l7AkU18p+cf4Iv/9znnPX7MhtWmCU
         Twm5dLUvfktdUK9L2PuJ6PR7EzD2MTQ/7LbrxqGxWm8Ib9yI/iOVnoUe+s13rtu4da
         KYmxGQjQwJq+g==
X-CNFS-Analysis: v=2.4 cv=SMyH6MjH c=1 sm=1 tr=0 ts=6221106f cx=a_exe
 a=aCiYQ2Po16U8px2wfyNKfg==:117 a=aCiYQ2Po16U8px2wfyNKfg==:17
 a=IkcTkHD0fZMA:10 a=QpcPEjOwQhA3vf25GIUA:9 a=QEXdDO2ut3YA:10
Message-ID: <d9d6f8a6-044c-648a-c677-d4258fc70154@inwind.it>
Date:   Thu, 3 Mar 2022 20:01:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>
References: <cover.1643228177.git.kreijack@inwind.it>
 <Yh0AnKF1jFKVfa/I@localhost.localdomain>
 <c7fc88cd-a1e5-eb74-d89d-e0a79404f6bf@libero.it>
 <Yh42nDUquZIqVMC0@localhost.localdomain>
 <e8d1a33a-a75a-1a25-b788-a2da5019e6c4@inwind.it>
 <Yh6Tit2dKcLt7xJP@localhost.localdomain>
 <90407af0-57bb-9808-7663-6feb56fa7b20@inwind.it>
 <Yh/gWL983TFzcObT@localhost.localdomain>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <Yh/gWL983TFzcObT@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfC0eRXaEUtKwCkm3bbCszyF8TRdMppUXcamdSi+NtYmb8eV+4wB60uZmKdae7f90TrI7bR+k+sWRmd5ZC/28LgiAudkhCv3vcwb8OAsHKTke4La7rBHf
 snvgiBIQc4A9d0UqmRGue0EBrDNSWjz31o8ACgzMf/C8vCLaebqT5cj/B4EpsvgsISYL9F7pcM8ehVrPtzeGEh5URVcWygmZl5MltkvFPmnUa8GdiyysgkKQ
 8zgBHucKLdpNP+wUblEmVtdABFwaK5bt3UA6RCM4dPBuPNaQaSM5Z28pQ32L66OmWerhy6wjM2xNiBh1fNCt+dhsgRoa19AGMd2mlOMp0PQ0m5cQIWmEHZZW
 zTnjcHX9rrytyyP/nQJsoSSkqBj7Ag==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/03/2022 22.23, Josef Bacik wrote:
> On Wed, Mar 02, 2022 at 08:30:22PM +0100, Goffredo Baroncelli wrote:
[...]
>>
>> For simple filesystem (e.g. 1 disk), it is trivial (and not useful); for more complex
>> one (2, 3 disks) it is easy to make mistake.
>>
>> btrfs-progs relies on major_minor; it is possible to used the BTRFS_IOC_DEV_INFO
>> but it requires CAP_ADMIN....
>>
> 
> Well this just made me go look at the code and realize you don't require
> CAP_ADMIN for the sysfs knob, which we're going to need.  So using
> BTRFS_IOC_DEV_INFO shouldn't be a problem.  Thanks,

I am not sure to be understood completely your answer, so I recap what I am doing:
- replace the "int" interface in favor of a "string" interface (not "echo 123 > allocaton_hint"
   but "echo DATA_ONLY > allocaton_hint") [DONE]
- remove the "kernel" patch related to "major_minor" [DONE]
- update the btrfs-progs patch to use BTRFS_IOC_DEV_INFO instead of <devid>/major_minor [WIP]


This will have the following consequences:
- any user is still capable to read <devid>/allocaton_hint
- only root is able to use "btrfs prop get allocaton_hint <devname>" (before any user)
- only root is able to update <devid>/allocaton_hint
- only root is able to use "btrfs prop set allocation_hint <devname>"

The 2nd point may be relaxed allowing to use BTRFS_IOC_DEV_INFO even to not root user (
I don't think that there is any sensitive data exported by BTRFS_IOC_DEV_INFO); but this will
be done as separate patch.

> 
> Josef
BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
