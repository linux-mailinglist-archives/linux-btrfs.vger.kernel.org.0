Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7334C3E0E7B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 08:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbhHEGjb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Aug 2021 02:39:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:52381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230183AbhHEGj3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Aug 2021 02:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628145553;
        bh=RtrNGxy+IEIQtdoNiHTGUxAgbOGOXOmx7FmzznXud8s=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=RRM+bCibeAkdptXnuezYt2IQQEhZBW5SJRaQGJMbTJRs7ycEsunSkRu0vtX9tF2hO
         fNpKMC6dCPWCGVow99tON6cdauwn6Fte1ZTD5u4zuI8S8ix3NPvXtagoj1nHjz1yMz
         Lurfswa+xdBuO59brzURXNVYt3or1C5n0j7va5rg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEm6F-1mLlNb2v5n-00GIvY; Thu, 05
 Aug 2021 08:39:13 +0200
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com
References: <20210804184854.10696-1-mpdesouza@suse.com>
 <20210804184854.10696-4-mpdesouza@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 3/7] btrfs: zoned: Use btrfs_find_item in
 calculate_emulated_zone_size
Message-ID: <5f66b9cc-288b-3f26-ee36-9c2ce672c100@gmx.com>
Date:   Thu, 5 Aug 2021 14:39:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804184854.10696-4-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hEk+dVwfzLCxnJu/+FCk9I1AXCAc8sZ695/0BoAB/4K1chzacKL
 GoeVo1JRmpPhZZcw1qrHxza7dyb1bteFaP+B/a++6n1hd9djB7M8p2HNqM6sQ4GB6CPWHJY
 BAv1m5To/RMOq3RGn+NGR1fbwrCbIDcOOCRbohw6nlNXPkIznHBOuSiqd/NJ+z7J/byXOTu
 QDphfJTVZ0nbjIX+WhVlw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cJn7DiUh7EI=:Nk7vWqpB42TQuha2Y1+Mlk
 q+EnrJDHxm74+R/1ToCzBYJbHVDT7vSA6xMvI1vdSLwkqdECbn1S2bQ3JI1qehSfAWTd3KOXQ
 QpoUGRkIzz0OusGCtr6G8zohB3dX2lVKyDP1ZWkTthRQQPE2u+xNg+kj5e75Udj0wvWFR0J4s
 DW0hW4yea57V2xUxE9Y6ohsHw8Gzz/kpJAAS3Dt/vWKMJ+3gh8SdeGYNpzLFakF7KfmoKKX7S
 o6fs22lw7lu50gzJ5a3KYk3z6V5PSq6NdXj8HUJqmtGGd8n4jsKMNp0S/DmkYj5/PsTCSWDGo
 3HdzE1Y2eW+4Nm3OsXFIe5NTUqJntxex8M0AXoz4j7LhTJ3LW5XJjE7kNo5+PgxXVkSHHbTBZ
 CCgD8cTCx0PMj9hAu72btkVrsgGYMotBMwa+G33g+rzsEr5eV0nx8dRfPC6vMQeDlGPnPOgFR
 G/M5/15J+TFMPKRl23d2lPBQN+CSymuKYGtWD1VsIO5y5X8qxo/l8V3rHH+GbG2tRXhEYJlo2
 VhytDNVoILJxHK0rfDoJ4NMHOB1uuWmgrh+EGWi/h6o/cxYH3iImSqHBg6OibgC1KyMbjMHt8
 o1988NYZ2RMLmEIKdEyZNcQ9zrq6GIB1p5jOebvrUMBWp+5X1RAqwSoP+IeSyF9NeWmmDJ71z
 2+BXpWf8tXGvHR8Cg0N1XR/SyBFhhx3lh+5lUIoyVxBRoks0j8CqrMONRo87BDLD6K1Ciltd4
 c6squUtD5t6fh+FbVM/5lBJBSe2dsEyE1WEoqte6WQ4wzwZAKVmgkCrTA65JqcHXDXWVkhdKb
 c1779y6wvMqlwrXjHk6rrW0Jo9+g/iJ59hiVwbk3MJ7+qXLOqSATIONRFyCVPzc6vuc4d25ak
 rUbBEKAQN7mlBGxA6FfQpXQT7ghA6kkEJ1CFTjnIlemeZN7c5pxB1uytJHuxIgC9f67yw4Zi6
 +7y3nBC4IwbwZAXU+Aqq7TRW0PDCnb9b7Q4NnvYAE0Y3EvVhVF183Ug6o1lZ6qfs1R0eRWwC2
 nrGW5fW5Mmzko7xDwEjMUicr7pgtPRN94kKChbRfQiGPOUTl+JcXVi9Y9ix0mbccKiEQJ1hU7
 QyVE518qAGRl7XQ43jVTQHBiZ6FFnl+NGDzXtqCPbuHnxSiCKPIXTkXJA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/5 =E4=B8=8A=E5=8D=882:48, Marcos Paulo de Souza wrote:
> calculate_emulated_zone_size can be simplified by using btrfs_find_item,=
 which
> executes btrfs_search_slot and calls btrfs_next_leaf if needed.
>
> No functional changes.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

But since we're here, some unrelated comment inlined below.
> ---
>   fs/btrfs/zoned.c | 21 ++++++---------------
>   1 file changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 47af1ab3bf12..d344baa26de0 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -230,29 +230,20 @@ static int calculate_emulated_zone_size(struct btr=
fs_fs_info *fs_info)
>   	struct btrfs_key key;
>   	struct extent_buffer *leaf;
>   	struct btrfs_dev_extent *dext;
> -	int ret =3D 0;
> -
> -	key.objectid =3D 1;

Not related to this patch itself, but this immediate number is not that
straightforward.

In fact for DEV_EXTENT_KEY, the objectid means device number.

For current zoned device support IIRC we only support single device,
thus it's fixed to 1.

It would be better to have some extra comment/ASSERT() for it.


> -	key.type =3D BTRFS_DEV_EXTENT_KEY;
> -	key.offset =3D 0;

Normally for DEV_EXTENT_KEY, the offset is the dev physical offset,
which normally is not 0 (as we reserve 0~1M for each device)

So this is a special zoned on-disk format?

Thanks,
Qu

> +	int ret;
>
>   	path =3D btrfs_alloc_path();
>   	if (!path)
>   		return -ENOMEM;
>
> -	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +	ret =3D btrfs_find_item(root, path, 1, BTRFS_DEV_EXTENT_KEY, 0, &key);
>   	if (ret < 0)
>   		goto out;
>
> -	if (path->slots[0] >=3D btrfs_header_nritems(path->nodes[0])) {
> -		ret =3D btrfs_next_leaf(root, path);
> -		if (ret < 0)
> -			goto out;
> -		/* No dev extents at all? Not good */
> -		if (ret > 0) {
> -			ret =3D -EUCLEAN;
> -			goto out;
> -		}
> +	/* No dev extents at all? Not good */
> +	else if (ret > 0) {
> +		ret =3D -EUCLEAN;
> +		goto out;
>   	}
>
>   	leaf =3D path->nodes[0];
>
