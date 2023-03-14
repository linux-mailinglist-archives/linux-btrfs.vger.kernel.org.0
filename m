Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D236BA276
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 23:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjCNW2d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 18:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCNW2c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 18:28:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275B223679
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 15:28:28 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3DM-1pileY16fw-00FUWm; Tue, 14
 Mar 2023 23:28:22 +0100
Message-ID: <810b336b-c96e-d676-2e41-09c5316eaea6@gmx.com>
Date:   Wed, 15 Mar 2023 06:28:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 01/12] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1678777941.git.wqu@suse.com>
 <cfea13b2a1649e4c295b020f2713660c879ef898.1678777941.git.wqu@suse.com>
 <ee70d6fb-2aae-e0d8-8b32-a5e373c572a0@wdc.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ee70d6fb-2aae-e0d8-8b32-a5e373c572a0@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LlLHB0d+Eo6PBLb+CFDixod2ItShEOo9ZSbvuHi1C8pX+ANkF6n
 cll/qKP46Tl4M4l9SxxKPuCGzPn/ZKQ0jO10JKG+TqmlaHpFk+3WrsvWJprRSXPJqOqlQJR
 87FLPZMjHCSHg6skROYwBJpphoos0bXq8ntgwyyAm5xP6E265/zJ4RgQfMQ30o+QaioBm6G
 At+YDJ6G8BqBrZc+EjZUg==
UI-OutboundReport: notjunk:1;M01:P0:ULRhZt6C7Rk=;RG+xmZX7JH282HCE+/eo8/wJecI
 oEviReAwGVCL735rIIUi/hTy04144E1FgN6lptLooe1NiWYij/aEywlf8eS3kvtBKedbvkAsC
 7FNnRaiKvEtDNPgPhrKBt7+GNV9/FqrraZn+fyMSDnOFxOqYMsoIILYXX/2idmn4dAeI6rSfX
 VfJm0xf2BlTCeh69fMVhefMncimRZxJEKtafHWrRqrFDFTgT9pJ7axaQD3CoIa8C93tSFiQWq
 5f+L4Mu86hkJu0dvDlAZZR0ToH/AuB+VH5HM3txCvFkMLMxRMi3FAYcYRsqztunovUtVe0pS7
 UrZQT42yNj99ATOLFqctAL3Gr4Zo83ZAVKiAbo+cOZLBI8z9fwax8AyogNcJHzmyFITpLJqC9
 mr40onZkJ6xxJtH2j2YwkRQYWcBiThhsbyM0IpmqqdbiLQWpJHrA9NLExmxRBrU15EmVAuH39
 tXoL5CP01L0oFLvHgf53N1j3DreSRCLPrd3gsviAxbTc1G0oTmOJLSPYoQdysTaKsy1PTBODr
 3uh9GuXP5sbV4dQVLk2Zqdn4UheIfdy9Iv9IaIzpsgnp0hy0h/0B/epLAYC45NLV1OtDy7hbk
 P7W/fWIL8Jdqlf5epeGTUwSBk3vQea5/jD5PFYel/qqksihEjJGmU4mDBKh3Dc4mra/rfOVhL
 USLyLVGvDhoMtVv3Nogec6x3Z14q3Q+PcFvcY+gzBJ2vTumEmUDbalpkVXLo9bHGxt+CGLnrJ
 /+xfC+E00BI/B8eHa7WfcDuIbTJn3N2nTR+FFvByT8o4EO+sEvzIHDPUcIfrYkd98PUeFtaqg
 HUMpbMwj4MzQ4LE+aiDH0UX1i5cVknKHWwI0aWqt37pFYXtlQqGBlxcHjh8PbgdFBUNqljmiZ
 TNgp5396jcObt8uVdrQOjhyXhuQONFHsy+2+JIlg5WIKkCYDrvp5P2t2SD0J8qt0pzu01zPGg
 gLdIOgHcaJ6Lafz0IhkCQzsMZE0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/14 20:05, Johannes Thumshirn wrote:
> On 14.03.23 08:36, Qu Wenruo wrote:
>> There is really no need to go through the super complex scrub_sectors()
>> to just handle super blocks.
>>
>> This patch will introduce a dedicated function (less than 50 lines) to
>> handle super block scrubing.
>>
>> This new function will introduce a behavior change, instead of using the
>> complex but concurrent scrub_bio system, here we just go
>> submit-and-wait.
>>
>> There is really not much sense to care the performance of super block
>> scrubbing. It only has 3 super blocks at most, and they are all scattered
>> around the devices already.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/scrub.c | 54 +++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 46 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 3cdf73277e7e..e765eb8b8bcf 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -4243,18 +4243,59 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>>   	return ret;
>>   }
>>   
>> +static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
>> +			   struct page *page, u64 physical, u64 generation)
>> +{
>> +	struct btrfs_fs_info *fs_info = sctx->fs_info;
>> +	struct bio_vec bvec;
>> +	struct bio bio;
>> +	struct btrfs_super_block *sb = page_address(page);
>> +	int ret;
>> +
>> +	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_READ);
>> +	bio.bi_iter.bi_sector = physical >> SECTOR_SHIFT;
>> +	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
>> +	ret = submit_bio_wait(&bio);
>> +	bio_uninit(&bio);
>> +
> 
> I don't think bio_uninit() is needed here. You're not attaching any cgroup information,
> bio integrity or crypto context to it. Or can that be attached down the stack?
>  
It's mostly to pair with bio_init().

Although the bio has no CGROUP nor crypto context, it's still better to 
explicitly pair bio_init() with bio_uninit().

Thanks,
Qu
