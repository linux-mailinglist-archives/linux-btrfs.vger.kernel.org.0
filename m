Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB4CD30D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 20:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfJJSr6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 14:47:58 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:45404 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfJJSr6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 14:47:58 -0400
Received: by mail-io1-f53.google.com with SMTP id c25so15962866iot.12
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=R2SR4Dm6fPGqC37AffP5celux5s6Gh0yaQhhsaL+VZs=;
        b=GmMpPCqoXv9iChnaky1SS1zj3SubxM32zzWk2bYdwCQ2SYOyERS5eM7hDCfrB3QGbC
         KPgWaQCYLOJhoS+ZK6kincxOEAcHUFXcIicJg6rnm3wrzcrTof59C8a8GIVmiX68KxtY
         3Zp2MmZSSf0P6XUkx+8SyoD13hbkPYTfbXIfSAT79P2wHODcLyDqdDcRbSlXU5aUTDOC
         SwTNO4vNxgbfurcREWolWn5kg1i5ahONnV/PrcKi3euS5gdkvIWBLSejLEfumkaEkDiG
         BxEuNUE7lt7cPEUFsfJ0G1dOj0DzvQ0D2W5G8f4LpE3RGnG269vOrRzOXmVAMQZJy6lt
         Ptog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=R2SR4Dm6fPGqC37AffP5celux5s6Gh0yaQhhsaL+VZs=;
        b=Gi0qezl+JxOrQysxO2broF3IOYKrqUUCLb5oRD5niUJWNT6lOSd1W0wA7pCJVO3svo
         t1lmFWA+DFPTOSzXu8on6ta6bdbMPGzGNxuC2zlmgFFZ36vVRGJ1ZGqM1EqsPzk9Pwtw
         QDtxhM93bVX0DrzY30Q9SOzSQJk+BmJGYHDPO/zsdWNofNht8SvsWFXWV1qXDzYESEww
         iF9ee5D3LBB5AF85C6aYw+TNb+HDKrcAfmcOxz9glVVa1DBm0OWtduXjPz0/zg5S5PF+
         C8pUqpv/fMWdSa8qcDkMRmADEXLpV3MnENgdyc2oWpjoa2bCazHmnjig6KC251z3ivW+
         G1uQ==
X-Gm-Message-State: APjAAAWDUtmleBR2yIRR0ZGkNx9RYaG48nn9ZHdTBGJeTGBtBAIhU7HM
        jB9FIBPgKbYgEF5gpg0zD4jr5xUjtcw0IsgbFie+8llu
X-Google-Smtp-Source: APXvYqz/ECx/gg/R1exrVRBlPTn1u4SdXULc5RvG7iTZNiBRPPSk5OgdSKhj4DDOYkJImOEfu2MQc0/vWSpwkeMu+gQ=
X-Received: by 2002:a6b:7417:: with SMTP id s23mr667712iog.221.1570733275220;
 Thu, 10 Oct 2019 11:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191010172011.GA3392@tik.uni-stuttgart.de>
In-Reply-To: <20191010172011.GA3392@tik.uni-stuttgart.de>
From:   Kai Krakow <hurikhan77+btrfs@gmail.com>
Date:   Thu, 10 Oct 2019 20:47:29 +0200
Message-ID: <CAMthOuMV7MgB4b87RsijYr9e0UsjMUDNk+QRXeauFdb3cZcTjw@mail.gmail.com>
Subject: Re: rsync -ax and subvolumes
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

Am Do., 10. Okt. 2019 um 19:32 Uhr schrieb Ulli Horlacher
<framstag@rus.uni-stuttgart.de>:
>
> I run into the problem that "rsync -ax" sees btrfs subvolumes as "other
> filesystems" and ignores them.

I worked around it by mounting the btrfs-pool at a special directory:

mount -o subvolid=0 /dev/disk/by-label/rootfs /mnt/btrfs-pool

Then run rsync from /mnt/btrfs-pool without the "-x" flag. It won't
see mount points with foreign filesystems anyway below that mount
point.

> How could I tell rsync to include btrfs subvolumes, but exclude
> other mounted filesystems?

You can't, btrfs subvolumes are distinctive filesystems when viewed
from the API: they have their own set of inodes and thus their own
dev-id (and when that changes between two directories, you're crossing
a filesystem boundary).

> Do I have to write a rsync wrapper script and find all subvolumes to have
> them included? Nasty task...

The trick above should do, as long as you don't mind seeing another
view of your btrfs-pool opposed to your root mount view. It has the
benefit of seeing all your stuff. And it has the benefit of no longer
seeing API mounts there (like proc, sys, dev) and you can should rsync
without any more excludes needed.

Actually, you could also just bind-mount into /mnt/btrfs, bind-mounts
won't inherit other mounts but will still see pure subvolumes.

HTH
Kai
