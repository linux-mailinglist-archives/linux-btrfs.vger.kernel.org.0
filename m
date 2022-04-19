Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348675064B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 08:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348945AbiDSGpO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 02:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238054AbiDSGpO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 02:45:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4362AE2D
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 23:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650350549;
        bh=qw/3ky7Y2MbtHJpCsn/EjD8AVoa6MEW3Sb59nR+9KxY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=hHf+7GPVdw68wa8wDI9CPnMpa3nJTwfLlutfvnKF2CHvTOrxT2KGQVhA3D8EGEPC6
         caYFLJBTMjNHI0f4Z/Qv3T7GsMc7S8pCgXdNAbmrjPyqI/IauDEVnqu1BcwmkUMol9
         6ifgwySIAWeimR6hwAOvrLtAgaws7Bb3RSF88Al4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYNNy-1nSu2w0puM-00VS9C; Tue, 19
 Apr 2022 08:42:29 +0200
Message-ID: <645e71e0-3f4d-c4ec-d285-fb6546b1bf3e@gmx.com>
Date:   Tue, 19 Apr 2022 14:42:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] btrfs-progs: fix a memory leak when starting a
 transaction on fs with error
Content-Language: en-US
To:     Andrei Borzenkov <arvidjaar@gmail.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1650287150.git.wqu@suse.com>
 <0aa27221eba9359cd566fc6448d46b12583211f2.1650287150.git.wqu@suse.com>
 <e329a96b-8fe0-0426-f368-f0a1c2eb13b9@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <e329a96b-8fe0-0426-f368-f0a1c2eb13b9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lrngB//4u8ziqozd/GlMNyAidhbc3z9ptbGW38MiI2muEIkGyQd
 izWql6b36s3iRYyJAzUTaWkGFn0u6MPiwCfCJHDGom7+0/thd0iJTwTEFDYXmqrL2Z2nLDC
 jzfQmjR4+N9DQn7tNrp6NtCq+MLMwSW1BhWsxri8OjuyDkbFIFcxmGd2y+dmT3v6PH5mMWA
 UBlEPkGwPFvG88N74kuzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NY81doMAN4s=:tG5irz4zRzZfHU3OB8+1Zx
 R3OgOWB/XppDxWbktmwLIlYpsNw4Fs74iXdho2haD1RGrHlV7R2OUE67ej+8B1w8txGKUEtbC
 JnhEZRz9eOUsZYnM2e8Tgk4mJhVo1tSV8Kg3oLjhbUKGOyCGY3Bwemn2UrGcejQI51thLLu4M
 KbJRhsNIQuhmlt416Y0zT8+E35I/yFMbDCqvZ0Ae3ZvrN4J9rGiDnJFNtecNeqzThqtC4YnKk
 Mmr0Z0wO0EajmaVdIv5XYsxGtOeNBLSIfnDT8TRZXABpM2ifypTz4zZ0tcPl+tN9MBtYFENtP
 9pCFw9opAxUuCUWpU8qNHfIVZoeyvCWaVTu9C4S7S4vZ2XV8waCxaj9Rnr76PXmfIUnZlrRrM
 NM6Ga2P0zm/roHcyj+NOyUCh4piGh0lOBNRkKV2JnADtcuqzq25xWiOwxlV4BMw5ZcYpgmJUT
 XVNm+kE7ZjRjFSebDbRXXe7IwwQcPdqjByrjGiUJQGysduYSIy6acQ2nk55cQsIStIYG72nem
 G54PQvBMROrDwMCkAOFMCAzo5tNuzMhZ4X/Gu8g79dqwYonSsqo5kIS4ao8+h8LPbJOvBylLm
 QNi1P4tUex6BzApXf/itA/6eH7cVW6gBcsSYZohPbR7LVWNT/rf2UrYKsdYP6yNQ20b1vSSXI
 Ohla27VGy2n8f4L2pn3L8fBYORYp72fA/vNeKRNamJsa+Om79tRcuSWBLlEQJh7rwriAVcm/+
 0KzAPldcpFZIiD+1kCKeHryBHHU1O98X84G+SdZAnaFL+Oy0XjRRe5fYzi03mTgyRUVtfDgXg
 Yvyo5uS1HBhQVv0lgtp6MmWUgoDONdqhWFkq4Bl7Vl7mjbKK/wJnwW6Y2vF1R6lCgxezxmv5Z
 QyG5Gvr1vCz3SRPQoi/Kimc3eIaMsbZ7ME6S+jkx5FFfNi2uWVwZ5sSoVYjo+hWRcKd4xSgJa
 5p/GiwWzcNbsnNHXn1MBkRKo4x2lHm/K+iPzBglzYr6fCVjx7jHzP/hgsu0aLUJGB/ggpgp6R
 hNwXr3pVdStiVMcLRJle5sZwYTWIP6V2WbFC7TKQnnVi4t+6BlbQz0C5JEEHuFht2FaqltMmh
 s+OzoG1cSjo1uA=
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/19 13:09, Andrei Borzenkov wrote:
> On 18.04.2022 16:10, Qu Wenruo wrote:
>> Function btrfs_start_transaction() will allocate the memory
>> unconditionally, but if the fs has an aborted transaction we don't free
>> the allocated memory but return error directly.
>>
>> Fix it by only allocate the new memory after the transaction_aborted
>> check.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   kernel-shared/transaction.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
>> index 0201226678ba..799520a0ef71 100644
>> --- a/kernel-shared/transaction.c
>> +++ b/kernel-shared/transaction.c
>> @@ -25,13 +25,15 @@ struct btrfs_trans_handle* btrfs_start_transaction(=
struct btrfs_root *root,
>>   		int num_blocks)
>>   {
>>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>> -	struct btrfs_trans_handle *h =3D kzalloc(sizeof(*h), GFP_NOFS);
>> -
>> +	struct btrfs_trans_handle *h;
>> +
>>   	if (fs_info->transaction_aborted)
>>   		return ERR_PTR(-EROFS);
>>
>> +	h =3D kzalloc(sizeof(*h), GFP_NOFS);
>>   	if (!h)
>>   		return ERR_PTR(-ENOMEM);
>> +
>>   	if (root->commit_root) {
>>   		error("commit_root already set when starting transaction");
>>   		kfree(h);
>
> If you are moving allocation of h anyway, why not move it beyond all
> checks and delete redundant kfree(h)?

Good idea.

Thanks,
Qu
