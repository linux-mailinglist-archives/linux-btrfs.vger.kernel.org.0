Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030C474FAE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 00:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjGKWYw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 18:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjGKWYv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 18:24:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D812819B
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689114285; x=1689719085; i=quwenruo.btrfs@gmx.com;
 bh=4eCBK0nkK4YqGIYnUEprbMCmo581M2RTK8Z+JCRkHE8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=CqZw3nclBhCXzqSiEMH52ydkxyuqa/gPkpx3vfRIADaEucGKHmRKtFwe2FFFOXAaeD91xFy
 naSFF4QpTaCCsEpb0YMpt85YVLrf9AFGu0pZloMjvq2cRaFfSMVHbxiytBuEigGTQW+JJ0hbq
 AlOzTqvSBh8CwzEVRqoGWuqX5oPe54IKVkb/5N3Lq42zUmA7DZcF9FddJ2lyPNFJ5N/MJz2Kx
 ciwwM8LcMkj8x1X12Bi7ZSHIaDKNTBEJFnwPRkNzPdxppY+QgcAI4wHRBNJePpwNow0H2BbID
 OIMlSA7pxeEEdJ3VZ1tjo0pJ/tIH0hSdsp7F77uDo+KLMyk6Sj0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkHMP-1pYmgO0pvF-00kdbi; Wed, 12
 Jul 2023 00:24:45 +0200
Message-ID: <f3cd2a35-04a3-d5d7-d8ae-c967617b64dd@gmx.com>
Date:   Wed, 12 Jul 2023 06:24:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: speedup scrub csum verification
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
References: <6c1ffe48e93fee9aa975ecc22dc2e7a1f3d7a0de.1688539673.git.wqu@suse.com>
 <20230711210153.GG30916@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230711210153.GG30916@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kSb+iR3C+aPmwNwQCrd2iQKF8BXPu4RnPzgBDaTYWq0vJtYYDAG
 S+2joVlOGxZC/43Qh3l1LN0Dq/lgyK4Qu+3RARTSwVN0rp4DiLEsz6wzE+GpXnyhfI0dgeP
 S6jNWHeKI4uPA1ON4I2l+m66ux4deGhfPXxKs1fuSU2YbDUFjGuF1Z8E44WmDPB2q3yvBqD
 27vx8S1PVV5JCJcGcjHWQ==
UI-OutboundReport: notjunk:1;M01:P0:54/RAoTxAS8=;m/VY/GH3kyq1legn3wqpueJ2h54
 PHvyLO12W4/k5sPKD0/qK0hgWgmNBoKVf3JO9rZ/QSz5uiOn7vZRPkTIpazy58LPK+Vn6LliB
 lhUeUW4dtXP9JN1giFTZW6mm1gCQ0pb5kchw4DciEMVoUvQ8CkG0mrCn0WB6c6FO7C2oyCpV5
 bNFPMGKYFTa71T2GOyKcm7F0wsHOPdMpp+vqQJUru2OL/ERMCo9rob1+eQzd4E35dc//tsk/2
 5WZ4ylWFtME4qvnXz0rrJpJPcC8oPFyq6r0NGKSuprrzEc95rtZYlKMAFuH5QJ7WCzASq/AeS
 KJVSKB23hWJtSf/l4SoBXj0ENCDqUYTEea+VYSPcSBpq6tw/JI/3KzfxsXVQSGxnILjIhGz9N
 0JtpTp5r4w11fSGqTxquuKOjpSUpi2jG2t6WocNiWnJR9B8Woz40QKAtJtaxJ68eeHyVb0CvR
 02Z2Vk5PDIf4Ie+oei41pjr5soEu/2nsSPb8RM5EdhNmTUTb2v5dANbAY799Lh1BayWRho/oK
 IgHmWzphhmAkY0kUolRKVHx+0kjeytjMBA9kNRpX7uG9o8MEYeFD+6MLeqvjPh12XhPpPTVjp
 Rsl2e6XI9yzHWgCTFprsdTvKk2laeYXLvSoNdbqYcOdCbUjP8ns9TLdVXsdB/6YwGf0T73qAE
 5leJBAT87ojFJ++0hvY3vUehJX8+SI2Wn1qcv+T57GjkF1cQYLbc619/G1KUHA8A/tLuarop7
 ggLKAxJVKxg2co+8b4s6IXqK9KoLoyPpUlFEaahwE2rj/X0rgz7CvkFWqCQGO3Jkm8WUNgt0X
 9+pvpTCxxFNDTSNdTrYvq5XTD8vilaF1+DB7G8bq77tTEJS/uYrz4IJd6+IDJq6ndfMMkGGXn
 uO/RM2ioDZ3PQUpGSe4LgiO5mlJ7jMljCywNbsJm6lV37CVUEW0j8+N0NIzdk3yGBzMRdlCek
 lXQe8JZ8RFMCULAZUIKgeciRCms=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/12 05:01, David Sterba wrote:
> On Wed, Jul 05, 2023 at 02:48:48PM +0800, Qu Wenruo wrote:
>> [REGRESSION]
>> There is a report about scrub is much slower on v6.4 kernel on fast NVM=
E
>> devices.
>>
>> The system has a NVME device which can reach over 3GBytes/s, but scrub
>> speed is below 1GBytes/s.
>>
>> [CAUSE]
>> Since commit e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() =
to
>> scrub_stripe infrastructure") scrub goes a completely new
>> implementation.
>>
>> There is a behavior change, where previously scrub is doing csum
>> verification in one-thread-per-block way, but the new code goes
>> one-thread-per-stripe way.
>>
>> This means for the worst case, new code would only have one thread
>> verifying a whole 64K stripe filled with data.
>>
>> While the old code is doing 16 threads to handle the same stripe.
>>
>> Considering the reporter's CPU can only do CRC32C at around 2GBytes/s,
>> while the NVME drive can do 3GBytes/s, the difference can be big:
>>
>> 	1 thread:	1 / ( 1 / 3 + 1 / 2)     =3D 1.2 Gbytes/s
>> 	8 threads: 	1 / ( 1 / 3 + 1 / 8 / 2) =3D 2.5 Gbytes/s
>>
>> [FIX]
>> To fix the performance regression, this patch would introduce
>> multi-thread csum verification by:
>>
>> - Introduce a new workqueue for scrub csum verification
>>    The new workqueue is needed as we can not queue the same csum work
>>    into the main scrub worker, where we are waiting for the csum work
>>    to finish.
>>    Or this can lead to dead lock if there is no more worker allocated.
>>
>> - Add extra members to scrub_sector_verification
>>    This allows a work to be queued for the specific sector.
>>    Although this means we will have 20 bytes overhead per sector.
>>
>> - Queue sector verification work into scrub_csum_worker
>>    This allows multiple threads to handle the csum verification workloa=
d.
>>
>> - Do not reset stripe->sectors during scrub_find_fill_first_stripe()
>>    Since sectors now contain extra info, we should not touch those
>>    members.
>>
>> Reported-by: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
>> Link: https://lore.kernel.org/linux-btrfs/CAAKzf7=3DyS9vnf5zNid1CyvN19w=
yAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com/
>> Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scr=
ub_stripe infrastructure")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Added to misc-next, thanks.

Please drop this, I got feedback from some real world tester, and it
doesn't help at all.
(Although it shows that the CPU usage is indeed lower than previous)

Thanks,
Qu
