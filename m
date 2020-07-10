Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E7421B8BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 16:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGJOcm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 10:32:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43080 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJOcm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 10:32:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06AEQjRC078048;
        Fri, 10 Jul 2020 14:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gD/OX5/g3bySPIrw8OV7Iu+Jw+nqvNPz5zITnc/QKUM=;
 b=PIqPpRGl76kQA7jx9KjV3+YxvmLUz/fF6OAd+vtj0Ui0wfr3+NAxq0okNoWu62hD83Ud
 peLsxvgpcd9vAEVQnHb7cr6XyftASmdE0pvn+r0KUrVyCoy9hnXWDnZtz5hPoqFYzjiw
 29Z5XygavPeoSNBqOc8LEI2fM6qo0zG0Su+vy9JDOeVzlmcOFa8pUws9EJiqgR5gAPYk
 NW39wQIquqpqR+lhx6W/F5uqODvqHnAE2xUbTjRIxkVcBigoJRN9O4v7y0zUC6D+18pE
 ZvLzsN/cHde6AKWLqys6zTbefWekenMgqfChGjPy6q2nNNBvzGjC0iWmQYoQ3Rj/4Vve iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 325y0aqsys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jul 2020 14:32:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06AETKZw135608;
        Fri, 10 Jul 2020 14:32:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 325k3mgdmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 14:32:38 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06AEWaRW014001;
        Fri, 10 Jul 2020 14:32:37 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Jul 2020 07:32:36 -0700
Subject: Re: [PATCH 1/3] btrfs: add filesystem generation to fsinfo ioctl
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <20200710140511.30343-1-johannes.thumshirn@wdc.com>
 <20200710140511.30343-2-johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3f60141d-027a-c9e2-aa69-680668edcebc@oracle.com>
Date:   Fri, 10 Jul 2020 22:32:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710140511.30343-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007100102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100102
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/7/20 10:05 pm, Johannes Thumshirn wrote:
> +	__u32 generation;			/* out */

Generation is defined as u64 in fs_info.

struct btrfs_fs_info {

         u64 generation;

Thanks, Anand
