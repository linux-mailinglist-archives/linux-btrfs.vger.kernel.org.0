Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB7120F7A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2019 17:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfLPQb2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Dec 2019 11:31:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbfLPQb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Dec 2019 11:31:28 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBGGSEOW041449;
        Mon, 16 Dec 2019 11:31:18 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wwdpykqc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 11:31:18 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBGGV7DK031265;
        Mon, 16 Dec 2019 16:31:17 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 2wvqc69ta1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 16:31:17 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBGGVFTL54657466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 16:31:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9E93B205F;
        Mon, 16 Dec 2019 16:31:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 691C0B2066;
        Mon, 16 Dec 2019 16:31:14 +0000 (GMT)
Received: from [9.152.96.21] (unknown [9.152.96.21])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon, 16 Dec 2019 16:31:14 +0000 (GMT)
Subject: Re: [PATCH v2 6/6] btrfs: Use larger zlib buffer for s390 hardware
 compression
To:     dsterba@suse.cz, Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191209152948.37080-1-zaslonko@linux.ibm.com>
 <20191209152948.37080-7-zaslonko@linux.ibm.com>
 <97b3a11d-2e52-c710-ee25-157e562eb3d0@linux.ibm.com>
 <20191213173526.GC3929@twin.jikos.cz>
Cc:     "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>
From:   Zaslonko Mikhail <zaslonko@linux.ibm.com>
Message-ID: <9068869f-1ec2-f8c1-c2e2-4d38e62572cf@linux.ibm.com>
Date:   Mon, 16 Dec 2019 17:31:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213173526.GC3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_06:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912160145
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

On 13.12.2019 18:35, David Sterba wrote:
> On Fri, Dec 13, 2019 at 05:10:10PM +0100, Zaslonko Mikhail wrote:
>> Hello,
>>
>> Could you please review the patch for btrfs below.
>>
>> Apart from falling back to 1 page, I have set the condition to allocate 
>> 4-pages zlib workspace buffer only if s390 Deflate-Conversion facility
>> is installed and enabled. Thus, it will take effect on s390 architecture
>> only.
>>
>> Currently in zlib_compress_pages() I always copy input pages to the workspace
>> buffer prior to zlib_deflate call. Would that make sense, to pass the page
>> itself, as before, based on the workspace buf_size (for 1-page buffer)?
> 
> Doesn't the copy back and forth kill the improvements brought by the
> hw supported decompression?

Well, I'm not sure how to avoid this copy step here. As far as I understand
the input data in btrfs_compress_pages() doesn't always represent continuous 
pages, so I copy input pages to a continuous buffer prior to a compression call.   
But even with this memcpy in place, the hw supported compression shows
significant improvements.
What I can definitely do is to skip the copy if no s390 hardware compression
support enabled.

> 
>> As for calling zlib_deflate with Z_FINISH flush parameter in a loop until
>> Z_STREAM_END is returned, that comes in agreement with the zlib manual.
> 
> The concerns are about zlib stream that take 4 pages on input and on the
> decompression side only 1 page is available for the output. Ie. as if
> the filesystem was created on s390 with dflcc then opened on x86 host.

I'm not sure I fully understand the concern here. If we talk of backward 
compatibility, I do not see side effects of using larger buffers. Data in 
the compressed state might differ indeed, but it will sill conform to zlib
standard and thus can be decompressed. The smaller out buffer would just 
take more zlib calls to flush the output.


> The zlib_deflate(Z_FINISH) happens on the compresission side.
> 
