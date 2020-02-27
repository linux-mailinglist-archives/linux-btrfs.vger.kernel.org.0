Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB21720AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 15:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbgB0Nrt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 08:47:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48204 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbgB0Nrr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 08:47:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RDlRE3062320;
        Thu, 27 Feb 2020 13:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=teS6Z5Oud/+W2CBueZZY1jU6KCTi1bQcHHbbMPEHI4E=;
 b=TaEQDyeCtTDHbY/99s/ofreJY+cmvcAuSXvCLUNLPdX2iDylC5ijb/28WbRhPDDHRX1a
 Pw8SpC4OxEjnsHr8Aezmr2DR9m8iXdUzhXYb7LztcTA63I8zOidTzWeFp/l05GYwIlqs
 LNIRuXUN3FFEu3HZZTaUaB3sw9IpDCxcxTCMQQ7GbFdicK8lgQv69y2k9lk/lFLHfQvj
 71XfcsPF/zEclWaBny0Yu0qs46MBnvQLi2LU9/4MpeI7z/DsJ4yy1vIe4xv9Hn8HqK/e
 0LOH+hk2D1pw3jx6qQD7scGjM1omxXlS/EWGb8sdqw9ppnaPuPO6Vj+Ugqo4WwzT12bk wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ydcsnk1cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 13:47:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RDkhm4030679;
        Thu, 27 Feb 2020 13:47:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2ydcsce686-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 13:47:44 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01RDlhsE015824;
        Thu, 27 Feb 2020 13:47:43 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 05:47:42 -0800
Date:   Thu, 27 Feb 2020 16:47:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     josef@toxicpanda.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: hold a ref on the root in
 btrfs_search_path_in_tree_user
Message-ID: <20200227134737.bq6cz7bo6jjciswe@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=751 mlxscore=0 suspectscore=3 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=806 phishscore=0 spamscore=0 adultscore=0
 suspectscore=3 impostorscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270109
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[ It's weird that I haven't reported before...  - dan ]

Hello Josef Bacik,

The patch d8359e551d00: "btrfs: hold a ref on the root in
btrfs_search_path_in_tree_user" from Jan 24, 2020, leads to the
following static checker warning:

	fs/btrfs/ioctl.c:2534 btrfs_search_path_in_tree_user()
	error: uninitialized symbol 'root'.

fs/btrfs/ioctl.c
  2374  static int btrfs_search_path_in_tree_user(struct inode *inode,
  2375                                  struct btrfs_ioctl_ino_lookup_user_args *args)
  2376  {
  2377          struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
  2378          struct super_block *sb = inode->i_sb;
  2379          struct btrfs_key upper_limit = BTRFS_I(inode)->location;
  2380          u64 treeid = BTRFS_I(inode)->root->root_key.objectid;
  2381          u64 dirid = args->dirid;
  2382          unsigned long item_off;
  2383          unsigned long item_len;
  2384          struct btrfs_inode_ref *iref;
  2385          struct btrfs_root_ref *rref;
  2386          struct btrfs_root *root;
                                   ^^^^

  2387          struct btrfs_path *path;
  2388          struct btrfs_key key, key2;
  2389          struct extent_buffer *leaf;
  2390          struct inode *temp_inode;
  2391          char *ptr;
  2392          int slot;
  2393          int len;
  2394          int total_len = 0;
  2395          int ret;
  2396  
  2397          path = btrfs_alloc_path();
  2398          if (!path)
  2399                  return -ENOMEM;
  2400  
  2401          /*
  2402           * If the bottom subvolume does not exist directly under upper_limit,
  2403           * construct the path in from the bottom up.
  2404           */
  2405          if (dirid != upper_limit.objectid) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
root isn't initialized on the else path.

  2406                  ptr = &args->path[BTRFS_INO_LOOKUP_USER_PATH_MAX - 1];
  2407  
  2408                  key.objectid = treeid;
  2409                  key.type = BTRFS_ROOT_ITEM_KEY;
  2410                  key.offset = (u64)-1;
  2411                  root = btrfs_get_fs_root(fs_info, &key, true);
  2412                  if (IS_ERR(root)) {
  2413                          ret = PTR_ERR(root);
  2414                          goto out;
  2415                  }
  2416  
  2417                  key.objectid = dirid;
  2418                  key.type = BTRFS_INODE_REF_KEY;
  2419                  key.offset = (u64)-1;
  2420                  while (1) {
  2421                          ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
  2422                          if (ret < 0) {
  2423                                  goto out_put;
  2424                          } else if (ret > 0) {
  2425                                  ret = btrfs_previous_item(root, path, dirid,
  2426                                                            BTRFS_INODE_REF_KEY);
  2427                                  if (ret < 0) {
  2428                                          goto out_put;
  2429                                  } else if (ret > 0) {
  2430                                          ret = -ENOENT;
  2431                                          goto out_put;
  2432                                  }
  2433                          }
  2434  
  2435                          leaf = path->nodes[0];
  2436                          slot = path->slots[0];
  2437                          btrfs_item_key_to_cpu(leaf, &key, slot);
  2438  
  2439                          iref = btrfs_item_ptr(leaf, slot, struct btrfs_inode_ref);
  2440                          len = btrfs_inode_ref_name_len(leaf, iref);
  2441                          ptr -= len + 1;
  2442                          total_len += len + 1;
  2443                          if (ptr < args->path) {
  2444                                  ret = -ENAMETOOLONG;
  2445                                  goto out_put;
  2446                          }
  2447  
  2448                          *(ptr + len) = '/';
  2449                          read_extent_buffer(leaf, ptr,
  2450                                          (unsigned long)(iref + 1), len);
  2451  
  2452                          /* Check the read+exec permission of this directory */
  2453                          ret = btrfs_previous_item(root, path, dirid,
  2454                                                    BTRFS_INODE_ITEM_KEY);
  2455                          if (ret < 0) {
  2456                                  goto out_put;
  2457                          } else if (ret > 0) {
  2458                                  ret = -ENOENT;
  2459                                  goto out_put;
  2460                          }
  2461  
  2462                          leaf = path->nodes[0];
  2463                          slot = path->slots[0];
  2464                          btrfs_item_key_to_cpu(leaf, &key2, slot);
  2465                          if (key2.objectid != dirid) {
  2466                                  ret = -ENOENT;
  2467                                  goto out_put;
  2468                          }
  2469  
  2470                          temp_inode = btrfs_iget(sb, &key2, root);
  2471                          if (IS_ERR(temp_inode)) {
  2472                                  ret = PTR_ERR(temp_inode);
  2473                                  goto out_put;
  2474                          }
  2475                          ret = inode_permission(temp_inode, MAY_READ | MAY_EXEC);
  2476                          iput(temp_inode);
  2477                          if (ret) {
  2478                                  ret = -EACCES;
  2479                                  goto out_put;
  2480                          }
  2481  
  2482                          if (key.offset == upper_limit.objectid)
  2483                                  break;
  2484                          if (key.objectid == BTRFS_FIRST_FREE_OBJECTID) {
  2485                                  ret = -EACCES;
  2486                                  goto out_put;
  2487                          }
  2488  
  2489                          btrfs_release_path(path);
  2490                          key.objectid = key.offset;
  2491                          key.offset = (u64)-1;
  2492                          dirid = key.objectid;
  2493                  }
  2494  
  2495                  memmove(args->path, ptr, total_len);
  2496                  args->path[total_len] = '\0';
  2497                  btrfs_put_root(root);
  2498                  root = NULL;
  2499                  btrfs_release_path(path);
  2500          }
  2501  
  2502          /* Get the bottom subvolume's name from ROOT_REF */
  2503          key.objectid = treeid;
  2504          key.type = BTRFS_ROOT_REF_KEY;
  2505          key.offset = args->treeid;
  2506          ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
  2507          if (ret < 0) {
  2508                  goto out;
  2509          } else if (ret > 0) {
  2510                  ret = -ENOENT;
  2511                  goto out;
  2512          }
  2513  
  2514          leaf = path->nodes[0];
  2515          slot = path->slots[0];
  2516          btrfs_item_key_to_cpu(leaf, &key, slot);
  2517  
  2518          item_off = btrfs_item_ptr_offset(leaf, slot);
  2519          item_len = btrfs_item_size_nr(leaf, slot);
  2520          /* Check if dirid in ROOT_REF corresponds to passed dirid */
  2521          rref = btrfs_item_ptr(leaf, slot, struct btrfs_root_ref);
  2522          if (args->dirid != btrfs_root_ref_dirid(leaf, rref)) {
  2523                  ret = -EINVAL;
  2524                  goto out;
  2525          }
  2526  
  2527          /* Copy subvolume's name */
  2528          item_off += sizeof(struct btrfs_root_ref);
  2529          item_len -= sizeof(struct btrfs_root_ref);
  2530          read_extent_buffer(leaf, args->name, item_off, item_len);
  2531          args->name[item_len] = 0;

root isn't initialized on the success path.

  2532  
  2533  out_put:
  2534          btrfs_put_root(root);
  2535  out:
  2536          btrfs_free_path(path);
  2537          return ret;
  2538  }

regards,
dan carpenter
