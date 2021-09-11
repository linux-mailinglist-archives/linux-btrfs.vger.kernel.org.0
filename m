Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE250407A99
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Sep 2021 00:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhIKWDI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 11 Sep 2021 18:03:08 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:60536 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhIKWDG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Sep 2021 18:03:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 3CA2C3F4CF;
        Sun, 12 Sep 2021 00:01:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RdJ7Klec9MBX; Sun, 12 Sep 2021 00:01:51 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 5087E3F29C;
        Sun, 12 Sep 2021 00:01:51 +0200 (CEST)
Received: from [192.168.0.126] (port=56432)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mPB4H-0007nY-FX; Sun, 12 Sep 2021 00:01:49 +0200
Date:   Sun, 12 Sep 2021 00:01:49 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Dave T <davestechshop@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <f041b06.ddfa8457.17bd6e185d0@tnonline.net>
In-Reply-To: <CAGdWbB57aE9fmuS3ZU1oBxK3Gqd+7YMRL2oGYzwhvT3=s=45MQ@mail.gmail.com>
References: <CAGdWbB5i2QumFah3aCxC7Zwg1TPGMS-_7nsPxeuJu+JZ-bGYew@mail.gmail.com> <CAGdWbB57aE9fmuS3ZU1oBxK3Gqd+7YMRL2oGYzwhvT3=s=45MQ@mail.gmail.com>
Subject: Re: seeking advice for a backup server (accepting btrfs receive
 streams via SSH)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Dave T <davestechshop@gmail.com> -- Sent: 2021-09-11 - 22:41 ----

> Hello. I have a server on a LAN that will act as a backup target for
> clients that use btrbk to send snapshots via SSH.
> 
> After my initial attempt, the backup server became extremely slow. I
> don't know the cause yet, and I'm starting to investigate.
> 
> The first thing I would like to know from this group is whether there
> are special considerations for configuring or managing a server that
> will receive many btrfs snapshots from other devices.
> 
> For example, do the general rules about limiting the number of
> snapshots on a volume still apply in this case?
> 
> Thanks for any input.


It's hard to say much without more detailed information about your set up, such as hardware configuration, filesystem setup, etc. What do you consider slow?

Some pointers to look at may be
* deleting snapshots can cause increased I/O.
* atimes can affect snapshots as they mean cow of metadata. Mount as noatime.
* exclude snapshots from mlocate/updatedb and other indexing services. I forgot once and ended up with several gb database... :D
* space_cache=v2 can be helpful, but it increases metadata usage a little.
* monitor disk usage allocation with 'btrfs filesystem usage /mnt'

Good luck. 

