Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE57229AD22
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 14:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbgJ0NVt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 09:21:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56124 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbgJ0NVt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 09:21:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RDF1Vq032486;
        Tue, 27 Oct 2020 13:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=++kG6QTjozoOgaKltHVvb8po0NCkIQ+6d0VgBFMX2K8=;
 b=YTDNlvHIjfNpdrQu1ho2XexlMrUDJmPP8mX3CnWKQ1NrRyfAuJBNuHZ+Fr1VSBbB9JBI
 yH2SRdcR5HxbEtXTwGqDl49wn8hKoIbzTF+caNYL+AEnUBAk13uHdiijtY4tcrc1frOP
 TGBsS3eNN7PO/WO1oS9yxwooyjIaif3dm4Eu3+wN8i7//cpqM+TzyPAag3A52h+TGEFC
 LVwYO5UeSbQRuI69UHfX8RENRhoghDS2eUVMM0t5njQRo+P8hl/K7kw7MCNpO7xh4bMG
 MHhDPeozQfy9JSQV6JldeaQgdHCX9kyXhGwy8vlpPeW3iK2i858mZm68yT5r1Dn9jGZi Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34cc7ksv89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 13:21:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RDGH22194243;
        Tue, 27 Oct 2020 13:19:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34cx1qq8jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 13:19:38 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09RDJbbb025827;
        Tue, 27 Oct 2020 13:19:37 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 06:19:36 -0700
Subject: Re: [PATCH v9 1/3] btrfs: add btrfs_strmatch helper
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com
References: <cover.1603347462.git.anand.jain@oracle.com>
 <75264e50d49f3c68cc14dc87510c8f3767390dcf.1603347462.git.anand.jain@oracle.com>
 <20201026175228.GS6756@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d241d508-6c7e-1624-8f04-4c234bcd6c57@oracle.com>
Date:   Tue, 27 Oct 2020 21:19:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026175228.GS6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270083
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> +static int btrfs_strmatch(const char *given, const char *golden)
>> +{
>> +	size_t len = strlen(golden);
>> +	char *stripped;
>> +
>> +	/* strip leading whitespace */
> 
> This is confusing as it's not stripping the space but merely skipping
> it.  The arguments are not changed so you also don't need the separate
> variable and just update 'given'.

  ok let me update it.

> 
>> +	stripped = skip_spaces(given);
>> +
>> +	/* strip trailing whitespace */
>> +	if ((strncmp(stripped, golden, len) == 0) &&
>> +	    (strlen(skip_spaces(stripped + len)) == 0))
>> +		return 0;
> 
> This a bit hard to read but ok, essentially we can do the string
> comparison in a loop or use the library functions.
>

>> +
>> +	return -EINVAL;
> 
> This does not make sense as it's an error code while the function is a
> predicate, without error states.
> 

  A non zero value return will be some arbitrary number, is that OK?
  Or the return arg can be bool instead of int.

