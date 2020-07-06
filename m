Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C6921521A
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 07:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgGFFSz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 01:18:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51482 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgGFFSz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 01:18:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0665GQtC164895;
        Mon, 6 Jul 2020 05:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Vk61Blm02PAbG153UQf9wFRX7MoR/pk6fDHyr9PRFeY=;
 b=pr39tpwuhQURlwKSvxIsSZq5MGgJMkjGRLT269vzh9k87hW8jCNlkvui9ByySY7XzZc8
 TPL4G+bS27TPmjWTCgT48dAILM6TOiVKNQ2iLMHALU8g7Tt26RXfzwY+/z0jiLVqS+f0
 oJWhDetN69oiVttxbeZr0eWzKJ+1PMK4nT4TtFlFYuq9QLducCXilFRUFpiKl6r7Qsao
 ZPZuvV09/njWE6+lCzdMQDKiDkDI3UaUkCJP+nwG2HRHuXEmadZWGXWer+phpk3pWkwe
 vpjweNyCpLXD8uGlITD5vfGTXVytMnZSbg1DOFODwmn6Gacys9hNu8DwMjXuD1u20hug zQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 323sxxggnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 06 Jul 2020 05:18:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0665D5fP043050;
        Mon, 6 Jul 2020 05:18:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3233bkwk6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jul 2020 05:18:39 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0665IbQ0027193;
        Mon, 6 Jul 2020 05:18:37 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 05 Jul 2020 22:18:37 -0700
Subject: Re: [PATCH] btrfs: discard: reduce the block group ref when grabbing
 from unused block group list
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos@mpdesouza.com>
References: <20200703070550.39299-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ad5fcc69-d771-dafd-7b62-6f413bc3574b@oracle.com>
Date:   Mon, 6 Jul 2020 13:18:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200703070550.39299-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9673 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060041
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9673 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 adultscore=0 cotscore=-2147483648 phishscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007060041
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

  We should have a set of remount test cases.


Looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>
