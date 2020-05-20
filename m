Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5B61DAF8C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 12:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgETKBj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 06:01:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41190 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETKBj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 06:01:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04K9vEr9161671;
        Wed, 20 May 2020 10:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2020-01-29;
 bh=knMSL9gOMaFgFebmt2ZghBhKlyJDFEz2l96zhewwmg0=;
 b=YPLNxP1DzsAW6kC1fmfSj+0sKMV3kqCiancqBcW3cqk0AOu87tECk3gk8sYHMLIiQC7A
 psbLIhNhv2bgA26Ke0aGnc9ElC2cAowzdzMvISiZDkmmyJqPzsAgPgmj74BoB57vGL3Q
 +RnVuUEianexZwc5ZopxEUnoxYk7MKUm4kiFDoL+14bCFXmT6A2nEOY6JZAGMZGjWZXn
 vO/9L7fqMpRycC2+YAh2qCCLMOXAgHBooH2rbOCo1r72RfMMxB6NPu5mgspPQvlr8xuh
 c6lNMSsMxitKt01ocJBERLp0A37C2a3dSm2CifRZ4ymTBZ9vC35yrC3VhktPcLW7K0iC Wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3127kra8dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 10:01:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04K9sQ4C059498;
        Wed, 20 May 2020 10:01:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 314gm6sknv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 10:01:32 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04KA1Wof014584;
        Wed, 20 May 2020 10:01:32 GMT
Received: from [192.168.1.102] (/39.109.177.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 03:01:31 -0700
Subject: Re: [PATCH v2 00/16] btrfs-progs: global verbose and quiet option
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
 <8a2bac99-5c07-2aa9-fe3b-e09f2ad16213@oracle.com>
 <20200114114047.GC3929@suse.cz>
 <d38e842d-e2a7-5d27-3157-72532c3526b4@oracle.com>
Message-ID: <b3981267-d64c-ebbf-233c-ea821cb7257f@oracle.com>
Date:   Wed, 20 May 2020 18:01:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d38e842d-e2a7-5d27-3157-72532c3526b4@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David,

   A ping on this series.

Thanks, Anand


On 28/3/20 1:45 pm, Anand Jain wrote:
> On 14/1/20 7:40 PM, David Sterba wrote:
>> On Tue, Jan 14, 2020 at 02:14:24PM +0800, Anand Jain wrote:
>>>    I wonder if could this be integrated?
>>
>> Yes, when I get to it through the pile of other patches.
>>
> 
>   Can this get into the upcoming release.
> 
> Thanks, Anand
