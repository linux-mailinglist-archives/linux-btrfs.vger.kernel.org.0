Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B876629AD3C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 14:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900643AbgJ0NZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 09:25:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59236 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900634AbgJ0NZ2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 09:25:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RDP1Bn041203;
        Tue, 27 Oct 2020 13:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=JdLmc6rd7TpAip7Xp4imAuI6ern2cxgFrHUMHxTbblo=;
 b=ypOxQWFBhNc7JVoLup6IoRwKsgRuOKGgv3GUp/olg+hranyxqFRWXJGkjck0jYQ5zUIO
 xwzMYm6EBWpqJdYWGzqyn8qHwRiWMgC5qMInjA72pd5cpGXD0eqH9O5wJFLEfZrv4FOV
 /RWMTVrNNkF0GwL12DBZ7+GdFs+Kk+hTY7wA8CVwFd6JIMkP3PAGtnbjZAY8JCQh891z
 oPtW2DRDlGsCdR8exk6DUplSk+s0sojh2Qyp6bBXLqsH8EfrWKqPQMN3GNEdAhvfvZzX
 O+TUEqPGmfBFJ1csipnlCjxiTsmz3Py8C/++gyEdOLA+QGTHlwEkmX50elzT0vfZBIYK vA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34cc7ksvr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 13:25:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RDLJrJ126550;
        Tue, 27 Oct 2020 13:25:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34cx6vy5dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 13:25:16 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09RDPEna029171;
        Tue, 27 Oct 2020 13:25:14 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 06:25:14 -0700
Subject: Re: [PATCH v9 1/3] btrfs: add btrfs_strmatch helper
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com
References: <cover.1603347462.git.anand.jain@oracle.com>
 <75264e50d49f3c68cc14dc87510c8f3767390dcf.1603347462.git.anand.jain@oracle.com>
 <20201023111212.GA22167@infradead.org>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <0e7fe1fd-6ae8-f0e8-78ba-d28932d29a7a@oracle.com>
Date:   Tue, 27 Oct 2020 21:25:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201023111212.GA22167@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270084
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23/10/20 7:12 pm, Christoph Hellwig wrote:
>> +	if ((strncmp(stripped, golden, len) == 0) &&
>> +	    (strlen(skip_spaces(stripped + len)) == 0))
> 
> No need for the inner braces.
> 

fixed in next version. Thanks.
