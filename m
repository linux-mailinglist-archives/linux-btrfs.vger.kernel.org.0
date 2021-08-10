Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B083E7B85
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbhHJPB0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 11:01:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6874 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240996AbhHJPBZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 11:01:25 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17AEqOS9006344;
        Tue, 10 Aug 2021 15:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9xTZC8XvlbLZPFk83dpNAGvKOmEj2iidCtt+1zgWx4s=;
 b=NSMbMvgPyOEzu9Bsj5CHMNbarXbpuPZFDchPmonWFO5cfTgPsag0gZZayxZMsehaP8bO
 A3Fhs7gD9WkErGIt/7yOhW1ytBk5b4Zzpm0wn26x0yRZzJiKwxSfKMkdjCTYIu1553aZ
 AdLDfgWGWPmGN2g2cxXIBO3k7igM9TWSsMXONiVo97tk0InDWdSMUxHkGdUmU2BdRik7
 gdU4F/4y8Yzir3EXcoET5+j/K7oqBVa8laLlb8jeOhs1vGUmdBltuAKyfXmxyeVcPt9+
 4+HFpa53Xzu0aZi02/dk1QrTjGqA4xZRZImSpRXdvSZprlrMVUiJ19zHBkjASUZsITQ9 xQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9xTZC8XvlbLZPFk83dpNAGvKOmEj2iidCtt+1zgWx4s=;
 b=WZJR5iy2vDl0232l8bq777L+iK66t/7IUQc6R0n1LD3zHtyKy+BomekwwWPU09b8lvex
 +1BU5E9xwnOdjxEKAM69aMf6T1+Q1IjysSVp7EACXCxEFdhq9kIFHXLIApz85ek3iyAe
 AElxDAXVt+DaC/Mac3UbnXaOH0Q0Kw8rsTVe15F0pcgERzxATcwH/HQxvSyG+Mg1tEjQ
 hh0ULzfLvPRBaRYB1czP+FFVD3mLV6iPHWCwdNPt6qfrBFwkUv2J5Y/fDymgKZsaS6Lk
 aakG9RcqzgOCeN0mwYT62f7x1/ONNqHd5KYZTj7RIIJVQWnPnNYQ42iA3YFBVfqG+h3/ nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt448a0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 15:00:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17AF0Viu194602;
        Tue, 10 Aug 2021 15:00:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 3aa8qt815q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 15:00:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0abWbRWqosEO6k3Bw5B7zFmMnLiQMoTJBLBq1LRBVuOI2IzyL1xefrUZJeNmpFlrvJmsueeS5vwHk/j8y25+4n4frGxQkcTWX5XOFDVajg3aB+IYQHQylZM2MBu1+66q18j68wmparCDw8DlZtf6ejJwcFiuFgdjtO2HENmIsslzF0TthcwrzlfayHwJFcAigYrrU1S5DTBX9Y8BcjaS335Tqp7e3F2qmA9jdSGOsLcEJ9pGv1kxwxk4ycmi+gpMhZIdv/juUkMrML+pctUyGZ9dZejHnOdRuRDCsUfaNJC2evEVICwgDrifELVigPL9AbF6Flh3LaAk1RGn1XzNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xTZC8XvlbLZPFk83dpNAGvKOmEj2iidCtt+1zgWx4s=;
 b=VV46PBbTkWqldgr/qyaWdtV6vxApmDMX+koohkpPcj3rgsznMAHz5mrPkkMmaCELFcbD8QUG2B3rNenBHZr18NyYBQ9xEitn5OeCLWRt3zx1wPXqp3nrBnjZhhpjFqj+pusoUXg6x0eIE/jL5m+VCLTM833pMyAx4NZj+D86oCAkNXlL5mpsPSGI0PwfROJQDSPz+z83F1hqONeyamjgFoLmZEbx12c56L6GFWfuAC0/u5WJoK5kggePZmKWZNLEh1V4U0kJxFHuXdTjbiOe88Em3GaMMouapd2ncemo/uA8RLqdK5rAedqNqOhjxWMSZ9ZK9SjlkYtBFKV6yQ88pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xTZC8XvlbLZPFk83dpNAGvKOmEj2iidCtt+1zgWx4s=;
 b=LK8BhS6W18bKhpRCBlF/+srlPorePpjSNQu7oyN9K+gwI7k+LKGbSYD+G8aeGzDoRYf6k1DIO5z7uMn3myDZqrsarJvXCQxc6nb8cn8W4/pcJTy/UVULuga6cwtaAy8lb+T1+YLQvKQXb/8o6EaLhN+GSqI3+nI5Rkv3NkKYzqY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3965.namprd10.prod.outlook.com (2603:10b6:208:1b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 15:00:46 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.019; Tue, 10 Aug 2021
 15:00:46 +0000
Subject: Re: [PATCH v2] btrfs: sysfs: map sysfs files to their path
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <437f0a236348a3376ac2baeab564460491c7fa12.1628603355.git.anand.jain@oracle.com>
 <20210810144501.GY5047@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <63d8dacf-9b8f-8607-c0e3-37bbfd3b455b@oracle.com>
Date:   Tue, 10 Aug 2021 23:00:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210810144501.GY5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:3:2::31) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR0302CA0021.apcprd03.prod.outlook.com (2603:1096:3:2::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.4 via Frontend Transport; Tue, 10 Aug 2021 15:00:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f27c26f-1edd-4be6-114a-08d95c0fa1e3
X-MS-TrafficTypeDiagnostic: MN2PR10MB3965:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3965084D7BF30397F8FCCF13E5F79@MN2PR10MB3965.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXlEdjp1r67jdhGL4Vm/8C0MwofLls/kalCbFoEG6dooEf+o1+wjBsmrLvs9tjf01JTkrSpwGqBXsHBPGWI8qnqvmAyZkQzdlLCKGYPSUCYqSLyBFQXHZk7HwHwMSfXMDJFwsVevF5ORQAlzjJI5bhTDcXcs3tmZhCh44OXCDnzLx1OvDvnhKfjC5T6NI/bgf9IOoHGHPz0nJL2OX+MK+o5wkO8Y678VNq77ShkhP+BweyepyUl9kGqHNUQcq3iBT0NUnekqEtZtWLXbI0izgy/POYzwcRQZgRN94nh3taPsW5VDVgSfMnM6GaGldy0AgOkg1qRDU3nLTP2UNUuMAouhrpqHBnfRsaX43pqn8TQuLw84Rw+kY1nGc5Z/Oc41apAaHP4CTOGAL2jRPB90ai5Stea5cW5fKQFCvhAJK+KX5NeOQV5cilEhA4bUu4WZ6wEFdD3ydp0HpbGRLe3qeAv69lF1uRfLnpTkh26zubYWvdBwlVXWNkiQUCf9uA/l/G4POZ2J8EEKDZDUHs3SKSZ9aN0B9mn+so7QBPnZ9u9g1T4HOlV26b6ZKjLgchOv0uq+vf8MxiuqlVNTbu9F++K27YXnuk2qfFd5FwIneM6Cyua8QCTIGwnFJgVYiBOmBmjWuuRuqddwzTQCUmljFXsR+PLSNhbauW1VwXWVnNwtiFws1BQB/E6Webzuimbo/iJxffzNwwhS8deMlwqVwkrvIyqL+WbQY6VWg8N4n4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(39860400002)(136003)(376002)(31696002)(86362001)(6486002)(36756003)(8676002)(2616005)(44832011)(956004)(53546011)(38100700002)(26005)(66556008)(66946007)(478600001)(66476007)(186003)(2906002)(8936002)(5660300002)(16576012)(316002)(4744005)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZwMURBU2dpa2Y1ek04TGNtWGhtOG92OTZjaFFsLzBsVEQwbG9ZWTNGUTUz?=
 =?utf-8?B?ODZmaDZjVllmQzNybnpXYXQ5WjhzTUFOYjJkZkpjYzZ2NHN5V2VJL0syOU1W?=
 =?utf-8?B?ekw5bjNtV1FtMDhvbG9VaTVlNGpHUTVNRVZjRFpSaTdtUndPM0F6NGltaFVq?=
 =?utf-8?B?K3EydUptL3lVUmJiSXVJOTBNdW5KWnZIR1VYVGt0ZUExOURUZnlHSGhzVXVp?=
 =?utf-8?B?SWJvN0IwWCt1dlJZb29GQkVROFEzcnNMVm5hS21Ec2JacHh5ZFZaWmFQWmo1?=
 =?utf-8?B?OXFEUG5vSDJ2eG5NN3lDbkdrKzNiL2JCcjVKdmo3NTRPYTRhLzVPUFlOSzVn?=
 =?utf-8?B?SzIvSVZaNElvajA4eDJwZkthRDQvNWFCeURSWEc3Y3JxOTEwcVJ5d1o2SW1x?=
 =?utf-8?B?VDBMa2dqVUlxeEJSQm5yZzhFNVh5bXJFRHFQMmcrMGswa1R3Zk1veXNCck8w?=
 =?utf-8?B?MzI4aWlLK29MQVZyY0k4NHhNamQ2OGNtajFDM09oaDl2RURQTHkydUduZ0Nt?=
 =?utf-8?B?ZUNGdnB1Rm52clpKSmVoUkhLTzJYOHFPZThGQ3JLMnBqQWNob2thSWxVaTVZ?=
 =?utf-8?B?ZEdIM0p1QXZ4Q0l4MytqUnFQZ09pZWxVeXBjbGpNUXVRM3JoL0QvdEc4T0tW?=
 =?utf-8?B?NmpyQWl4VkhubzBiRnpQYlZEL1hkb2hkS1lNK2RUaUZpVVV5TWwvWFRpWERu?=
 =?utf-8?B?NldMOFM1Q0gwaFpGYnUydDUvZmxSSVBiWWRybE0rcFB1b0FNNGJQWXRFVmhZ?=
 =?utf-8?B?dnVzWnZLaE1SNVc5YSsrZUlONGlvQ1FydXRrOWhDRzcwVkJZWXUyME12VFpt?=
 =?utf-8?B?R0ZxRFlNTGV4aUhYZ3Z1UGU4NVoyeVZoN002UVNhUmFkRUdSNTBMWWkwb3pm?=
 =?utf-8?B?LzY3Y040ZFQyV0tkU3ZSNk8xRlVOY2pGN1MxNG9zWEFiRHZuS21rbmdmenU1?=
 =?utf-8?B?TlRRWk1nb1FHQVByZGxIYmdwd2p1a05xUXJZdFdlVGZ4TFZwcXRDOUxJSUIv?=
 =?utf-8?B?azVOSmZCaDdFSkFKNWRMaVlSbk9VZndtY2hGLzRiT3Nud0pNdFRoWVVZVWlT?=
 =?utf-8?B?V0JDeG1QN1lUaHRrUG5PbXJqNGg3ejhwbThpYzhCK3ZINXJRK0tGTnZidWQ0?=
 =?utf-8?B?cy9ldDNpd29uNVRIY0VBTjF1VG0xZllRUDlrUjF6K1FiVzdHMlVHSjhVWG9W?=
 =?utf-8?B?QUJDTmxISXZyWGF1aWptbE5ZdzdISVJiVkFwNE5RTXExeElvcFhoYmJjajZQ?=
 =?utf-8?B?SzN3VDdEbENwOWJxYVFhSWRLM2JHSGwvTEJaZ3paV1JuTE94VlZIMG5uTmdh?=
 =?utf-8?B?aDBhdHptUVFSZHVrN2lab2I4N3BCcC9JOWJEbktTN1ltNUYxSUErcnU1dElC?=
 =?utf-8?B?cUcvQW1qa1ZpdU9ZbFhxa1RzamRjQ2lsUUtBSDd2NDlXamVCd1FELzNsb2E5?=
 =?utf-8?B?SkpNVHBrRVFYc0Ric2RRTlEyMisyc0oraEhIK0lKV254WjNLVVdidGY5QW00?=
 =?utf-8?B?NG50UUZGQldudTYrZm83NkltZnBmRDFUS2dSd1VUcmVhVm1NRldtNUFnbHlV?=
 =?utf-8?B?VFBjV0ljY3JvaERtaG9VK05kV1B5RHY2UXhvYUFCV2RLMEtIV3hQK213SWpt?=
 =?utf-8?B?VmNSYmo5aHJGZE1JNXh2T3N0SDZOVjg1SjV5Z1g5aXNhWlRkMmxZN1huRUVh?=
 =?utf-8?B?UjZuSWt0UGV1NHhpYTVmdUxJWW42c3kzVU5KSmdaazJ4QjJGZEpPTXBVUFhz?=
 =?utf-8?Q?48oKRJeSAuch3PRZ8LfQQl7jDQeVz0An5sVndmm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f27c26f-1edd-4be6-114a-08d95c0fa1e3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 15:00:46.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eokGELYoE+8g5ZW/mbspmE41BslUxd9nw5sfaJC8xdiY/ba3uy9bKvcpocAINlKqMYwSeKSO+sl7H3oO7OlPhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3965
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100096
X-Proofpoint-ORIG-GUID: 2OWQAlaEzFLSQHafzJV8yFtMysSdNg-5
X-Proofpoint-GUID: 2OWQAlaEzFLSQHafzJV8yFtMysSdNg-5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/08/2021 22:45, David Sterba wrote:
> On Tue, Aug 10, 2021 at 09:55:59PM +0800, Anand Jain wrote:
>> Sysfs file has grown big. It takes some time to locate the correct
>> struct attribute to add new files. Create a table and map the
>> struct attribute to its sysfs path.
>>
>> Also, fix the comment about the debug sysfs path.
>> And add the comments to the attributes instead of attribute group,
>> where sysfs file names are defined.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2: Add sysfs path in the attribute definitions.
> 
> Thanks, I've reworded and reformatted some of the comments. Added to
> misc-next.
> 
>> + * qgroup_attrs				/sys/fs/btrfs/<uuid>/qgroups/<subvol-id>
> 
> This is not subvolid but the "level_qgroupid" formatted qgroup id.
> 

Got it. Thanks.

