Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4032F06BA
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jan 2021 12:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbhAJLs3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Jan 2021 06:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbhAJLs3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 06:48:29 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39B8C061786
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Jan 2021 03:47:48 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1kyZCA-0008LW-A4; Sun, 10 Jan 2021 11:47:42 +0000
Date:   Sun, 10 Jan 2021 11:47:42 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     <Cedric.dewijs@eclipso.eu>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs send / receive via netcat, fails halfway?
Message-ID: <20210110114742.GB3686@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
          <Cedric.dewijs@eclipso.eu>, linux-btrfs@vger.kernel.org
References: <0440549b7c78763ce787b03341ca5b9f@mail.eclipso.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0440549b7c78763ce787b03341ca5b9f@mail.eclipso.de>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 10, 2021 at 11:34:27AM +0100,   wrote:
> ­I'm trying to transfer a btrfs snapshot via the network.
> 
> First attempt: Both NC programs don't exit after the transfer is complete. When I ctrl-C the sending side, the receiving side exits OK.
> 
> btrfs subvolume delete /mnt/rec/snapshots/*
> receive side:
> # nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
> At subvol 0
> 
> sending side:
> # btrfs send  /mnt/send/snapshots/0 | nc -v 127.0.0.1 6790
> At subvol /mnt/send/snapshots/0
> localhost [127.0.0.1] 6790 (hnmp) open

   Use -q 15 on the sending side. That will exit after 15 seconds of
no activity from the send process.

> Second attempt: both nc programs exit ok at snapshot 0,1,2, but snapshot3 fails halfway, and 4 fails, as 3 is not complete. 
> receive side:
> # nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
> At subvol 0
> # nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
> At snapshot 1
> # nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
> At snapshot 2
> # nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
> At snapshot 3
> read(net): Connection reset by peer
> ERROR: short read from stream: expected 49183 read 10450

   This failed because of a network disconnect.

> # nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
> At snapshot 4
> ERROR: cannot find parent subvolume
> write(stdout): Broken pipe

   This is expected because the previous one failed.

   There's no btrfs problem here. You just need better error handling
(to retry a failed transfer, for example).

   Hugo.

-- 
Hugo Mills             | How do you become King? You stand in the marketplace
hugo@... carfax.org.uk | and announce you're going to tax everyone. If you
http://carfax.org.uk/  | get out alive, you're King.
PGP: E2AB1DE4          |                                        Harry Harrison
