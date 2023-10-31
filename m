Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C767DC965
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 10:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbjJaJXj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 05:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJaJXh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 05:23:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B92F5
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 02:23:35 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMxHSw001890;
        Tue, 31 Oct 2023 09:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4YaT9bmvZ02XV53+fUJ58TRnyYrckeFckAoB/rvHw1M=;
 b=PktaQ/SqyW5YIgTwdg8BRUcublvQdLDdf5a6aqf84Mw+F7rmX94K9hepTEA5KqyFPG6V
 87gywi4XHr+dJM7d2pJtlCHj35+U6eEj4tZd9sPuCx/QfQxo5WihDFPPlcVmE7PVyY3U
 fYvuXVsRH+6N98VfWrbzAe8X56XwiYtWdmOvTf7XckNr5cYxItyhQh3AcoIPt2HhB8Cv
 NS3y7CekcKcQCVvI2jjWG+AD5wWqw9AknrWP0YulKhcPa3E0NYxIHPe3RJLgBjVZlIb6
 9sP4zm1gNoLE7PjXB7Qq6B+553szKXYjQxoyCzvdd8+KFLZo+JCw8wMZP+CL9ESueO5D Yg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7bvmnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 09:23:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39V8oeb3020308;
        Tue, 31 Oct 2023 09:23:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrbmpf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 09:23:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUq1Urvd94Yy4lAph8QxDNEY10Sr+k78sxrkXTRZgR5sZdIIU9GRGjyG5ZsYciIYnkIJLvgxdjtfevlakSaGeIoYWKZ7NOhnf8LKhdkHkD7STbw82Kf9msxI213HdD8WDwxyYYc5CO/JIuWwnVt+RSs9ZnPZfrcyiyK+hyIEUQX2DNtYlTbHvIgy2E0pq076IR5uwKvG/HEuBtqxCsTxco+rkTzbrdFeP2z9Qts/WVWxZOp9sPEPnOTyi2JVLbsMIRBLdVN9EX3EQNoA8ddH8Rd8gb+HN5qus+dVus+EEKhF6Pkn+PixpB0L9XrC+h2Ttyv+6SWr2xFA37cre6McDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YaT9bmvZ02XV53+fUJ58TRnyYrckeFckAoB/rvHw1M=;
 b=Un8CFhDFYOZG82PAmBorCf12UdTrPVOvgfDIR/snoMBusS3sG1uLSeVCjiUANvb3qSoWSAFb1/U32oOceOMhyZ3xZR4D88uEydTEtHpXJBEj7pKqW1Onx8fORn7OZNNvS1X7inTHCLQlCuuXZyMsIHIIg0fnV1TfHPIsOW7rUPipqLHhczPvkrLLUP8ub0TeXJv19+2kpkhjwxqLDRkbq5/c2WniX5Hz+DH+WsCyVmUlo2dVWSgbTVVa6wnWiYh4YxDCa9ICG2fqJpxTTTpgPdZ4jJT5wGDkGPwQYWqYBmmx1UDrBw0Uq24wOa8pvJfCtP0etRhLKwnVVi+5o0N5WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YaT9bmvZ02XV53+fUJ58TRnyYrckeFckAoB/rvHw1M=;
 b=fbDJoLzKMxgU4YdJflgv3FKlIXs1cRmmEWzcTotjc6VnHKb12olTbwbn0fRTAof62c7ivKKhw4zs58w4xE3wnw4YUHt+Cle8u05vWHAKQnKxP2NxOWrACgU3NBArTXkRJsCho6mQ15qHOcxnk72JtwjVnAmDHKGR4oWIrCB8y4Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6497.namprd10.prod.outlook.com (2603:10b6:806:2a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Tue, 31 Oct
 2023 09:23:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 09:23:25 +0000
Message-ID: <f291309a-71d3-484b-a876-99382a61363d@oracle.com>
Date:   Tue, 31 Oct 2023 17:23:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [kdave-btrfs-devel:dev/guilherme/temp-fsid-v4] [btrfs]
 479361d32b: xfstests.btrfs.185.fail
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <202310311425.c2e34aef-oliver.sang@intel.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <202310311425.c2e34aef-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a32b82-adc2-469a-b697-08dbd9f308aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fUJtKSeul7hHJ2HTOwsz9+1ykUc1talcMfbTc5VHLGg+8/PCOxOywUnWwckS1oLi07IRp4EdFSH9Z9usdOGVN0MdJGPSwR91nBZq4f4MxQ4ruGXkhLmOCeIMxHWYPpwl+en3j15hP2IYc5yyBf8f1zuXzApno7FT3FYh3G7nmqRS0rNpU3kdZBxNI8M+KDn77mMe2TK7PY2Xf3rksjDFn5NnhQ+PUchzfJ+bdt5T08+43hh9y2br4nssbZvt5OcBuCaYUKS0cTxvUIo/rCoClfI2upgJP0NAFdXbbT/FPL1Im7Zy/BSIzxBjKdU8bnY6heHBNmNVWaNCoPTsM8Y0AuWXJrZ1mM6J4FbkvprsSA0mN7az7BVMutMsXI9hxyROhbgV3a9yFXVbB9PhsUM+vZB1T1VysdDQ1WNAvKPPMpgR3BPFoYmVRTOUuBBXqeVi9z0yIVVvl/Ia92oXRCbpQYTUixxVe/BcssyLY/aZF4MAE2rjYdTthXV35lfztlyhDMW+ggAkGXv3DczAK/ncuVXAHCOll7WKf5iP1nq6o1Ewz5EgbkWLveckOAY1+APk2rwAA0fXf8cO61l2BmL9urKCw+jKi8qwR0m4ZE7mFS9/DyacfXj3nsiR4XHwQSKPpog+G7oFqjIOeKvTVueihQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(558084003)(31686004)(6666004)(6506007)(6512007)(41300700001)(86362001)(8676002)(8936002)(5660300002)(4326008)(38100700002)(2906002)(66946007)(2616005)(36756003)(26005)(44832011)(66556008)(31696002)(66476007)(478600001)(83380400001)(6916009)(316002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVhSNDJsb0dkOStWaHdRL1BPTjBHVTZrOFZLTDF2QnFDWklVcW01eGp4Z2Jr?=
 =?utf-8?B?ZGZVWlpNQzVaWG9nQXFOdkMrcStqcDZCdEp4V0dJaTlQbGt5emdRUGRQcXRh?=
 =?utf-8?B?S0JDN2I3bml2ZXVrblFucWtKb1FyMWVIaFY2MDZ5Q3pTVTdqd2ZEMmkva2Rp?=
 =?utf-8?B?aWFpWElMNDlyVGtNMVBZdk9tNzlORVV1L3ROOGozaVdFZHhFMTRaU2s1RUNM?=
 =?utf-8?B?ZlBPeUpGVktzdUFUaTBBcGxucVhkbERNQTBIWGZoOS96Kzk4Ly96RlZ1OExX?=
 =?utf-8?B?UExZMlU3UUhwbUUzaVIzZkVnUjlRNkpreE81Y1VNRmhCQzVZRmhieDFqcHEv?=
 =?utf-8?B?eW10K1ZmQnBFcERkUFA1VU1id1BFcDAzNUpuaXBKNzlOYkd2djVueWxWanFp?=
 =?utf-8?B?MmxRV0FrazcrWHBncGNmTm5scFZTL21qS3d6TktBTmFPUXI2Q05YVTJsWGZW?=
 =?utf-8?B?Um5PQ09YMG5CSnVpTWFsdGwveVJ0RXFwMVRBelQ0QWlORURXcXFjNHZLaE5O?=
 =?utf-8?B?ZmFFQXAvQTBFZ2prY2krMU9HckhpT2tLSzJMVzBaSlhFSVJlZFBzNzJGOGxD?=
 =?utf-8?B?VlduSzNWSnJGbDNEYWZTNEpVVy9BcFk1ek9rNUsyOEZwbmlyTk9sWlVneTJH?=
 =?utf-8?B?T1FFRU9RZGF5SVJCMDBML3R0RTNVaUtpTFpCZGQwWDJrLzVabWFNMUhjR1Ju?=
 =?utf-8?B?bkxRZTB3VzR4Z2toWUpGR0pISlZMUS9XVEJzNHUrMStSRU5GbEord2poUVlM?=
 =?utf-8?B?ZkRUNTgvZzlSNU9vdWRUZWNCcHgxa1d1d0VBYVF5elBmbnBQcWtWbWJJOTFF?=
 =?utf-8?B?b1F1SlRrc1AvV1lxZ2RLQVMraEpWajhlZ2xHRDJsZWFJTmJ1cWd2UGU1TWc2?=
 =?utf-8?B?Q0hGSnl0TmNxMlk5R1ZFekd2WFBHYVBCMnR5UW1LenlEbGtKT01aQy9jVUtL?=
 =?utf-8?B?VHlianZtZC9sY1RjTEtqRnZFVTFOOFNabVdGREhwL0xXNUNlYUdxb3EwTVNP?=
 =?utf-8?B?OHlDSmN6aWloQVdhNGxBUVhRRGUvalFZbVFVSHJudVI4NGhQVUNhQnQ2MGlS?=
 =?utf-8?B?U3RxWlpBVVhUa3lQTitiTUZDSHo5d294OWlGRXZ1WnBaS3htZURka1BDUklh?=
 =?utf-8?B?MGhUNm1aNjQvUXg3NVlZTVY2czFnNW5nMDJ4aWV4N1h5eGZjbkhXa3diOEps?=
 =?utf-8?B?ODZ5cWtNZTNLODAwa1NxdnQ2QzNtd2VuUDBOaUJMVkN3eHZmWWExc3B6VDV3?=
 =?utf-8?B?L1NvclRna3NxYjBxVkN3TDRpU013YzhnQ1ZFamoydWI0N1BXOFpZU2FoVldi?=
 =?utf-8?B?WGkwUHNmelNOckVUajA1MUNIek40S0lrbXgvRjdOWDNmcWlHVDA2VzlUN3Qx?=
 =?utf-8?B?cDVJMkNocWNYWUJZcjYrNHUrczNCT0FaSThxNHo2c2V5eS9CWE1OTjZqbFJm?=
 =?utf-8?B?VEljNGJKWm0vS2dVVUMyVTVXQUhGQ2NrcFhYZjZTV2QyK1UyVStGYVdLOXVa?=
 =?utf-8?B?aFdnalU1Z0g5Q25tZ2tiRWZPd1BWOW9VaHIxYlo2VWJVbm44UWhiWEl1dUFT?=
 =?utf-8?B?Y3h0bUF6VFkrVEtYaVpGdElhUStyQk5OL1NlTjVGUDRYTVpyMGZPdkdjTFJa?=
 =?utf-8?B?cGVTemxEcXkzUDM1Wmwrdk1Oam03Y1V5ejY5enZmWWJ1b1NwV1J0K3RtY3Fu?=
 =?utf-8?B?ZVlnM3BVZktZRjQxaFFtQkc5SHJkRG9FV0VrZmo1WWtsdmJQa1NETzBDcXJD?=
 =?utf-8?B?V2hteHdyNzhBZGtsbHNDZnpLWFpnVjFkMGJNcUJScU5WZUVEbVVpdXFEdkRM?=
 =?utf-8?B?UjFsSEV6TmpzRW9ROFRGMGFnejZZLytWK2lzSVQrODVvMlM0RWhwR25tUDlx?=
 =?utf-8?B?Nkd3a21wMnEwR1FaY2syRXpObHg0Mjl5L1B2VEhqU3ZIdFV1UmpQYjRySEM4?=
 =?utf-8?B?SXF3RFMwUzFlbm1OY001SnRGb0VNQllzSDc4ZTVtQ0ZuNWdiQlgwWjFnVHBM?=
 =?utf-8?B?MDl4NjhCbGc1QWRBOTJadnB1Qm0rUEI1SVdxdjlZS1JlRFRTUVluVGlSSUtt?=
 =?utf-8?B?WHFzTVJDZndFcVFwc0YrdmUzc1hXQ21oV1JxV2x0cXJHYlg1QVBsL2RENVJp?=
 =?utf-8?B?K215NDg2RGVFQnFtKzFxajdaK3h4SnR0UEQ5KzRLcUhvV2dtSFRIdXZKTDVO?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DrUBNofGXXei4KlEgdZchEtBiDOpNQyNr7qFFEhRVkHWCgZVA2W8Hz43k0ozoiY5hA7YPE6wqWVC1xfnBH+mg+RaHe7ZztbMEJXJCPiob9AHG8AplbgDuKvlU11jUgOX3LrqJ03cMJq8LF32LQKrSzzvl1KZaSBXC1F2KLYu1VJI3dbnLJWzNeckfzpXp+f9q7lFo4LNBfXT7VszwIEO6dzpJv70PhXl3xUBLLTGBY18qlPOZfHXhHg7Sli9w/CHw48XSswUe4X6AM6m6w82AiB3j5g+EjmO304snOr3+uZstg23o5GPGBiTKoie5F2TA1E+SbeI4aVq72mxlbUsZfrB+tiY9rhjherWE2UGMvC16pRj/BIOR8ZJ++b/WXmuYbXXtxGxIZCh2dBjwDH0+gOGgyDDevxTYezHza6t60xsN7qtpjZW8+G6RHU2/zyfJJqKZ9dJMZAVgSLic98EVntm9eT5pIITMlO3APYLHFF9dXGE5wY0vXAEJrVwDMZWGd3I1k6YjuTDK5gbssKU3wN2c1WVpZUy68v/lKsvyKOHyzwCss/zkyENKUoLtyYeZHuk5rAPnNrjsMg2Jon2u4m71MOX/M0HBnUy19TEr7S1BVpx2gboFp5SwULWfD78acpNYfm7GOBm4GfdU1rz+eZPyN4kfpn8l+/kBXVOvHIohtkedVcdNfzsl6AaQmxU02vLadduj6SSzR8KgqZN1ptPMojzbyplimUxYQ06ZD9Y+4lLyLLWx0PEiO8Gvfm51ZWe0nq1xraQGwH+3UbjkdCDzqOE3l5U5SQCFUr3BnW1AjmpVtpt8d1CKKHsQaTIGnd74ALcZQgkoa0/4o93D+GbDVSOlppu5dsHmW13u10=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a32b82-adc2-469a-b697-08dbd9f308aa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 09:23:25.3046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apm0ILfHZTskeIpIybTHcVUOf5NAdAqUsecKC987vsusPHJWhYQuRW6m8q/oYdAuvZJFBa3Vb/oPsM7P+DZcVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6497
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=967 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310310073
X-Proofpoint-GUID: g5Lu5hGJap7SNUXCI_ZO_54OknTH8GxC
X-Proofpoint-ORIG-GUID: g5Lu5hGJap7SNUXCI_ZO_54OknTH8GxC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the report.

>      +cloned device scan should fail

Your fstests is missing the following commit:
    1348ed0e256a ("fstests: btrfs/185 update for single device pseudo 
device-scan")
Pls upgrade.

Thanks, Anand
