Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF20169CB8
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 04:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBXDok (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Feb 2020 22:44:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34624 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgBXDok (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Feb 2020 22:44:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O3hjMp111317;
        Mon, 24 Feb 2020 03:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TAXO17fEwETQfFtQcxQ9Wv7N4HcqSlLqLznHppnoPq8=;
 b=JX3vuQsXF60TbZobDlTuMB5YRJRa3Xq43ZXZEVsu53lVll3vTgPW8jRRWYknJ+bOZ2ON
 JL5JBidx5BER02GIL6CkErBIkHCjzWl+LqfBVzCw7gvxuUVARN9JQq54wNvFVKG/vzBf
 Ktq1oeyuyPMwbksvN01HXSVoZ/YcasaPQgdD8d5RYRyncLXpuphbwYyCDn+ryzyaKc5L
 W7he6eDUrs6chqVGY1RQy4p+kz0ZtUANocY1/Ui1dXYoIj4rZBqaYfNC+MIc470W0fF1
 8VwKyLhgGxheOYvTrGolMwxt54OeBYWCXsxfu1PgHoUd6GSJ6PXpjcBvDeTu9SRl/Sob iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ybvr4gyu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 03:44:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O3gNgF110607;
        Mon, 24 Feb 2020 03:44:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ybe1060dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 03:44:35 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01O3iYju026984;
        Mon, 24 Feb 2020 03:44:34 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Feb 2020 19:44:30 -0800
Subject: Re: [PATCH 06/11] btrfs: adjust message level for unrecognized mount
 option
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1582302545.git.dsterba@suse.com>
 <a3813ca2dcfa6d75e118f4924811487dea4c52a0.1582302545.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <85d0dfbe-980b-455d-d7c3-a837647ef9d7@oracle.com>
Date:   Mon, 24 Feb 2020 11:44:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a3813ca2dcfa6d75e118f4924811487dea4c52a0.1582302545.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> An unrecognized option is a failure that should get user/administrator
> attention, the info level is often below what gets logged, so make it
> error.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

