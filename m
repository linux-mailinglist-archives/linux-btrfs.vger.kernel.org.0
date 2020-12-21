Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23882E01C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 21:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgLUU7m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 15:59:42 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:47809 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbgLUU7m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 15:59:42 -0500
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2020 15:59:41 EST
Received: from venice.bhome ([94.37.172.193])
        by smtp-33.iol.local with ESMTPA
        id rSAZkWSnljQzorSAZkJyd3; Mon, 21 Dec 2020 21:52:39 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1608583959; bh=Dxx0GlO0p/fLF6+sRMMDEDa/zD9tmuvS88sa+sIo4BQ=;
        h=From;
        b=rKFzAv8+Pg6Ih3FI4CMPzUonyRpK2ObVCm+TD4AvFshy0c92g80uq693sVTueWRe5
         /SbsJnI/J6LOPReaRH2oa2Uep8VCAIpAPSCzHIFyYBjvE6EuNZ0g8HxqGOkJiBwZQx
         LoizDP9EXc7kPt+jGquCutozx+9IV5RGVlKjjI3adFwpXeGfSbG8FoW+YWF9eUct/D
         9w2Kh5ZR38/3mbTusK9FQQxDybqXEcAKNqJIUpFXEthIHW+Plr+TN3DYqvSYFgThhG
         VhnJnY2oWIEOaiH1GboRXP7DZUWybkV+BBxtNTqubrid2WjMIYYMXFKvkN6ufFN/Dp
         0Ksy2QQmpEqiw==
X-CNFS-Analysis: v=2.4 cv=e6rD9Yl/ c=1 sm=1 tr=0 ts=5fe10b17 cx=a_exe
 a=z1y4hvBwYU35dpVEhKc0WA==:117 a=z1y4hvBwYU35dpVEhKc0WA==:17
 a=IkcTkHD0fZMA:10 a=gjiO5ye9uZJco596x2oA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: WG: How to properly setup for snapshots
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>
 <20201221223701.0845e9ad@natsu>
 <108a3254-f120-b5fe-2b7f-f363cbe34158@georgianit.com>
 <de2abd3d-1306-59b3-2ed6-23f03fc443df@libero.it>
 <e4622aa3-2c38-f389-1e2a-aa29009f9b5e@georgianit.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <4058703a-8cbc-3ceb-c9e7-08fcaaa2d8aa@inwind.it>
Date:   Mon, 21 Dec 2020 21:52:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e4622aa3-2c38-f389-1e2a-aa29009f9b5e@georgianit.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCCy/u0pVrdi0T0HowhePVF9yjhQjfookE0n/Z5MfF5jn96WhgQVs1ahqdnHONI+3qDygBWb+25AjKL2+Ua/rGchZuV2g/wItnhTNKTEOjBpfx5IVVtR
 3ZRXjFaTQ6PTeT7EE6SzvlPyrwl4ZYkvalNErBoBbI/JwG7i5xHh/cLLpgUvz/Lv268lEdhgheB7vPUEYHfyANT++SoENqC29e04iMORYK/oy8G4CwnCF3oT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 9:27 PM, Remi Gauvin wrote:
> On 2020-12-21 3:14 p.m., Goffredo Baroncelli wrote:
> 
>> A subvolume can be moved everywhere with a simple 'mv' command.
>>
> 
> No, they can not,, try this again with a *read only* snapshot
>

The topic was about why put the subvolumes/snapshots in another subvolume.

A readonly snapshot can't be moved from its parent (doesn't matter if it is a diretory or a subvolume). This is true. But the subvolume containing a readonly snapshot can be moved :

$ btrfs sub crea sub1
Create subvolume './sub1'
$ btrfs sub crea sub2
Create subvolume './sub2'
$ mkdir dir1
$ btrfs sub snap -r sub2 sub1/snap2
Create a readonly snapshot of 'sub2' in 'sub1/snap2'
$ btrfs sub snap -r sub2 dir1/snap2
Create a readonly snapshot of 'sub2' in 'dir1/snap2'
$ mv sub1 sub1-renamed
$ mv dir1 dir1-renamed



-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
