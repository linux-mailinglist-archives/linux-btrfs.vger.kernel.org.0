Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC3B6976E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 08:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjBOHCb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 02:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjBOHCT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 02:02:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B5B9EC3
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 23:02:18 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrQEx-1ooEWq2Htn-00oVbL; Wed, 15
 Feb 2023 07:56:44 +0100
Message-ID: <d2f73a10-7ec8-0b42-1a4e-eb86b0740741@gmx.com>
Date:   Wed, 15 Feb 2023 14:56:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Stefan Behrens <sbehrens@giantdisaster.de>
References: <2902738be4657ec16e5b5dd38eac1fb53aa5cc44.1675918006.git.wqu@suse.com>
 <Y+sy5xHfz6S16/oc@infradead.org>
 <e7a2cb06-d6b1-f40b-477a-dca130a4a5d2@gmx.com>
 <Y+x+GjgREMyYe5pP@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC] btrfs: do not use the replace target device as an
 extra mirror
In-Reply-To: <Y+x+GjgREMyYe5pP@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dJK46pWFXV5HMqfHRAXeqjLN5HqV/lJhSxd8m6yVTRkaD4cRsuJ
 um64uHcVMTEncFeXKP17O7INNUEttS/WbQtWqDzDg16A/2vxS8qtKssBOzbo1vxOSdguxLH
 ooqFtfv8h8G8e8Bpf+dOlVm320Tg0Fq57QNx8jty9ysuo7PLkgxBfGbNYXs8y4wZsL4by19
 GmR6hG2euKkGeUGHkeXyw==
UI-OutboundReport: notjunk:1;M01:P0:VpI1N/A3OEc=;rmTQ9ge2uZ7sKxx8Ctxsffi0r67
 wPJYYgJ7SToqj4JM7EhSqhUb81xXak5bOA6M6ZHk6HCmkvWkR8n3EgwhvHTv+IvyPgas+nMWI
 k6LNt+SNBTKvBU65WmzAHbVK7vE+5n/qs/5bdRqboaF2LRmfjejcjQhEJsCJTZ1uHvprFBqw1
 U9MUNwnztETtX3k9NCnEMHylgbA7r33Wznsq/BK97GiZHcA8dCUb32Bk85zBoMH4o9jv3I5ho
 Nmt0bfgRnyQm3aQ6xOesmGzWX7ju2PXJ7BzVVcHC49oaHa0uSD3AtPRrA1Q7cKsCEcrbehaFP
 EnIPhQPI4ZOYyUoewNuwlmle+Y2hqm1HUk7PrPH+NQQJ/56CZsmqQirdCKtBF2Qv3cewmzFvt
 Q5yxuaALzhPNCF1DuQKTrpihzu/xDztl6/flbOi2HyLdQ74k3euw8fsAtndvTA07aZZJtjoYQ
 A1QhA+K19JL6xSPCILdDlzMeWUPAk+4gbM9uUelIArE/BgvGj8MLF0VgPICQuKdk0l6zxU5Xr
 IJcI0+e/XRmcnfjshNOs4z1Q5rxFBSQwOmqiYb3+CShXWLiUPE9wpaEIppeBQLFtV0VUumRit
 REo+fG8E1FrMdNBoqJHLsPJicGHBQICxqyJDBnUcR8nVn7NnOQDwTh63bVcf83IoKUqva8/X6
 zJzthr3Xr5MS/AC6S4WJbXTMxccftJV2eOs8djHOiINH32dLxenRJuWTzhT0O8bUz78KvX5zv
 NNJmL8Z9eITOtUdnB/KlE025QoAv4WMaoYwwRTCRAdNMuIP6YP5qkq2Y6NmTYssF1RXbzk9ZU
 KbXcjfESJZEgviBq6jRwL8Ce4wMJWTgK66r9a3oYA3VTl+YsDYMtvjWmXYXy059n861mSUrVX
 7bpdYHN+fM8I3Oat2bL6NT3n8RjcOQfa7JrmyukeR5LRpaJoKQEWvXxrHUHrdfv6jqIFoKklD
 Pmbp9J5TqHxTTZAcEEjq6YLTp7E=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/15 14:39, Christoph Hellwig wrote:
> On Tue, Feb 14, 2023 at 03:18:11PM +0800, Qu Wenruo wrote:
>>> from which I father that the idea is that when a drive is replaced
>>> due to a high number of read errors, it might be a better idea to
>>> redirect it to the target device.
>>
>> To me, avoiding reading from source != read from target.
> 
> Well, it's not identical, but it does severly reduce the redundancy.

The problem is, the target device is not a reliable mirror.

Its reliability is bound to the progress of the replace.

At the beginning, the reliability is 0, all read from target device is 
garbage.
While at the end of the replace, all read from that target device is 
reliable (the same of the source device).

If you really want to use a single number to describe the reliability, 
I'd say it's 0.5.

But in reality, we treat it more like 1, not 0, not 0.5.

And that unreliability can lead to data corruption cases, e.g., 
NODATASUM read failed on one mirror, and read-repair started using the 
target device.

Meanwhile replace hasn't yet reached that bytenr, thus we're reading 
garbage from target device.
And since NODATASUM, we trust the garbage, thus corrupting the data.

Thanks,
Qu

> 
> But maybe Stefan will find some time to chime in.
