Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626F933068A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 04:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhCHDvL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 22:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhCHDu5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 22:50:57 -0500
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB74C06174A
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Mar 2021 19:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SaAWy6LpnQRw+r1E1TKMQZ5vc/f7VzXCFvfXiFrc9to=; b=E0eandvKeoctrBwJ4ygOPiyhd8
        P7q69UMmzdjZRhBLeHLb51xseEsU0bW9d4Lr4R4Ol4vKkEQtC4UXrXgIoqajbdchQ+6ZM1cM03DGP
        0spz6l3fZRHmgDiPLUucCA3Sdh6XsIcSqsWfDEapQd8MWHtSLY0riKkt7bW8Ia5T+GlmohO5e1tSL
        TYf/2c7H1x0JkBWp4sCkTsWdV2kqwqDYbgheeckFQ4eK/br9MK1dzxzCRFBh4zMUU8KE2GyT4KQhU
        U8HLhhNJr/rr6KE7+ZSFDlxPYPahrPqOLQrvD0Jd9Afb+9XsxC/8NdTLUT1cAlugYvmLpNNkUkzf+
        vRpqsGnw==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1lJ6uu-0000we-HL; Mon, 08 Mar 2021 03:50:48 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id 3C99C14951419; Mon,  8 Mar 2021 12:50:45 +0900 (JST)
Date:   Mon, 8 Mar 2021 12:50:45 +0900
From:   Norbert Preining <norbert@preining.info>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>
Subject: [SOLVED] Re: btrfs fails to mount on kernel 5.11.4 but works on
 5.10.19
Message-ID: <YEWfFYe+vESAfmCU@bulldog.preining.info>
References: <CAJCQCtTn_O8grH5OBHoDfN7OfEOq5WM2Ryxffb-Z=qhVn_PLTg@mail.gmail.com>
 <CAJCQCtSZGGVamOUGRFzPXBejTW9Hx-2EkYUSCXdN6qEY3snW2w@mail.gmail.com>
 <YEV+hDZcguma9Pqg@burischnitzel.preining.info>
 <YEWJbxhR53O0PqaP@burischnitzel.preining.info>
 <CAJCQCtRmQ115LStiWXp2ihe-v8bvM+mUirMkBYGgu9EzbWpXCw@mail.gmail.com>
 <YEWQa2TXhdSbyWlR@bulldog.preining.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEWQa2TXhdSbyWlR@bulldog.preining.info>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Chris, hi all,

case closed. The reason was that some NVMe devices weren't recognized.
I don't have any idea **why** this happened, but I cleaned out the whole
models tree, made a complete rebuild of the kernel, and now it works.

Sorry for the noise.

And I also switched to dracut on the go, thanks for the suggestions.

Best

Norbert

--
PREINING Norbert                              https://www.preining.info
Fujitsu Research Labs  +  IFMGA Guide + TU Wien + TeX Live + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
