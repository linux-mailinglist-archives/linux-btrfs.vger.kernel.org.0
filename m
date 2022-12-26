Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48BB655F73
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Dec 2022 04:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiLZD36 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Dec 2022 22:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLZD35 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Dec 2022 22:29:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B2810C8;
        Sun, 25 Dec 2022 19:29:55 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4zAy-1okaNP2G72-010w8E; Mon, 26
 Dec 2022 04:29:52 +0100
Message-ID: <18b5fa1e-7d1e-4560-c98b-d7ac5fc87c3a@gmx.com>
Date:   Mon, 26 Dec 2022 11:29:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     wqu@suse.com, dsterba@suse.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
 <f68699c3-ec5e-d8e8-f101-6e9a7020ac81@gmx.com>
 <CABXGCsNrm3ddn3p_ECSRe+yQeoF3KojTFvy-CpXNzi9ADkbnvQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [6.2][regression] after commit
 947a629988f191807d2d22ba63ae18259bb645c5 btrfs volume periodical forced
 switch to readonly after a lot of disk writes
In-Reply-To: <CABXGCsNrm3ddn3p_ECSRe+yQeoF3KojTFvy-CpXNzi9ADkbnvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:p49EQwLfBRKIoszgUiDWzj9I1BjOfZjB0ULLMKrdmMDqj9vCDft
 pT00BABZaOgzKMQYXXnQVA6ltLDhwERtgvdO8wv5daCWMpjqMfZB/1n40Z/vl9o+1OPNi4S
 e/KJduirGWS+4gGjAXIctpCdjtldz0RIKA0ZbpO6sch6/0xIwxl/6D3myGfJvWzs39IiO/5
 ZOEPykLa/fopnUZYW+Apw==
UI-OutboundReport: notjunk:1;M01:P0:Ab7F1arDRVo=;gozgqYkcXGWBQiB5ACyLYes9xbv
 J2bjNENAl8eVGpLcoYm3pVtfAKOFN7rynqrgR/3GsrKiuQYuDOKLx3ccQUfVDpilraKCcC8bi
 lO6J5L5/X5BlPZ6IdWtktywe6hplv0lFspxHlCMYH+/ACTJZ5lUsjJ0vQe/3gJ1p4bwFZtbO2
 UPb85u1fxVMgH5A+rmTxQX+TgyQDlkENlKfTZ8UhshJK4aelSCMeyTnspBp6bHis4NLSj74qi
 CmRFTl/dbm/OhCXEhMO8+MBspc15mTelJp3qIB3gobrRJbreNWE53mBtBWlq5AycROzqp0YXQ
 hfhYEubYsPJ/7DuTj+yWQd1XAy5BSfj9meY9u13AanvZC3j3ADc2HAOjNr9u+Tpv//0QBEb7u
 LxL6ckrmR6QYikVAiX/6S02F0aRm4IzhcZUqFn3e8oF8P46bo9Ra9yQuKde7zFhu499UWBqqX
 ySi8LZCVrAkqpEAvYqahaPuIx1yM1IbibznhrO+6VLfQatDvqm1r5cPxNA4DEIv4J3NYKZ8xF
 Be88Aex5axq2vL7gNSVNVzXkq+e1V+NZ5i8pSKtoP5VprG+sTt3zOHSqllMy0lHuE9UJwpUAj
 RpEZ9eUOdXroavrz7HRZkhk/YZjO9jBtEySksdfhi3UNOsCExzse1cY5iOb9UiXuZ26Uh1LAH
 QpxUO0PoBCe5fS+IUv6OfYwrOHOm5P+lxrBgFY/HkX6t5/N2twoIvAmOkFKjlvY6Pe1oVGZKe
 aXJXjVr5orYyopQlfZiFb8iTYQ82cvJH85ZoSYPxKX1OBKqUXXEzRtIJd2YbvqjeMfOfqCPf3
 UgBHkc9CUhZYPPtNtzj8ymUeo7XALe3+OUmB2qppEZM1skYVWFIZFxxUTFcqCIqPPxI3h60HX
 OltG5VNVK6fSbZIKcB3TWGdxYZQJzc+lhX+JlHAflG4YjPw/UKNguoBYaISZF5VMEsVvv3mRG
 LMTqIjVf4kIxLPVoh9fn0yUOzkU=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/26 10:47, Mikhail Gavrilov wrote:
> On Mon, Dec 26, 2022 at 5:15 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>> Thanks a lot for the full kernel log.
>>
>> It indeed shows something is wrong in the run_one_delayed_ref().
>> But surprisingly, if there is something wrong, I'd expect more output
>> from btrfs, as normally if one tree block failed to pass whatever the
>> checks, it should cause an error message at least.
>>
>> Since you can reproduce the bug (although I don't think this is easy to
>> reproduce), mind to apply the extra debug patch and then try to reproduce?
> 
> Of course I am still able to reproduce.
> The number of messages foreshadowing readonly has become somewhat more:
> [ 2295.155437] BTRFS error (device nvme0n1p3): level check failed on
> logical 4957418700800 mirror 1 wanted 0 found 1

OK, indeed a level mismatch.

 From the remaining lines, it shows we're failing at 
do_free_extent_accounting(), which failed at the btrfs_del_csums().

And inside btrfs_del_csums(), what we do are all regular btree 
operations, thus the tree level check should work without problem.

Thus it seems to be a corrupted csum tree.

> [ 2295.155831] BTRFS error (device nvme0n1p3: state A): Transaction
> aborted (error -5)
> [ 2295.155946] BTRFS: error (device nvme0n1p3: state A) in
> do_free_extent_accounting:2849: errno=-5 IO failure
> [ 2295.155978] BTRFS info (device nvme0n1p3: state EA): forced readonly
> [ 2295.155985] BTRFS error (device nvme0n1p3: state EA):
> run_one_delayed_ref returned -5
> [ 2295.156051] BTRFS: error (device nvme0n1p3: state EA) in
> btrfs_run_delayed_refs:2153: errno=-5 IO failure
> 
> Of course full logs are also attached.
> 
>> Another thing is, mind to run "btrfs check --readonly" on the fs?
> Result of check attached too.
> 
Could you please run "btrfs check --readonly" from a liveCD?
There are tons of possible false alerts if ran on a RW mounted fs.

Thanks,
Qu
