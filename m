Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB960CABD
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 13:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiJYLRc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 07:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiJYLRa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 07:17:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C7D1AD9E;
        Tue, 25 Oct 2022 04:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666696636;
        bh=7AL7EYlm4Xr7IAbvlSQol7iSCIjAwmR3cBHLfZ9D5GQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=FfExlaxnQnOI94ltIE3h72Cpw8lUYk84E+G6GfM9y5/yZ+lx+Z9J4cLwxYW0bqaEX
         VqqI33mKdHJ4iVkuzQytrUGdyTZaaqc/H5adh5qWWWi+a7yON/LwfvJwfNrZb8lt6D
         U3N/hm4/I/CGPvplWg10bEq0JjAiMOcPsLCKgR+c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHoRK-1oq5TJ3Zuo-00EqxQ; Tue, 25
 Oct 2022 13:17:16 +0200
Message-ID: <9b69ccd1-2fa2-512f-a3ab-d9a8cf723350@gmx.com>
Date:   Tue, 25 Oct 2022 19:17:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] btrfs: volumes: Increase bioc pointer check
Content-Language: en-US
To:     Li zeming <zeming@nfschina.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221025105244.5212-1-zeming@nfschina.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221025105244.5212-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HXX7PEnJTPRb4W6VEufn5O1yC0dgUcCDYmJIzLkhwV0NgRbwGNt
 JFxrQ/p/fme3e1ulziZGWdCxW5nrnjkB2OXS1aQ1lYRAi/2d+hBGnpd80gzQZpHvJJIQ8vt
 KNRrrIzLx+kB1dvnluQqDgK5j43qvbm4c/Ghn1dED6EavIUZpsPEyQY+I2FWFKGfpVTAQs/
 UZJDZBGM4LLJTJMlEYirA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WiWYavo94iU=:fZVxCs0prbKJvXqcadGHdQ
 oM4Ra+AV72/FwH8fOb0jywi4tO4F0EmPhCLXFzXpaXo5yUoAAAbeVsmWGpFrUgHotgYZ7UHUh
 CZ3sdAQbgS+6geoSVQJRo74b4OJnvoEO8hdpLnTxPNEy43yPMLESnRHfiGIcxvNoG56+PzSKO
 uMoY5rb3RZusQ8xzEZxXfqPwjcN7+TIIzrzA5ROxPnAkamPu0VZOZphztbG/uqIVvwjiiUlrU
 1x8BHAq/4sc8S8rCwdHpLJHd0qd2SrtPBQ2viPi3B5cw19WXDHPAgW4bQodFDuatdU/bqlRz/
 U1PsnEDcqvoa5NVjEEAofHSEC/xZYZm2qyL/gYQcK2DGF6lDbHoxIt2nYqA/vT+s1oi9KaO9U
 Ey5tPxyaJw6+9XNz6/VmEIZoGBRJRqTl+pz5YBQKASZOxkOf3Jph1QbdPXaU9OD91u0nJHDJ3
 cgnREAi/LS+icFKoEPw6mJLyQD9wxytwJwZwbRrhjCLSgItm5z6s+qHf4mbaFD7IwQy0jcULc
 tewocIvoBigfZPKwk04AuGhwXIPj5ApOLalEBMXO4TcE3fwoqY3oP/IXzY4AAjHLthBkz1wui
 6olVcc3jtFe8+JHc43Tt4/JqbVAv22FmfqX+5A/KCfC2fssy57qCaaoo+7kUbKHcmZ6eFMVL4
 TCdS9yEeGMdyizPNddnlCplvYjqOjMTWVpNvt8UpgM/3zCiuQ+lhdaTWBWg68jDFNTnW2ESxe
 c2dSLWcLBUY3i+IVgdIFDhQeshREcPWch/d4fdfoDFooSqx4z2Yh9E/xV8GkXukrm0mDEieYZ
 Ubt2iJAk0F5+R2lxivB9ZyvfkxEgMOPyskGZwPYBrgc8LYlGsnZEwowHqIBf4CsaiJPSDTYyC
 o0QJRHzXlipcAQYyE8g6IXytlLFUKLEZQiOiZ4riftfpm9SekyIiFsfij/oGhe7EwP1DX94fw
 A37JLezkUk0/YHy3nBwK2aTO1iMkR8PEZ2P1h2gXAVVcMZOgOWosj7Bd86sO5y6Q6oMpqY+qJ
 sTK+uHf9uQ+uskEdisAhHF+e7Gpb6cbzwBXMWso2V6dbv0pLWSmA1SAm9OV+8PR86kwfC5ud5
 o3Lrd3a1sOepyrGmPyFr9hPQ3wmVzIXcfEBJPXoplbMia8QEXpPEZsv0brpQgpalS6vGIasvA
 VMqww7sJ1Nxj7Dp0YBMVN7GIsXVTU+z6ydACsMIrX74MqQJlLceWy5+VfXsI52/ZgEv6qGLZz
 O5B154HItOBnKzvjXbaWlgxoisNvK49o3rOBlyiyjzvS+PVKMhJXraqKFzg2wRZqjr1EoGYCF
 jt8H7gNfqbzPhalRum0axiivPmGXVSEvucWif8J3Hu1psAH9tthQ/Mxu0dKKwNsW4sxh5TvXr
 MX2hYQEjuByjOY407epri9q9Gf9UWOrGuZ29cO3RwIaXMumAGf+SMOhwKHqwryIgSUJ9EaCWK
 +kMUrut1sTo9xZmygUAmw8SwOKR0HGED62YvasKxCoYaMwctb59pePI/BUEZPDMCxLpQ5GLtU
 xuvNrvpWiCUSy76Zwwtda/Wx8Q2D7rytsgZuUri5+67n9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/25 18:52, Li zeming wrote:
> This patch has the following changes:
> 1. Modify "is returned" in the comments to "should be returned".
> 2. Remove the __GFP_NOFAIL flag from the kzalloc function, which returns
> NULL if kzalloc fails to allocate memory for bioc.

Firstly this part should be in change log, not commit message.

You can just do a search in the mail list and see how we handle patches
with newer versions.

Secondly, you didn't mention why we can remove the __GFP_NOFAIL flag at al=
l.

The commit message should look like this instead:

```
Currently we allocate memory for btrfs_io_context using
(GFP_NOFS|__GFP_NOFAIL) in alloc_btrfs_io_context().

But there is nothing special for that function to require NOFAIL flag.

Furthermore the only caller of alloc_btrfs_io_context() is already
handling the ENOMEM error properly.

Thus we can safely remove the __GFP_NOFAIL flag, and handle allocation
failure properly.
```
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

I'd say, please don't add my tag until everything is fine.
I did a wrong expectation.

Thanks,
Qu

> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>   v2: Add annotation vocabulary modify, remove __GFP_NOFAIL flag.
>
>   fs/btrfs/volumes.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 064ab2a79c80..b8d901f58995 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5891,7 +5891,9 @@ static struct btrfs_io_context *alloc_btrfs_io_con=
text(struct btrfs_fs_info *fs_
>   		 * and the stripes.
>   		 */
>   		sizeof(u64) * (total_stripes),
> -		GFP_NOFS|__GFP_NOFAIL);
> +		GFP_NOFS);
> +	if (!bioc)
> +		return NULL;
>
>   	atomic_set(&bioc->error, 0);
>   	refcount_set(&bioc->refs, 1);
> @@ -6071,7 +6073,7 @@ struct btrfs_discard_stripe *btrfs_map_discard(str=
uct btrfs_fs_info *fs_info,
>    * array of stripes.
>    * For READ, it also needs to be supported using the same mirror numbe=
r.
>    *
> - * If the requested block is not left of the left cursor, EIO is return=
ed. This
> + * If the requested block is not left of the left cursor, EIO should be=
 returned. This
>    * can happen because btrfs_num_copies() returns one more in the dev-r=
eplace
>    * case.
>    */
