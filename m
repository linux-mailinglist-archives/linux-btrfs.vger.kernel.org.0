Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A849772F67C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 09:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243089AbjFNHgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 03:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbjFNHgp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 03:36:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A365326A6;
        Wed, 14 Jun 2023 00:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686728143; x=1687332943; i=quwenruo.btrfs@gmx.com;
 bh=S9LtiaIQe1KHAB/mdGv50YAXRAYL6f2p6uj/VL1tokA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=XFSpc6e+IvmeC0Q2GnckhWoYKwIHaHDswPg2QhDtznLajp6IoeAWWvGXwwUn+7RjvPWmcao
 t78LSp+5nL1841t6SUiTXDJsMnCAc9s3MG6sw/aUH5zl5vO3GIDVN2XaBPgDUo45E6iW0NyUZ
 gCBnF+dZ9AO/rHKkByp03mrtamitsQyFG7HVMeA4zIaQw8vkBEMfmGE9HeH5Ik7Bu7/KwV3Qp
 ZJxV1zM6q6wUlcu/WerhDsz5yA9+PLxLAqhFhgWlvdkDtEyOO9ePT4reVLJF2cfQuMIN6a4sp
 ROOELvM4qXezrodCQRWUOwPF7dEG2esclWVciui0hG27RzQ5MJEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5if-1qRghn0YJZ-00J4GZ; Wed, 14
 Jun 2023 09:35:42 +0200
Message-ID: <146b71c3-2ce3-acb1-2580-96bd9b80546f@gmx.com>
Date:   Wed, 14 Jun 2023 15:35:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: make unpin_extent_cache return void
Content-Language: en-US
To:     baomingtong001@208suo.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230614072710.34392-1-luojianhong@cdjrlc.com>
 <a478eebcb05b6eebc6bab8996641c2ed@208suo.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a478eebcb05b6eebc6bab8996641c2ed@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eWE7qtlogYOaXjLxxc1HdnYv5hRsL6I0HbFETHTY/HQwfuXmM1U
 QqZ/7SYMlQx1GfODZCTlL13B83mqBnDgv88mW4ivAGa7zevflhTH1oF9GR240TxeTQ7o7U+
 uEvwRKn3+DNlMwZMPvK1mR4oNy7NNtzGFgUr2dsZjOxXTIHY5gYwOMdiINnZ7ns2Rd0m7vG
 GV4hTSulj7ivmPBJxqPaQ==
UI-OutboundReport: notjunk:1;M01:P0:0bssYAZCgT4=;QFHqLAiKDSP87uaGzg3IfMRJrDW
 +pvoJeZ8f/m8iajp2sOH51mcvuw2O7lF4gH0YvA1IWePv3KcjKvEmzoZNB5IIemwoe9Zv9OzS
 c45SP9aD48VhAsLfJKrL6+MTMHprBT6kEZ+I8N0yEBl9W0Wbt7qyXnPc0ZvGXkEW9iLD42mov
 JXmeDyIejQ9cJIF/SFPquMA/94AeKN+IiMUhnt3PsFM6uiX97l38uyZbynYlCCuW15Az9fBxV
 nqGqkKcl6P81Ivzc885th2UG4nRyqY5kLJz2Lw0fdNFffwCek2XVSJUNwSrX+hZoJWbM4DFBp
 YUzl4l3kmqhIIIfYoPbe+/kqG6phKo7rp6DESrizeW6bWAwvR7XZjSoHXBS2fmQUUvrfkmHby
 kke6fVAlLVGflCtaIkwLJRNCmBGyoCoYtZlf8y6m0e37HcuYhJhLbQZutau8Uc+KzJ02Vq/8Y
 shEwXjFpjV/WW571CNAkoJD+EpuoW2DaEGCnzH+x7LY6zqXWeZ6MZklykhaxw8Uck+1YWbyD4
 lBauOzIaMKd18EzDyPAGJAEY2VlSxwlNz80fnxH9qrSWrWrZEzQ7/fT2v3ZAtY9efImNhUrNZ
 GS1wW1ZFVuVe00FpJNeA9vuZ/X28PM4/vtzoed4gvzsLuTcIV6i4EJQPQ1Zy2iOJhYN6IzU+M
 mJegA2ENjmcbOWaCW5Uek7NW0wQl6PYtCHNbLn4UoXTNd2IPxp7uEtIe1SVyKtB5A9k6Nj2BK
 YVtu7PCZ3uYg+g/lbrqRIwGgsWaGO62gBbIND1p+5NnTsWC8+AnA937yCzjf71f3T560eEctm
 cUvv2RfyV/SzEGJ3hZdvcG5uBtTIlXBGGubcx4XDmM8FDCss0jMJ0IRqWNL98JZZcNmHToNu2
 vl+Vlh/8aDSQ+rQ4f3DMP0ZVYvg9feP9vm8JtWhQRIBC9m8zrXKntwPw6UAM/RwGQrj0jj+oZ
 yUEFdfcs1JSwHm3xUSBmtFtLxGA=
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



On 2023/6/14 15:29, baomingtong001@208suo.com wrote:
> The return value of unpin_extent_cache is always 0,
> and its caller does not check its return value.
>
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  =C2=A0fs/btrfs/extent_map.c | 3 +--
>  =C2=A0fs/btrfs/extent_map.h | 2 +-
>  =C2=A02 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index f3e9aaeb9956..845994b47998 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -292,7 +292,7 @@ static void try_merge_map(struct extent_map_tree
> *tree, struct extent_map *em)
>  =C2=A0 * to the generation that actually added the file item to the ino=
de so
> we know
>  =C2=A0 * we need to sync this extent when we call fsync().
>  =C2=A0 */
> -int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len=
,
> +void unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 le=
n,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u64 gen)
>  =C2=A0{
>  =C2=A0=C2=A0=C2=A0=C2=A0 struct extent_map *em;
> @@ -326,7 +326,6 @@ int unpin_extent_cache(struct extent_map_tree *tree,
> u64 start, u64 len,
>  =C2=A0=C2=A0=C2=A0=C2=A0 free_extent_map(em);
>  =C2=A0out:
>  =C2=A0=C2=A0=C2=A0=C2=A0 write_unlock(&tree->lock);
> -=C2=A0=C2=A0=C2=A0 return 0;
>
>  =C2=A0}
>
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index 35d27c756e08..486a8ea798c7 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -97,7 +97,7 @@ struct extent_map *alloc_extent_map(void);
>  =C2=A0void free_extent_map(struct extent_map *em);
>  =C2=A0int __init extent_map_init(void);
>  =C2=A0void __cold extent_map_exit(void);
> -int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64
> len, u64 gen);
> +void unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64
> len, u64 gen);
>  =C2=A0void clear_em_logging(struct extent_map_tree *tree, struct extent=
_map
> *em);
>  =C2=A0struct extent_map *search_extent_mapping(struct extent_map_tree *=
tree,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 start, u64 l=
en);
