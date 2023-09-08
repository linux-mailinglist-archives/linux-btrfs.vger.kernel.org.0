Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DA1797F7F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 02:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbjIHAC3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 20:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjIHAC3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 20:02:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F809D
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 17:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694131342; x=1694736142; i=quwenruo.btrfs@gmx.com;
 bh=D60nrrJb4elGHelecAUXnbZemCOiJxjj9i25UvwPT0g=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=aSXmSXn6GpRaDX/FXd60p5NtnBj9vJ2VEBjL8ipAHSo5NhWPYSGUNQ+72HPoRdPDubSm4yE
 4kFVWDeEMOv2VhMb68OWl+9s94/am1zMCJQtPzMxTzkDeDcQMlDslx1kz+CA/YYi3QpuTMHms
 B/HxXjBREE/DcnYnk8+tub9jTefdYT1FA89WqxS2XQ0W0zf+nNEiAjrhFLvu6Fk8ZiIUT/RdU
 u8jbcTr8C0Sm7LNNEXRU4mf8BAocQB5yCm6jLv9Vh/bB1/K+Mr1tzHKjoGh5obr6pXX5pTXyc
 AlgbUy0yi3sq5EE8ZXF5TOvEGna3bu2BDOd9G1v1exQbqSxTBd7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5GE1-1pgDAB0W1d-011CUM; Fri, 08
 Sep 2023 02:02:22 +0200
Message-ID: <e7a9d10b-61cc-4e41-a8d6-9dcb2db38b11@gmx.com>
Date:   Fri, 8 Sep 2023 08:02:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] btrfs: reduce size and reorder compression members
 in struct btrfs_inode
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1694126893.git.dsterba@suse.com>
 <9c8300f8034d596a60307972b54390364fca1c73.1694126893.git.dsterba@suse.com>
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
In-Reply-To: <9c8300f8034d596a60307972b54390364fca1c73.1694126893.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZFsbc+98loNV/cL+2QAUciqi2CrgbuUyikqi0Fk3w4/Icux/scj
 GEUHhoUz8f27rIbe7dhgvxZRdxOqwuYocwsAqm/mvkXHWgWvqU0AeZ5aS3r6ZO0SkuLQcaN
 3QGEAEkV3q4emQuTxRj8aA9qYdqAlDCV1ziBBphu91a7liHkXPqX5l8Qfruhql4rERwCsaa
 ojQtRvOkdKVawyXNVgJiA==
UI-OutboundReport: notjunk:1;M01:P0:74f/d+4TOOI=;c+8B4Yj0z11Fwz/6sZdmg6PC+Tr
 f2dfOUesXhp4NOA9QmPbnKmSE6weslQYgAAvn19NHq2g7YeS3obMAA/VSee46znH8jtpkBbLn
 gC9Eq8QLO62Xlg1ygbJQrEL0XaoODoJgzVjMimoEUD9PSTKKoYgyVfauoQfIJmOyH0oljLhms
 6CtDK4s0X0NH069pIcKXeqT2pGCwSTfIV5p9aaW5GQNlvzXnt6zYgdXxwpWyd7vqgWcsfMy/A
 M9OlZepOQnn/MfScgBcanTmA8N/Ik/Zk0JiwQfiDaxbay6vVx92pT7Bp0b6VDYESw29x0y+B2
 hClcNMYyhdPjgJ1GWM6rW2mBpVdiBk7I65jI3tstsI/wUBkkA3bPf3smw0sRF6U3Z370uFICN
 lZcdtIcgZymFvz8PbAxCqR6oHxK/9OoA8g/2AHhQQDrVrRkB058rLIHhZqGywwUP/MbzmyhRC
 Qx2x9399RaeU8B/GoFASKGTDDSoEoGDOvKPXC4sSgMCjk1xIGrkq8g9IzQdGnqjsl7G2j81iU
 9zGbz9zpfVBt+vyC5yrxWUf8oTnfA6IosL2I8pQi078PaGU9jfnyQbSrGsd7wp+Xs/TF0EwNl
 0AZRS2AS+6wQbEH9BRP1E6WU+SuwKGH9kVyT1oJRCyWjYG/4gYUjsfFUOQt+aoazJdtS/SBKK
 2rEZhGmLCe7RIp9cQCXQHYNf31Z/EwuLQ1ht6p5fkVMDf2l7pbxA9jXU2tmXXHX1jFu8eIEOA
 BAjNgyRfGL44l9tSAhNfmLXEMBA9ic0E02r7JBgHQJ8TrUaWdKMV9sHtA8GVHy9Fg5DorOpJd
 fJqyuIxH+6dT1HS7YfVLIpAEm/u330eKWnnBDGO//pRP98nDhUBhhTSzyhW/3VbxRnYJFk10e
 y6NDZzQEtCn+z45qclbehCAlRAkGHSMR2tpc0fdM52lNKHx5VBSPaC0D5IwChyM/N57Z2077f
 qwYyTPfyExa7+qkYWrIypP9eRSI=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/8 07:09, David Sterba wrote:
> Currently the compression type values are bounded and fit to an u8, we
> can pack the btrfs_inode a bit by reordering them to the space created
> by the location key. This reduces size from 1112 to 1104.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/btrfs_inode.h | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index b675dc09845d..2e1c0f68d704 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -81,6 +81,16 @@ struct btrfs_inode {
>   	 */
>   	struct btrfs_key location;
>
> +	/*
> +	 * Cached values of inode properties
> +	 */
> +	u8 prop_compress;		/* per-file compression algorithm */
> +	/*
> +	 * Force compression on the file using the defrag ioctl, could be
> +	 * different from prop_compress and takes precedence if set
> +	 */
> +	u8 defrag_compress;
> +
>   	/*
>   	 * Lock for counters and all fields used to determine if the inode is=
 in
>   	 * the log or not (last_trans, last_sub_trans, last_log_commit,
> @@ -235,16 +245,6 @@ struct btrfs_inode {
>
>   	struct btrfs_block_rsv block_rsv;
>
> -	/*
> -	 * Cached values of inode properties
> -	 */
> -	unsigned prop_compress;		/* per-file compression algorithm */
> -	/*
> -	 * Force compression on the file using the defrag ioctl, could be
> -	 * different from prop_compress and takes precedence if set
> -	 */
> -	unsigned defrag_compress;
> -
>   	struct btrfs_delayed_node *delayed_node;
>
>   	/* File creation time. */
