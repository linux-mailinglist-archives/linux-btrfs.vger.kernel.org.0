Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8981C6E5770
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 04:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjDRCVB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 22:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjDRCVA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 22:21:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CEAA7
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 19:20:58 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWics-1pqfOM0zQu-00X0mc; Tue, 18
 Apr 2023 04:20:50 +0200
Message-ID: <1cd25fe2-8794-104c-b8fb-f5e37a6d166e@gmx.com>
Date:   Tue, 18 Apr 2023 10:20:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH U-BOOT 1/3] btrfs: fix offset within
 btrfs_read_extent_reg()
Content-Language: en-US
To:     Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
 <20230418-btrfs-extent-reads-v1-1-47ba9839f0cc@codewreck.org>
 <ad41862c-e7fb-acd7-7657-85b76cb302ee@gmx.com>
 <ZD364ycA71hLmmOK@atmark-techno.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZD364ycA71hLmmOK@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iZpnDmkHT/eA99IIQ1SZVNGS/nawQjdYy2rkflf0y9W7qtZzyp5
 BaTZWqFPmddLziFivX3W6cYOLto5K5g9vD8oPPfnAlI58QbBsD8sGf4Dx24Ap/BLqH6HAh8
 9tjFUNVYXdvg+yEVgtVv2GwcC/w2ngem5nvHysu1WJgghicmqIeEgAMlBkxKMOTKmwM+uBr
 b1c+tKlvdqTlN7nTcCaZQ==
UI-OutboundReport: notjunk:1;M01:P0:irnuJU2thPE=;seOejr07YBj7AR/KlK8SM4v2PHM
 S3kuzvl5gKgEb1TKdXKkoqfimPw9tSxAI/jWxsGZbsxh40KQKF0/Y2z2kadKfkx+lVMZPAy2m
 Rd5Xl8N+K2yFh31tOUz5f2o8SeEYufOa0Rx65zxS1m/zdLbwDkRZvG0IdhzRSGWpmig/t5U2Q
 QZr9toOXen4HxpJBXS2NDqoKHiZ3/RcqzRba47pr/5jyQqC3OwKPVVw9kdrCPW/C8TZxo7gjm
 42PkLThLDhrIrIytVwGazZV11k2do1agOYRl85ILG2BPnR7FBpqL6HLtoBRQNwEy8Xxs6u6yu
 cgi+21jHzmCdlS5kmMfafNdIpo5rAllr4LAqDFueEct4G3RAlLTSZhvuOHaSZIkPSeF53IblI
 cpmHZtiiCxgyEypDPXuA4f4yiaC/xShnhvMS0SqeitVL1bkrdvz1YY4CRhqln/kwnqBHWA0UC
 qwLYDaO3Mp/uaxTx6ozEijV3IFiclvwKirmw+kdU7D3R/G8EL9NqyfoMpJQ5I/gf3CECi544x
 itC24xiQtfDUJcTeNu/BYzGf9UAlhA6Uv30f+qvjRf8eUrOXUo7JBgp19ud93af3H8FBLj5e3
 6MJO2BYZvpsF1QnxR7dtUrIISgBQik3DkAayaqsyVAez5xkRFP3gceY3WLa1KDXB4EAZ0pZR8
 SyMAMq0dX9trPal8wSdtO0zDETTrEi4u9XJazmgAybbQR1ihXH3DlpdDIPx7K/4kDOZBp8vyH
 DL0vwzCj73m38BsjCsWTHWfHKfItBnwVvyl056ZBzplW6nXmS8wHoT8JJOwgUvmeQ2yvy8/Ca
 CjB2u7uBg8ldg9mUhTzoMummBN4NrSqE6PLP7IgmG1WD8Uc2vKIJD9K5qpt3L/BCN/tX4yOVO
 CnLyi/GPnHGh3pb+WTgiViPw6rin2GNI5Xsi8GsJHrSml0z7bD20Q8lWZnA3fjs5ApC6KYjZT
 +V12KPqEBsOJMAT/czusXZUGysM=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/18 10:05, Dominique Martinet wrote:
> Qu Wenruo wrote on Tue, Apr 18, 2023 at 09:58:37AM +0800:
>> The subject can be changed to "btrfs: fix offset when reading compressed
>> extents".
>> The original one is a little too generic.
> 
> Ok.
> 
>>> btrfs_file_read()
>>>    -> btrfs_read_extent_reg
>>>       (aligned part loop from 0x40480000 to 0x40ba0000, 128KB at a time)
>>>        last read had 0x4000 bytes in extent, but aligned_end - cur limited
>>>        the read to 0x3000 (offset 0x720000)
>>>    -> read_and_truncate_page
>>>      -> btrfs_read_extent_reg
>>>         reading the last 0x1000 bytes from offset 0x73000 (end of the
>>>         previous 0x4000) into 0x40ba3000
>>>         here key.offset = 0x70000 so we need to use it to recover the
>>>         0x3000 offset.
>>
>> You can use "btrfs ins dump-tree" to provide a much easier to read on-disk
>> data layout.
> 
> key.offset is the offset within the read call, not the offset on disk.
> The file on disk looks perfectly normal, the condition to trigger the
> bug is to have a file which size is not sector-aligned and where the
> last extent is bigger than a sector.

Forgot to mention, this bug does not only affect the mentioned case, it 
affects all partial read of an extent.

Even if it's sector aligned.

> 
> I had a look at dump-tree early on and couldn't actually find my file in
> there, now the problem is understood it should be easy to make a
> reproducer so I'll add this info and commands needed to reproduce (+ a
> link to a fs image just in case) in v2
>   
>>>    	/* Preallocated or hole , fill @dest with zero */
>>>    	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_PREALLOC ||
>>> @@ -454,9 +456,7 @@ int btrfs_read_extent_reg(struct btrfs_path *path,
>>>    	if (btrfs_file_extent_compression(leaf, fi) == BTRFS_COMPRESS_NONE) {
>>>    		u64 logical;
>>> -		logical = btrfs_file_extent_disk_bytenr(leaf, fi) +
>>> -			  btrfs_file_extent_offset(leaf, fi) +
>>> -			  offset - key.offset;
>>> +		logical = btrfs_file_extent_disk_bytenr(leaf, fi) + offset;
>>
>> This is touching non-compressed path, which is very weird as your commit
>> message said this part is correct.
> 
> my rationale is that since this was considered once but forgotten the
> other time it'll be easy to add yet another code path that forgets it
> later, but I guess it won't change much anyway -- I'll fix the patch
> making it explicit again.
> 
> 
> Thanks,
