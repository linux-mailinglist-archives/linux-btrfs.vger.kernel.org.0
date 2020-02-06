Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E19CA153DC3
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 04:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgBFD6W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 22:58:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42270 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgBFD6W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 22:58:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0163vsmX189746;
        Thu, 6 Feb 2020 03:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BTll5AU19dU27k0hDKke0lmT0S0w+Ijid1rVXs5p5Ec=;
 b=LTrBCyQdIP7TniiEV14CWNLIzxEO2o0ROaqTIn7uXtQaWrEM97YQEj2aVTVE9Fwoq4nG
 pGTOvM5i5jtSN0PqlyhG2G7eviv+rdIdSoKmxccOy4BV3woHg1z1v24h9814dMj1Zpk0
 0lgdKKk8+ZuNPuqvwRmAQyJVwyUz8C3EzuGHQAeIiGYXWajlBLTNgDxub/d9WL683LFJ
 C0R4pJiOq+4BiEunePN9ZG/ZgVpfJn6Wh1f1ZY1RaEFuhTQ2FfLiIjiD4P5XT1p+dTFc
 xeiANzi/WyTSL/97XCL4VJuHsO896oD2I+LBtegI1qqubvEPzw6JrZ61XSZHO+yFFN74 RA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=BTll5AU19dU27k0hDKke0lmT0S0w+Ijid1rVXs5p5Ec=;
 b=iY6nM0jnhXU3GUcf7yfARZEjCzw/zEvaMxF94IjWQAZbM7iLFi7Np2GKHTj1WocKjp1G
 9dmqdzS7S/hL2rpO1xDHIYeCJPn1kO3mppQ/N/0hYARxQQswahxod9Mlk0SdzoBxh5HW
 /7StNtnX/Vci6QJILcQMYvFGDXfSd0FsmLrNQ+6wP/80YsKemrNketyaq3Kpul5B+sYi
 JKIWdg+LfoIsg6AFIaIZTyyS/g220yGc2sW/1hZuTGNdeQJOIfdhQSvMKmt0PO08Z5KY
 STOs3esK3pXWbYoPdAkPbWvR/VWE8MnC8bdEaNSms2fPUe1GLmSZMZ4cVFhOHBxwrCpS WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xykbp73mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 03:58:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0163rBAv082979;
        Thu, 6 Feb 2020 03:58:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xykc4js8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 03:58:17 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0163wGOq003766;
        Thu, 6 Feb 2020 03:58:16 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Feb 2020 19:58:16 -0800
Subject: Re: [PATCH] btrfs: move root node locking helpers to locking.c
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200205162651.32110-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <526491bd-9efe-2201-dbef-0d0ccfed7870@oracle.com>
Date:   Thu, 6 Feb 2020 11:58:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205162651.32110-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060028
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 12:26 AM, David Sterba wrote:
> The helpers are related to locking so move them there, update comments.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
