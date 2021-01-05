Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78142EA69F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 09:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbhAEIfW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 03:35:22 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:16317 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbhAEIfW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jan 2021 03:35:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id F2A003F4CC;
        Tue,  5 Jan 2021 09:34:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FHGSlx2BbMWR; Tue,  5 Jan 2021 09:34:10 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id E55103F433;
        Tue,  5 Jan 2021 09:34:09 +0100 (CET)
Received: from [192.168.0.10] (port=60252)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <forza@tnonline.net>)
        id 1kwhnL-0009V5-Mz; Tue, 05 Jan 2021 09:34:23 +0100
Subject: Re: synchronize btrfs snapshots over a unreliable, slow connection
To:     Cedric.dewijs@eclipso.eu, linux-btrfs@vger.kernel.org
References: <dc1e528567c9a57d089d77824f071af8@mail.eclipso.de>
From:   Forza <forza@tnonline.net>
Message-ID: <cd3a4a0a-e0b4-3224-f00c-5ec52c6362e3@tnonline.net>
Date:   Tue, 5 Jan 2021 09:34:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <dc1e528567c9a57d089d77824f071af8@mail.eclipso.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-01-04 21:51, Cedric.dewijs@eclipso.eu wrote:
> ­I have a master NAS that makes one read only snapshot of my data per day. I want to transfer these snapshots to a slave NAS over a slow, unreliable internet connection. (it's a cheap provider). This rules out a "btrfs send -> ssh -> btrfs receive" construction, as that can't be resumed.
> 
> Therefore I want to use rsync to synchronize the snapshots on the master NAS to the slave NAS.
> 
> My thirst thought is something like this:
> 1) create a read-only snapshot on the master NAS:
> btrfs subvolume snapshot -r /mnt/nas/storage /mnt/nas/storage_snapshots/storage-$(date +%Y_%m_%d-%H%m)
> 2) send that data to the slave NAS like this:
> rsync --partial -var --compress --bwlimit=500KB -e "ssh -i ~/slave-nas.key" /mnt/nas/storage_snapshots/storage-$(date +%Y_%m_%d-%H%m) cedric@123.123.123.123/nas/storage
> 3) Restart rsync until all data is copied (by checking the error code of rsync, is it's 0 then all data has been transferred)
> 4) Create the read-only snapshot on the slave NAS with the same name as in step 1.
> 
> Does somebody already has a script that does this?
> Is there a problem with this approach that I have not yet considered?­
> 

One option is to store the send stream as a compressed file and rsync 
that file over and do a shasum or similar on it.

Steps would be something like this on the sender side:

1) create read-only snapshot as 
/mnt/nas/storage_snapshots/storage-210105-0930
2) btrfs send /mnt/nas/storage_snapshots/storage-210105-0930| xz -T0 - > 
/some/path/storage-210105-0930.xz

send this file to remote location, verify integrity, then do:
3) xzcat storage-210105-0930.xz | btrfs receive /nas/storage

You could expand on the compression scheme by using self-healing 
archives using PAR[1] or similar tools, in case you want to keep the 
archived files.

btrbk[2] is a Btrfs backup tool that also can store snapshots as 
archives on remote location. You may want to have a look at that too.

Good Luck!


[1]https://en.wikipedia.org/wiki/Parchive
[2]https://digint.ch/btrbk/


