Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0986F4F99
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 06:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjECEwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 00:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECEws (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 00:52:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B422684
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 21:52:46 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6sn1-1qJQ630k19-018NZc; Wed, 03
 May 2023 06:52:40 +0200
Message-ID: <18eceb03-bbab-db61-24ea-a6b5d14248fe@gmx.com>
Date:   Wed, 3 May 2023 12:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: don't free qgroup space unless specified
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <e65d1d3fd413623f9d0c58614a296f0ab5422a05.1683057598.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <e65d1d3fd413623f9d0c58614a296f0ab5422a05.1683057598.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:q+N0ahxIiwcdXKVqrj80AREQltyVsc9Nwfl2ElZZyw+BXvgOWeX
 iM1JOGJsl8edv1RlhuuHwtLT575ytX9M1FEu2XuS2vixeSeukmmhCA57nI4XZd/+JTY9dVl
 QUTjreOnAoD/BpGgZJD6fPIR5GLvI8hfWBiuhKdFAC3mBtdtZn1C3L9aPcRzNPsHYO0JIsO
 HO8KZCJANIElUyjCUM0Yw==
UI-OutboundReport: notjunk:1;M01:P0:3vIa+fHOj28=;QyhaJOoHMYInCB3R1C/dUXTxRGZ
 SzM1h212CM5GG4/b3YS21mU3xVvdeNJl6pm/Ln//YBp5XYCm/bNLdlRQ3lwVmIolMyiijh2OH
 sQv/Nr48aq0f21dwEaQ5g0wk8bOEhOCemk6cmNIsY1TSedPdc1kSCm+lLvJkKDz/uMFXcnbKX
 vEcGMuevv/t2gQA+OE+Wbi9Xt+mFBnpM4/BtGUfyheuNKv2hEdoB8U7tBRS0LeVnFbyPqAOcl
 E4MYxSbchPxuizHWh6m415xcFRR3MCYmOj5mcNgbvq1IGV9WuLtSn7QU5v/noYUTWOpqLLSoc
 5VfespydaBQAo5EPwU2PSWW0KGKgADIimpu6pbRVxdhfvHf2y61SN2QWWb+jkNlcZIlLebIGg
 6WrHyEfPXNtevK9ySt1veL+lEEKzMqlkJJQHVgJVZQ1MBC8ayhrsiV1aRIW3X134Ft1syywXu
 T+D9lUIecAFnt/KYa4ErF4RDPYz/+SoTipFREDrgbH+K8vwPO6r2ielsWRbJ+WgngkBluEKyw
 YnOXNnTU1X+abex8QuvzqLiUYseEHJYfLLfSFaFL5/Vk3DtvLwAsP3FjCEd0IFqSlpsvhQFc9
 wTA1c4kAHsAh7czo6mK0RTL3rzRnDW4WmC10ADR6r85667j2ef0nN9jDkqzUWkspX5pTxicvm
 wEM2EW0eYOldbDasNlxgfYiofK5SrYYP6nygd7bfK1UrJRDdFZQeq0Z2iKw6ryiZqF5O7WTd/
 Yaxia/gPV/SaEigmic7/CB6rvjVNe+hPDDhEgY8k4loGoP5VxEdel2ExtDno+QxW1eLBsyKTA
 x/kulkW5QcIrIGmv4ZwiE4x7HpmB51HZMczsdvvwpGfDzvSQHw+W38Wz848i5mjcJObW6lHjM
 xp+ae01KWZMJMDcFmCgi4wTWzF1FI3z1OS2UxAbEqXaJIHG8Hzu6w/iM0IHw6EquD+NSb+zhx
 8zZwkckm2Ugoc90pfNQquSHG+is=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/3 04:00, Josef Bacik wrote:
> Boris noticed in his simple quotas testing that he was getting a leak
> with Sweet Tea's change to subvol create that stopped doing a
> transaction commit.  This was just a side effect of that change.
> 
> In the delayed inode code we have an optimization that will free extra
> reservations if we think we can pack a dir item into an already modified
> leaf.  Previously this wouldn't be triggered in the subvolume create
> case because we'd commit the transaction, it was still possible but
> much harder to trigger.  It could actually be triggered if we did a
> mkdir && subvol create with qgroups enabled.
> 
> This occurs because in btrfs_insert_delayed_dir_index(), which gets
> called when we're adding the dir item, we do the following
> 
> btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
> 
> if we're able to skip reserving space.
> 
> The problem here is that trans->block_rsv points at the temporary block
> rsv for the subvolume create, which has qgroup reservations in the block
> rsv.
> 
> This is a problem because btrfs_block_rsv_release() will do the
> following
> 
>    if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
> 	  qgroup_to_release = block_rsv->qgroup_rsv_reserved -
> 		  block_rsv->qgroup_rsv_size;
> 	  block_rsv->qgroup_rsv_reserved = block_rsv->qgroup_rsv_size;
>    }
> 
> The temporary block rsv just has ->qgroup_rsv_reserved set,
> ->qgroup_rsv_size == 0.  The optimization in
> btrfs_insert_delayed_dir_index() sets ->qgroup_rsv_reserved = 0.  Then
> later on when we call btrfs_subvolume_release_metadata() which has
> 
>    btrfs_block_rsv_release(fs_info, rsv, (u64)-1, &qgroup_to_release);
>    btrfs_qgroup_convert_reserved_meta(root, qgroup_to_release);
> 
> qgroup_to_release is set to 0, and we do not convert the reserved
> metadata space.
> 
> The problem here is that the block rsv code has been unconditionally
> messing with ->qgroup_rsv_reserved, because the main place this is used
> is delalloc, and any time we call btrfs_block_rsv_release() we do it
> with qgroup_to_release set, and thus do the proper accounting.
> 
> The subvolume code is the only other code that uses the qgroup
> reservation stuff, but it's intermingled with the above optimization,
> and thus was getting its reservation freed out from underneath it and
> thus leaking the reserved space.
> 
> The solution is to simply not mess with the qgroup reservations if we
> don't have qgroup_to_release set.  This works with the existing code as
> anything that messes with the delalloc reservations always have
> qgroup_to_release set.  This fixes the leak that Boris was observing.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/block-rsv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index 3ab707e26fa2..ac18c43fadad 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -124,7 +124,8 @@ static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
>   	} else {
>   		num_bytes = 0;
>   	}
> -	if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
> +	if (qgroup_to_release_ret &&
> +	    block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
>   		qgroup_to_release = block_rsv->qgroup_rsv_reserved -
>   				    block_rsv->qgroup_rsv_size;
>   		block_rsv->qgroup_rsv_reserved = block_rsv->qgroup_rsv_size;
