Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2C3100462
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 12:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKRLjc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 06:39:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57646 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfKRLjc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 06:39:32 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIBYt4V059821;
        Mon, 18 Nov 2019 11:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Bq5tSmaGQqSW7FgSlw7mGc5Oy2JBJUIMfmoMCWdqEHA=;
 b=KcYM6REvWdLz4cvXkC6MwNb7x+Uyz0Tu6MsbOJE6pSa+3kTN/jFPuL66NuSgybt47T/I
 Ap7zIWHxDXVGY4cw2lqTb+Mcp+tQ/weyiwmU7HVtmVTECZyaddB82jr65pivQz9oWa1S
 ZHrkP5cBY2n8xjJRncm44N6iAseq43gtCfJNpfR29mjdtdt54rez8Ao8IByCNMk7GFwk
 JY3pp7XktNDfN9lkXDHbjDa5K3Kt7vrTDhfMpAi7I/f5FPagJHFV8MMyDpJTRkZgiRkM
 bw0myKgy9lZeMI+BzMePaVUV4ADcJydJCwSDlJGASu+NJ8OPQ1p5Sk8AVLyN5lFi/wWs Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wa8htfmx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 11:38:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIBbs9x012700;
        Mon, 18 Nov 2019 11:38:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2watmrwt54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 11:38:16 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAIBcFs3022338;
        Mon, 18 Nov 2019 11:38:15 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 03:38:14 -0800
Subject: Re: [PATCH] btrfs: resize: Allow user to shrink missing device
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Nathan Dehnel <ncdehnel@gmail.com>
References: <20191118070525.62844-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <18e6af7c-a9b0-9a9d-f91b-ade078c6b2c1@oracle.com>
Date:   Mon, 18 Nov 2019 19:38:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191118070525.62844-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180106
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/11/19 3:05 PM, Qu Wenruo wrote:
> One user reported an use case where one device can't be replaced due to
> tiny device size difference.
> 
> Since it's a RAID10 fs, if we go regular "remove missing" it can take a
> long time and even not be possible due to lack of space.
> 
> So here we work around this situation by allowing user to shrink missing
> device.
> Then user can go shrink the device first, then replace it.


  Why not introduce --resize option in the replace command.
  Which shall allow replace command to resize the source-device
  to the size of the replace target-device.

Thanks, Anand

> Reported-by: Nathan Dehnel <ncdehnel@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/ioctl.c | 29 +++++++++++++++++++++++++----
>   1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index de730e56d3f5..ebd2f40aca6f 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1604,6 +1604,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>   	char *sizestr;
>   	char *retptr;
>   	char *devstr = NULL;
> +	bool missing;
>   	int ret = 0;
>   	int mod = 0;
>   
> @@ -1651,7 +1652,10 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>   		goto out_free;
>   	}
>   
> -	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
> +
> +	missing = test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
> +	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
> +	    !missing) {
>   		btrfs_info(fs_info,
>   			   "resizer unable to apply on readonly device %llu",
>   		       devid);
> @@ -1659,13 +1663,24 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>   		goto out_free;
>   	}
>   
> -	if (!strcmp(sizestr, "max"))
> +	if (!strcmp(sizestr, "max")) {
> +		if (missing) {
> +			btrfs_info(fs_info,
> +				"'max' can't be used for missing device %llu",
> +				   devid);
> +			ret = -EPERM;
> +			goto out_free;
> +		}
>   		new_size = device->bdev->bd_inode->i_size;
> -	else {
> +	} else {
>   		if (sizestr[0] == '-') {
>   			mod = -1;
>   			sizestr++;
>   		} else if (sizestr[0] == '+') {
> +			if (missing)
> +				btrfs_info(fs_info,
> +				"'+size' can't be used for missing device %llu",
> +					   devid);
>   			mod = 1;
>   			sizestr++;
>   		}
> @@ -1694,6 +1709,12 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>   			ret = -ERANGE;
>   			goto out_free;
>   		}
> +		if (missing) {
> +			ret = -EINVAL;
> +			btrfs_info(fs_info,
> +			"can not increase device size for missing device %llu",
> +				   devid);
> +		}
>   		new_size = old_size + new_size;
>   	}
>   
> @@ -1701,7 +1722,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>   		ret = -EINVAL;
>   		goto out_free;
>   	}
> -	if (new_size > device->bdev->bd_inode->i_size) {
> +	if (!missing && new_size > device->bdev->bd_inode->i_size) {
>   		ret = -EFBIG;
>   		goto out_free;
>   	}
> 

