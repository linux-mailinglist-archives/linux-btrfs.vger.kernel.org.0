Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B52968A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 05:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460278AbgJWDLP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Oct 2020 23:11:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33238 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460271AbgJWDLP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Oct 2020 23:11:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09N34lli151152;
        Fri, 23 Oct 2020 03:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=pZvc3j1vgmsa9yqBgLdz1INiLe02QvmRJ9hpwpacEU8=;
 b=bncVqnD00DA/BhguxPduQFvW+XpxT4+uEcQfMQf+/zKz7c5t93IyfrreqX4wA3unplqy
 QwzVH/c0gArJ7cCon389XT8HW+oYVGW093il04meFKGskTNVwBnWEHrcP6mAtr/rdLAv
 k7IhdJC3gFPBwC4S2hMux5gp/hAidVJhbOM8GK4JKRZ+sDzLXV17qqR9GIN+iehREi5U
 S5XY0wCyB6loP4zSb8emtoOrGOVA5WhvYt5sXCWm9ewaMeTPJxFLIRaIwn5pJOFUxlCl
 APTX4/X04zx9aduBlfTD6i9VPhnxA3NsaOQjAb0WVNZkZFHGFZQmo52+VjAFCTdSb2Ac Mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 349jrq121w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Oct 2020 03:11:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09N35jHn067777;
        Fri, 23 Oct 2020 03:11:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 348ah1j4m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Oct 2020 03:11:10 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09N3BA8L016938;
        Fri, 23 Oct 2020 03:11:10 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Oct 2020 20:11:10 -0700
Subject: Re: [PATCH] btrfs: Open code insert_orphan_item
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20201022154046.1654593-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6d93e744-7d54-b675-867a-848e1e5fe3cd@oracle.com>
Date:   Fri, 23 Oct 2020 11:11:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201022154046.1654593-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9782 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9782 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230024
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/10/20 11:40 pm, Nikolay Borisov wrote:
> Just open code it in its sole caller and remove a level of indirection.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
