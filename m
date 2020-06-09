Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBC61F3F1E
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 17:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgFIPU7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 11:20:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50388 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729678AbgFIPU7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Jun 2020 11:20:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059FIPcE103042;
        Tue, 9 Jun 2020 15:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lJ9TPtJaaTcSaOsaQCptngZSDffJmyCshbPP/OHqD34=;
 b=rhfFSTeOnZZ4jZ0uW2zS9+P+I2pRIR8ho55uu6BzfEm/SHlYgIpO1EdFz85F+7rFG0FQ
 LhwCS7U6uho2P1qassAqPTIQo/tpqxPFKFiYy9EsnWqzRajYG6TBcuejPiDnFklKmQSL
 T5zH3N9AZnQR/AN50JGWGf5Z6i3efpXb64SRnmIwef552vojff+TJLru9zuFfdoHvt8P
 8uoHRfqeMooKF6mJSiWDxGtbePAl2axaUfqBgYmwYSxqED5zierMSjxdhURNV7zCzJKq
 5wDunfXAdfacO8aOkQ0onMcQPSnDkwMYyHFK0gYqNNm3ter5M/Sx5vh9C7BplVCe9dwE ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3smwa2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 09 Jun 2020 15:20:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059FJjlh168896;
        Tue, 9 Jun 2020 15:20:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31gn2wvcjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 15:20:56 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 059FKunY006097;
        Tue, 9 Jun 2020 15:20:56 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jun 2020 08:20:55 -0700
Subject: Re: [PATCH 1/3] Btrfs: remove the start argument from
 btrfs_free_reserved_data_space_noquota()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200609101933.29459-1-fdmanana@kernel.org>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3cd70934-1fce-bcdf-92f1-88dca42e6bdd@oracle.com>
Date:   Tue, 9 Jun 2020 23:20:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609101933.29459-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090117
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
