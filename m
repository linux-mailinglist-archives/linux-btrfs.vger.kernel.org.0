Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23E434392
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 04:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhJTCmk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 22:42:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53018 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhJTCmj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 22:42:39 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K2YDEK024884;
        Wed, 20 Oct 2021 02:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cU9yFX7oPA4DC3R4FeCfern1IrKbyin01FVwXaQKKNw=;
 b=duQMuxL56HtwQFx6PkGEdzqldz7MRaH11GeNGFA0egD+sd4XvA8c2iFjEwe5q2Aq1QiG
 4LhurUQUGcmEu4U+kjL9ojCNzK8i0i3QfQTFhJYtmV8y7ACbd6pHrI1VwPH8gkzo14MO
 T/WVs5axfickbRT9nEi03/8za8ir7c1hXmWs/eBmWgFgbpdfpKW755/R/f0RIfrRBujs
 +cQdHSQSa0WdIUp+0n8We9k6ukt/PAh4IhLGyCc69BTmyrrZo3Oq3u7jlul0L0EYM5Cj
 +sNYYtTbGOQkYYOsamrwKROoM8b5XQ11FTgje6pYKv0Y0IB7TehPXCEeWmELelx+YMPt 4Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsn7kpdb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 02:40:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19K2aoiG019345;
        Wed, 20 Oct 2021 02:40:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3bqmsfqqxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 02:40:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/JSNueb+w0+9SU4pm87kDnv5R0BDMi9PpN6u5ocOirmhSMUdsMzhEss2tdBJN6csptEvsejSWj/QksIJw9VJGwEocMtvBMhXiaISGE2D0x9//6u1XpC4HwfHaam35r0wnwXK/aSxlLf/IqerNgIbJaknsDHpWPL9fr2Gle8ylS5RNOwDKWqsbWETVlpgSOlF7itNjZbhCchaPa3sHv8+uVycrP2hr+6W0PQ8PS6ZpXyhwLGLQPXXnaYvDpHr1g4SdhkqswroEs3xg51gpZ896TLtNJwfr36MlQ8UfUYFDcTkPhmW40UzUaI5ygQkjcEVFBc+NnCWzBAAhbAqlzy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU9yFX7oPA4DC3R4FeCfern1IrKbyin01FVwXaQKKNw=;
 b=jTLhLo3Kv7McSL0WO6nLcFrdbeNjrUa5rCXDebeNCzQqiK9YUcZz25RLF50wejjx5CQJaMDNuUVQMkcoMnnvF0AWNF+g2NEX5tLqfgHjZVUAZISvHUxe0ydyameH5im40+7lNFSqjYXIy3FPoZ1nq/40rdA6mPAu9Vk08ktq1dP6NA1IgMvJwCo3KbXvLedm9R1imOzOjtzDtwRPFDnjTC++12RFbKGNFXYfBi5I6iG96jC2PDvd9t/D88n9lQfQ5bPORTrqemibBuRqBUPilS116Oen1o/u/7wVfPxfDHGxTa+7IkRKPc0eR1Vqo2dTvpo+YTpTVOkE2XTmUeE5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU9yFX7oPA4DC3R4FeCfern1IrKbyin01FVwXaQKKNw=;
 b=cDipVJKK1tF1AmLRIrc/AH2d3U7wa2gpLbv7fwxsUVT1laJiXdMYo15snut+vRlDUc+Jby/k+ahPF55ppagF17+LJy96QC2hrFh3XStNoe4wZlv+rJK2UHqi94xuEOmciIcvGIbexGqAiqUOO8QHwRw4jq5e/jLPD9bNOhgLPXQ=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3840.namprd10.prod.outlook.com (2603:10b6:208:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 02:40:21 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 02:40:21 +0000
Message-ID: <61915dee-0878-a170-87d5-a3d611af6810@oracle.com>
Date:   Wed, 20 Oct 2021 10:40:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] btrfs-progs: read fsid from the sysfs in
 device_is_seed
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1634598659.git.anand.jain@oracle.com>
 <873d173c3b16fcd027dba4b10690e3e3fc3b6cdd.1634598659.git.anand.jain@oracle.com>
 <YW7QJUNHU9Eo/wZp@localhost.localdomain>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <YW7QJUNHU9Eo/wZp@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR02CA0010.apcprd02.prod.outlook.com (2603:1096:4:194::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Wed, 20 Oct 2021 02:40:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2604b226-50c4-463b-4136-08d99372f5f8
X-MS-TrafficTypeDiagnostic: MN2PR10MB3840:
X-Microsoft-Antispam-PRVS: <MN2PR10MB384071E3A3E78323BADB8AF3E5BE9@MN2PR10MB3840.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DR5QmNtOrGkSczDmNXxLNlgRNMNvaseNQk3GBpndRtzPA3KjXAa7Fi5Fccja6K+cE+CEcNkcx1nk6Ade6skMkudU6VEQkqAUYSsnw723lEPyRgPF/M0ZA1IHX+5OKtb3PH9IOiGtuCQ1GGQW1CgD4QEYA6/xKz7svtnk3VVTgsqNXzbPL8gjkRCeUlPKGaH8p9haba4/1pvbxbL698Lwe0mXFWVdx39JocRkeL9GEHyEBhtl+Z4YxqiJdeLOW2EzrsW7M0UXZxcBTRp724g54mi8M+KYY0LLodsvA5CJDwgkpFxPDVIPetmrDX8krPTR/HtqyyP6yR3tIw7PqE6VUkFvlch5NZGRs5hCaAGvxTAH9gwpvsMKpsMOQFRFQsDbBew+zkhjJf8pErP1Pa3jfggS48EH3eNjivXHY+q9KEhNX0Hr7hsmQBl7rCuIAyWDknflgKLXHctIEJHQJrKhu1Le8za05tpUWlzrHwc4vjrrtWzsUfBErM1yGagGC54JVoW+0Sp2MncherhNdDNs8JpKrif0AKpOt2exHnlWWmTi+6NUM+l+YZoV5FcjZxYJstpi3RA9orNB0d9RFMtXsHrBTevi5NsnRk1zojMkCDI8KN3pDY+WRoEi9dIJ13Lemt8lG+ok/bXEPgauUUuDzRkWUwdEI25J05kvNXPA3WnmEdDnuThPRAk+zqRy0AGVx/HbLELFRLe3fMGLFdXbsqIE5oMugidLniouIJhMt+3gzTxVy0I5Qag+EpevnzM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(31696002)(31686004)(186003)(956004)(6916009)(508600001)(26005)(83380400001)(66476007)(16576012)(66556008)(2906002)(2616005)(316002)(8936002)(66946007)(36756003)(38100700002)(53546011)(8676002)(6666004)(86362001)(6486002)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU94empxVGJRaVJXZUw1RGYxejhWeWsyNzVKeGhxZ2JQU0pCVEcwTmRIZmVz?=
 =?utf-8?B?alI2VkR1S3Q2eW1mS0NpeXdNZXhWbnhhNllWSWRQY3QwNmFvKzYzbVhaVlZi?=
 =?utf-8?B?L3dmZlpGQUVpSXRuVkdteGpjVGFMNTd5dlk3MHF1KzduZ1BxZzJyOE9BVWw2?=
 =?utf-8?B?dExKaFBZVzQ1eUk1Nk16dWZMTXh1bzlZUklNSlROSWMwdW1uQUQvc2ZXK0s4?=
 =?utf-8?B?RUZINHRiN2EzMlJ0ODJjM0ptcnZIOFI5S3BsZXN6ZCtOd2dWWUdTOG1xQkFw?=
 =?utf-8?B?VGxoUU8xY2NDUEJqeHdadkYzWElvVHZRdlpWeTJPcStnWHBtSjVYeC8vc0R6?=
 =?utf-8?B?c2JYNHBqNGU2aWNCdHgxWFA2Skk2Z1R2cjBJY29EMDVOL0JzZGV4SW1jVno5?=
 =?utf-8?B?dm5EWUFkaHRBNFJ2OHZZY1ZJVTN5akRVTnZ1OTJtdytPUkNVeDRyWHF2Nndq?=
 =?utf-8?B?Z0JOaXhWUmhYc1M1aWJWekFnYTBKaldTS2NGdUZlR3hmc1I5T2JFSTdNUGph?=
 =?utf-8?B?ejQ4czg2WlBxSXNUbjRUYmF1OFIyS2RyaDA0Y09kdi9CRStyNFpxMi85S1Z6?=
 =?utf-8?B?YTR3SXZFSGRvd0FIQ2UyQzR4YkNaY1N6VGZlSlBPUnkwdUoyb3p4SVlJU2F2?=
 =?utf-8?B?MGp1T0xFZythK3gxVzlvMmZSSzdPbFJDaWRtS1NnNllvOWM0dU5Hd2hzdGdP?=
 =?utf-8?B?M3F1SExOS0FDREpDYWFLZkVyLzZqYTg5RDVlQVV5WnRQeG1PMmN4RVoxSCs0?=
 =?utf-8?B?SkRVSFZOSmNmekRmeUNVZHZId3RMaDhRYzVQTE9NMWVuc0tueS9HODJ4ZThZ?=
 =?utf-8?B?enFROTFPZEVZWGV5MGcrZm52dWZ3c3pCdVJVUHlJb1ZydVByQW9Tc2lUVmxZ?=
 =?utf-8?B?QTc2QVBpdklSUnJnY0RaNnc5Q3ZqYUl1bmdMT05VN2pzeXZzNDZMMzhsenlD?=
 =?utf-8?B?bm5iTlQrVGJ2d05XUHlhTTVpNkJkM25QMmZ3RkdRWE5rYU5kNU1BdEp2aE9N?=
 =?utf-8?B?YTdTWWNtM21wQzhmbDVJWHV1NGdYcWFLUTRiV3MzRm40SGhTNklETW5RT3Na?=
 =?utf-8?B?b25VSytKODR2QU14N2dtemVWYlRManNQbU9PNndJYnZ3WlZzNkozb3NSZFR6?=
 =?utf-8?B?TFNhWEpleS9rVVF5THJ5a1VFM2tlUlREUldFamRoenlRREdrN1AyTUtTWUdD?=
 =?utf-8?B?bFZKSXpsOFVlZndjQmRsT0ZEc2xmRG5qZmVjYnVNZTJPalNKSElXNXRzRGl4?=
 =?utf-8?B?ZjhSdXlJMmwyTzhJb0NpeEUwZTcxU0Foa2NTSkxvZzRSaXQrTUxZdktYTFVk?=
 =?utf-8?B?Q0hSUWQyVGVrUno1ZzNoSGFMbTZvRXpVRTRzMHpQekVWcU9POVI5aDBqMXNX?=
 =?utf-8?B?M1Z0N0NJckx0TzR6R2thWC9UNUhENDVuR20yYUFiR2N0V00vaFJheHZuaUVz?=
 =?utf-8?B?YXFPVlF5Ymt5UE4yZ2hWZDA5NytzRE0weHNYQU9udFNZS3BsKyt1d2Uva2pB?=
 =?utf-8?B?Z01YV0JMN1c1cGlDUHlBaUI1YkMvblNLSU92U0c2UktCRTJBZk4wVHlpbjVj?=
 =?utf-8?B?ODgraVhsTk15OTQxOFoydG45ZnhpejRrZW9MMjh2U05MQWpXNE5Rd3VGY3lZ?=
 =?utf-8?B?aFRNTjR6dFVVSThPNk8yclRMbWFTWUdmSXFsMEtXdGhpVmpkN3J4azhTLzJi?=
 =?utf-8?B?amxaWmVMeXhxZTRDRWYvYmN5YkQ1RElTNXZIeFEwSXdlNFk5UzVVMFZBMG9F?=
 =?utf-8?Q?RjBZMG5NmIyNeedhCIYET4jeH5AmDBH3C9Yfqki?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2604b226-50c4-463b-4136-08d99372f5f8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 02:40:21.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3840
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200009
X-Proofpoint-ORIG-GUID: GwTNZVPvEG1bfnPr-DN50cE14TktzmC0
X-Proofpoint-GUID: GwTNZVPvEG1bfnPr-DN50cE14TktzmC0
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19/10/2021 22:03, Josef Bacik wrote:
> On Tue, Oct 19, 2021 at 08:23:45AM +0800, Anand Jain wrote:
>> The kernel patch [1] added a sysfs interface to read the device fsid from
>> the kernel, which is a better way to know the fsid of the device (rather
>> than reading the superblock). It also works if in case the device is
>> missing. Furthermore, the sysfs interface is readable from the non-root
>> user.
>>
>> So use this new sysfs interface here to read the fsid.
>>
>> [1]
>> btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   cmds/filesystem-usage.c | 38 ++++++++++++++++++++++++++++++--------
>>   1 file changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
>> index 0dfc798e8dcc..f658c27b9609 100644
>> --- a/cmds/filesystem-usage.c
>> +++ b/cmds/filesystem-usage.c
>> @@ -40,6 +40,7 @@
>>   #include "common/help.h"
>>   #include "common/device-utils.h"
>>   #include "common/open-utils.h"
>> +#include "common/path-utils.h"
>>   
>>   /*
>>    * Add the chunk info to the chunk_info list
>> @@ -706,14 +707,33 @@ out:
>>   	return ret;
>>   }
>>   
>> -static int device_is_seed(const char *dev_path, u8 *mnt_fsid)
>> +static int device_is_seed(int fd, const char *dev_path, u64 devid, u8 *mnt_fsid)
>>   {
>> +	char fsidparse[BTRFS_UUID_UNPARSED_SIZE];
>> +	char fsid_path[PATH_MAX];
>> +	char devid_str[20];
>>   	uuid_t fsid;
>> -	int ret;
>> +	int ret = -1;
>> +	int sysfs_fd;
>> +
>> +	snprintf(devid_str, 20, "%llu", devid);
>> +	/* devinfo/<devid>/fsid */
>> +	path_cat3_out(fsid_path, "devinfo", devid_str, "fsid");
>> +
>> +	/* /sys/fs/btrfs/<fsid>/devinfo/<devid>/fsid */
>> +	sysfs_fd = sysfs_open_fsid_file(fd, fsid_path);
>> +	if (sysfs_fd >= 0) {
>> +		sysfs_read_file(sysfs_fd, fsidparse, BTRFS_UUID_UNPARSED_SIZE);
>> +		fsidparse[BTRFS_UUID_UNPARSED_SIZE - 1] = 0;
>> +		ret = uuid_parse(fsidparse, fsid);
>> +		close(sysfs_fd);
>> +	}
>>   
>> -	ret = dev_to_fsid(dev_path, fsid);
> 
> Why not just have dev_to_fsid() use the sysfs thing so all callers can benefit
> from it, and then have it fall back to the reading of the super block?  Thanks,

If we are using sysfs to read fsid it means the device is mounted.

cmd_filesystem_show() uses dev_to_fsid() only if the device is 
unmounted. So we can't use fsid by sysfs here.

There is no other user of dev_to_fsid().

Thanks, Anand

> 
> Josef
> 
