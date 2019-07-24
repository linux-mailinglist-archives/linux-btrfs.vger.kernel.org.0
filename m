Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928DB72521
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 05:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfGXDLR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 23:11:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40230 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfGXDLR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 23:11:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O38xaO163168;
        Wed, 24 Jul 2019 03:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Bv1dvLrq6YfCYMMwIYL0uRmn7eEvGX/GMQBCzCxF1VE=;
 b=cCd6xT3ITiJPYW+lteqF94JGhu9TzE6K2lrk7+JxesBKNMf5Pv+BhLUezcJVYQQIsI4h
 2xiweBtxUM3r1kiQa8F4pNNg/LWrE0sT+52p04ilg1GT2x0kd/7aI/Rn+D8Y3IeFzvdB
 yR95oWibPTI0FedzPrly0dNz77IFvuVnOfIp6CCO023342Q1sfkhP7ExnLcSJQu5lbJp
 jle+iGYuReDKBBPJiLt1NewgRpdsj3MhfSnQ5BeCC16WbCo+KIJN6LU6XgwHCI7g6xaV
 0WEyKplaIg5Cs2bsLooUWaYvPWtVETJIhJMTqCV27zkjYqsw/oc51ZP3r0GBfrmV1dnf iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tx61btcyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 03:11:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O38KxP022481;
        Wed, 24 Jul 2019 03:11:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tx60xdwj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 03:11:12 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6O3BBIa024853;
        Wed, 24 Jul 2019 03:11:12 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jul 2019 20:11:11 -0700
Subject: Re: [PATCH 2/2 RESEND Rebased] btrfs-progs: add readmirror policy
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20190626083402.1895-1-anand.jain@oracle.com>
 <20190626083723.2094-1-anand.jain@oracle.com>
 <20190626083723.2094-2-anand.jain@oracle.com>
 <20190723135330.GC2868@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <dacef0f4-f452-4ad8-9c9b-a0395b8c15dc@oracle.com>
Date:   Wed, 24 Jul 2019 11:11:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190723135330.GC2868@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240035
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/7/19 9:53 PM, David Sterba wrote:
> On Wed, Jun 26, 2019 at 04:37:23PM +0800, Anand Jain wrote:
>> This sets the readmirror=<parm> as a btrfs.<attr> extentded attribute.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   props.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/props.c b/props.c
>> index 3a498bd9e904..1d1a2c7f9d14 100644
>> --- a/props.c
>> +++ b/props.c
>> @@ -178,6 +178,53 @@ out:
>>   	return ret;
>>   }
>>   
>> +static int prop_readmirror(enum prop_object_type type, const char *object,
>> +			   const char *name, const char *value)
>> +{
>> +	int fd;
>> +	int ret;
>> +	char buf[256] = {0};
>> +	char *xattr_name;
>> +	DIR *dirstream = NULL;
>> +
>> +	fd = open_file_or_dir3(object, &dirstream, value ? O_RDWR : O_RDONLY);
>> +	if (fd < 0) {
>> +		ret = -errno;
>> +		error("failed to open %s: %m", object);
>> +		return ret;
>> +	}
>> +
>> +	xattr_name = alloc_xattr_name(name);
>> +	if (IS_ERR(xattr_name)) {
>> +		error("failed to alloc xattr_name %s: %m", object);
>> +		return PTR_ERR(xattr_name);
>> +	}
>> +
>> +	ret = 0;
>> +	if (value) {
>> +		if (fsetxattr(fd, xattr_name, value, strlen(value), 0) < 0) {
>> +			ret = -errno;
>> +			error("failed to set readmirror for %s: %m", object);
>> +		}
>> +	} else {
>> +		if (fgetxattr(fd, xattr_name, buf, 256) < 0) {
>> +			if (errno != ENOATTR) {
>> +				ret = -errno;
>> +				error("failed to get readmirror for %s: %m",
>> +				      object);
>> +			}
>> +		} else {
>> +			fprintf(stdout, "readmirror=%.*s\n", (int) strlen(buf),
>> +				buf);
>> +		}
>> +	}
>> +
>> +	free(xattr_name);
>> +	close_file_or_dir(fd, dirstream);
>> +
>> +	return ret;
>> +}
>> +
>>   const struct prop_handler prop_handlers[] = {
>>   	{"ro", "Set/get read-only flag of subvolume.", 0, prop_object_subvol,
>>   	 prop_read_only},
>> @@ -185,5 +232,7 @@ const struct prop_handler prop_handlers[] = {
>>   	 prop_object_dev | prop_object_root, prop_label},
>>   	{"compression", "Set/get compression for a file or directory", 0,
>>   	 prop_object_inode, prop_compression},
>> +	{"readmirror", "set/get readmirror policy for filesystem", 0,
>> +	 prop_object_root, prop_readmirror},
> 
> For some unknown reason the object type for filesystem-wide props is
> called prop_object_root, which is correct, but it got me confused first.
> 
> So the most reliable way to set it is
> 
>    $ btrfs prop set -t filesystem /path readmirror <VALUE>
> 
> and
> 
>    $ btrfs prop set /path readmirror <VALUE>
> 
> will auto-detect the object type by /path, but I'm not sure what exactly
> does it do in case it's a mount point but not the toplevel subvolume.
> 

If its not toplevel subvolume it fails in kernel with -EINVAL.

----
+static int prop_readmirror_validate(struct inode *inode, const char *value,
+                                   size_t len)
+{
+       struct btrfs_root *root = BTRFS_I(inode)->root;
+
+       if (root->root_key.objectid != BTRFS_FS_TREE_OBJECTID)
+               return -EINVAL;
-----
