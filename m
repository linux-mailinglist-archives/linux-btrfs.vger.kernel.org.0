Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB97ABBCD
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjIVWcg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjIVWcf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:32:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE22A3
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695421947; x=1696026747; i=quwenruo.btrfs@gmx.com;
 bh=CoPX5CW7oaAZEIYt5nsq47/vkQHlMfIoPYhT3SHPrUU=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=OPAAdudgCoIDowi8HLBvMKeTVPip8MZEhjVaAyWBpqN0AwVgfLNes52NGKDfAbemp3HwHcj+pzL
 62HqbEOtXPIhKdCU/pODtjCQpM3iH/nJCuFn6WySDlA6ZjZbmkvhLZyY8OguK06dzLKHDVODiQxs3
 xbDGH3kM5GM4BXEPcc/i1f31D1Us/wGlHoOiBztaBgynb5eEvZxLo712VOE6RPdGpdoVd8Bb0h3qV
 3UPTqjvtpvQasA1FHZ+ONjjeaMhIYLXgUBxrUIKDn0kNvb8zlwUCKsc5nBnmqCRWeoGnGuAVvbeGn
 IMPvvrd+rZJE2896+lbLiGUBmqcW6fNVQu0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.6.112.4] ([173.244.62.37]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2V4J-1rg5Cu0kkJ-013ypE; Sat, 23
 Sep 2023 00:32:27 +0200
Message-ID: <9540b9ca-9c66-48ea-ac53-16ef6d736f71@gmx.com>
Date:   Sat, 23 Sep 2023 08:02:26 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] btrfs: relocation: return bool from
 btrfs_should_ignore_reloc_root
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1695380646.git.dsterba@suse.com>
 <54a6cbc4c91d872ec7eb9d1f7c1240d137fcfe5b.1695380646.git.dsterba@suse.com>
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
In-Reply-To: <54a6cbc4c91d872ec7eb9d1f7c1240d137fcfe5b.1695380646.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AT+P+pEnwbFucj31FW9me0C2Rh2bhj2kNoellh5Ur/7643FUNik
 YS0ArXvJ9nyY1c34vqayluiZmWa7fQNDn+Oey95yfE1MBoffpIvQGAzrf2uGWplihA74YPQ
 pldVJwS+Nf0oyZ1xW0t9o8cTL1ZcN70T6O6Xm5YybW+twKGqTPg53U02fbyfXIGo05nGJsF
 7oDK7g1ucdZiLr4sV9ShQ==
UI-OutboundReport: notjunk:1;M01:P0:vPRkIIa88Og=;m0c4PbVEVwSTTAJjazaDQG3Fa1c
 VfMDAL8idb99sQ4UMiUJnF7VehVkRNL8hsXltK1KkXMz1ympKAYA882z4dp//Ae2AXXcKmOOW
 LL4ZNEI9qSrtPK6vtYkVZu6XHSMn1AJtnf5+UuKsmY0gznyLE8ngYJwderCwtM93aUQtL+fhH
 0QlVnAAe7MFFS120eYQfP8UGlj5viumzvz7hc1fgWA+0o0G+zPMjKw00NdavYgSxvMRmXtx2J
 /+yHUwVEnynEglbL/1IrHbcGQIXVIpRBDTMPIxmSXLCE0/l/sMh1A3bNV7b4jsroug42VetLD
 NVlGxcIgtj1zyVsyCqTs28IyRfla5t8tqPsss/DLrxBkfZJnZaDEa1mStWMzwWnWYwRqDHUMI
 qqja66l98tW4E1P7hEif08bgJKCk3CD9chEYpVI18cQ6woa5v3SdjS3TYfg0hMsYv4sdafN5w
 7t75zQg52/s3KMzogVe9kCTXuKZWPLQMQHZTJj624NFxw5L25HPHRsUvbDUPD7JX7OeCJ0MkU
 SWU35HZd9tXBPd4Wq6jXPLAVP70r3ndGBjfCfGQXKjqSAyDzIAGUtqEQdr3TbDar3Aun7XtRx
 9i4kSSlDVaEOXiZ3IEWJ4LdLMNYeQBUFmdbqmY6PcSFgoVSkl7tkxZBuVbV5Z6XlTqLfkY9T8
 8yJlF3HGn8HT17drgCUJJiG24i80P3mcAkAKEWzBqe2cbzP4sLP8jvILgFM83bt6CWYezc3Dz
 QU0qw81uhkxJhRnSZYwkqdxiuwuxM/Iq4/CKF8IXJE1lZsOqiM52rVhD/Nmry/Tj6Cr6DfcgW
 U3TPzGISRZZaHkUtNkXy+YES6exPkisO0In19NU/q7H6sEKwb/pHzvhzFquu00gYk/SBs5iku
 Yr0gGxzyAgDJyNZGb3cmo1H4OJMw3xBQJs8XyR+iOtE6STL7slZ0yBYfBCqU+GzQzaF9rS+ew
 008DKv+mMQn/swAYkOSrfGNJP2Y=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/22 20:37, David Sterba wrote:
> btrfs_should_ignore_reloc_root() is a predicate so it should return
> bool.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/relocation.c | 19 +++++++++----------
>   fs/btrfs/relocation.h |  2 +-
>   2 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 75463377f418..d1dcbb15baa7 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -325,31 +325,30 @@ static bool have_reloc_root(struct btrfs_root *roo=
t)
>   	return true;
>   }
>
> -int btrfs_should_ignore_reloc_root(struct btrfs_root *root)
> +bool btrfs_should_ignore_reloc_root(struct btrfs_root *root)
>   {
>   	struct btrfs_root *reloc_root;
>
>   	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
> -		return 0;
> +		return false;
>
>   	/* This root has been merged with its reloc tree, we can ignore it */
>   	if (reloc_root_is_dead(root))
> -		return 1;
> +		return true;
>
>   	reloc_root =3D root->reloc_root;
>   	if (!reloc_root)
> -		return 0;
> +		return false;
>
>   	if (btrfs_header_generation(reloc_root->commit_root) =3D=3D
>   	    root->fs_info->running_transaction->transid)
> -		return 0;
> +		return false;
>   	/*
> -	 * if there is reloc tree and it was created in previous
> -	 * transaction backref lookup can find the reloc tree,
> -	 * so backref node for the fs tree root is useless for
> -	 * relocation.
> +	 * If there is reloc tree and it was created in previous transaction
> +	 * backref lookup can find the reloc tree, so backref node for the fs
> +	 * tree root is useless for relocation.
>   	 */
> -	return 1;
> +	return true;
>   }
>
>   /*
> diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
> index 77d69f6ae967..af749c780b4e 100644
> --- a/fs/btrfs/relocation.h
> +++ b/fs/btrfs/relocation.h
> @@ -18,7 +18,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handl=
e *trans,
>   			      struct btrfs_pending_snapshot *pending);
>   int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info);
>   struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 =
bytenr);
> -int btrfs_should_ignore_reloc_root(struct btrfs_root *root);
> +bool btrfs_should_ignore_reloc_root(struct btrfs_root *root);
>   u64 btrfs_get_reloc_bg_bytenr(struct btrfs_fs_info *fs_info);
>
>   #endif
