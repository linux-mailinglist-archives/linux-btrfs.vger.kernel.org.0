Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60489645488
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 08:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLGHXV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 02:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLGHWl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 02:22:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD1041995
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 23:21:36 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgesG-1oScuY4Bhc-00h3Wn; Wed, 07
 Dec 2022 08:21:27 +0100
Message-ID: <2579d457-ddd5-3cb6-658b-1dd0124a768f@gmx.com>
Date:   Wed, 7 Dec 2022 15:21:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] btrfs: make btrfs_get_io_geometry() to return void
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <b3d2350ae3920a475a43dba6f979731420859dc8.1670390031.git.wqu@suse.com>
 <Y5A8IWC6z/LZHRcI@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Y5A8IWC6z/LZHRcI@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2+YgoIPtUMAfzoUVKRx4kSaAEvTKOTCzgUkFgUVut1olt9JXdpN
 fy48bz7w6XravEbuRmo4jZW9fKGrmrWxjGhDbb67b+niyewUDkVWSrwlfnbA5Lt9xUyPFNc
 6aWcyQztnthORhidN2uZxywka7iivQeyKpViM+rJM3kw+tOYq8LXs+6uCOKqeYabVgmqw7N
 mQw3KLGCOKmkMWiD1NgrA==
UI-OutboundReport: notjunk:1;M01:P0:/M4GPt6JT1I=;uZkF0u7eWE11Em7i56j8G0i4qDu
 pFYh10q5U6yP7DAdhgkeVEWR83iVGkHn6Yx6BGxW5ZFmTFOtIUdgEmapqFniGB07fOymvNVaP
 EGlXSqookMHPaW26Q4kjTFYKKfTtHciWx4ju1LPIbiigNkPHPhgtEkQdkWZLgoPkmFCvJwkxe
 hsSmveXFHWkMpYWVJ0sqm3QFcBe+UpVf06heFFe7bJ6tSt3M6Ge/4LEjezPocHcX/e5fFg68f
 WARz7gkMbmfIzcACmQXMl3/0IcAU2V7AzEgvt+GcM+JxVDWzwXmAPuQhGNRREnsE+l9q6Cpuu
 1zGa/qipi+q4uzVg33T6RZuEUdrWwGubQEvAuT8cDq6ysk2nzH8cQwCIzktNkL8ogVFUmfs/g
 gl2momDOVkniWDSXM49xHszYQ8UBjY8dyb439oQ+CRJg3NnM8jtixb17pk3HGs5/pe+1dR0OS
 jke/y8oHvbLc1NeqsvN/7S/wgrvg6VMH41GtWspn7RDuKEttA5zSi/m+eIcM6j5VKznwat7xV
 OhCuk4T7GAcd3OCT61ewCEpdBdambG364Ac+N0Fv/i3C0qmwQc5Xo3DdVHFsAeTyDyVYGpA0Q
 Jh+v4RBpKzZqrrDuYd2i2b3088W88dJJ6lzW7/8HtPppfrxjRKj24mC2dPlykkWebpyKtHVJl
 /Q73bwi/A8+NQxdYrqR5w1BCSSM1qiQK3TmX/2kqe/c25opnjRV8rc/sfFUN7lPGb+VnuU8jT
 qQmi/CM/LE1UnTN6RbJoUmdtreIUHopQvzo12vJG2YyN9fKtnEE0Snha6XBpNNPdJMFYGbbk3
 bXUfwbBdCR6qRlxfaCWjsB5xcVQttS42/Xi0S/TpTUPHv5tpu/UityJKn87KOi30Tl+kpWWD6
 UzWUOG6Q41KwsTnYLmheIkbhcbGbqsFd+MpOwq4zqnw4CspMfdZ99Pa35cmZrMjsl2HgUc+qn
 qnZRVMQmfZmUY+Jh4OCWquR0aMU=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/7 15:09, Christoph Hellwig wrote:
> On Wed, Dec 07, 2022 at 01:13:54PM +0800, Qu Wenruo wrote:
>> Since commit 420343131970 ("btrfs: let callers of btrfs_get_io_geometry
>> pass the em"), btrfs_get_io_geometry() no longer calls
>> btrfs_get_chunk_map(), thus there is no more source of errors.
>> (The remaining ASSERT()s are really for careless developers)
> 
> My btrfs-bio-split series removes btrfs_get_io_geometry entirely.  Can
> we avoid spurious cleanups for now until that series is merged?

Oh, didn't notice that.

Sure, I'm completely fine.

Thanks,
Qu
