Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3D6440980
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Oct 2021 16:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhJ3OYk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Oct 2021 10:24:40 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152]:34808 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhJ3OYj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Oct 2021 10:24:39 -0400
X-Greylist: delayed 5456 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Oct 2021 10:24:39 EDT
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HhM1r1gKXzQjkX;
        Sat, 30 Oct 2021 16:22:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duxsco.de; s=MBO0001;
        t=1635603726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMYraPv3l8oly8VfVXktdsXNnPm/7Ky+r8qu44V97oA=;
        b=EZpQmpuvNgo0QioFFFN5EpsvalyarRj71SJZITrHTip4hMx/iVTwwDzxO/uQ336Bh5yZOb
        Wqlr5D0Gtt+a9oxwGjsp7+/Y2tIiVgYpwup3In1RumQLaqeCQlar5hJJS9L6Q0DKDnaVoj
        yBewkrpGuML/iKvu9Fz6szk/i4FnnPkmZLf9bMw1U/6KwhmR7ojsLBupbUIPDMEwpnLjss
        TydzmF9MkWrRqIKCV8s9fxFo+KWTpFvEtzdPQVAh/Fdhb6X6ARCK7S9bbbMQGPFN5Kq3Um
        KeeTbdb4J6l39t/QEccm715ZUIfUiErN4R4y1c4sKUimLuS3uQu6k5lljEgtqg==
Message-ID: <9eefd0b24436350452e993dce3cf02c4f6284b71.camel@duxsco.de>
Subject: Re: Btrfs failing to make incremental backups
From:   David Sardari <d@duxsco.de>
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Date:   Sat, 30 Oct 2021 16:20:33 +0200
In-Reply-To: <8d2d6b96071b9f50c2a509c71a0eb34fd20b4349.camel@duxsco.de>
References: <58d81c70b2c7de2faa209b56ba18143b5bfb6e2a.camel@duxsco.de>
         <3574af93-d40d-1502-3c8b-5c71c2ee1abd@gmail.com>
         <8d2d6b96071b9f50c2a509c71a0eb34fd20b4349.camel@duxsco.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 41C78710
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here is what the corresponding parent snapshot looks like on the
destination side:

bash-5.1# btrfs subvolume show "${DST}/@2021-10-30-095620_files"
WARNING: the subvolume is read-write and has received_uuid set,
	 don't use it for incremental send. Please see section
	 'SUBVOLUME FLAGS' in manual page btrfs-subvolume for
	 further information.
@00_snapshot_hourly/@2021-10-30-095620_files
	Name: 			@2021-10-30-095620_files
	UUID: 			59c8e5fb-f3f7-d448-9da9-e2af0cc5b0d8
	Parent UUID: 		e04d86db-293a-cc44-a226-059677aa6e11
	Received UUID: 		7eb8ade9-0234-474c-b3c6-
3b439bb51aa4
	Creation time: 		2021-10-30 11:56:27 +0200
	Subvolume ID: 		3275
	Generation: 		1048
	Gen at creation: 	1045
	Parent ID: 		1988
	Top level ID: 		1988
	Flags: 			readonly
	Send transid: 		319434
	Send time: 		2021-10-30 11:56:27 +0200
	Receive transid: 	1046
	Receive time: 		2021-10-30 11:56:27 +0200
	Snapshot(s):

-- 
My GnuPG public key:
gpg --auto-key-locate clear,dane --locate-external-key <MyMailAddress>




On Sat, 2021-10-30 at 16:14 +0200, David Sardari wrote:
> I understand. Next time I write everything in the mail body.
> 
> I deleted the snapshot on the destination side. So, I had to do again
> just now resulting in same problem:
> 
>    btrfs send -p | \
>        "${SRC}/@2021-10-30-095620_files" \
>        "${DST}/@2021-10-30-100526_files" | \
>        btrfs receive "${DST}/"; echo $status; sync
>    At subvol
> /mnt/backup/src/@00_snapshot_hourly/@2021-10-30-100526_files
>    At snapshot @2021-10-30-100526_files
>    0
> 
> The parent snapshot:
> 
>    bash-5.1# btrfs subvolume show "${SRC}/@2021-10-30-095620_files"
>    WARNING: the subvolume is read-write and has received_uuid set,
>          don't use it for incremental send. Please see section
>          'SUBVOLUME FLAGS' in manual page btrfs-subvolume for
>          further information.
>    @00_snapshot_hourly/@2021-10-30-095620_files
>         Name:                   @2021-10-30-095620_files
>         UUID:                   c4914d2e-b1f7-134e-984f-bf686f8d919b
>         Parent UUID:            537c7db2-05da-6546-9092-89f873d7276a
>         Received UUID:          7eb8ade9-0234-474c-b3c6-
>    3b439bb51aa4
>         Creation time:          2021-10-30 11:56:20 +0200
>         Subvolume ID:           5914
>         Generation:             319458
>         Gen at creation:        319458
>         Parent ID:              5855
>         Top level ID:           5855
>         Flags:                  readonly
>         Send transid:           14924
>         Send time:              2021-10-30 11:56:20 +0200
>         Receive transid:        1276
>         Receive time:           2020-10-30 23:44:11 +0100
>         Snapshot(s):
> 
> Snapshot that needs to be sent:
> 
>    bash-5.1# btrfs subvolume show "${SRC}/@2021-10-30-100526_files"
>    WARNING: the subvolume is read-write and has received_uuid set,
>          don't use it for incremental send. Please see section
>          'SUBVOLUME FLAGS' in manual page btrfs-subvolume for
>          further information.
>    @00_snapshot_hourly/@2021-10-30-100526_files
>         Name:                   @2021-10-30-100526_files
>         UUID:                   74c54234-20b3-7d4c-9dd8-ebb919d2e876
>         Parent UUID:            537c7db2-05da-6546-9092-89f873d7276a
>         Received UUID:          7eb8ade9-0234-474c-b3c6-
>    3b439bb51aa4
>         Creation time:          2021-10-30 12:05:26 +0200
>         Subvolume ID:           5920
>         Generation:             319481
>         Gen at creation:        319481
>         Parent ID:              5855
>         Top level ID:           5855
>         Flags:                  readonly
>         Send transid:           14924
>         Send time:              2021-10-30 12:05:26 +0200
>         Receive transid:        1276
>         Receive time:           2020-10-30 23:44:11 +0100
>         Snapshot(s):
> 
> 
> Resulting snapshot on the destination side:
> 
>    bash-5.1# btrfs subvolume show "${DST}/@2021-10-30-100526_files"
>    WARNING: the subvolume is read-write and has received_uuid set,
>          don't use it for incremental send. Please see section
>          'SUBVOLUME FLAGS' in manual page btrfs-subvolume for
>          further information.
>    @00_snapshot_hourly/@2021-10-30-100526_files
>         Name:                   @2021-10-30-100526_files
>         UUID:                   4a97faed-5852-e140-a6ec-4eaac6ab4863
>         Parent UUID:            e04d86db-293a-cc44-a226-059677aa6e11
>         Received UUID:          7eb8ade9-0234-474c-b3c6-
>    3b439bb51aa4
>         Creation time:          2021-10-30 15:54:32 +0200
>         Subvolume ID:           3300
>         Generation:             1146
>         Gen at creation:        1146
>         Parent ID:              1988
>         Top level ID:           1988
>         Flags:                  readonly
>         Send transid:           319434
>         Send time:              2021-10-30 15:54:32 +0200
>         Receive transid:        1147
>         Receive time:           2021-10-30 15:54:32 +0200
>         Snapshot(s):
> 

