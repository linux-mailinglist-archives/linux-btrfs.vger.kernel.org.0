Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C66B78A7C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 10:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjH1Iem (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 04:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjH1IeO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 04:34:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3429DE0
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 01:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693211644; x=1693816444; i=quwenruo.btrfs@gmx.com;
 bh=Wb5rUNsZP5DqiiQChWxKE8rAMMwdqdnMV5xp1HaV2eE=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=DezkA75AOXou00KNoJDEm/1Qb5Ge4hALJJVQAV/CAnrqVMIQxc64QCkCuRU0lz44Rj5arKl
 DXkfchaXnejt3aOWwMG2oonoO2uw4+cJCL4vncqynmx3E/5+Y/UcoZRA7qZ+IchAN51kmRGXN
 EhE1VqFKxwJscv0vrzYQILghbO8AyviwMCNf7WMi5I+ecDrhvFq6d9/qIE6sL6C1u3RHcbPST
 EVAjI9j6Z2p7MtXr5YlVZZauxfLaaTHOti8Nuc51IUsh/RwCiGZjhsrtHluCyktOkJCGVsjvv
 Q13xqw4nB1bSWkyyUfqx8dIU4weVKKwNL3n6fcLIBpe4ay4Yg+6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5VHG-1pdlpJ3htK-0170xD; Mon, 28
 Aug 2023 10:34:04 +0200
Message-ID: <ff2425e1-041d-4f24-b27f-1af69496a706@gmx.com>
Date:   Mon, 28 Aug 2023 16:34:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] btrfs: improve error message after failure to add
 delayed dir index item
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1693209858.git.fdmanana@suse.com>
 <bb54e5910f8393a1404393138bc74df751d6655f.1693209858.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <bb54e5910f8393a1404393138bc74df751d6655f.1693209858.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mreanzw/o020CCgIS2qV0OhuR4akpJ1yAuSM+g7XyGdh/M/LgbF
 AUGIkwbtWyQT8XsnARwcucnV/CzuTfa5OMDpMvajGiUvdcu5Hl5qPm9uks7M11+ghP5DEee
 B9xrQSpP+a0f2fGOZkZWgmVPdL/oA1wkMoPkdLDrrOKER3sbN0PkuL1yOd06Dlz9GvBkWNp
 LQkxbgpDILfN6HmjbboDQ==
UI-OutboundReport: notjunk:1;M01:P0:BU5Vp8bna1E=;vo+TUjcI5oz6ko3FR4DVATd7aYm
 36M52DsRn0olpAByCihw5Vc1XPSHuzDrSFj5vBYlgUJESwjkrBCwfbZ4FN541lXAOLCMuolU8
 0K0H/u0foGF4WBWvMJ1TFJynrgZuyLCbaatYEGU1ebUdS4N1laAHCYNR3nNn2aWCDqZdXBjtf
 pZ3O/G7+NQd2G3ElYY0h7o8vtK+61phfqBjCb9eTHOjyUjiISNZR7aiPdRMH8EyqRj+WeGaEm
 5T6uOzFXNyVtrmTjGQJzICtaPNJ3s17eCzNomG832kqA9uj59eD5U+rwGUpaipZejG/sFzP79
 pvBLiW8KiMRnqrNSGqOS16SJfhco08JtjBV6iiEJ2aXdOcnqUyiRVQKdZe9nytLZgDjKaIAgt
 cy8Ko4ZuKB5iWoOgLGaaiIYsy87QkoPJB+/9iB4LIKyQeezG/Mz2KFv89R7PVWv/a88fcO397
 xQLkuEAsVBUaKzq3d8u/Dq5XeIA0Jz6Kr7WN4mj5Qc5W3WWVpeX8xblcHdI7NzZZyJikw4+LS
 WnezCIiUqKtd7e76G77SKaaLRJ/Tc2VY/K2GDwJzR9IIieev6uckvAYRVlZr09obImK4aUAkO
 j0bvY/XAIQE8ymkkPCiAg9A75GurEtjdRgOj82A1ZLrpB2Zm6fMpr5wYovT1qRQG2zpi8JTGT
 pNGvWU1SYl15TR0VRRQunJnO8PRsgUt6ImX12m6aSMlNA6mx3LzsKNkvWlsFSnZz1LLonwxHX
 K76yi2+xc4Lz/BxixSotyCF7euE8Ld26LjIECvH0aiBDWWOZxVL7GnfrjPeHwiSmb9kPkec03
 F+Yu0ysu+xGla7GB8H2PalfvyzmniUCp7FNGpNUT0dhIgJ+IvqhP0QriWZyJ3bV8mgu5YGDbv
 4KkJ+g2h094r+wl0iLibvc1G+s+VB3BylnXciZuxWGcw6btBOkJFpsHmEWqBLSuOHNQwD3QHw
 kXWTFRk91mWf0dsl03cSWC1vWkA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/28 16:06, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> If we fail to add a delayed dir index item because there's already anoth=
er
> item with the same index number, we print an error message (and then BUG=
).
> However that message isn't very helpful to debug anything because we don=
't
> know what's the index number and what are the values of index counters i=
n
> the inode and its delayed inode (index_cnt fields of struct btrfs_inode
> and struct btrfs_delayed_node).
>
> So update the error message to include the index number and counters.
>
> We actually had a recent case where this issue was hit by a syzbot repor=
t
> (see the link below).
>
> Link: https://lore.kernel.org/linux-btrfs/00000000000036e1290603e097e0@g=
oogle.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delayed-inode.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 08ecb4d0cc45..f9dae729811b 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1498,9 +1498,10 @@ int btrfs_insert_delayed_dir_index(struct btrfs_t=
rans_handle *trans,
>   	ret =3D __btrfs_add_delayed_item(delayed_node, delayed_item);
>   	if (unlikely(ret)) {
>   		btrfs_err(trans->fs_info,
> -			  "err add delayed dir index item(name: %.*s) into the insertion tre=
e of the delayed node(root id: %llu, inode id: %llu, errno: %d)",
> -			  name_len, name, delayed_node->root->root_key.objectid,
> -			  delayed_node->inode_id, ret);
> +"error adding delayed dir index item, name: %.*s, index: %llu, root: %l=
lu, dir: %llu, dir->index_cnt: %llu, delayed_node->index_cnt: %llu, error:=
 %d",
> +			  name_len, name, index, btrfs_root_id(delayed_node->root),
> +			  delayed_node->inode_id, dir->index_cnt,
> +			  delayed_node->index_cnt, ret);
>   		BUG();
>   	}
>   	mutex_unlock(&delayed_node->mutex);
