Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23DB19B6C5
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 22:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbgDAUPc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 1 Apr 2020 16:15:32 -0400
Received: from mailgw-01.dd24.net ([193.46.215.41]:47158 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgDAUPc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Apr 2020 16:15:32 -0400
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Apr 2020 16:15:31 EDT
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-01.dd24.net (Postfix) with ESMTP id 88D4E60305
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Apr 2020 20:06:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id KEn8bu31hwj9 for <linux-btrfs@vger.kernel.org>;
        Wed,  1 Apr 2020 20:06:46 +0000 (UTC)
Received: from galois.fritz.box (ppp-46-244-252-139.dynamic.mnet-online.de [46.244.252.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Apr 2020 20:06:46 +0000 (UTC)
Date:   Wed, 01 Apr 2020 22:06:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Btrfs transid corruption
To:     linux-btrfs@vger.kernel.org
From:   Christoph Anton Mitterer <calestyo@scientia.net>
Message-ID: <800B6BF0-64AA-45F5-A539-9D2868C2835C@scientia.net>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Seems my mails didn't get though,... Maybe because of the attachments.


Hey.

Can only write via smartphone...

My notebook, running 5.5.13 froze... After forced power off I did a reboot from rescue USB stick with fsck... no errors found.

After booting into the normal system I get the errors attached as screenshots.


mount -o ro,recovery fails, too.

Any idea how to recover? Is this a serious corruption (and should I thus recreate the filesystem from scratch..or just a minor glitch? )

Thanks,
Chris

Screenshots here
https://drive.google.com/folderview?id=1pWUh80CIefXUguqv6UklEBrVv5QSpNkp
