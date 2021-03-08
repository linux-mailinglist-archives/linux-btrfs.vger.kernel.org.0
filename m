Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806703305F3
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 03:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhCHCsa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 21:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbhCHCsS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 21:48:18 -0500
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF71C06174A
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Mar 2021 18:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Kt7KZ+yK8Ac4BFT2L+E4a3MBNfFzM4U0hf1CM0AqDGQ=; b=HVt5DqWcR4GNfUWQdaOit+CpVU
        v9ns3qXYQfyQDB50+P8SmTikTpat/eXgDvpH3lZTFwiVm94C2K6Dne61QVCeqVXSQP9of1c61YDGz
        jIx/WwYKJxD1W0qgU7E5jpcW4SIPM6c9W17X8hlZc8WArnfi14vXNrxh/RZG1hW8WqhlA9vjV5wc/
        fEef+q1E0eg07C6rfEKAnpUDuZs8IKb+UAwiPCaca9oj0J3fy57dkuhiSRKmLdT8Em1QZjkn0RGd0
        qIkMOKz3VKTPBUGkoMinB73bXCX+qbT1y41WqNxZziH4kbs7SMFrdQ00pMF/ckvtjaTXdgYJRJxrY
        nicwDhuQ==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1lJ5wM-0007E9-6p; Mon, 08 Mar 2021 02:48:14 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id 37C5E14928145; Mon,  8 Mar 2021 11:48:11 +0900 (JST)
Date:   Mon, 8 Mar 2021 11:48:11 +0900
From:   Norbert Preining <norbert@preining.info>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: btrfs fails to mount on kernel 5.11.4 but works on 5.10.19
Message-ID: <YEWQa2TXhdSbyWlR@bulldog.preining.info>
References: <CAJCQCtTn_O8grH5OBHoDfN7OfEOq5WM2Ryxffb-Z=qhVn_PLTg@mail.gmail.com>
 <CAJCQCtSZGGVamOUGRFzPXBejTW9Hx-2EkYUSCXdN6qEY3snW2w@mail.gmail.com>
 <YEV+hDZcguma9Pqg@burischnitzel.preining.info>
 <YEWJbxhR53O0PqaP@burischnitzel.preining.info>
 <CAJCQCtRmQ115LStiWXp2ihe-v8bvM+mUirMkBYGgu9EzbWpXCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtRmQ115LStiWXp2ihe-v8bvM+mUirMkBYGgu9EzbWpXCw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Chris,

On Sun, 07 Mar 2021, Chris Murphy wrote:
> I suspect something is wrong with devid 9 in that case. If it's a
> dracut system, then it waits indefinitely for sysroot. You'll need to
> boot with something like rd.break=pre-mount and see first if you can
> mount normally to /sysroot, but if devid 9 is still missing then mount
> degraded and replace that device. Or otherwise find out why it's
> missing.

Ok, I will see what I can do. It isn't a dracut system, but
initramfs-tools AFAIS (not that I ever touched or decided anything in
this respect).

I will try to get to that state. (Only that USB devices seem to be hosed
in Debian's initramfs ... no kbd atm :-(

As said, it is just puzzling that 5.10.19 boots without a hinch and
without a warning, just running it now.

> I don't think the scrub helps right now, the issue is the device is

Ok, I have already killed it ;-)

Thanks a lot

Norbert

--
PREINING Norbert                              https://www.preining.info
Fujitsu Research Labs  +  IFMGA Guide + TU Wien + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
