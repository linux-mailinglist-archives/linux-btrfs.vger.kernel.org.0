Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC046682C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2019 06:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfGOEJP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 00:09:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39408 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfGOEJP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 00:09:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6F48tea132857;
        Mon, 15 Jul 2019 04:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=6fvrHdQT17o2rujuT7QWprL32ZCQt5mGRle9dWJ7tBU=;
 b=Agv9UUSwpmShzG+K6VEe57OM/A1Jo8FS/M7jZ39Kt5LMBrTkQLyfO5HhIQdo90UYHmXY
 gVn64XsBneTMIJ1zbrFWbVr9cm5Xp/qW2rtvV1j2SFXVMLMferWq6cb/nxqqjT0lcPDU
 hhwv3iZHZX47656+26B8zXh/yFq5Qh7L6dHaslI0OLeHVuVYBTszYGAG4LLfJy3myVR2
 dU+D1XRolHay3J0fUoqh4jlDtnbK4C9Ge84zBkAMfvWxJ8TSUnql43Ec8EdT4uLbI41g
 ckkqMDzAy7bTDsRuvUvOmfvB1vdbDcVhjlvfuE0HADNOp8APvlteFxyQ5+Wt7evhk/aW ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tq78pc277-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 04:09:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6F47t1A047083;
        Mon, 15 Jul 2019 04:09:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tq6mm2hdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 04:09:10 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6F4988K020091;
        Mon, 15 Jul 2019 04:09:09 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Jul 2019 21:09:08 -0700
Subject: Re: [PATCH v2.1 08/10] btrfs-progs: image: Introduce -d option to
 dump data
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190704061103.20096-1-wqu@suse.com>
 <20190704061103.20096-9-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <0909bbd0-5e22-8826-e067-8d38cffa91c7@oracle.com>
Date:   Mon, 15 Jul 2019 12:09:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190704061103.20096-9-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9318 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150048
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9318 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150048
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4/7/19 2:11 PM, Qu Wenruo wrote:
>   static int copy_from_extent_tree(struct metadump_struct *metadump,
> -				 struct btrfs_path *path)
> +				 struct btrfs_path *path, bool dump_data)
>   {
>   	struct btrfs_root *extent_root;
>   	struct extent_buffer *leaf;
> @@ -948,9 +960,15 @@ static int copy_from_extent_tree(struct metadump_struct *metadump,
>   			ei = btrfs_item_ptr(leaf, path->slots[0],
>   					    struct btrfs_extent_item);
>   			if (btrfs_extent_flags(leaf, ei) &
> -			    BTRFS_EXTENT_FLAG_TREE_BLOCK) {
> +			    BTRFS_EXTENT_FLAG_TREE_BLOCK ||
> +			    btrfs_extent_flags(leaf, ei) &
> +			    BTRFS_EXTENT_FLAG_DATA) {
> +				bool is_data;
> +
> +				is_data = btrfs_extent_flags(leaf, ei) &
> +					  BTRFS_EXTENT_FLAG_DATA;
>   				ret = add_extent(bytenr, num_bytes, metadump,
> -						 0);
> +						 is_data);


   Both with and without -d option copies the data.
   Should check dump_data.

Thanks, Anand
