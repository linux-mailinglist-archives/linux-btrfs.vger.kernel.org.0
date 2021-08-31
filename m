Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE7C3FC42A
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbhHaISJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 04:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbhHaISI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 04:18:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E32C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 01:17:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b6so26253924wrh.10
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 01:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IeybWOOkKaTyYWy1hjKO+2u4Z1GCTqSwl9Y7jai6P10=;
        b=azJASwsrcB5vZfVN2MVOr8HrA6QBh75n8liy7BmcamnZbicwP8wtRHuNMdsteClf6+
         g4PUVWvT/wk4IifxK9nj+NMsGgndAvLUJJ92oKepAm2WYaYkSbSEoOnf0Bu6msJdoQaL
         AcQbdMbNWAvgMj+wxg1gNfceVqffSShUAJadNTl9Ay1MgAYs6vdCN7+eKCEjUG01iq3E
         w/cmaGYBqVBvCO+i1Bsmp3tqXjzEZ57lPdEF8u9yLnLoqAlu36ZOiJc8JgrJWPds++A/
         ofOhqPJIRI0ZoBlEcSGBhjiIlWTHMNIPEqQXhcrsCUt9/UErTJF1Pnel2pUQfzjTLaQ1
         WGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IeybWOOkKaTyYWy1hjKO+2u4Z1GCTqSwl9Y7jai6P10=;
        b=UjXG0NmIajBRKi2hZi95fNrlhS3ZGPQN3bwteC26jDrb5o1/mmZYN3PBr7qUr/j7GQ
         RcKfPZY2Rdk3wKauV5yDKG5/hUEOj7J6nY9b7lpQMeDmB44dCdttiQ7KypFe/MKeRVmw
         RD26OnMU79yULV9UtdU4TZNr54xK0krAalSEzUw4SR29RqsvuEJ2NHc3eNwmI6jd0MW3
         NUebAN9lPpdvcXfURa8BmINNeKUpJPZK/ofHM5eSlFSrlAzlmSwNYutT5lkvGYxeDsON
         sOksMbtNdgfyax/sTgLuwrx9ncRDj78/4WR2f0CVHRCrKljPSreroVki6UJUKdlbvGl3
         PPsg==
X-Gm-Message-State: AOAM533ql3tK0ao48ENxXfkhBFozu3YliPQQf+/Cf4ivwKKfRTiDbu9j
        rEX7oEP5bdi8P800vucZeEM0E44xwQHkpQ==
X-Google-Smtp-Source: ABdhPJwfT+7pT7zWdTRAlojgk4Pa2ulWAUBgFFDe4DPAozboCPDrUHqRciw+nKHWbUo6vc+p0YNcVg==
X-Received: by 2002:a05:6000:18c2:: with SMTP id w2mr29288017wrq.282.1630397830102;
        Tue, 31 Aug 2021 01:17:10 -0700 (PDT)
Received: from [192.168.10.90] (cable-89-1-117-98.nc.de. [89.1.117.98])
        by smtp.gmail.com with ESMTPSA id u16sm1918329wmc.41.2021.08.31.01.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 01:17:09 -0700 (PDT)
Subject: Re: Questions about BTRFS balance and scrub on non-RAID setup
To:     Lionel Bouton <lionel-subscription@bouton.name>,
        linux-btrfs@vger.kernel.org
References: <CABFqJH6acH=240RxRhVj5Y9geh-QG7vdDWAgFespwu0nk3wgaQ@mail.gmail.com>
 <04941c75-3ea5-32de-5978-efe5c5681ee2@bouton.name>
From:   Andrej Friesen <andre.friesen@gmail.com>
Message-ID: <d765bf95-0463-59bd-022a-39a0c2d8a241@gmail.com>
Date:   Tue, 31 Aug 2021 10:17:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <04941c75-3ea5-32de-5978-efe5c5681ee2@bouton.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

thanks for the useful information Lionel.
That already helped a lot!

Scrub:

> Partially. Ceph replication/scrub/repair will cover individual disk/OSD
> server faults but not faults at the origin of the data being stored.
> 
> We provide the same service for a customer. Several years ago the VM
> hosting the NFS server for this customer ran on hardware that developed
> a fault, the result was silent corruption of the data written by the NFS
> server *before* being handed to Ceph for storage (probably memory or CPU
> related, we threw the server out of the cluster and never looked back...).
> - ceph scrubbing was of no use there because from its point of view the
> replicated blocks were all fine.
> - we launch btrfs scrub monthly by default and this is how we detected
> the corruption.


This is a really good point!
Even though we might not be able to automatically let btrfs repair the 
corrupted files during the scrub it would be nice to know that this 
happened and act accordingly.

> We make regular rbd snapshots so we could :
> - switch the NFS server to an existing read-only replica (that could not
> be corrupted by the same fault as it was replicated using simple
> file-level content synchronization),
> - restart the original NFS server using the last known good snapshot,
> - rsync fresh data from the replica to the original server to catch up,
> - switch back.

We also wanted to do some rbd snapshots to have some kind of disaster 
recovery if something happens. Just in case.

Our idea was also to offer quick file based "backups" to with btrfs 
snapshots. This would help if the file was once created correctly and 
afterwards writes to that file would get corrupt because of hardware 
failures.
But for filesystem corruption reasons we also wanted to keep some rbd 
snapshots, you never know.


Balance:

> Full balance is probably overkill in any situation and can sunk your I/O
> bandwidth. With recent kernels it seems there is less need for
> balancing. We still use an automatic balancing script that tries to
> limit the amount of free space allocated to nearly empty allocation
> groups (by using "usage=50+" filters) and cancels the balance if it is
> too long (to avoid limiting IO performance for too long, waiting for a
> next call to continue) but I'm not sure if it's still worth it. In our
> case we have been bitten by out of space situations with old kernels
> brought by over-allocation of free space due to temporary large space
> usages so we consider it an additional safeguard.

In order to solve the file system full "problem" we wanted to create a 
large block device and use a quota of lets say 80 % of that for the data 
subvolume.
We could also make the block device double the size of the subvolume and 
quota we offer because it is thin provisioned from the ceph side we do 
not lose any storage.
We have tested discard/trim with btrfs and ceph and everything worked 
fine :-)

Is there any metric we could/should measure in order to see if a balance 
would give us some benefit in some way?

Did you only do the balance for the file system full problem?


I saw a recommendation to run this balance daily:

`btrfs balance start -dusage=50 -dlimit=2 -musage=50 -mlimit=4`

Source:
https://github.com/netdata/netdata/issues/3203#issuecomment-356026930

Is that a valid recommendation still today?
If so, why is the FAQ not having such information available?
I am happy to put something in the wiki, if needed.


Defragmentation:

> You probably want to use autodefrag or a custom defragmentation solution
> too. We weren't satisfied with autodefrag in some situations (were
> clearly fragmentation crept in and IO performance suffered until a
> manual defrag) and developed our own scheduler for triggering
> defragmentation based on file writes and slow full filesystem scans,


The ceph cluster only uses SSDs therefore I guess we do not suffer from 
fragmentation problem as with HDDs. As far as I understood SSDs.

-- 
Andrej Friesen

https://www.ajfriesen.com/
