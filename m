Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CDB2B127F
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 00:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgKLXId (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 18:08:33 -0500
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:55970
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKLXId (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 18:08:33 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1kdLhf-0009s8-JP
        for linux-btrfs@vger.kernel.org; Fri, 13 Nov 2020 00:08:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-btrfs@vger.kernel.org
From:   Jean-Denis Girard <jd.girard@sysnux.pf>
Subject: Re: ERROR: could not setup extent tree
Date:   Thu, 12 Nov 2020 13:08:25 -1000
Message-ID: <rokf9a$sb0$1@ciao.gmane.io>
References: <roibjb$u1$1@ciao.gmane.io>
 <CAJCQCtS81a96whvBXzkWY3wv9qLbTWiyjP_=3pQTVMi1uAnJrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <CAJCQCtS81a96whvBXzkWY3wv9qLbTWiyjP_=3pQTVMi1uAnJrw@mail.gmail.com>
Content-Language: fr
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 12/11/2020 à 12:55, Chris Murphy a écrit :
> Hypothesis: The NVMe drive has had some kind of failure, and since
> this single NVMe is used as cache for both HDDs, in effect this
> thwarts the raid1 protection of Btrfs. i.e. you don't have complete
> hardware isolation by having dedicated SSD's to use as cache for each
> HDD. Something went wrong, and it's adversely affected the writes to
> both drives. Btrfs is reporting write errors for both bcache0 and
> bcache1 at the same time.

ok, it makes sense, so I made a mistake with this setup...

> I don't know for sure what the next step is, so my strong advice is to
> make no changes until the problem and path forward is well understood.
> The more things are changed at this point, the greater the likelihood
> of non-recovery. Importantly, I'd say whatever you do should be
> reversible, until you get superior advice.

I restored from backups on a different HDD, so the original setup has 
not been touched.

> You might consider reposting or cross-posting on the bcache list and
> see if they have some advice for recovery, or maybe it's safer to just
> decouple bcache, and once the HDDs are freed to see if Btrfs can
> recover on its own.

Good idea, I'll also post on bcache list.


Thanks for your reply Chris!

Best regards,
-- 
Jean-Denis Girard

SysNux                   Systèmes   Linux   en   Polynésie  française
https://www.sysnux.pf/   Tél: +689 40.50.10.40 / GSM: +689 87.797.527

