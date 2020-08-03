Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56AB23A077
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 09:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgHCHrt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 03:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCHrs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Aug 2020 03:47:48 -0400
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA144C06174A
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Aug 2020 00:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4g5nMoWh5s0VXRfXHELzAL8yum2edVO/swpF7fIEIrQ=; b=mrC/5FiZF8Lz2nsbK4gLadHcz1
        oVDzs/kCDtgVne98Vrf8r6LZtkqGGEpKQk/zxMx4HsRvtp8uj72EJbuoo89E40M2b6VHoisSWkA+A
        /9RxiY1KijUPhHJoswTjxgQvm+cDrd9UgME7A3C08r6IivhzO8q9ph0dnvTdcKHUka/WA/4iaMOrq
        C+QN67w6Ei2t4/MOHOaH6rux70cUWKXdxn4pPds46w61vgAnhZhcPJgBy64zgURHA1z+frSpj7SOc
        Ivc/9mfTwO8SGa3ljscYTHU53cwCZLWNc07lGRMgQeWUo/9/3W67SOF3SRHKllQwb6rXI/zfK4XfI
        k+zgayGQ==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=burischnitzel.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1k2VCC-0006lg-Em
        for linux-btrfs@vger.kernel.org; Mon, 03 Aug 2020 07:47:44 +0000
Received: by burischnitzel.preining.info (Postfix, from userid 1000)
        id A00AB983AF4E; Mon,  3 Aug 2020 16:47:41 +0900 (JST)
Date:   Mon, 3 Aug 2020 16:47:41 +0900
From:   Norbert Preining <norbert@preining.info>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: replacing a disk in a btrfs multi disk array with raid10
Message-ID: <20200803074741.GB24782@burischnitzel.preining.info>
References: <20200803052651.GA685777@bulldog.preining.info>
 <CAJCQCtSeZCVpnxeip6D1nRb-nuvTYyJdY2SFWeDUQMV0BnAbyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtSeZCVpnxeip6D1nRb-nuvTYyJdY2SFWeDUQMV0BnAbyw@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Chris,

thanks for your answer, that is very much appreciated.

On Mon, 03 Aug 2020, Chris Murphy wrote:
> Some of these are considered normal. I suggest making sure each
> https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

Thanks, will read up on that.

> Once you've done that, do a btrfs scrub.

Happening regularly, but I will kick one off anyway.

> btrfs replace will work whether the drive is present or not. It's just
> safer to do it with the drive present because you don't have to mount
> degraded.

Ok.

I wasn't sure about whether I can mount without -o degraded because all
the metadata and data is on raid1. And then, I don't know what the
Debian initramfs is doing - that is probably the more interesting
surprise.

> > - add the new device
> 
> Use 'btrfs replace'

Thanks, noted.

> Currently 'btrfs replace' does require a separate resize step. 'device
> add' doesn't, resize is implied by the command.

This is somehow a logic approach, I agree.

> > - start a new rebalancing
> >         (for the rebalance, do I need to give the
> >         same -dconvert=raid1 -mconvert=raid1 arguments?)
> 
> Not necessary. But it's worth checking 'btrfs fi us -T' and making
> sure everything is raid1 as you expect.

Thanks, good to know.


Again, thanks a lot for all the details - I couldn't deduce most of them
from the wiki page on multiple devices. Your email is extremely helpful!

All the best

Norbert

--
PREINING Norbert                              https://www.preining.info
Accelia Inc. + IFMGA ProGuide + TU Wien + JAIST + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
