Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57052737B64
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 08:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjFUGhE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 02:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjFUGgU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 02:36:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13362213C;
        Tue, 20 Jun 2023 23:35:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L4RhC1032536;
        Wed, 21 Jun 2023 06:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Wcc/wqS12DQdbU/w6lv0dDRyTfN+JZ+qHeOAIeZT844=;
 b=X7matwN3ZZmTLg86NbiTE06Dixga4lJDhLtYtQV+7NWf2kynYv9tmMqWYWqOzb/YGa6+
 Ei4s1O59w0Idb1AJ1YwXefNzh37E/su44CJ4szBZPsbC7r7WcfebYQv+jDetmFift9RZ
 hcnR5PueU6X1hhMPVU2AMSQifqDvfj1vT68rv/DBbGgwqs2HcDtefGhmKnuotq+AXz4p
 yX7Hy1wkpV5DrM8paBMeC7kV4iH5RvBi452705ZcxdGcHIx81tbcUphudYSHLHlDYtgd
 J3L7to+21DZdRt5x46PYx3Vyurywn0VSQZKhde0Dc0p8MRDNpO2OF7UfOmsOGHs0JXc/ PA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dprm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 06:35:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35L54kJn008391;
        Wed, 21 Jun 2023 06:35:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9395vqxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 06:35:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk3U0ZVqYJKOsFRLjX0IInRU4UVN1SRITCOOPopE9Gbr2u/viA/CdiEjo8Bi8ydl37PmXhPSEjtGIrI1BqU0L2Qf6aBn8UVgumcV5DBPoHYZDISJesXfEiwR7Iq/5zMyMqECFsVmNJiqc+GOf0atGYjoz5Lx833oEFiCmm61/t4zdNyW6qAzIJGzuIlTx8GGXw81boIqGZp+YLQOS9od6SI2xjSPPvRwjdnTbUdpKw79SQXw4pR2ty/DS05PP22mc5eqy0f8AsKQXGvh3LDix/vOdjmDLY38OhnuyxI+BKdMfeQg+ZV+X3tJVYwlK7k7jB8CDDcZJGnm/wGMVEIbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wcc/wqS12DQdbU/w6lv0dDRyTfN+JZ+qHeOAIeZT844=;
 b=kqWrkM7aemUs34gZi2/Iq/fEyxxrd/sgvcTutncmmKg2clrpg2X/hXWl46HiHfdV7HJ1Gys8xVlyWll4MLUtfBJjubFkKmWNcmNUiZkE+PpGhXa4OawFB7L1TrxHnRNAZDtfb2ug1gulN429R8lNd8/DhQMOyhfqgemyNq6nCOrwJ9kTZoTMb+apTqsjzXWe5RZZRTaKU8fJmg4acNRA5jBHPdNksGBMKz/rDu3sF2LHIYpCH+FWQkILWchFnE5h/Bua1vju5UvVK6wB4ooFgMpfOItJZ2VBAXuzXBnj+72xieonwf7YPlRVAOklggOIXyvy+VYP3WqNVinTfjcxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wcc/wqS12DQdbU/w6lv0dDRyTfN+JZ+qHeOAIeZT844=;
 b=zwQCxJMrcR7xh8Xmhh0Nf614rtLW7rY1WB11xGs6DSIhA1nQ3ggaMcLsNk7AOpD2mSrNXAdTNKjl903pE3o2E8B0ahRLqyiBVxtS1R7bwGJy4axCkiNieyxqIZOzwsGHvmj6bCdXp1nJH2bN9/Z9gHrdnzbapCE3ceJYBTi550U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 06:35:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 06:35:25 +0000
Message-ID: <e30423bb-8b9b-06e0-3978-4711afb77c58@oracle.com>
Date:   Wed, 21 Jun 2023 14:35:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: add test case to verify the behavior with large
 RAID0 data chunks
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230621015107.88931-1-wqu@suse.com>
 <90714755-3b63-b95c-87dd-1a7ef785c461@oracle.com>
 <790f7e19-a31b-c27c-570e-5e3125e4a1d9@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <790f7e19-a31b-c27c-570e-5e3125e4a1d9@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0f47bb-1a5b-40b1-a782-08db7221b1ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7+vQPHYZxbVagi0yrXDLH3yF2n6QBMLelGFpOmtP3qgo4p0+gNJHVVZqn+ihKePPTki9Y6QPNEJpvKLxaorqJG9xxmz5Yqtdz9ayVaGTdnT9pXmfcALow0Fic8Qj4rtOJBYcFiFU+LU93xjkmAmMEyLNzb7u7AesaP2Goy7YgQqw7DPT8hE8F3Kh57QfeCyNur97jVwv6CukeMCCmlGueP4n8P/6pBTn5WMKWn2rDssSFZSzr2C8u+MFK9u13c7sJHt1rbJ1dIvddRK0pv3BESWZWReaw42LELE0o6Kb+2WvLFXAe3WIfQIBDB+GN1O4Pt5ubz8M+ze6vqL9Gv01bWHZflmE7rMrJ1kOQl2rHf/tGdOUTvMsa4wWxmIjLZ9vGVOMTbbj0soX1H9VqPM7THeLKnB4Z5cuElfvLf5d7D+fn6vEPZMnNNBy7eI0wN5E7wh1ld85wCmIzb4YBNJkqE4eRlCbJjIvFQsD78uT6Cgk/KpfhiZk58HM+pt27Sl9gst3ADbDpgt6lyaUK9mu7DaGarh8BBXN2r+CGvo8dBs5H0U9aHhr1PXEt1CLFTVQeuf7afn1GctLKcmCiCkkrQm2Qml7emV9o2WK5Emq5NK7zybf3EpwvUcqolMeELEhCFQOsoqUQ5ych3kA8LjHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(8676002)(2906002)(8936002)(44832011)(86362001)(31686004)(316002)(66946007)(66556008)(66476007)(478600001)(41300700001)(31696002)(110136005)(5660300002)(66899021)(83380400001)(6666004)(38100700002)(6486002)(2616005)(36756003)(186003)(26005)(6512007)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVJlL0R6c213QUZscUdUYjYyNXIxTkxIWkhsaWN0VWdKUUlaV1Q0V2U0R2NL?=
 =?utf-8?B?VXlET1RvRkZ5cElDRjhQSVR2d25kWWlER0lVTGdKSE4zeVJkZC8zUFRoTERC?=
 =?utf-8?B?M0czVWVLd2RMQ2xDci9Ecm10UmFma2loNEJQRWFIaHArOFpyQUs3ai84TDBY?=
 =?utf-8?B?c3hMajh4RTVYU1FUYWNhNXIwRWF4U2lEcnpFVk9MaTFwMFJndHdobERzak45?=
 =?utf-8?B?N3hDVUVqdkxoWHN4bnRIdUpzME82bUhLM2dycnZlVExYVjVGNTR3YTBoRGF2?=
 =?utf-8?B?NUtRL0lrdVRKYTNER0RyaFNkdzZiUmorRENKSURYSTNPbGpKSHU0VjFVSndx?=
 =?utf-8?B?ZmNSWDBWMzUwZEUwc3BmMFF5NG5hZW9sNHhSa3czSmtIcmRPS2tsMWo4WUVI?=
 =?utf-8?B?OTJOcmZ5d0xXVDlnK2dzT1IxcXRRU0tZelZBOGVSaUhqbG03WjdWN1JyNENl?=
 =?utf-8?B?aHBvZ08yY1d5RGxpYUNRWXBpV042WUsyVWxKOUdhOExiNG1YV1NtQ2lvRG9F?=
 =?utf-8?B?aHdoMGJGUG1WWUR4R2QxdUdxblBQcGFWNldXTEhNQ3N2WFFKeEs1Y0pWTVZm?=
 =?utf-8?B?dlpURVdvd1hjLzJ1OUlIendyMS80U3MzRndRZXZBS1RNdmhmRXlPVVRYMVQ5?=
 =?utf-8?B?QnMzb0FDN1ptTmtDRnJPdGZyeEwyUkUyVTdMYmNYeEZ6V0FCQldhcVNVNDFp?=
 =?utf-8?B?WHd2eDEwQnFMcGQxazlsL2JnbGV1ZTZiWXgxM0VWWnduaU8wenpQZStTQzFx?=
 =?utf-8?B?aDNVMUxSZG9aU3d1WFpLVm5kWkV1Z1pkeGVkZlV0UHc3Z2dxbUZlNkZIVTBG?=
 =?utf-8?B?bHlmWGlCcUJpOGRUa1RhTjVwYXlQeXZBNVhoeGVzaGo2Uy9lSTlRMVo1UTBK?=
 =?utf-8?B?ZHlvTkJ5WkJTcW9jZXM1MEhEeGUzUCtIUkdvWWFNeE1HYXBtblNjUjNLVHdl?=
 =?utf-8?B?bVo0dUxUMFZQUDlONmg4V0lxaHJENnluMXNKYlJ5cFhMYzJkOTlkbVNheE5R?=
 =?utf-8?B?WVNRejl1dkRQMDE2WXpjcko1eEVIUFVFQlo2WFRWYXpselBBclVLdk16V1Ir?=
 =?utf-8?B?aEVjaiszTXc5WkRDRnFqRGxQL2IzVkFXZ0lkMWdGOHVhVVlYTU9kSkxYc3Zo?=
 =?utf-8?B?Q3UzYXBXNS9IVTlXbC9jWUMzUmx4d2dzUS9OdUFMb1RSZ3ppM1luUkpqWTJv?=
 =?utf-8?B?SzNaOWM5djg4dlhNc2RTMUZGSFZ3VzYya01UZFZ6NFd3SHlRNkEzNFlNRnFC?=
 =?utf-8?B?dnVxMWRlUDROdkFaVFAxbFJ4Q01aOWFwS1NzTU9tT2hWYm04KzZJK3piOEVI?=
 =?utf-8?B?WWZGcW5tTGtpVlMvSWVpc2pUcGJPc2d6UFdhNzNzMmhUVnh3Y0pheTFHRkp0?=
 =?utf-8?B?am1kTjg3azBoZWdDTUhzK3h3U1N5LzZ1TjJNbnFPcWhDRFB5d1VDOTJDQlhW?=
 =?utf-8?B?OHRkR25wY0VRMVdLYlZhTWJJZWdsaVAzVEpYNllGTWZicVAyOUdwcjdhWHVo?=
 =?utf-8?B?bnczTWM5SnhjUjJjOGRCeUtuSEliUDk0VkVia3hMN2xxNHNheU5uRjRtU3BY?=
 =?utf-8?B?eHlpUXV6WWRkNzVlMGFyRi8wZFVRbkJvNGFnVWtQaDI1eElXWHBTK1lwMjQ3?=
 =?utf-8?B?L3FrMkJEbVVoYmlUdFdMOFlNdjFXbXJlbUxBQXo3ODdQcnFWZkJDazI4em5K?=
 =?utf-8?B?VmpsZDVBNmF6b0EwQ2NnK2RVZDFqdWhKcm5FMVJEdXZxUDVDa3Z3L0xidXdp?=
 =?utf-8?B?UmhuV1BnRjFHTmJCNE1NRUlNTU5HWnl4QlNpbXJYWEdLT1FQKzFCOFNEbjA2?=
 =?utf-8?B?RnREbU5HdnhpZTdiSzJ4cHdpOExlWmM4QTF5M1BXS2FRQUQ5STlmRmN5RnNl?=
 =?utf-8?B?ZDdPOHJFdVZaR1lSK2FNbEhsRUpaaXlHM0U5SmRSYnBiVXlhNlR4dEtYVTdz?=
 =?utf-8?B?RjNzVmFyVTRBL0NWN0s3NUtLNUFoc0tTbW83REdHWW5WSTFFQTRBMGQ4Z2FX?=
 =?utf-8?B?QVBCZWdQUTF5RkZOdS9vcVA3Sjk2OWVaVkVZK05iNWltdExRNnhhbTFuQUE2?=
 =?utf-8?B?eEVYWE1Xa3VjdnlabGU2VXRrZmlVNUhWenJWMFR0Q09BNjV3ZS9qekpFdnhX?=
 =?utf-8?B?NnNiVy9FNnY3bElyUzVwNHJzUUdwM3F0MFZRWGw5WDJCdWYvdGE2WDhpYWox?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KWW3yoB145a6kOE8QqhOIA6iFd1uq9csphFDKpTe5kRGLtlkgL9rqjdkkI6hnoDGFSkK7mlh8r216IvzmhFmeLQYcYRcCoRhUgg6btNenZwRbsLQrxpaQysqh+u9d64FbaWt8Y/NLDjOcrKnZ5rCHoa0nD3MnFjjehYtn6jNcqnZsM3JZf5/RVMShQmn8oMYaDfWnMbB6zhLVQ+dYKPhmeHVL93IeDsGUpRfKrc1ZDQKjIByJVSHsnwJFNFQezTyWWG8xMMe6VpodBKc85FgxquLWi3WbQymeLCTe8O+rK53pVi5UHsBqFCLMZtju3hMkZayffWCgzaf5dji1bGG9vtCxu5SLjkXTP/rv64/ZTkpFYp3raxZQL3duenuaIvOrfFzauEMQVz7HgJwsyIFJymgMu0sEBO9AKgJXIhLdpJ/I0vGn2i/C8tmdLgB/EM/gydXxRibeWTgI6nq1K4HeB9S8ertVdg3Kdx1XEi4sVtWwHTKvAqMlVafMl0LNrDSZpjSzcvSt18c0YcKiHGzxdhDvZqQdgjCDYETIGA7ODqTmwcRUrVxnsaTuZ9nYsrdXhvDDyvd56z8G5LE1wmShiL7jcuas+WMQmC9GIC6+SgTu4P5lrqPh85h7UFFl8pKGPeKYWCmIP+ghZkLq0nolo5PQm0CqXxRThGmEGG5FH06f/WYblgGQLL8thZgmS7UNH8C9KdKPKNlmiizGtlmhOeZOrIohzsDMmNVUnluCIVWvOxfPaCZ17ODt4e3yybA9kibdQD5OsoekjsMUcax/OpwrjXTxfpDhrp/rpH6YGagdefqLkCr50pjhsWoVMqx
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0f47bb-1a5b-40b1-a782-08db7221b1ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 06:35:25.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x75B0+128rH/ej3J8ceCDePFI+rxM5znyAJLc05J4qiauWbvTcxv+gDb7Ay3zmtdBL1oa+YNBlh0Ss8gpbkBTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210055
X-Proofpoint-GUID: nppnC7_dyxq15QXuN2X1fMx-osa0H5Kt
X-Proofpoint-ORIG-GUID: nppnC7_dyxq15QXuN2X1fMx-osa0H5Kt
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21/06/2023 14:00, Qu Wenruo wrote:
> 
> 
> On 2023/6/21 13:47, Anand Jain wrote:
>>
>>
>>
>>> +for i in $SCRATCH_DEV_POOL; do
>>> +    devsize=$(blockdev --getsize64 "$i")
>>> +    if [ $devsize -lt $((2 * 1024 * 1024 * 1024)) ]; then
>>> +        _notrun "device $i is too small, need at least 2G"
>>


>> Also, you need to check if those devices support discard.
>>

Howabout this?


btrfs/292       - output mismatch (see 
/xfstests-dev/results//btrfs/292.out.bad)
     --- tests/btrfs/292.out	2023-06-21 13:27:12.764966120 +0800
     +++ /xfstests-dev/results//btrfs/292.out.bad	2023-06-21 
13:54:01.863082692 +0800
     @@ -1,2 +1,3 @@
      QA output created by 292
     +fstrim: /mnt/scratch: the discard operation is not supported
      Silence is golden
     ...
     (Run 'diff -u /xfstests-dev/tests/btrfs/292.out 
/xfstests-dev/results//btrfs/292.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
       xxxxxxxxxxxx btrfs: fix u32 overflows when left shifting @stripe_nr




>> Uneven device sizes will alter the distribution of chunk allocation.
>> Since the default chunk allocation is also based on the device sizes
>> and free spaces.
> 
> That is not a big deal, if we have all 6 devices beyond 2G size, we're
> already allocating the device stripe in 1G size anyway, and we're
> ensured to have a 6G RAID0 chunk no matter if the sizes are uneven.

Ah. RAID0. Got it.

> It's the next new data chunk going to be affected, but our workload
> would only need the initial RAID0 chunk, thus it's totally fine to have
> uneven disk sizes.

>>
>>
>>> +    fi
>>> +done
>>> +
>>> +_scratch_pool_mkfs -m raid1 -d raid0 >> $seqres.full 2>&1
>>> +_scratch_mount
>>> +
>>> +# Fill the data chunk with 5G data.
>>> +for (( i = 0; i < $nr_files; i++ )); do
>>> +    xfs_io -f -c "pwrite -i /dev/urandom 0 $filesize"
>>> $SCRATCH_MNT/file_$i > /dev/null
>>> +done
>>> +sync
>>> +echo "=== With initial 5G data written ===" >> $seqres.full
>>> +$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
>>> +
>>> +_scratch_unmount
>>> +
>>> +# Make sure we haven't corrupted anything.
>>> +$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full
>>> 2>&1
>>> +if [ $? -ne 0 ]; then
>>> +    _fail "data corruption detected after initial data filling"
>>> +fi
>>> +
>>> +_scratch_mount
>>> +# Delete half of the data, and do discard
>>> +rm -rf - "$SCRATCH_MNT/*[02468]"
>>
>> Are there any specific chunks that need to be deleted to successfully
>> reproduce this test case?
 >
> No, there is and will only be one data chunk.


  Right. I missed the point it is a raid0.


> We're here only to create holes to cause extra trim workload.
> 

Thanks, Anand

>>
>>> +sync
>>> +$FSTRIM_PROG $SCRATCH_MNT
>>
>> Do we need fstrim if we use mount -o discard=sync instead?
> 
> There is not much difference.


