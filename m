Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB37EACC
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 05:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfHBDui (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 23:50:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50592 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbfHBDuh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Aug 2019 23:50:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x723n4kD053195;
        Fri, 2 Aug 2019 03:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Mo02I5vcHFfKx7F3TPwL0uRVsVOv/Yq5wOPxe4YbbbI=;
 b=irp4ARybwg2SWL1RIWid0tHLNzMIiPCj16RUTHNHk1WBQM97C/cTIknouxcuIIDaNnrv
 CmB/pgSLIE5oxMzhgBsjz9fvFoMUQ1AhukJ+bAwdNvqETHwgXQL5MOxwrg65LUaIFPJ6
 uEtZXgB44Y5ibBpkoiJA/ElkJetdfTDP5Hu59r68Kdn0VPOVu6O3wvyG+AEdgzP+iOtL
 fpJ7Gtoh/fITmIIyblR0TBZoiOOLHLLlmkGsfORrwejVZxhqkhroHxRjpH63iM+JDFXB
 xSCiNvfHPIQat4HDXW0NPlYlv7axwlMdU3J01IWVi0JC1U6IXdTYWdyhyPjA1t1lQxVW pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u0ejpydk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 03:50:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x723lrNn145710;
        Fri, 2 Aug 2019 03:50:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2u3mbv1jhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 03:50:32 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x723oUMi012475;
        Fri, 2 Aug 2019 03:50:31 GMT
Received: from [192.168.1.147] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Aug 2019 20:50:30 -0700
Subject: Re: [PATCH 3/3] btrfs: tree-log: use symbolic name for first replay
 stage
To:     David Sterba <dsterba@suse.com>
References: <cover.1564663765.git.dsterba@suse.com>
 <5e7f207680bb5e16c0ef4f8499b060bff308a8f5.1564663765.git.dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <053e458d-fffb-e483-0880-62a49ccda990@oracle.com>
Date:   Fri, 2 Aug 2019 11:50:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5e7f207680bb5e16c0ef4f8499b060bff308a8f5.1564663765.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908020038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908020038
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


For whole series.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

One nit below.

On 8/1/19 8:50 PM, David Sterba wrote:
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/tree-log.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 5513e76cc336..f48c8b9b513b 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6237,7 +6237,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
>   	struct btrfs_fs_info *fs_info = log_root_tree->fs_info;
>   	struct walk_control wc = {
>   		.process_func = process_one_buffer,
> -		.stage = 0,
> +		.stage = LOG_WALK_PIN_ONLY,

  Why this isn't enum?


>   	};
>   
>   	path = btrfs_alloc_path();
> 

