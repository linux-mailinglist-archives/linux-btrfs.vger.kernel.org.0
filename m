Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7A262AE89
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 23:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiKOWqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 17:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiKOWqi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 17:46:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F288A1F2FC
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 14:46:36 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGhyc-1oiROQ1eVO-00Dngo; Tue, 15
 Nov 2022 23:46:29 +0100
Message-ID: <8142d180-9a27-2c21-7c42-f6db6feeb306@gmx.com>
Date:   Wed, 16 Nov 2022 06:46:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Change BTRFS filesystem back to R/W from R/O
To:     Spencer Collyer <spencer@spencercollyer.plus.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20221115122702.4ca83887@selket>
 <7be0584d-5596-189a-353a-63e4b21c3b5e@gmx.com>
 <20221115125208.02a2876d@selket>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221115125208.02a2876d@selket>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7DCr0l2x2rdKswW+y947lMg9s34RGGGC/vagBs0YbhExQ4jLm8I
 iZ59bbrMGJnteoRycqQ3Q2D0NTObD/twKnBh4+C0rq5fS0BP9iUAMj8eCUuoZXD5sUR9AL3
 M12S5vtWoj/9JaccBtbxnU0cbLYincAdPflH9kzSVomdUIphe8ZAaS4sxkxDeT2w6f3g3H6
 IauAIdOmEcb/OgL1Q/+wQ==
UI-OutboundReport: notjunk:1;M01:P0:Fvv/Rs+18AI=;JUjK85l8nvVG4f8oO19cw6MtQtF
 XH+sA4znZlIwBL2m/d+B/Cl81ERQQFrsp6f8ovVUBZxThKnKxdku1s3oKSS427OL8EFWp1buJ
 tgvWGjvhACCiRzb3G/LhzNzRe/DJMrHkuqyGmZmXmW8E44urXEmJo9NKbPkzkRkmrwZ6r9kMa
 hs7C2XYEBxh1cxnKlDg5TiXo12/OFKW4Zl0rj0ZYeOGD4tL6DLqaCpMnhWhlW2by4b5feMsC1
 9zpaALOgj4oJ4XfiLVXMUt/HFWmCz7P0Y3yM8WcjSJRszDmWYZ1Cc6fJBqF0iUK+EeLvpxDQG
 1M+TKZaW0Hk6KHvhuPXVFMcnab71j5bBF0kLYKuWZhGEi0MwqFb/g97r2KspELWvcsZ4AKpbt
 AGhMqnW50hI8BIEP/4AkwEqG2P424ALsjkw4GkTv9Gg1Uc3ToEznP/OAALXJEMvst8lFJ32CW
 KaxaGid2mPI9F+RY5Z+y+B3BCdrvIqgynNuo21blD0eFKuBGNcdek4LJYyP9PdRwWYsfxPJOg
 uOe63RjzOrZIxPKR4CzHSEMGMdbiSnoh8cK1kfZhXB31CPf0+1AV9rEOpdcWHFwRHvN/EUuDk
 c4H8YVntkMVeqvxZmUuQfVGJimMT3RSSN7ZB557pp7JhGAYBELFOKnsVMi3iJ1FLuapofcHgK
 EeZSq+EbF2b/2sFSNA2xMZq0P/+PhG+pCusi8I79EFz8gMfPgYnS5M3YyyIxxK47LXN3zAFL2
 rfo3sOfKMroussIbB54IdKbS+DYpzHfgX7SeBKvB8sdasOAwFxtKbpGyWkqvooVjwhpZKMvZo
 dfe/9mowVW0VBdW7ZUFyQkPz4I02c47NJ9OpyZXYRf96NWsPwi1j5eJJ/9tbjNXiXqWEH6SQt
 IhVnZfgk8xU8gk8UolpGgH7l/ONEp/Mkr3dsMYJW0VNJkGSJ/YOZtkCk2oUO0Zzwy7lHOTHNV
 CBbu0YcUdcASwnORmzN/cLVMw94=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/15 20:52, Spencer Collyer wrote:
> On Tue, 15 Nov 2022 20:41:54 +0800, Qu Wenruo wrote:
> 
>> Considering you have some metadata space left, I believe you can free
>> enough space by deleting files (aka, moving it to other filesystems)
>>
>> Thanks,
>> Qu
> 
> Hi Qu,
> 
> Thanks for that. You say I should move some files to other filesystems, but that's really the nub of my problem - the filesystem is marked as read-only. Am I Ok to do what I mentioned previously:
> 
>> 1) Unmount the filesystem.
>> 2) Remount it as R/W
>> 3) Move data to the external disk
> 
> If that is all good, would I need to do anything else or would the BTRFS system sort itself out correctly?

With enough data removed (or maybe with balance to remove those empty 
block groups?) btrfs should be able to handle everything.

Just don't try to write any new data into the fs, as it will trigger 
btrfs back to RO again due to very limited metadata space.

Thanks,
Qu

> 
> Thanks for your attention,
> 
> Spencer
> 
> PS. The output form the 'btrfs fi usage /data' command you requested is as follows (run as root to get everything):
> 
> Overall:
>      Device size:		  10.92TiB
>      Device allocated:		  10.92TiB
>      Device unallocated:		   1.00MiB
>      Device missing:		     0.00B
>      Device slack:		     0.00B
>      Used:			  10.90TiB
>      Free (estimated):		  15.26GiB	(min: 15.26GiB)
>      Free (statfs, df):		  15.26GiB
>      Data ratio:			      1.00
>      Metadata ratio:		      2.00
>      Global reserve:		 512.00MiB	(used: 0.00B)
>      Multiple profiles:		       yes	(metadata, system)
> 
> Data,RAID0: Size:10.87TiB, Used:10.86TiB (99.86%)
>     /dev/mapper/data1	   5.44TiB
>     /dev/mapper/data2	   5.44TiB
> 
> Metadata,single: Size:8.00MiB, Used:0.00B (0.00%)
>     /dev/mapper/data1	   8.00MiB
> 
> Metadata,RAID1: Size:23.00GiB, Used:21.39GiB (93.00%)
>     /dev/mapper/data1	  23.00GiB
>     /dev/mapper/data2	  23.00GiB
> 
> System,single: Size:4.00MiB, Used:0.00B (0.00%)
>     /dev/mapper/data1	   4.00MiB
> 
> System,RAID1: Size:8.00MiB, Used:784.00KiB (9.57%)
>     /dev/mapper/data1	   8.00MiB
>     /dev/mapper/data2	   8.00MiB
> 
> Unallocated:
>     /dev/mapper/data1	     0.00B
>     /dev/mapper/data2	   1.00MiB
