Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6313730E5D1
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Feb 2021 23:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhBCWLW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 17:11:22 -0500
Received: from a4-2.smtp-out.eu-west-1.amazonses.com ([54.240.4.2]:32925 "EHLO
        a4-2.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232513AbhBCWI5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Feb 2021 17:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=pqvuhxtqt36lwjpmqkszlz7wxaih4qwj; d=urbackup.org; t=1612390058;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=KctRBvmz+ZC2xJVgeaQKpoMrOM/DsWRqp611+BD5NSY=;
        b=SGzXTI2+DlU4LVf0jw2GmnQuIn1xFVsNO+c90Zhimio14C33uV5UPWCM1Y7LzWLW
        Nu+Mc78PtqABRmDfoSt8VZBWvNkrRmwB7QPPowJOPOZjd6a8dxPc9Dp9J+jNJHv19I3
        CpJvSGKkJYwjSloELy6Wvhbe/nElJnNBQ+yxeDfY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1612390058;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=KctRBvmz+ZC2xJVgeaQKpoMrOM/DsWRqp611+BD5NSY=;
        b=xXq7Yjdhq1AaOT464K4zmVkWPSzLgEWLhi1ud/fadE3eR6yGNAWSkhBFq8mBXn9Y
        Kj19+tpRMIK3MDxTNrCONuNt8spad9WbdwJfGIsZpA81CnFKg6h5T6XLiPgpp/pIgKt
        psCHScELe2V8B2nsGSWszfLL8BAQWfyolG1DBBME=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Martin Raiber <martin@urbackup.org>
Subject: Space cache
Message-ID: <0102017769efc912-ebdc0106-e400-4a3c-8209-f6abb4ac0e4f-000000@eu-west-1.amazonses.com>
Date:   Wed, 3 Feb 2021 22:07:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2021.02.03-54.240.4.2
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I've been looking a bit into the btrfs space cache and came to following conclusions. Please correct me if I'm wrong:

1. The space cache mount option only modifies how the space cache is persisted and not the in-memory structures (hence why I have 2,3 GiB btrfs_free_space_bitmap slab with a file system mounted with space_cache=v2)
2. In-memory it is mostly kept as bitmap. Space_cache=v1 persists those bitmaps directly to disk
3. If it's mounted with nospace_cache it still gets all the benefits of "space cache" _after_ those in-memory bitmaps have been filled, it just isn't persisted
4. In-memory space cache doesn't react to memory pressure/is unevictable

This leads me to:

If one can live with slow startup/initial performance, mounting with nospace_cache has the highest performance.

Especially if I have a 1TB NVMe in a long-running server, I don't really care if it has to iterate over all block group metadata after mount for a few seconds, if that means it has less write IOs for every write. The calculus obivously changes for a hard disk where reading this metadata would talke forever due to low IOPS.

Regards,
Martin Raiber

