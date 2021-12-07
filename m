Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120B146B135
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 04:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhLGDKi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 22:10:38 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:64350 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhLGDKh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Dec 2021 22:10:37 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 49CCB820D46;
        Tue,  7 Dec 2021 03:07:07 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 60205820DC9;
        Tue,  7 Dec 2021 03:07:06 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.100.11.81 (trex/6.4.3);
        Tue, 07 Dec 2021 03:07:07 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Invention-Skirt: 3f9329426b5ccdd0_1638846427081_4264434553
X-MC-Loop-Signature: 1638846427081:2028896894
X-MC-Ingress-Time: 1638846427080
Received: from p57b045ec.dip0.t-ipconnect.de ([87.176.69.236]:49574 helo=heisenberg.scientia.net)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1muQon-0000D1-A5; Tue, 07 Dec 2021 03:07:04 +0000
Message-ID: <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
Subject: Re: ENOSPC while df shows 826.93GiB free
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Tue, 07 Dec 2021 04:06:58 +0100
In-Reply-To: <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
         <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2021-12-07 at 10:59 +0800, Qu Wenruo wrote:
> 
> Since your metadata is already full, you may need to delete enough
> data
> to free up enough metadata space.
> 
> The candidates includes small files (mostly inlined files), and large
> files with checksums.

On that fs, there are rather many large files (800MB - 1.5 GB).

Is there anyway to get (much?) more space reserved for metadata in the
future respectively on the other existing filesystems that haven't
deadlocked themselves yet?!


Thanks,
Chris.
