Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E31522730
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 00:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiEJWsv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 18:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiEJWst (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 18:48:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFC222B398
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 15:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652222919;
        bh=P4tFMy8+RqpPLkRDFuJGddpt2NvJfCjNeSSuE2guJ4g=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EOpE8HyB2EI5jg7O+y8Sjnr9vhQJuoGc2MOpGg/6bKaThTi9Xy8NmBBcwJuHjeBwz
         iA5OULH2u4lY1yyKi8IRA5nSZOnFM1bbVoG/f2RovwT5/FQFmmoMVK54qN26OAo6DV
         gVoQwA9oJITmdSixew9z5bocjgDC93pL2VcTLShI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N49lD-1nxOFD0X1V-01048s; Wed, 11
 May 2022 00:48:38 +0200
Message-ID: <ebc77987-0212-1623-245d-8c79cba5fa80@gmx.com>
Date:   Wed, 11 May 2022 06:48:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/1] btrfs: simplify lookup_data_extent()
Content-Language: en-US
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Marek Behun <marek.behun@nic.cz>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de
References: <20220510194338.24881-1-heinrich.schuchardt@canonical.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220510194338.24881-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4vGFVR9bvggwd3i1ydT9SGPswOOo0OHcaJGFc52e1n5Wy9sBSTd
 TrWb++F5+5Ux7SY/5HP7v6ygRv5cFPQbPi/OiDu7y0is2zD79yvNx02xRvJhQrGnAisAtAH
 W1n1MUFhEpHe1Kakzr9vbjtZZA+bOUmBiRfH3TIMDWSz98KyWGrt5ojPFfZ4N0IrPldFt5w
 Kd2L/5BHXAllhxcW87S1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BNY3PwPAkfo=:iIP5H1KJLk9nFoaiuxYjHL
 Pasv0LSIDHSRx0cL40QFmj6W64L9EAHybpMF5aCOqvPxYelyBpqKql90eGQLe9+HiPezWO/jI
 UJ4uptDwDr3/45umDrT7N3wnuvrNTNoxmdOLGdEkZlyxaewjso5n7AJvdBVpbp/W7h5Lpu76q
 hvd0e4/SM7ZmCJg+9JeHndopJ3Ezk6HtGC8+HiILIBYxTPDDpIxlgUH60i/VXA9/xMfpCT38C
 FAiGuC6ftHKi1vLCSYWHEgdo7uBok9I9IHQzpA3HhuqL+UQyICKiJ0Hmi+wKiOoW6iG09SqXF
 R31G08PXtYbQl+fRIQv0pVgX60I/PiEFFpWrv0yoXkbKeh4G0ewleRrRPnlQYMSYEJJHoe7Fx
 oa4/sDP4CFSJ6Qqr/ykY3lcO3jkMKYaBWZs4EYaKdvzWt0GK7PDrf8QajSsRVu2Kx+FZoASow
 k4yxwKWBLqoTWkPFUh+Hp7DbkDVIFf9+NKzj24W1dvcURxDTNVhS0cSLqRpxu12uL9O9/U4c2
 mrLP5CCbncXp19T8wxHE/CzjmHnUNHLt64COsR4UtvRm3bjLscypEyp6M0D/EQrucviXNMsSc
 BOLglxOFGQVU9pg5WM3C0XHarkoi+/E77CxWjXwNG4A2F9mOzISYvh87MKOPyBLlNhh1a6cQs
 Fi0f895I6VEw0HkLDZB0WovTNQxllP03Q6dMAadS212UPKW91Ma6dG/NGN+5r97gfYEOKwpBp
 9ZrIa9ob3g3Z4H9jAIKHVw5xbglXuto3Lf+KXJ/BOMpFO2F5wmVNt3iDak8eO3wzTSRhKpC9N
 Cfgtd9wq2NsZaWMYQO1QOIe+/ScEu/BZWdJ/+eXbSIJ2IdkO6WTCru7rGJGD1rEnmVB8eDb7Z
 8nCzwiu81V1y3JFwczlmfgM/5xrow/XsNST+CFrOMlQhLWdjF11RMvannqdPprfaK6pPPHE+m
 00mz0QiP17ZitOpqjzMnutYK/xEZ38hbH8Ei1zUmZ8EnUOhml01G6Xg7850vKmyVlcU6P/Bxr
 0mz7aJ87gTZufU+jPZesiesTld6X2mdgFtJFAI8FwEIntEFQGaNKxhXE/T3afmRgQp6h2FBoc
 Zh8fT/TktBqO+dlvwC/UB9zGeU3ZpvS+nGozKsz4x6zvl6vHFNUJ7xxPQ==
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/11 03:43, Heinrich Schuchardt wrote:
> After returning if ret <=3D 0 we know that ret > 0. No need to check it.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d00b515333..0173d30cd8 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -546,15 +546,12 @@ static int lookup_data_extent(struct btrfs_root *r=
oot, struct btrfs_path *path,
>   	/* Error or we're already at the file extent */
>   	if (ret <=3D 0)
>   		return ret;
> -	if (ret > 0) {
> -		/* Check previous file extent */
> -		ret =3D btrfs_previous_item(root, path, ino,
> -					  BTRFS_EXTENT_DATA_KEY);
> -		if (ret < 0)
> -			return ret;
> -		if (ret > 0)
> -			goto check_next;
> -	}
> +	/* Check previous file extent */
> +	ret =3D btrfs_previous_item(root, path, ino, BTRFS_EXTENT_DATA_KEY);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		goto check_next;
>   	/* Now the key.offset must be smaller than @file_offset */
>   	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>   	if (key.objectid !=3D ino ||
