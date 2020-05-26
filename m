Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CB11E19B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 May 2020 05:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbgEZDBR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 23:01:17 -0400
Received: from sefru.de ([176.9.70.71]:59288 "EHLO sefru.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388439AbgEZDBR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 23:01:17 -0400
X-Greylist: delayed 1008 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2020 23:01:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bxx5.de;
        s=dkim2016; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xfPXHiRygPBWbO12tgoISQv4XctGOlHyVjD/QguDJqI=; b=IrzB60W6eODmFZFERrTbLdFy9/
        6FxrLglxGzDmFXRHJ9TQzCj+DyxOzUT+NfTuk6H0N1Rji1zHLWMLp2BdLEKT2v4sGpIm8o7eQ+h/U
        N6selqkWZ4//vuW96cBV12lXZ8SfsiiXNItn+lu+8TO8YZUASXlUcX1ZETd9SHxix+v3wJnCFC0El
        qz9W6KeVIHS7geS8jrGbXDGNaadMfYaN+UM6lfcJ+9Xcw2Apg8LgKB1syYGhKnexb1d9I8yNN19vO
        uPWS4oVprzIYqySTyhytEAmX8A6XNMzyxVYS9yDatV/23zJOO/3iSSVnwfxUTqf3lj50Vde5Rusi7
        vJRTq1ZA==;
From:   Michael Thomas <mt@bxx5.de>
Subject: Any news about rescue data from a raid5 in the last years?
To:     linux-btrfs@vger.kernel.org
Message-ID: <41c53dd1-b553-bc2e-115d-b227f97c43c2@merkens.info>
Date:   Tue, 26 May 2020 04:44:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey,

I just wanted to ask if it's maybe possible to restore data from an old, 
failed, raid5 btrfs fs. There are some files on it which I lost lately 
and before I format the drives I wanted to give it another shot after 
some (6?) years.
I'm not sure what I tried before, but there are 3 drives there, was 4 
before but 1 died (and this seems to be the problem of the disaster).
I tried to add 1 new, but that didn't worked.
So, there are 3 devices and as far as I understand, there are still no 
good tools to rescue data from them, are they? btrfs restore and other 
seems only compatible with 1 drive.

But maybe someone can give me a hint what I can try before giving up.

If I try to mount:
mount -o 
degraded,subvol=data,ro,device=/dev/mapper/sdb,device=/dev/mapper/sdd,device=/dev/mapper/sde 
/dev/mapper/sde /mnt/test

dmesg give this errors:
BTRFS warning (device dm-4): suspicious: generation < 
chunk_root_generation: 176279 < 176413
BTRFS info (device dm-4): allowing degraded mounts
BTRFS info (device dm-4): disk space caching is enabled
BTRFS warning (device dm-4): devid 4 uuid 
16490fb1-df5e-4c81-9c07-4f799d0fc132 is missing
BTRFS warning (device dm-4): devid 5 uuid 
36436209-c0d4-4a5e-9176-d44c94cb4b39 is missing
BTRFS critical (device dm-4): corrupt leaf: block=1095416938496 slot=151 
extent bytenr=1095389085696 len=16384 invalid generation, have 176581 
expect (0, 176280]
BTRFS error (device dm-4): block=1095416938496 read time tree block 
corruption detected
BTRFS critical (device dm-4): corrupt leaf: block=1095416938496 slot=151 
extent bytenr=1095389085696 len=16384 invalid generation, have 176581 
expect (0, 176280]
BTRFS error (device dm-4): block=1095416938496 read time tree block 
corruption detected
BTRFS warning (device dm-4): failed to read root (objectid=4): -5
BTRFS error (device dm-4): open_ctree failed

(usebackuproot changed nothing and super-recover prints "All supers are 
valid, no need to recover")

Do you have any hint, advice to get (some of) this data back?


Best,
Michael
