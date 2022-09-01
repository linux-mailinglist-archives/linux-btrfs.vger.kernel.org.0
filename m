Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646FD5AA33A
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 00:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiIAWnA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 18:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiIAWm7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 18:42:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E68F67CBE
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 15:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662072171;
        bh=JYRalC8OJYkQBUshHL8rn6HjoR/bxrJJkHuXa77urhk=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ew0aAV8ElOdujPd71sJh1agfpoEy3h0Zh4tYBVp/wkGtpOaRCKlH1RH1jd+kHA4FL
         4Lv2VRngf7oC2WDIzn6WUKcRRftK77pyqp0EsT8RKGXyMPwLfgnpTRdeLwqUiumbaz
         IS0Xwy2r/76rNe+9hdfC59gOlO4E3qIhXLV6jb2I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEFzr-1odT8Z3sUX-00AIGy; Fri, 02
 Sep 2022 00:42:51 +0200
Message-ID: <bea03117-d8b8-78f2-93a1-c1b81457b26e@gmx.com>
Date:   Fri, 2 Sep 2022 06:42:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 06/10] btrfs: allow fiemap to be interruptible
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1662022922.git.fdmanana@suse.com>
 <5bf31c02f5117ece6a1f4709af1c8b938f149d3e.1662022922.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <5bf31c02f5117ece6a1f4709af1c8b938f149d3e.1662022922.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5Po2Uhypf4bPEdRzRzC1fVcTUVj3v8VcE0hWjLqZUSh5g/rjVD3
 /uUOuVShGKQfM8IFTbFG65dOLxTWiFHBEGeMleoMFpMHySdt9LnBdyIUx6d1GfMFrQSwb52
 YjhjcY+NGLY1hlTcYi2sAkQem/PGezVTFm9fUFwsesZLceIXdpmOkIOaZ0jt9F+G00TD3EA
 iQWG51tzv1+PUJgW7A2Ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xw3VmhMrV/w=:KlSV2R64OmeQneXAhtN3G6
 vT6jYdBqwI/AkynBugYLSBA01CHQDNK/uPggMQmwEfcBFQV8DKfLnJR6COpO4F3wL4a2EObSP
 4iBRr5uH1gM8YzW5gJDxMRIXIe768ZXTfrOfD72Z9Rjgg+1jZvqXkOtuGVkhwXdnNMETghh89
 XbkkJvo+nqN6qKxMVICyJJWrHsr3IjIFXAlEnig+ISqlSHQPHcOqYoJgb+tHuUUXnCUxOLAiq
 b2StlgMJD1y6r74eeW3TsxEhlMZUlFawOrg7AA1kEwQNg5/R81T85EwTUWEIaGPrMSJj6vphi
 nJCglMcoYlUX25Jm0wxPiAvASa6fU5xcVC91v71Dxr5THdcFHihmeGno0eeVLfRzQvC87vtJj
 cBzZqTSmDwcdWkOULc7PI8oyB4bQlP9xOob00r3pXsilCXki2mneG/IMuV7z+q36bpvnmGO1e
 0CypGIVp+LJ7YhoD9g8D+5GoSj/w4b36O9PBRJjNuIl4bKIhoSLZIXNKWwnPB2ylkCRg6YAWz
 L3839nQC7CFl2IJTuJeejdkvH7QCinr3KBIZJHxVxaSEl4VMZXjH3U7kHFeWSQocGj++PqEms
 HUMouN8YDlVvdafP6Q9//T41l8zFJMftIrP76fidNstBkAsd5HJsxgBnxEdUrHML8pu19Qtg4
 7swHaOaouxAGUzA/ApQP42qeK3LW5IbF+afXg0535z+HoNHKrKtE3PGL3j+ZVBdOyJvFrjbAX
 QDUqihDnhUc09VFdb9LWYXzi1p77MV6TZkne6aMTQu/CI6HT2HccpWNmrrCbtWUHKZ6xelh/t
 tulYHEQUxfewGWPxekenKBOYmqIaloWIKw0M9Q6PD+MidusEardG9Hpu65AVdxmNcDHNBmc6j
 macG7F617qLd/3BGbYVDLcWEYso2g2tByrcqoNJv1O0yD/PUfateelp2J3NZoVfF4s83Lxuw9
 owkoxqGF2Fvi/3Hq+LIQmbCzMoZ4qSMvPeWj1QArF5WlyurT7DTCunR25LFo269njy3leYDd/
 GdONUlsoKExMPK0MIlKPsT6mIC6jOHQtwEY8zoA1RRhH5sRKTo/WlEl4yOoF7bp+qJ5f4rTqn
 GNZv+a/SNYtFvFAWF5cZD9hn4MdKGzMx7RWWzkaj5R//ZPJKjxX6RRYHx214utgicDBsTE3Wc
 vyampognqs67XIAx6GWBogiZWv
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/1 21:18, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> Doing fiemap on a file with a very large number of extents can take a ve=
ry
> long time, and we have reports of it being too slow (two recent examples
> in the Link tags below), so make it interruptible.
>
> Link: https://lore.kernel.org/linux-btrfs/21dd32c6-f1f9-f44a-466a-e18fdc=
6788a7@virtuozzo.com/
> Link: https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno=
.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just one small question unrelated to the patch itself.

Would it be possible that, introducing a new flag to skip SHARED flag
check can further speed up the fiemap operation in btrfs?

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6e2143b6fba3..1260038eb47d 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5694,6 +5694,11 @@ int extent_fiemap(struct btrfs_inode *inode, stru=
ct fiemap_extent_info *fieinfo,
>   				ret =3D 0;
>   			goto out_free;
>   		}
> +
> +		if (fatal_signal_pending(current)) {
> +			ret =3D -EINTR;
> +			goto out_free;
> +		}
>   	}
>   out_free:
>   	if (!ret)
