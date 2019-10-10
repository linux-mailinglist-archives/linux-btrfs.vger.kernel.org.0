Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8D4D1EB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 04:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfJJCxz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 22:53:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46478 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfJJCxz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Oct 2019 22:53:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A2mM8H094552;
        Thu, 10 Oct 2019 02:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Ihp/vu9PZExUePz6ehlwoeXFe7wb2Md/jYSKivs3y4c=;
 b=sIef0k6qGwoz38eYX3eJGUyNAl9BQfWGIbOPEZDy8Ay/cJbTgAp6wNSw6OSa/dEhgFxa
 eiezPCa1b6zvp9Z+ZgBhjD+UtVKxlm6ney0C2nmHnK6d4ml1rmO8xyMtbIjt/p+f4oGK
 0aO2T2Kvnw8oj4TGP6BxTfCGltqe72/XGKDIWEb5y0SEXAqSHD7j9z4VkygG+Dx5lgDH
 nUeayUW7CWdKQgJEnNRFebwEGZ77u/nnMCih+big5LwqiKSwbI90Z8GJI276WP4dTu1R
 amlRyRzZOqnr3RRnL6BljoCBKfCju6JyH0KWOTI9jH8WcNVz3HHJc0Fjgk33WLHTIfHL SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vejkur9yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 02:53:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A2mnaP071637;
        Thu, 10 Oct 2019 02:51:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vhrxck7v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 02:51:51 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9A2ppb3021451;
        Thu, 10 Oct 2019 02:51:51 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 19:51:50 -0700
Subject: Re: [PATCH v3 1/3] btrfs: block-group: Fix a memory leak due to
 missing btrfs_put_block_group()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191010023928.24586-1-wqu@suse.com>
 <20191010023928.24586-2-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <9c103130-afc4-8004-34bf-1f24476e13c2@oracle.com>
Date:   Thu, 10 Oct 2019 10:51:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191010023928.24586-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910100026
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/10/19 10:39 AM, Qu Wenruo wrote:
> In btrfs_read_block_groups(), if we have an invalid block group which
> has mixed type (DATA|METADATA) while the fs doesn't have MIX_BGS
> feature, we error out without freeing the block group cache.
> 
> This patch will add the missing btrfs_put_block_group() to prevent
> memory leak.
> 
> Fixes: 49303381f19a ("Btrfs: bail out if block group has different mixed flag")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
