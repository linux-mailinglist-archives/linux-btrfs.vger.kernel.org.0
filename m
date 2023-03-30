Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47036CFBDA
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjC3Gra (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjC3Gr2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:47:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A1740E5
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:47:26 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MV67y-1pq42D2Lfq-00SAtk; Thu, 30
 Mar 2023 08:47:12 +0200
Message-ID: <b38a9aa2-9869-2f95-59a0-d2fe20f4e1d6@gmx.com>
Date:   Thu, 30 Mar 2023 14:47:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 04/13] btrfs: introduce a new helper to submit write
 bio for scrub
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1680047473.git.wqu@suse.com>
 <72f4fa26c35f2e649bc562a80a40955d745f1118.1680047473.git.wqu@suse.com>
 <ZCTK34vrpfGiCu1B@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZCTK34vrpfGiCu1B@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ENWDvotiPWvqfQJBi17b+rW9mJI/KuXUsKVDQq8iSDVwC9T8i6G
 K+gtufKMh0ceKtlsWvDCi7tjNB/hRbbeN6qha2Do3q4flnzfeoJaeP4IuXy0YKWA96E2UrI
 HEtPP5AVigUqnsYftX3MAKx8uD7bbJZSUVNkiBud1B2vB/1LWDNxiBbMKzjZzvSEnvwbDH5
 8Fo82NvzjPnrU2n86wL6w==
UI-OutboundReport: notjunk:1;M01:P0:680CHdo6Dqg=;2VmPfvM7UvgQZMIBQ4pqYKwaGhD
 h/l3hjPYkFUiCVzX6mZRmmZ4GjfsvUQe4ILvz3JSGejI1C+JImRO0I9s93K5IyHkkYaw3cJMG
 H4wK+F2+1liSBFo2Fcx0vzS5g7Jui9R4dggqgxS8xWk4zHn5Y0c7mTqyG3MuBfbVhFAQTpnmo
 Vd3fh+WRAwsd+DUI4aIS8XXinBa9JVX7F4E8qYkPXNJmKeA6XFfE2XeMQnnNeQrjf7SlRlmjF
 ZwHj60dneq/S4NWvCf2esavs7ZgoZgLWoa1lmP5TXJnz9uqo/Dhg8IsW/4zsA6YxJvza4DNCS
 EG+LtkMyakFShDccvNbYrs5Qdvm2MT7aOhSMUMP0swEmN5jVzdO9jannxbEXPIJ9cGMpslUhL
 g4pJgCdkooPWyTH4fZjlJ/L7evc+TrNkX2n0wa9TWQQT0m+YN7q9Yx3saXNXv3Xyo+JB5fDKX
 UPLz38rZmPQrI9tNNyTFX/TZJ8raL7W7PzoTP7YLJPSBXayiIGCBtwyss73HX/plPDqKNq2fF
 iTKccItuieDEK0QluGmAEU9HA5+Y6m2j3/rUdceCcv5MdQuyr+BQLsEpPcSu0oydXshK2qTbS
 ZeYvnt1KkQEECCc//z/5v+1H+uFtx/bBDn/K5pwPCsmClHttE/0v8hOH17SD63xgcf44mqtL3
 lm2apUkUnAYWx7chba8lOVMLYnxXDc6pgdd6zb2t69pX4BevP+DBnzB4A+Sqs9wVhJSMpab/+
 0tnv1VCqz15zqef9MRhvLZCmL5J8gojKv9De1nEQgaRC2QzZeY44QCrFXmA94HDBADF7bbei4
 u+WC1t1ZJ1ItfqM5+ion7Ta78KAO86wkJp4nZwZlpF56lOThxMxbBxg/XRvIPGLcaz+wXyLAW
 lRjFy9Or1yJHh5hy+H6UGDk8jCSVvRGHLwpQ1sO0APCu6JSbqrYqxZhLgFxybpbrS5fR1rq9G
 /Uu+HMer4BfLGFamObe+Qf8clkE=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/30 07:33, Christoph Hellwig wrote:
> Same here, hadn't we just decided to share code with
> ⅺtrfs_repair_io_failure?
> 

Due to the interface differences (read-repair goes plain bio and 
submit_bio_wait(), while scrub goes btrfs_bio), I can't find a perfect 
single interface for both usage.

Thus I go a common helper, map_repair_smap(), to grab the device with 
its physical, and use it to implement the old btrfs_repair_io_failure() 
and the new btrfs_submit_repair_write() interface.

The new one would be utilized by scrub.

The patch is here:
https://github.com/adam900710/linux/commit/e5740c4e7bbf5b3ab368a19459e5b2331c730289

Mind to give it a preview?

The whole series has been tested without problem for non-zoned device.

Thanks,
Qu
