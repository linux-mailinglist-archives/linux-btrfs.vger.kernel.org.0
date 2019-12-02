Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13CBF10E92D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 11:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfLBKtb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 05:49:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52174 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfLBKtb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 05:49:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2AnP5A077795;
        Mon, 2 Dec 2019 10:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=isbovAW+bWhvVDQxtDyXRidikyBLx/E05PkjOJ4gR7o=;
 b=IUguLsxf96M32U2KEJfPOUYc126g8+bSX1pn+Es12W3/0cnjGIz6QRIODFGWMqWP9C5y
 D31juIetOFU34PdRnlFfaA2GZlmBZf+FBNe+NR992nZxbmbUUw7uPUOjJoD+aL/bw0Em
 DAMA5lmdNG26x+2LlvPn0QYT8qjpsF3Uq0pP7Ajx17qdtzMsCRAwjG+1v8pvpflMNIcq
 3osQnP0ptENKuVOME3kP1PD3oUJKiZiCk9atRWYWhhDvIU9dMgcTyIHHkCAK8J+m6M93
 LKFeoOUtrzQj1proRSmibj6I4k/UECILc43WGYqaSd+PBg2tm+GhdBj4oWGsPGC7fNLu kQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wkgcpy48m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 10:49:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2AnKjv098387;
        Mon, 2 Dec 2019 10:49:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wm2jm780c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 10:49:20 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB2AmFqU012800;
        Mon, 2 Dec 2019 10:48:15 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 02:48:15 -0800
Subject: Re: BTRFS subvolume RAID level
To:     waxhead@dirtcellar.net, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <494b0df1-2aab-5169-836d-e381498f64db@dirtcellar.net>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ed65c577-3971-8c4f-c690-83e85dd8188e@oracle.com>
Date:   Mon, 2 Dec 2019 18:48:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <494b0df1-2aab-5169-836d-e381498f64db@dirtcellar.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=887
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912020099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=951 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912020099
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> I imagine that RAIDc4 for example could potentially give a grotesque 
> speed increase for parallel read operations once BTRFS learns to 
> distribute reads to the device with the least waitqueue / fastest devices.

  That exactly was the objective of the Readmirror patch in the ML.
  It proposed a framework to change the readmirror policy as needed.

Thanks, Anand




