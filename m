Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2FD710A3B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 12:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjEYKi7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjEYKi6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 06:38:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CF210B
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 03:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685011134; i=quwenruo.btrfs@gmx.com;
        bh=UV2nf4JyLHSNnD7CAYyhbe/SCryk5ANJNJoz1Bo7+vQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=nr7rlVr0Z54aXbx49+dui71AwppUOpfBBARmG03SWtpfEXzGHazg8DMn4OI3ZM3M0
         +4nFCfeCAPGUdhH6DuGAFOp59KMPKcJg5HPTkgracUzoVoWyGvJC5Ep0ViAGA1WFZt
         HH13uEL2byl0kzPqxXbDiHwjn4eazmcS+CiUcdNplgPk8jjF+ch2jeR3klL/CujyK5
         euNnNOkwJ95u6LjTYTGyoDFHP/ClJVV7UBFClI/csepID7Ulh3rVL14qrtdfykb0iY
         z7vofy5+v0hs6G4cq1hWDrHVKDhaMjjvpt+141nWPkUllrOHGiXoihcc4JhyOtkF6c
         BiNLid9CeuciQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOKc-1qG5BL2ZYM-00uv2F; Thu, 25
 May 2023 12:38:54 +0200
Message-ID: <58561722-bb40-ffd5-0154-b466810c4cf0@gmx.com>
Date:   Thu, 25 May 2023 18:38:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 7/9] btrfs: drop NOFAIL from set_extent_bit allocation
 masks
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1684967923.git.dsterba@suse.com>
 <232abb666a6901f909aeb21dc6f5998f0250e073.1684967923.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <232abb666a6901f909aeb21dc6f5998f0250e073.1684967923.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y7m1RHacUqul/GS8KZNTt26xAm8w4NxFAMYQkvGJKXSFdt+yNGz
 a/+Q6UhAzK/UzXa9dm/ityuhLxzMnmp4+F5t2RgFMMgyodf7muCYL24uaY51NnBuev5JXJ/
 JMftPV4fmUUxLzw30loVjYoqBuq/S8e99wVAvSyuyLuh5qJWoqIxmM6mhGkVUzRyOFaW6uz
 55Uz8NGR/wkJ3dXZo9vbQ==
UI-OutboundReport: notjunk:1;M01:P0:vc5283Nyp/c=;fTPeGr7abZdvP5+1PIQ9wLXfH5P
 oYmS2JWCFonJ7o1J2SGpbvFGyMycvyvK+bA/0rxywKmu8Cm2O43uUogNZKW4p8txWh4HS2hv1
 t12kQXi4bcl38m+wd3YxXWtJw941qqyE+q7H0wBks8g+mKzY/eWTbGWOR4yheryNzabJZO7Ce
 fMMHQMNgqi+pv8LSrY9G+vyD9i5vpLsU6JC0zbwqDewQKH6wDlC5A4VFIMzw5b93YhbzuWHk1
 R9aj+h8WECT9ZFalc5l2as/zj9XJZ6Tf6f4Yav7x+aHaCM0DiWG1lvLX+NMpB7J+6ZAglV0Vg
 r/g+i7GcWgpgVZ7fKo9nqXEXHbNdymxpXu3rKxJDjOTfIoZKjtUR7864qvBQmdH2+66oKEeSv
 ouIxyxHyHwSjUh17jV21mF4KyzZvlcUOYPXGiTsDV3+6rpxfm3a0Ap1+Qa/ILQjA3xalQlQja
 CesrzebUtv6GL2J6sT0N12ccVQ/UDm3VSexJAM59WZ+lBr4oDaXE6Df+pVKtbxzX3IDcStvYw
 Y0m59xoM2OJ1XqP4ZFWyCcLs4wcbOqRl5VLrlKAmlIMK36fmypGM+qHfiYdVFPKOdIB+qsYlZ
 vRI38ZKi2g4p84YzBPQGSkUgxmUWvQaBNbr5tnHRBc0UPn4bRgwHyi+yVaTzExgqwRosRwoQ1
 i8EDTB/vwj9VhK8vnsP/2ulZi2U0j6k3JmskmI1mXg31Zbq4DuKOcLLOtvyRR8znbl7y3TnNH
 X6WQuEanWTFzBcVjEn3k0uFTZi2efItQgRqNX8e8hF3dFNHOpBJLDgrIB46VJXv0KgDO7cjSj
 VDqUDQMMkmAp3XzVazk4uXsxetX5iM4znYh6O14SGmTBIXuLxS+aFTlaZUlw8FA2ZgtmPdTF3
 dAMDjGWizGXGXjiAV+p9FrBUpiSn7hjmGsfOTm0UBphYOSY8cCrm+y13oVF6sQB3t5K1Ds1j6
 sE8htsL5Ahrief1rIg49cn+vnS8=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/25 07:04, David Sterba wrote:
> The __GFP_NOFAIL passed to set_extent_bit first appeared in 2010
> (commit f0486c68e4bd9a ("Btrfs: Introduce contexts for metadata
> reservation")), without any explanation why it would be needed.
>
> Meanwhile we've updated the semantics of set_extent_bit to handle failed
> allocations and do unlock, sleep and retry if needed.  The use of the
> NOFAIL flag is also an outlier, we never want any of the set/clear
> extent bit helpers to fail, they're used for many critical changes like
> extent locking, besides the extent state bit changes.

As I mentioned in the cover letter, if we really want to set/clear bits
to not fail, and can accept the extra memory usage (as high as twice the
number of extent states), then we should really consider the following
changes:

- Introduce hole extent_state
   For ranges without any bit set, there still needs to be an
   extent_state.

- Make callers to pre-allocate 2 extent_state and pass them as mandatory
   parameters to set/clear bits

- Make set/clear bits to use the preallocated 2 extent states

By this, we should be able to completely get rid of the memory
allocation inside the extent io tree set/clear calls.

Thanks,
Qu
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/block-group.c | 3 +--
>   fs/btrfs/extent-tree.c | 3 +--
>   2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index ec463f8d83ec..202e2aa949c5 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3523,8 +3523,7 @@ int btrfs_update_block_group(struct btrfs_trans_ha=
ndle *trans,
>
>   			set_extent_bit(&trans->transaction->pinned_extents,
>   				       bytenr, bytenr + num_bytes - 1,
> -				       EXTENT_DIRTY, NULL,
> -				       GFP_NOFS | __GFP_NOFAIL);
> +				       EXTENT_DIRTY, NULL, GFP_NOFS);
>   		}
>
>   		spin_lock(&trans->transaction->dirty_bgs_lock);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 03b2a7c508b9..6e319100e3a3 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2508,8 +2508,7 @@ static int pin_down_extent(struct btrfs_trans_hand=
le *trans,
>   	spin_unlock(&cache->space_info->lock);
>
>   	set_extent_bit(&trans->transaction->pinned_extents, bytenr,
> -		       bytenr + num_bytes - 1, EXTENT_DIRTY, NULL,
> -		       GFP_NOFS | __GFP_NOFAIL);
> +		       bytenr + num_bytes - 1, EXTENT_DIRTY, NULL, GFP_NOFS);
>   	return 0;
>   }
>
