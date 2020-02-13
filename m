Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62A515B9C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 07:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgBMGvf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 01:51:35 -0500
Received: from len.romanrm.net ([91.121.86.59]:51060 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgBMGvf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 01:51:35 -0500
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 15A2340300;
        Thu, 13 Feb 2020 06:51:33 +0000 (UTC)
Date:   Thu, 13 Feb 2020 11:51:33 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: fstrim reports different value 1 minute later
Message-ID: <20200213115133.6a109d69@natsu>
In-Reply-To: <CAJCQCtT6QwBeB79jWGoOtpT+GLLEQAdVHrYvMRZhFz4Th_xYNw@mail.gmail.com>
References: <CAJCQCtS9Te9gRAGwin_Wjqv_3cJXVXthNa1g53zF4PbZW+k0Qg@mail.gmail.com>
        <20200213112110.7100baf2@natsu>
        <CAJCQCtT6QwBeB79jWGoOtpT+GLLEQAdVHrYvMRZhFz4Th_xYNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 12 Feb 2020 23:37:26 -0700
Chris Murphy <lists@colorremedies.com> wrote:

> I have fstrim.timer set to run fstrim.service once per week, and that
> reports sane (expected) values each time. But, it also tends to happen
> soon after a fresh boot or wake from S3.

I believe Btrfs now[1] tracks which areas have been trimmed already during the
current mount and does not re-trim them again, like ext4 does since a long
time ago. In case of ext4, for your scenario the first trim would return 91GB,
and the subsequent ones (assuming no FS activity) would trim 0 bytes.

But if the above is indeed the cause, then I'm not sure why it still always
retrims about 3.6 GB or 11 GB for your other machine, even with no writes or
deletions.

[1] https://patchwork.kernel.org/patch/11254859/


-- 
With respect,
Roman
