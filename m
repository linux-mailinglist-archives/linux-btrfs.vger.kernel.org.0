Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC8D741F51
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 06:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjF2Eka (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 00:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjF2Ek0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 00:40:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6B02132
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 21:40:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1qRYi019785;
        Thu, 29 Jun 2023 04:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FUkugLA1edykJFhcDd6fWPlkxQ5nH/veiAZI+wi+v2o=;
 b=xQr4N8mwYdCP0cuqVdBJbHqzg1DEWTI/N8POBTllsZrjPnLqvt1jmPU8yxeoxdfkTUwR
 G8aCiyUzsuH6p3wkvESRvcrzIE8Om2i7rTBaarTVZtbYQ0OTb1JBW4fJ9E9wuDLIt5mJ
 hu7/iUKWJHIm5eUGXpb0NfhLYKZizl3CcLwXUabLwmx7vxlRsoi+MUHY4Mt89VAQLRdl
 v/9sN10a4Or4RfCrhvmkl0hrplDaoHSGUDUYPlz/0oB+wh2hzzqGRDuhZKw5FNgAv/7Z
 uyZk+k4F+iK0/wtZpXJROKgypTl6mGofRFzA78NCdxjnXj9nWQgadClH5rApLGiC8bBr QA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq312k2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 04:40:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35T2e70m038158;
        Thu, 29 Jun 2023 04:40:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxdeutv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 04:40:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGfwHnqLX6UlHpJ+TIng49Lu9Qk2hccON3vIWtS3dk0YHgkvhOFQ90Nws2LioPV3J7kJV0HUMorkGRQ3Zpm8/w62Gjlm0L7eyjNVCNst+mOMQ5HqfNOCbKMRVS6DJKIDvnu9B//AV8+aOHReLGMzSHgwRCMWTNAYxolK72CCpso0jKLr2/W2oOAVvjHSuw8J7xxDb8+gOF9isQImO7QRmm1prXDs2Ko5Z6FKyM7fqCk2c2TrxgqEQE/RlzMovC7PLp0amG9dVbiapBYaQf+49zqkdviKMT30qf6lq0O7CaYQ+x65Dj06UPFgnNViyua0e7fcXpPrxQps1EXEb0V+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUkugLA1edykJFhcDd6fWPlkxQ5nH/veiAZI+wi+v2o=;
 b=O5qfbVOWU+bWtXL2DJ2SBLyr+87o8kK6x5p6pvFVzOtm4549gdInPjf7IGqkSUdtB5nC6JDD27ctYtdemiLN754lSDRr/+wG3smhiCq9b/r/ZNw3vp7pMiJCFrpJsrSwXOpzrFr9f3ARHl7kyYkboyiY6zd41MYdkxsckZl9FFSouO6qVk+pwmV8P6PE/xW9frLbPLihKNVSBb2VnEeQY1Wux7QCYFW3SMoIURa7Kkc0fbdDedA5ggYZr6J/ObAfb4zYaa6rzNuX/rq1gDfupEM9UFxsm4zhbJq2VyRVkdk0qBv1cjVAb4BIK1yxC+KoTT+VKscA2YEPHza0an5qZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUkugLA1edykJFhcDd6fWPlkxQ5nH/veiAZI+wi+v2o=;
 b=qL3hb3N5HyM6dlsXNG+Rjsg1NyaHHpYT5duffVbmzCRPlfWc8jFoyNgdFU9genUP+K/TlcN6aO5uGtGBZKZTESqXreg4NpYl6IQHqjJJQtVu7FbsgPcZkqqr3WDnnoz9CWlYqL6mpcApRJr9ExzxwG8fj6EXWzw4z6FjIMQ8bBc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB7513.namprd10.prod.outlook.com (2603:10b6:208:451::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 04:40:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 04:40:00 +0000
Message-ID: <214471e3-43d0-5f13-4c54-00713553cd7d@oracle.com>
Date:   Thu, 29 Jun 2023 12:39:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/3] btrfs-progs: dump-super: fix read beyond device size
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1687854248.git.anand.jain@oracle.com>
 <6e8980b7306716ed8a71dc50868169ae96424e79.1687854248.git.anand.jain@oracle.com>
 <20230628214153.GF16168@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230628214153.GF16168@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: c046c653-adda-4f7b-3311-08db785ae5a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMJAVI3PwkrDzZHoJTMoWBqLzj+mWs3EjqlBYJ95fV51HKeNQ3Y5JGdQg2iW2WLbT58ygon4aLrBl3abpEEd0eDhyhh6dJO2dz8q8MAiHUkslUPDuMLxsz0NSkbDuP6Od1W3NtJeEvkU+t4grV8seFvbMcZxuQkjfbenDFkpg4kjBA2m69H5U5gyL0kXW+/kLTCqNfm+gQT9Yh+6H2Vyn6QeDoecPbJaGEAtALo/zVCQDmIRdH4aW3L3u0mu/YGBNjOQa7zkkSuZ80ZpKdtFH2lq7WlWCB1mH/EXpdbKoLBox3RKdw4W4N5eeMcOYVvIEOEQRB/hKqbyUvf/cBSV3qRut8P8vJwHtOVfyFJQvGDR/40t5YW3to8y5HDq21ndxATSeHaReHteKhLbVl18UVFpMdYQecxvMr7R6IwJWyqMZSPhrA5p/JMX9BnkytO68OLLh8+RKiNVnvARX8NJKGgHnMRtRR3w+R8gFJ6IE+TDyn/xN4NlhNhCAFJCj40sj8TSmeeQo8f+fX3DP+VMvRNur9Lp/eP4geKg5iESeDRpxhyMd/wcW5QRYhG9oDOZ/XKEBbXHf6/PQA1cJB7Pd0lmvNkdvv5YznlzRXap2KEPlxgu+HkYZLyh3+y8NSmO5CZ3O6NLaVHCo4kHTD88KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(31686004)(6512007)(66556008)(66476007)(4326008)(558084003)(66946007)(36756003)(44832011)(86362001)(6916009)(316002)(41300700001)(8936002)(5660300002)(8676002)(31696002)(38100700002)(478600001)(6506007)(26005)(2616005)(2906002)(186003)(6666004)(6486002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2Z1c3pJa1NQcE44RDJBb2RNSVdQcGNPZmJIbk15SWE4NjVTY0h0LzFTTlBR?=
 =?utf-8?B?eXZCaU4wU01QNVlTRnZZUmNTbDhkYTlsMk9Pei9Kei83OGVvd1NpeFdHaHZq?=
 =?utf-8?B?YWU5dnVtdTdGZ2prUXZtTjhwdCtQbzRrekF0cG92d3dPb0V2cDdxb1REeTE2?=
 =?utf-8?B?RUtFQ1F3THEvdjJhK3JrQy9hclZyR2ZrY2FiakNkY0d0WFZFVUJOWGJwL2VH?=
 =?utf-8?B?Zkl0TnhtSjVjQkhrQzNoSHV2eFJJaTV0c3cyODd2YS8vcHB2M3diZWRFUmp3?=
 =?utf-8?B?SDZ5TDIrR2JIUktXU001NVR4OTRzVERsTUJsWlU0bnlaejJmTHcvb2RwUVk0?=
 =?utf-8?B?Y3FUNEpSRnBYaTE2a2craVVkZGk5QVUxWDVGc1kvblJuRTMwdWRNTkxrWHgw?=
 =?utf-8?B?YW9UVXBhSGJEcVJjbVgwNU81MFIzdDZ6bzg1NEwwKzFja0lMMlVEaFJ3Y1Yx?=
 =?utf-8?B?NE5ERlU2ZnZISWtna21xeHl2MWxyOEtyaVM3MDlSQzFKWWtWd1JRRW5xUDdk?=
 =?utf-8?B?YlRibmxaMzhGNGRHRXZIMmR5a1UvMlRUNmo1ZVhCbmRDVXY0ZzkzdTl3NFA0?=
 =?utf-8?B?WWRweGFuTFMzK2ZVVnU1djFkVW1zMXRSeEVHNmF6QnR4cWNHSlJ1NUU5Z3JO?=
 =?utf-8?B?WVBJUXFxSDByTUlpaWw3dFovYUNPdlFBVzVIZHZ4cGlvY0NrTy9PRWd6bWZD?=
 =?utf-8?B?TU9VU1Uzb21ZVy9kOHVkN2VJdUN6VUxOUk5ieWRMVFEvRmcwV0RFSk9DWE14?=
 =?utf-8?B?cUVGbTZDL2JTWEZLT3gxSS8wQ0dHMllaYnJjUHFsVkMzMWxTaEtkQWpnaGFV?=
 =?utf-8?B?c1BwSjVhU09DcDZ3ak9pQ3cwTUhPU2RRQVdaSmdjYkVMVk9yWE1YUlBQUmQv?=
 =?utf-8?B?N2VuNFREdVRzeEZvbkJHK05nbmhZK0ZueEVCN3QwNTZka2d5R3pFSFcxbEtQ?=
 =?utf-8?B?YnQ1dWRqMDJsS0UwN1QvcnhFRzc4ZlNYUzZOamV5a01ma3RBOStkUzhDVTZP?=
 =?utf-8?B?NXFWZWVmUW1NdUh4NHhWSi9BclBCeTZQZndyTHR6VUE0VVBWcVZBZGgzZXpH?=
 =?utf-8?B?QVhhb2NKSUd6VXB4SnVhUjF6Mk4rTkhzbEJGMTNIcnQwZ3RhRk5FaFJiZys5?=
 =?utf-8?B?Zmtjd2tjRm5Qak1FVXpJTDMxbzFScDQ5VXFBdmFLc2NQVy9zOTRMWStyeDc3?=
 =?utf-8?B?bVlFRXJBYzhkQXArYmNXRTQyM09CeHJaOTJXWVpMdkV3S3U0YTdraGpSaXJr?=
 =?utf-8?B?R210NmF1SU9CZHc3Rk9EU1NocnpqNDVoaXo0dlJ2MGVMaEcvaHVSbUhLa3Iz?=
 =?utf-8?B?TmJnUUxreHdpMTdmOGY3UElxUjlPRi9ZaGRNMEV2WXh5SnJtZEtFdC9JVUZN?=
 =?utf-8?B?Qi9vckZSeFRMRXh3bDFaYmltZWZvdTZkUUVKeUZkYWhTOFR1b2haMncwdk1y?=
 =?utf-8?B?QncvNDl4RTltdmttc1grMXdFS3dXR0tCS1JuTTdQbFhHZmJqQXBhZ3F6NkYw?=
 =?utf-8?B?MDM2U0dZRUIvb1lMWTVXNGszU211UkFqaGtQeFQ3a0hNYTcvRzBFckNkcmdv?=
 =?utf-8?B?aWo3Q2tLVzdFaFZZUDZiWHF2aHlEc1VabW1tL2prK0lzT20yUnBFREpWOUwv?=
 =?utf-8?B?aGpVSzYwa1ljYXA4WFMwZnlQd21tTEhXanZLWnFMa0ltbU1xREI3L01JOXR6?=
 =?utf-8?B?UGhkc0R6aTMxTjRwS2R5MlVoVlRXUUVDVnhFOENldndkV1RIYkhWdmlwMUo3?=
 =?utf-8?B?WDhtZjE5SzlwYU9nRktHRnp5eGt2VWxhZndFMzRNOURlazllZ0JERnVKN0Ri?=
 =?utf-8?B?U0d6L3BudEJJdHpwSWJMUGY0ZGZBMHo1UU93bTRrbmZ6TFR5b09EbGM0S2JN?=
 =?utf-8?B?cVVob292OXdGQzl4djhoYTVvUHhmVG05VzRFRlRsS29NanU1K0xvM3d1blQ1?=
 =?utf-8?B?U01hdVJMTEVGRUsrUWNrdGcwb3VLQkFzTWR4NVY5VUEvMEZ3SlMyazJTZHpK?=
 =?utf-8?B?cXVRbHlZdkxVSjJHNlFLUnQ4TzI2MGNYWnI2QlBPbU5XV1ZtN1IvUW1yTEdI?=
 =?utf-8?B?eUdNS3Jua2ZrcFl0aERRWHdsQlNEVDhqK3hrcjJuN200Y0ZoZ2FLai9LUitI?=
 =?utf-8?B?cmQ4bFZrcjhON21XWUQ4RTRmQ0dpNzAwdXBXamRVaVN5YnBVT1E3dFg1L3Bu?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WMUDWXAbv0jBJo0mozMRt6pOzBdLyNuhanmwA1QRyJIFrc6MBnoOvW/xKm7mEn2TrHHazbBOLWoHZ9/Ky1993h71q0ZKdBSxAcLUxq7wFEOK4qPT4HmyOPoJ9uTXAMosqc0TPYe/IfsCub6RUnGnqcvUO2r4Q/ZEN00z9vHouJxcH+oJHVFKE17VPHx3OsVCxGlAjUKiBE2aF2bex256GQw8V6Bk8qQsSrqVjG34MNBfinyBJWd3eGUXwke/tOyqvKR1ogpxyB0StnhZoRfWEObG2woyDjoS3NKR556JpCPh77rFv39PW1WXnkY1JMmlBLLnttSg8Lfou0aFH/qiBdoEEuYYfA/L95zrzbGVT8gw5Sedc/A8GBNi2bAfOpJ46o8ONf9P9C8uty8xhMtr9bMR763pYu1T9kJ3Rzr7C2j7euNId6BOr+vhpXaHCggChvymuqz83V13FAPYeTZAZ/e7DAbsg47jRKwoDh7nLbph7J1+rC2BlRNHzMdHIAwwc2vfQortbTtlWr58mUWVamTf+skiZOi6TfEb5ymkYwC3nmsRKyYtyztGGn8VjAbslZtJita+I3vpq0oI/uU4eNRD24llyE7VsIhSX1fAzsdyBx26Cb7z3KKiQlUem71Ye8sIMgO//BWS8G7GupN5ZC2JfsabBXCSb/BNLBxb3oWhGoIwwJ5Fo+eDGkdjrUZ+jTHVFafa1UjSEzTYSLV+iOHIxVoqsrbvteiaKqPOl7x92wLkIw+BLC19rX/H5I/iFR9BbFRYBVu75HczUui8XNu7GD+3WHrwSv0y17illZQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c046c653-adda-4f7b-3311-08db785ae5a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 04:40:00.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yg0R1OqXkOoYjmukOSTUng7SS5zgZaFpHHZAd1SlEBn3vu4yGNaBADo4mvIQZwPvE8ggqleDJszZmpQed2TR5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=892 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290039
X-Proofpoint-ORIG-GUID: fePDG5OjdM7T9_Z3OnlmvDUF7Q_lqCwc
X-Proofpoint-GUID: fePDG5OjdM7T9_Z3OnlmvDUF7Q_lqCwc
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> +			error("error = '%m', errno = %d", errno);
> 
> Such error messages are not useful, there should be a description of the
> problem with %m for the error text. I've updated it.
> 

          error("cannot read end of file %s: %m", filename);

Yep. Now much better.

Thanks, Anand
