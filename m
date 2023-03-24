Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9916C7C11
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 10:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjCXJ7N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 05:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjCXJ7M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 05:59:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F020FF24
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 02:59:11 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIdif-1picKn2hu9-00Ehtf; Fri, 24
 Mar 2023 10:59:01 +0100
Message-ID: <0ee1de5c-9cb2-cecf-c4be-02cc16bd505c@gmx.com>
Date:   Fri, 24 Mar 2023 17:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/12] btrfs: introduce a new helper to submit bio for
 scrub
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1679278088.git.wqu@suse.com>
 <b61263cba690fd894e21d75442556ae2f150f095.1679278088.git.wqu@suse.com>
 <ZBmc3ZqDVzb/hVDD@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZBmc3ZqDVzb/hVDD@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:moUHsGYiSPhw7LdmfKTK8ciK0O9pt165aTUdjS5bt8M52aukV5a
 WUmsbZvV7rqELyYmzRR+SFIw277zDVneRboegRQQGpgBYKaasPSymo18aA7CvQERr+3MWAC
 6mD9FHbnBoaMhxTJ0jyG0Wyu5SE3/6q3/4ZkIguhbrj7FOIU6PAdGtu/KPRdAx1+vBlqy3v
 mi3qkEukUM8trpRSZ32bQ==
UI-OutboundReport: notjunk:1;M01:P0:JIhrIi8fbeM=;IkDzuX9gGDbwcPumohcF1lKjNy8
 XaxcAlSsNNg4eGct/DTxICe/EoHbacWhPqoFO2JJWB9PJn+LsMhiJQU/9uK5K/QLWSSi1LnFb
 vrQH1DgnvNknY41Iw2moYbVk0cpNgYPxjtrQa4i5O8p7sguUuYARRSWIX2s9IWc5zAPYR5Np9
 yTHf1XDN9Gqm0MhorepfyiGWgY+pJe/y97Tby7CYhWBrwepw2zvMMFKSmD/RcQr527OFxj4Y7
 BSvfRowuWoJMkCf34ET4/ObJWE8xWKj0dHBihpyXVxK1Dx0wyNY1iBRuHBRn8HxvcmuNtmioZ
 cyFj4mIp+aucXsbl4WHYuiQgnKoiQdTgldKkR0RlkZXIULhH3zlfq4snJrPbgGhCcZjhgsJtT
 x6OikEjhKiFH6l9uGtWzYEVS8Hj1Gwr+yGVcXsWJou7On82+LMU+drmP5cs4YA5AMKuzwfzfm
 VwdXY50HsEiKE8+UoLP0ELslvrIU5R/aLvSyu8p+B1i9O2JkM081+QOl5QNlaeCPl8PiH585w
 G3sQMDxVCgFaJjpJKcLzQQbwmHvZ3N+iYl9mCCHPiWx4QFHfY9U4q7Tdct2UkJuHnTgWra3Np
 wGBlygDcqpgey6QU49x9UHWC4p9yFwTUzIA20fskQZiWfBWA+mCyr749p8QTqKnA1XSPNNXwt
 tWGbs3Er4bo+jRYxASLZBKiW6u2qOlzgF9TOmqyKdypvHk7e10u2Tg1RRSMVRbKbjtwr91Na8
 0yhL6LYbRJa9enrKkvLV+kON5tlh2EX+BCwe2hyVZFgOX6GVxSvwvp91WR8aFCvJ5O7ktovcd
 mast6NbzhWKgbKVbPZ14F9usxLVwD/At+hvTmreEsowOKXMZDvZLKaZe71/MHQIUoxBPmDfum
 qHyqCh5k0BHrepVeR+M/DcFlQ6vU5OcOMUHds2/IQvoCKIFvSrxUsPLMg/Qvze7PmJMSEWaIY
 4thxrZ6d4oL84iH8vjh669pQ/w0=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/21 20:02, Christoph Hellwig wrote:
>> @@ -39,6 +39,8 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
>>   	bbio->end_io = end_io;
>>   	bbio->private = private;
>>   	atomic_set(&bbio->pending_ios, 1);
>> +	if (inode)
>> +		bbio->fs_info = inode->root->fs_info;
>>   }
> 
> Please split modifications to the btrfs_bio infrastructure into
> separate patches.  And we'll need a proper helper to allocate these
> non-bio inodes that ensures fs_info is always set.
> 
>>   	struct btrfs_bio *bbio = btrfs_bio(bio);
>>   	struct btrfs_device *dev = bio->bi_private;
>> -	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
>> +	struct btrfs_fs_info *fs_info = bbio->inode ?
>> +		bbio->inode->root->fs_info : bbio->fs_info;
> 
> .. and all places that just need the fs_info need to just use
> bbio->fs_info instead of these complicated constructs.
> 

I have updated the branch, with a dedicated btrfs_bio::fs_info, 
btrfs_scrub_bio_alloc() and always populate that new fs_info.

Mind to have a pre-check?

https://github.com/adam900710/linux/commit/0f6a419f035787546eec6f51b0430a05a345d4c5

Although the next two patches are also slightly updated to take the 
advantage of that always populated fs_info:

Since the modification, I'm a little more dependent on that always 
populated fs_info now, thus not sure if going back to a union and 
conditionally grabbing that fs_info is a good idea.

Although I'm more interested why there is a super big gap between work 
and bio (32 bytes), while the compiler still refuses to put the pointer 
into that hole...

Thanks,
Qu
