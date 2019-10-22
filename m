Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412E6E0031
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 11:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbfJVJAb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 05:00:31 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:35503 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbfJVJAb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 05:00:31 -0400
Received: by mail-wr1-f46.google.com with SMTP id l10so16665281wrb.2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2019 02:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=jHHRF6bxKJ0vjoHyhXFTfWH+KjdLavHcfZIbKaMynZ0=;
        b=EvIBHrPc9wgs5PGSbJdtv4IJGi00Lup6ToiAwtU5iNxRSHDAWasNhteazzX2/WVR0p
         4WkRyKTBhWYMkDTshTqq9s/mjhzIG0/OcuYzWCY+2et0AJdS6kbo/9VES8MUDyPxXTFK
         8VOz+gGvo5yGN8WdWlAkUIETJqGuEqiPluSxN5QvqhwAGDSrXZTI8mbn6a042d+W+694
         zC9fHxoAgddZhwS46gwJVCKTUOGm7+0jBHcay/wDh+XDRLI5Jlyyut45XIfWBXLzQntZ
         abyL31TjzXt6NJjk4WvDmgcnwMIo4kZ47+scU8NMbbmAk0OPcWcxt6lhWxS86ERnwd/V
         YLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jHHRF6bxKJ0vjoHyhXFTfWH+KjdLavHcfZIbKaMynZ0=;
        b=hR3w87g9Ha95aWOlpbtjuboXftAO+UbgWHtTTxXObW1Vkf6MdtodFECP1HaN0mwpmV
         AiPgAq18KEknR0G7m2Bv1/241SE95RARdTJ6KPIHDVgweBCGUilBS/l1C6PrlOtEZTvD
         ifU2m/hzsBMaklse1k23jI2ekn/Kh9f17up0MOd7860Mmq6WX2eaJBwtbnbbRYp24UGC
         JN1p+iDu4pgkfO9VxzvgxOrTlwQb2vwjQ58PaqBXDt5y0t3UKu3//4ITfNDD1XaiJ4du
         TyschD/CiSzorDW2cCWuNgpKNFsyD9Qy3kZW1hmUoJCUmn6Hhb5gtzBt8sqPhennRj0N
         e4QQ==
X-Gm-Message-State: APjAAAUs+yQ2xjHDcTKuuZkC2a4UPHbUxv80mw9Urrh5WdxusRuSDPnL
        ENGWk18NWRQUGPCwCD7Gmf6OrmIR+O3Njv9X29ePS23UPuXzdA==
X-Google-Smtp-Source: APXvYqzCIiHtU4LhiKgpjuGsB6+ja5W8b2A9XLF3bKLsCVKGKq73WEx06Jo0AZ8ep2DeejmPPVzOZC63HzeNCEEqKNs=
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr2430832wrw.167.1571734827054;
 Tue, 22 Oct 2019 02:00:27 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 22 Oct 2019 11:00:07 +0200
Message-ID: <CAJCQCtTPAm6eGA80y9LYc+Jaeo1wB0+vOMvO6B02o5JJKRFrhw@mail.gmail.com>
Subject: feature request, explicit mount and unmount kernel messages
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

So XFS has these

[49621.415203] XFS (loop0): Mounting V5 Filesystem
[49621.444458] XFS (loop0): Ending clean mount
...
[49621.444458] XFS (loop0): Ending clean mount
[49641.459463] XFS (loop0): Unmounting Filesystem

It seems to me linguistically those last two should be reversed, but whatever.

The Btrfs mount equivalent messages are:
[49896.176646] BTRFS: device fsid f7972e8c-b58a-4b95-9f03-1a08bbcb62a7
devid 1 transid 5 /dev/loop0
[49901.739591] BTRFS info (device loop0): disk space caching is enabled
[49901.739595] BTRFS info (device loop0): has skinny extents
[49901.767447] BTRFS info (device loop0): enabling ssd optimizations
[49901.767851] BTRFS info (device loop0): checking UUID tree

So is it true that for sure there is nothing happening after the UUID
tree is checked, that the file system is definitely mounted at this
point? And always it's the UUID tree being checked that's the last
thing that happens? Or is it actually already mounted just prior to
disk space caching enabled message, and the subsequent messages are
not at all related to the mount process? See? I can't tell.

For umount, zero messages at all.

The feature request is something like what XFS does, so that we know
exactly when the file system is mounted and unmounted as far as Btrfs
code is concerned.

I don't know that it needs the start and end of the mount and
unmounted (i.e. two messages). I'm mainly interested in having a
notification for "mount completed successfully" and "unmount completed
successfully". i.e. the end of each process, not the start of each.

In particular the unmount notice is somewhat important because as far
as I know there's no Btrfs dirty flag from which to infer whether it
was really unmounted cleanly. But I'm also not sure what the insertion
point for these messages would be. Looking at the mount code in
particular, it's a little complicated. And maybe with some of the
sanity checking and debug options it could get more complicated, and
wouldn't want to conflict with that - or any multiple device use case
either.


-- 
Chris Murphy
