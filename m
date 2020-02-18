Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65FB6162361
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 10:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgBRJaT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 04:30:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33084 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgBRJaT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 04:30:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01I9OWIC033650;
        Tue, 18 Feb 2020 09:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=c5/RMt1MIVPtaItn5HFxKwbjX/19jzakS6PlLlmnhwc=;
 b=0gxSsQLjY30lfkjycjSJP4Ej55UdPR5h6l3gBz0JMcduqA6VMJeFQJdgzANeBSULJqNc
 gh9lj0dxQVJNsXWhCcKm43OGeCPupsQMIb6LVOO5kshom48gtu0Jajino+0g950oeBMi
 bMRfmWbW85fNBwSs+pnH/3RI0Zsfi6gkZWrxyovVvhPyav8nhnOIUewyzRy6iMnJDU6W
 27u7ACwNZCeRSbvclM5oToWjVi721mRpSoiWpm6FJq+wfkW7BbKMA7nyhV+H/FNNvNrX
 iRYv0X0O4QYcgm1CCoK0gdCfl62XcSswk/X0dQWPqnnSDlOvhMm4lpXl/omQdecoLgy5 VQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2y699rm67j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 09:28:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01I9Rlas015138;
        Tue, 18 Feb 2020 09:28:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2y6t4hu9e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 09:28:13 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01I9SBvg022865;
        Tue, 18 Feb 2020 09:28:12 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 01:28:11 -0800
Subject: Re: [PATCH v8 5/8] btrfs: use BIOs instead of buffer_heads from
 superblock writeout
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
 <20200213152436.13276-6-johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <59a939e4-2962-7c21-e685-75c777232f4c@oracle.com>
Date:   Tue, 18 Feb 2020 17:28:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213152436.13276-6-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9534 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9534 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180076
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/13/20 11:24 PM, Johannes Thumshirn wrote:
> Similar to the superblock read path, change the write path to using BIOs
> and pages instead of buffer_heads. This allows us to skip over the
> buffer_head code, for writing the superblock to disk.
> 
> This is based on a patch originally authored by Nikolay Borisov.
> 
> Co-developed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Looks good. A nit below.

> @@ -3553,12 +3570,11 @@ static int write_dev_supers(struct btrfs_device *device,

  The comment section on this function still says..

  * buffer heads we write are pinned.


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
