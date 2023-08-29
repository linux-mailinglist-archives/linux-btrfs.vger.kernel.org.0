Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA378BE7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 08:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjH2Gcq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 02:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjH2Gco (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 02:32:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4A91B3
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 23:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693290743; x=1693895543; i=quwenruo.btrfs@gmx.com;
 bh=ykx4TiUp30zj62nliVic+iZyVRyw93+Zgw0eeEr/lI8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=E0xQGG5IsUR6qhujTVFJQIbBF+iHlnL0yIKYgN3X7cAYcqgVS+FahTonJRUKu8ozBKKpHCp
 C/1ownh1SurBZzDqyfq2ag1dXWSWsneqGg/wrx8B7hMUeVPAi6PjTkFDFmP3lEQaQvj5XJ54R
 tV9iNOZzdUGNtbAxzluMsjVjgU+EjwzZoBZpVSIsxc4gW2Fxfg9VqOnslMui5ULN5rAt+32xO
 jk7av+VbsUJedsNivyf3U7C1RWHmwfth2OTcGg70yt+ndjz8RM6uhRd/cWRiSGYdjtgptyRUZ
 dMrT5u4OTS80k283jbNPsZjoIRdkGnsCBLHR/BYCwQxDSKAhn2jA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt79F-1phXjT3jsP-00tQVn; Tue, 29
 Aug 2023 08:32:23 +0200
Message-ID: <afeeda1a-0317-456d-a9b4-0e95a62d3de1@gmx.com>
Date:   Tue, 29 Aug 2023 14:32:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/38] btrfs-progs: remove useless add_root_to_dirty_list
 call in mkfs
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1692800904.git.josef@toxicpanda.com>
 <34ac8f222d475d692faa8d325cf63b5196912644.1692800904.git.josef@toxicpanda.com>
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
In-Reply-To: <34ac8f222d475d692faa8d325cf63b5196912644.1692800904.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xg8LJjR99oINoGIrQnLCggE8Qxa6W0jFDKzeeBArk8FCL+63QXe
 TcIr6pChRrXswAzY5C1cbUQwODi8HJ9AjKfPrqpSvCRZDXtVRYpQeYfpLzfsfLqbc75ccvJ
 CfYh5NanjDyk539sltCMaL7fNJodLYPPRwF17YdXAjebW/QMG8cT1FyGwFQe0dW+TRCKjSK
 fjIkcTaFGcMQfA9glGdww==
UI-OutboundReport: notjunk:1;M01:P0:GFEytADV7ds=;/GLKE84Xs0VPMI6Zt4YYACNzovh
 2IZYjrMibsLWXg49gFhz9UYznOazQR4jlOCNvzSEUmWPt9N8GMu3x5moy9qejMUHhwjxJW3vj
 X9UEZVLEeMeS+9pqYyeE8QuVPVSh5D5zUQCDKBVwV9YQCy6bS4YojGabxlKmAztQm/VpYGIVf
 VaEQMjG0H/0ZJJ7zYgIefOCkBuNTLl88izJbBtjoPUBh4c7vtzBi0juVQcLWd6uxfG3VedQ7+
 CUesIod11gfcHFQwrQuiOIqFnxbK0XimP89FSgP/VrvP/iuA6MaQqTJTt91D5ALCEa0q6vhbo
 M4tdGhB4WMT3cgxqOD2OQVd3DNfgY8/yT4pnhtQwMddzdpsd9JOAkFAIl+1Z4FLC6SH497FSq
 ZHpnsntEJB/h5msST4McFDBLdPgRiuTzFSxuXLTxZeFkgg0Pzc+r9/dIC/H/eFNpSSEoL08Qt
 jvEn3hhGHq15qkgISCQu14juVxbc9cTU2sA/yrpyYGhEkkBhoLOAw+HHCOBS8nkPY6fFPovRS
 HdGAULQgnaCHnjG6skTWdKfKpDLFkDWuWY1trMNqYPeRXsOhZm1GRHR4zpa1GwcA3KCDy543p
 OEy0Ptri5hbi0jcjqkh80E8/dmda6xzeGvFywL657bzLcFz0mYMUpWWFXLa6PRHKhq8TUMIl9
 eWobRxgrb3JsNDz35mdU946+5voLVBH+ukRk5u0VuFxDe0fyZm70VajAwnDJNaKYqYt4F+QoH
 ms/hlXq4m2JWtrQddxvLzEVDHbq0mVpCGPkOaLwqWVqyLUxatQ8wxu5boEaIph2F6F5lsryVc
 8QAKzh6rQxzk/xGiyi5c6n9mqWVOOfbOylDCj1y+FcxhFBJlBrV9a/x5yVNakM6mnlAztmGaT
 3kX/7vbI93nQUm8zZX8iPjZ4jXApyzyJZRfGoyOWylnchn1rhfHHXKIy18aGeEdjQTWwjA9BB
 GvuzmMTvZDiPPex7QzAlGfOs0/4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/23 22:32, Josef Bacik wrote:
> We are calling this when creating the UUID tree, however when we create
> the tree it inserts the root item into the tree_root, so this call is
> superfluous.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Unfortunately this patch is causing extent buffer leakage. (Thanks Anand
for finding it)

The latest devel branch would cause two eb leaks, one for uuid tree
(caused by this one), another eb would be from free space tree.

We can remove this one, but we need to add those dirty trees to dirty
cowonly tree lists at least in btrfs_create_tree().

Unfortunately this means we still need to export
add_root_to_dirty_list(), and would cause conflicts with later patches.

Thanks,
Qu
> ---
>   mkfs/main.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 1c5d668e..1b917f55 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -789,7 +789,6 @@ static int create_uuid_tree(struct btrfs_trans_handl=
e *trans)
>   		goto out;
>   	}
>
> -	add_root_to_dirty_list(root);
>   	fs_info->uuid_root =3D root;
>   	ret =3D btrfs_uuid_tree_add(trans, fs_info->fs_root->root_item.uuid,
>   				  BTRFS_UUID_KEY_SUBVOL,
