Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83ADE154056
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 09:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgBFIel (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 03:34:41 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33184 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgBFIel (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 03:34:41 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0168X6EC000989;
        Thu, 6 Feb 2020 08:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=AYpCFnseN9sNCWFwQLB224LvTO8wEnv1R8uFOOU1UZo=;
 b=rGYNE7fNeXaEWf/X/qEBuAKIvXIiwR+jKYGfF4C7PyvX1MiiW1Dy2j14zs4KkhPvhBXj
 MSciWv7yCOMQOTTcLrYyYgCRHlwyqUMyxg9cloBbFyjPlLssyObszYC6KkAXb4zcRd11
 K0S7XD77We0XQMxPW/81nw2tGGXYb4fe7risPWMZjB9jNI2wsvOMTuCpgrCV9H64Fesl
 zHyXz0pnJ/AjCLi8iE5EQXFFTu5LH/87bqAtlTJRk2rzELRHiv3BWfOzpsisaat/NR41
 p6gj8QGaL8RYyAqgEN8xUZ4RdvYsLU6KmeQAILkep7XFhX+W4WzzEDgDAjZxx3mWhtdN 7w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=AYpCFnseN9sNCWFwQLB224LvTO8wEnv1R8uFOOU1UZo=;
 b=k9+3/Qy9E9ttNGQKuHoWyhdy4py+VPImlx6hkCFYYMvJMOtQJfD82WtwCBnpR3pLRGrh
 W8vJyl+0d/T4RZD+/9vv7BK143vlLhN4FkBitVFbGBJWznBYZZzz8jEcsI8wI6EjfVUE
 FLZ8MFzRk1o1sAgjPZg7txjeOKoyfrEtkdi86NjawTLAYpib/PiLnEFb5fbz+5LoUN4F
 BaH5FYmlmTkU5GUAMmgbfWfirIpiCdV/zZRETeLVk4CskFTlgNVJysvhb1iCtAtyXdz/
 Y+nQpwuxjKByBpsAyPxT5do8dk2bkfNOW0pj8/fCcKpyT01hKJXTS4CGXu3eREkUUW1m 4w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xykbp84c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 08:34:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0168YEUg133690;
        Thu, 6 Feb 2020 08:34:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xykc5398p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 08:34:34 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0168YTnl003966;
        Thu, 6 Feb 2020 08:34:29 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Feb 2020 00:34:29 -0800
Subject: Re: [PATCH 1/8] btrfs: remove extent_page_data::tree
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1580925977.git.dsterba@suse.com>
 <9bca78d5ecd1eec04ebaa6fa760af3817f9345ab.1580925977.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <fa258ad7-016d-0fbd-7076-9a20d8adc94d@oracle.com>
Date:   Thu, 6 Feb 2020 16:34:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9bca78d5ecd1eec04ebaa6fa760af3817f9345ab.1580925977.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060068
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 2:09 AM, David Sterba wrote:
> All functions that set up extent_page_data::tree set it to the inode
> io_tree. That's passed down the callstack that accesses either the same
> inode or its pages. In the end submit_extent_page can pull the tree out
> of the page and we don't have to store it in the structure.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
