Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6AB66BC0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 11:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjAPKn6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 05:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjAPKnD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 05:43:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0471E9EA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 02:41:21 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiPl-1p9QIK0Pnh-00U6UJ; Mon, 16
 Jan 2023 11:41:18 +0100
Message-ID: <bddd724d-649b-aa3b-9a97-f415fe7b6afd@gmx.com>
Date:   Mon, 16 Jan 2023 18:41:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Correct way to clear a free space cache file invalid error
Content-Language: en-US
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org
References: <2269684.ElGaqSPkdT@lichtvoll.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <2269684.ElGaqSPkdT@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dqt2Z1aEO4+F1sIpvat2zhnWGQHZ4IEok9Qr9ZkUuy2ODZD7yYt
 9vS44IF7vTUvTrVFSKHJcrEUGUNN2tbAtNrK8XHr84Ky1HUC3aiYRp1RjVj8/M7/Ja30CY/
 529HMfGNYVmGsi3LczV+peem8AtoT97ZiYjtX9ExdZ3ez7K4L4ONGSqBzbZFDdd2LrfR9ru
 Vcdzpka1hJKMKQxhwXfLg==
UI-OutboundReport: notjunk:1;M01:P0:LuJL/nf5uaM=;9fGzpw8pfEOrdGpAoSpotP+u9ZW
 rJP5U9xyBKy+KMO7DhZEEMQlP8X3Is74MHBIcNfTFzozxYmEShA/Ir+WVkJ/nzCbVxl8EF/O0
 qMjFF0njSswVbfH+PmJYVKxVPW/8F171xHJCV9HkJAN6CTtk/DscxOgb9xKXrMJgp9vsK2xcu
 aGwEVtcbgL29IihwXPe62cRPAUaMw4JXnMonsrvb7zEHowa5J8rZFtQ7MzxWUdIJNLUcN7Hya
 8EwQ9x5UV1LmqaBGVSPCodPYnm2XVTnjPDPQ1nIBK06YiySFK/iBqg00l5XjmldSoijfOZL1q
 KYRca7T0W7PaGWMCaO/ocxLoZYlC4+Kknk/3FxyChp+IPJ+Wd+uYQxdl7xpcCpYF7dGeMUIdE
 sJe/+JqjWJEQ3oVaA9ZmjFP4TeVV8h+GoJNd0kv0TQlzQeaXfV8MqJG1iUQQZnQ+MC2YIn/CB
 OMALdpSFi2CBivpYj4u1C3gYctqti6jEKU1aufqSQQqwlvUKspHQdER0LpynygLy6t5qbKren
 RwnrrN4ajLDRMWYWbu2A8n2IBfIV2MfkzzTbrYK4/UCzb9ArZpNmo+AoqExOP1QFNt/cU0rAB
 JmA6f3dKSJ3BbB0tekGqyYrXfG0govvfSPXjPLlHYrh03iLnLPX/D5cSrxU+XqDjduT2qbUyc
 RVtkD2gR0O8HCdw6v7Q/243S+QcHsw9ikGEV1xBK3/ClfbmJgLZ2bV9EqoUEWfNgA4Z/GhAVX
 Zj43wwXjYQeB92YLp9yOYWUEnvq5BQjMH+DFPOxPNtQmMFJHT8w2Y8MKhHY431rkweYHnYgff
 YrHBGnEL0UWKeN55IvtcGlIEPrlvxpRztVxDsDukvOkfJes2cnNb3HpbM/x5L7GaxufbpWIF/
 k7FVVg8m2oG8P+g32aURajmYJ3G4MsuBbbM321jR1eCOkvAkw61ewAMio6XHDINKwfwlQbHR1
 XFY6yjWwY7wFcC0Vp/L7ntV8O14=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/16 18:22, Martin Steigerwald wrote:
> Sorry for incomplete subject, reposting.
> 
> Hi!
> 
> Kernel 6.1, btrfs-progs 6.1.2. Filesystem on NVME SSD, via LVM and dm-
> crypt.
> 
> I would like
> 
> [   18.657903] BTRFS info (device dm-1): the free space cache file
> (23912775680) is invalid, skip it
> [   18.697033] BTRFS info (device dm-1): the free space cache file
> (25254952960) is invalid, skip it
> 
> to be gone.
> 
> So I tried
> 
> mount -o remount,clear_cache,space_cache=v1 /
> 
> as well as
> 
> mount -o remount,clear_cache /
> mount -o remount,space_cache=v1 /
> 
> to no avail.
> 
> Before that I had space cache v2 on the filesystem as with most of my
> other BTRFS filesystems. But since it really should not be necessary for
> a 50 GiB filesystem for the Linux system (not user data), I thought I
> play it safe this time. At least from what I learned from btrfs manpage.
> 
> In a page on BTRFS wiki it is stated that one should run "btrfs check"
> on the filesystem.
> 
> So what is the correct way to clear that error?

"btrfs check --clear-space-cache v1 <device>".

Of course you need to unmount the fs in the first place.

The clear_cache mount option only clears the old cache of touched bgs.
If the bg is not touched during the runtime, it won't be modified.

Or, you can go v2 cache, which would drop the v1 cache at the first mount.

Thanks,
Qu
> 
> I did not perceive any malfunctioning due to the error in dmesg. The
> filesystem scrubs without errors.
> 
> Best,
