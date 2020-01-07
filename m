Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8CAB132AC5
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 17:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgAGQLA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 11:11:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:52548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbgAGQLA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jan 2020 11:11:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 51817AF0E;
        Tue,  7 Jan 2020 16:10:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 38347DA78B; Tue,  7 Jan 2020 17:10:47 +0100 (CET)
Date:   Tue, 7 Jan 2020 17:10:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [bug report] btrfs: get rid of trivial __btrfs_lookup_bio_sums()
 wrappers
Message-ID: <20200107161046.GZ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20200107081058.35la6yytkwly2h52@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107081058.35la6yytkwly2h52@kili.mountain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 07, 2020 at 11:10:58AM +0300, Dan Carpenter wrote:
> Hello BTRFS devs,
> 
> This is an old warning but we recently renamed the function so it showed
> up in the new pile again.
> 
> 	fs/btrfs/file-item.c:295 btrfs_lookup_bio_sums()
> 	warn: should this be 'count == -1'
> 
> fs/btrfs/file-item.c
>    151  /**
>    152   * btrfs_lookup_bio_sums - Look up checksums for a bio.
>    153   * @inode: inode that the bio is for.
>    154   * @bio: bio embedded in btrfs_io_bio.
>    155   * @offset: Unless (u64)-1, look up checksums for this offset in the file.
>    156   *          If (u64)-1, use the page offsets from the bio instead.
>    157   * @dst: Buffer of size btrfs_super_csum_size() used to return checksum. If
>    158   *       NULL, the checksum is returned in btrfs_io_bio(bio)->csum instead.
>    159   *
>    160   * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
>    161   */
>    162  blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
>    163                                     u64 offset, u8 *dst)
>    164  {
>    165          struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>    166          struct bio_vec bvec;
>    167          struct bvec_iter iter;
>    168          struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
>    169          struct btrfs_csum_item *item = NULL;
>    170          struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
>    171          struct btrfs_path *path;
>    172          const bool page_offsets = (offset == (u64)-1);
>    173          u8 *csum;
>    174          u64 item_start_offset = 0;
>    175          u64 item_last_offset = 0;
>    176          u64 disk_bytenr;
>    177          u64 page_bytes_left;
>    178          u32 diff;
>    179          int nblocks;
>    180          int count = 0;
>                 ^^^^^^^^^^^^^
> 
>    181          u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
>    182  
>    183          path = btrfs_alloc_path();
>    184          if (!path)
>    185                  return BLK_STS_RESOURCE;
>    186  
>    187          nblocks = bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;
>    188          if (!dst) {
>    189                  if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
>    190                          btrfs_bio->csum = kmalloc_array(nblocks, csum_size,
>    191                                                          GFP_NOFS);
>    192                          if (!btrfs_bio->csum) {
>    193                                  btrfs_free_path(path);
>    194                                  return BLK_STS_RESOURCE;
>    195                          }
>    196                  } else {
>    197                          btrfs_bio->csum = btrfs_bio->csum_inline;
>    198                  }
>    199                  csum = btrfs_bio->csum;
>    200          } else {
>    201                  csum = dst;
>    202          }
>    203  
>    204          if (bio->bi_iter.bi_size > PAGE_SIZE * 8)
>    205                  path->reada = READA_FORWARD;
>    206  
>    207          /*
>    208           * the free space stuff is only read when it hasn't been
>    209           * updated in the current transaction.  So, we can safely
>    210           * read from the commit root and sidestep a nasty deadlock
>    211           * between reading the free space cache and updating the csum tree.
>    212           */
>    213          if (btrfs_is_free_space_inode(BTRFS_I(inode))) {
>    214                  path->search_commit_root = 1;
>    215                  path->skip_locking = 1;
>    216          }
>    217  
>    218          disk_bytenr = (u64)bio->bi_iter.bi_sector << 9;
>    219  
>    220          bio_for_each_segment(bvec, bio, iter) {
>    221                  page_bytes_left = bvec.bv_len;
>    222                  if (count)
>    223                          goto next;
> 
> On the later iterations through the loop then count can be -1.
> 
>    224  
>    225                  if (page_offsets)
>    226                          offset = page_offset(bvec.bv_page) + bvec.bv_offset;
>    227                  count = btrfs_find_ordered_sum(inode, offset, disk_bytenr,
>    228                                                 csum, nblocks);
>    229                  if (count)
>    230                          goto found;
>    231  
>    232                  if (!item || disk_bytenr < item_start_offset ||
>    233                      disk_bytenr >= item_last_offset) {
>    234                          struct btrfs_key found_key;
>    235                          u32 item_size;
>    236  
>    237                          if (item)
>    238                                  btrfs_release_path(path);
>    239                          item = btrfs_lookup_csum(NULL, fs_info->csum_root,
>    240                                                   path, disk_bytenr, 0);
>    241                          if (IS_ERR(item)) {
>    242                                  count = 1;
>    243                                  memset(csum, 0, csum_size);
>    244                                  if (BTRFS_I(inode)->root->root_key.objectid ==
>    245                                      BTRFS_DATA_RELOC_TREE_OBJECTID) {
>    246                                          set_extent_bits(io_tree, offset,
>    247                                                  offset + fs_info->sectorsize - 1,
>    248                                                  EXTENT_NODATASUM);
>    249                                  } else {
>    250                                          btrfs_info_rl(fs_info,
>    251                                                     "no csum found for inode %llu start %llu",
>    252                                                 btrfs_ino(BTRFS_I(inode)), offset);
>    253                                  }
>    254                                  item = NULL;
>    255                                  btrfs_release_path(path);
>    256                                  goto found;
>    257                          }
>    258                          btrfs_item_key_to_cpu(path->nodes[0], &found_key,
>    259                                                path->slots[0]);
>    260  
>    261                          item_start_offset = found_key.offset;
>    262                          item_size = btrfs_item_size_nr(path->nodes[0],
>    263                                                         path->slots[0]);
>    264                          item_last_offset = item_start_offset +
>    265                                  (item_size / csum_size) *
>    266                                  fs_info->sectorsize;
>    267                          item = btrfs_item_ptr(path->nodes[0], path->slots[0],
>    268                                                struct btrfs_csum_item);
>    269                  }
>    270                  /*
>    271                   * this byte range must be able to fit inside
>    272                   * a single leaf so it will also fit inside a u32
>    273                   */
>    274                  diff = disk_bytenr - item_start_offset;
>    275                  diff = diff / fs_info->sectorsize;
>    276                  diff = diff * csum_size;
>    277                  count = min_t(int, nblocks, (item_last_offset - disk_bytenr) >>
>    278                                              inode->i_sb->s_blocksize_bits);
>    279                  read_extent_buffer(path->nodes[0], csum,
>    280                                     ((unsigned long)item) + diff,
>    281                                     csum_size * count);
>    282  found:
>    283                  csum += count * csum_size;
>    284                  nblocks -= count;
>    285  next:
>    286                  while (count--) {
>                                ^^^^^^^
> This loop exits with count set to -1.
> 
>    287                          disk_bytenr += fs_info->sectorsize;
>    288                          offset += fs_info->sectorsize;
>    289                          page_bytes_left -= fs_info->sectorsize;
>    290                          if (!page_bytes_left)
>    291                                  break; /* move to next bio */
>    292                  }
>    293          }
>    294  
>    295          WARN_ON_ONCE(count);
>                              ^^^^^
> Originally this warning was next to the line 291 so it should probably
> be "WARN_ON_ONCE(count >= 0);"  This WARN is two years old now and no
> one has complained about it at run time.  That's very surprising to me
> because I would have expected count to -1 in the common case.

Possible explanation I see is that the "if (!page_bytes_left)" does not
let the count go from 0 -> -1 and exits just in time. I'm runing a test
to see if it's true.

>    296          btrfs_free_path(path);
>    297          return BLK_STS_OK;
>    298  }
> 
> 
> regards,
> dan carpenter
