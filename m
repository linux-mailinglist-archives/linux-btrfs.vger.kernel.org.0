Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A55131097
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 11:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgAFKcJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 05:32:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42888 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAFKcJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 05:32:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 006AOh9E024239;
        Mon, 6 Jan 2020 10:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Rrtvf1MjA5rX9OXeJY0Hi1MzsG9DyIM/izS5nIKx5FE=;
 b=ef0j5PKiVe5XdnP2ouQi7SZT1RsS+VcOLVpXUIUTIi6CBu6u2PQBOxJIcDDvbXCIev7G
 4xy2+PxpAIxWFX+oQ8MVILfoo1ySsK1kBpt/vWTC0ZH5Fnqyq2WzHyuwXYmCiNJjf7lq
 sQ+n/NDuu/8mw5gS+w1y5vJPIQ4kaexT6Vc0DncI54yPXmMzA0eDTAPEg2VhKnUVyxY5
 ldQyiEPA3N2hjHEmMogIBXWhhvk6Ax2+rJhJPWB+OTSYC8L2EuYB//ojQlgcfEPJweTB
 BAROg7VrGieeBqUK8pp2+Jb0Bwrm7G/bdl+WcaPj1vBMnzXqPFoA/WLxn2nV4Cug4eIx YA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xajnppcty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jan 2020 10:31:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 006AOV6w191840;
        Mon, 6 Jan 2020 10:31:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xb466cbbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jan 2020 10:31:03 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 006AV28I001963;
        Mon, 6 Jan 2020 10:31:02 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 02:31:02 -0800
Subject: Re: [PATCH] btrfs: remove unnecessary wrapper get_alloc_profile
To:     Johannes Thumshirn <jth@kernel.org>, David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <20200102161457.20216-1-jth@kernel.org>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <57a514e6-c8fa-3332-8bd8-2bd3a97fe966@oracle.com>
Date:   Mon, 6 Jan 2020 18:30:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200102161457.20216-1-jth@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9491 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001060096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9491 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001060096
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Reviewed-by: Anand Jain <anand.jain@oracle.com>

