Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CD52E8402
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Jan 2021 15:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbhAAOnC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 1 Jan 2021 09:43:02 -0500
Received: from mail.eclipso.de ([217.69.254.104]:51398 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbhAAOnB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Jan 2021 09:43:01 -0500
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 4FCBCEF7
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Jan 2021 15:42:16 +0100 (CET)
Date:   Fri, 01 Jan 2021 15:42:16 +0100
MIME-Version: 1.0
Message-ID: <cf2aa5f977e099ba237eb1e9b1fa4fe8@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <Cedric.dewijs@eclipso.eu>
Subject: synchronize a btrfs snapshot via network with resume support?
Reply-To: " " <Cedric.dewijs@eclipso.eu>
To:     <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

­I have 2 PC's, one called master, and one called slave. On the master, I have a btrfs filesystem with real-only snapshots that are made daily. On the slave PC, I would like to create a btrfs filesystem with the exact same contents as the master. The two PC's are connected via internet, so interruptions in the connection are to be expected.

Btrfs send can convert the differences between 2 read only snapshots into a stream of instructions. This stream can then be send via ssh to a remote computer, and fed into btrfs receive, so that the snapshot is recreated at the remote computer.

The problem with this approach is that the transmission of the entire delta between two snapshots has to succeed in one go. If there's an interruption in the connection, the complete transmission has to be restarted. This is a problem if the delta between two snapshots is large, or if the connection is slow.

I'm looking for a program that can synchronize a btrfs snapshot via a network, and supports resuming of interrupted transfers.

Buttersink [1] claims it can do Resumable, checksummed multi-part uploads to S3 as a back-end, but not between two PC's via ssh.

Does anybody know a program that is capable of doing this?

---

Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!


