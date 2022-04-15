Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08685031AF
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Apr 2022 01:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiDOWwD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 18:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiDOWwC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 18:52:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E791463F8
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 15:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650062966;
        bh=U5pgn+fbW536m0lnClCGE0zeuAWG868PF/RIJobYTxg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Ws8Ed2lywtE8700FhRsGIx+FMvlTzPhMNkbqhjLY9d43UJQHVYJHjrv0DwAZXOx66
         pwjMMeV8o2GEEqeSbqWDpdyC+/lxOEuO9zZ4h8laOFrA+4xMlwM7r9wH8737ZF6ij9
         UrLVuC9R4wPyDtrvBu8dikcHD6zZNZowwbN3GIRw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N17UW-1o40eF2a5q-012Zc4; Sat, 16
 Apr 2022 00:49:26 +0200
Message-ID: <ad361fac-c81d-4a6a-84a8-040ca28763bc@gmx.com>
Date:   Sat, 16 Apr 2022 06:49:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 5/5] btrfs: do not return errors from submit_bio_hook_t
 instances
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220415143328.349010-1-hch@lst.de>
 <20220415143328.349010-6-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220415143328.349010-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h7sp2dkyPrInFCE4OJ2fYqDDLX3rAJw5ZGMorUZaSvZaNGGCVG1
 0y4hugSRqc6SonJsUFav3HNNV5Lxnipv3mtIFK3G/aRCHAUp7QAwINtYEnVsbxbmvi7rj4v
 DIPopFEjMDjruZZtzdKjVY858FKXsltsVpfj3xwZwvIXv6TBIutrtcSHlsFtNNDxRU34ZdS
 JSXer9XNhP63+U/66pETg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wb47z36nrG4=:sQ7hXxWbI29j8yC/CljqqW
 XBdOLplH2aLRsQhR3qXnC7rSNWlLetZHiI4K0hplFpjRsRCX46y+p3lbAMfrJA5IaQCY5BmV9
 qXUjtFRW3I8mdBHHisH63LwLoNg4cIuEChAbisXwaSp+9oBhQug1KjSLI3OjmGyNJt7wKKnvH
 YOxK9c8rrC02XUyF7Yxs6VR6so4fDHqwRcbzdrRTEvumzNiOh5HtlvAMBjdzjDP3g898EkVAZ
 gm3QjNmLA5kG/ZrFRUOemur0Tv8l5+q33Y8lcY+D7kaqr+gNTQYJ/N019/A79T35NaYbfrzL+
 JX1GNLqRWUZV+Po4dYlT0j1/oe6jPdURqUrr/Q7dgGrbWWgbIop11/E2WtooFAFQDcOZTCdKR
 5nsjS6lFDyjSlz0at8EXT71+KsQFMYXrfIhrZjhkw9ORLzKTq6J5pkzdAKzelJMsr7oz3wok1
 7t7AcRhKPDDSegq7voc1nCmmD3MQdWFAcYu5fmVJ899+jFXMhxdoXKiPMRc8lvpwznn+SFUz8
 OMrmnil+9rVBYeVhEti6FZUQomM37VnxxYMwcfFX8uP+UAONsa5oAe22sitBUvzkuoycQtKP7
 wbnJLRnARS/54Zd8U1UuEUvEDDH4lR8GG4X6fsgLZrhxujr3En1Pjhg1xwlPLmd0B8PzmwcLt
 DLbg6LwOrB5KElHMOqv2KfuFG2CyHXYAo25CwBR1Jgp+GsjSsdJNC+i4K7VHQjhv162b+CgKj
 IWll2Zkc4U5qKhHXr8Uw2d12QfDT2LDjFfXEFZB2lW2t2EiIztmv6Vk0Kxacsansv26pMYIqs
 1ec0cbDXmrydlkau13IpJxeGWuLb12a7FjHvJvP6ff7nZKFagT4YHIjGPZu8KsBpnhqopppaD
 FCwShgS/jYwdpCq2Yc3oDaOhXxTd8o6opu2KBTuIS3I5/3l2ibchab1J1c8tEtbHg2gklBDcC
 r485YSV0ooQpjlhJa1UekoqwlGF2ObT1gmuCezdDcX3A5bPTtyRNQdIb/nAPXlXHstvP6mgPp
 6/uaT6b3ZZoD4+5YpMka+3Z5hcEVFyNElRIxHI1OFgOAOJnOsl5H6tSECTSbexaXMzr6L1FQU
 fyPHrm3Mx/DXyk=
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/15 22:33, Christoph Hellwig wrote:
> Both btrfs_repair_one_sector and submit_bio_one as the direct caller of
> one of the instances ignore errors as they expect the methods themselves
> to call ->bi_end_io on error.  Remove the unused and dangerous return
> value.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.h     |  4 ++--
>   fs/btrfs/extent_io.h |  2 +-
>   fs/btrfs/inode.c     | 23 ++++++++---------------
>   3 files changed, 11 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 0fd3a21cd5a89..67e169ba55e87 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3249,8 +3249,8 @@ void btrfs_inode_safe_disk_i_size_write(struct btr=
fs_inode *inode, u64 new_i_siz
>   u64 btrfs_file_extent_end(const struct btrfs_path *path);
>
>   /* inode.c */
> -blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio=
,
> -				   int mirror_num, unsigned long bio_flags);
> +void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
> +			   int mirror_num, unsigned long bio_flags);
>   unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
>   				    u32 bio_offset, struct page *page,
>   				    u64 start, u64 end);
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index c94df8e2ab9d6..b390ec79f9a86 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -71,7 +71,7 @@ struct btrfs_fs_info;
>   struct io_failure_record;
>   struct extent_io_tree;
>
> -typedef blk_status_t (submit_bio_hook_t)(struct inode *inode, struct bi=
o *bio,
> +typedef void (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
>   					 int mirror_num,
>   					 unsigned long bio_flags);
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 414156c0ac38a..a37da2decf958 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2581,9 +2581,8 @@ static blk_status_t extract_ordered_extent(struct =
btrfs_inode *inode,
>    *
>    *    c-3) otherwise:			async submit
>    */
> -blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio=
,
> -				   int mirror_num, unsigned long bio_flags)
> -
> +void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
> +			   int mirror_num, unsigned long bio_flags)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	struct btrfs_root *root =3D BTRFS_I(inode)->root;
> @@ -2620,7 +2619,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *i=
node, struct bio *bio,
>   			 */
>   			btrfs_submit_compressed_read(inode, bio, mirror_num,
>   						     bio_flags);
> -			return BLK_STS_OK;
> +			return;
>   		} else {
>   			/*
>   			 * Lookup bio sums does extra checks around whether we
> @@ -2654,7 +2653,6 @@ blk_status_t btrfs_submit_data_bio(struct inode *i=
node, struct bio *bio,
>   		bio->bi_status =3D ret;
>   		bio_endio(bio);
>   	}
> -	return ret;
>   }
>
>   /*
> @@ -7798,25 +7796,20 @@ static void btrfs_dio_private_put(struct btrfs_d=
io_private *dip)
>   	kfree(dip);
>   }
>
> -static blk_status_t submit_dio_repair_bio(struct inode *inode, struct b=
io *bio,
> -					  int mirror_num,
> -					  unsigned long bio_flags)
> +static void submit_dio_repair_bio(struct inode *inode, struct bio *bio,
> +				  int mirror_num, unsigned long bio_flags)
>   {
>   	struct btrfs_dio_private *dip =3D bio->bi_private;
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> -	blk_status_t ret;
>
>   	BUG_ON(bio_op(bio) =3D=3D REQ_OP_WRITE);
>
> -	ret =3D btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
> -	if (ret)
> -		return ret;
> +	if (btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA))
> +		return;
>
>   	refcount_inc(&dip->refs);
> -	ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> -	if (ret)
> +	if (btrfs_map_bio(fs_info, bio, mirror_num))
>   		refcount_dec(&dip->refs);
> -	return ret;
>   }
>
>   static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private =
*dip,
