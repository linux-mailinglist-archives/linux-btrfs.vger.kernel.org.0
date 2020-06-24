Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D9E206F03
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 10:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbgFXIeA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 04:34:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51562 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbgFXId7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 04:33:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05O8W0xK105536;
        Wed, 24 Jun 2020 08:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9qy9JZW62+Prtd9Xnov/vPBUrNIIr4w6OvXWTFIk0xI=;
 b=GN+P6O2W5Bjfp8ZLxSjMVp1TXjW2XCyrrwLo9R+DgwrD1fWBHRc/2F7dy13jl+iVIW1C
 1JUSz2lzntunHN6KmQ+XWrFEM7fIOFgFDlPrB2tyvpsAXtTX5xf3udzT7EEjQoG7oVlc
 2RCI8KCRSGFOpgemPtkycVmA5n4sEl5kTVnmB7dHDVLn3q3UXvyRoX8I1NboZxnevx4r
 SZah1Mfw9iybAbPgwNu6JEM6DW9CH/J4KCtXzxZTgxmL4bAUBeSIXG9I0Z/ILc/7sshD
 Y76KkDQGPtC8SE/EXeY1YWx3bybIm6O45Nt4C8xUsavFotBNrOMfbZwbR9PQAerezNx+ uQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31uustshs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 08:33:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05O8XHnx109220;
        Wed, 24 Jun 2020 08:33:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31uurqf7mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 08:33:54 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05O8XreC021856;
        Wed, 24 Jun 2020 08:33:53 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jun 2020 08:33:53 +0000
Subject: Re: [PATCH] btrfs: remove unused btrfs_root::defrag_trans_start
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200623192354.29423-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8343bef6-ca06-9968-2e2f-aaaa26a03f84@oracle.com>
Date:   Wed, 24 Jun 2020 16:33:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623192354.29423-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 cotscore=-2147483648 malwarescore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240063
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

