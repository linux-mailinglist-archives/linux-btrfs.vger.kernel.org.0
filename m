Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC0F1EF3F6
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jun 2020 11:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFEJWZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jun 2020 05:22:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35566 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgFEJWY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jun 2020 05:22:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0559HUTX040479;
        Fri, 5 Jun 2020 09:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=zA9jgm0wLbc0Ct1kXgDEhWnrG+ci/hK4pVWjtF+embA=;
 b=t1EVBVNztlR9hagWrvJY2py52U8+jxY6eEikbaAuEBn4xOOKmPZKVSaH9aOBYdxHTaFV
 +nXBfAJ+T9p8YgmBlglMl+L8pI145AUqM5SSoR25UaTMQk05+U2oYsqAaXKVlR+FMCrI
 NfvWfptQlkCD5pIEBDDdTO+RjSCSQB395jdV2UHi42vJgO6b9nbu2HUmOrWU7B9PE7/7
 V0AiClPQ4dj+0N+/OZsHpDTAEF6LtpyDvEJw2mcxbxn9OYlZtGLgijDuWh3+aXkfbTRl
 TwS7vHkn/Ha1ryd/SFpF7ciumHtMS4C5SspUetKmT7g3iJzcEg+pZwjWz359nckEJjr6 Mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31f91dt0ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 09:22:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0559HbSh150563;
        Fri, 5 Jun 2020 09:22:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31f925679r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 09:22:20 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0559MJnZ012584;
        Fri, 5 Jun 2020 09:22:19 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 02:22:19 -0700
Subject: Re: [PATCH v7 0/2] btrfs: Introduce new rescue= mount options
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200604071807.61345-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <236d8772-2e55-bdb1-339c-655f69510234@oracle.com>
Date:   Fri, 5 Jun 2020 17:22:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604071807.61345-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 cotscore=-2147483648 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050073
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4/6/20 3:18 pm, Qu Wenruo wrote:
> There are quite a lot btrfs extent tree corruption report in the mail
> list.

> Since btrfs will do mount time block group item search, one corrupted
> leaf containing block group item will prevent the whole fs to be
> mounted.
> 

  Can you add btrfs_info/warn() at those places to indicate
  -o rescue=skip.. might help to mount in RO.

> This patchset will try to address the problem by introducing a new mount
> option, "rescue=skipbg", as a last-resort rescue.

  Do you think there might be another check to skip during mount at some
  point. So if why not add a generic -o rescue=skipchecks? Of course
  dmesg -k must show what has been skipped.

> This "rescue=skipbg" has some advantage compared to user space tool
> like "btrfs-restore":
> - Unified recovery tool

  Yes.

Thanks, Anand
