Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B12A2E9138
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 08:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbhADHft (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 02:35:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34632 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbhADHft (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jan 2021 02:35:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1047Z27G098813;
        Mon, 4 Jan 2021 07:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BvcLAFI2UQ1+WPODkbZ1PQe2/FcAx+BMYxv1aqLYGrQ=;
 b=epOiq9rTAw0I+U5lslTTQAlunkpGmzsalt5yUsV5cOCU0Y0ryCl+cGo2XoVy7kwRygua
 OWBnXqvu4b/izHycC7DewIilRn5S8QURbswHJtnZrFAQwBNCiT8zUF17KNUyoGkppX+Z
 mW6bHvTH/yuSgy1FNy1+LqjRlom7Q0RJVlqP4TGWJG6SjDTNq8WJO6FuUKvL3fd0UKIp
 wAAXxCVa8KzR5zmk1vnXQr7tjWeRhXBn6a8HdgB9BKMp5hM3ruB+T1Gdc8naLxeqbsOB
 y2oV/UgcQcjsuQ5h3mfJMa1g5dTGPhyLusOB+8z6fnRb2OEfl0zgldFzouSQ/7Hi/Et2 Lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35tgskk1ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 07:35:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1047Yrts052270;
        Mon, 4 Jan 2021 07:35:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 35uwsysgre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 07:34:58 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1047XAPt018762;
        Mon, 4 Jan 2021 07:33:10 GMT
Received: from [192.168.10.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 07:33:09 +0000
Subject: Re: [PATCH v2 1/2] btrfs: prevent NULL pointer dereference in
 extent_io_tree_panic()
To:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
References: <20210103092804.756-1-l@damenly.su>
 <20210103092804.756-2-l@damenly.su>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <21bc38aa-87be-7ec2-3ef6-06df790ed4b8@oracle.com>
Date:   Mon, 4 Jan 2021 15:33:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210103092804.756-2-l@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040051
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/1/21 5:28 pm, Su Yue wrote:
> Some extent io trees are initialized with NULL private member(e.g., btrfs_devi
> ce::alloc_state and btrfs_fs_info::excluded_extents). Dereference of a NULL
> @tree->private as struct inode * will cause kernel panic.
> 
> Just pass @tree->fs_info as parameter to extent_io_tree_panic() directly.
> Let it panic as expected at least.
> 

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.

> Fixes: 05912a3c04eb ("btrfs: drop extent_io_ops::tree_fs_info callback")
> Signed-off-by: Su Yue <l@damenly.su>
