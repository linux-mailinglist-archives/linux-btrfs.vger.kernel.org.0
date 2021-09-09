Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706F94058B5
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 16:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbhIIOOD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 10:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353279AbhIION7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Sep 2021 10:13:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C01C034038
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Sep 2021 05:24:18 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id l11so3373565lfe.1
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Sep 2021 05:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3hMW+dQWAvNbzD6c/FgpeKrvLOKZiTlVHQPFtYaWI2I=;
        b=PeXUieGhCxnOx2mogDHoAqfo/e4/PwpD8FaB56o3aw00qj146ayKN03h0PkfFx7Usm
         ie6pi33J99D1JHSBMtluiUIRCuV07Vlm1gXljY/25NpONJZIxPjjRCtJX4wAe1v4w6Lr
         KBIIazKpvYJGQ/7wdoVKAR3xVOpOngRraxJTGIegRwyBf/WIgVJjZOUOy6rFLBaTYmJY
         PNWFK4Q3OyYo6Ipfz1HehOg1Hs2UoLsmoP2dzR91MSo59Qm16fz4swFQXJy9WFRg5S+F
         kfZv//s99N+THyagqdnK9VNYIuH+IN0RpwaEKHN+PNQ/D8/pmcyXFcgFoB1wUa3LypIH
         hS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3hMW+dQWAvNbzD6c/FgpeKrvLOKZiTlVHQPFtYaWI2I=;
        b=sQu48iG+AIhkvbTasEKnOt6hwEgRPHl1iFHTjawIUnuHg0Mq7tJTdRLsnOtArYEfdZ
         okuMAzUul/mZn2liOwnDGk/MHjgdhB8E5ynz2hRzeLH2U58SuUiR1xBjM7f3wlvSU15b
         nKRDVT24lzSfXFW083C09XLFvJuok3Qt4ifI0ll+sLlrVbo/nd/foDBlDVj+6PtwVN5L
         MLuPuALVmpSWkFmBe+KkOlThWwc8VkSYsi/5NHCGJRyMGFfKP/W/IKJmbBjKpExpQXet
         dvh04685ILq4ZeVPownzAMjcUaGwrv5On9ZWyMlFT8KR2t5kR6BrdJe10k19wMwmst4C
         sCtQ==
X-Gm-Message-State: AOAM532mFBbbSCJkfrYMdInwVDIUgPPWkCC7tZuFSz/mNZbEa4E0anxx
        BPniWm7SlPW284lBSarHAyb0Zu9F9ukfJQ==
X-Google-Smtp-Source: ABdhPJyA6Prcg1IJjhqNeu3uSXifvUd52oFhi5p25jlyQpP5B1T1Blw053y7czeBKh8KG8UDSp8zlA==
X-Received: by 2002:a05:6512:2009:: with SMTP id a9mr2125877lfb.647.1631190256209;
        Thu, 09 Sep 2021 05:24:16 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:7b89:f5c1:8fc4:df08:16ab? ([2a00:1370:812d:7b89:f5c1:8fc4:df08:16ab])
        by smtp.gmail.com with ESMTPSA id z15sm185416ljm.78.2021.09.09.05.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 05:24:15 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: Remove received information from snapshot on
 ro->rw switch
To:     Graham Cobb <g.btrfs@cobb.uk.net>, dsterba@suse.cz,
        Martin Raiber <martin@urbackup.org>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210908135135.1474055-1-nborisov@suse.com>
 <0102017bc64308e0-f75c4f13-349c-4c2c-a77d-f037340f07c1-000000@eu-west-1.amazonses.com>
 <20210908183312.GU3379@twin.jikos.cz>
 <44c16ed8-89fe-a38b-0304-a84dfd4a5335@cobb.uk.net>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <88e84dbf-3d38-1dba-57b5-7afb0fd51fa4@gmail.com>
Date:   Thu, 9 Sep 2021 15:24:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <44c16ed8-89fe-a38b-0304-a84dfd4a5335@cobb.uk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09.09.2021 00:24, Graham Cobb wrote:
> 
> On 08/09/2021 19:33, David Sterba wrote:
>> On Wed, Sep 08, 2021 at 04:34:47PM +0000, Martin Raiber wrote:
> 
> <snip>
> 
>>> For example I had the problem of partial subvols after a sudden
>>> restart during receive. No problem, just receive to a directory that
>>> gets deleted on startup then move the subvol to the final location
>>> after completion. To move the subvol it needs to be temporarily set rw
>>> for some reason. I'm sure there is some better solution but patterns
>>> like this might be out there.
>>

Better solution is to delete partial subvolume and start over. No need
to mess with internals.

>> Thanks, that's a case we should take into account. And there are
>> probably more, but I'm not using send/receive much so that's another
>> reason why I've been hesitant to merge the patch due to lack of
>> understanding of the use case.
>>
> 
> This seems to be an important change to make, but is user-affecting. A
> few ideas:
> 
> 1) Can it be made optional? On by default but possible to turn off
> (mount option, sys file, ...) if you really need to retain the current
> behaviour.
> 

And then next btrfs update will start modifying read-write subvolume
when you do not expect it and we are back on square one.

> 2) Is there a way to engage with the developers and user community for
> popular tools which make heavy use of snapshotting and/or send/receive
> for discussion and testing? For example, btrbk, snapper, distros.
> 

The only reason you need possibility to flip read-only bit is to allow
btrfs receive to write to subvolume and mark it read-only after that.
What should have happened instead is subvolume state where only one
process (btrfs receive) is allowed to write and subvolume is
automatically removed if this process dies before having completed.

Even better would be support for checkpoints and restarts.

But current situation is really the worst possible.

> 3) How about adding an IOCTL to allow the user to set/delete the
> received_uuid? Only intended for cases which really need to emulate the
> removed behaviour. This could be a less complex long term solution than
> keeping option 1 indefinitely.
> 

This IOCTL already exists and it is used by btrfs receive but it does
not really solve anything. Why do you expect users to remember to use
this IOCTL if users do not remember to never switch read-only subvolume
that is part of replication to read-write?

tw:/home/bor/python-btrfs/examples # btrfs sub sh /mnt/rcv2/src-snap1/
rcv2/src-snap1
	Name: 			src-snap1
	UUID: 			05bb994c-605d-3042-b45a-1ba9d88822ea
	Parent UUID: 		-
	Received UUID: 		213b224e-016e-0b43-a681-d534027cfe95
	Creation time: 		2021-09-01 20:30:35 +0300
	Subvolume ID: 		263
	Generation: 		118
	Gen at creation: 	114
	Parent ID: 		262
	Top level ID: 		262
	Flags: 			readonly
	Snapshot(s):
				src-snap1-clone
				src-snap1-clone1
tw:/home/bor/python-btrfs/examples # btrfs property set
/mnt/rcv2/src-snap1/ ro false
tw:/home/bor/python-btrfs/examples # btrfs sub sh /mnt/rcv2/src-snap1/
rcv2/src-snap1
	Name: 			src-snap1
	UUID: 			05bb994c-605d-3042-b45a-1ba9d88822ea
	Parent UUID: 		-
	Received UUID: 		213b224e-016e-0b43-a681-d534027cfe95
	Creation time: 		2021-09-01 20:30:35 +0300
	Subvolume ID: 		263
	Generation: 		118
	Gen at creation: 	114
	Parent ID: 		262
	Top level ID: 		262
	Flags: 			-
	Snapshot(s):
				src-snap1-clone
				src-snap1-clone1
tw:/home/bor/python-btrfs/examples # ./set_received_uuid.py
00000000-0000-0000-0000-000000000000 0 0.0 /mnt/rcv2/src-snap1/
Current subvolume information:
  subvol_id: 263
  received_uuid: 213b224e-016e-0b43-a681-d534027cfe95
  stime: 0.0 (1970-01-01T00:00:00)
  stransid: 111
  rtime: 1630517435.297119052 (2021-09-01T17:30:35.297119)
  rtransid: 115

Setting received subvolume...

Resulting subvolume information:
  subvol_id: 263
  received_uuid: 00000000-0000-0000-0000-000000000000
  stime: 0.0 (1970-01-01T00:00:00)
  stransid: 0
  rtime: 1631189234.720887105 (2021-09-09T12:07:14.720887)
  rtransid: 167

tw:/home/bor/python-btrfs/examples # btrfs sub sh /mnt/rcv2/src-snap1/
rcv2/src-snap1
	Name: 			src-snap1
	UUID: 			05bb994c-605d-3042-b45a-1ba9d88822ea
	Parent UUID: 		-
	Received UUID: 		-
	Creation time: 		2021-09-01 20:30:35 +0300
	Subvolume ID: 		263
	Generation: 		118
	Gen at creation: 	114
	Parent ID: 		262
	Top level ID: 		262
	Flags: 			-
	Snapshot(s):
				src-snap1-clone
				src-snap1-clone1
tw:/home/bor/python-btrfs/examples #
