Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA7376C13A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 01:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjHAXsT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 19:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjHAXsT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 19:48:19 -0400
X-Greylist: delayed 12804 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 16:48:16 PDT
Received: from box.sotapeli.fi (sotapeli.fi [37.59.98.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9091B1
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 16:48:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C6DF7D949;
        Wed,  2 Aug 2023 01:48:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sotapeli.fi; s=dkim;
        t=1690933693; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=oNnZmlgDiqM8MJHXfXFLCc63+Qw7pIyLJsNgkml90n8=;
        b=me4QK8asGrAhOw/MVgfDa8vzEpMjf5MsiVSZX6maOkf2lzs0A7hsjhZ748JHQp1KTZyUJK
        gIfOn+3DWwhdh441VxGBpGqhCql5/LvwlLsR8W3nb2ALYnUdUDZDDKIlvI1UQ7F7v49w29
        pbqOI/H1SFXWqE43OfIVTcNbWCAmK7ukKmSaQjSfSAXBmJfs/BrD3ANeEA15/A/9hR7YLF
        rTNYLb3HgrcMvTLsATPCTjF/48nJ++HWNYzIz9prQ6VUY931I9FiKxiILTKRNd7Z8Jn/G7
        xFJEETniBl74CLGZmHZDASwvq5w/oiFLgyj8z02kM/rMSJk4xg3LHyg4KyJElw==
Message-ID: <ffd7ece2-6ee1-7965-ba9c-47959c1f5986@sotapeli.fi>
Date:   Wed, 2 Aug 2023 02:48:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] btrfs: scrub: improve the scrub performance
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1690542141.git.wqu@suse.com>
 <2d45a042-0c01-1026-1ced-0d8fdd026891@sotapeli.fi>
 <48dea2d4-42ba-50bc-d955-9aa4a8082c7e@gmx.com>
From:   Jani Partanen <jiipee@sotapeli.fi>
In-Reply-To: <48dea2d4-42ba-50bc-d955-9aa4a8082c7e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 02/08/2023 1.06, Qu Wenruo wrote:
>
> Can you try with -BdR option?
>
> It shows the raw numbers, which is the easiest way to determine if it's
> a bug in btrfs-progs or kernel.
>

Here is single device result:

btrfs scrub start -BdR /dev/sdb

Scrub device /dev/sdb (id 1) done
Scrub started:    Wed Aug  2 01:33:21 2023
Status:           finished
Duration:         0:44:29
         data_extents_scrubbed: 4902956
         tree_extents_scrubbed: 60494
         data_bytes_scrubbed: 321301020672
         tree_bytes_scrubbed: 991133696
         read_errors: 0
         csum_errors: 0
         verify_errors: 0
         no_csum: 22015840
         csum_discards: 0
         super_errors: 0
         malloc_errors: 0
         uncorrectable_errors: 0
         unverified_errors: 0
         corrected_errors: 0
         last_physical: 256679870464


I'll do against mountpoint when I go to sleep because it gonna take long.

>> What about raid 5 scrub
>> performance, why it is so bad?
>
> It's explained in this cover letter:
> https://lore.kernel.org/linux-btrfs/cover.1688368617.git.wqu@suse.com/
>
> In short, RAID56 full fs scrub is causing too many duplicated reads, and
> the root cause is, the per-device scrub is never a good idea for RAID56.
>
> That's why I'm trying to introduce the new scrub flag for that.
>
Ah, so there is different patchset for raid5 scrub, good to know. I'm 
gonna build that branch and test it. Also let me know if I could help 
somehow to do that stress testing. These drives are deticated for 
testing. I am running VM under Hyper-V and disk are passthrough directly 
to VM.

