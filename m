Return-Path: <linux-btrfs+bounces-1288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E5E82635B
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 09:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC3D1F21B43
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jan 2024 08:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1332A12B70;
	Sun,  7 Jan 2024 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJaN0/MH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F589125D3
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Jan 2024 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ccc1a757e5so2520381fa.1
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Jan 2024 00:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704615692; x=1705220492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCxV1zVjNW4aXZSlsjSUxpA2y/txavp/WsgCVW2w28Q=;
        b=dJaN0/MHMJm2Q7sv90bpJxxipv5epi1OUbTzuRmivmHU4BO7bhUjCJaQ1BDsDFMWtM
         1YwIrygJkhCYFeVAUrJe+WZ8vW2IEsJQh4nD9obHfc2iueKEEBD8cK+me8OOxS2gPwVG
         +zvnN2VA44Zul1NUIwcJA334Yc8RBuKchZ67dRiZGOXDHwdG3R5LvpnHGmrSXSZlc10t
         Zxr8EP+Y8mG+vY3tnoTVIcXQCMetE61Xhz+MGZm3L7O9/oSLnwhofngDy2pWa4oUzVmf
         gFFPcEwxwe8/5WfSa+CKoejpxJf1q0fYK8IQYkllWgywC6s2OF1+tivi6AUv55ewu3n0
         tUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704615692; x=1705220492;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCxV1zVjNW4aXZSlsjSUxpA2y/txavp/WsgCVW2w28Q=;
        b=T/lOuthygxh60FLPdn/efjhWV3Al37RpwXFS1GOAWF4FrTZWY1qkKscGrid7wMpwSw
         Mvtwm15f3f5ZwdWdKnklxYbyRiYNFC6fvuQsJHlPdBs2yBv45Xc3nktgSojrsniXY5K9
         G6dhtmjhuQO9t9J06emEsTJLndZlG0RsFcGzi0ZhBC2u3YGoL+oJsDaAovITejU8skvw
         n4YUWj6Yved4+i7OTG6vl35a6qgJT5YjDmcrvUpeMJf0v2+emBlfH7cq8VV1inzidbQb
         Qz7z4HbpMDeEKEozM3hqF+blT45qjPpkX5dk4WyQ6KW3YePDemaiWVwD+r7JjLlCI6br
         bzwA==
X-Gm-Message-State: AOJu0YyAgNwOPNj8rrXMKKn13H9LPpX+v9Pl63le4JTrYWBzBvbhSGFE
	o2lVqmbA4Pzf6QunuAOesERq32rdLB0=
X-Google-Smtp-Source: AGHT+IGTxx0zQmbQITG9AP7fcJDZmLH+v/DbELdisJJS6VfXIAWO2d3QBaVvh/TnE/RYmryph/fOjQ==
X-Received: by 2002:ac2:55a1:0:b0:50e:7b2d:3618 with SMTP id y1-20020ac255a1000000b0050e7b2d3618mr1248332lfg.6.1704615691943;
        Sun, 07 Jan 2024 00:21:31 -0800 (PST)
Received: from [192.168.1.109] ([176.124.146.164])
        by smtp.gmail.com with ESMTPSA id h23-20020a056512055700b0050e9acde054sm744939lfl.3.2024.01.07.00.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 00:21:31 -0800 (PST)
Message-ID: <ce6fd895-abdb-468c-9145-655d7755f289@gmail.com>
Date: Sun, 7 Jan 2024 11:21:30 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using send/receive to keep two rootfs-partitions in sync fails
 with "ERROR: snapshot: cannot find parent subvolume"
Content-Language: en-US, ru-RU
To: Clemens Eisserer <linuxhippy@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAFvQSYQvUQXabM4XDNH34y=CsbCHmonmwRh_sS=DkxhJWC2oxA@mail.gmail.com>
 <de1e4749-c265-496b-956d-6ab8e56af7d0@gmail.com>
 <CAFvQSYReFG3hUJCoRps36hbR1-PaprSsEirodtSS9Bc9nThEtQ@mail.gmail.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAFvQSYReFG3hUJCoRps36hbR1-PaprSsEirodtSS9Bc9nThEtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.01.2024 11:10, Clemens Eisserer wrote:
> Hello Andrei,
> 
> Thanks for taking a look.
> 
> The exact commands executed where:
> 
> mkdir intern
> mkdir extern
> 
> mount /dev/mapper/ext extern
> mout /dev/mapper/int intern
> 
> ls extern/
> # output: root-ro
> 
> ls intern/
> # output: -> empty
> 
> btrfs send extern/root-ro | btrfs receive intern/ #initial ext -> int
> btrfs sub snap intern/root-ro intern/root-rw # rw snapshot to modify int
> touch intern/root-rw/newfile #actual modification
> 
> umount intern
> umount extern
> 
> sh sync_int_to_ext.sh #source of script at bottom
> 
> ls extern/root-ro/newfile
> # output: extern/root-ro/newfile -> sync int->ext was successful
> 
> # now modify ext fs
> mount /dev/mapper/ext extern/
> touch extern/root-rw/anothernewfile
> umount extern
> 
> sh sync_ext_to_int.sh
> 
> mount /dev/mapper/int intern/
> 
> ls intern/root-ro/anothernewfile
> # output intern/root-ro/anothernewfile -> sync ext->int was successful
> 
> umount intern
> 
> sh sync_int_to_ext.sh # just to make sure
> 
> # boot into extern/root-rw with rootflags=subvol/root-rw
> # both newfile and anothernewfile are visible in the root-fs
> 
> # reboot into other OS used for syncing disks
> 
> sh sync_ext_to_int.sh #to mirror modifications made in ext during it
> was rootfs back to intern, worked
> sh sync_int_to_ext.sh # just to make sure
> 
> # boot into extern/root-rw with rootflags=subvol/root-rw
> # perform a few modifications
> 
> # reboot into other OS used for syncing disks
> 
> sh sync_ext_to_int.sh
> # command btrfs send -p extern/root-ro extern/root-ro-new | btrfs
> receive intern/ fails with:
> ERROR: clone: cannot find source subvol 29fca96e-ca6a-3d4b-b7c9-566f1240d978
> 
> 
> btrfs sub list -pqu intern/
> ID 330 gen 426 parent 5 top level 5 parent_uuid
> 29fca96e-ca6a-3d4b-b7c9-566f1240d978 uuid
> 6409bfb7-1af0-7e4b-8a0f-d5a44e34a15c path root-ro
> ID 331 gen 426 parent 5 top level 5 parent_uuid
> 6409bfb7-1af0-7e4b-8a0f-d5a44e34a15c uuid
> 258c1fe5-b14e-654b-8ad5-5591268c9095 path root-rw
> 
> btrfs sub list -pqu extern/
> ID 291 gen 418 parent 5 top level 5 parent_uuid
> 1c738933-0bb2-2547-ad5f-326bfc6263b3 uuid
> 939c1ed9-9589-6c4b-ace7-2fcdeb970303 path root-rw
> ID 292 gen 418 parent 5 top level 5 parent_uuid
> 939c1ed9-9589-6c4b-ace7-2fcdeb970303 uuid
> 155f4370-32f0-5f4b-b288-2e8d7302d279 path root-ro
> 
> Best regards, Clemens
> 
> 
> 
> script sync_ext_to_int.sh:
> 
> unalias cp
> mount -o compress=zstd:6 /dev/mapper/ext extern/
> mount -o compress=zstd:6 /dev/mapper/int intern/
> 
> btrfs sub snap -r extern/root-rw extern/root-ro-new
> btrfs send -p extern/root-ro extern/root-ro-new | btrfs receive intern/
> 
> btrfs sub del extern/root-ro
> mv extern/root-ro-new extern/root-ro
> 
> btrfs sub del intern/root-ro
> mv intern/root-ro-new intern/root-ro
> btrfs sub del intern/root-rw
> btrfs sub snap intern/root-ro intern/root-rw
> 
> #cp cfgint/fstab intern/root-rw/etc/
> #cp cfgint/crypttab intern/root-rw/etc/
> #cp cfgint/grub intern/root-rw/etc/default/
> 
> umount extern;
> umount intern;
> 
> 
> 
> script sync_int_to_ext.sh:
> 
> unalias cp
> mount -o compress=zstd:6 /dev/mapper/ext extern/
> mount -o compress=zstd:6 /dev/mapper/int intern/
> 
> btrfs sub snap -r intern/root-rw intern/root-ro-new
> btrfs send -p intern/root-ro intern/root-ro-new | btrfs receive extern/
> 
> btrfs sub del intern/root-ro
> mv intern/root-ro-new intern/root-ro
> 
> btrfs sub del extern/root-ro
> mv extern/root-ro-new extern/root-ro
> btrfs sub del extern/root-rw
> btrfs sub snap extern/root-ro extern/root-rw
> 
> cp cfgext/fstab extern/root-rw/etc/
> cp cfgext/crypttab extern/root-rw/etc/
> cp cfgext/grub extern/root-rw/etc/default/
> 
> umount extern;
> umount intern;
> 
> Am So., 7. Jan. 2024 um 08:19 Uhr schrieb Andrei Borzenkov
> <arvidjaar@gmail.com>:
>>
>> On 07.01.2024 10:06, Clemens Eisserer wrote:
>>> Hi,
>>>
>>> I would like to use send/receive to keep two root-filesystems in sync,
>>> as I've been using it for years now for backups where it really does
>>> wonders (thanks a lot!).
>>>
>>> Both disks contain a read-only snapshot which is kept in-sync between
>>> the filesystems (int and ext are the mountpoints of the two disks,
>>> original_disk is just used for initial data):
>>>      btrfs send original_disk/root-ro | btrfs receive int/ #send
>>> snapshot of the original disk to the first of the two filesystens
>>> (disk "int")
>>>      btrfs send int/root-ro | btrfs receive ext/ #now replicate the same
>>> to disk "ext"
>>> so both disks start with a snapshot "root-ro" with equal content.
>>>
>>> in case I would like to work with one of the two disks, I create a rw
>>> snapshot based no root-ro:
>>>     btrfs sub snap ext/root-ro ext/root-rw
>>>
>>>     touch ext/root-wr/create-a-new-file # perform some modifications
>>>
>>
>> There was no "root-wr" before.
>>
>>> once modifications in root-rw are done, the following steps are
>>> performed to sync the filesystems:
>>>     btrfs sub snap -r ext/root-rw ext/root-ro-new #create a root-ro-new
>>> read-only snapshot based on the rw-snapshot with modfications (so it
>>> can be used with btrfs send)
>>>     btrfs send -p ext/root-ro extern/root-ro-new | btrfs receive int/
>>> #send root-ro-new to "int" filesystem
>>
>> There was no "extern" before.
>>
>> Never describe computer commands. Copy and paste them in full with
>> complete output.
>>
>>>     btrfs sub del ext/root-ro # delete the original root-ro snapshot, as
>>> it is no longer needed for differential btrfs send
>>>     mv ext/root-ro-new ext/root-ro #rename root-ro-new to root-ro, as
>>> this is the current state of the other (int) filesystem
>>>     btrfs sub del int/root-ro # delete root-ro in "int" too, as it is no
>>> longer needed for differential btrfs receive
>>>     mv int/root-ro-new int/root-ro #rename root-ro-new to root-ro
>>>     btrfs sub snap int/root-ro int/root-rw # create a working copy of
>>> root-ro which is writeable
>>>
>>> this works great - i can add/modify files in one root-rw folder, call
>>> the synchronization script and everything is found on the other
>>> filesystem.
>>> When exchanging int and ext in the script above it actually works in
>>> both directions, so this is exactly what I was hoping to achieve.
>>> Even when executing the script multiple times int->ext, ext->int,
>>> int->ext ... with modifications in between, everything works as
>>> expected.
>>> Awesome :)
>>>
>>> However, when actually using the file-systems as rootfs, this seem to
>>> break when performing the following steps:
>>> - create rw snapshot of root-ro on disk "ext": btrfs sub snap
>>> ext/root-ro ext/root-rw
>>> - boot the system with rootfs=ext-uuid and rootflags=subvol=/root-rw
>>> (etc/fstab was adapted accordingly)
>>> - use the system, modify file system etc and shutdown again
>>> - start separate system to synchronize disks (not based on int or ext
>>> rootfs) and call sync script ext->int (shown above)
>>>
>>
>> It is absolutely unclear what it means. As mentioned, provide full
>> transcript of your actions as well as the output of
>>
>> btrfs subvolume list -pqu /mount-point
>>

Apologies, could you post

btrfs subvolume list -pqRu ...

to get received UUID.

>> for all filesystems involved in these commands.
>>
>>> it now suddenly fails at btrfs receive with:
>>> btrfs send -p ext/root-ro ext/root-ro-new | btrfs receive intern/
>>> ERROR: snapshot: cannot find parent subvolume
>>> 4ed11491-7563-fb49-99e7-86cb47cfb510
>>>
>>> which I, to be honest, don't understand.
>>> Exactly the same sequence of commands worked multiple times when the
>>> root-rw snapshot was not booted from but modified directly on the sync
>>> system, even with umounts between modification & send/receive.
>>> Does it make a difference for btrfs if it is used as rootfs vs normal
>>> writeable mount?
>>> Or does it just work in the non-boot case because of some side-effects?
>>>
>>> Thanks & best regards, Clemens
>>>
>>
> 


