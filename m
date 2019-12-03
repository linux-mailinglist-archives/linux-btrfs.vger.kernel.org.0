Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F2311037A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 18:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfLCRaL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 12:30:11 -0500
Received: from smtp-31.italiaonline.it ([213.209.10.31]:44711 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbfLCRaL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 12:30:11 -0500
Received: from venice.bhome ([84.220.25.30])
        by smtp-31.iol.local with ESMTPA
        id cC00il1XciFL3cC00iRSTV; Tue, 03 Dec 2019 18:30:08 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1575394208; bh=zXD6i4s2obscPSWEVJJ7UObm5+S8ZAdmCe+7/u7hBhU=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=uO89rHriaWO+YqLMY/JrDQ/uAGfybADJQug7P3qmQ7th2iVjIwE9o86qFbzWTKM39
         POwU2UPjGoOpiLTqKK30WxbH6nZ4XfwH3mel66ij2HytvxGAyygSkb9iv7GWDTFBVn
         5xKySo3QthgaXw566wv5e4+H0WlJIyUkDt+eum33zk6Evs46FZgt5QSy7QqHk1vWqi
         xsyQImPeNikTFOc3YQSddLB2NTrqhCHVz6xflMClbbHKxPvmrF50Zm+kW2wic7Icgj
         ZWnE1VTio00WW/l7TWxX1xail7LaNO73b+0wZrItiGAgchfACeGhE+afLM0JNns3oF
         M6/kVMvqHB91Q==
X-CNFS-Analysis: v=2.3 cv=J77UEzvS c=1 sm=1 tr=0
 a=zfQl08sXljvZd6EmK9/AFg==:117 a=zfQl08sXljvZd6EmK9/AFg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=mDV3o1hIAAAA:8
 a=V3NtCzo15oPBqwp5Q74A:9 a=QEXdDO2ut3YA:10 a=BIUib9zpbOMA:10
 a=_FVE-zBwftR9WsbkzFJk:22
Reply-To: kreijack@inwind.it
Subject: Re: [RFC] GRUB: add support for RAID1C3 and RAID1C4
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191202181928.3098-1-kreijack@libero.it>
 <20191203132302.GP2734@suse.cz>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <e41d122f-a92d-2ba5-7786-c2c4670d4060@libero.it>
Date:   Tue, 3 Dec 2019 18:30:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203132302.GP2734@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHO28vbQJp0nI0DxfEGNtq5iQ1g/dLn1JmNxkTictcs1De7MB80ubJmEfvwN1OW7x+9xQuCZcHWWIMz0VZWntFkkWlkNukuuVyLqJkQ2VEx1wZ2RPc/R
 2W6dllcVzWVQdUAsLspyIe3cbS92FXitEs76tbQEy1Dlnl9/ZCjrt9na1Xy3xl1WBOBshtV7KUbmTMaeb/CMjhRdQY4edAaKFds=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/12/2019 14.23, David Sterba wrote:
> On Mon, Dec 02, 2019 at 07:19:27PM +0100, Goffredo Baroncelli wrote:
>>
>> The enclosed patch adds support for RAID1C3 and RAID1C4 to grub.
>> I know that David already told that he want to write one; however
>> recently I looked to the grub source and so I make a patch.
> 
> I sent the support patches some time ago, the were held back until the
> kernel support lands. This happened in 5.5-rc1 and Daniel is about to
> add the patch to grub git.
> 
> https://lists.gnu.org/archive/html/grub-devel/2019-11/msg00012.html
> 
Perfect, so please ignore my patch
BR


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
