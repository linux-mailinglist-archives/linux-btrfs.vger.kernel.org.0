Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5522C53C8C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 12:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243720AbiFCKdU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 06:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241739AbiFCKdS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 06:33:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7D72A70A
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654252393;
        bh=R0ldykBC8wtlS6sN3pt6SvUyoq8wG8hMHoCwBv1RIAk=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=XnihLRLrHRIeA3Voh5h2Qqyw7KVN63hcxT3AvUDSBuGZDl8aPQN7aZBahJQy+gSSb
         qQJy2Sx2qJZSavMV+39Rt7rR3kB0kqZ/enAczb4v/poftkhMsbMw0N2rvBi/ZkSkMJ
         i975aYNSjKBNcmuonOg2UWxqIRl0vjSZRXXyhhC8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbVu-1o0uta1PWY-00H4E6; Fri, 03
 Jun 2022 12:33:13 +0200
Message-ID: <714fe5b2-4a38-c373-c03b-d5b822d94a7f@gmx.com>
Date:   Fri, 3 Jun 2022 18:33:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220603071103.43440-1-hch@lst.de>
 <20220603071103.43440-2-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/3] btrfs: don't use bio->bi_private to pass the inode to
 submit_one_bio
In-Reply-To: <20220603071103.43440-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kc2n+f7QDuPZLH8PfKFwj+X3I44zPuM0JZjQJPAJdJOg3eni2D5
 y8IM3+4ARnPe4Z0NNwrrytGUHmW+LvTlyJHgeoi1H3JbS9J4ds7eKky4MSlxNwzWixLjR7R
 QGw6oIRhPuOC9dtVvtghMqGZMNPnqTHyMeYt4NrwmRfkouvCcSbUmXqMyZ+apUZMM4SLLNb
 BT3sCb9yQE0CiZ6I9Eqgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sq2XnvH5iTA=:O6JnSwoUFKlb6N516+K4HJ
 x8TNKpw5NA694YU5pDhTiaWnHMJTIDaTjBS2eOIJEh0apHbwovX7V4EU0WjOPdRtcn76RcJJL
 XOUQgojquFD4KXvOWXrpYAEinklN0B7ZC1hM5zPiEqWwmeRlMFBKjlv4u/L/FLrFt54OEvamX
 uJHuB26ZyfyX3IpJNX5qpLPjtkZZuyZfKvARYFT1qyWcwH/Kqa6Q2X3qTDuWeGmTaeRLLzV+t
 ExBUMhD0+hIv+83jx3TRa81/GmPT0M5rqAwZCs8WZmhpH0ZFXnDSWQmBX8raAwBxU2tepOCjX
 KzS20B1hHJsy7i63peXRyD6Ujz2bTUiuw8Ejn0r4rQf4P3abQmeavqk/FCggpXHDKi7ri8kqr
 wxcqFYMWV3likng3p8AG0XiGgBt0Mh+fEyk6WLZScJOCzj+leOCfiz5fxYZaapVOEs2ae1hWS
 ecIuTNsn03R2UOAeZWTLIha4Kn8PKWpkPvZ4vfPrtliekHOUjJTtOAc7cvsujMmuD2nl48a4V
 dNf1zvn0A1wlyqKPbRcpVpO9MWlx1tL5y8shUqEf2gCiacek5r+Y7XGQRkBy9m3SfkOLVbqrA
 VYwb7HILiBM6fL56PEYiFwAIhC/GlUAjikOFtLMR7+eNiEpk2GbAmUs4K8fZW506tp8YluedR
 m9/uZY+ZbAqep/Jp4G2lJXxY2bCLApQo9OFXhq/2EDpMdaWuCMuZq7xwwEyCVhxCVcMzwxYAS
 HRPf7imT4TUHQW2LVgWrYAuegna3MSDX5LFfVLjs0LeEDkTfindIr3EzlrOOrniQQ/KxSmrQI
 GWAdi1IUp1kBZP7Fh5xURoZGzyjgRSf3eaeITrdg7YFPLxJpRQxEs27DzQKKudKJmzG1lDrpB
 XKRuytP/D0ic0MhIAIuR4W+ZoJWOUT3f/0KOmDsWhr4Ih0ry+cWHBRrJf3H5iOKEcKVW0gjp4
 iF8mr+iA5x7oNHojLIwPmYEZvVXRmTEcYCx5uqRwsIM0rQazFpIGL5t9riRalfjuYQH8TOW2n
 mcNFGYE9PMAFTVjVL1pezXZizEPsIL8MfRrW9Gkn0U3FdV4tlJm8O0jHnISkgrf/5ln0u97DG
 npTX1PaGJ4zEhhloVNVoY0P+X6snHhWQL/wDqfr6uq4XnK2zONPcll/Uw==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/3 15:11, Christoph Hellwig wrote:
> submit_one_bio is only used for page cache I/O, so the inode can be
> trivially derived from the first page in the bio.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

> ---
>   fs/btrfs/extent_io.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7b5f872d2eb9f..025349aeec31f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -181,10 +181,7 @@ static int add_extent_changeset(struct extent_state=
 *state, u32 bits,
>   static void submit_one_bio(struct bio *bio, int mirror_num,
>   			   enum btrfs_compression_type compress_type)
>   {
> -	struct extent_io_tree *tree =3D bio->bi_private;
> -	struct inode *inode =3D tree->private_data;
> -
> -	bio->bi_private =3D NULL;
> +	struct inode *inode =3D bio_first_page_all(bio)->mapping->host;
>
>   	/* Caller should ensure the bio has at least some range added */
>   	ASSERT(bio->bi_iter.bi_size);
> @@ -3360,7 +3357,6 @@ static int alloc_new_bio(struct btrfs_inode *inode=
,
>   	bio_ctrl->bio =3D bio;
>   	bio_ctrl->compress_type =3D compress_type;
>   	bio->bi_end_io =3D end_io_func;
> -	bio->bi_private =3D &inode->io_tree;

And what the heck that we're passing io_tree into bi_private??
At least we should try passing inode.

Anyway, the old behavior makes no sense, great we can get rid of it.

BTW, I didn't see modification in btrfs_repair_one_sector(), it is not a
problem since we no longer utilize bi_private, but it may be better
explicitly remove that call site too.

Thanks,
Qu
>   	bio->bi_opf =3D opf;
>   	ret =3D calc_bio_boundaries(bio_ctrl, inode, file_offset);
>   	if (ret < 0)
