Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1B721695E
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGGJpV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 05:45:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60382 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGGJpU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 05:45:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0679fi95055206;
        Tue, 7 Jul 2020 09:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lPDmOs9G5vevjPel3X5/bPLa1HRHxA2mzOzgSFCLfAo=;
 b=lONJ2KAduE6b2gDlkIdy7TG2XDIPe+ds92PvgYaDfYsLCL4D0JThq90UjwlgVv/kw9IW
 hQXgT+LAqCTUQxskO6ppt2nCD6/mqTQWzJLaa43IQ3162vslGBqglWryysLMLMWoyKOX
 +qU8k0oeilTEy7WQ1JKFDNZEf5ZbpHcyUxH1MegZoLERtYsXSFjmtGlBcZTY+uPUzjSR
 Ph2IyvpOLKw32qXkehmcNxlquzpWl6KuqFfsaJuHsLPIlnG6ga/euwYKZY7JfE5VvOSr
 X3ZQD0APVQU7FtA5kU3yT4Vd08Om+Ap3LMzxygNirZaBwIJ13Syw2rPQS6B7N5vL5Jhi ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 323wacf7hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 07 Jul 2020 09:45:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0679h2PU145803;
        Tue, 7 Jul 2020 09:43:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 324n4qvdw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jul 2020 09:43:14 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0679hDTM014960;
        Tue, 7 Jul 2020 09:43:13 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jul 2020 02:43:12 -0700
Subject: Re: FIEMAP ioctl gets "wrong" address for the extent
To:     dsterba@suse.cz,
        "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cfd1d2842b4840b99539f00c34dc5701@rs.bosch.com>
 <20200702114348.GJ27795@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <486ad3ac-a6f4-ef94-7dfc-1a58b6a7b747@oracle.com>
Date:   Tue, 7 Jul 2020 17:43:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702114348.GJ27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=958 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=936 adultscore=0 cotscore=-2147483648
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070074
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/7/20 7:43 pm, David Sterba wrote:
> On Thu, Jul 02, 2020 at 09:11:20AM +0000, Rebraca Dejan (BSOT/PJ-ES1-Bg) wrote:
>> Hi all,
>>
>> I'm collecting file extents for our application from BtrFs filesystem image.
>> I've noticed that for some files a get the "wrong" physical offset for
>> start of the extent. I verified it using hexdump of the filesystem
>> image: when dump the content starting from the address returned from
>> FIEMAP ioctl, I see that the content is absolutely different from the
>> content of the file itself. Also, the FIEMAP ioctl reports regular
>> extent, it is not inline.
> 
> There are 3 address spaces:
> 
> - device physical offsets
> - filesystem physical offsets
> - filesystem logical offsets
> 
> What you seem to expect is that device physical and filesystem physical
> and the same. This is not true in general in btrfs and fiemap will
> return only the filesystem offsets. To get to the device offsets you'd
> need to do the reverse mapping.

Do you think is it a good idea to rather update vfs? A quick check 
indicates struct fiemap_extent has reserved space to hold the devid, and 
should handle the backward compatibility issues.

struct fiemap_extent {
	__u64	fe_logical; /* logical offset in bytes for the start of
  * the extent */
	__u64	fe_physical; /* physical offset in bytes for the start
  * of the extent */
	__u64	fe_length; /* length in bytes for the extent */
	__u64	fe_reserved64[2];
	__u32	fe_flags; /* FIEMAP_EXTENT_* flags for this extent */
	__u32	fe_reserved[3];
};
