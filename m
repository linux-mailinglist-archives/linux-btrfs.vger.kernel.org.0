Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341CA20554B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbgFWO6o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 10:58:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32922 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbgFWO6o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 10:58:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05NEvkiX106438;
        Tue, 23 Jun 2020 14:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=d0JMp+/e1uW0pgFfx/S58SZINuWbKqXIHj5Kd9+wqRI=;
 b=gaq+f5csykf7lC9Nyhi1B1xplxHt1/ppaOlyPkBDiqG/GioeoRyncaVmYJeD+iyYgepS
 55V62vkz6x4EW6YHOIgiMFH0L2upgGRIoJdwqm25mOMIAgGOnMoo/8z2oDGuoVpIas9T
 VqRmmV0OFH6sC3R+sYYs/rKAZlUmeDXYchsiytnEsL8rmTQ15S6HUOtvG1vOxMk5zB9j
 eApyJZTvV3+n930auaYlstDsjHsMk8+SZiYlmpDjOgOxY34eXuI1vYYFlEO6BPgA8Hz/
 cOxrPxWQPejCjWbhWibKQbXKESDIs6trkCoRVXkOmfbgIT+a3qIcsJdf8CpUi1ezfStk 4g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31uk3c0bty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Jun 2020 14:58:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05NEm33e125658;
        Tue, 23 Jun 2020 14:56:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31uk3gmjrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 14:56:39 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05NEucwT023298;
        Tue, 23 Jun 2020 14:56:38 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jun 2020 14:56:38 +0000
Subject: Re: [PATCH v4 3/3] btrfs: refactor btrfs_check_can_nocow() into two
 variants
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200623052112.198682-1-wqu@suse.com>
 <20200623052112.198682-4-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ed6eedb1-26e9-c209-900f-069322a02503@oracle.com>
Date:   Tue, 23 Jun 2020 22:56:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623052112.198682-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006120000
 definitions=main-2006230116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006120000
 definitions=main-2006230117
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




> +static int check_nocow_nolock(struct btrfs_inode *inode, loff_t pos,
> +			      size_t *write_bytes)
> +{
> +	return check_can_nocow(inode, pos, write_bytes, false);
> +}


> +int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
> +			   size_t *write_bytes)
> +{
> +	return check_can_nocow(inode, pos, write_bytes, false);
> +}


  Both functions are same.  Something obviously not ok.

Thanks, Anand
