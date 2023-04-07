Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5362C6DA66C
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Apr 2023 02:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbjDGAEv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 20:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjDGAEs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 20:04:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1006EAB
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 17:04:46 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvK4f-1qbAJW0tST-00rFP1; Fri, 07
 Apr 2023 02:04:43 +0200
Message-ID: <157773e1-103d-5a44-82a2-0d91066f34bf@gmx.com>
Date:   Fri, 7 Apr 2023 08:04:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: dev-replace: error out if we have unrepaired
 metadata error during
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <4db115f8781fbf68f30ca82a431cdd931767638d.1680765987.git.wqu@suse.com>
 <20230406170909.GX19619@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230406170909.GX19619@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RgH31hSi3yQaLDCzuDWDIg6x/5pLFqH7C3L0nj/Vjxrf8Ezh0S4
 efWRkw7hWUty9EolSn6fPR2pTR4SM9Pkl8CLpVYic1Ve7ZMn46r9FyxbQkiTNDgQIorh2U5
 19Ops39upNTnc1UEZaWAVe1r3YdcR9MpE1yxx9ReKr7l986i+fN8AHHwgnAna2RHluzSs5q
 iOx+nzy5q95DrgOKzOxmA==
UI-OutboundReport: notjunk:1;M01:P0:fb73WAu/JN0=;aOtAfM2M3XZ21ArUV0LTJu1XFnU
 lxquUweKgNEVrRxsy7BbRdUnn8V0yuRjdkoRtAbPv3wYUU1HA3lb+A+4mP1/vgESfTYT6ozXq
 lXTqFS+IFxCu04Ft0By95d9g/mq307sQkJ0KkDJKtlmeHknZG+C7hDHjReLz7z7RamHdx8qR3
 4lP7VKERjk2ATwx+jKtjQne7tafpM5inL+LHT7BiZgLDJijQl/tHnWW/gzAPdQSUK71Yhn9AF
 +MeU4Qyr1I8r2AeokfkunIo/nXOkIfo+5z8kKe5DgN8U7j2WzkW/P7Otr8dkhDD+HDUwEjZmX
 FwZWC2GU1TUT0p+gL+hmhlnjTP4jtj0rvuYDgWL5mg4iqNMB0efYaYGajzWDqVlM4tt4OnvcB
 QUdk4I4FIDkXRl5bM4Sa8jXBA4mZ5y4/nHNk3D+p54mvzAw9nEMeMGKuJ5jgcqVabS9Zsg1Ny
 9YYehzP4Yq0dkml20kUgTeCFXi3Imlt7FQVyEXv5T4OzhU952CeguryCtx64KyAsWdCrn9lgX
 F5mmVD9AyYfCjkN8WVUFuZMe7Qkew8wkYRLRbx8bwUW41/7HSk6ZrzwVDKFlOc7BrcekUM4a0
 8+AYaQF1Ozrf+klAHoc9NHBpgbx3LvUgnn32BWQt9N4iVSxFFlUJWV0yY+UQhZQtDU2gmp8F/
 gtp+V5+rAhq8izRSyfDasp648iTU7OpqbaZP+2HsWtw2YN+K/30ScSOdi7Yt9WfjVVFjCzSjM
 Y2/Pkx7lRPd1+dxbiMTvtSXxdzDWCs1WXYDWgSsq4wKI2iFrTnRJBTmz+sZb0o3ASt6D80lj8
 9cROUhHHZh1nZnFx5bFLgBAaAz8crezLwUzUcRvbnOxB4pubsijGcip8p48Ufidi+9Qt/0d9Q
 QSKFNq4PgBPk5rNgaGN0cLPa4keuhIH+OsSJDedBCz3nJ2aGGg137vADPQkgitwEsaDhQdxDx
 x/oiDKuX3hNEEcMk9A47Tb6YB64=
X-Spam-Status: No, score=-2.9 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/7 01:09, David Sterba wrote:
> On Thu, Apr 06, 2023 at 03:26:29PM +0800, Qu Wenruo wrote:
>> [BUG]
>> Even before the scrub rework, if we have some corrupted metadata failed
>> to be repaired during replace, we still continue replace and let it
>> finish just as there is nothing wrong:
>>
>>   BTRFS info (device dm-4): dev_replace from /dev/mapper/test-scratch1 (devid 1) to /dev/mapper/test-scratch2 started
>>   BTRFS warning (device dm-4): tree block 5578752 mirror 1 has bad csum, has 0x00000000 want 0xade80ca1
>>   BTRFS warning (device dm-4): tree block 5578752 mirror 0 has bad csum, has 0x00000000 want 0xade80ca1
>>   BTRFS warning (device dm-4): checksum error at logical 5578752 on dev /dev/mapper/test-scratch1, physical 5578752: metadata leaf (level 0) in tree 5
>>   BTRFS warning (device dm-4): checksum error at logical 5578752 on dev /dev/mapper/test-scratch1, physical 5578752: metadata leaf (level 0) in tree 5
>>   BTRFS error (device dm-4): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>>   BTRFS warning (device dm-4): tree block 5578752 mirror 1 has bad bytenr, has 0 want 5578752
>>   BTRFS error (device dm-4): unable to fixup (regular) error at logical 5578752 on dev /dev/mapper/test-scratch1
>>   BTRFS info (device dm-4): dev_replace from /dev/mapper/test-scratch1 (devid 1) to /dev/mapper/test-scratch2 finished
>>
>> This can lead to unexpected problems for the result fs.
>>
>> [CAUSE]
>> Btrfs reuses scrub code path for dev-replace to iterate all dev extents.
>>
>> But unlike scrub, dev-replace doesn't really bother to check the scrub
>> progress, which records all the errors found during replace.
>>
>> And even if we checks the progress, we can not really determine which
>> errors are minor, which are critical just by the plain numbers.
>> (remember we don't treat metadata/data checksum error differently).
>>
>> This behavior is there from the very beginning.
> 
> The code depends on the scrub rewrite, should we do a backport for <=6.3
> kernels?

For older kernels, the backport can be more complex, thus I'm still 
trying to figure out a way to do the same work, but no good progress yet.

Thanks,
Qu
