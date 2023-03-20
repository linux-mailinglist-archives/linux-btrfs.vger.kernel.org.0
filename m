Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA186C0C12
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 09:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCTIVZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 04:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCTIVX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 04:21:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BBE196A1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 01:21:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o40-20020a05600c512800b003eddedc47aeso1509593wms.3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679300479;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w/whyBEIhGR56OQWr/i1fJulfUsTOqCo0qwZMLBywA4=;
        b=e6OtNYcykYPu+XBxrHOp4uVt6uWz1YtWOIRpR+XbmhIPEd8cuTJYMv6ZeTya16PclG
         zoWQyxO95JdpZyRSyoZ2Si0fmcJAPRMBhNmgzpKCfQFfwjJuBPvcZy7V6uAVcrOSRtZa
         Kf2ESKHUGb0xyr13Dou16IFnqonQmigOSiTSre4gcf4oLkojBA4GZg2rfGc5G3KpR4B/
         pkJ63Azdt15wrq9pa3RaE477S21LKqeZDxJNnKAUjXC73+T6K7pvS/0LeFc7/OmtOfXZ
         XtM+YQjRqxqs7JD6jVgSE2AiuRYMrxppa0iA7jJ0NIuhXD1GPZ4VkOj3u0dmpO3kHk8w
         A/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679300479;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/whyBEIhGR56OQWr/i1fJulfUsTOqCo0qwZMLBywA4=;
        b=D10ZPetUcbh1tu/FvSgYpZaNDs9aeG7JK2xUBrFnv/0ZZRFRtvG+LcAiZA7byeP324
         HLK1y3VhuDjT283nhnSja6Vu6n2DxVDeSyDKfsENCwIDD3mvGOxxjNO+FH0mmCXe8uFi
         O/nG/B+UYgTAV5Pz9VydjMv3eTlSm2bqDozFRw6oRejvTPV4MvK03Ge97Slyj/PP4qCD
         k7Vhz4BXMgs3v7TkMKlstiLXU3P6wTX4PeD0lGcip/4XhjwBmGVSDvpWKhVFIVknffgw
         H/ygoPIS4OadrRGt2dxsATrmXNMQ7x+AkAXJf1dD6nElor77A6CIjY/EK/ADwep2fJoP
         pTOw==
X-Gm-Message-State: AO0yUKUhNJjUWTiqF6Dq8ZTLsIrRaItS1b2EWuoIYDDet8QbPJWZSmPE
        SyoOXINAt7/fBl1vzmJF5CNBAHlaE8M=
X-Google-Smtp-Source: AK7set8mTOkt8EJrcjT7Zz6D/baPpnufi35fnTeQnreTYh5NxzSaBcyHeuQvd6eRwgsR455m0Vawug==
X-Received: by 2002:a1c:ed0b:0:b0:3ed:8c60:c512 with SMTP id l11-20020a1ced0b000000b003ed8c60c512mr9274256wmh.17.1679300479055;
        Mon, 20 Mar 2023 01:21:19 -0700 (PDT)
Received: from 2a02-8440-c125-2685-94ed-a895-6f11-309e.rev.sfr.net (2a02-8440-c125-2685-94ed-a895-6f11-309e.rev.sfr.net. [2a02:8440:c125:2685:94ed:a895:6f11:309e])
        by smtp.gmail.com with ESMTPSA id o25-20020a1c7519000000b003edff838723sm1485434wmc.3.2023.03.20.01.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 01:21:18 -0700 (PDT)
Message-ID: <be621f62b01fd14d1bb81a5ec01a7cb613496c75.camel@gmail.com>
Subject: Re: Utility btrfs-diff-go confused by btrfs-send output - a file
 isn't changed but is associated with an UPDATE_EXTENT command
From:   Michael Bideau <mica.devel@gmail.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Date:   Mon, 20 Mar 2023 09:21:25 +0100
In-Reply-To: <CAL3q7H6FuWMcoGwzLG+CscQ3Xc=M4Y75Vw81efquvY-s7_9CTg@mail.gmail.com>
References: <4508efb976dddf7ca5be98f742de2db4db677ab2.camel@gmail.com>
         <CAL3q7H6FuWMcoGwzLG+CscQ3Xc=M4Y75Vw81efquvY-s7_9CTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

Thanks Filipe for your quick and precise answer.

My follow-up questions below...

Le vendredi 10 mars 2023 à 13:41 +0000, Filipe Manana a écrit :
> On Fri, Mar 10, 2023 at 1:24 PM Michael Bideau <mica.devel@gmail.com> wrote:
> > 
> > Hi all,
> > 
> > First, thank you for the btrfs FS and all your work.
> > This is my first interaction with this community and I'll try to communicate
> > to
> > my best.
> > 
> > I am developing 'btrfs-diff-go' (https://github.com/mbideau/btrfs-diff-go),
> > an
> > utility that analyse the output stream of a 'btrfs-send' command, and
> > produce an
> > output like the 'diff' utility to visualise which files/directories have
> > changed
> > (and how) between two btrfs subvolumes/snapshots.
> > 
> > While I was testing it I encountered an issue: some files were detected as
> > changed, when they where actually not (no difference with 'diff' nor
> > 'sha256sum').
> > With my program's debug log I found out that it was related with the
> > UPDATE_EXTENT command, always interpreted as a file change.
> > Digging into it I ended up in the 'btrfs-send' source code and found out
> > that
> > this command was used when data actually has changed I guess (in function
> > 'send_extent_data'
> > https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/tree/fs/btrf
> > s/send.c#n5682
> > ), but also for "holes" (in function 'send_hole'
> > https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/tree/fs/btrf
> > s/send.c#n5456
> > ).
> > I couldn't debug further nor check myself (according to my current free time
> > and
> > knowledge), but as I read the code I understand that the function
> > 'send_update_extent' always send a path, and maybe that path is wrong or
> > should
> > be empty when sending a "hole" ?
> > 
> > Could you please help me:
> > - to reproduce a simple test case that send the UPDATE_EXTENT command for a
> > real
> > file change and for a hole ? This way I could acknowledge properly the issue
> > in
> > my program 'btrfs-diff-go', and later on the fix.
> > - to understand what's going on ... Is a "hole" an actual file change even
> > no
> > data has changed in that file, and if so, how I am supposed to filter them
> > out
> > to only report real data changes to match 'diff' output ?
> > - to report this as a bug if you think it is one ?
> 
> There at least a couple reasons why an UPDATE_EXTENT command may be
> sent yet the data in the file did not change:
> 
> 1) The file is fully or partially rewritten with the same data - for
> e.g. running defrag - this only changes the extent layout - but we
> have no way to quickly and efficiently check it's the same data, so we
> send the UPDATE_EXTENT command - it may also be interesting for some
> use cases to know the extent layout changed - so it's not necessarily
> a bad thing;

Agreed that is it not a bad thing, but I would have liked to have the
information if only the layout changed and not the data (from a user
perspective).

Do you think it is possible to code an evolution, either of the btrfs kernel or
of the btrfs-progs, to get that information (data change/layout change), may be
with an option flag ? I am sure we could find a solution that would cost less
than a full check-summing or a diff of the content and still be usable ... May
be there is different strategies to get that feature ...

I am not able to design and code it myself (lack of time and knowledge) but I
could contribute to issue description, use case, and may be testing... with some
help/guidance.

> 
> 2) A hole is punched into a file range with all data bytes having a
> value of 0. Or an application writes zeros to a range with a hole, or
> calls fallocate against a range that has a hole.
> 
> If you find a case where the extent layout is exactly the same and no
> data changed, then it's a bug (although a minor one as it didn't
> incorrectly change the file).

I struggled a lot to check that and failed. Could you provide me guidance on how
to check that please ?

The following were my different attempts to find a way to compare the extents
layout :


```
$ sudo sha256sum /mnt/toplevel/timeshift-btrfs/snapshots/2023-02-22_23-00-
06/@/var/lib/blueman/network.state \
 /mnt/toplevel/timeshift-btrfs/snapshots/2023-03-02_13-31-
55/@/var/lib/blueman/network.state
03dbfae7fc7cc0e59ef20df6e3fde60caa086da0af0c6ef6db2c543e49870a58
/mnt/toplevel/timeshift-btrfs/snapshots/2023-02-22_23-00-
06/@/var/lib/blueman/network.state
03dbfae7fc7cc0e59ef20df6e3fde60caa086da0af0c6ef6db2c543e49870a58
/mnt/toplevel/timeshift-btrfs/snapshots/2023-03-02_13-31-
55/@/var/lib/blueman/network.state

$ sudo stat /mnt/toplevel/timeshift-btrfs/snapshots/2023-02-22_23-00-
06/@/var/lib/blueman/network.state
 Fichier : /mnt/toplevel/timeshift-btrfs/snapshots/2023-02-22_23-00-
06/@/var/lib/blueman/network.state
 Taille : 154 Blocs : 8 Blocs d'E/S : 4096 fichier
Périphérique : 0/49 Inœud : 292461 Liens : 1
Accès : (0644/-rw-r--r--) UID : ( 0/ root) GID : ( 0/ root)
 Accès : 2023-03-12 12:12:11.601909283 +0100
Modif. : 2023-02-22 19:56:50.915720066 +0100
Changt : 2023-02-22 19:56:50.915720066 +0100
 Créé : 2022-11-12 22:21:37.822349260 +0100

$ sudo stat /mnt/toplevel/timeshift-btrfs/snapshots/2023-03-02_13-31-
55/@/var/lib/blueman/network.state
 Fichier : /mnt/toplevel/timeshift-btrfs/snapshots/2023-03-02_13-31-
55/@/var/lib/blueman/network.state
 Taille : 154 Blocs : 8 Blocs d'E/S : 4096 fichier
Périphérique : 0/51 Inœud : 292461 Liens : 1
Accès : (0644/-rw-r--r--) UID : ( 0/ root) GID : ( 0/ root)
 Accès : 2023-03-07 16:58:03.027010803 +0100
Modif. : 2023-03-02 13:23:43.909033727 +0100
Changt : 2023-03-02 13:23:43.909033727 +0100
 Créé : 2022-11-12 22:21:37.822349260 +0100

$ sudo filefrag -e /mnt/toplevel/timeshift-btrfs/snapshots/2023-02-22_23-00-
06/@/var/lib/blueman/network.state
Filesystem type is: 9123683e
File size of /mnt/toplevel/timeshift-btrfs/snapshots/2023-02-22_23-00-
06/@/var/lib/blueman/network.state is 154 (1 block of 4096 bytes)
 ext: logical_offset: physical_offset: length: expected: flags:
 0: 0.. 4095: 0.. 4095: 4096: last,not_aligned,inline,eof
/mnt/toplevel/timeshift-btrfs/snapshots/2023-02-22_23-00-
06/@/var/lib/blueman/network.state: 1 extent found

$ sudo filefrag -e /mnt/toplevel/timeshift-btrfs/snapshots/2023-03-02_13-31-
55/@/var/lib/blueman/network.state
Filesystem type is: 9123683e
File size of /mnt/toplevel/timeshift-btrfs/snapshots/2023-03-02_13-31-
55/@/var/lib/blueman/network.state is 154 (1 block of 4096 bytes)
 ext: logical_offset: physical_offset: length: expected: flags:
 0: 0.. 4095: 0.. 4095: 4096: last,not_aligned,inline,eof
/mnt/toplevel/timeshift-btrfs/snapshots/2023-03-02_13-31-
55/@/var/lib/blueman/network.state: 1 extent found

$ sudo python3 btrfs-debugfs -f /mnt/toplevel/timeshift-btrfs/snapshots/2023-02-
22_23-00-06/@/var/lib/blueman/network.state
(292461 0): ram 154 disk 0 disk_size 154 -- inline
file: /mnt/toplevel/timeshift-btrfs/snapshots/2023-02-22_23-00-
06/@/var/lib/blueman/network.state extents 1 disk size 154 logical size 154
ratio 1.00

$ sudo python3 btrfs-debugfs -f /mnt/toplevel/timeshift-btrfs/snapshots/2023-03-
02_13-31-55/@/var/lib/blueman/network.state
(292461 0): ram 154 disk 0 disk_size 154 -- inline
file: /mnt/toplevel/timeshift-btrfs/snapshots/2023-03-02_13-31-
55/@/var/lib/blueman/network.state extents 1 disk size 154 logical size 154
ratio 1.00

$ sudo btrfs fi du /mnt/toplevel/timeshift-btrfs/snapshots/2023-02-22_23-00-
06/@/var/lib/blueman/network.state \
 /mnt/toplevel/timeshift-btrfs/snapshots/2023-03-02_13-31-
55/@/var/lib/blueman/network.state
 Total Exclusive Set shared Filename
 0.00B 0.00B 0.00B /mnt/toplevel/timeshift-btrfs/snapshots/2023-02-22_23-00-
06/@/var/lib/blueman/network.state
 0.00B 0.00B 0.00B /mnt/toplevel/timeshift-btrfs/snapshots/2023-03-02_13-31-
55/@/var/lib/blueman/network.state

$ sudo btrfs sub show /mnt/toplevel/timeshift-btrfs/snapshots/2023-02-22_23-00-
06/@
timeshift-btrfs/snapshots/2023-02-22_23-00-06/@
 Name: @
 UUID: 2209acc6-1f29-1042-95ac-5d9a3b59b9e0
 Parent UUID: 24d1cc44-64a9-7547-a325-b99f871c83c0
 Received UUID: -
 Creation time: 2023-02-22 23:00:06 +0100
 Subvolume ID: 468
 Generation: 79512
 Gen at creation: 73193
 Parent ID: 5
 Top level ID: 5
 Flags: -
 Send transid: 0
 Send time: 2023-02-22 23:00:06 +0100
 Receive transid: 0
 Receive time: -
 Snapshot(s):
 .2023-02-22_23-00-06.ro/@

$ sudo btrfs sub show /mnt/toplevel/timeshift-btrfs/snapshots/2023-03-02_13-31-
55/@
timeshift-btrfs/snapshots/2023-03-02_13-31-55/@
 Name: @
 UUID: cd6b2945-cce2-e843-8b0a-ce48711303e2
 Parent UUID: 24d1cc44-64a9-7547-a325-b99f871c83c0
 Received UUID: -
 Creation time: 2023-03-02 13:31:55 +0100
 Subvolume ID: 482
 Generation: 79512
 Gen at creation: 74292
 Parent ID: 5
 Top level ID: 5
 Flags: -
 Send transid: 0
 Send time: 2023-03-02 13:31:55 +0100
 Receive transid: 0
 Receive time: -
 Snapshot(s):
 .2023-03-02_13-31-55.ro/@

$ sudo btrfs inspect-internal dump-tree -e /dev/mapper/luks-d62a42e4-b94e-4c99-
a869-23c6cdc3f55f > /tmp/dump_tree_extents.txt # not found any inode matching
the one of the files

```

Thanks again (to all).

> 
> 
> 
> > 
> > See also:
> > - btrfs-progs sending UPDATE_EXTENT command:
> > https://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-
> > progs.git/tree/libbtrfs/send-stream.c#n455
> > - btrsf-progs receiving UPDATE_EXTENT command:
> > https://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-
> > progs.git/tree/cmds/receive.c#n986
> > 
> > Thanks in advance for your time and answers.
> > 
> > Best regards,
> > Michael Bideau [France]
> > 

