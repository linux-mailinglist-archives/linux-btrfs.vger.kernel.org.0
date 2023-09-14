Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A9079F8F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 05:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjINDio (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 23:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjINDin (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 23:38:43 -0400
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA051BDA
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 20:38:38 -0700 (PDT)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w1.tutanota.de (Postfix) with ESMTP id 6A927FBFBA6;
        Thu, 14 Sep 2023 03:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1694662717;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=q7BMoNrbnJUQiz4XIsAVd1J97E2HKAkBVGfnNJcCWf8=;
        b=l1oJGGlxiAlCARztqoyPc38Yh0RTB4Wrv6y3s2AURjKlzUCauvczSclN+OsjRJDn
        WAmvFmlBwlSPmxpxU1WwVfkDLDC3loCa/M2FfMEr78j0Lbpwgj+k0q3snYNAQS/UJOp
        SbUGd9aY56eMKHRdQEUQBzQPbmpi4MmonWVbrZmSjycmvzPCiAIcybuJBjSnX9ve27I
        xL6rBET8+xVaWpFBc7wyYWqlJywWsrXwjSSic9qcNzSu+ycg77gXvVbbkYr+XhCI/n+
        vq7X6mmD/zNFpYd0W9rZRwgThzMiwJ8uoyyKurcctIZdGYk67alcKdSbNPeaOCCnaUm
        BHqZ8LKH6g==
Date:   Thu, 14 Sep 2023 05:38:37 +0200 (CEST)
From:   fdavidl073rnovn@tutanota.com
To:     Qu Wenruo <wqu@suse.com>
Cc:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <NeGkwyI--3-9@tutanota.com>
In-Reply-To: <4b8a10e4-4df8-4d96-9c6f-fbbe85c64575@suse.com>
References: <NeBMdyL--3-9@tutanota.com> <4b8a10e4-4df8-4d96-9c6f-fbbe85c64575@suse.com>
Subject: Re: Deleting large amounts of data causes system freeze due to OOM.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sep 13, 2023, 05:55 by wqu@suse.com:

>
>
> On 2023/9/13 11:58, fdavidl073rnovn@tutanota.com wrote:
>
>> Dear Btrfs Mailing List,
>>
>> Full disclosure I reported this on kernel.org but am hoping to get more exposure on the mailing list.
>>
>> When I delete several terabytes of data memory usage increases until the system becomes entirely unresponsive. This has been an issue for several kernel version since at least 5.19 and continues to be an issue up to 6.5.2-artix1-1. This is on an older computer with several hard drives, eight gigabytes of memory, and a four core x86_64 cpu. Slabtop output right before the system becomes unresponsive shows about four gigabytes used by khugepaged_mm_slot and three used by btrfs_extent_map. This happens in over the span of a couple minutes and during this time btrfs-transaction is using a moderate amount of cpu time.
>>
>
> This looks exactly like something caused by btrfs qgroup.
>
> Could you try to disable qgroup to see if it helps?
> The amount of CPU time and IO of qgroup overhead is directly related to the amount of extent being updated.
>
> For normal writes the IO itself would take most of the CPU/memory thus qgroup is not a big deal.
> But for massive snapshots drop or file deletion qgroup can be too large to be handled in just one transaction.
>
> For now you can disable the qgroup as a workaround.
>
> Thanks,
> Qu
>
I've never enabled quotas and my most recent attempt using the single profile for data was on kernel 6.4 so they would have been disabled by default. Running "btrfs qgroup show [path]" returns "ERROR: can't list qgroups: quotas not enabled".

Sincerely,
David
