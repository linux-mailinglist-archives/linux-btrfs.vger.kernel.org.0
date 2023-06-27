Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B073F3EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 07:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjF0FVB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 01:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjF0FU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 01:20:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8A3E74
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jun 2023 22:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687843253; x=1688448053; i=quwenruo.btrfs@gmx.com;
 bh=kRyt+tN8gJbajMJE4t52XERHusukWHxIBWCcZ9p30O0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=TntqNvPh99p767uv1N/z2FG0KB9/JsGxoG4nmma4bGT1Wy9WdB3RumBYKYP4UMRpD6I0ZFT
 03C4ZcB5SW0hDOsZI/XoxrXFA6/FajGbO4WXZ/BOOa29wZa1aLrerkyFVunQubWZWjiAoN7z8
 GYFZQLLHLCHlXA2U/pQ0Q6uP+31RZ1zu36h0HR/FgVmx35QPns/qz8ZqOQ4X3C5KiAUClslzr
 nBfmqnyjrd4YjrozZesxRh2xqEBg5M8jq0co+tr2HK1ona7yGN6EwFLzXvanKltHKRGkH1/TW
 p5AmjTZL2mx7ChGiJDayl+KdqaqOVWE5mRo6fPwXgpu9IKCr6oJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiTt-1qdV1t2sqD-00TyKn; Tue, 27
 Jun 2023 07:20:53 +0200
Message-ID: <2770a5b7-1101-b3a3-0824-3ab40c694f35@gmx.com>
Date:   Tue, 27 Jun 2023 13:20:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: scrub: remove unused btrfs_path in
 scrub_simple_mirror()
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <9a09b2850b25de2eb9142d95bcdb1b46ff0207af.1686724789.git.wqu@suse.com>
 <20230614163357.GN13486@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230614163357.GN13486@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:swtdUwPAm7I08TR4r9l5HGKu1OW3lFVxTjNgWma3DUpbLBTc494
 JOTjpACD+THr4FJwVQJNrbWjsD0pgvxAH1/j68tbQgHPn75Dr2jD3OQcwEQqLTiPND2qOKC
 5dOe/F1ciSgNtyJzXuvyiJmfJvkGiztHE6yt939Yc6tvOQsVxjAizpJHHfUWYb8muzw6RCC
 XDzudEdO1qkQPkMsdBpUA==
UI-OutboundReport: notjunk:1;M01:P0:MNo78pnaleU=;iOVGx446BPxXk12XTpaXGwjqByJ
 TZmt4PYSdlAwUoQxlb/c7+R1u1gfk/L7FGTnv9rDZ6EUGl6x6OPCuRXIIOaqmd1nER1fQGmgy
 4367cC0W7GN1hMCuvdGRHatux6EKZ4wfk83q2c01Xm8f0bBi2CypJ2hKzlljJR6WjZAC8HeKx
 4BvsC+hnM8FBEvisqxyGAVr8lIdgOeO9x8kPxfVTIfzuh12DPMKwLeLJJfrgZhWngOmv7Kjg3
 BoqPWffYSO6mmO/hxkKpTK0AKBHRqX222uHTXe6/hiAl8zwzCy+ihCTe03ny0N/GPP0smb+Jy
 fC1gHTfzGPnUMrmdZdaRPkNnX13wuvpg1X64PjXwtzTOpXFFpEG3qWXQA8MMC98KApfQ8D6R0
 03Sj3RCC/cXXguMp+q75NkLW6/sXrc3h4ChTdICFrP6QqLHn1XC0yzEJ8t4xjAvAsniHyeLx4
 eRWpgGyme4R/u3n6Vzudh+ibOf1YFKQoazc0P2tI7YZ0Gqf3Nv4rOcQ3L3fb8fQ662C06Qszn
 nyZraKS2ExFEa4IjqwZmLt/dWh7bbhO+S0uXoobZoKMpHUvAX+znz5M9NOMdncg5Z0Lsv3UDq
 AszKijemgWmRU8eqNXJTEE2krtHZnTcpT76eKuNXRi7VcozaCYAhZl5yAPicYf16VtWbs5mFJ
 /GwJCE0V6+YkMKp+gzYQ5Jui5ab2tV4U84DEss5okFg8xCXxNHY74GGEA371PrI/jr/TeJxgp
 k3qmDZmFlIPqIyEwCcVQlqVJT5W10flUS3pb8sDWlz2LN8C0rpHOASj0Wie8LgODE0vn4WTn1
 ltUgA9IsVLvKbymuuXzdwccasr9lTUF4XbhznaaTonQgyF/KElv0yXIH3LcG0iu3LRtY+8W0q
 zNTkgCE8WZhuuhz70npQ2V92xzrDHD2A7OHtG+HseW2DnBchorKILJbrElnod/3pMp3muf5bc
 20dcham8IDIrOuv2ZH/M3JfDx2c=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/15 00:33, David Sterba wrote:
> On Wed, Jun 14, 2023 at 02:39:55PM +0800, Qu Wenruo wrote:
>> The @path in scrub_simple_mirror() is no longer utilized after commit
>> e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stri=
pe
>> infrastructure").
>>
>> Before that commit, we call find_first_extent_item() directly, which
>> needs a path and that path can be reused.
>>
>> But after that switch commit, the extent search is done inside
>> queue_scrub_stripe(), which will no longer accept a path from outside.
>>
>> So the @path variable can be removed safed.
>>
>> Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scr=
ub_stripe infrastructure")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Added to misc-next, thanks.

BTW, I didn't see the patch merged in misc-next nor in the latest 6.5
pull request.

Is it missing by somehow?

Thanks,
Qu
>
>> ---
>>   fs/btrfs/scrub.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 7bd446720104..be6efe9f3b55 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -1958,15 +1958,12 @@ static int scrub_simple_mirror(struct scrub_ctx=
 *sctx,
>>   	struct btrfs_fs_info *fs_info =3D sctx->fs_info;
>>   	const u64 logical_end =3D logical_start + logical_length;
>>   	/* An artificial limit, inherit from old scrub behavior */
>
> This comment became stale after e02ee89baa66 ("btrfs: scrub: switch
> scrub_simple_mirror() to scrub_stripe infrastructure") so I'll update
> the patch to remove it as well.
