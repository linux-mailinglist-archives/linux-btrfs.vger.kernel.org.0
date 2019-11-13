Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE7FA052
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 02:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKMBhR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 20:37:17 -0500
Received: from mail.rptsys.com ([23.155.224.45]:10519 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfKMBhR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 20:37:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 38CFFC39A4097
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 19:37:16 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xxppSmJMOCL8 for <linux-btrfs@vger.kernel.org>;
        Tue, 12 Nov 2019 19:37:15 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id BD173C39A3F8D
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 19:37:15 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com BD173C39A3F8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1573609035; bh=S1uzsxzNGIVwfmQB8CUC8a1xZ/+mEpcMBd8Iiv5l+ss=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=HX5y8T4Y6g2BHmcFGNdqgJF2I9Wu94JHqILlzPxzn6K5Pkv6HFEJ+pzcb++hL7rSh
         wUKD/cnwag3r4nax0YkT0015z4Vp+opujGNTtLQqPrFAa6uuOCDEww67QrmVQIY5gi
         hd+EaI9Vg8ARlVbSVy5X4CfNkjsbjcS5Hm7ZO4Ok=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Q6yEYVdC9vkZ for <linux-btrfs@vger.kernel.org>;
        Tue, 12 Nov 2019 19:37:15 -0600 (CST)
Received: from vali.starlink.edu (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id A6859C39A3F5B
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 19:37:15 -0600 (CST)
Date:   Tue, 12 Nov 2019 19:37:15 -0600 (CST)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <1204250219.669.1573609035591.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Potential CVE due to malicious UUID conflict?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC65 (Linux)/8.5.0_GA_3042)
Thread-Index: f+d0XqVXmcQFh1Eux+qwALmMtFCWbw==
Thread-Topic: Potential CVE due to malicious UUID conflict?
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was recently informed on #btrfs that simply attaching a device with the same UUID as an active BTRFS filesystem to a system would cause silent corruption of the active disk.

Two questions, since this seems like a fairly serious and potentially CVE-worthy bug (trivial case would seem to be a USB thumbdrive with a purposeful UUID collision used to quietly corrupt data on a system that is otherwise secured):

1.) Is this information correct?
2.) Does https://lkml.org/lkml/2019/2/10/23 offer sufficient protection against a malicious device being attached iff the malicious device is never mounted?

Thank you!
