Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EAC52AE1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 00:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiEQW03 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 18:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiEQW0X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 18:26:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86296579
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 15:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652826376;
        bh=OTaBhy/E5kzC12ZzEDdfcGs3zTe0yVrGEuLHItpfvfk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=O2ev/Y1dGKwQ+eyCfY/RxRAc/ECCstfAIjF7TT9s14fCVeb5fobzQP/Ez2RyWctHd
         Wi2mpdKf1odhQ67oJU1mf5DPI7RUnl03fGi9LFz6fG4A3sBYIpVFmn3zYY1HJdVE8a
         NUrUE26fG1rDKaJgHWFHt5UAt88e2xakq2jFcDkY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M72oB-1nxRhg18nf-008Zaj; Wed, 18
 May 2022 00:26:16 +0200
Message-ID: <35c12a78-fe5d-c683-58c7-d600e8f7ce14@gmx.com>
Date:   Wed, 18 May 2022 06:26:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 10/15] btrfs: add a btrfs_map_bio_wait helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-11-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220517145039.3202184-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cslnKkD8gS59iNy80HeHc8Kh/kp8isfNbka+4KwPYRkJ/SPC2c6
 kM4bYtGgBztgJb87mnrTZiDspUt7hUi0GIAK+3E7Q29mLFrq4QijxqJvTBXBASekO7mJSZS
 HzF0i7JC6De3NJzAEr1rsz5zA8TBaUI+YggSdsjylmlokVjGwQP3WcjhQtQBmF4bhe0aNbK
 iYwMX2ZMiJtmnQlB8hhXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b3uOsIJbjt0=:cZUYX+iTizUwSO/yI+muoG
 gfyREr4qFb6RTeZo8AMEbueGXhmWGAsEs9O8bENNgovXPpM14s57OkR2bHWepJz55NLEJ1xYU
 tjjVXJSn5MVTyPGp6/UhLyp0as353RLNF4TCO+iJf716jVUMKYAIz4//bFYoP5hwSF8cd6mD/
 WF5T9CmMj1jpIYg9Sj1Rwo2cyJ34p5dNVTToFAXDWs5Lk3wJIPLIqf+xowstlPkw+0QrRCsqH
 hQfq8ASj6Aw/2G54EKg0ny8ukk4ooYtYi81C36sQPu8OUzDXXC4yrSNtxmIACktHyd9JEOY5h
 YNXBKhfOEcq38EKIQie9laDUZl1NYki5LD2NeUh3o4YjeKgmFhLHbw7HWKcdR8dhZvS8z9RRd
 2AR8675Cq8/3qdIfjxWOkOh3q9t2/QBTKHaXoI8jG8T01I56zq+om2wbrtptLL8aSD6lSBeps
 FavOFBuK5xDtFFKzgEUYxEhBuIEOgCOixykVKz0ngimxMy3Zkm1CVVmsRM6EhuQe0VY3bz1Xb
 O+izuWafVCLv6Rs3JgFBZIFvVs4hhIpdzF+VVi26ogBmW4NwBF/1e39QxfuUgXAy2AwqNL5rb
 KcY7ddt+9pndPacIRtH0ygAcNHX/0MNIM/RRh+501VNER5RMYXmI/BtyN/q1lwNsn80LQdn4/
 uF2wubjJ+4K0Dd4hBWdUQ7GnKi0nM0bKp00fq5dH5eGgCWdxGfhGgleCC11DcvDmElEm5a9F9
 lOezg9OOdkJJSLoCEHlMeR/fcEKiGaAzvewz2CNJB3v9PuinLxC5Ft2XoY8cX5B7e5Yz8Mvnm
 eMTTO/ITSbky0IarrnJhJsMjveSbrTPDuoLkNUFBdS5cOEgpdjrqppymYIcAn20o9a0J069Hg
 ZX+dzJmmNGZYD6yErOpq/MMHUJM0VIEEhDJF1MCTG8c9dQt2pyosFxlUTFj84zq0KxttYEKCM
 M7YAn4xZIHh5OEvIC1R/pVvhyQN1vnoO9nTh8L6dp5jnzkSYHx6XBiN8ITcP1FVHHT5MStnw+
 4S6aqLQAIXOfiO50pbOiUXwnPDgSa0QPUdl3jw3QwXnRk+IdGEX/GWCY3iF2kZEmPuE2LhsbD
 WIwrNdhyMwDith5p2pViRoK3bge/TSVloPOaYCrCI1Z+4IV/LsdWke7Qg==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/17 22:50, Christoph Hellwig wrote:
> This helpers works like submit_bio_wait, but goes through the btrfs bio
> mapping using btrfs_map_bio.

I hate the naming of btrfs_map_bio(), which should be
btrfs_map_and_submit_bio(), but I also totally understand my poor naming
scheme is even worse for most cases.

Maybe we can add the "submit" part into the new function?
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/volumes.c | 21 +++++++++++++++++++++
>   fs/btrfs/volumes.h |  2 ++
>   2 files changed, 23 insertions(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0819db46dbc42..8925bc606db7e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6818,6 +6818,27 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *=
fs_info, struct bio *bio,
>   	return BLK_STS_OK;
>   }
>
> +static void btrfs_end_io_sync(struct bio *bio)
> +{
> +	complete(bio->bi_private);
> +}
> +
> +blk_status_t btrfs_map_bio_wait(struct btrfs_fs_info *fs_info, struct b=
io *bio,
> +		int mirror)
> +{
> +	DECLARE_COMPLETION_ONSTACK(done);
> +	blk_status_t ret;

Is there any lockdep assert to make sure we're in wq context?

Despite these nitpicks, it looks good to me.

Thanks,
Qu

> +
> +	bio->bi_private =3D &done;
> +	bio->bi_end_io =3D btrfs_end_io_sync;
> +	ret =3D btrfs_map_bio(fs_info, bio, mirror);
> +	if (ret)
> +		return ret;
> +
> +	wait_for_completion_io(&done);
> +	return bio->bi_status;
> +}
> +
>   static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_ar=
gs *args,
>   				      const struct btrfs_fs_devices *fs_devices)
>   {
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 6f784d4f54664..b346f6c401515 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -555,6 +555,8 @@ struct btrfs_block_group *btrfs_create_chunk(struct =
btrfs_trans_handle *trans,
>   void btrfs_mapping_tree_free(struct extent_map_tree *tree);
>   blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *=
bio,
>   			   int mirror_num);
> +blk_status_t btrfs_map_bio_wait(struct btrfs_fs_info *fs_info, struct b=
io *bio,
> +		int mirror);
>   int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>   		       fmode_t flags, void *holder);
>   struct btrfs_device *btrfs_scan_one_device(const char *path,
