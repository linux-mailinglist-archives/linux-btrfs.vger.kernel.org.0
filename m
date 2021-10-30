Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCDE440972
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Oct 2021 16:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhJ3OSv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Oct 2021 10:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhJ3OSv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Oct 2021 10:18:51 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DDEC061570
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Oct 2021 07:16:20 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HhLv52YL9zQjnB;
        Sat, 30 Oct 2021 16:16:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duxsco.de; s=MBO0001;
        t=1635603374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4yyacLR+V6kiYXBifbHvd4ncJCdW6mSeTtzk1z8YU4=;
        b=Xi0fOZj22lVUYJZnyFzZW3xrjLI6Mi0ZeZ7L3OA4JDqKjsEFKIj7dDtQ8xGsZ/yeANXq5K
        BS2DxKSd4n+v7nFIV0yPIYrqGOgaJ+GVr4afyK75FdLZAU+fjLPwN8aWRQYBTNr3dyR1dT
        moLW1poft71UcpeENYWSwUXeBQyTstkHsSohlaRZi6QonuBf/bqhQ79gg1uCzHc6QplIIs
        LMPZwU+DDs+yoUO8hSXMqXk2yWxarhFQZGIJBU8WYNJz+lANdPB/BkdbrinRO0ucJ6cHHD
        5Tw435nrJYlYy7pgd97npW3nRuq65XVeNKAh6AzilVhFjRwYgW1Gd3wfTfCa2g==
Message-ID: <8d2d6b96071b9f50c2a509c71a0eb34fd20b4349.camel@duxsco.de>
Subject: Re: Btrfs failing to make incremental backups
From:   David Sardari <d@duxsco.de>
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Date:   Sat, 30 Oct 2021 16:14:41 +0200
In-Reply-To: <3574af93-d40d-1502-3c8b-5c71c2ee1abd@gmail.com>
References: <58d81c70b2c7de2faa209b56ba18143b5bfb6e2a.camel@duxsco.de>
         <3574af93-d40d-1502-3c8b-5c71c2ee1abd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D6186881
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I understand. Next time I write everything in the mail body.

I deleted the snapshot on the destination side. So, I had to do again
just now resulting in same problem:

   btrfs send -p | \
       "${SRC}/@2021-10-30-095620_files" \
       "${DST}/@2021-10-30-100526_files" | \
       btrfs receive "${DST}/"; echo $status; sync
   At subvol /mnt/backup/src/@00_snapshot_hourly/@2021-10-30-100526_files
   At snapshot @2021-10-30-100526_files
   0

The parent snapshot:

   bash-5.1# btrfs subvolume show "${SRC}/@2021-10-30-095620_files"
   WARNING: the subvolume is read-write and has received_uuid set,
   	 don't use it for incremental send. Please see section
   	 'SUBVOLUME FLAGS' in manual page btrfs-subvolume for
   	 further information.
   @00_snapshot_hourly/@2021-10-30-095620_files
   	Name: 			@2021-10-30-095620_files
   	UUID: 			c4914d2e-b1f7-134e-984f-bf686f8d919b
   	Parent UUID: 		537c7db2-05da-6546-9092-89f873d7276a
   	Received UUID: 		7eb8ade9-0234-474c-b3c6-
   3b439bb51aa4
   	Creation time: 		2021-10-30 11:56:20 +0200
   	Subvolume ID: 		5914
   	Generation: 		319458
   	Gen at creation: 	319458
   	Parent ID: 		5855
   	Top level ID: 		5855
   	Flags: 			readonly
   	Send transid: 		14924
   	Send time: 		2021-10-30 11:56:20 +0200
   	Receive transid: 	1276
   	Receive time: 		2020-10-30 23:44:11 +0100
   	Snapshot(s):

Snapshot that needs to be sent:

   bash-5.1# btrfs subvolume show "${SRC}/@2021-10-30-100526_files"
   WARNING: the subvolume is read-write and has received_uuid set,
   	 don't use it for incremental send. Please see section
   	 'SUBVOLUME FLAGS' in manual page btrfs-subvolume for
   	 further information.
   @00_snapshot_hourly/@2021-10-30-100526_files
   	Name: 			@2021-10-30-100526_files
   	UUID: 			74c54234-20b3-7d4c-9dd8-ebb919d2e876
   	Parent UUID: 		537c7db2-05da-6546-9092-89f873d7276a
   	Received UUID: 		7eb8ade9-0234-474c-b3c6-
   3b439bb51aa4
   	Creation time: 		2021-10-30 12:05:26 +0200
   	Subvolume ID: 		5920
   	Generation: 		319481
   	Gen at creation: 	319481
   	Parent ID: 		5855
   	Top level ID: 		5855
   	Flags: 			readonly
   	Send transid: 		14924
   	Send time: 		2021-10-30 12:05:26 +0200
   	Receive transid: 	1276
   	Receive time: 		2020-10-30 23:44:11 +0100
   	Snapshot(s):


Resulting snapshot on the destination side:

   bash-5.1# btrfs subvolume show "${DST}/@2021-10-30-100526_files"
   WARNING: the subvolume is read-write and has received_uuid set,
   	 don't use it for incremental send. Please see section
   	 'SUBVOLUME FLAGS' in manual page btrfs-subvolume for
   	 further information.
   @00_snapshot_hourly/@2021-10-30-100526_files
   	Name: 			@2021-10-30-100526_files
   	UUID: 			4a97faed-5852-e140-a6ec-4eaac6ab4863
   	Parent UUID: 		e04d86db-293a-cc44-a226-059677aa6e11
   	Received UUID: 		7eb8ade9-0234-474c-b3c6-
   3b439bb51aa4
   	Creation time: 		2021-10-30 15:54:32 +0200
   	Subvolume ID: 		3300
   	Generation: 		1146
   	Gen at creation: 	1146
   	Parent ID: 		1988
   	Top level ID: 		1988
   	Flags: 			readonly
   	Send transid: 		319434
   	Send time: 		2021-10-30 15:54:32 +0200
   	Receive transid: 	1147
   	Receive time: 		2021-10-30 15:54:32 +0200
   	Snapshot(s):

-- 
My GnuPG public key:
gpg --auto-key-locate clear,dane --locate-external-key d@duxsco.de



On Sat, 2021-10-30 at 16:38 +0300, Andrei Borzenkov wrote:
> This makes it impossible to comment on your description or logs inline.
> 
> Anyway, the usual primary suspect is duplicated received UUID. Show
> "btrfs subvolume show snapshot" on both source and destination systems
> for each involved snapshot.

