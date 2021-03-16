Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA6733CA44
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 01:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhCPAKs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 20:10:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47820 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCPAKj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 20:10:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12G05q2K182790;
        Tue, 16 Mar 2021 00:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OUa5WfeFG0bfd1P35IZXfobJ486Kgk2sRWieqKqtqN4=;
 b=G+iIwLVk1lIQje/eCL52q0iAPvmcVkB9oitHDiXo6b6fttk4KOliNeUIHKUCf6i0L0gg
 EaLdp6+t3DmBC6VrYqquzFIX+WfcGLRsVWTd31fPy39hInIFz5U2S2ol+jlZRO1OfgJM
 EUB0/N3MnGQTahgErDq1GQZ1oWI15NFicFs4K8YCACa1rul7M+IrzhyzDYppH7509LHv
 tgIOoxTNJ6eSY5ELwWaza4NZ4KonLrgvpHf4lnL3U6BTM20ogmYNWjwEfHjIDXcNpbBL
 kkGRgv+YyQlKE9SrqHQ40itJcYzn2Vgp/8zFUebXeI5LXEnFpRfecbGmzp3/kIoVS4ga Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 378nbm5w1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 00:10:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12G05BOG011936;
        Tue, 16 Mar 2021 00:10:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by userp3020.oracle.com with ESMTP id 37a4es7cgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 00:10:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP5YPM+tq75sLBpINnWD7CeoC3RCTTV1+3xl1ciCnhFDXUVJG+nYZ3qznYCZT7NFaQe0wEbytEwguHLSNBbZ8u20iBf7NDkfN8GEar1K+8VfVPtYjVHVtLaiBM8e4W7HS3KWbZ5aWSD/WkkL/JR2SXsnW1KQhfzMyfyjCQ63VErIFjpZJdzIteMyGPXExKTtbJl3DXw0y4Ga31CkXEnHxUPqiBExRkzYtjpZ5vw16g72kr8rO0OyaV6/NpcR+VNm2Z1kFVeNJbohT6AsEBxSM428tZ2OOuYknmfwZN3NrhECp2ijjufdkJcCG8qbI/S6pGyMGB8e4C04EBsVJUzWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUa5WfeFG0bfd1P35IZXfobJ486Kgk2sRWieqKqtqN4=;
 b=ltsIs7wOzzSid9BIjlhc+CN3ONzorwXT7kPZhyadyqm/dERkGFFS9I7yppYZvSHYt8zc/GQIxMcSNkgEQ6uGELX9NOa/MZY5g25dSsvUyDJ8fjRx2C5n2iJa7viejOrEZHc0DCaLuujD0Ln98KCtjhGPK+NUqP66V62L+/LHMJMZj9lev92kw4bm6K7tlhZQrLgWj0ndav8hjPxibZeNKAjDNsYW6ZABHUOA2D72EL0TvesGV9ekBz8qCL0cNswkd7O/oqmg2nxeAZJ3d29ioq+GiV0IrKl7iRhpR4RTr82EDqWdemZl2qEQ1MXYivVG1TVKMfpTPRfjUnVfLluPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUa5WfeFG0bfd1P35IZXfobJ486Kgk2sRWieqKqtqN4=;
 b=lXUcTAlCvB92Um3V+jYh2H5ATm+/6mVs1kJX+1wncqbvSXsCxmlJ+fOsKTqxbUOAmfdfHHk7OhbA82aAK60+AXiekAmn6O8FwyxgZvWjVw3cJFm+tPmer0S2/YEPheBl3iyD53HS9dZ1jIU1A7lr5ocsZgUn1ptJEAmlVmaKePU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4078.namprd10.prod.outlook.com (2603:10b6:208:180::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 00:10:26 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 00:10:26 +0000
Subject: Re: [PATCH v2 01/15] btrfs: add sysfs interface for supported
 sectorsize
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210310090833.105015-1-wqu@suse.com>
 <20210310090833.105015-2-wqu@suse.com>
 <61c2ba18-c3de-a67f-046f-1f315500c8c8@oracle.com>
 <59a9ee34-1893-a642-2a00-8cc42ec7a31f@gmx.com>
 <20210315184414.GZ7604@twin.jikos.cz>
 <57e0fbcc-a8db-a821-5948-fb048f426dc8@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <82e16fe9-cf79-fb5e-2863-d9f6cc73adbc@oracle.com>
Date:   Tue, 16 Mar 2021 08:10:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <57e0fbcc-a8db-a821-5948-fb048f426dc8@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2406:3003:2006:2288:a177:93a9:ccfb:d353]
X-ClientProxiedBy: SGAP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::36)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:a177:93a9:ccfb:d353] (2406:3003:2006:2288:a177:93a9:ccfb:d353) by SGAP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 00:10:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b84e0eb1-c5ac-4e60-eb57-08d8e80fe678
X-MS-TrafficTypeDiagnostic: MN2PR10MB4078:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4078253C5C2015129E1CB427E56B9@MN2PR10MB4078.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDdP/4aeEeDx8LXe2pFR6BAK1aS/HXr/kCYLo6nsaPiljvxYNiVSnw6eTztDOQ0ZEXDYms/+aJ4NWSWwSzqJkEIQYhyvoc8dm0q0Ty6lSCL4D2if+TR8fmHpzlo/imtBqzCt05iqKz9kfJ0AC4Xjf9DDJmX1FChERCgyUQa0E2SHg0fwUaYeKwjnS2YXjQkmrLhYArScuNRzbHnovhJ49DVpXBCVtK9u+GLSov/MFtXGssG8nNPGikpGmFPhtl86SepfFighg5H3f2nutO+AogUBJxiiHa2Vz7Lg89sT6KRO4NV5q0M7y8cBoVuwF1a3LGm074/Ne18zQxYGVC5YzZs1AO3EOrHdnyaDt4Mo0PJaZyoO66DuVBZ74ql3MUkSsxdcLVOKbVoCx0HublxnS+Wd0Lo+GrY06PxrTDnq6kVbMAqyrXEi+55hGsmfXZFjHmUJGt+719+KyD1DDLH5AjB+JKeYhV+6l8dbCT7Z2FqMWXQ2uOjNxn4v1T4wdOAFikxevLPFVUbcsqcuSvBA4V+ZUuqlwZAXTQlnM9A7/fKqXS1Nqmk8v5+56VlwS1JuktRBcO0sXJ83Hio3EMyajE96E6Jywb2mgjmQt7vbdyYOH5KqB9y87u02F/2uw97mMJFarck00JK1VHVvOe1IOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(346002)(376002)(136003)(478600001)(16526019)(66556008)(6666004)(31686004)(86362001)(31696002)(66476007)(66946007)(2906002)(2616005)(8676002)(36756003)(6486002)(8936002)(110136005)(5660300002)(83380400001)(316002)(44832011)(186003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: o2EyXZYfOZLpJbFPWX8qixhekExGCCgfI3ZfkoX8QxFlEzOZ8hIiILxG9ClyBjZP6bqM6rOzXXui/QzXvQ9/CuLCfvFx9I20D0Yf6atAO3S/x2bKSyOLBAzcsCjIEtj0YnzfdrMNFp6mZvFI7DoA0dyoxTBYhnIfV5BDcM5CO0y8+/RtZF1GmsAP2bvZyUp5ZH6S8I338P++s+jVi382NzDwQa5tccHhxMN3QodBdpV5J02PbkVOGKM8OgnmghLzSfMNtkkp+CIBi4WquX84dT8utKCHM0RE502uTuYIRyOk+7ycKA9OlZJztTDTUNY1rtmIYHjY4O3lpkrHY+buRpdZ7aOZ0GUidhdH21qcyjO1y8z5m05ME0Sw3lsGO+mkHfzIgQUOuDiGkk+LnqHl/6VgaQlO9N3TOtUCQkBNUU16nclTwAuRlCKFLZLrSvmLcqu6aFvfjVd6VrUfN9h2Qpz5DqN2jH4z0p5hDU88ji0+WSUVJzA3igXqB0hj5z7gOx6lYez0dSMTNycy6LXzrcGWaMJW0m1CxJ4T6kDxtjuPgH04POuTmINyZa0Soqs4+6td9wsQ1bZFApRj8t+1WpYhUaDsLC8wQc/fv84fkkKZXCE1ToiH3ULxFanm2JEj4EqJxIiZpb0+QDHe9/75+Ql9VaSFuwWFQ+b1/szogkqmzyXzJx1A4w9QUW/6JYncMHH2vIecR15VZyy4J2f8vX2x7Ym7Oa+Rb8WzRkMXVi65Inx/ddOvx0kP5Dpl6/gbg0bq97f2hR0fdVE9lXiZPuKTRPzUwa+Ir1vAGn90nL/NUXIm8FcLEvM54VoOJAwX
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84e0eb1-c5ac-4e60-eb57-08d8e80fe678
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 00:10:26.4869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvJWopjXTiVPvZb9t8DLchninONlOdIZykAYxfWL3iGosa5Y+6DOUoWBPTtU4165u0c38vvHgRsWEDPNjY5xlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4078
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150165
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150165
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16/03/2021 08:05, Qu Wenruo wrote:
> 
> 
> On 2021/3/16 上午2:44, David Sterba wrote:
>> On Mon, Mar 15, 2021 at 08:39:31PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/3/15 下午7:59, Anand Jain wrote:
>>>> On 10/03/2021 17:08, Qu Wenruo wrote:
>>>>> Add extra sysfs interface features/supported_ro_sectorsize and
>>>>> features/supported_rw_sectorsize to indicate subpage support.
>>>>>
>>>>> Currently for supported_rw_sectorsize all architectures only have 
>>>>> their
>>>>> PAGE_SIZE listed.
>>>>>
>>>>> While for supported_ro_sectorsize, for systems with 64K page size, 4K
>>>>> sectorsize is also supported.
>>>>>
>>>>> This new sysfs interface would help mkfs.btrfs to do more accurate
>>>>> warning.
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>
>>>> Changes looks good. Nit below...
>>>> And maybe it is a good idea to wait for other comments before reroll.
>>>>
>>>>>    fs/btrfs/sysfs.c | 34 ++++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 34 insertions(+)
>>>>>
>>>>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>>>>> index 6eb1c50fa98c..3ef419899472 100644
>>>>> --- a/fs/btrfs/sysfs.c
>>>>> +++ b/fs/btrfs/sysfs.c
>>>>> @@ -360,11 +360,45 @@ static ssize_t
>>>>> supported_rescue_options_show(struct kobject *kobj,
>>>>>    BTRFS_ATTR(static_feature, supported_rescue_options,
>>>>>           supported_rescue_options_show);
>>>>> +static ssize_t supported_ro_sectorsize_show(struct kobject *kobj,
>>>>> +                        struct kobj_attribute *a,
>>>>> +                        char *buf)
>>>>> +{
>>>>> +    ssize_t ret = 0;
>>>>> +    int i = 0;
>>>>
>>>>    Drop variable i, as ret can be used instead of 'i'.
>>>>
>>>>> +
>>>>> +    /* For 64K page size, 4K sector size is supported */
>>>>> +    if (PAGE_SIZE == SZ_64K) {
>>>>> +        ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%u", SZ_4K);
>>>>> +        i++;
>>>>> +    }
>>>>> +    /* Other than above subpage, only support PAGE_SIZE as sectorsize
>>>>> yet */
>>>>> +    ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%lu\n",
>>>>
>>>>> +             (i ? " " : ""), PAGE_SIZE);
>>>>                             ^ret
>>>>
>>>>> +    return ret;
>>>>> +}
>>>>> +BTRFS_ATTR(static_feature, supported_ro_sectorsize,
>>>>> +       supported_ro_sectorsize_show);
>>>>> +
>>>>> +static ssize_t supported_rw_sectorsize_show(struct kobject *kobj,
>>>>> +                        struct kobj_attribute *a,
>>>>> +                        char *buf)
>>>>> +{
>>>>> +    ssize_t ret = 0;
>>>>> +
>>>>> +    /* Only PAGE_SIZE as sectorsize is supported */
>>>>> +    ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%lu\n", PAGE_SIZE);
>>>>> +    return ret;
>>>>> +}
>>>>> +BTRFS_ATTR(static_feature, supported_rw_sectorsize,
>>>>> +       supported_rw_sectorsize_show);
>>>>
>>>>    Why not merge supported_ro_sectorsize and supported_rw_sectorsize
>>>>    and show both in two lines...
>>>>    For example:
>>>>      cat supported_sectorsizes
>>>>      ro: 4096 65536
>>>>      rw: 65536
>>>
>>> If merged, btrfs-progs needs to do line number check before doing string
>>> matching.
>>
>> The sysfs files should do one value per file.
>>
>>> Although I doubt the usefulness for supported_ro_sectorsize, as the
>>> window for RO support without RW support should not be that large.
>>> (Current RW passes most generic test cases, and the remaining failures
>>> are very limited)
>>>
>>> Thus I can merged them into supported_sectorsize, and only report
>>> sectorsize we can do RW as supported.
>>
>> In that case one file with the list of supported values is a better
>> option. The main point is to have full RW support, until then it's
>> interesting only for developers and they know what to expect.
>>
> 
> Indeed only full RW support makes sense.
> 
  Makes sense to me.

> BTW, any comment on the file name? If no problem I would just use
> "supported_sectorsize" in next update.

  supported_sectorsizes (plural) is better IMO.

Thanks, Anand

> Although I hope the sysfs interface can be merged separately early, so
> that I can add the proper support in btrfs-progs.
> 
> Thanks,
> Qu
