Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B938111F
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 21:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhENTzo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 15:55:44 -0400
Received: from mail.knebb.de ([188.68.42.176]:60020 "EHLO mail.knebb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230268AbhENTzn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 15:55:43 -0400
Received: by mail.knebb.de (Postfix, from userid 121)
        id AD5A1E18E6; Fri, 14 May 2021 21:54:30 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on netcup.knebb.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=1.7 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.2
Received: from [192.168.9.194] (p508bf12b.dip0.t-ipconnect.de [80.139.241.43])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cvoelker)
        by mail.knebb.de (Postfix) with ESMTPSA id BC36AE0FC2;
        Fri, 14 May 2021 21:54:27 +0200 (CEST)
Subject: Re: Removal of Device and Free Space
To:     Roman Mamedov <rm@romanrm.net>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <850c35a8-0322-c60e-b179-b07eb0e1de8c@knebb.de>
 <20210514220612.6293aa23@natsu>
From:   =?UTF-8?Q?Christian_V=c3=b6lker?= <cvoelker@knebb.de>
Message-ID: <28e272b2-77de-881e-41d2-4357e133ac8e@knebb.de>
Date:   Fri, 14 May 2021 21:54:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514220612.6293aa23@natsu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Roman,


thanks for you ideas. Unfortunately none is valid here. I have for sure 
no snapshots and I have mounted the device with compression enabled:

root@backuppc42:~# btrfs subvolume list /var/lib/backuppc
root@backuppc42:~# mount| grep backup
/dev/mapper/crypt_drbd2 on /var/lib/backuppc type btrfs 
(rw,noatime,compress=zstd:3,space_cache,subvolid=5,subvol=/)

I do not like the idea of going to full file sync for my rsync backups 
as the bandwidth is my concern here. And it does not help either as I 
have compression enabled, right?

Any further ideas?

Greetings
/CV


Am 14.05.2021 um 19:06 schrieb Roman Mamedov:
> On Fri, 14 May 2021 10:54:16 +0200
> Christian Völker <cvoelker@knebb.de> wrote:
> 
>>       What is occupying so much disk space as the data only has 1.7TB
>> which should fit in 1.8TB (two) devices? (no snapshot, nothing special
>> configured on btrfs). Looks like there are ~400GB allocated which are
>> not from data.
> 
> Check if there are really no stray snapshots left over, which keep around old
> versions of some of your data.
> 
> If not, it could be the infamous Btrfs "extent booking" inefficiency, where the
> whole extent (up to 128 MB) is kept around as long as some part of it is still
> referenced.
> 
> Discussed a bit here: https://www.spinics.net/lists/linux-btrfs/msg90352.html
> 
> Since then I found that not only VMs, but for example it's really
> inefficient space-wise to download torrents onto a Btrfs (without nocow).
> 
> Anything where you overwrite small pieces within a large file, will waste
> space.
> 
> In your case, if it's a backup server and you use rsync or the like in an
> incremental mode updating only the changed blocks, switching that to
> whole-file updates (-W for rsync) could alleviate the issue. Another way is to
> force compression on the filesystem, which clamps the extent size limit down
> from 128 MB to 128 KB and mitigates the problem in another way.
> 
