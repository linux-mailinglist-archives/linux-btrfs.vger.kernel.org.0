Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB149F6E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 01:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfH0X1W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 19:27:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52096 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfH0X1W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 19:27:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7RN4aDB144031;
        Tue, 27 Aug 2019 23:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=89LZK8OtRCNCvQbpZxQQ+opjM8fsCv1EJweCEXFGBgk=;
 b=sfgOsiIZZIHTe0A2/2gk+MBLJm758lG/m9tKcUhnsHZqDG/nxo3lGxzD1v6DzuJ9OhTl
 0daYiQVX0OwJMdb3JO4mw3mfX9Ap21q2QnuVZjsPBq/2RbwR7b6fR6n5C2oHZXq5QmZ9
 IdbYDtSBVVR6VIVJFF4qZspDPjKI+Nw0ClbnaY6qDXTNtdaa5H/z5eXekuhyigROq21G
 K91hSlG/NK/+j6izqFIfjiU40fLQXCjVlluouWNhbgtza4o2Qj9GrrfRDz3nbqUUfseU
 CM6iKAST45I7d1TfFlWPJCJ4Rc5yzuI0Xx7KCtmGgRDNPXYiboQS+moHG+YBJgQw9aYq Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2undqrr3j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 23:26:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7RN3D7Y027141;
        Tue, 27 Aug 2019 23:26:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2un6q1qn4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 23:26:55 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7RNQsqC026546;
        Tue, 27 Aug 2019 23:26:55 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Aug 2019 16:26:54 -0700
Subject: Re: [PATCH v2] btrfs: tree-checker: Fix wrong check on max devid
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190827140511.7081-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1c281539-89b6-e4c6-9c12-bb0b7bb9708d@oracle.com>
Date:   Wed, 28 Aug 2019 07:26:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190827140511.7081-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270219
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270219
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/8/19 10:05 PM, Qu Wenruo wrote:
> Btrfs doesn't reuse devid, thus if we add and delete device in a loop,
> we can increase devid to higher value, triggering tree checker to give a
> false alert.
> 
> Furthermore, we have dev extent verification already (after
> tree-checker, at mount time).
> So even if user had bitflip on some dev items, we can still detect it
> and refuse to mount.
> 
> Reported-by: Anand Jain <anand.jain@oracle.com>
> Fixes: ab4ba2e13346 ("btrfs: tree-checker: Verify dev item")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove devid check completely
>    As we already have verify_one_dev_extent().
> ---
>   fs/btrfs/tree-checker.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 43e488f5d063..076d5b8014fb 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -686,9 +686,7 @@ static void dev_item_err(const struct extent_buffer *eb, int slot,
>   static int check_dev_item(struct extent_buffer *leaf,
>   			  struct btrfs_key *key, int slot)
>   {
> -	struct btrfs_fs_info *fs_info = leaf->fs_info;
>   	struct btrfs_dev_item *ditem;
> -	u64 max_devid = max(BTRFS_MAX_DEVS(fs_info), BTRFS_MAX_DEVS_SYS_CHUNK);
>   
>   	if (key->objectid != BTRFS_DEV_ITEMS_OBJECTID) {
>   		dev_item_err(leaf, slot,
> @@ -696,12 +694,6 @@ static int check_dev_item(struct extent_buffer *leaf,
>   			     key->objectid, BTRFS_DEV_ITEMS_OBJECTID);
>   		return -EUCLEAN;
>   	}
> -	if (key->offset > max_devid) {
> -		dev_item_err(leaf, slot,
> -			     "invalid devid: has=%llu expect=[0, %llu]",
> -			     key->offset, max_devid);
> -		return -EUCLEAN;
> -	}
>   	ditem = btrfs_item_ptr(leaf, slot, struct btrfs_dev_item);
>   	if (btrfs_device_id(leaf, ditem) != key->offset) {
>   		dev_item_err(leaf, slot,
> 

   Though ab4ba2e13346 didn't add BTRFS_MAX_DEVS_SYS_CHUNK,
   BTRFS_MAX_DEVS_SYS_CHUNK is unused now, can be deleted.

   The reproducer script and logs should rather be in this change log.

Thanks, Anand
