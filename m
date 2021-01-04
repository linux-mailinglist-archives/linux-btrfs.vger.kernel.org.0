Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4B62E9F0A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 21:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbhADUw2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 4 Jan 2021 15:52:28 -0500
Received: from mail.eclipso.de ([217.69.254.104]:46574 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbhADUw1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Jan 2021 15:52:27 -0500
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 732E55DF
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Jan 2021 21:51:46 +0100 (CET)
Date:   Mon, 04 Jan 2021 21:51:46 +0100
MIME-Version: 1.0
Message-ID: <dc1e528567c9a57d089d77824f071af8@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <Cedric.dewijs@eclipso.eu>
Subject: synchronize btrfs snapshots over a unreliable, slow connection
Reply-To: " " <Cedric.dewijs@eclipso.eu>
To:     <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

­I have a master NAS that makes one read only snapshot of my data per day. I want to transfer these snapshots to a slave NAS over a slow, unreliable internet connection. (it's a cheap provider). This rules out a "btrfs send -> ssh -> btrfs receive" construction, as that can't be resumed.

Therefore I want to use rsync to synchronize the snapshots on the master NAS to the slave NAS.

My thirst thought is something like this:
1) create a read-only snapshot on the master NAS:
btrfs subvolume snapshot -r /mnt/nas/storage /mnt/nas/storage_snapshots/storage-$(date +%Y_%m_%d-%H%m)
2) send that data to the slave NAS like this:
rsync --partial -var --compress --bwlimit=500KB -e "ssh -i ~/slave-nas.key" /mnt/nas/storage_snapshots/storage-$(date +%Y_%m_%d-%H%m) cedric@123.123.123.123/nas/storage
3) Restart rsync until all data is copied (by checking the error code of rsync, is it's 0 then all data has been transferred)
4) Create the read-only snapshot on the slave NAS with the same name as in step 1.

Does somebody already has a script that does this?
Is there a problem with this approach that I have not yet considered?­

---

Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!


