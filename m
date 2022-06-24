Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF9559528
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 10:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiFXINR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 04:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiFXINQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 04:13:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505A3186E6
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 01:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656058392;
        bh=WZGcqzkYi2d63F6UjpgY/hKDWzPeu9lXa3x2bb2YGA4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=XMJxQ5S4FRY8X1HLhWNNdc7rhSxCmJ2TnsOXLAs9DoxVRt6K+nZOBSokP8RYI4aCX
         GzVpSiVTCY97307abH/qrN6Al7mjQvAuX4qkbZvjRKzCMR1qEohygS1f6PuGHhXwbJ
         AVl0iZyreAU2Acrg+5XDZ3DoTOSAZ9g2RiL/QgKI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzQkE-1nihlf39BQ-00vOxF; Fri, 24
 Jun 2022 10:13:12 +0200
Message-ID: <21f7eb10-09d7-826c-48c3-ded892984d50@gmx.com>
Date:   Fri, 24 Jun 2022 16:13:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] btrfs: remove MIXED_BACKREF sysfs file
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20220624080123.1521917-1-nborisov@suse.com>
 <20220624080123.1521917-2-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220624080123.1521917-2-nborisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ETzGG+X9FZu//rr8vmKRvxm8cMLYZwFyXZgUZJqd+cGGI8O8os9
 wmfGbNh7doFx/FM6AJd3iBovj2eRCb5phCU0LssdaOL1u/5DGqB2F0xw0Ph4PUMZuM30CDN
 O1WebIyMDb0fqb3w3xUaamoxiuG6J/J8E626Q6wQ/54qUcIx6uJFOfhmYfp+7i910VO/aBJ
 pt3Hb9MqmT9DjQPRftPEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oIA1REbTLMQ=:MqsiDPMMFKBb94GJEUS4xC
 nhErH6nZR/irhtUWBzNbN36GBoeVq08opTRrw8id0WKiXLrlR8+2tIasQP+g1qYpDpQ5LC0x+
 MbAZ7S+ivheTc1aZEbjLWTbewEVHzcgHgE/SWvC6w5JcekfayVUQHSHXt6kKPPn2+xDKioeyu
 q40B5hOL12oDfXZWct/Zf66IE7nGtfMGdtks47XgqfIYN7Q7SM/pN9jvtZ8mxliBIr2ohQP72
 jDBigs6NFjCbr9U1aZdvqcz2P3CJfll38k3fnXE1hcuxLFtBYd46jZV7eF1pte4lVMsHgXpuA
 fv845hhnbbbuEkmTRX5OFmIBMLzYzeMt6xpYqLLP/P3c6tsQ/WIH+IUL1a2TQKwyFQ6Lq3flH
 F25XYS+1GCfMgB7dVDx7U3dOTUwGUzAUmCaeBT99LuAcw3zLEKZfJAPbVZvjijWW3ro6SDaU1
 Qjm8whj2c3K91M5jgkQWJbuWjBHcH5ZIXUdDew/8Hq+7sRj6kMqBofrrbHh/lzfZKvU0C6oZu
 gE2kNG+EGVDAH65RhW/dlagUcep6X7h1OyAkt6eBoOffLfL826qY3dWrkYPBAooxp5+EKW1oQ
 Yz8zjrzvabHXPx6hAUvvPH1LhyxdM0zPNkRbuqNYnVsVffzsTomiFLzzOJX25qNq5KNuJY2KA
 6tdctFp9JoPQApg7gUAD4Ke1+Z0kC+VjakFh6YVx/LgGEz4rRD++GwghkGr/xlJxr/Scii57S
 uCpIr/B00KyFYK754Cw18bbYv/JzRPedU99OwMxW9f9caGWy07NXxCj3zr2KdFTC1Qm360j7/
 qD0cusoHDbpytKy/zRralmEbKmQCxxaUhBhNaQE81xHHzheNTYcNhaCX6xOuvWRj6uLW/KIfs
 i3+6YbmDLNRzpB5f3LAACBHPM5dbpdNrLfRxWMQOhn578fKLVue2aakFlFlWZ9e/Z0hwuyq6u
 ++XXThPL915GLTxUqw23o3xPy74Dw9SUa39niDPnmqH/pLNOpt5SrzyMEg5ROV08T2PHNoOjq
 irbFI5/yMz2wnbbo6TE4tb7pywp7UVWCJ/V6GqfomqVE06RbcVCrU6D9B9uhPRZyvNi2A3q04
 Md5i5xTpEBDswEc2DIvklkuM7Wv0NIpUiOJMR6pTyFuM3XSH8tzFfuy7w==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/24 16:01, Nikolay Borisov wrote:
> This feature has been the default for about 13 year. At this point it's
> safe to consider it an indispensable feature of BTRFS as such there's
> no need to advertise it in sysfs. Simply remove the sysfs file.

I don't think that's the correct way to go.

In fact, I think sysfs should have everything, no matter how long
supported it is.

Thanks,
Qu
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/sysfs.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index d4502f0e4fca..715d1e725f2a 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -276,7 +276,6 @@ static umode_t btrfs_feature_visible(struct kobject =
*kobj,
>   	return mode;
>   }
>
> -BTRFS_FEAT_ATTR_INCOMPAT(mixed_backref, MIXED_BACKREF);
>   BTRFS_FEAT_ATTR_INCOMPAT(default_subvol, DEFAULT_SUBVOL);
>   BTRFS_FEAT_ATTR_INCOMPAT(mixed_groups, MIXED_GROUPS);
>   BTRFS_FEAT_ATTR_INCOMPAT(compress_lzo, COMPRESS_LZO);
> @@ -308,7 +307,6 @@ BTRFS_FEAT_ATTR_COMPAT_RO(verity, VERITY);
>    *                               can be changed on a mounted filesyste=
m.
>    */
>   static struct attribute *btrfs_supported_feature_attrs[] =3D {
> -	BTRFS_FEAT_ATTR_PTR(mixed_backref),
>   	BTRFS_FEAT_ATTR_PTR(default_subvol),
>   	BTRFS_FEAT_ATTR_PTR(mixed_groups),
>   	BTRFS_FEAT_ATTR_PTR(compress_lzo),
