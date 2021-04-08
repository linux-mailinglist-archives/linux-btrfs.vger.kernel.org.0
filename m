Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED54F358179
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 13:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhDHLQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 07:16:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230322AbhDHLQL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Apr 2021 07:16:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138B4JkJ080101;
        Thu, 8 Apr 2021 07:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=x/9irr/XndPno8Kd/qXxbVNeDaWo+EKVrZIHwb7msZ0=;
 b=AzYW8RXS3C5KaZMCC6Vwf3ORhB62tThP5h/pYP14pNsHIY4bQYgwjDqbd4eR7iZb8iDt
 Q56/GDrhTJ9qoyudn8VrmiJD+LMDA59Nog3+eWZrHjfKHmYkKIwget1rMP/YZ0AXDP7H
 FV9D6T0SuZa/qxBF1WYacgoNPDS2xzm9of0HKbqbvl3Dd8MArbxLDUYzQsJL3npgSupM
 2kP/R4buwcvYXgt8xWRrTWDQJInWqtX9+jHswIemakFTAMwEvRlcrZ6eTHMHIsAY1/Zv
 jX1cI06ayI4WZq4tSG6oRGE2C1JrhHzrwuy1vz0snUcIVd1V587IuHIWO//IVMOt4lmz aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37rvy84qfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 07:15:58 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 138B4JEX080146;
        Thu, 8 Apr 2021 07:15:58 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37rvy84qet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 07:15:57 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 138BBPuq012613;
        Thu, 8 Apr 2021 11:15:56 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 37rvbu9h4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 11:15:56 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 138BFrOc39911920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 11:15:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7D6DA405F;
        Thu,  8 Apr 2021 11:15:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 856FCA405B;
        Thu,  8 Apr 2021 11:15:53 +0000 (GMT)
Received: from localhost (unknown [9.85.70.102])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Apr 2021 11:15:53 +0000 (GMT)
Date:   Thu, 8 Apr 2021 16:45:52 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Joe Hermaszewski <joe@monoid.al>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs crash on armv7
Message-ID: <20210408111552.tyevdsqlxhsmnt3g@riteshh-domain>
References: <CA+4cVr95GJvSPuMDmACe6kiZEBvArWcBFkLL8Q1HsOV8DRkUHQ@mail.gmail.com>
 <1f5cf01f-0f5e-8691-541d-efb763919577@gmx.com>
 <CA+4cVr8XEJwyccvAhfgJUZyTcjubkava_1h+9+3BggN6XpH3iA@mail.gmail.com>
 <c8e82fcd-de9d-d46f-e455-1d0542fda706@gmx.com>
 <CA+4cVr-gg89KovFG+Yso0iYjhPjnx3eMNK8qG6W1SLY2WkozdA@mail.gmail.com>
 <8315aaf6-26e9-ad0a-cc49-1a1269266485@gmx.com>
 <CA+4cVr9nWjnNbWNctd4vZaoeyqFTyG1DCSTYbrbC4A27XtDG2Q@mail.gmail.com>
 <f8a63ef3-9eaa-f5ea-e403-be81ffcf7c85@gmx.com>
 <CA+4cVr82ujZrdsmjpUPBg3W2xL4gQJwjGwvA2LTy-yj73BhGfg@mail.gmail.com>
 <d7b26dfa-d40b-43e5-07e3-67d5377f84c2@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7b26dfa-d40b-43e5-07e3-67d5377f84c2@gmx.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ddv6BQMqlBZ216OHlibYVcH0Ovw5XGSQ
X-Proofpoint-ORIG-GUID: Tq_Bg5RPEmGPTcoNxtPLJtMqWdbry9Qc
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_02:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080075
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Please excuse my silly queries here.

On 21/04/08 04:38PM, Qu Wenruo wrote:
>
>
> On 2021/4/8 下午4:16, Joe Hermaszewski wrote:
> > It took a while but I managed to get hold of another one of these
> > arm32 boards. Very disappointingly this exact "bitflip" is still
> > present (log enclosed).
>
> Yeah, we got to the conclusion it's not bitflip, but completely 32bit
> limit on armv7.
>
> For ARMv7, it's a 32bit system, where unsigned long is only 32bit.
>
> This means, things like page->index is only 32bit long, and for 4K page
> size, it also means all filesystems (not only btrfs) can only utilize at
> most 16T bytes.
>
> But there is pitfall for btrfs, btrfs uses its internal address space
> for its meatadata, and the address space is U64.

Can you pls point me to the code you are referring here?
So IIUC, you mean since page->index can hold a value which can be upto 32bit in
size so the maximum FS address range which can be accessed is 16T.
This should be true in general for any FS no?

>
> And furthermore, for btrfs it can have metadata at bytenr way larger
> than the total device size.

Is this because of multi-device support?

> This is possible because btrfs maps part of its address space to real
> disks, thus it can have bytenr way larger than device size.

Please a code pointing to that will help me understand this better.
Thanks.

>
> But this brings to a problem, 32bit Linux can only handle 16T, but in
> your case, some of your metadata is already beyond 16T in btrfs address
> space.

Sorry I am not much aware of the history. Was this disk mkfs on 64-bit system
and then connected to a 32bit board?

This also brings me to check with you about other filesystems.
See the capacity section from below wiki[1]. Depending upon the host OS
limitation on the max size of the filesystem may vary right?

[1] https://en.wikipedia.org/wiki/XFS

-ritesh

>
> Then a lot of things are going to be wrong.
>
> I have submitted a patch to do extra check, at least allowing user to
> know this is the limit of 32bit:
> https://patchwork.kernel.org/project/linux-btrfs/patch/20210225011814.24009-1-wqu@suse.com/
>
> Unfortunately, this will not help existing fs though.
>
