Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A8B4B20E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 10:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbiBKJCJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 04:02:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiBKJCH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 04:02:07 -0500
X-Greylist: delayed 2528 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 01:02:06 PST
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E49C101C
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 01:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=Content-Type:MIME-Version:Message-ID:Subject:To:
        From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AGROqN0RFAVfqavY0c5pWdOKxtK1mgOFeHj3AYs154M=; b=LvlVgXvIiaH/TJc17Y28FgI1rG
        roNJYYlfTtu4LxRQYB9+sz0V723RSDLIzmlsqidPrYWkwE2Uvy0uVld3UOyeRAZn6inTw172A1GDu
        mOlO+Thd8TkfnB3+XeYsWlScT/YQiE24RyWEFnsIjF5QHYn8z0L81PAequuVqO3o9VM6CqWREDxPd
        9s+9DST2fmDnUQS7+Vx+MTP/3RBglhWmcFLXYiXfeXWzY5CH0CkGngbyHRARZI1aiZ2OJ2XwtAQXA
        xsPC40jLfa8FcChhNDPvWtyz1bgyvlBEcpg5x0Qap0bFQIPu6kXm9rw96IPT9qmpg+1sZ1+1fmwTg
        CAy4p6+g==;
Received: from tvk215040.tvk.ne.jp ([180.94.215.40] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1nIR9n-0007xt-R1
        for linux-btrfs@vger.kernel.org; Fri, 11 Feb 2022 08:19:56 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id 87F4134DFEA; Fri, 11 Feb 2022 17:19:52 +0900 (JST)
Date:   Fri, 11 Feb 2022 17:19:52 +0900
From:   Norbert Preining <norbert@preining.info>
To:     linux-btrfs@vger.kernel.org
Subject: lsetxattr XXX system.posix_acl_access= failed: Operation not
 supported
Message-ID: <YgYcKOVAHGhk4euR@bulldog>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

(please Cc!)

I am trying to send snapshots to my NAS using btrfs send/receive, and
often it fails with error messages always boiling down to
	lsetxattr SOME/PATH system.posix_acl_access= failed: Operation not supported
The local system is Arch Linux with btrfs-progs 5.16.1 and kernel
5.16.8.

The remote system is an Asustor NAS with btrfs-progs 5.6 and kernel 5.4.x
(no further specification found in config.gz etc).

What I have tried and checked is:
- update btrfs-progs to 5.16, still the same error
- CONFIG_BTRFS_FS_POSIX_ACL=y in /proc/config.gz

Is there another way around this besides mounting local fs with noacl?

I can update the btrfs-progs (since it is an x86_64 system I can compile
on an old Debian version so that libc is ok), but updating the kernel
is not possible (some firmware hackery would be necessary, and as far as
I know not been done by now).

Any pointer would be greatly appreciated.

(Please Cc)

Thanks and all the best

Norbert

--
PREINING Norbert                              https://www.preining.info
Fujitsu Research     +    IFMGA Guide     +    TU Wien    +    TeX Live
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
