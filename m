Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3FF6A6442
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 01:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCAAaP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Feb 2023 19:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCAAaO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Feb 2023 19:30:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962B9166EA
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 16:30:12 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXGr8-1oyasg2suc-00YlzG; Wed, 01
 Mar 2023 01:30:09 +0100
Message-ID: <a6fbb53a-f5bd-3d01-5944-1e7dfe60985e@gmx.com>
Date:   Wed, 1 Mar 2023 08:30:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: Btrfs progs release 6.2
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     =?UTF-8?Q?Tomasz_K=c5=82oczko?= <kloczko.tomasz@gmail.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20230228192335.12451-1-dsterba@suse.com>
 <CABB28Cw_=EaExPGWRX7k1dB0+j_PoHWPti3bmYvEEURQscKKHA@mail.gmail.com>
 <7c04f236-a81c-8198-8e9e-d280d4b4127d@gmx.com>
 <20230301001504.GT10580@suse.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230301001504.GT10580@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Fx6Owy9oDAE3uQ+HgD4Dgi8XM2e1i7vF63oMNhTV6RFohlhRDkH
 bVhGh4QZt+Vts4fT+mI9x8yXnXrkfEErR0HISmbYVzWctLyC6OcQHebDgLkFzmdjwMenRvm
 FkRaeOlC+YSdflZ1hNm7smVYlYY0rFgpOGjnSd/Dl2dKkKabHEjaYN+5BeUfEmG1pveCe+a
 q7jem2VFf9UwQiVNvT/eg==
UI-OutboundReport: notjunk:1;M01:P0:p6zwa0Rqe78=;lwPPidepc+kFwM7duhKm9l0IWn+
 mSyfmn62qhXvuGblKOAzrj5qZ/2VLjxXal+Xmc9Z4cuLCVjOzObF00FMmyqPPge57jPj3OkCG
 h2roKCG1t8g6ldYamB41+F0jyeke5h6HKkT+OFhRilAlvs0VVFATHPVwCJLqZnXNQNWt7urF2
 mjnnl1J/bjV6fRo1W4qGzVqyuPkXd8zyY6rYJiggr3yzTLyI3wDk/zBkJwCFEENAQnZGpluxN
 nq60UEFw0cn1T+UEWmgiZQvK/DfaGacTlMQ3rP4kq1CHqI3asOkPBEa9b47XeCMI4kUCN1Dps
 LKM5HveLIFmKoSv5XGg11Mroks4Vk4zjbN/jgH/VRYj5k43R5teYoN5tL7sDFEZqLHL2/IolE
 LQCZkoU1o8Luz3CN9G5ONqIGINJw6arc08fdtTOnPor9+TLtDDYU4pLsCJ5OjH949guiMfCKJ
 fYVp87bvGHLA27MadlNlHFszI2KeZI+Jq/Q+eFSzf0iqKgpr5BQUAG2Mfi2Xr/DMIdt5qOE9t
 4qlJsvN6slicEDfJ8xytcz5geDVsNfL31HWlOx1mEo027rff0DXFh+Ekoizjhrto91ybRd+KY
 hCyNxHHz0emyo7G/oX3RyHyilJinJsDZAOtYr21OkkEJHfV+Q8I7DRiBVS5L00ax/o0rm7snm
 U9qX5PipE4oYK0tK9BhSsuo9CNNgoI2JxMgBUQAwc666vDIU/wjmwlFrD6hvbVthHLk8R4scd
 UT0WB84LoC43+0tPwjKSmoyFy1GXr0+JP+ERhhx+2bO9H591zMmfKnaP211iWIxOMLt8F991I
 1G+drMHMBQO1FBlX6WERricb4YwhRNEGcWWfb23KT/7ozUJV40F5yuR2bnWwusOmCD4HisoLL
 EOSM4jBNrex+dF6MPvkDalkqZuvsmXnYi1Y6DemmHuy361YuSdSLRN7OfyXvdoI070a91QB4X
 MO0fpm5yODktANp+AQdF9KsRu18=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 08:15, David Sterba wrote:
> On Wed, Mar 01, 2023 at 08:17:59AM +0800, Qu Wenruo wrote:
>> On 2023/3/1 07:07, Tomasz Kłoczko wrote:
>>> On Tue, 28 Feb 2023 at 20:07, David Sterba <dsterba@suse.com> wrote:
>> cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o
>> cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o
>> cmds/reflink.o mkfs/common.o check/mode-common.o check/mode-lowmem.o
>> check/clear-cache.o libbtrfsutil.a  -rdynamic -L.   -luuid  -lblkid
>> -ludev  -L. -pthread  -lz  -llzo2 -lzstd
>>
>> According to the Makefile, it looks like Fedora build is not using the
>> built-in crypto code.
>>
>> If using libsodium, I got the same error, as libsodium goes a different
>> name for its blake2b_init (crypto_generichash_blake2b_init).
> 
> Oh right, thanks, I can reproduce it now.

And bisection points to the following two patches:

bbf703bfd3f68958d33d139eb22057ab397e6c68 btrfs-progs: crypto: call 
sha256 implementations by pointer
d1c366ee42bd3d2abb4fd855ac4a496b720d8bb6 btrfs-progs: crypto: call 
blake2 implementations by pointer

Thanks,
Qu
