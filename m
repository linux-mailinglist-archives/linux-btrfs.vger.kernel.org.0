Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75565031C7
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Apr 2022 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbiDOWvR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 18:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiDOWvQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 18:51:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280FF60ABE
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 15:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650062922;
        bh=VzoFGr9OF4ZVehBpdJ0JKM6ul7WUNtcNW98O0GENa4g=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=h55sgmKh8s7CFEPfWeKRLvZL55zLXxl/w4+j/wa95JMsP3slQpCvRh8ZosnVo1Bkl
         N69eu+TuVSLdN8XK5aM2l/xssOnbmMpeQkmsD/LPDYL3I8bYInOu9vqZPsf9C3Wd1h
         n9vTQhIbslr3iePvP/peVMXg9izhlyU2UGEu8RDg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbRm-1njINL1Dfa-00H4GH; Sat, 16
 Apr 2022 00:48:41 +0200
Message-ID: <935e4667-2414-4620-382c-333075150f8f@gmx.com>
Date:   Sat, 16 Apr 2022 06:48:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/5] btrfs: do not return errors from
 btrfs_submit_compressed_read
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220415143328.349010-1-hch@lst.de>
 <20220415143328.349010-5-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220415143328.349010-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TjvM6YSUtiyNgxDnMLNI9sSTsPKBHeotBoKieHBTGxL7LnMEznR
 uwyk3eiaM3pGN/Jh6GI87T27mdJO2Gr394T1SVoBe0jIb2PufPQKxYcQVErWFpWT3BO2Ywb
 2Ng76kQHvEHO/caM8PSrc51VR6ztNMn4yCLt8i1ZcKoKjI4hCqElaqnC1BHQ2RIOexfa6Gk
 /r4iBPbEnnZ7nnVDQDm5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JVEhqhcua5o=:wTWhRxIxhdEygLLLTMuKKk
 ADChk2iKmy8AOCDZhRMgBfnF8e51vC5ytcf9Z+o0VhHFDAg8o/ICdq93kHeSTXJwbBKA3SNl4
 8h6xAQgWfWxp7aeNteuu3zDHr2tVfFwrlPcynLMLbXPx/lDDffNd3GkWP2EXCSuXQOcsmwATK
 PZazuG0qM6At1uf25PKsQ/qD1dEkgmQIJVUncOSN7q3ew30VecqrDv8Q/iTSFQduRJj/0t56K
 iLbAqaCw9bsRvEkTVATWC5uAAODmKcmkyFjNhFIEbpjaM/PCmQ8vxxd3LhP5/UY22TuU9erdb
 l75wXh88ukPGXl2WgLFzmEus0iEE1EJNpni8DnECtrmucbFSFPFIvp5mxCEeNhIQ+6cTRtezU
 /kYLco/qAfdcKsyF/kCDZl5NiOMHOcj9WdX6Rg68gIPXi9HtyLHeaqrZWEFy5wut+ccZjn5Za
 8SV7w6HeYX+3V8ScUarAKYvcDwV+rCJuHqxY+OPYAUQ/kxgBTHp6VNMBQfRCdfpLbfzE/oqeq
 7QHcz6dZBuxk+hHpPs/WOPksaRPVBSQdOLvdfmls8OLwd7y183EsEXDtxtFpqHKibdVRLMpUr
 PgdlfzSRxVrMBpNbTqfwLTYGe1S1KQ8pR5H25I0Tx8f9fZeA87R1wuRhbPR1ZtBFXsynR0qco
 mFjQJJ//2FN+HxZsObl5Rbdv+SIqQC+uaLuSm3CvbCdxT6VS7s/fkCP1LQTjIAO3IZbpeyoK1
 ui1/lTFC4n2wEB2yOszwb7iFG0VpkkndVtGM/pb+RQZ6ayzeX/1nRikcuHhoPobYLrEEIi+r1
 6DFuK1F19WTZyeL0kDJhvHTXp+aWxO9Bt3Ux6S7GMZSwfV4GwFDYqWlQ5y1Xo+bq33PNJOoUs
 syu6RRphwc2DeBU26mBeW9siYq2ArzUff8JfN1J0KwTxo85f/GRfGYtQALXsgUdJSKul+tH4i
 bQMZ3jCaCtXr+OZXoUv9GXQ2Eq4Dk60HowlET72FrH4suygeiB4va44auUpZuaCYnFHzJrUXK
 1RBZ5XZz36Skne/A0D7+GrB+0Xp5yPaR5PxISaeAoOq0HZeiV+jDNKg4mbRkXHEianYseabpb
 5HqLLnRsFM0cbk=
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/15 22:33, Christoph Hellwig wrote:
> btrfs_submit_compressed_read already calls ->bi_end_io on error and
> the caller must ignore the return value, so remove it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The patch itself is fine.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although more such cleanups are going to bring some question on how
those bio handling functions should behavior.

More and more bio submit functions are returning void and endio of the bio=
.

But there are still quite some not doing this, like btrfs_map_bio().

I'm wondering at which boundary we should return void and handle
everything in-house?

Thanks,
Qu
> ---
>   fs/btrfs/compression.c | 11 +++++------
>   fs/btrfs/compression.h |  4 ++--
>   fs/btrfs/inode.c       |  8 +++-----
>   3 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 3e8417bfabe65..8fda38a587067 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -801,8 +801,8 @@ static noinline int add_ra_bio_pages(struct inode *i=
node,
>    * After the compressed pages are read, we copy the bytes into the
>    * bio we were passed and then call the bio end_io calls
>    */
> -blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct b=
io *bio,
> -				 int mirror_num, unsigned long bio_flags)
> +void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
> +				  int mirror_num, unsigned long bio_flags)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	struct extent_map_tree *em_tree;
> @@ -947,7 +947,7 @@ blk_status_t btrfs_submit_compressed_read(struct ino=
de *inode, struct bio *bio,
>   			comp_bio =3D NULL;
>   		}
>   	}
> -	return BLK_STS_OK;
> +	return;
>
>   fail:
>   	if (cb->compressed_pages) {
> @@ -963,7 +963,7 @@ blk_status_t btrfs_submit_compressed_read(struct ino=
de *inode, struct bio *bio,
>   	free_extent_map(em);
>   	bio->bi_status =3D ret;
>   	bio_endio(bio);
> -	return ret;
> +	return;
>   finish_cb:
>   	if (comp_bio) {
>   		comp_bio->bi_status =3D ret;
> @@ -971,7 +971,7 @@ blk_status_t btrfs_submit_compressed_read(struct ino=
de *inode, struct bio *bio,
>   	}
>   	/* All bytes of @cb is submitted, endio will free @cb */
>   	if (cur_disk_byte =3D=3D disk_bytenr + compressed_len)
> -		return ret;
> +		return;
>
>   	wait_var_event(cb, refcount_read(&cb->pending_sectors) =3D=3D
>   			   (disk_bytenr + compressed_len - cur_disk_byte) >>
> @@ -983,7 +983,6 @@ blk_status_t btrfs_submit_compressed_read(struct ino=
de *inode, struct bio *bio,
>   	ASSERT(refcount_read(&cb->pending_sectors));
>   	/* Now we are the only one referring @cb, can finish it safely. */
>   	finish_compressed_bio_read(cb);
> -	return ret;
>   }
>
>   /*
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index ac5b20731d2ad..ac3c79f8c3492 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -102,8 +102,8 @@ blk_status_t btrfs_submit_compressed_write(struct bt=
rfs_inode *inode, u64 start,
>   				  unsigned int write_flags,
>   				  struct cgroup_subsys_state *blkcg_css,
>   				  bool writeback);
> -blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct b=
io *bio,
> -				 int mirror_num, unsigned long bio_flags);
> +void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
> +				  int mirror_num, unsigned long bio_flags);
>
>   unsigned int btrfs_compress_str2level(unsigned int type, const char *s=
tr);
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index f2fb2bfc2f9a2..414156c0ac38a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2618,10 +2618,9 @@ blk_status_t btrfs_submit_data_bio(struct inode *=
inode, struct bio *bio,
>   			 * the bio if there were any errors, so just return
>   			 * here.
>   			 */
> -			ret =3D btrfs_submit_compressed_read(inode, bio,
> -							   mirror_num,
> -							   bio_flags);
> -			goto out_no_endio;
> +			btrfs_submit_compressed_read(inode, bio, mirror_num,
> +						     bio_flags);
> +			return BLK_STS_OK;
>   		} else {
>   			/*
>   			 * Lookup bio sums does extra checks around whether we
> @@ -2655,7 +2654,6 @@ blk_status_t btrfs_submit_data_bio(struct inode *i=
node, struct bio *bio,
>   		bio->bi_status =3D ret;
>   		bio_endio(bio);
>   	}
> -out_no_endio:
>   	return ret;
>   }
>
