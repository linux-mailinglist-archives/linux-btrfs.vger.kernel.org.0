Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E0A41C331
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 13:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245035AbhI2LPe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 07:15:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33770 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243377AbhI2LPe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 07:15:34 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18T9eJeW005942;
        Wed, 29 Sep 2021 11:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Od/zkC75gMGgsxk8telvJzs6R1DNEShLMxrUJ8uadLo=;
 b=KFoOaMxQKDGSJwq69KpTPJXr/68B8q+ygBHbqtxk0NIfc0N5qUv2CYKcq1N+tMYkpErK
 or5crxLGRhrBbgUT1VLdlMTjWXr740IMqeuqapfty4cxj7e73DndvfwGwE85yg2nfnbO
 NP3mxSHazKBdY7zZJEjjcijfx9FVf/xxF5YOMS5dEese7ITTK4+aajuI5Na5SSRGYa/W
 c+/eebkKxWdbDWrEspJBQg/HbWk9ADoVz6A2NagljeEMmsvB/ZDj47F1K8Vc1zG+vxBH
 sA7euEcSumxWF+1g5qQ4ARne9RnPDuCnh5qUS5HTowSc5ztUa6edQdqNTlwYyxM4A/AV IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bchfksse8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 11:13:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TBA8Z6002362;
        Wed, 29 Sep 2021 11:13:47 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by userp3020.oracle.com with ESMTP id 3bc3ce1k6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 11:13:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExK6o4+Q/5VugVoHOdkfRWn0dlEYx8Md1sj+SfLPqAriIqYlW+h1Mz9u/W570x8FIC+zHJz39SgMlYFj20Xr4ldL14UvUIA5O0GdwzH8zy2dxaMUTVgiPiDli8cgxq/9N6cqAbsQCjEJLHOzr4zhJ/JSUVkcUqKDewn6FGwOb6MU07gD/O+vQW1SJBS3usEKOUscgCJG8NrWJEEwxASiKsMvDYUOOUWVtfyxTdlX31d5tvjcs6HC8zWJ/OW/j4zxe1XIxrB10ztMESjZ4LoXjNKDxovMwJJA5mlCRerkfbq8MD3rMQX3rCw0sr2DXc9tbTEbDh3zO6++3+ujx4RggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Od/zkC75gMGgsxk8telvJzs6R1DNEShLMxrUJ8uadLo=;
 b=FjMVmep7DLKdVERufrUTv/+tSJAZUFA7YbBQ5FOn/WdXJlrM6/Ql19Te8qu4m5+X2M0S+hzbqzvO1YnaAMXU9VKKW+Xc4j/HjSWEk/bB02ul3fWqLZzEjIga/1mll8dArfQDzZEnxtWKezjJfhV/PK4Mn8w29Y5Cddop7hYtItNIkSTkIzMV4kqCSUkRJcm876834KL4oX7ICraozX0Elh9faEXnvGAJcIjwuuEp/apeWAXPGj5FC4z/JqwjgDbmaG/Pavf2kPwJVHXAU+77KzkV6wnGtPt+Jxuv0PTlv1e9xI54z5RLvIVXbMfP4QvGElsvU3iiGODbJnkyN4tMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od/zkC75gMGgsxk8telvJzs6R1DNEShLMxrUJ8uadLo=;
 b=IjskIMXACTQr6h8fLBwhOtJKaWwVPR1uarmUzoHkJPTFYhAA9w5goYeVPvFeRh2jKKnFw7nFC3iu/07GHevPZCPvYyXcfSqZnkKcMZdHEewnDtbH3x0jLNi56iVhVLCbbGxeC5z46tmt0R4xhlH07COnH0gTM5djFJArrdghtKc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3025.namprd10.prod.outlook.com (2603:10b6:208:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 11:13:45 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 11:13:44 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: Ignore path device during device scan
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210928123730.393551-1-nborisov@suse.com>
 <50f82537-0ccc-701d-215a-f45c20c0827b@oracle.com>
 <9330f390-f561-7358-f932-46fd580f98e5@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <036be5f7-642b-60b4-f862-7541e65c0551@oracle.com>
Date:   Wed, 29 Sep 2021 19:13:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <9330f390-f561-7358-f932-46fd580f98e5@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0110.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR01CA0110.apcprd01.prod.exchangelabs.com (2603:1096:4:40::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 11:13:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e8fd66d-7cc5-4d79-fffe-08d9833a33a0
X-MS-TrafficTypeDiagnostic: BL0PR10MB3025:
X-Microsoft-Antispam-PRVS: <BL0PR10MB30254796A0818260D30C2274E5A99@BL0PR10MB3025.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZ9aVHTGIh/4OGgohbM9yGnIpQCPgUfk1OSxQr5D4IOQvZ0unj+NOUAFukDtboUpRDrtC/z3zB5jVheWab7i02gpdbqLG9nYosVLaXijnIPL5lTmuqF199e703WQF1o8S8KZBLjsId+uU7P/cfwvYS7+rsE/HaOhWrcfMSFsc+emfn+YK2ydK8qafmJVqaKWKm5xevAqa0voYUW971YzSe3QYwUs4yDZLKYQfBTBZZautNCiz1TZyL0fp2ySM0QCWS81mQfOT/9HEMhQ6cAEw0POn6WqpJOLlraGod29CcDLlwLhFbfGLnjt3u/9SPGexOFfJdhnTUd1ZZ3VTNc2S3ckPvfxS3yN/SaYy5Z7PvHa66dmbQoGP8G2wV+q99KS20pJOC0sT5aJntCZUSfm3d8XrVxloPcCX8H9oP3hiyKyFlM0DhsrKfAf4WgEdW4Gt2HPwjVAfWI9QQw5ZTEY+yCBVHaTpO4kQivSZZwPcBbRhrHsc1X5D/xDBboJK6GegNgl7wK71+3PBcZ1tZOPep6O2r8dYYFN1+PUI78+q0mzFzBzWMCB5dXPzsfI79ITCHF8QVMx8b1BOw2X3fjJYsAWwRIn30N2ZZbf2/Tj+GUpSOc79yXI/dBcfcj9gQ0tj+ygI9xStTypx8/Xt5Xn9d1hGL9DnRNzzgVVkJIgscI+MynqIDzgc9bIp0pOxUHOGOrLCAdUAsCYW/N7W4hzRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(66556008)(53546011)(86362001)(66476007)(38100700002)(66946007)(36756003)(31686004)(83380400001)(31696002)(6486002)(956004)(16576012)(8676002)(5660300002)(44832011)(508600001)(2906002)(186003)(8936002)(26005)(316002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUxIUlFMZkxhSUhwQktNSmRFdHdSNVRTQmQ4dEZNV1pPa21RR3FsUlZ3dUUv?=
 =?utf-8?B?VDFJOEFDZ29SZkFUWTZVdDYraUNKcnE0UGx5ZjNsMWI4VHA2N0dwaU1HVFEx?=
 =?utf-8?B?VzYybXlFM21hdFJ5Ri96c1FTTHF3ZHVIRFRDTGRaenpuc01paGhnWkJNdzIz?=
 =?utf-8?B?VmZYSHlIOWp5cTZLRGtIQ0FFR0lFclQ5czVBcjljeEN6NE4vbG1ERDgyK3Bu?=
 =?utf-8?B?by9vRjZ5VDJPN0dGYzhyVHRrU1VMOHI2bCt0RUpnd1NNOUc4ZUNEK3U3S1BK?=
 =?utf-8?B?MEpVUWZaaDBwYytTZmQvTGxnRjRWZDk4WkJwYzBDTjBKWXAvNFRudjhueGUr?=
 =?utf-8?B?V29vRm5SUE1tQkdXMzhSY3lFeWVwc0NhVFFWZkhVWGNVL0NFcy9neEpRTnJZ?=
 =?utf-8?B?eTllYXQ4NVN2WmY3YWVSY0R5ZGIzUUVwZFZSanFSSEVWTTh5b0lWZjBpVUUw?=
 =?utf-8?B?OWhYOHVsQXhsOUFtQjJGN0RVWWN6Y1BCUFduZjlhZDNld2E1ZGpJNlp5eGlP?=
 =?utf-8?B?WXBSR29QYVBkNVRxQXVMVmFXUVAyUURzeG5RNk5sNnZuejN4ck53cU1NZzlS?=
 =?utf-8?B?MXFBaDI1Z1VNVDZmN20yUDhDWHZ2SnpMbkxNanRLakNWOVJlMEIrSUF6UEg3?=
 =?utf-8?B?TnIwZ2h6S0VXbllnTDlFWU5oZDk2bmpad2ZJckFxQnZydi9WdU9Qb2ErM0gr?=
 =?utf-8?B?QzJRWEp3R1VzaXNGMUVkb0xvSkRPSFNhWkJLNEREbldoUko1bEhCci9zMnJm?=
 =?utf-8?B?Q05OUEJaaGdWMC9FUDhSZ0lUSityM3ZVQzlOVHZjMndHMjNEdHppb3NNbEtO?=
 =?utf-8?B?NktlV3poZnNVL0pGS29HN21ad2ZqZXJDczhwb2NkMVp5T1RKbXlONHlZRnVs?=
 =?utf-8?B?WEU1alpJYkVCK3VyMDgzT1EwbFB5OGJaTXFGeGZiTHdCYWxBd1ZtQmVHOUhz?=
 =?utf-8?B?aURpR1MrS3RRQWFtNDlCNVEwM1gxT0IycDVLcjZQbUk3Q1Z1M0QwWWhRMlRm?=
 =?utf-8?B?VS9MQlovMm9EU3o1aVJCM0hPajJjRDNCV3puZ1QwMjl0T3ZJbUVvT1ZhMHVS?=
 =?utf-8?B?N1NZY01KTWZNODd1d2s4Nlo2Q2FMQndQOHB5ZDVCOHByVTJvSnUwVUx2ZkVu?=
 =?utf-8?B?b2FwTlROVHczZWN4cEpOVll3a3JpRWdlbk1McU9RRnFtNG9SWGxjTVZPL3B4?=
 =?utf-8?B?aCt5UDVRRUFMYWRmMUdNQzZXUmwydzhzVjdmWUNmR28rVGJwa1BSL2kydlJD?=
 =?utf-8?B?ZXpMaFVRQTB5bTFFMDRFNFBwNFFxT01BZHcyNU1aVi8yWjVnR3dOa3RncWpn?=
 =?utf-8?B?ckxVRHNpNFc1Z1l3N3VRR25zZkxNdVpaVmZ1dnVUcnJ0OFFMdG9pTFNwM1Yr?=
 =?utf-8?B?UUEvdmlLSGVSbHVJclJ0djJIMGh1SGhXcklrOUJVQVM0UFNQdEMrOVdVdFFS?=
 =?utf-8?B?NGJMeHZiYmF5TThxbGFmOUsxNTIyZDlOK0Y4UFVIZE9KRUx2Z0xXQkJzZ0Qx?=
 =?utf-8?B?VE5yRlRldnBTRTdRc2Y5ZmpYVlNjZ3lSSjZZOWZSUWpOUnYrUG9IVXBaWnFF?=
 =?utf-8?B?STQraDVMRWU1bWt0Wi8wNkxYa1ljL3JzS3NuNW84OVV6NmlkbFZQUVBIVmhE?=
 =?utf-8?B?cGxLdGUxRDBjZ01kQit3SG5HcDkzTVB3WHNzRU5xMmgwb2tMU05kaGh2N3pC?=
 =?utf-8?B?SC9CckNicFBYam9DMTNDRXlYeTRLWW5rR3hPQWMxRzJJdDRQTkIxMWU2SFBG?=
 =?utf-8?Q?PgchY5K8d2ldYxbvvoe4IfOZh6ySVHeJsbykax7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8fd66d-7cc5-4d79-fffe-08d9833a33a0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 11:13:44.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfGGFtnvUB9k4qDZwrlxo1w9oMeg6hOQayn1caBFeXH+43Poll0mvQXBDzsP9y6TI1t3ObLb6dxKP0IkJOX8kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3025
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10121 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109290069
X-Proofpoint-ORIG-GUID: FAg4RbS5wZvWKdjp0SzIH_D2BS4NWHbr
X-Proofpoint-GUID: FAg4RbS5wZvWKdjp0SzIH_D2BS4NWHbr
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29/09/2021 14:59, Nikolay Borisov wrote:
> 
> 
> On 29.09.21 г. 2:03, Anand Jain wrote:
>> On 28/09/2021 20:37, Nikolay Borisov wrote:
>>> Currently btrfs-progs will happily enumerate any device which has a
>>> btrfs filesystem on it. For the majority of use cases that's fine and
>>> there haven't been any problems with that.
>>
>>> However, there was a recent
>>> report
>>
>>   Could you point to the report or if it is internal?
> 
> Internal
> 
>>
>>   Kernel message has the process of name for the device scan.
>>   We don't have to fix the btrfs-progs end if it is not doing it.
>>
>>> that in multipath scenario when running "btrfs fi show" after a
>>> path flap
>>
>>   It is better to use 'btrfs fi show -m' it provides kernel perspective.
> 
> [146822.972653] BTRFS warning: duplicate device /dev/sdd devid 1
> generation 8 scanned by systemd-udevd (6254)
> 
> [146823.060984] BTRFS info (device dm-0): devid 1 device path
> /dev/mapper/3600140501cc1f49e5364f0093869c763 changed to /dev/dm-0
> scanned by systemd-udevd (6266)

   So /dev/sdd is a device-path of the multi-path
      /dev/mapper/3600140501cc1f49e5364f0093869c763 aka /dev/dm-0
   which, the kernel rejected to use, that's good.

> [146823.075084] BTRFS info (device dm-0): devid 1 device path /dev/dm-0
> changed to /dev/mapper/3600140501cc1f49e5364f0093869c763 scanned by
> systemd-udevd (6266)

  systemd-udevd is scanning the same device too many times.

> btrfs fi show -m is actually consistent with always showing the mapper
> device.

  Do you mean either of /dev/mapper/3600140501cc1f49e5364f0093869c763
  or /dev/dm-0 but, never /dev/sdd? That's expected as per the above
  messages which is not a problem.


>>   What do you mean by path flap here? Do you mean a device-path in a
>> multi-path config disappeared forever or failed temporarily?
> 
> flap means going up and down. The gist is that btrfs fi show would show
> the latest device being scanned, which in the case of multipath device
> could be any of the paths.

  Do you mean 'btrfs fi show' shows a device of the multi-path however,
  'btrfs fi show -m' shows the correct multi-path device?

<snip>
