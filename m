Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3ECDB0F98
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 15:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbfILNJy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 09:09:54 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:60546 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731786AbfILNJy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 09:09:54 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-02.dd24.net (Postfix) with ESMTP id 905935FD8B;
        Thu, 12 Sep 2019 13:09:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id Ti00DtwrCd58; Thu, 12 Sep 2019 13:09:50 +0000 (UTC)
Received: from gar-nb-etp23.garching.physik.uni-muenchen.de (unknown [141.84.41.131])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA;
        Thu, 12 Sep 2019 13:09:50 +0000 (UTC)
Message-ID: <ce6a9b8274f5af89d9378aa84e934ce3f3354acd.camel@scientia.net>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Thu, 12 Sep 2019 15:09:50 +0200
In-Reply-To: <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
         <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi.

First, thanks for finding&fixing this :-)


On Thu, 2019-09-12 at 08:50 +0100, Filipe Manana wrote:
> 1) either a hang when committing a transaction, reported by several
> users recently and hit it myself too twice when running fstests (test
> case generic/475 and generic/561) after I upgradaded my development
> branch from a 5.1.x kernel to a 5.3-rcX kernel. If this happens you
> risk no corruption, still the hang is very inconvenient of course, as
> you have to reboot.

Okay inconvenient, but not so bad if there is no corruption risk.


> 2) writeback for some btree nodes may never be started and we end up
> committing a transaction without noticing that. This is really
> serious
> and that will lead to the "parent transid verify failed on ..."
> messages.

As some people have already pointed out, it will be infeasible for many
end users to downgrade (no security updates) or manually patch (well,
end-users).

Can you elaborate under which circumstances this problem occurs,
whether there are any intermediate workarounds, and whether it's always
noticed (i.e. no silence corruption)?


Thanks,
Chris.

