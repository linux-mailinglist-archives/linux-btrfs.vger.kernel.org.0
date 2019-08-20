Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A66ED95ABD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 11:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfHTJM6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 05:12:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:38372 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728414AbfHTJM6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 05:12:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1015FAF81
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2019 09:12:55 +0000 (UTC)
Date:   Tue, 20 Aug 2019 11:12:54 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 12/17] btrfs-progs: pass checksum type to
 btrfs_csum_data()
Message-ID: <20190820091254.GF28770@x250>
References: <cover.1564046812.git.jthumshirn@suse.de>
 <cover.1564046812.git.jthumshirn@suse.de>
 <e1ca8b3c89c7a07143928ba29a5eb7494fc60b53.1564046972.git.jthumshirn@suse.de>
 <25578854-fd24-8427-f89d-761e972762a5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25578854-fd24-8427-f89d-761e972762a5@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 12, 2019 at 01:51:01PM +0300, Nikolay Borisov wrote:
> 
> 
> On 25.07.19 г. 12:33 ч., Johannes Thumshirn wrote:
> 
> So patches 12/13 have identical titles, different contents and
> absolutely no commit messages :( . How about no... Squash 13 into 12 and
> put a commit explaining your change. And by the way the patch's title
> doesn't correspond to the content of the patches - you also change
> btrfs_checksum_final to take a csum_type

Yep already done.

> 
> 
> Something as straightforward as the below example should suffice:
> 
> "In preparation to supporting new checksum algorithm pass the checksum
> type to btrfs_csum_data/btrfs_csum_final, this allows us to encapsulate
> any differences in processing into the respective functions".
> 

Sounds good, will update it.

> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > ---
> >  check/main.c                |  6 ++++--
> >  cmds/inspect-dump-super.c   |  8 ++++----
> >  cmds/rescue-chunk-recover.c | 10 ++++++----
> >  convert/common.c            |  5 +++--
> >  disk-io.c                   | 39 +++++++++++++++++++++++++++------------
> >  disk-io.h                   |  4 ++--
> >  file-item.c                 |  7 +++++--
> >  free-space-cache.c          |  2 +-
> >  image/main.c                |  2 +-
> >  9 files changed, 53 insertions(+), 30 deletions(-)
> > 
> > diff --git a/check/main.c b/check/main.c
> > index 92a7e40c1ebf..eabe328b6800 100644
> > --- a/check/main.c
> > +++ b/check/main.c
> > @@ -5581,6 +5581,7 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
> >  	struct btrfs_fs_info *fs_info = root->fs_info;
> >  	u64 offset = 0;
> >  	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
> > +	u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
> >  	char *data;
> >  	unsigned long csum_offset;
> >  	u32 csum;
> > @@ -5621,9 +5622,10 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
> >  				csum = ~(u32)0;
> >  				tmp = offset + data_checked;
> >  
> > -				csum = btrfs_csum_data((char *)data + tmp,
> > +				csum = btrfs_csum_data(csum_type,
> > +						       (char *)data + tmp,
> >  						(u8 *)&csum, fs_info->sectorsize);
> > -				btrfs_csum_final(csum, (u8 *)&csum);
> > +				btrfs_csum_final(csum_type, csum, (u8 *)&csum);
> >  
> >  				csum_offset = leaf_offset +
> >  					 tmp / fs_info->sectorsize * csum_size;
> > diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
> > index 96ad3deca3d8..40019a6670ef 100644
> > --- a/cmds/inspect-dump-super.c
> > +++ b/cmds/inspect-dump-super.c
> > @@ -35,15 +35,15 @@
> >  #include "kernel-lib/crc32c.h"
> >  #include "common/help.h"
> >  
> > -static int check_csum_sblock(void *sb, int csum_size)
> > +static int check_csum_sblock(void *sb, int csum_size, u16 csum_type)
> >  {
> >  	u8 result[BTRFS_CSUM_SIZE];
> >  	u32 crc = ~(u32)0;
> >  
> > -	crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE,
> > +	crc = btrfs_csum_data(csum_type, (char *)sb + BTRFS_CSUM_SIZE,
> >  				(u8 *)&crc,
> >  				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> > -	btrfs_csum_final(crc, result);
> > +	btrfs_csum_final(csum_type, crc, result);
> >  
> >  	return !memcmp(sb, &result, csum_size);
> >  }
> > @@ -348,7 +348,7 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
> >  	if (csum_type != BTRFS_CSUM_TYPE_CRC32 ||
> >  	    csum_size != btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32])
> >  		printf(" [UNKNOWN CSUM TYPE OR SIZE]");
> > -	else if (check_csum_sblock(sb, csum_size))
> > +	else if (check_csum_sblock(sb, csum_size, csum_type))
> >  		printf(" [match]");
> >  	else
> >  		printf(" [DON'T MATCH]");
> > diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
> > index 0fddb5dd8ead..cddae471f50c 100644
> > --- a/cmds/rescue-chunk-recover.c
> > +++ b/cmds/rescue-chunk-recover.c
> > @@ -1887,7 +1887,8 @@ static u64 calc_data_offset(struct btrfs_key *key,
> >  	return dev_offset + data_offset;
> >  }
> >  
> > -static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum)
> > +static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum,
> > +			  u16 csum_type)
> >  {
> >  	char *data;
> >  	int ret = 0;
> > @@ -1902,8 +1903,8 @@ static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum)
> >  		goto out;
> >  	}
> >  	ret = 0;
> > -	csum_result = btrfs_csum_data(data, (u8 *)&csum_result, len);
> > -	btrfs_csum_final(csum_result, (u8 *)&csum_result);
> > +	csum_result = btrfs_csum_data(csum_type, data, (u8 *)&csum_result, len);
> > +	btrfs_csum_final(csum_type, csum_result, (u8 *)&csum_result);
> >  	if (csum_result != tree_csum)
> >  		ret = 1;
> >  out:
> > @@ -2102,7 +2103,8 @@ next_csum:
> >  						  devext->objectid, 1));
> >  
> >  		ret = check_one_csum(dev->fd, data_offset, blocksize,
> > -				     tree_csum);
> > +				     tree_csum,
> > +				     btrfs_super_csum_type(root->fs_info->super_copy));
> >  		if (ret < 0)
> >  			goto fail_out;
> >  		else if (ret > 0)
> > diff --git a/convert/common.c b/convert/common.c
> > index ab8e6b9f4749..894a6ee0ba90 100644
> > --- a/convert/common.c
> > +++ b/convert/common.c
> > @@ -63,12 +63,13 @@ static inline int write_temp_super(int fd, struct btrfs_super_block *sb,
> >                                    u64 sb_bytenr)
> >  {
> >         u32 crc = ~(u32)0;
> > +       u16 csum_type = btrfs_super_csum_type(sb);
> >         int ret;
> >  
> > -       crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE,
> > +       crc = btrfs_csum_data(csum_type, (char *)sb + BTRFS_CSUM_SIZE,
> >  			     (u8 *)&crc,
> >                               BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> > -       btrfs_csum_final(crc, &sb->csum[0]);
> > +       btrfs_csum_final(csum_type, crc, &sb->csum[0]);
> >         ret = pwrite(fd, sb, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
> >         if (ret < BTRFS_SUPER_INFO_SIZE)
> >                 ret = (ret < 0 ? -errno : -EIO);
> > diff --git a/disk-io.c b/disk-io.c
> > index a0c37c569d58..7e538969c57a 100644
> > --- a/disk-io.c
> > +++ b/disk-io.c
> > @@ -138,14 +138,26 @@ static void print_tree_block_error(struct btrfs_fs_info *fs_info,
> >  	}
> >  }
> >  
> > -u32 btrfs_csum_data(char *data, u8 *seed, size_t len)
> > +u32 btrfs_csum_data(u16 csum_type, char *data, u8 *seed, size_t len)
> >  {
> > -	return crc32c(*(u32*)seed, data, len);
> > +	switch (csum_type) {
> > +	case BTRFS_CSUM_TYPE_CRC32:
> > +		return crc32c(*(u32*)seed, data, len);
> > +	default: /* Not reached */
> > +		return ~(u32)0;
> > +	}
> > +
> >  }
> >  
> > -void btrfs_csum_final(u32 crc, u8 *result)
> > +void btrfs_csum_final(u16 csum_type, u32 crc, u8 *result)
> >  {
> > -	put_unaligned_le32(~crc, result);
> > +	switch (csum_type) {
> > +	case BTRFS_CSUM_TYPE_CRC32:
> > +		put_unaligned_le32(~crc, result);
> > +		break;
> > +	default: /* Not reached */
> > +		break;
> > +	}
> >  }
> >  
> >  static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
> > @@ -156,8 +168,9 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
> >  	u32 crc = ~(u32)0;
> >  
> >  	len = buf->len - BTRFS_CSUM_SIZE;
> > -	crc = btrfs_csum_data(buf->data + BTRFS_CSUM_SIZE, (u8 *)&crc, len);
> > -	btrfs_csum_final(crc, result);
> > +	crc = btrfs_csum_data(csum_type, buf->data + BTRFS_CSUM_SIZE,
> > +			      (u8 *)&crc, len);
> > +	btrfs_csum_final(csum_type, crc, result);
> >  
> >  	if (verify) {
> >  		if (memcmp_extent_buffer(buf, result, 0, csum_size)) {
> > @@ -1376,9 +1389,10 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
> >  	csum_size = btrfs_csum_sizes[csum_type];
> >  
> >  	crc = ~(u32)0;
> > -	crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
> > +	crc = btrfs_csum_data(csum_type,(char *)sb + BTRFS_CSUM_SIZE,
> > +			      (u8 *)&crc,
> >  			      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> > -	btrfs_csum_final(crc, result);
> > +	btrfs_csum_final(csum_type, crc, result);
> >  
> >  	if (memcmp(result, sb->csum, csum_size)) {
> >  		error("superblock checksum mismatch");
> > @@ -1616,6 +1630,7 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
> >  	u64 bytenr;
> >  	u32 crc;
> >  	int i, ret;
> > +	u16 csum_type = btrfs_super_csum_type(sb);
> >  
> >  	/*
> >  	 * We need to write super block after all metadata written.
> > @@ -1631,9 +1646,9 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
> >  	if (fs_info->super_bytenr != BTRFS_SUPER_INFO_OFFSET) {
> >  		btrfs_set_super_bytenr(sb, fs_info->super_bytenr);
> >  		crc = ~(u32)0;
> > -		crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
> > +		crc = btrfs_csum_data(csum_type, (char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
> >  				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> > -		btrfs_csum_final(crc, &sb->csum[0]);
> > +		btrfs_csum_final(csum_type, crc, &sb->csum[0]);
> >  
> >  		/*
> >  		 * super_copy is BTRFS_SUPER_INFO_SIZE bytes and is
> > @@ -1667,9 +1682,9 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
> >  		btrfs_set_super_bytenr(sb, bytenr);
> >  
> >  		crc = ~(u32)0;
> > -		crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
> > +		crc = btrfs_csum_data(csum_type, (char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
> >  				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> > -		btrfs_csum_final(crc, &sb->csum[0]);
> > +		btrfs_csum_final(csum_type, crc, &sb->csum[0]);
> >  
> >  		/*
> >  		 * super_copy is BTRFS_SUPER_INFO_SIZE bytes and is
> > diff --git a/disk-io.h b/disk-io.h
> > index 92c87f28f8b2..4b5e9ea86385 100644
> > --- a/disk-io.h
> > +++ b/disk-io.h
> > @@ -186,8 +186,8 @@ int btrfs_free_fs_root(struct btrfs_root *root);
> >  void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
> >  int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid);
> >  int btrfs_set_buffer_uptodate(struct extent_buffer *buf);
> > -u32 btrfs_csum_data(char *data, u8 *seed, size_t len);
> > -void btrfs_csum_final(u32 crc, u8 *result);
> > +u32 btrfs_csum_data(u16 csum_type, char *data, u8 *seed, size_t len);
> > +void btrfs_csum_final(u16 csum_type, u32 crc, u8 *result);
> >  
> >  int btrfs_open_device(struct btrfs_device *dev);
> >  int csum_tree_block_size(struct extent_buffer *buf, u16 csum_sectorsize,
> > diff --git a/file-item.c b/file-item.c
> > index 5f6548e9a74f..78fdcecd0bab 100644
> > --- a/file-item.c
> > +++ b/file-item.c
> > @@ -202,6 +202,9 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
> >  	u16 csum_size =
> >  		btrfs_super_csum_size(root->fs_info->super_copy);
> >  
> > +	u16 csum_type =
> > +		btrfs_super_csum_type(root->fs_info->super_copy);
> > +
> >  	path = btrfs_alloc_path();
> >  	if (!path)
> >  		return -ENOMEM;
> > @@ -312,8 +315,8 @@ csum:
> >  	item = (struct btrfs_csum_item *)((unsigned char *)item +
> >  					  csum_offset * csum_size);
> >  found:
> > -	csum_result = btrfs_csum_data(data, (u8 *)&csum_result, len);
> > -	btrfs_csum_final(csum_result, (u8 *)&csum_result);
> > +	csum_result = btrfs_csum_data(csum_type, data, (u8 *)&csum_result, len);
> > +	btrfs_csum_final(csum_type, csum_result, (u8 *)&csum_result);
> >  	if (csum_result == 0) {
> >  		printk("csum result is 0 for block %llu\n",
> >  		       (unsigned long long)bytenr);
> > diff --git a/free-space-cache.c b/free-space-cache.c
> > index e872eb6a00db..8a57f86dc650 100644
> > --- a/free-space-cache.c
> > +++ b/free-space-cache.c
> > @@ -213,7 +213,7 @@ static int io_ctl_check_crc(struct io_ctl *io_ctl, int index)
> >  	io_ctl_map_page(io_ctl, 0);
> >  	crc = crc32c(crc, io_ctl->orig + offset,
> >  			io_ctl->root->fs_info->sectorsize - offset);
> > -	btrfs_csum_final(crc, (u8 *)&crc);
> > +	put_unaligned_le32(~crc, (u8 *)&crc);
> >  	if (val != crc) {
> >  		printk("btrfs: csum mismatch on free space cache\n");
> >  		io_ctl_unmap_page(io_ctl);
> > diff --git a/image/main.c b/image/main.c
> > index 28ef1609b5ff..0c8ffede56f5 100644
> > --- a/image/main.c
> > +++ b/image/main.c
> > @@ -124,7 +124,7 @@ static void csum_block(u8 *buf, size_t len)
> >  	u8 result[btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32]];
> >  	u32 crc = ~(u32)0;
> >  	crc = crc32c(crc, buf + BTRFS_CSUM_SIZE, len - BTRFS_CSUM_SIZE);
> > -	btrfs_csum_final(crc, result);
> > +	put_unaligned_le32(~crc, result);
> >  	memcpy(buf, result, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32]);
> >  }
> >  
> > 

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
