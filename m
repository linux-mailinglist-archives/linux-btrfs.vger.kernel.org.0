Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDABA169CBE
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 04:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBXDqO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Feb 2020 22:46:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36338 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbgBXDqO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Feb 2020 22:46:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O3hm2K113422;
        Mon, 24 Feb 2020 03:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=sDp0yWGsHyouKtmiMyMVI4ZDjBN7Hs+8yws5qzDJaIY=;
 b=SmFDv4UHCmLLavv7DK8qrd21nIuJujVG+LqBx6wFOAg7GtJJKXaXQzaHbcoJd3zDcUMD
 Bs7o7LbNlDXkzjEhIsWbq7oMqGkvjq1joy77Wn3dNQvLZ3mGJS30ABCqlI+obeCCTy0y
 aRJ/VokgDykw4PHWAcAf/rr6PQfXNzrkERhIbAkScXUzYpvdLgOa5/hgXjy7WEscds/S
 rS8ahJuYMHlcjrZPqwT8XPgpVVAeDAjNSNVZpURtzvQfR5xkWZ27/0W8urA0xd7DOFtP
 iWgTNRw68OIAME6UDgstmD1IIIJoumwl4ZPofvTWV0ftotTk8GifXK1P3NUNLobpfLHH yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2ybvr4gyyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 03:46:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O3h1YE180271;
        Mon, 24 Feb 2020 03:46:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ybdutdsha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 03:46:10 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01O3k9sl029526;
        Mon, 24 Feb 2020 03:46:09 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Feb 2020 19:46:08 -0800
Subject: Re: [PATCH 09/11] btrfs: adjust delayed refs message level
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1582302545.git.dsterba@suse.com>
 <f8d0bd62a1cea81145756e5fb7857c8cd4dcc8a2.1582302545.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e32839d9-2987-05d5-eb4b-973984b77b56@oracle.com>
Date:   Mon, 24 Feb 2020 11:46:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f8d0bd62a1cea81145756e5fb7857c8cd4dcc8a2.1582302545.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240030
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/22/20 12:31 AM, David Sterba wrote:
> The message seems to be for debugging and has little value for users.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---

Reviewed-by: Anand Jain <anand.jain@oracle.com>
