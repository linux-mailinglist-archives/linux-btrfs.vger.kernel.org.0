Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01466D4141
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Apr 2023 11:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjDCJvY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Apr 2023 05:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjDCJvA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Apr 2023 05:51:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130821BF7A
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Apr 2023 02:50:02 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvvJ-1qLw1S0869-00hM5N; Mon, 03
 Apr 2023 11:49:27 +0200
Message-ID: <0f92238e-c5d2-c6e3-ab10-28d4fa047cd8@gmx.com>
Date:   Mon, 3 Apr 2023 17:49:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: btrfs mirror fails to mount - corrupt leaf
Content-Language: en-US
To:     Craig Silva <off-centre@100flowers.tech>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <E1pjDzy-0002yU-0u@rmmprod05.runbox>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <E1pjDzy-0002yU-0u@rmmprod05.runbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KaoZRYKU7ZIDbeZDoP4xGNpLL+TXVV3ksiBFz5hucxJwrAUZ1+i
 N9lVKiVp6fVQvb/7cAhIySabmv1FcJWT/DnIOL/y5r5Ju4BYdq0/lscy49y6Y2I1FgFQYBN
 NcUtSqxIHkQI6PE0B00hFGSNVv4AJ3ZU4n7RmctP9u4Mm+skA8nPAEUtm9gK5tK+c3Jbh2w
 k5YjG4/NLgjnV4GURSdfQ==
UI-OutboundReport: notjunk:1;M01:P0:D4qNZzjvP8M=;64mxrwqlStKvLdQdieTx+ZgvJ6n
 r4LNpoAONSBQLEQmLdL0vr8Pr6fsJcvQbCaI+vhAg011KKAW5fSSZS6a74Ip9YvBuTi7aSCBO
 99e03udC1O40y6HhkGfNhL4WxtwkJFsVS55TArAB09vlXK1A08AnHOpPNhhaMqkEbxR+t7ns8
 ny5S7EDXai7szjaOUasJ4izXHD5leKZ8IdzlJuWGJGcikNUpaTO2MHW2DCFG7Vez7yNYnFMqJ
 bWYSrtbn8TP3J1gS44/r3XeQxFuz7QV9eh8cGMYFCDKmgVBelb8qZ4sWV3fr1by3YQ9E5Ya8o
 lR1o7/AmDda10+KZs14GqgYnerxnYTUib//TF/oduTCr3/etXcPYZdq31z0gdR4XhcIjVp8Ec
 ZWZJ9Y5q9DgxiN5O6YidTMSYtsuA6ud0S/LpAnVOkFi0H7WJLHMUsDwLmWn82wbpjxDzmpUyQ
 ss5f+LUj1pjpuOnZ3987d7wC854Ue2j59jSX2ltpWiUxA4fUOV76y7JsS2702WxBPJ9FcPVlc
 1xZ69TFJVYSPfgP2Cvtv4hGei4cBSznYhJZ+LihvSaJiqjC43ryo345WsnPj4peWohXYA0faV
 mF1axiue73WduWYvCuciMEcqGBr7G2zwZzMHOk1fBDDUrlPyK5xvHYUdZXTfMOmCSNlb1Goxz
 XbbpbwzlN/Yy0hkIhenyQjCccJjos9Diqrcc+T+7qyU529M+7T97RgT7X2F+Ce5rXqUc26MhH
 VTUZM1b/kzv++jrl8rOwXiztYFDifWcOgc0asj9RAnhzeEYmBCSk7vWRW+s+E2/RCQSCUNzon
 /Wi8VYJzt/onkGo3Qz84tk/b7Zz5udC6ZqSklrbVbny7+kpn6VklkY3R0jvq/KfsEFbnNeFlb
 t/m6FTpg66wMuvX5rs7QUHRTlQsBKgtQIvErw82hKtu4Oyfo7sA875ta6rMMBPawzEvugDFG9
 ZDCaxrtEPJXsil/mvK7lLKpAXWs=
X-Spam-Status: No, score=-2.0 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/3 14:49, Craig Silva wrote:
> btrfs filesystem show
> Label: none  uuid: 34f2c6cc-2665-4b9b-9503-356c83066d33
> Total devices 2 FS bytes used 864.48GiB
> devid    1 size 3.18TiB used 2.02TiB path /dev/sda1
> devid    2 size 3.18TiB used 2.02TiB path /dev/sdb1
> 
> blkid
> /dev/sdb1: UUID="34f2c6cc-2665-4b9b-9503-356c83066d33" UUID_SUB="5c40e61e-04d0-4025-8c97-be4a12da719a" TYPE="btrfs" PARTLABEL="primary" PARTUUID="c0bde629-1d0c-44d9-a48a-6f4657627428"
> /dev/sda1: UUID="34f2c6cc-2665-4b9b-9503-356c83066d33" UUID_SUB="05db5d7d-92e9-46d3-a7bf-655af00ccb85" TYPE="btrfs" PARTLABEL="primary" PARTUUID="3a5b7725-0be5-4935-89ae-2b67813cbc07"
> 
> btrfs-find-root /dev/sda1
> incorrect offsets 5447 33559879
> Superblock thinks the generation is 1443155
> Superblock thinks the level is 1
> 
> All supers are valid
> 
> dmesg:
> 
> BTRFS critical (device sda1): corrupt leaf: root=2 block=546514255872 slot=205, unexpected item end, have 33559879 expect 5447
> BTRFS critical (device sda1): corrupt leaf: root=2 block=546514255872 slot=205, unexpected item end, have 33559879 expect 5447

hex(33559879) = 0x2001547
hex(    5447) = 0x0001547

So an obvious bitflip.

Please run memtest to make sure your hardware memory is working correctly.

With the hardware fixed, you need to use newer enough (your kernel 
doesn't seem new enough, as such corruption can be prevented since 
v5.11) and mount with "-o rescue=all" to backup your important data first.

Then with newer enough btrfs-progs, you may want to try "btrfs check 
--init-extent-tree", which can be dangerous, but can at least rebuild 
extent tree.

Thanks,
Qu

> BTRFS error (device sda1): failed to read block groups: -5
> BTRFS error (device sda1): open_ctree failed
> BTRFS info (device sda1): disk space caching is enabled
> BTRFS info (device sda1): has skinny extents
> BTRFS info (device sda1): bdev /dev/sda1 errs: wr 0, rd 0, flush 0, corrupt 11, gen 0
> BTRFS info (device sda1): bdev /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 11, gen 0
> 
> I checked hardware both sda and sdb with smartctl and no apparent errors.
> 
> I'm in the process of a restore (ho-hum) - but it would be nice if there was a way of fixing it
