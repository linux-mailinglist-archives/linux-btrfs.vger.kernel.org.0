Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E80410DAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 00:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhISWqo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Sep 2021 18:46:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:42295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhISWqh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Sep 2021 18:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632091504;
        bh=tEYH271czTR+hIK8ZuXtHvP0Tzp7KxVJE5QaooMyptg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UZxfbtMY6CcxK+e9/D77CEe5Cw5TgyxB0GhmOjsb19Thi6UgMbv/gIl//634W1oul
         LVGB7uQUvHgGkBdcCPecxRDWazWgTDbXki9F10udX1Ndhjux5++WggJWCs/VKCwNMX
         euUa3y3rJdMzTRzV2zQYDCZ9bD/iOD+P50AvGc7c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAONd-1mcDky06nr-00BsQY; Mon, 20
 Sep 2021 00:45:03 +0200
Message-ID: <b4f6ec59-daa8-d4bd-d6b9-25d854eb70c3@gmx.com>
Date:   Mon, 20 Sep 2021 06:44:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] btrfs: fix initialiser warning in fs/btrfs/tree-checker.c
Content-Language: en-US
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <E1mS5UF-002wsg-0c@rmk-PC.armlinux.org.uk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <E1mS5UF-002wsg-0c@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LkI7/1+1DGPJVgUCcXHwppgcuQnsuW5K+7ujtFipOfdpy/Pl/1i
 dNNRlypkvvTzKWqmyLvRmtbqwD+FYhhJWXZAc/cfOXMJWo33PuO0DFJA0XW++Y46uvqfLqj
 cIL9QxuPHd0TBn8wLQGIw1P7z8A8StTpSIWw3fRy0NYcW3UVh/b0OiikvrDo29hKcXUOhO5
 mk2N4q+hTv9IYbuVWkgSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ohn6L8aEKmc=:hVSWA+b2f9DADbsilHAb2U
 lePQYDZZKuUUc8QflQ7EdBBymP4U/XU1Uu2bc5klkg1xUVwF6PEEKI8i9isUak/cT7g2YVlQT
 MBYZsM8PHH0MrAmj6wwtfj/JfTl4l2Q2KXFqJWzm+zxo+H2cqlXNqVKV3geXAfPnknA7Ydemx
 Sld6cmhGhOBOSUeuSSDbF+eGYgcQ2TfAlznPvy7IrcHoUxyStFo4dhG59NoG2EPi5bfiZTFYU
 Bd9kd30cadrpkwJhr6sb1I/uMPj4mZW6PwrHvz6J1Im8SfMeWpavuNrLvPdlnqLO5I2DUbUaW
 ZEnVEPTSQNuapNB9fq+qZBQT3P3SAUTUPieHkmTEgEH6lON2ZVdKS0GkA2Ui8ndGmHso1kevX
 hpZ76skD05D/PN8HQ3azWFE03trT1nyZquNmnCTYGizVgGiA6ArSojtZ9xnwuWF0zbHPAIr0D
 CeVJVY816X4EL8sSk+Sh8WNlSUHpSaSeheLeccWfYe/NJvPPRdrSCafvrBHeL/HRq8VI7SbVP
 eXDfHzIqrIMP4zcT+jFfntVh1zXLBjrWtOzwS2coaxk4w0mV4h8ncUTCY5OZBgA7XwlPSLRsL
 P4kNKpAK1h+qA2E3wbrmxIcPZn/3/UJRjhl0AipiENI8esyUS9QITc2a03F8wKWzj1JHT0YfT
 bNpkVWTokIlON/J9yp2l/eKiwHJPVz8RAeFHdGB9CyHZiHObPF3hqIfL7iWuK1Q+LmeyfaW5b
 aTvI52doC1Y4imCJFekcdzDie0gBOeaGOzYwlf2HLFLauN/hTuqkamOJdQDiH4lya0ZH6JtyE
 YMjQXFygrV8MlkEopi7dkae4YqoEafBkJjauj1SMiz6fUVCCxBGEZSNXMnZLtkDWMHlOhVEoy
 pUoPKSirk37btk4L6pKGpZaXsh0g0ReT+om5oEwNNMUFXNycfXmId+MOrZb9o+J90oRVyPljM
 nmSxZTNZOgpuCv5NQbh1EijupwOLGKZPUutGneJHlG/ZBcveObjyvO4pF9/0Che6U7eOUBGv3
 6Sj09+2mjCOj1pliKBzLiUkj8e8G+Q9GdlEHy3zrI1rDw+eR1WoU/djkuCY6meVFdVyi07BlG
 DBxYGD8BYkUJqk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/20 06:40, Russell King (Oracle) wrote:
> Debian gcc 10.2.1 complains thusly:
>
> fs/btrfs/tree-checker.c:1071:9: warning: missing braces
> around initializer [-Wmissing-braces]
>    struct btrfs_root_item ri =3D { 0 };
>           ^
> fs/btrfs/tree-checker.c:1071:9: warning: (near initialization for 'ri.in=
ode') [-Wmissing-braces]
>
> Fix it by removing the unnecessary '0' initialiser, leaving the
> braces.

This should be a compiler bug.

=3D { 0 }; is completely fine here, in fact =3D { }; would be more problem=
atic.

What's the compiler version? I haven't hit such problem for GCC 11.1.0
nor clang 12.0.1.

Thanks,
Qu

>
> Fixes: 1465af12e254 ("btrfs: tree-checker: fix false alert caused by leg=
acy btrfs root item")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   fs/btrfs/tree-checker.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index a8b2e0d2c025..1737b62756a6 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1068,7 +1068,7 @@ static int check_root_item(struct extent_buffer *l=
eaf, struct btrfs_key *key,
>   			   int slot)
>   {
>   	struct btrfs_fs_info *fs_info =3D leaf->fs_info;
> -	struct btrfs_root_item ri =3D { 0 };
> +	struct btrfs_root_item ri =3D { };
>   	const u64 valid_root_flags =3D BTRFS_ROOT_SUBVOL_RDONLY |
>   				     BTRFS_ROOT_SUBVOL_DEAD;
>   	int ret;
>
