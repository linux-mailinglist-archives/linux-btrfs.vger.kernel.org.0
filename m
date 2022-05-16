Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429D6528C35
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344378AbiEPRmb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 13:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbiEPRma (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 13:42:30 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A0377D5
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 10:42:27 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id qejfnDLFJpmc6qejfntg18; Mon, 16 May 2022 19:42:25 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 16 May 2022 19:42:25 +0200
X-ME-IP: 86.243.180.246
Message-ID: <bbabdbba-9700-2cb6-beac-6566fd84ee3d@wanadoo.fr>
Date:   Mon, 16 May 2022 19:42:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] btrfs: Fix an error handling path in
 btrfs_read_sys_array()
Content-Language: en-US
To:     dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <d915ceb4d459aff89c0264113db21592a6806db1.1652517184.git.christophe.jaillet@wanadoo.fr>
 <120e4c34-da48-7d86-4a50-c31a3804600d@gmx.com> <20220516135407.GM4009@kadam>
 <20220516150148.GX18596@twin.jikos.cz>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220516150148.GX18596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 16/05/2022 à 17:01, David Sterba a écrit :
> On Mon, May 16, 2022 at 04:54:07PM +0300, Dan Carpenter wrote:
>> On Sun, May 15, 2022 at 06:57:25AM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/5/14 20:01, Christophe JAILLET wrote:
>>>> If alloc_dummy_extent_buffer() we should return an error code, not 0 that
>>>> would mean success.
>>>>
>>>> Fixes: a1fc41ac28d3 ("btrfs: use dummy extent buffer for super block sys chunk array read")
>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>
>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>>
>>> All my fault, thanks for catching it.
>>> Qu
>>>
>>
>> I sent this patch in January and David was going to fold it into the
>> original patch but it got lost.  Thanks, Christophe!

Hi,

Not exactly.
Your patch was:
-	if (IS_ERR(sb))
-		return PTR_ERR(sb);
+	if (!sb)
+		return -ENOMEM;

Mine is only:
-		return PTR_ERR(sb);
+		return -ENOMEM;

So for some reason, what you had reported was just half applied. (or 
half fixed by someone else)

> 
> I found my reply to your fix that I folded the fixup, but then it got
> lost for some reason. Probably because I picked the patchset from
> mailing list again and did not take the local branch. I'll fold the fix
> again as it' still in the unmerged branch. Thanks.
> 

just in case, the Fixes tag in Dan's patch leads to:
      "Notice: this object is not reachable from any branch."

I don't think that it is of any importance if the fix in folded, but in 
case, I let you know.

CJ
