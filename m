Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 319D5AE4BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 09:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfIJHh4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 03:37:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56864 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfIJHh4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 03:37:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8A7OKPw132477
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2019 07:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=Xlppr1IPgzfdmfTitDVCFJdh4vYS3fNDOM26poN/oWk=;
 b=Jsb+hckUMiRCTrQkZ5HZeUz65WYWxrOaGHxPp1NOLDTNcB0NlLJXIN+H7dm6rDUS+p37
 5bo51ZSiZ/5s/CnRXKhdBFDOeSFyOmzlWCf0s7Sb3cvreGlURFHkFtGQSVR2csggSzPJ
 BHT3ElpA+DqyFis8lW63sNqDNK2sGjxuryz6/I90w0s6XvT5RPKcFMappTzghxb1CWfh
 p0BBiQV9r+wVzprieztDf09rluDGmBO+pj1AO+NDhXq4+9m6kz70tCbxkyU0qfiGh6uJ
 ydliRyGpQj9YlJdSca5nXdTatbYHLcEXaIttSST6p3ntOjLLvyNbAnwPSskRHTpzw92J ZQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2uw1jy1are-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2019 07:37:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8A7brjw185878
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2019 07:37:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2uwpjvfvcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2019 07:37:54 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8A7brKM013178
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2019 07:37:53 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Sep 2019 00:37:52 -0700
Subject: Re: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <20190628022611.2844-1-anand.jain@oracle.com>
Message-ID: <e1d78c85-c433-ce7a-dda6-a48cec720ef4@oracle.com>
Date:   Tue, 10 Sep 2019 15:37:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190628022611.2844-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=902
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909100075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=970 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909100074
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Ping.

Thanks, Anand
