Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F1B47938F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 19:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbhLQSIu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 13:08:50 -0500
Received: from smtp-31-wd.italiaonline.it ([213.209.13.31]:51160 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234093AbhLQSIu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 13:08:50 -0500
Received: from [192.168.1.27] ([78.12.25.242])
        by smtp-31.iol.local with ESMTPA
        id yHewm37XTOKKIyHewmHnPV; Fri, 17 Dec 2021 19:08:48 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639764528; bh=DrR0vhJA0A5L1P7nKOMkBizcJnzBczNEu8x7lrbkfhI=;
        h=From;
        b=Q3rIk3BdfQ2jSVSJFsD5UYHG7lW52tbMkqooFYAgwvyM6gmPiBPRyi1hepAT/GqPH
         iIPTxt1GeCgTOAmDfgMd+0GXsVzIIwztItP5xC88JQcKSk6RG8JVLkagpAjYX/RZPl
         kP6vopXEsNAkJo+TdDJCObYyyEZvXdzhabJgMCqt3r7QMtSFNB5GvTuLR3O0h3yX3K
         GD+j2THmLgyLjvHjLCw8D3/ZswM8LQqF4L/MHMs3Ccxax261mCqCz6qebuL6Jr0xqT
         i5+1qFBMoUPYV5jV5lDJVvbxDO4GOCIrSxEGrwaFP+nIT+DH62eM7OIMT0p4pNmu8c
         +2MgiC/0gbhwA==
X-CNFS-Analysis: v=2.4 cv=QuabYX+d c=1 sm=1 tr=0 ts=61bcd230 cx=a_exe
 a=IXMPufAKhGEaWfwa3qtiyQ==:117 a=IXMPufAKhGEaWfwa3qtiyQ==:17
 a=IkcTkHD0fZMA:10 a=kLkcIFAxblVy9NE4HEMA:9 a=QEXdDO2ut3YA:10
Message-ID: <89554a58-1d6c-bc49-6ae2-5ba41752be05@libero.it>
Date:   Fri, 17 Dec 2021 19:08:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
 <Ybe34gfrxl8O89PZ@localhost.localdomain> <YbfN8gXHsZ6KZuil@hungrycats.org>
 <71e523dc-2854-ca9b-9eee-e36b0bd5c2cb@libero.it>
 <Ybj40IuxdaAy75Ue@hungrycats.org> <Ybj/0ITsCQTBLkQF@localhost.localdomain>
 <be4e6028-7d1d-6ba9-d16f-f5f38a79866f@libero.it>
 <Ybn0aq548kQsQu+z@localhost.localdomain>
 <633ccf8f-3118-1dda-69d2-0398ef3ffdb7@libero.it>
 <YbqOwN7SW7NWm5/S@localhost.localdomain> <Ybwi58Uivf29oGhw@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <Ybwi58Uivf29oGhw@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHm61JDwlqp2JGIota46VxM7pLgw2t21X+0Ntmh2Rkvmk0bCsUsncZQelfSw1GMAzg55QFs1Y3DHcofC5ChznWXrqr26K+YE0fw9mahUNsWGrPeRZQ/h
 P5lBpPx+dlUPAVoWzr4f1w6YttwDdOx8nXHFE5V7S3y4j9nvmbF6prbO69Q0sF+jEw4f+HFtOuwpucblwAZ4pHBzfSk0buL6hIPklNC/nXeWqKT9du+YgPEp
 mvYEjQIKWmT7y252WEZB2OK1NhTSBqvOd+MMKS0ltemq9Jun+rYOq6CNHjMqZrnChhT7uIdMWC0HNZUvArsiL4NFBQY1PRMksZMdXMIZRo8y476sTYPYdD53
 r7UcllkH
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/17/21 06:40, Zygo Blaxell wrote:

> 
> In theory if you get stuck in an impossible allocation situation (like all
> your disks are data-only and you run out of metadata space) then one way
> to recover from it is to mount with an old kernel which doesn't respect
> the type bits.  


> Another way to recover would be to flip the type bits
> while the filesystem is offline with btrfs-progs.  

Unfortunately this would not doable; type is backup-ped in the dev_item
which are stored in the metadata.

So despite the fact that the filesystem is mounted or not, changing
"type" would require updating metadata which in turn may require to
allocate a new metadata BG.


> A third way would be to
> have a mount option for newer kernels to ignore the allocation bits like
> old kernels do (yes I know I already said I didn't like that idea).

The patch is still available. However I have to point out that this is not
a new problem. Will be always some cases where the metadata space is
exhausted and is not possible to make the needing changes to create space.

If the user uses the _ONLY flags, it is shooting in its feet. We should warn
in the manual to avoid that. But even if the user do that we still have the
problem. Frankly speaking I fatigue to see an use case where _ONLY flags are
needed. IMHO _PREFERRED are enough; what it is needed is to improve the
reporting to the user about these cases: something like that for each
btrfs-prog invocation a warning is raised when the metadata space is near to
exhaustion...

> 
> If we have a bit that says "old kernels don't mount this filesystem any
> more" then we lose one of those recovery options, and the other options
> aren't implemented yet.

Using an old kernel is not a solution. Sooner another new non-backward
compatible change will prevent that.

> 
> While I think of it, the metadata reservation system eventually needs
> to know that it can't use data-only devices for metadata, the same way
> that df eventually needs to know about metadata-only devices.
> 
> 
>> Josef
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
