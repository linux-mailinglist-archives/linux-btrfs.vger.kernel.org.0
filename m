Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A90466B4CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 00:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjAOXiI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Jan 2023 18:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjAOXiH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Jan 2023 18:38:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE381C141;
        Sun, 15 Jan 2023 15:38:03 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mxm3Q-1oWO8z3y06-00zEmx; Mon, 16
 Jan 2023 00:37:56 +0100
Message-ID: <e103b9fb-9d73-efb5-2f70-9537e943fad0@gmx.com>
Date:   Mon, 16 Jan 2023 07:37:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] btrfs: raid56: Fix stripes if vertical errors are found
To:     Tanmay Bhushan <007047221b@gmail.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230115203215.8115-1-007047221b@gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230115203215.8115-1-007047221b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rnL2+T8lcD94bMbnw1He82Fs5xatHjKG2j5yrQ7YD/75luGXITT
 d1PZGbHibcBUA+LwFBQE2P1dGzdK7llPWQ9qqr1gFKk4wq2ct8VhrDMv05Whee9aU5i0UBV
 SGQCZHb44HqrlwcScoImW9UyMvtK8k/8V+rsdO0rK8zYcAY2VDlX+QlkWHmcx5jA2GB+zBV
 18tIWT0HD+gt0tky4+k8w==
UI-OutboundReport: notjunk:1;M01:P0:vl+AYKuQLNo=;yBhaS1EWToj6qNpU0Qt5u9pfC0u
 3FUEgFbG1PO5c45EGYc399Mz0Z6aT/vvnM79RaOE0dW/jnjnJKtdH+v8lMzNaUK6YDzHoYekF
 99t7gWJ/WYR4m7XaW5QFNSP6gYoT6sJWcRnZgk6x7oKqTCaNi55kf9idqmKIZ0lUX6I4blAmP
 i2oflay4NefRG7i1SL63bLbe8sivavGpGoHvCxKeGggI5LqX729AfZlHQ5ltO07UNrEXK5m94
 WcHqwO61iciyhmbATfWow7v5OidIBXOe+WzDeujzDakmyqwD02lNgJW+J3gEEIO+MjsYZr/AH
 ibkiP4hKp1jWOsH5khmqkbsVAtrbQFqc7phAJTfdkdo+LJIKobOChkAMNmgBqBu+cXDrcGTFg
 Q3EUiL+18grnCKErKY4aVJiQahBFGfumBoAcz1iNnUo3VT6tY5f1Oljd0TenmOUAZDutRTo70
 Du3oPS2gGI66W3G7NXnwZRNPZgIpsTaB81oQH8l0MUEmskXf5lOmyPYRLnZPcN0kN/IhEOMqw
 vFXfscLzg3nl+DoTDAbTeueuIH5p+HW96HGSW23UVhvcXNHSYR/62JSfLg+a6VQT4gBn6jw8o
 cNW6a5YFtwlW5SpJWdl3RZcpoSqdc72Q/Mu4xoQPF3/Re0+DN8TEpfy8N7ZH5tywZuV6CKEWF
 wGvz/BJNYOk9xGij4CBHQww5Fnlcn+YVLPxYsR7n2lRrQ4bbv1j/UJX6Aexv1w+DF87TLS4zy
 KbEHEWyWM92TBRw+p1vgQ18Avz1FC3gcXE2YL9KxOMQfI8ifw/XIXVzpDNBYDFclG+bj32I1L
 US2n+akDpAHbllEqltnhICpzW0WfS/5WWRxP4hUzV7/1mtOqpkY6kC5JUNcZ9iO044yWtsNZZ
 EBAus/UCay89G7QWKj7Syyh85QBhtJIiTYzPk5CqP+MQmlWY5VUnL/KNH/p+k9ruXbMgER46X
 qEjTv6Y6Kz6guhhQPFBK+tbE4Vk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/16 04:32, Tanmay Bhushan wrote:
> We take two stripe numbers if vertical errors are found.
> In case it is just a pstripe it does not matter but in
> case of raid 6 it matters a both stripes need to be fixed.
> 
> Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>

Oh, my bad, typical copy-and-paste error.

Should go in to the next rc.

Fixes: 7a3150723061 ("btrfs: raid56: do data csum verification during 
RMW cycle")

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 6a2cf754912d..f35898a78b16 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1886,7 +1886,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
>   		sector->uptodate = 1;
>   	}
>   	if (failb >= 0) {
> -		ret = verify_one_sector(rbio, faila, sector_nr);
> +		ret = verify_one_sector(rbio, failb, sector_nr);
>   		if (ret < 0)
>   			goto cleanup;
>   
