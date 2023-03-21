Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4850F6C352C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 16:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCUPKP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 11:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjCUPKN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 11:10:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7486C125
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 08:10:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LE45J9016594;
        Tue, 21 Mar 2023 15:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uwv+eFFsLCPwkLgIHBn2sDcJdsaj9dX9xlZqxLYzYf8=;
 b=eY/Ep0qxSBWfs2OFcxnaW3VS7+p+k1Q4S+a34D8RAFHTIHwJ/UJHCMOVK6nY5higQY/A
 1z7Blcrbs0UQ4ybs0joX2oymBJrES0HKz6Pc5ILRey2TDetBs5YYdMy7HpQdlEqT6AHw
 rUUKuvD+t9QEkbsMn2B7IsWClNxEPHkoI2Gv8UFeVhL3bgNMDHXhNJxtnixuLmM0PWoz
 VPrXrtRsAO0651sh7VU6g2FIYT0vgDziovQgcxt2Orh9fi7dOa9wHvlpl9wQtcIJppNl
 USYsIe8y+q/9/wtmlZNgEZfEKJeF9R4Eue5lPaFewe5JJ435ve0BLZohuMijCxLvVOYJ UA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wt6hjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 15:10:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LF2ZZB038634;
        Tue, 21 Mar 2023 15:10:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3rdc7s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 15:10:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDIqAyCAY+fnGoT4G820nt9z1ktHXFsHTmWqK6Tag0grcEAxULRr4Xd1oARf0pdpXoosGkSQL1vldJrrJJQAeK4HnDXZYJpFLL6MZ2hv6osmjWEbweXy7FXsm+uwG/TibeoYadgucE/8TkvwgA5LarSwBhkLkVIrBGMm7hf+0DypUCiPsCaJK5ruggs4TkdHNosPrEVphb87bK0iQAiNIM9EcpuLsrCFLwTAi+JUzUTCiaAVLgyBZ4E6/ImyvgN+BfKzXIOaOyMDJBbrzzk+fEqqHhCL7YtVi+wO8FXJpQ5OlWfqWVUroxiuZnukNUPlXHjTalqmvMjnMHhwp/nP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwv+eFFsLCPwkLgIHBn2sDcJdsaj9dX9xlZqxLYzYf8=;
 b=juGZmgshruSeA1kS4qCVI2dhSYgM6yQ5joUmEeKXXbAqm2WrMTEWnys4JmMgHXP8dON2vyeRTIeEDCDaBaF/JIMGI7clUSolnhRH2WkxDW7BP/gG/6a1uWS1qNKNbp0AFNsHMjq/SsdEZXeT6H6unrJqzq3yxWCGcb4QLhh14nPMtvNsUh2aiGwfNWWutzP+24UDuS5WuX+tCcJnS9M/+dV6zqKsmmkTdydQB8T0M3MW1zpuyeaCgTjAcZwj1SOQwKS23/RzCoD7efpUdXs6wAR25lG22qOy5sKckUCJnHVf/ihBjkPOWriXJjBdshc1xVcX9c1Mi6zpaJcqUos7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwv+eFFsLCPwkLgIHBn2sDcJdsaj9dX9xlZqxLYzYf8=;
 b=Udz1U7SFptMnaaVSGJaJyJiPRnHnD74EO3MHdCTEkoteBj3QSAYt+ZM9cJcvYgCSK96SH6L9/qKVWw0z7VGFySwSSj0P1T82DMa7j4/Ir1mNzPSglfkjeuANM04HeWoUSBHNxbRbPJ3noa36bVWVCFWfoeAP4tCcBD7LAwxcWmU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 15:10:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 15:10:02 +0000
Message-ID: <8ba53d04-ae0e-0c6d-80ab-1cea19f08bd3@oracle.com>
Date:   Tue, 21 Mar 2023 23:09:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 17/24] btrfs: constify fs_info argument of the metadata
 size calculation helpers
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <9a763409b806ae4e3be981a554628e6f7dcb6fe6.1679326434.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9a763409b806ae4e3be981a554628e6f7dcb6fe6.1679326434.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: 068544cf-603d-49fd-9d19-08db2a1e5866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vW3rCtPONS+XK/SCR10rEciRwcUAE7EAdRKchBvzFsBGzTjXzM+GkIS92j1xef1NXRnMoo5imC7vilBxhKRGZ+psdlQa05yrhyAa8bB+BqUHhB3U7Un+Dqy18IH/C8odBcVtk1LLD7rYRRwQzkNyHqKvuH5zuEkwEekjhODfFGiLZNDpAqkMG9/5nQXS6YWyFiXK1NWeyc178ZizVCjn1tn+RzW0ivzQKvbEIZhbtFMxqJ4AzQyesTYCp+IZ9iWcWjJSe//vkd0mIJhFN4cMX/tIQF2dEqIE8hGfVf7LX13TeapItje6X8nDxH/Yf+VN6yoAci4INdfQ8JwK7SZp+siBwbxlLabXfmlazjAooRq4duCNKnNDbk06VG0A/NPdix29MF2CS81Axxm+xo72YVKcVLVS1ZjQ7IcSZvRA3o4aBs39anKf2emLS6pMfkaaR3bTNs1TED8fcoNN71HbMfeJz336cniZv9upx7ie4E85sVR0MqqdGnMAZKBi3R8eHQ3IsjDkCOuRyBLQMKxBH705EaV3IRJeUycu1ODAL5WwxaK7d8IKQ8kDku5kbqRIH688XFt7FzCjMq1bCfXPBA699jNv5M7H3Ui1gSATlJfBk3o85TCbCtIhKg2V/y2VONYGoUmG1TlsqvCjpVEqSuH24r7Sp8RaEEdT3sesJLmewCWb1IsbEB8XLeiybMe4/NDOsdtA+lZyoqoVdtJWJu2qo29kBOGutOdsVT6VAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199018)(31696002)(38100700002)(86362001)(44832011)(316002)(8936002)(558084003)(66946007)(8676002)(5660300002)(36756003)(66476007)(66556008)(41300700001)(478600001)(2906002)(31686004)(6666004)(186003)(2616005)(6506007)(6512007)(26005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0dKSHdEZGNTWS94cnM3QVpodjFObVZDNitCMUEwOHpTVVNDT0pxWEVJTWI4?=
 =?utf-8?B?RFpFdDl4dEdoeWlEUk5lVnNRcm5uTmxYbThQSmNRYmNWbUR1YXVqQXRLcGtl?=
 =?utf-8?B?NXViWkRtZTkxekZMOTc3ckVXUFNHaGN4OHRhMWtHMVZaSU42eFVybXppUUI4?=
 =?utf-8?B?NHc3Z3N4RjNBRUpISHBLdlFXV0RLQUgwU1h3YXMzb3V2cjhqU1IxODlHMktW?=
 =?utf-8?B?M20xeU1helY3MWJiakdvb29Cbi9MdnpUUVdzZmFkcVoxeWJQcmU1bHN5RXVk?=
 =?utf-8?B?QzhhVzFiQml4N0xKWGp4YVZHTzRZK3FyeEVZM1BHTnJ0R1piWDFiMUNobGFI?=
 =?utf-8?B?ckp0ZTc4aWRtRTNyOWc2NENBOHNDa0JTYTV3cHB6VTFWWktXRHRuMktXam5T?=
 =?utf-8?B?blAwckhOT3d2TkVleCtva0xFRVkwQU5lQjBKOGRHa0x4azBCdHgyMFFWblJL?=
 =?utf-8?B?dURVR3MwSFZMRnhlUDZWQTJveHVlV3MwQ0FMb0c0RFR1dHlqTHkwbzFsNytO?=
 =?utf-8?B?bE9kVEFwWmFBUExoaXVNbWY2QUNrTXlSRVYwODI1enpyTWp0SkJoOXBwb2xj?=
 =?utf-8?B?MStIaU5heFZCZUMrbHFzcE9iR3M4Ui9qNE1RR0U3UyszQ0JxUGVZei8wcC9C?=
 =?utf-8?B?R3kvZEtDWWkyejVNZEZmdG5XMlMydGx3VWdUQjhVQk0zb01KdHRhdE1oeUtu?=
 =?utf-8?B?UzFRYmt6aWN5R3c2bjBFQ0g4ZTR6K09rSDNxS1YyOHpTenBCWEhJSGFSbWFy?=
 =?utf-8?B?anJyQ1JuZldFc3JTWUV4dHZnR0twTGcvRHVhdnNFMFdYYjRjZEJRN2g2cFk1?=
 =?utf-8?B?bzJUeUNBM1d1UUkzM1dGV0ZHVHk4UVBISHZSbHArWFl0QW1WRzFGdWFXQmIz?=
 =?utf-8?B?cmJEb3hFVFFzcC9wSFBiZ3BaVHVTc29FeHNHSjFBM3V1a20wSTY1OUJYMERh?=
 =?utf-8?B?SmdXQlZMK24rV3dnVnRFMXRzVkUyT1FleHRNd291M3kzMnpCcmloTTVUK05I?=
 =?utf-8?B?WHFmS1JSQThqc1FteXVzdWw3ejhQOSs1MmU5ZmRUS0s2THM1cHNoWUdDQ09S?=
 =?utf-8?B?bXIxNjNVaWwwWi8zV2FYNVJVVCtOa1dNL0FVNFY3VDQxU3ZFamord3dFYkZT?=
 =?utf-8?B?QW0xREppTitXUXZFNG14OUtNKzlFcUNRcjdMQ2lHbi8vbTJ2TXlDTEhxaTNI?=
 =?utf-8?B?cEVtaHBhZENlU2V6cGRLWEs1S3YwN2RTMUJ6aWZ3M0NqanZJVmVEU1h3ZHhK?=
 =?utf-8?B?SUwyRWRETUk5dUt1dlpzdFFkUVUvbFc0UkJoS05vUm1zdTFhK2ZxSEE5OGsz?=
 =?utf-8?B?MG53Yll4bmNuM1RIOUVSRlJiTDFNM0ltVWxIeUoxaUIzWE1oSm1JVHBhem9N?=
 =?utf-8?B?a2R3Wm5ZUkxzWVk4S3BlNUJzbnk4Y05TaDJsa1poaGtZMDhhTmxlSGhMRm42?=
 =?utf-8?B?b0RVa1VSZ3hqcExURW1Iay90QUtXMjZReURwQUtsZ2FKbFEvNjJoZkZuZGZp?=
 =?utf-8?B?cWgxdkNmMWEvbGk5SWJ6N2M5WGhJdjc0VjVWb3RyZmp1SXdkb1Z3WkwvMWRs?=
 =?utf-8?B?clIwZWRZaHo1Y0lhYjFoL3ZaclJPL0YwSGE5V0RlT2QvNlp1S3V2bnU0TCtC?=
 =?utf-8?B?Q2Z1NkZSc0lTWk9WTnFMZCs2KzJRSXZMRkJWT2tObmFDMzZjZnJDSjBvK2Nh?=
 =?utf-8?B?Tzk5QlBtYUg3M1NUZFJpT0k2b1VZTnBsZE5xdi9sQmtJYkp4NGxPc1N3UVVQ?=
 =?utf-8?B?L2dFUTJWcmUrOUZscldlN05YcVNoUGxDWXUxUjVBV0d5Y3lnbXJMaXM4OGFQ?=
 =?utf-8?B?aTFTNElqNW92N1ZCRWZsRkdIRnJOeEUrTk52RzRQZjVJRmpBT3R0MkRBMU5T?=
 =?utf-8?B?U0k2VERCVUc3ZDVYbVVKc2hBbmU3RVYwOFBqN0Q1YitJT0NSMTlINzBXc2Fo?=
 =?utf-8?B?c1AwNjIzVXR2azBnSzZmb1R6Y0h0eW96dSttWWthUHVaMzJ4OUxzNHlqTmI5?=
 =?utf-8?B?c2JydzVRTGdhKzRNU3JnNmpuUkxTMFltcXIwbHhkK3pqYTFVajU4NzJqOEtv?=
 =?utf-8?B?RHhpREVnWUlpaHBOVlNYa1E0SS92L2JnVTZuTG5sTkpMVDZ2dkVKZ0Y3NFJY?=
 =?utf-8?B?TEtEUDVNM2k3V2MwaWliZG5VdEgvbW0xZWhTRThFZkhlNUF4alFpMCtlekNr?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LbWNkHsq8Em5gd/s0Ml7rnsOQAmKIWZuL+h+iZtBGB4FGqMoHBMxpAre32z1zuab2y8mrrt17H/HV8EnyO46/IiQxBOf2P6D31Wrj8SGK7LzjdR0HQaMvkgz5cr4BlDey+kLUyW6et0IMjn6DWtAKbPE2A9xj5534XCUYn4YOGvE7BZHQsiCoW8fJit3axFnHO4jdTaIgSqlaSdJEPYKi7o7S7pOOTgWZpzrkQL2E20XGJGvVxSiwdbKtJkEyaZ9hcBPzt8IbkzzlFAgmV+jMpV9IJLh9cPjRB9JUDYVJ+urjvQA1ml1OVJMRHf3MOA2EDDxeMkoOKP9i2TQkiVOJ/9q79NJFdASsAU7flxCgvIwdGqHmZVYH5Fvklq1uurs5SpTL04yrbZVtV5ZFZrNQsk0FYmPANdtQcugzVikdNw40+iW47fAuPuVV94sNZH7vyTZ9/8UV6br1h4mVsF9IBZAKMda5qe22Eq9XAb7T6wmXgHQqRDNIE1dDNH9mdW+xBEPAG81M7nKk+DUM01/fUYAZLyIlvVX94pWwOasBsVmtEkbeaN58aEzUG5qWCdpoZM83dpu1c0LYKwb5RuV+qDNspsWnTe43CY+sH2plp0esYrc/4YV5QBLLnTBqclQKdZgwjQ1AIUz9QOxF5Ti5frW1HK4eUAtdhNpfOSrq9JiJ32jGI/ePWuoeYqD1QXDYvDXXTK01KHHKltEPQoj6JcaXH+HgNeEUcGPVxZU4swQ73upJdMtqdzDWVxOqiGipBccw4oDUHld22qrIZVl3BES98R9nVanFjMZqQispNo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068544cf-603d-49fd-9d19-08db2a1e5866
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 15:10:02.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEr3H+/Eb210RGKf+GUM4G4hQwhn7hyY4HMHa10oTgLPwWNN6CzH+GWb8KfPZnzrAa0FqmSwmNncMeqmb1tVrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210119
X-Proofpoint-GUID: oZmmcfdpiRZe3u6ngBzk3VVE7eYhinXs
X-Proofpoint-ORIG-GUID: oZmmcfdpiRZe3u6ngBzk3VVE7eYhinXs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


