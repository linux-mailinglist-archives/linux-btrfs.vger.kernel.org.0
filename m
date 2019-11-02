Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21C9ECD10
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Nov 2019 04:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKBDrz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 23:47:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36574 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfKBDrz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Nov 2019 23:47:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA23jCsW126974;
        Sat, 2 Nov 2019 03:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=W1BhO7urlIjHMgk9lNBB5eVLk4xR/5HbKw+CZ9DdLoc=;
 b=GD9PNS/cb+zbxit0p6xDcm2KllHp4nBiX8BFWgdmWs1o0e6lwJ6Lf1CFqiH1EtVy9Nrn
 QA4i/3KZ5s4S+ghvbGdB4DYXSvvYde6Xkla9bHNgu2BV9fMTPazjioCdm8KkcN259YT+
 gxsoR+INsPU07rnRrr9QN3dfUWGuWclziVl0b30on7JgkqjrTeeRA05lRR3wOuCoBThT
 uGFlYyrhzT18RjJgLuNugPTgvQOMriCI6JZx/lnI0PsIE966v2TnMNocSSFeHjJdbHF4
 5MV56eEfzNDj0WxoICzhRjLuY7BkK9QILWn5XWeI3MZpJ2O5PnqGXG0ckNMciy6hAISC QQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w11rpg30s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Nov 2019 03:47:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA23hThm036876;
        Sat, 2 Nov 2019 03:47:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2w0yuc599q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Nov 2019 03:47:49 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA23llVk001174;
        Sat, 2 Nov 2019 03:47:48 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Nov 2019 18:15:12 -0700
Subject: Re: [PATCH v1 04/18] btrfs-progs: add global verbose and quiet
 options and helper functions
To:     dsterba@suse.cz,
        =?UTF-8?Q?Antonio_P=c3=a9rez?= <aperez@skarcha.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20191030084122.29745-1-anand.jain@oracle.com>
 <20191030084122.29745-5-anand.jain@oracle.com>
 <CAMhy=vK7HcCHs2JxQUQ5Fyz1CFuAp7erm_2v5ZYY4Ud+BRczZg@mail.gmail.com>
 <20191101101254.GH3001@suse.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <296b7d30-e37c-aa25-3efd-51df77987f35@oracle.com>
Date:   Sat, 2 Nov 2019 09:15:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191101101254.GH3001@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9428 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911020033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9428 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911020033
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/1/19 6:12 PM, David Sterba wrote:
> On Fri, Nov 01, 2019 at 10:46:42AM +0100, Antonio Pérez wrote:
>> On Wed, Oct 30, 2019 at 9:41 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>> +#define HELPINFO_INSERT_QUITE                                                  \
>>
>> Typo?
> 
> Yes it's a typo, should be 'quiet'.
> 

err. Thanks.
Will update.
