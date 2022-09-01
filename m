Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833255AA2DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 00:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiIAWVR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 18:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiIAWUs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 18:20:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18646A1D19
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662070748;
        bh=dHvmJljyymfrLEyge2UG1DsrovPFG8t1tuP/8r3IwV0=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=aEX3g1DnPHHjWl4lrVyI3mGc7f08og2Tft9AEc1wxty/YUznhQnN+chvDBU5OjARq
         6teNL6izFkMJvqd+9nUqcaJQuAKuF0hH5FTjskuUWisS9f0zTxQxJ66EUXob2+ulGf
         4XlfaIxusAphFNWBZRhyQ22aZQnRS4mXwjP1wmTo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8hZJ-1oPDgo45XV-004nPH; Fri, 02
 Sep 2022 00:19:08 +0200
Message-ID: <b2eaf693-05af-6121-cddd-d8dc36e9d07f@gmx.com>
Date:   Fri, 2 Sep 2022 06:19:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 03/10] btrfs: remove check for impossible block start for
 an extent map at fiemap
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1662022922.git.fdmanana@suse.com>
 <a33ca7029931ae0a076cfe0a151881bd43016472.1662022922.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a33ca7029931ae0a076cfe0a151881bd43016472.1662022922.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ItGBCWacQEbKoA6S2KG8iPiOTwJpk/HgqoWfg8eup3xmvUKwCit
 yQEeofQJUj6g0H9YIrZ2O1TZrZZb9Ef66ANiGFLB9Z9bhN2/MHuZhGO3n5VXI/XYjzrn08l
 NtOtTrxTTSL5cniTZ22EaNCNwKplGzHyF4sagmrcihX0rfclqq+smqzyYgz4c+1dWBRtI07
 UFSNaY+x9t5oFru6J1RGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kuxy0C4111U=:2ccUYb+UZd2N/n2cpeBNyG
 +ZlwCijLihhfhZYThrib1OjOrzDs4Rz+A0TMYCRW0AYIZeHi1l9dJ6vgknBtr28WGrVs9FCoM
 WIAKcrgbERp3OYPVc42+XI49Yvj7REx1ZR7vl8m3x4ID0yrZdvq6aVD++CZEDDIWn9xJix1HL
 SbcS9EKehp+pGUjM8A10cZFwv0T27taAHjhyV/8OycYyjqZo8ZgnWzC6s9DmtZjDUdfS6UIWi
 +RlZ+v/THEzgnuxzKtB+3NiWgcO0gP/ZH1hnaPPMjMm05wMOG1rQs7zzHIcAeNuD+jYDM+2sQ
 0YMh5UnTTtuMEnRoFs8lujLyS0XvxEx19sFJo0nnAn/4gnPWhR8wzJcBsXoTLs6AEVTaL8GKA
 5JGmKjtuMdvoj7qiFcCzyobEPx1x9OxN0q7vIS/pW/pNxWaglp80p0NAN5BweMCQ20CHIVUV6
 Ojodqyruhq4YKs/CTEYwwYDtsrd5WMC2wWxH+aUhb1yWfvdaxL/qC6xa9lsgEmoRI8U2ZVu0S
 7xfM0BwahD98+/iqjNFZnUMVpN7cqNwoNi+Y6DJ0n8g5smPgZSxPcJCWzvLeU8FgdPhNOLrT9
 4Whfe/actQs20j8bzgK2qXYtAD+OLUXDP3wmzy4d/tB/tl9HcizrzU+BV9iNHXQPHRoywV8h8
 n0qf7UTwrJc/7re3lgLlHsDfKU5Xxp6GJjn9rBadrV5aRyNNusTf5lRxhmisJRCLAzVEp2cpW
 xscgCsCRiB9VTkCbK9r4i4U6GtjvdC7q4Ln6bhuPfnUQZLbl3MuSTN++viMPpPr07c2NXbJdO
 oJInRo/K+C6e30M3FhIZgCDL+MjJeLZfLT0Q2A8WWPNPRgF2xM8h4BQFB2rdBNH9P/kXIYTAY
 DCwNxsg+PJEvS9XTtRV6LP/kP4pacRnIlJP7ANBOOwyf7nvCR/5IKHlh6By2Xq/y3OzRYfKop
 AxL5Kzssv8VxJr/feqY/HDQxxzdCUts0M9HSYkPnXdLIKPgBwEzMI3SwXWyk1HcSuOYoLycyC
 CAJKK+HUqhDllG98OtqrZfHrATWBYOI/aocvaYTUbc7nTQgmREFBKKzLblNlfeqjJzyJrrlXJ
 E2BvgMQgP6fBxL1MFE599mEia2mvZTU58FbeuAvReADgzBESncn3jyNV73PzG3WkS7uTuvh5M
 slxXB/IsJZRKmPcfV5xlh0AVjz
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
> During fiemap we are testing if an extent map has a block start with a
> value of EXTENT_MAP_LAST_BYTE, but that is never set on an extent map,
> and never was according to git history. So remove that useless check.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index f57a3e91fc2c..ceb7dfe8d6dc 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5642,10 +5642,7 @@ int extent_fiemap(struct btrfs_inode *inode, stru=
ct fiemap_extent_info *fieinfo,
>   		if (off >=3D max)
>   			end =3D 1;
>
> -		if (em->block_start =3D=3D EXTENT_MAP_LAST_BYTE) {
> -			end =3D 1;
> -			flags |=3D FIEMAP_EXTENT_LAST;
> -		} else if (em->block_start =3D=3D EXTENT_MAP_INLINE) {
> +		if (em->block_start =3D=3D EXTENT_MAP_INLINE) {
>   			flags |=3D (FIEMAP_EXTENT_DATA_INLINE |
>   				  FIEMAP_EXTENT_NOT_ALIGNED);
>   		} else if (em->block_start =3D=3D EXTENT_MAP_DELALLOC) {
