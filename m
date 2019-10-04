Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8EECB618
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 10:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfJDIZb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 04:25:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34978 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfJDIZb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 04:25:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x948JE5m087447;
        Fri, 4 Oct 2019 08:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=LF9ZTsU5XAs9oKMVeEzP+otEFloEouZbi4lc2n1zN6U=;
 b=qxUuXr5S0imCBo0fsB3MqTWUP3Teo5wWqzoVLwbryFYxYgR/Gs5VOy2dyiQXk6OL5nSw
 5/DqoiB8t+EY5XLTaqDQkm3VlcLxjtzJ+Pcw6hoGOnPfVMnb8RzTcGVp9WnQezzItejf
 f0Ti5x6A5g0qCQiLIl27FqO4ZYb9qjszqsNN9sxQCPcpNvqdZaiKLh0dUX8X0FKOs1mN
 AKhn3j/fTdnnGghZMdyezKqYgERotWMjKNeePFFLClSgZbKNFkP2kRRwvSpRN0LjR1JD
 bn9O7xe/Lzu8I0L5kbNs7syN3o23fEu0BLEnxkxTXssWcITDb80s8TV6NlENmHuQgING bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2v9yfqsp4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Oct 2019 08:25:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x948NHDa176274;
        Fri, 4 Oct 2019 08:25:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vdt3p894v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Oct 2019 08:25:27 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x948PQOI010887;
        Fri, 4 Oct 2019 08:25:26 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Oct 2019 01:25:26 -0700
Subject: Re: [PATCH] btrfs: drop unused parameter is_new from btrfs_iget
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20191003170935.31399-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c881bf24-76d5-9d21-478c-27cf9c5b3b99@oracle.com>
Date:   Fri, 4 Oct 2019 16:25:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003170935.31399-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910040078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910040078
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/4/19 1:09 AM, David Sterba wrote:
> The parameter is now always set to NULL and could be dropped. The last
> user was get_default_root but that got reworked in 05dbe6837b60 ("Btrfs:
> unify subvol= and subvolid= mounting") and the parameter became unused.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
