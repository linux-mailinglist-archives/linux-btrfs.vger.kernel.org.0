Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C413B5D43
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 13:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhF1Llv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 07:41:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:35287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232884AbhF1Llt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 07:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624880317;
        bh=00G7pzR1O9LgCBM7CPR6hiHOXgoARTMTk2Q1Z8dY/SY=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=GO0RHG3VZRfL5Pzr7ZNlpYaW8LfPDxEjvHKW+C2dnhcusSFnFLKLhPEM3GuY/m0qc
         FtJIPSnzvyfMHuiLNv3x9ij29vgOWcT5b6jE+UNcWCA1dLF1mSqE6nNI4oDKXVxM0f
         t0sb8fI0uAtPJsAfJayMVSBBQBK9m+i2NBhu5Dzk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3KTo-1lGHaI2TlS-010MPK; Mon, 28
 Jun 2021 13:38:37 +0200
To:     13145886936@163.com, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, gushengxian <gushengxian@yulong.com>
References: <20210628083050.5302-1-13145886936@163.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: remove unneeded variable: "ret"
Message-ID: <0220a6b0-a948-daa3-331e-1332588057e9@gmx.com>
Date:   Mon, 28 Jun 2021 19:38:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628083050.5302-1-13145886936@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cAubsysGtGV03CoD+DkB53fjInzdFpm4lB5hSQ28jADKa4bZoaT
 85A1bXajtVYGlK570yt3tDL5bCamEjsMlEdbusnlfSvpfuqnUl8v9JLsVQKnIwq/UhZJJyA
 eFd79N4ok/GWNCKNqsIuE5xbZjYiICaDYei+G0h6QG95Z4iNrqkR7KMD6YLLr25zi5W7eIQ
 YKjYRKQALjoyTMxogeokQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nNAC8qQi56A=:I9IZBgeEvImvPX96jiUo85
 SqTzTuYnFRdscy7QajwIrgPBUDBFnQM4Ff1iulPft710X2psdFhNnfmy5PIDQDx6hC2nzzvo8
 qDIOO3mHlzjZt7d6dB8CvmlCJyw9nlVdEiRFfcejzhZ/PZoTENpZ39FYklkDRbgM8YfYkRfQm
 qoJoDAen31zTRtcITrXg6MVS0Yf2NxZ/yoZtAdzCTt/avyeCaIon9dDw6aClC0MbnygrXC3wa
 SUqHwzx3/RA3FpvxEQ+kuQWvHl0VedKNNzUFYZp7IXeBgmjxRinTZuoHs87LajNA+1E6XrYdk
 bNkvJP0SMQYIRIZgpJlMG4B+wL3++2yO8WGAdS3G9umYvMW59VBZ1XOa8sYeXwosqEEWxwOOW
 Rq86/Q5k1tYH480TkipPNzb1JTC+rI/HYUMXdcaIEIVu2OYj7iyTh9nuNEI2V4AkpKBEr3Czc
 BrYYSVdW9funR+M3VI25ieSXV6Qs8aTjNJk2oxFZRloBr5KQH4qVnF8dgWt9l+2gFwZzNAv6M
 hex8x6DFr+LnM7z1hPp8Serno2n8fmdD1q9Dxa05YR37qFe+IRPNUVkYFsKdf8Bgt5jHEIT88
 i6srGb4Ph8M5mAoBE0ujg6LVdLda/4GfuEC28sjuMc/6qLd3bE68Uk/02Yia+M+/beS56Xpnu
 lT8lXURaYMpePQaCmqWPkletrR6T8Z2LYGW7XSfKo2JXWPyZd5lQOVaSd2BaVLQoPUZCgOr2Q
 6kcKwYGL9KvmR+VgYtvwziLs0+Js/DpiItJTCDny71ca9eXh8m3eY8HhHthVfzp+y6EGaRECm
 3nFdspeSPSe5HKg4q7Cfpb5TRMsc91iZNvr6hucpAkfolVLF/1m1SyqW1C3LVhIbsuEVEZBd+
 3UqqdBUrCTdFPVECGtjJXiu1MUajWnYZGdwgDn7/MEkTsOQiudG+TtzMuf12X6lsPWp4kWTVZ
 67G0tiIQZH7KEKzEMMcAA0+KPJgIsxk1JgzSwHbJN08tlhq/69S64KBwpQmi0GRIJ6eajQfar
 sVS+Ij9sCLlzm6yFKCCG+zVB0hLYy/rAn6nVZ3nVKtjvR8ojTzt5rh1i/peMtS58zmJ3+B9VD
 TFt+nuhE539mrnk3g0Gw9FDjaPCPfWeFaEDaFeQ4QUK9RzusgmaPK/OiQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Gu,

On 2021/6/28 =E4=B8=8B=E5=8D=884:30, 13145886936@163.com wrote:
> From: gushengxian <gushengxian@yulong.com>
>
> Remove unneeded variable: "ret".

Considering you're really a newbie doing new contribution to the kernel,
I think it's better to give you some advice to encourage you do more
contribution, while also be more professional, and hopefully to help
other individuals in your company to contribute.

And I hope this could also be some guide for new developers to learn a
trick or two from.


=3D=3D=3D WHEN NOT SURE, LEARN FROM OTHERS =3D=3D=3D
First thing first, if you have something not sure, like how you should
setup your name and email in your git config, try to find some merged
patches to learn from them.


=3D=3D=3D EMAIL ADDRESS =3D=3D=3D
Firstly, your mail is sent from your 163 mail box, not your company mail
box.

Peter Zijlstra has already mentioned this in another patch.

Normally if you want to send a patch to represent your company, it's
common to send using a mail address of your company "@yulong.com" (Isn't
it called Coolpad Group nowadays?)

For how to configure git-send-email to use the SMTP server of your
company, I guess your colleague Hu Yue <huyue2@yulong.com> has more
experience and you can definitely learn from him.

If you want to the patch to be CCed to your personal mail box, you can
use "--cc" option of git-send-email, as most reviewer just reply-to-all,
thus your personal mail box will definite get the comment.

This will make the SOB line much cleaner.


=3D=3D=3D MAIL LIST =3D=3D=3D
This is not a big deal, just something optional but really helpful for
your next contribution.

In this particular patch, you only need to send the patch to btrfs mail
list <linux-btrfs@vger.kernel.org>, even no need to CC the maintainers.

LKML is fine for your first several patches to get more comments, like
this one.

But when you get settled to a certain field of kernel, it's better just
to send the patch to the related mail list.


=3D=3D=3D FOR THE CLEANUP =3D=3D=3D
As I mentioned in another thread, if you use some automatic tool or
script to expose the problem, that's fine.

But it would be even better to provide the tool. Fix one small problem
is OK, but fixing a type of problems is really what we want.

If you really just found the bug by manually scanning the code, kudos to
you.

But if you do more contribution, one day your time will be too precious
to be spent on things like this.


Just like an old Chinese saying, give a man a fish, and you feed him for
a day, teach a man to finish, and you feed him for a lifetime.



And since the patch itself is fine.

Reviewed-by: Qu Wenruo <wqu@suse.com>

And really hope you can do more and better contribution to linux kernel.

Thanks,
Qu
>
> Signed-off-by: gushengxian <13145886936@163.com>
> Signed-off-by: gushengxian <gushengxian@yulong.com>
> ---
>   fs/btrfs/disk-io.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b117dd3b8172..7e65a54b7839 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4624,7 +4624,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,
>   	struct rb_node *node;
>   	struct btrfs_delayed_ref_root *delayed_refs;
>   	struct btrfs_delayed_ref_node *ref;
> -	int ret =3D 0;
>
>   	delayed_refs =3D &trans->delayed_refs;
>
> @@ -4632,7 +4631,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,
>   	if (atomic_read(&delayed_refs->num_entries) =3D=3D 0) {
>   		spin_unlock(&delayed_refs->lock);
>   		btrfs_debug(fs_info, "delayed_refs has NO entry");
> -		return ret;
> +		return 0;
>   	}
>
>   	while ((node =3D rb_first_cached(&delayed_refs->href_root)) !=3D NULL=
) {
> @@ -4695,7 +4694,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,
>
>   	spin_unlock(&delayed_refs->lock);
>
> -	return ret;
> +	return 0;
>   }
>
>   static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
>
