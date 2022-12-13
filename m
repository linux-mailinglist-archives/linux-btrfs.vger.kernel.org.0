Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5212964B1A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiLMI7s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiLMI7r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:59:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBA460FE
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:59:46 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVNB1-1pXMwm0yIR-00SKer; Tue, 13
 Dec 2022 09:59:40 +0100
Message-ID: <4a2e71d8-59ca-f29c-a6c7-f07685c2e528@gmx.com>
Date:   Tue, 13 Dec 2022 16:59:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: small raid56 cleanups v2
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20221213084123.309790-1-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221213084123.309790-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4J6OPQYOx5sgI9S2Aq92UmI4aWL8hUKRCd40hzeLjy1G2XC5vy1
 YBtQQdGimScsOtR+IWKAl9CE5GY7v+BQyM8s3PeiaaUqAWcxaD00DnQ7XIxgXquhaYy2/vQ
 JyqZRx98DoVsahqPA0s54LbhoRGo4dhOHfeqfc9buUEbn/jK9c98fxciH54AbGIJ8RhVmFW
 SYn1KT9dxAuyWVPoV6fQQ==
UI-OutboundReport: notjunk:1;M01:P0:qyMPojICtI0=;MyZna6DcsTstSjz+iWlqN1VRjv9
 d3ChvtCa/RjZEqPWJOtuel9rSUP1jZV2sfT16lD8ibXteLu8KJJLAKgLvAa1n9Vu75iUoTMiu
 /Cj0Govqh61fPGVDkrut7Dx8/EUM2ekkS2Qf+km0GvwG3Vfdqs1/5gP8lVzPMI+rKXTcYe5Hb
 C8DRQYNj+XEjhB0m6va//JlZoS+SIMxXYj0e+3XrnBTw9IIHtq9prnNcEUqMkXHyzEEqC59U2
 mI/JbNcxThBPI2R3nr8G8ZjmigNrueCDmpzlgVNBw3cSwFjxCUgmvJNWEQD+3i7/7F7C6D/DO
 t0VL9AJDvvLx7LasWzcgoteZ019+VwbLS3iqsFG3tT5ZakiA5IC8X43USgdU7tFUC2aN2tB+w
 7h7oLMLzZIrOeKdtdC6G82cyrTuUUs+tb+fcOz2KzR00tPx3JpVBrN+SxSGW9g++PDIoS9iLg
 syYq1v3NMFLqgCxiTzDFAiciSO0PtThQX+nj8zgWe/oa7CI8fnEiKDx20V2jO9GXK56PlvNFt
 KwCfP9ObbAfYRiZgTH08+XlDIws2ASGuGS0j45Fbqg91A+VW0VFQRGbPU5xGEQkJ5+fU8hQDr
 Mdsgqwfiz33VtNXuc+VyGJOUGgTTt8hFkTfctfQQ+7N53UXMKfxTXtNKz7amSb48GPR/yngSX
 f0rjgAE56caD0lPJRmWhewfLIPFyK2gy+QNhDUNADlaP4IaVMNw3TBvbcPKp5cRzBMGAD2jb7
 UCPzMhCy7El7H0nj9pLuhrRjC41zNTi0KVJvCrR8S0U046Li/LtlvJIMiVwrrR2LIXXluV3VF
 oz/gODk+VgpcZKISS1GRdnZX/dMV7oElYV3zQ0m2TjJtBCXDDJ8sdqJARAXFsfyvQmhEcxx54
 Mb9V0UzCcwqATnwFNO6GTjVfN0Jbcg52/we9QVKjBOwL2yQck/AeS28/xtBbMiahDQcg0aeqY
 FtAHcKxwcdjQgox1EX6CKHa57OI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/13 16:41, Christoph Hellwig wrote:
> Hi all,
> 
> this series has a few trivial code cleanups for the raid56 code while
> I looked at it for another project.

The series looks good overall, but I'm more interested in how btrfs 
RAID56 can help your other projects.

IIRC btrfs RAID56 should be less feature-full compared to things like 
dm-raid56, no write-intent/journal etc. (but I'm not a fan to read 
dm-raid56 code either)

And if you have other feedbacks or uncertainty, I'm pretty happy to 
improve the raid56 code.

Thanks,
Qu

> 
> Changes since v1:
>   - cleanup more of the work handlers
>   - cleanup cleaning up unused bios
> 
> Diffstat:
>   raid56.c |  167 +++++++++++++++++++++------------------------------------------
>   1 file changed, 58 insertions(+), 109 deletions(-)
