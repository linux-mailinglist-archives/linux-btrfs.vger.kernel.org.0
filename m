Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9AF25BE6C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 11:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgICJ1U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 05:27:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54204 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgICJ1S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 05:27:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839PBWU052907;
        Thu, 3 Sep 2020 09:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Z2Un8N43SKHvYIgmK3RvzyzieZ3nv528qzI0eh0yZmk=;
 b=QfQGYcOC7T/Z2IyPDMvVkfV34rRJjJTI9ZqQcCuwgaok4nxREbnns5mxwxiV/UZU5hjQ
 Thy/pok6Hx7ol6vNehDwSGhO7P/QYngNMr3x7FzWXYJuJ4BdxhBPUqJhR+9tEHPiLO7d
 y0QumcWSeHPTBuRxLIVIydBNLD0zzVj6KQUCR1n8IVnihf9D3vkvQNjflSICPdDmeocY
 a1lyHyUtsuMvlFLSa6hOlrtooGiJ6HRxxNtokGM/i0AJLPYEL/3Pxn4U7/S7J18hG5iI
 aF9tyOD/azTYoOB652g7Rq/YO7eJRuhpOUas7aJ+rWZW0b+dy1CrtyoqaBB2weQldhgO eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 337eer7pxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Sep 2020 09:27:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839Oval186070;
        Thu, 3 Sep 2020 09:27:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3380x9db3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Sep 2020 09:27:11 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0839RAkX004117;
        Thu, 3 Sep 2020 09:27:10 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Sep 2020 02:27:10 -0700
Date:   Thu, 3 Sep 2020 12:27:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     nborisov@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: remove err variable from btrfs_get_extent
Message-ID: <20200903092705.GA392335@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=769 adultscore=0 suspectscore=10 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=771 bulkscore=0 suspectscore=10
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Nikolay Borisov,

The patch 85b1eebdaf1d: "btrfs: remove err variable from
btrfs_get_extent" from Aug 3, 2020, leads to the following static
checker warning:

	fs/btrfs/inode.c:6737 btrfs_get_extent()
	error: passing non negative 1 to ERR_PTR

fs/btrfs/inode.c
  6531  struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
  6532                                      struct page *page, size_t pg_offset,
  6533                                      u64 start, u64 len)
  6534  {
  6535          struct btrfs_fs_info *fs_info = inode->root->fs_info;
  6536          int ret = 0;
  6537          u64 extent_start = 0;
  6538          u64 extent_end = 0;
  6539          u64 objectid = btrfs_ino(inode);
  6540          int extent_type = -1;
  6541          struct btrfs_path *path = NULL;
  6542          struct btrfs_root *root = inode->root;
  6543          struct btrfs_file_extent_item *item;
  6544          struct extent_buffer *leaf;
  6545          struct btrfs_key found_key;
  6546          struct extent_map *em = NULL;
  6547          struct extent_map_tree *em_tree = &inode->extent_tree;
  6548          struct extent_io_tree *io_tree = &inode->io_tree;
  6549  
  6550          read_lock(&em_tree->lock);
  6551          em = lookup_extent_mapping(em_tree, start, len);
  6552          read_unlock(&em_tree->lock);
  6553  
  6554          if (em) {
  6555                  if (em->start > start || em->start + em->len <= start)
  6556                          free_extent_map(em);
  6557                  else if (em->block_start == EXTENT_MAP_INLINE && page)
  6558                          free_extent_map(em);
  6559                  else
  6560                          goto out;
  6561          }
  6562          em = alloc_extent_map();
  6563          if (!em) {
  6564                  ret = -ENOMEM;
  6565                  goto out;
  6566          }
  6567          em->start = EXTENT_MAP_HOLE;
  6568          em->orig_start = EXTENT_MAP_HOLE;
  6569          em->len = (u64)-1;
  6570          em->block_len = (u64)-1;
  6571  
  6572          path = btrfs_alloc_path();
  6573          if (!path) {
  6574                  ret = -ENOMEM;
  6575                  goto out;
  6576          }
  6577  
  6578          /* Chances are we'll be called again, so go ahead and do readahead */
  6579          path->reada = READA_FORWARD;
  6580  
  6581          /*
  6582           * Unless we're going to uncompress the inline extent, no sleep would
  6583           * happen.
  6584           */
  6585          path->leave_spinning = 1;
  6586  
  6587          ret = btrfs_lookup_file_extent(NULL, root, path, objectid, start, 0);
  6588          if (ret < 0) {
  6589                  goto out;
  6590          } else if (ret > 0) {
                           ^^^^^^^
"ret" is 1.

  6591                  if (path->slots[0] == 0)
  6592                          goto not_found;
  6593                  path->slots[0]--;
  6594          }
  6595  
  6596          leaf = path->nodes[0];
  6597          item = btrfs_item_ptr(leaf, path->slots[0],
  6598                                struct btrfs_file_extent_item);
  6599          btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
  6600          if (found_key.objectid != objectid ||
  6601              found_key.type != BTRFS_EXTENT_DATA_KEY) {
  6602                  /*
  6603                   * If we backup past the first extent we want to move forward
  6604                   * and see if there is an extent in front of us, otherwise we'll
  6605                   * say there is a hole for our whole search range which can
  6606                   * cause problems.
  6607                   */
  6608                  extent_end = start;
  6609                  goto next;
  6610          }
  6611  
  6612          extent_type = btrfs_file_extent_type(leaf, item);
  6613          extent_start = found_key.offset;
  6614          extent_end = btrfs_file_extent_end(path);
  6615          if (extent_type == BTRFS_FILE_EXTENT_REG ||
  6616              extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
  6617                  /* Only regular file could have regular/prealloc extent */
  6618                  if (!S_ISREG(inode->vfs_inode.i_mode)) {
  6619                          ret = -EUCLEAN;
  6620                          btrfs_crit(fs_info,
  6621                  "regular/prealloc extent found for non-regular inode %llu",
  6622                                     btrfs_ino(inode));
  6623                          goto out;
  6624                  }
  6625                  trace_btrfs_get_extent_show_fi_regular(inode, leaf, item,
  6626                                                         extent_start);
  6627          } else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
  6628                  trace_btrfs_get_extent_show_fi_inline(inode, leaf, item,
  6629                                                        path->slots[0],
  6630                                                        extent_start);
  6631          }
  6632  next:
  6633          if (start >= extent_end) {
  6634                  path->slots[0]++;
  6635                  if (path->slots[0] >= btrfs_header_nritems(leaf)) {
  6636                          ret = btrfs_next_leaf(root, path);
  6637                          if (ret < 0)
  6638                                  goto out;
  6639                          else if (ret > 0)
  6640                                  goto not_found;
  6641  
  6642                          leaf = path->nodes[0];
  6643                  }
  6644                  btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
  6645                  if (found_key.objectid != objectid ||
  6646                      found_key.type != BTRFS_EXTENT_DATA_KEY)
  6647                          goto not_found;
  6648                  if (start + len <= found_key.offset)
  6649                          goto not_found;
  6650                  if (start > found_key.offset)
  6651                          goto next;
  6652  
  6653                  /* New extent overlaps with existing one */
  6654                  em->start = start;
  6655                  em->orig_start = start;
  6656                  em->len = found_key.offset - start;
  6657                  em->block_start = EXTENT_MAP_HOLE;
  6658                  goto insert;
  6659          }
  6660  
  6661          btrfs_extent_item_to_extent_map(inode, path, item, !page, em);
  6662  
  6663          if (extent_type == BTRFS_FILE_EXTENT_REG ||
  6664              extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
  6665                  goto insert;
  6666          } else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
  6667                  unsigned long ptr;
  6668                  char *map;
  6669                  size_t size;
  6670                  size_t extent_offset;
  6671                  size_t copy_size;
  6672  
  6673                  if (!page)
  6674                          goto out;
                                ^^^^^^^^
Assume we reach here.

  6675  
  6676                  size = btrfs_file_extent_ram_bytes(leaf, item);
  6677                  extent_offset = page_offset(page) + pg_offset - extent_start;
  6678                  copy_size = min_t(u64, PAGE_SIZE - pg_offset,
  6679                                    size - extent_offset);
  6680                  em->start = extent_start + extent_offset;
  6681                  em->len = ALIGN(copy_size, fs_info->sectorsize);
  6682                  em->orig_block_len = em->len;
  6683                  em->orig_start = em->start;
  6684                  ptr = btrfs_file_extent_inline_start(item) + extent_offset;
  6685  
  6686                  btrfs_set_path_blocking(path);
  6687                  if (!PageUptodate(page)) {
  6688                          if (btrfs_file_extent_compression(leaf, item) !=
  6689                              BTRFS_COMPRESS_NONE) {
  6690                                  ret = uncompress_inline(path, page, pg_offset,
  6691                                                          extent_offset, item);
  6692                                  if (ret)
  6693                                          goto out;
  6693                                          goto out;
  6694                          } else {
  6695                                  map = kmap(page);
  6696                                  read_extent_buffer(leaf, map + pg_offset, ptr,
  6697                                                     copy_size);
  6698                                  if (pg_offset + copy_size < PAGE_SIZE) {
  6699                                          memset(map + pg_offset + copy_size, 0,
  6700                                                 PAGE_SIZE - pg_offset -
  6701                                                 copy_size);
  6702                                  }
  6703                                  kunmap(page);
  6704                          }
  6705                          flush_dcache_page(page);
  6706                  }
  6707                  set_extent_uptodate(io_tree, em->start,
  6708                                      extent_map_end(em) - 1, NULL, GFP_NOFS);
  6709                  goto insert;
  6710          }
  6711  not_found:
  6712          em->start = start;
  6713          em->orig_start = start;
  6714          em->len = len;
  6715          em->block_start = EXTENT_MAP_HOLE;
  6716  insert:
  6717          ret = 0;
  6718          btrfs_release_path(path);
  6719          if (em->start > start || extent_map_end(em) <= start) {
  6720                  btrfs_err(fs_info,
  6721                            "bad extent! em: [%llu %llu] passed [%llu %llu]",
  6722                            em->start, em->len, start, len);
  6723                  ret = -EIO;
  6724                  goto out;
  6725          }
  6726  
  6727          write_lock(&em_tree->lock);
  6728          ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
  6729          write_unlock(&em_tree->lock);
  6730  out:
  6731          btrfs_free_path(path);
  6732  
  6733          trace_btrfs_get_extent(root, inode, em);
  6734  
  6735          if (ret) {
  6736                  free_extent_map(em);
  6737                  return ERR_PTR(ret);
                                       ^^^
BOOM!  The caller will Oops.

  6738          }
  6739          return em;
  6740  }

regards,
dan carpenter
