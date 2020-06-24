Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848B9206EEA
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 10:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390290AbgFXIWp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 04:22:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40948 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390204AbgFXIWp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 04:22:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05O8MWk8096822;
        Wed, 24 Jun 2020 08:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TsYwpbzK55PP80qQZeWdr+eXw54Yo0NMVlCzKkh1bqo=;
 b=LnpdQwAsKNC4oY+o82eNRuPziChhvTSSbUgvQ+1hmaQ8TdcAoTwU+quQfs4xBxx5nYWk
 HlxrNDk0rgoNPCVd0exK+lOJuIYm4rYZmB5Mj7Ef8eahr9L1j6y1hQ1n4X/qUdTqLtTr
 if/PR2mp2MwkrkRiNOLCINOoXP/zsdmD90FUSsCSL3xywt1RdxOCElSqY5S/lIeSalH7
 IJgDT42NH0Y6J49GBxees2+1O29GvWyRpfXmNGtqmK7Fhctk3GeFETqqEaOuywz23XGR
 wSU3fbY5wLDKyptxkjjgI3PAMiXI8SBz5a+9c4ZtUkZx8DUHn4R2H4yPnb/rhZ0WDPgr rQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31uustsfsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 08:22:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05O8JHHR038325;
        Wed, 24 Jun 2020 08:22:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31uurqesqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 08:22:41 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05O8MehE016512;
        Wed, 24 Jun 2020 08:22:40 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jun 2020 08:22:40 +0000
Subject: Re: [PATCH v5 1/3] btrfs: allow btrfs_truncate_block() to fallback to
 nocow for data space reservation
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Martin Doucha <martin.doucha@suse.com>,
        Filipe Manana <fdmanana@suse.com>
References: <20200623232352.668681-1-wqu@suse.com>
 <20200623232352.668681-2-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3a799f24-491a-a495-349a-334c59d7eb2d@oracle.com>
Date:   Wed, 24 Jun 2020 16:22:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623232352.668681-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 cotscore=-2147483648 malwarescore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240061
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good.
Just a nit below.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

> +	if (ret) {
> +		if (!only_release_metadata)
> +			btrfs_delalloc_release_space(inode, data_reserved,
> +					block_start, blocksize, true);
> +		else
> +			btrfs_delalloc_release_metadata(BTRFS_I(inode),
> +					blocksize, true);
> +	}

Nit: (May be it can be fixed during integration so no need to send 
another revision.) here the ! operation inside if can be removed.

if (only_release_metadata)
    btrfs_delalloc_release_metadata()
else
    btrfs_delalloc_release_space()

Thanks, Anand
