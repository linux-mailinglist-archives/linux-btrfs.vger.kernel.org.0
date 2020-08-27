Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44439254BCD
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Aug 2020 19:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgH0ROX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Aug 2020 13:14:23 -0400
Received: from smtp-33.italiaonline.it ([213.209.10.33]:57250 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbgH0ROW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Aug 2020 13:14:22 -0400
Received: from venice.bhome ([94.37.192.142])
        by smtp-33.iol.local with ESMTPA
        id BLTek4MMD8e2WBLTekTteE; Thu, 27 Aug 2020 19:14:18 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1598548458; bh=+SWmZAoTUwAPsLBnIjlmEInqFPb9ns4Lc5lWAe52rDM=;
        h=From;
        b=Ge3XcsFkTFuyorgupasPnf/INNJNlTs9sfsf6DWyJFoSgQO4t3CfrLfzEEkPsn9G7
         vKoB7FzWaBSuH0ks9XcAJQyGELz6fGNuC2UhZFQppxnehJYi7daFQWEyWuDCWj6TJf
         D8tj0fkiE0yg98r6D/H5Hm+Sz5aAEvQPSZFJeIrvrGCjBjSxm4hsRMlxytWr8K4sL+
         il4u52K3Wg3utsui3pei+LXLgg+qxjfdTFvhGClb5bQ0q/NKKeOlpqf40lP8uGAwa9
         BdugEFeS54N2ptFxbXixv9RnegrcabGq7oAexnTEqxjtsiyW2Fp+WU0M8qpieUtbvf
         1lnygvoDXtg+Q==
X-CNFS-Analysis: v=2.4 cv=ZYejiuZA c=1 sm=1 tr=0 ts=5f47e9ea
 a=ppQ2YIgYQAGACouVZCsPPQ==:117 a=ppQ2YIgYQAGACouVZCsPPQ==:17
 a=IkcTkHD0fZMA:10 a=Oe0UhN7WJhCyF6pNc-4A:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: adding new devices to degraded raid1
To:     Eric Wong <e@80x24.org>, linux-btrfs@vger.kernel.org
References: <20200827124147.GA16923@dcvr>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <862ab235-298a-12eb-647b-04ec01d95293@libero.it>
Date:   Thu, 27 Aug 2020 19:14:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827124147.GA16923@dcvr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfA+Kn/stTSPF0ICoyx7niLxauzzbq0pt4yyrVBKgIA08Phj6gQrkIbU9S7r6RUzNUY8nBZ1uks+3RQTGA4r6FXCwAGtm2IBJN/5tA+pCYJyjsMxFg79i
 LnnmnmoEdA/a1gimBbVHhozfPlXke3KycKsLJNGB75cfM8yttlV+3d3RpPvFnzSwaETKEPQ8Sgg+PeWxfSPHmqtkgixdm6BNwjE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/27/20 2:41 PM, Eric Wong wrote:
> I don't need to do it right away, but is it possible to add new
> devices to a degraded raid1?
> 
> One thing I might do in the future is replace a broken big drive
> with two small drives.  It may even be used to migrate to SSDs.
> 
> Since btrfs-replace only seems to do 1:1 replacements, and I
> needed to physically remove an existing broken device to make
> room for the replacements, could I do something like:
> 
> 	mount -o degraded /mnt/foo
> 	btrfs device add small1 small2 /mnt/foo
> 	btrfs device remove broken /mnt/foo
> 
> ?
> 

Instead of

  	btrfs device remove broken /mnt/foo

You should do

	btrfs device remove missing /mnt/foo

("missing" has to be write as is, it is a special term, see man page)

and

	btrfs balance start /mnt/foo


To redistribute the data to the disks.

Please before trying it, wait for other suggestions or confirmation from more expert dveloper about that

BR
G.Baroncelli

> Anyways, so far raid1 has been working great for me, but I have
> some devices nearing 70K Power_On_Hours according to SMART
> 
> Thanks.
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
