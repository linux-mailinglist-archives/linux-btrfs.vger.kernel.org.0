Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD9CB5E24
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 09:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfIRHdR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Sep 2019 03:33:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50516 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbfIRHdR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Sep 2019 03:33:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8I7SZt1138726;
        Wed, 18 Sep 2019 07:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=jVJDunWLz+Xcykb4FZHQ3k/pcx9Ztn20GwEppCiHnKs=;
 b=iPfDGOaDhRp+8romcGyumuXNEU+Yl76+hrw3uoxPd5WDAxV9e8jiWy//3JJiFh8OIA6N
 /CejW6LjH8QatK40eLJaNMHYMnNt5POdJ6BeGPLlGdRZ1qmBAI/sUUFL6djMUdG8p7jp
 H3oB+W3o+l4eTt4TxZeFO98lYbTPFgwBp22vrB/qrVM6YAGqGKSwGWpO6Jl7mgal8LiJ
 yLnltuSthsKiO+jr2L6gXoOhctzOP83zY/oUGxAbxjEhRPJUVx0WKBe1/jyojTywnOYy
 +XoqjZw1IKCUYAuTc8q7lB33IydjDgnKPTwSQ90hDq26k8R7POFzz13RAcmIbTNzf6ks cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v385dsuf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 07:33:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8I7WXXD054627;
        Wed, 18 Sep 2019 07:33:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2v37m92wva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 07:33:12 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8I7XBsG000622;
        Wed, 18 Sep 2019 07:33:11 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 00:33:11 -0700
Subject: Re: [PATCH 1/2] fstests: btrfs/028: Don't pollute golden output for
 killing already finished process
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190918065626.34902-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <2d3f5284-793b-92c4-fad3-52e59caf1406@oracle.com>
Date:   Wed, 18 Sep 2019 15:33:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190918065626.34902-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9383 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9383 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180079
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: Anand Jain <anand.jain@oracle.com>
