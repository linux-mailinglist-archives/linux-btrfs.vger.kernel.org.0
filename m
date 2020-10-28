Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1915729E24D
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 03:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbgJ2CMZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 22:12:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45946 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgJ1VgZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:36:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SC55Wc136687;
        Wed, 28 Oct 2020 12:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3f8NAaZq9070x2DphUfx3HH/5T67COUGd9APGfKJakg=;
 b=j+2ftmNxgykWB94cTxmLulCIbcF9SmTqfT63NHitxkg8rKDUd1RLBl0s3jBP5Wjhljbj
 WdNiJebW8iUODjzqoSgC2d1H/9XnC2CJhpDED6rKdRUPPsO53EXQbRWRkzg11/kvIPjy
 ZLdLMz94jbKu0p608k8fplsurPzF+m5c5P0isbIB0snrABpe+nSlzF2+el9sKmb6Rehx
 ocZsX1t8/lDWfLm4iNx7LjZyPuyuRwLG3kBNpgclWShZ12XJSqT6g9VCCwyjHnSMBdbt
 knPbU1ZV/R8M7cr69T8BIusbMqOTwVPa6i+/Omn3AAgbJWVObLkfT0kozrNJWC3aXdiR ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34cc7ky1h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 12:06:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SC6KuT155792;
        Wed, 28 Oct 2020 12:06:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34cx1rwbcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 12:06:33 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09SC6VBs027451;
        Wed, 28 Oct 2020 12:06:32 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 05:06:31 -0700
Subject: Re: [PATCH v9 0/3] readmirror feature (read_policy sysfs and
 in-memory only approach)
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com
References: <cover.1603347462.git.anand.jain@oracle.com>
 <20201023170403.GM6756@twin.jikos.cz>
 <31c3da05-2238-da84-509e-3b29835ec33a@oracle.com>
 <20201027180233.GF6756@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c669ab96-82aa-bd41-756d-a7302f6c0963@oracle.com>
Date:   Wed, 28 Oct 2020 20:06:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027180233.GF6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280083
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/10/20 2:02 am, David Sterba wrote:
> On Tue, Oct 27, 2020 at 09:52:11AM +0800, Anand Jain wrote:
>>
>>
>> On 24/10/20 1:04 am, David Sterba wrote:
>>> On Thu, Oct 22, 2020 at 03:43:34PM +0800, Anand Jain wrote:
>>>> v9: C coding style fixes in 1/3 and 3/3
>>>
>>> So the point of adding the sysfs knobs is to allow testing various
>>> mirror selection strategies, what exactly was discussed in the past. Do
>>> you have patches for that as well? It does not need to be final and
>>> polished but at least give us something to test.
>>>
>>
>> Sure. I just sent out the patchset [1]. It provides read_policy:
>> latency, device, and round-robin.
>>
>> [1]
>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=371023
> 
> Exporting more information from the devices would help us to decide but
> is there anything we can do just with what we have? Or eventually add
> our counters like for the in-flight requests or total bytes. The
> intention is not to duplicate what block layer does as we need to
> experiment with the stats and heuristics it's just for that purpose and
> we don't have to rely on other subsystem patches.
> 

I could rewrote the latency patch without export of any new block layer 
functions. Patchset v1 will soon be sent to the ML. I hope that
shall address your concern.

Thanks, Anand
