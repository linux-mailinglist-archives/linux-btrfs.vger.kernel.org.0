Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572CE200AB0
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgFSNub (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 09:50:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48066 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732879AbgFSNua (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 09:50:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05JDlBSP105993;
        Fri, 19 Jun 2020 13:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Rs69d24JeqcVi2TouBsmVXSCfudLuFNO/UBjXx1gX/8=;
 b=odxfF2QrVJZjTeVfH/41uHhar3yOZrscp+CzAF5wDEXm4rCQRHFmXBamN1dRIXSqHSq4
 971hDJ3oHGEADHaQ3TS0CbquWAywTUBO/dZu1+MlQqYOgi1mIFtFg2LKgDVJdErnolEi
 L0iQYy3e616ts+orwAV+h8k7LgALVkC42nnVvstwE6duy3vIRD8BsLpkXyUlfLxtQ6Os
 vWVxJj5ZNgc3r/fCV2oACTfePHaxyiJ2eREsdNhsln9z24P7rjjXRPRC/+AP9ZI2Td+6
 suqFukKz3e0Dk+VjMOJYSwuvfrVjnvZW3Rx9BusaYmY9U8UAXvHj9UXSyAw3mfn67d2g lA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31qecm5cnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jun 2020 13:50:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05JDlHW0038539;
        Fri, 19 Jun 2020 13:48:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31q66rhcw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 13:48:26 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05JDmOcR023592;
        Fri, 19 Jun 2020 13:48:25 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Jun 2020 06:48:23 -0700
Subject: Re: [PATCH 2/2] btrfs-progs: mkfs-tests: Add test case to verify the
 --rootdir size limit
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200616063230.90165-1-wqu@suse.com>
 <20200616063230.90165-3-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f9236da4-b66a-38f7-4685-2cab4e280d7e@oracle.com>
Date:   Fri, 19 Jun 2020 21:48:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616063230.90165-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9656 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9656 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 malwarescore=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006190102
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>
