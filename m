Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B45888D8
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 10:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiHCIsh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 04:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiHCIsf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 04:48:35 -0400
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739091E3FB
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 01:48:32 -0700 (PDT)
Received: from [192.168.1.27] ([84.222.35.163])
        by smtp-16.iol.local with ESMTPA
        id JA3Jo86TQnJ6yJA3JoQong; Wed, 03 Aug 2022 10:48:29 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1659516509; bh=dqClaYc79WpyeJDqajj7uc4WY/Py4NyZAIFFqB27DKM=;
        h=From;
        b=AXLuZbMgFU4BqfrwZs9Ny+hR/27Fgy4Tf0RnoucpzIo2Cfc27mmgxKlFQPBrb9Rwe
         KnvWdu+Tgiu86Gdu2FW9t/8gVA/yWpabZtVlscc97JOpC1GOzcxGikLAKSJUXxYN6x
         8sxWqVExzPKef6Fhji4JxrAtf4g/NR5z9I9G21DZwpbCOiAljgmK9Thm4pkM+/Fw9R
         yDq7I1m5SEMT+hOSFy7nwf0XhKcHCoArwG4TXmwevgpK6wJcT1Phy1gVWXLJrdVURv
         kj67Y+VdFtYSbCjmxIzfKRiGUaf9qBxEI4HcAH1BF2ufq/Yti9lEmt9tokTaY7GevB
         scVCC0qDwiJ+A==
X-CNFS-Analysis: v=2.4 cv=E9MIGYRl c=1 sm=1 tr=0 ts=62ea365d cx=a_exe
 a=FwZ7J7/P4KMHneBNQvmhbg==:117 a=FwZ7J7/P4KMHneBNQvmhbg==:17
 a=IkcTkHD0fZMA:10 a=JH9p4vlxT8AVIMDDvhcA:9 a=QEXdDO2ut3YA:10
Message-ID: <9494ba7a-baf4-540f-dba5-b47bdc85162d@libero.it>
Date:   Wed, 3 Aug 2022 10:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 00/14] btrfs: introduce write-intent bitmaps for RAID56
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1658726692.git.wqu@suse.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <cover.1658726692.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFf1XSz3hshhTxYfQsdfELjobbxu29l6nOpA62tP3HACkEjRnLtTA4/cu6U2Wj3rGIuLwKYm2Py0fVZ0lEZrcbgnGfzYFZt0xcCOcpHZzJkcRV9Tp1Ol
 hwBhpXgSfFfwF5JGITyE0XmoFLrmmI1LeKV2tkqjDkgtjTOrAHl3qWf/P+DfR+1U+Z+KKFSvDw8qKFF27Y4sIaY9xKSYFQNtTuIKDY1Z4Syk1NSPCJdXQbYF
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,
one minor tip in the cover letter

On 25/07/2022 07.37, Qu Wenruo wrote:
> [CHANGELOG]
> v2->v1:

[...]

> 
> When there is a RAID56 write (currently all RAID56 write, including full
> stripe write), before submitting all the real bios to disks,
> write-intent bitmap will be updated and flushed to all writeable
> devices.

I think that the previous statement is not fully correct; now (with patch #13)
the fully stripe is not logged anymore in the intent bitmap.

[...]

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

