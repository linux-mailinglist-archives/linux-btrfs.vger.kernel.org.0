Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463957ABBCA
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjIVWbe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjIVWbd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:31:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B72DA3
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695421884; x=1696026684; i=quwenruo.btrfs@gmx.com;
 bh=Vk3eMEEkM5rv/U/6UxUElpISy5y+CA2jY+f2v0GZTrc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=PFGWkc3/UIsL0lQWGu4c1ssMTLU4m23y/G30kgNvl2WYkML2gLD6uPcS26IT7YuQnhHYaQj5K8S
 AtiLh2xoJJcFPoHYjOHRszqnbnbfmeilVbTB+R0HkDeIC8Rn7qTHdnbV19CAw4waVZhMKGp/7U4P2
 dA/cIofonO6PQs9rWwIlIFV4gMX15fRIGV84cVB9qkp3/5dwjmfOUUtQnvrDv47AUEjcuSeMstuAv
 SLHWs+IWyc7wuy5ObCuhfBD5h+fnDYuZ4RD92l7Y0vbfCx5bV3J4aeB8VXao8rm0jCLIRfuJ01pJH
 L/FD7r2S3VlKJd4k4lXnkcjihvPQCxrAPrVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.6.112.4] ([173.244.62.37]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSt8Q-1r6TUQ0Nw6-00UN5l; Sat, 23
 Sep 2023 00:31:24 +0200
Message-ID: <36c2040d-b57f-4331-aa19-61be9ef4135b@gmx.com>
Date:   Sat, 23 Sep 2023 08:01:23 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] btrfs: relocation: open code mapping_tree_init
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1695380646.git.dsterba@suse.com>
 <90521cf5613540330ffde6ec78dc0210aa05d146.1695380646.git.dsterba@suse.com>
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
In-Reply-To: <90521cf5613540330ffde6ec78dc0210aa05d146.1695380646.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ORiu8f/mG1GOZYtFDJOqAOkCyXRrRzUpeWWfrYN86smfQNqk7sD
 0qrka2BJJdqy/OUKqcwe6oc4AQ2gW0cScjRXncE20rjg5CEfG6l5aXoaJ2Ku8l7M+XljcdE
 YbrVS6bkDp8jt+5z7xxECfLuYVEo6y7B6PU0IKQWvlSvpbyLuWuidwQ7ROxifo0rvtRQn7b
 TCykwzZdpMDR31ycVcVaw==
UI-OutboundReport: notjunk:1;M01:P0:ALb2r/trQeM=;v0m5mq2VR8eWzxNCjNMfcbPrQ2i
 VTWKlBMwYM/AeXtzhG9j0+f2YOzz12VslylkGEHAvanB6CcT0jr5RPTJxYGZnzDN3wZ2/48oN
 JnMD9s4S/l13LVZwZEe062jB0vYTid73JGM2Ld5fQdll+d0DNfMsbm9+wl6cwu+pFaGQ8F7IF
 hzi1unHgZDx/DcUesUgmfpSIJtSJBo/F3r4SzlLchD1fVmwzmGWAT4FXEBBlf7H798KPE0/7E
 woLqeMJeQ8vv93bwsX9U8EbV8s74G8Zj0bwTpcP6Y8IJZKsfKjkNt6l5lUZniWtgV/G7bdzAm
 jjjod41yPOjMSGmXj1sJqpIjLSf9pxa87wznfKNAIlAU7afwGtLfmtRUy72djbtZu8On0LAeb
 Q8yMlKiNOKN+VNoSbw77P9r18bEGR2SpaQ0x7zIMeIUm1gMLbpfJdW9HBNtIjoeRyUrK7wsRY
 d0nbqthuMXBCNc0nHAV/nDSCURWhnAOzQnC7b/80hTqFl/M5etlBls9RETvBfQO5WzjEmgDQX
 38a6C3Zlt4hclQoxDYymWDgN5H/DEIMCuGMzqTRfQDNqjkQoUxvYfyGdovrqfCfTEI+tKsCgJ
 0hqHpRtshne5k14jL/qI+rzeqOsRQZovForpPLUmqUZf1z84xEJB81PPBVLRtsseoAz7gJCJI
 hXQJ9Ji7kawohWvjWQwom8saTo0H4Px7jPezPYXvRwD6b9IJlUt2eqZ3XIi1kiLnFlifcMDDP
 sGJZoG5Q8EtdZUt17GkO6JN0rUPv7qq/cuHKrYBp43CXpBVA9cZq99mwPWZ3MG6xeQNZOQOVq
 SW0FynM7Sh+HFNoeh9X2jYBM2x94AEU8lOkbXIhcFTmOCoV0PLt5g4AJL4tITrWuBtwio7fDL
 bPQkZoAx1cuuna8/XfikNaubiWTXYL1K+bTImqLx5er2yUfM9VbR2tfZcbTzF+p1Qhoo/nneF
 uT5nUOJiTT+Bfk1g4/BYJ6KFHMM=
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
> There's only one user of mapping_tree_init, we don't need a helper for
> the simple initialization.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/relocation.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 87ac8528032c..3e662cadecaf 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -183,13 +183,6 @@ static void mark_block_processed(struct reloc_contr=
ol *rc,
>   	node->processed =3D 1;
>   }
>
> -
> -static void mapping_tree_init(struct mapping_tree *tree)
> -{
> -	tree->rb_root =3D RB_ROOT;
> -	spin_lock_init(&tree->lock);
> -}
> -
>   /*
>    * walk up backref nodes until reach node presents tree root
>    */
> @@ -4024,7 +4017,8 @@ static struct reloc_control *alloc_reloc_control(s=
truct btrfs_fs_info *fs_info)
>   	INIT_LIST_HEAD(&rc->reloc_roots);
>   	INIT_LIST_HEAD(&rc->dirty_subvol_roots);
>   	btrfs_backref_init_cache(fs_info, &rc->backref_cache, 1);
> -	mapping_tree_init(&rc->reloc_root_tree);
> +	rc->reloc_root_tree.rb_root =3D RB_ROOT;
> +	spin_lock_init(&rc->reloc_root_tree.lock);
>   	extent_io_tree_init(fs_info, &rc->processed_blocks, IO_TREE_RELOC_BLO=
CKS);
>   	return rc;
>   }
