Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434CA35B6E7
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Apr 2021 22:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbhDKUsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Apr 2021 16:48:09 -0400
Received: from tartarus.angband.pl ([51.83.246.204]:50758 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDKUsI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Apr 2021 16:48:08 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94)
        (envelope-from <kilobyte@angband.pl>)
        id 1lVgvY-006wGA-Ru; Sun, 11 Apr 2021 22:43:28 +0200
Date:   Sun, 11 Apr 2021 22:43:28 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Paul Leiber <paul@onlineschubla.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Parent transid verify failed (and more): BTRFS for data storage
 in Xen VM setup
Message-ID: <YHNfcB9Au/yYh9Au@angband.pl>
References: <FRYP281MB058285E8F1BD4B521817F6CFB0729@FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM>
 <20210410194842.71f49059@natsu>
 <CAJCQCtRqaxE6k9JGK+xSF-onTcVTjageC4dWoPdD+RARMK652w@mail.gmail.com>
 <20210411121034.373468ac@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210411121034.373468ac@natsu>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 11, 2021 at 12:10:34PM +0500, Roman Mamedov wrote:
> On Sat, 10 Apr 2021 17:06:22 -0600
> Chris Murphy <lists@colorremedies.com> wrote:
> 
> > Right. The block device (partition containing the Btrfs file system)
> > must be exclusively used by one kernel, host or guest. Dom0 or DomU.
> > Can't be both.
> > 
> > The only exception I'm aware of is virtiofs or virtio-9p, but I
> > haven't messed with that stuff yet.
> 
> If you want an FS that allows a block device to be mounted by multiple machines
> at the same time, there are a few:
> https://en.wikipedia.org/wiki/Clustered_file_system#Shared-disk_file_system

All of those use some kind of lock manager, though.
So in no case you just mount the same device twice.

-- 
⢀⣴⠾⠻⢶⣦⠀ .--[ Makefile ]
⣾⠁⢠⠒⠀⣿⡁ # beware of races
⢿⡄⠘⠷⠚⠋⠀ all: pillage burn
⠈⠳⣄⠀⠀⠀⠀ `----
