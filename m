Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41336C9CCE
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 09:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjC0Hw2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 03:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjC0HwY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 03:52:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E54FC7
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 00:52:23 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbVu-1pgCLI3cFS-00H5Gm; Mon, 27
 Mar 2023 09:52:07 +0200
Message-ID: <fb12ae46-dca1-d883-f170-955e59eebd18@gmx.com>
Date:   Mon, 27 Mar 2023 15:52:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 04/13] btrfs: introduce a new helper to submit write
 bio for scrub
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <cover.1679826088.git.wqu@suse.com>
 <72f4fa26c35f2e649bc562a80a40955d745f1118.1679826088.git.wqu@suse.com>
 <ZCERG/+o6515r06h@infradead.org>
 <a9efa03d-2472-db26-ebb0-dd6b21991863@gmx.com>
 <ZCEoHxLZ6KWXMlKu@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZCEoHxLZ6KWXMlKu@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5zhTBqdChuXvG4gjdi4QVb9QKRzd1WBQ4rNIwvWeKP9uPe6K25v
 IdOuToD4hOGkMGw1DZk1/1ijDgR2RHTZTOQA2nVXxD1SsKcyN7ThQWHG4lH6Uoq1jywiiNc
 WwUy13Hhsd6kOiVHqF6+Q0M8V4g5wAeeaY269HGgk9RrsI+OJh6yag9Dh7riA/ETlM0dWhu
 ARCHPYRfJosmvYBeqd2Fw==
UI-OutboundReport: notjunk:1;M01:P0:61u9G7iFe1I=;Eed9JSyD6NCeW8wawXP9fq7hPPb
 gBFJwULoHrfpIr0wR/6gxW0RkEU/sEhPWCS41ZcHrwVsOJ/Gu2GoM8XfLF61KCIURfuL7/+1u
 mxQ5i6Etb/S2y2m3fgdomQFhd+Msh3bs/MG5buxhUr3LfPQn41zPNHSR22lm0nSjs+73EvSeL
 vIZLR3zgxAnIHyDAkfKABAsu5KvSqXE4W7ugUeoWtruhuseFDSgFanFolDG8JO7AphxSwyhST
 rUHWb0xtzuM0V+9D2qGR3SnG0t1kXNR8P4tTIPp0fIbGVbqnDZaftLRezlJpoLUKO87GJsaKt
 EYfHtYdShML2sI0objt109X4L24DXHGKWf7/tAr5w+Z0Ii4SkbR1AbX1+CArfiH9O83veP9Z2
 5mQXqAPeDVNIgSMEju50WwyjSRWUD4Q17lStZ7/J/vtcPhIs4x32NaUgizEBeIIR8TiR50IVm
 av0UzX3FAPTFpbG6Gs1yOLQG32VcnlKnBMbEc4G2wO7B7TxlOazniCNdey1Al5iH+ONDRTm86
 0JzML1hjqikl8FiInsdRZqBSmwPcTBgz0hQgR7w8xr9NmPmJB+WdIm7VgPHOvtHdWuFCsgD4n
 N3f6w2W+0EQQa6gOFwEG1XwPEvXrJkrHGgEovBWcQCxF7MQrNOGzTAFMhOcdttFfilvlVSx+T
 o9J0Q87Q+HpEsjoK5J+pulwysbaD5jgp7OdIC7xdJRbQ078aILLYSfqikKA1eXQW1GP0uFDTY
 rmqEAjUdssJqgyNOfb3w+cDaue3rBQm7gfvDb557ZZ2v2IwO8ol5W2G4+3LPCnabVen4ZnR6R
 FDfYW3p+hAlQhul0GUw39M3gCLBAKWjnuYSTrfBNFNsdHYlUrkJgtUYlWcQIn+EOwO+i5DGSj
 3tPYPQvTU1YPyX2fB2YfnZFULU14jjEACKKAiQuKvwXyjlSezARXa14WOUTIZtt4AbNhTCatJ
 Oboeci9VsozCFM7wUL50yRYqHo0=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/27 13:22, Christoph Hellwig wrote:
> On Mon, Mar 27, 2023 at 12:32:22PM +0800, Qu Wenruo wrote:
>>> Not crossing the stripe boundary is not enough, for zone append it
>>> also must not cross the zone append limit, which (at least in theory)
>>> can be arbitrarily small.
>>
>> Do you mean that we can have some real zone append limit which is even
>> smaller than 64K?
>>
>> If so, then the write helper can be more complex than I thought...
> 
> In theory it can be as small as a single LBA.  It might make sense
> to require a minimum of 64k for btrfs, and reject the writable mount
> if it is not, as a device with just a 64k zone append limit or smaller
> would be really horrible to use anyway.

The rejection method sounds very reasonable to me.

Although I'd prefer some feedback from Johannes on the real world 
values, and if possible let the zoned guys submit the patch.

I haven't yet build my VMs to run ZNS tests.

Another thing is, if we want to implement the rejection before the 
reworked scrub, the threshold would be 128K, as that's the bio size 
limit for the old scrub code.

Thanks,
Qu
