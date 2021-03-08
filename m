Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE533305DA
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 03:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhCHCSv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 21:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhCHCSa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 21:18:30 -0500
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0795C06174A
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Mar 2021 18:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IpBYl6FIhtz6JUQBIq59Fugl9ALY48EjQguu2teXgB0=; b=T+SEcj4xZzYCpsmoVjdsYoSQhP
        m080KzcMHVRFGtC56TDt+DPo1RBYZvhh53idinzvW9NP8OMYbYIPH4HBHa75ibI+5bJ66vlcAd3bd
        rK14+9gtfCn6psSq4TmxkTD2Lav3PKliEmJO0m4Qq2EhWRR9wxJIfe8RknvJujwBW2etPMQ4xaWPc
        NlkKGI8CFQ/2Ke21WYe11i+U4JP9d2FbgXplXQITtEsjJP1jj/simQZJKPe9fpqqe/e2jzzdBPA8b
        Gt/Z2l4ufVWJH7mDLAp46tHZoEY+/8f+TFWfFRzMnZSQaljaYM5D63qaBbIt/ox28mDXW5mUW0jb+
        Xo+SabyQ==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=burischnitzel.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1lJ5TW-0006NB-Ps; Mon, 08 Mar 2021 02:18:27 +0000
Received: by burischnitzel.preining.info (Postfix, from userid 1000)
        id 7A358B38C31D; Mon,  8 Mar 2021 11:18:23 +0900 (JST)
Date:   Mon, 8 Mar 2021 11:18:23 +0900
From:   Norbert Preining <norbert@preining.info>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: btrfs fails to mount on kernel 5.11.4 but works on 5.10.19
Message-ID: <YEWJbxhR53O0PqaP@burischnitzel.preining.info>
References: <CAJCQCtTn_O8grH5OBHoDfN7OfEOq5WM2Ryxffb-Z=qhVn_PLTg@mail.gmail.com>
 <CAJCQCtSZGGVamOUGRFzPXBejTW9Hx-2EkYUSCXdN6qEY3snW2w@mail.gmail.com>
 <YEV+hDZcguma9Pqg@burischnitzel.preining.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEV+hDZcguma9Pqg@burischnitzel.preining.info>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Chris,

once more ..

> > Does the initrd on this system contain?
> >   /usr/lib/udev/rules.d/64-btrfs.rules

No, it didn't.

Now I added it, and with 64-btrfs.rules available in the initrd I still
get the same error (see previous screenshot) :-(

Best

Norbert

--
PREINING Norbert                              https://www.preining.info
Fujitsu Research Labs  +  IFMGA Guide + TU Wien + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
