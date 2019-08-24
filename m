Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 559E39BF11
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2019 19:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHXRwc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Aug 2019 13:52:32 -0400
Received: from mailgw-01.dd24.net ([193.46.215.41]:36316 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfHXRwc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Aug 2019 13:52:32 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Aug 2019 13:52:31 EDT
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-01.dd24.net (Postfix) with ESMTP id BED4A5FCF6
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Aug 2019 17:45:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id h_-N6hr0_W7Q for <linux-btrfs@vger.kernel.org>;
        Sat, 24 Aug 2019 17:44:59 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-46-244-240-50.dynamic.mnet-online.de [46.244.240.50])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Aug 2019 17:44:59 +0000 (UTC)
Message-ID: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-btrfs@vger.kernel.org
Date:   Sat, 24 Aug 2019 19:44:58 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

Anything new about the issue described here:
https://www.spinics.net/lists/linux-btrfs/msg91046.html

It was said that it might be a regression in 5.2 actually and not a
hardware thing... so I just wonder whether I can safely move to 5.2?


Cheers,
Chris.

