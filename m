Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0E79322B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 00:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjIEWyh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 18:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbjIEWyg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 18:54:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2557CEE
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 15:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693954437; x=1694559237; i=quwenruo.btrfs@gmx.com;
 bh=1DDNxBU46ih6Gqe/nKyV22fzhqcMQxqDTQfMbXq2kIE=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=l6uLXIstPnEmAH/BkPwrwj8ocElepJupaMii2GD3Dc9o/9ZenUP9Z0ONwDl0T2LRcFEWhi/
 aExiusH7nFbHMB7f9FCQFfiaw9mwCWPNr2IViRiV4v50Y358tcNX7Oy8Wk25/SIMI2JuNxtWg
 fUYaRzaVVtE2WbDQxUHnh37oIcR3Bf8nMsDc1PQhDiEULsYzqQIUMmzR1EWJCkgXGdN834fEb
 6kYEqn90WDSIf+EknAo3iodMDbypKU1QrNKkbYctAW4odMmNx0qNR6Mf5iI5w3y5+5p+n5wwA
 fM3PZ/OZ6DLJRfySlNip90TrOvKRegJ7GAYBYAPFQE1M0UKVKmuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJZO-1pyGNH0aKk-00fUua; Wed, 06
 Sep 2023 00:53:57 +0200
Message-ID: <135a3805-f57a-433d-acdd-840315335b41@gmx.com>
Date:   Wed, 6 Sep 2023 06:53:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs-progs: cleanup dirty buffers on transaction
 abort
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1693945163.git.josef@toxicpanda.com>
 <0f71fe47579f137a626d9c9f4e68419bad9dd4c7.1693945163.git.josef@toxicpanda.com>
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
In-Reply-To: <0f71fe47579f137a626d9c9f4e68419bad9dd4c7.1693945163.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MoP9RV//66BHQbySMuJEykJnPId78N5JYGdimohQS6z6sN5PTtP
 xnt4OFrZYe4KRKIh5evjiZIdXymLe5tp6jvGzk1noQLUwlvnvKN+3F8nE4p9wCtz+RweIb7
 zIsMpcH8qpzBaTljDlJOgiWagZlDKAHBGQofUhXiF0pltNfsdU0gsYoFUx6QcrxsycWBpIa
 3zueekeeps5kczlOZRvww==
UI-OutboundReport: notjunk:1;M01:P0:4Dhbbt9gKho=;rGd+4BiOvzjtGt9kHo6D4kfYUnD
 30Ui6V+oHp6xzv0cvehAry9B0SGTcDdq2GoKycboRMFCUK2x1L2Z614hJFx1w7kIY6O/ramcT
 ht5WfHpPIy6JqB5allkK5Xhj33wl97xArsO4PLSuoDsJR12FjtQ8mIY8f8TC7N6EJijiQizum
 8a+GjZVuD8CfC9/FbR3rUfQISTe4IDe+00fEdaB0Br3/Ls9WaNUn2mRfX46hTFgD1XHf2bRrF
 +7obM9UcfnrlEp9k9sis8gWnmD6j19wE52JzmBtl1WHp8f8t7JFKU65hTflMWzlUSdJ7vkXGX
 Ze4adhhGPZoWJIxxCOMJA7NAPcFyKaoz519sdUJpfHPtnPLKPpm0DOKbOzhnZwc3PEfJcjQjO
 VB2B7+sWoSF4PSVzrUHcDWGAUKyZbWaZed20SdzrAP5SVtczgXak0gMsMLMd94JPEbJGzjFb7
 t7lOSiqcu9Y4OmNun+DY2ALIx+Wvbd89T47hm5+FOws3/JqvoyH8I7t38erx8UpEcZpADX2kR
 YnTSNrxGXfoAt+uYeZwwkr0Rn0AqZm6KiVknQNY9U6hMTlgrJKtoYwSgA5oBkLGi1LwoD+sF1
 6qSRdxXhd0+lno9xkmuydjkwe2HPFKbVyWMbqRhybwB4S8eRN/rbcC7i2BUOd6/5hMdI+rWD2
 fACPd0lFR0Xpc1/mMpQ2ToyjavjHQT+hvy4Tdvo58ubO49dm9PwWagWzyc9y8zhXmwgI8O/cD
 6/yp3KfYSeQlgHphHhY1+8XXcHJIS7QeYoxhOZXcc2l49RtTBwuSoJ3wNEKF5Oh4j8Pw02iv+
 Ao+aBKw3zwe8xv9H5k6S3PsyowGsErLAZD03eNObYMY7Wo5bMqYO2dTjqolOriWVMJQ+M7MaF
 NGj0Ptc6ey9twchUQJDGynh2DPpgvy02P/oi0BwoVNpCra+NHezGBkeiPdbUpXqb5GC6S48pj
 EoKIL8h1F3rDj6CVMfBhO3kaAuM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/6 04:21, Josef Bacik wrote:
> When adding the extent buffer leak detection I started getting failures
> on some of the fuzz tests.  This is because we don't clean up dirty
> buffers for aborted transactions, we just leave them dirty and thus we
> leak them.  Fix this up by making btrfs_commit_transaction() on an
> aborted transaction properly cleanup the dirty buffers that exist in the
> system.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Shouldn't we call the new clean_dirty_buffers() inside
btrfs_abort_transaction()?

Thanks,
Qu

> ---
>   kernel-shared/transaction.c | 45 +++++++++++++++++++++----------------
>   1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
> index fcd8e6e0..01f08f0f 100644
> --- a/kernel-shared/transaction.c
> +++ b/kernel-shared/transaction.c
> @@ -132,6 +132,25 @@ int commit_tree_roots(struct btrfs_trans_handle *tr=
ans,
>   	return 0;
>   }
>
> +static void clean_dirty_buffers(struct btrfs_trans_handle *trans)
> +{
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct extent_io_tree *tree =3D &fs_info->dirty_buffers;
> +	struct extent_buffer *eb;
> +	u64 start, end;
> +
> +	while (find_first_extent_bit(tree, 0, &start, &end, EXTENT_DIRTY,
> +				     NULL) =3D=3D 0) {
> +		while (start <=3D end) {
> +			eb =3D find_first_extent_buffer(fs_info, start);
> +			BUG_ON(!eb || eb->start !=3D start);
> +			start +=3D eb->len;
> +			btrfs_clear_buffer_dirty(trans, eb);
> +			free_extent_buffer(eb);
> +		}
> +	}
> +}
> +
>   int __commit_transaction(struct btrfs_trans_handle *trans,
>   				struct btrfs_root *root)
>   {
> @@ -174,23 +193,7 @@ cleanup:
>   	 * Mark all remaining dirty ebs clean, as they have no chance to be w=
ritten
>   	 * back anymore.
>   	 */
> -	while (1) {
> -		int find_ret;
> -
> -		find_ret =3D find_first_extent_bit(tree, 0, &start, &end,
> -						 EXTENT_DIRTY, NULL);
> -
> -		if (find_ret)
> -			break;
> -
> -		while (start <=3D end) {
> -			eb =3D find_first_extent_buffer(fs_info, start);
> -			BUG_ON(!eb || eb->start !=3D start);
> -			start +=3D eb->len;
> -			btrfs_clear_buffer_dirty(trans, eb);
> -			free_extent_buffer(eb);
> -		}
> -	}
> +	clean_dirty_buffers(trans);
>   	return ret;
>   }
>
> @@ -202,8 +205,11 @@ int btrfs_commit_transaction(struct btrfs_trans_han=
dle *trans,
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	struct btrfs_space_info *sinfo;
>
> -	if (trans->fs_info->transaction_aborted)
> -		return -EROFS;
> +	if (trans->fs_info->transaction_aborted) {
> +		ret =3D -EROFS;
> +		goto error;
> +	}
> +
>   	/*
>   	 * Flush all accumulated delayed refs so that root-tree updates are
>   	 * consistent
> @@ -277,6 +283,7 @@ commit_tree:
>   	return ret;
>   error:
>   	btrfs_abort_transaction(trans, ret);
> +	clean_dirty_buffers(trans);
>   	btrfs_destroy_delayed_refs(trans);
>   	free(trans);
>   	return ret;
