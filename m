Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2937ABBCB
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjIVWcF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjIVWcE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:32:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEEA1A4
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695421915; x=1696026715; i=quwenruo.btrfs@gmx.com;
 bh=NVSjoGKpfxLdfu9OBvPYcjso9PdtklK7p8wv5xGVst4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=PqXoA3oJPi+GlTU3YL9fs9Eo+6sXrYQKBWqw9sgcQCrVbLrLFuKRt74TH2crxMMzZ7MS3BZVLmA
 15eXvjL8W3pEPQwwol5Lb2+k3Zk2ePLr97KgdAsFF6QsnrAMMKRpMFbWFrL0mXmSNNm7gR09qqsUf
 KE4lcBuiMu+3mNHA2KtlhU8PsyHpfDw+B1wIUddgnQpU603Gh6akTPLhjIiJCHYYEE8VEQz9J7hTt
 0F4KqeGKuJkLv0Tn3OoFO/Hi5E8wY4ZNS35+SqbQADl+wKMLA7WYpmdEPyDt0wA5C2gKr00/GxgOB
 eNI6mbdYPATw22l3g2kfT+JBOe662N2AZN6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.6.112.4] ([173.244.62.37]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N17UQ-1rguh62ix0-012bun; Sat, 23
 Sep 2023 00:31:55 +0200
Message-ID: <46ed8ecd-cdbc-4467-85ef-b6ec1bc5f523@gmx.com>
Date:   Sat, 23 Sep 2023 08:01:53 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] btrfs: switch btrfs_backref_cache::is_reloc to bool
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1695380646.git.dsterba@suse.com>
 <a6570ecf163983ecc3b057aab71dd3d76d8a5307.1695380646.git.dsterba@suse.com>
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
In-Reply-To: <a6570ecf163983ecc3b057aab71dd3d76d8a5307.1695380646.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H3oo/fr0URq7IAkCeoUBqKifHgxlvzDw7CbPNKakOTrRSv4bi5t
 2ej4QgVTaLH7J23bhd45m781ccRbwy7w/XmNNtfVZ4x3NpwCJ/D5JYW3ERZGOZXMhLtvhVj
 jdzpBqA73SjhdBFKGGZSgkILysXQ+38TscMMUfawjA1E4RmZOgn6vuiCl7jFG3sHp4sqAO/
 GEZEfNbR/oe/hAVxSN6Ew==
UI-OutboundReport: notjunk:1;M01:P0:APQaCkH25qQ=;27wcaiMS2N+0CyFPCzfhp5UmuSO
 zqtVvMihJlE6x0bBaaatlyn/jmdJLktngRx//jzCTs2XHW5Cc++uJV7VJVue1o4A6TymTx8P/
 nK9C6B5UhDFly2VeQlJv+0MVIiGVMR4O8az0xIe41hHvUpxIsYqpaNeVJBHak+KSUh210SIc2
 mIK+m8S5qkATUczol8cYhuCaD2opCxEQSsOkmUnX7C1TIX/nEbMvJogU9EOTfvHqwE3Bwtzm0
 wHV/2qIY3tUPRIwfvxJEng1WV00jPFjQSCsN1B+r2SuZI8gTUbONu/eMvBG6MKKg9NlL91aT7
 y9mebE3qBWrFryHt9nwzlu8Hml/6aiRyi0voZTXIq1aZXV+T00hFLUO5OX8E3ExdXpA9tF4OP
 n0EcGjT/wM4Jvv9SgxghEm0zgi9aWxRITu65EJMH9FFvMcGxWApMsH5zBk/v0/DtYprIEAmV3
 NcuVtef/kU/OgGlQfRtWrgIxyoExD6iJhiAYVllC7satgD152IMSVk9FtUiReV15NlRloq9q7
 mCtoBHi40lvgRLFxmMM3qGwX9y95fJuf+gw2FJ4HZgMX9bmA5QPwJub6OUR4zHuFx5dBsCqtW
 /IVAM62tiOtMbfGvK0ZCzsHhOOh0Zuy4UKpffjtgAhwpaC7+y6G+6QFtFzCfnY1ploP5Nl5uN
 ngjUvZFJ06Jk9rUgDd1zkJhELNwbNlmsG0mvA8XDcwTnXYop8al/OFtTuc2iRfzemeR1qAZUC
 lMn+ZbzzqOlFhFyApfFStw0iPsKlP/d8KVoP9PJLalqAuDLmhN7NdoZhSQMqMgwMhUF78U4gU
 ey1wUBfRZiOPUwv2UdpkaoCIRSHrsSTh1JrYLdeDnrx7tZ8bSXP+hJSeSQffVjYRYeb4IKPsI
 S+jivyAAu84ZOQBzIMLC04wa+28BIKpfM7zcfXvaOzgXpxmOgASUZd7SU873gieUuKNAGNI+m
 niI9Wf0EsGQ8jbQIcVLpm/3lpEw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/22 20:37, David Sterba wrote:
> The btrfs_backref_cache::is_reloc is an indicator variable and should
> use a bool type.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/backref.c    | 2 +-
>   fs/btrfs/backref.h    | 4 ++--
>   fs/btrfs/relocation.c | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 0cde873bdee2..0dc91bf654b5 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -3001,7 +3001,7 @@ int btrfs_backref_iter_next(struct btrfs_backref_i=
ter *iter)
>   }
>
>   void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
> -			      struct btrfs_backref_cache *cache, int is_reloc)
> +			      struct btrfs_backref_cache *cache, bool is_reloc)
>   {
>   	int i;
>
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 3b077d10bbc0..83a9a34e948e 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -440,11 +440,11 @@ struct btrfs_backref_cache {
>   	 * Reloction backref cache require more info for reloc root compared
>   	 * to generic backref cache.
>   	 */
> -	unsigned int is_reloc;
> +	bool is_reloc;
>   };
>
>   void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
> -			      struct btrfs_backref_cache *cache, int is_reloc);
> +			      struct btrfs_backref_cache *cache, bool is_reloc);
>   struct btrfs_backref_node *btrfs_backref_alloc_node(
>   		struct btrfs_backref_cache *cache, u64 bytenr, int level);
>   struct btrfs_backref_edge *btrfs_backref_alloc_edge(
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 3e662cadecaf..75463377f418 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4016,7 +4016,7 @@ static struct reloc_control *alloc_reloc_control(s=
truct btrfs_fs_info *fs_info)
>
>   	INIT_LIST_HEAD(&rc->reloc_roots);
>   	INIT_LIST_HEAD(&rc->dirty_subvol_roots);
> -	btrfs_backref_init_cache(fs_info, &rc->backref_cache, 1);
> +	btrfs_backref_init_cache(fs_info, &rc->backref_cache, true);
>   	rc->reloc_root_tree.rb_root =3D RB_ROOT;
>   	spin_lock_init(&rc->reloc_root_tree.lock);
>   	extent_io_tree_init(fs_info, &rc->processed_blocks, IO_TREE_RELOC_BLO=
CKS);
