Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209EC1EF2D6
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jun 2020 10:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgFEILJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jun 2020 04:11:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44716 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgFEILJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jun 2020 04:11:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05588BOC075206;
        Fri, 5 Jun 2020 08:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nOROyHVqK3pDtlY8ZVMwHclFYxHj3sSTy/SB3fp81is=;
 b=PZEWJnup01BtTk1nDRGL5DBuK7kmJP3751dOq2OC0NOrpEP/ju0qGESIHtaeFdfE9xNP
 Y5JNW/MihSvqGTNy1SfNyMUPMTIJ9PaPF+fXuzE3cU+UWUA70XxppT5xkrsOL0LjRXzZ
 SzXfLD/bxRlBZliO+PPfYYH+uk4jWoUW+JJESbSVVqLdrhxM78akLS/s3XK9ldUX3dbf
 q07R+YCJ4bxuCUSN8YXeGj+bJ0mDzhg6qKdWUFbPnNUXMaWMr9rKXhnR9LpsFqLprM+o
 HgH5EJzmVezh5WygNSDFzSLXjyFO7m/QLFUHLt96EVZbFGuSSncPu4JlRNJRCgjJ1k1y +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31f9261jdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 08:11:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05588DVD112971;
        Fri, 5 Jun 2020 08:11:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31f926uyx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 08:11:04 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0558B3vx003179;
        Fri, 5 Jun 2020 08:11:03 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 01:11:03 -0700
Subject: Re: [PATCH v2 3/5] btrfs-progs: Add HMAC(SHA256) support
To:     Johannes Thumshirn <jth@kernel.org>, David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200514093433.6818-1-jth@kernel.org>
 <20200514093433.6818-4-jth@kernel.org>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <73461894-89e4-dd29-660b-2bfa5376ed3f@oracle.com>
Date:   Fri, 5 Jun 2020 16:10:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514093433.6818-4-jth@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 cotscore=-2147483648 bulkscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050062
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> diff --git a/crypto/hash.c b/crypto/hash.c
> index fc658475..b1cdfe67 100644
> --- a/crypto/hash.c
> +++ b/crypto/hash.c
> @@ -1,3 +1,7 @@
> +#include <gcrypt.h>

We don't need the libgcrypt library when configured with 
--with-crypto=builtin

So this should come under the define CRYPTOPROVIDER_LIB...


> diff --git a/crypto/hash.h b/crypto/hash.h
> index fefccbd5..252ce9f9 100644
> --- a/crypto/hash.h
> +++ b/crypto/hash.h
> @@ -9,5 +9,7 @@ int hash_crc32c(const u8 *buf, size_t length, u8 *out);
>   int hash_xxhash(const u8 *buf, size_t length, u8 *out);
>   int hash_sha256(const u8 *buf, size_t length, u8 *out);
>   int hash_blake2b(const u8 *buf, size_t length, u8 *out);
> +int hash_hmac_sha256(struct btrfs_fs_info *fs_info, const u8 *buf,
> +		     size_t length, u8 *out);
>   
>   #endif



> diff --git a/disk-io.c b/disk-io.c
> index 6221c3ce..5fa1f0c3 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -153,6 +153,10 @@ int btrfs_csum_data(struct btrfs_fs_info *fs_info, u16 csum_type,
>   		return hash_sha256(data, len, out);
>   	case BTRFS_CSUM_TYPE_BLAKE2:
>   		return hash_blake2b(data, len, out);
> +	case BTRFS_CSUM_TYPE_HMAC_SHA256:
> +		if (!fs_info || !fs_info->auth_key)
> +			return 0;
> +		return hash_hmac_sha256(fs_info, data, len, out);


hash_hmac_sha256() is defined under CRYPTOPROVIDER_LIB...
So with default builtin option.

/Volumes/ws/btrfs-progs/disk-io.c:159: undefined reference to 
`hash_hmac_sha256'

Thanks, Anand
