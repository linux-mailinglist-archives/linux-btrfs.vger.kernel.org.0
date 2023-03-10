Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AA86B382B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 09:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCJIJI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 03:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjCJIIi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 03:08:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E29F6C64
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 00:08:17 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MulmF-1qQrQX1hbf-00rpLF; Fri, 10
 Mar 2023 09:07:47 +0100
Message-ID: <3f4ec877-4d19-80a8-1dcd-84fbdbd54745@gmx.com>
Date:   Fri, 10 Mar 2023 16:07:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 05/20] btrfs: simplify extent buffer reading
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-6-hch@lst.de>
 <52d760f4-dec8-7162-40b7-4f0be14848b8@gmx.com>
 <20230310074723.GA14897@lst.de>
 <17c86afa-41af-a8d4-094e-81f1d47e8788@gmx.com>
 <20230310080331.GA15272@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230310080331.GA15272@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iOdYGg9YZIaBCVnZOSNxSI8TQyPAu6MyK0CQeLiPDba/4UzU0kT
 M8Atxxm2xssCkNLdn+1NqXGj5qiXHR6CIHHhtdIecCPfMqwHCjWNIseSwbR3wW1acGaOqjL
 D3jabT8thHi0haTMzez7z5A9M1okb9VkaC8PBQRwVCI75SJMwrdO8auMoZbqdaNMu3vkMeg
 Xfvz+ZBacRzq3u08WuvQw==
UI-OutboundReport: notjunk:1;M01:P0:G00XEqtM4dQ=;0ahdOddaG6Ldh5JfhgpIOTQropJ
 heFPbQClFPRHHbprkacNCWoxasy0U6qAEN/ESNwATxAJggKkbusutfb+r3TBVOifsmHs2WQ9l
 FjTT1OU7SN0YJzQaW4D1EMW/GaiFNG4KsrfBLisfqdTRmHUl46u8McDhME/0baNxJqTI2kuxu
 wkMKErx3fqyRnoNsjx6rmHrL1RcGfxYJ2ARkXijIF2Kt3QpAJoa00cY7BS6vzzBHwdC4ifufM
 kJzxA/4z3Po2HiBeKgssC/VZ/uXZ0HiPvEMHGxSgNrTjSBtAsyl760mdko+VtzafADyCevFul
 pvxtvfmTvsc79z47Vd/2QjJDz2C6Cur2DYP9K6IpW+rLxkBYq32XTPhO1J3G5LWMgME7wL1Bu
 H/JSTBbFVfo6keDu1a6Hp326ezPsVgpAFaGP44E8s6hrHYeF2wSDmx1YjDVFVHYb8YRYyqGPg
 seDmn4xEK90QNpLXVFCEnfvI8nEmGMVbgn6BfL+5mXOIl4XGsmevQcvZtZCyUY21uJ5DfheKS
 53Ni9iAv9XKHrroj2C9nrTRlEjsW53j8MaribEyh4LmoBsPfADCL+CWi8pUvAiUuK5+1uPdZ9
 o1/UfPhPgJLmSVEF/j1GtTQiIOT472BsvgCajEkkqronjxZ8GOeWrYGHLbZQMGYHCPIkR9+cs
 1BD4QQAFvd1n7HQOHxZmRWd4Vr3bXJPk/Mi4v1EFkBknO5n2BsW2qSXfpvNhEcIAXNqTFNy6j
 6zFmrlQZPSBADlBkwn4lB3mVy7glAsYkQ36Sp1mesHPkC0iDU/eHjcTjXx0B624CPBxYoZbun
 ijruhDVQ3lDy8b8YspB0DecW3o94KZ8f/HMzgjp8Uclc9z3EBMSqS8ATshJ5PocXUJxkyMImu
 0vUK3WSc3M4AMQQdtHyMNnJPnA8OJYNwUxbCn7BOJQORiBKQrgA/pO6zh0P4k5k+urVFmuxjl
 LuE2t/lKukUlYDMIezZHZXbCiW0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/10 16:03, Christoph Hellwig wrote:
> On Fri, Mar 10, 2023 at 04:02:02PM +0800, Qu Wenruo wrote:
>> Like this inside a RAID0 bg:
>>
>> 0	32K	64K	96K	128K
>> |             |//|//|           |
>>
>> There is an old chunk allocator behavior that we can have a chunk starts at
>> some physical bytenr which is only 4K aligned, but not yet STRIPE_LEN
>> aligned.
>>
>> In that case, extent allocator can give us some range which crosses stripe
>> boundary.
> 
> Ewww, ok.  So the metadata isn't required to be naturally aligned.

Yes, but you don't need to spend too much time on that.
We haven't hit such case for a long long time.

Unless the fs is super old and never balanced by any currently supported 
LTS kernel, it should be very rare to hit.

Thanks,
Qu
