Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D37935D151
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Apr 2021 21:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbhDLTo3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Apr 2021 15:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245366AbhDLToW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Apr 2021 15:44:22 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB72DC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Apr 2021 12:44:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id f15so5914991iob.5
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Apr 2021 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=az/xHUmhrFCMd+/OYvp1Rygkl2Cdw+yqNFZTB6GHfmk=;
        b=KJosjI2+T6FDysRrfgkkRmwZjeIERztEyJQ2XKcLMWy46SdU2FRkbvuGsPuxgy/2FZ
         BAaiWxxFQ8hvF/VdDIoYwEdgVdPbZIrrrr0AOoJNqM2ungKZ+kbw55/g8esR47Lvvl9p
         CuG7QDwbQkysxIP6Sh1P1bbaSnBXF1p5UTZGtMgDQCVZOMQxzFCGsqIJD8LwiDP2ArgE
         o4N9Cm7UcN3akAhh4rMc2jxlw3GrPdIzhMfGMh/ha1aXDeOsso37SbkzPw4nAv3rqAWg
         7vtWSJtHoeVO+8emfHVIGZHzGPdQyVFNQKasrO5O1baRJEIWtrRvvHwCBivx8m1TZo5w
         1u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=az/xHUmhrFCMd+/OYvp1Rygkl2Cdw+yqNFZTB6GHfmk=;
        b=ArhdZYeknD+gpNl3nhPU8SGz6YWYxeqlJ/BitPUlOQgtmwywz1fsRoOrfkZzdZ7Sb/
         QdFzM11OfcSVYdfLew6Briex/pOdZjxTk8S8V0r93l53D0rTOyflsx39Y7lmM80hjMQL
         HmnEnjhVja72C/hzJ2Vzo7HeXKapB0U3aa0M/F+1T9Yad48e4mQI4sabsOianlCJpfwo
         xZwDQTrzSD4ouALtrNgCxOqSe68k8EvcN0z+Kw22SAZlUaNEPwTA2843K6J2jwrlMVmM
         jLogeGbPP21DASdWVLYo004hGqcWfuT1dvEH2ePxvviqSnj2fF3W0rT/SuhmQLr8vrvY
         W4Vw==
X-Gm-Message-State: AOAM532l22ErEofB+OAak5ee/4kB4dGk6Y8lYTEDsRBfzbW6/Udhpapd
        KnwkjvjckOqELJSO6qUkGKOsnHXbI9l4mygJA5/ZzV0JWD8=
X-Google-Smtp-Source: ABdhPJy6/csoEIBzaR2AGiVr7VArLvWD8AvJSQ14AuuvftZhXdpJ/VkcdyIra8Tx1Z6+b9OAUr2LWSlklWRbJ5Bg7EM=
X-Received: by 2002:a02:3304:: with SMTP id c4mr30160394jae.68.1618256643204;
 Mon, 12 Apr 2021 12:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPbOkdp781Ydnj0VYSw1z3SB52H-7JQ98_YhEMZdn5jb4wockg@mail.gmail.com>
In-Reply-To: <CAPbOkdp781Ydnj0VYSw1z3SB52H-7JQ98_YhEMZdn5jb4wockg@mail.gmail.com>
From:   =?UTF-8?Q?Henrik_Nordstr=C3=B6m?= <squidhenrik@gmail.com>
Date:   Mon, 12 Apr 2021 21:43:52 +0200
Message-ID: <CAPbOkdqoagZn-URn83Sp_zEWofo641Hj5Daas-B1Bcq534n3eg@mail.gmail.com>
Subject: tree-checker read time error, unable to mount
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have an btrfs filesystem which have crashed and fails to mount. The
filesystem is on an extrenal SSD and it is quite possible it got
disconnected badly or had an unclean shutdown due to suspend issues.

[  447.321770] BTRFS critical (device sdc3): corrupt leaf: root=256
block=2036170752 slot=1 ino=806641, invalid inode transid: has 77966
expect [0, 77889]
[  447.321775
] BTRFS error (device sdc3): block=2036170752 read time tree block
corruption detected
[  447.321797] BTRFS error (device sdc3): failed to read block groups: -5
[  447.322328] BTRFS error (device sdc3): open_ctree failed

Host used for analyzing the disk (Fedora 33):

[root@localhost ~]# uname -r
5.11.7-200.fc33.x86_64
[root@localhost ~]# rpm -q btrfs-progs
btrfs-progs-5.10-1.fc33.x86_64

Mounting read-only also fails with the same error.

Not 100% sure which kernel was used to write to the disk when it
failed, but it's fairly recent, Fedora 34 beta. The OS that was used
is on the disk.

Data is not critical, but there is some files we like to recover if possible.

btrfs-image also fails with similar error

[root@localhost henrik_n]# btrfs-image /dev/sdc3 fedora34-beta.btrfsimage
parent transid verify failed on 2036170752 wanted 63722 found 77966
parent transid verify failed on 2036170752 wanted 63722 found 77966
Ignoring transid failure
leaf parent key incorrect 2036170752
ERROR: failed to read block groups: Operation not permitted
ERROR: open ctree failed
ERROR: create failed: -5

No difference with the -w option.

btrfs-restore do find some roots

[root@localhost henrik_n]# btrfs restore -l /dev/sdc3
 tree key (EXTENT_TREE ROOT_ITEM 0) 2056372224 level 2
 tree key (DEV_TREE ROOT_ITEM 0) 1974648832 level 0
 tree key (FS_TREE ROOT_ITEM 0) 5275648 level 0
 tree key (CSUM_TREE ROOT_ITEM 0) 2044133376 level 2
 tree key (UUID_TREE ROOT_ITEM 0) 1096368128 level 0
 tree key (256 ROOT_ITEM 0) 2043953152 level 2
 tree key (257 ROOT_ITEM 0) 2012250112 level 2
 tree key (262 ROOT_ITEM 0) 1637449728 level 0
 tree key (DATA_RELOC_TREE ROOT_ITEM 0) 5390336 level 0

btrfs-restore is quite upset as well, and only finds a handful files.

Regards

Henrik
