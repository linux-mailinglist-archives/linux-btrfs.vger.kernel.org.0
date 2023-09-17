Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C9E7A357C
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Sep 2023 14:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjIQMID (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Sep 2023 08:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjIQMHx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Sep 2023 08:07:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E79012B;
        Sun, 17 Sep 2023 05:07:46 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38H5IwWg010354;
        Sun, 17 Sep 2023 12:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0PQwh0cHzL1/gbPiJ0x2vSd8vADwP1V1TMfu56vt8H4=;
 b=g38atv2B34kZkuA9GhAqQF/X0BcqkPHiXA97TSkHxzRs1KLa/cXRzdQjI5DHJ9hiVcI0
 t66hM/HObOQA4i5KI3ymRjUNN8l0PAOF/Oh0cgQC1F/t5aB8VgIfWJr0WV8HVNnjw0jR
 iHfCzionG1S2yKcpjt8bXp773MwPGgb9ntKFer0YSfKXs2BMtGWBHDbtzdsj1pwmnKfX
 SLD4NboTu5qTkf9FC+aO2UihovZ1AM/5i1nBBoPfcbXzmWrC30zEucI3+YYyfnKsuAN+
 qRhl7ftGOHZJArof8EJ6qKXO0tIILJm5bu5UljJnzaNVFK5pQvjuyzNPmoZUOktpAS9c dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54dd185b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Sep 2023 12:07:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38HBhili012068;
        Sun, 17 Sep 2023 12:07:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t3ms73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Sep 2023 12:07:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ni5ihYTls6sMZ79M5VZokjQiv+yF+SlbPGvPds3dvsFy8XBZiwfmVrD1+ggIYMiwpTjBCB/x9jn5VdJX73ECaw7hUxuJralVnFW1iZm6ONjK6IxNY3PKPVlv+7D4WLXNbjEe3kLOGe87f0BnSuI+1nHvY563GQ8CC25GoYkeOPnM6MUCzLI/aYf49i3d8Cp3i99knFs7aj7inCt7bx/kpUvbXqrRZ37ssXu/XuggHGtNdVG1ZMyvE0bVlF2yQY6xEemuQsnaCm2dzURMmbbdyMjXQmpHnt7LVt7PkGwjmsKrroKeeZ8gWI1ZgXidWsscUTpUw1q+TxGIWh8JSf/QTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PQwh0cHzL1/gbPiJ0x2vSd8vADwP1V1TMfu56vt8H4=;
 b=IbjsP8YVCgadJl0AKijQ8jAxfAR7vOCoxQvBty7ifksuJwoLIEPg/FOqG4NinVmBDea5/pJPulNIJgGoVoCpIlsZz6BneCSoUViV2nnQE1RUx0OEx6DLK0U9vSS0IN2kRgkUW3jWRf5BbyR+SGv2kUK5SrQrzSTIkGoI8hjyNlLCzoDbypHbgs+DBM/5EtXgCNRWSO0s+C1EyaDkia74Q5BwNXX2lN3Hx+g7cY2nROr+TTtHHmu4GS+7zNp+NaqPb4KGB9AGbOSrwpfJOPIjjATf3KuOaAM9v7I48BrWivaTntBJNfuYAsBvpOG+cIAczZ7JEYNNlDOlzCMRdgH1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PQwh0cHzL1/gbPiJ0x2vSd8vADwP1V1TMfu56vt8H4=;
 b=TyMnvNEvxp3CRm5XRt3wf/CGUZQ5jB4GnZ2BpqhXaDzQumr2aBKQ2nv6i7X5yezrXJNSMDzURa+bx9PWafeRjPy1Rrm7Kxx4mAW17j7bMK5s3rsUFWg45QrqeEV58U5R1fZFrrgJev42iYdJgtYvgjDycjKUKnV8RWFQpGTt3Jc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7353.namprd10.prod.outlook.com (2603:10b6:610:12c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sun, 17 Sep
 2023 12:07:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Sun, 17 Sep 2023
 12:07:40 +0000
Message-ID: <87f9bf67-f407-e0b5-c29a-825eb4712392@oracle.com>
Date:   Sun, 17 Sep 2023 19:58:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1] fstests: add configuration option for executing post
 mkfs commands
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        zlang@redhat.com
References: <9c6d36835c04f18a59005a8994ba128970bac20a.1690446808.git.anand.jain@oracle.com>
 <ZQO6lmjasMPY8wOQ@dread.disaster.area>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ZQO6lmjasMPY8wOQ@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b0df33-a8c1-4f15-6991-08dbb776b091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BpkfCof8MudzDBoGMKyh4zz+WZJYKie8C3OJby9F73Bng8blk6Zg4FECUnDHze8BnPnnkqhtOc2OCk/PFB0msdCClXNN1Q6rRFuR1WWrqzEYAqKhoJlRXC8CkqRLlWifwG68Ygwt1HEKo1vY7kLFfcEg9Vmo+JuevU5pT5OLUHaWUUixREytt+SywZn0VNlTkG2npZ2V62nSgR4WbEyPKXarQ/vnqRyviyA/lc/9fH7TkDHoLWjUXSVtTnVlOa819j9XAByVNxFm8SmC+Q1CtHl+JgIoJ1j+vJgjIBShZB5gclnVUSU4pPa/OrqDRoc9A4+SEuYvH2/m4ODJ7lTWGdUSl2I5zUV04eaBcj1yBVcrD8eixjtnQfbfd+gZ1eERwN51WpAU0y6tG1AMFqEOcbFtqVyuXoYgIzKYoSZ5fnoHufi5P88w3EWyDNaT/KqZ5Veq0s/oasC9rkRJGuMfoCoSAXJ06Y14k5T/NUyRwjZL+i7Xa973OqcFWoZDkLA3lmPEwVwzOLDSUOSzbgkLRKr1l82ZBbmgzQ6bPnx/LhXbaMKLo09OqhOxzP44KwWaaTejrlOyQwCpW/Ixfh6nbOQ935rwVyQM46M2rIFYNOiAyQtCA5rTpqduZyaNw5KzwdJuislhdDPj5hNUaGorkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199024)(186009)(1800799009)(6486002)(5660300002)(44832011)(6506007)(86362001)(316002)(6512007)(66946007)(41300700001)(38100700002)(66556008)(66476007)(6666004)(31686004)(478600001)(6916009)(8936002)(2616005)(8676002)(26005)(2906002)(31696002)(36756003)(4326008)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L08zeVdRTkpJWWI3dHk2c1dnOCsvZmVsUVI4ZC9JYWV1aUNRUlNFNlIyK1Ew?=
 =?utf-8?B?RGFDNHoxSEd4cTRETlZHOU1leUFTelVmZ29uUFUrcFBuT0ZpdldOc1NBUzgz?=
 =?utf-8?B?U0tncldoZFdidUlTcVE5eVFVU3RtNEpPUWhEWWkxdy9zaDcvU2x0VDZpVkxW?=
 =?utf-8?B?elBOWFJQYlVqWUlFYkxETjM4d1YvTjVmaVVoNFVWdTA2NEEyL0RQYUJjcmVs?=
 =?utf-8?B?OUtqRzdhS2hGMG4rNFFxZEdnRGt0WTlGMnlMSFVkVldoOEJsTzZwSmlIYThQ?=
 =?utf-8?B?RW1OT09PZ0ttbk9LWDVCcStjclZIVm42YWR5ZmlNZnFOb2pDZzVuQWdKLzR1?=
 =?utf-8?B?Zy9aSVJKbktoTThlRnpCd1V4S0RvTzVQM3RkSDQ3YXJaNGlJbllRUmtIb3Fm?=
 =?utf-8?B?TVJYTFA4L3ZHeElvRVlTUHBYcE1NdVFUSVh4RlNmdDhSSFZjT1BYVDhSSzVO?=
 =?utf-8?B?QitRc3Y1ZWRXMlB0UUUwSUJYZGh0UmVGS3ZQYVY2RTBORFdwY0ZMa3NwNC9T?=
 =?utf-8?B?aEhMSStYZTJoOTlHNnlUcFpxaU9SUmRxY1ByRlFvWHZrRGxzVXZodVFQMUll?=
 =?utf-8?B?Zk9LUXhWL1kxZ29nUEoxNjRYOEdQL1pWT0FaZDBtRTZQbDQybjk5WTRjNUFM?=
 =?utf-8?B?VTFLQWxUM0RzelQybVFIc0JSOGVKcGJaT1NUc3A3NEtRRi9hWE5mYmFpZjdG?=
 =?utf-8?B?NXhPQ2hBWWc4bUxXSWdhQXZFNzhwc0ZERmR1TERDTHQwaDBuY2w1MnNjNFRl?=
 =?utf-8?B?MUtrU0pmc3MzaWlmZzZhclJjMTRabVpTNWhtTGpjZEFNMFl5aHJvbzRCN2VB?=
 =?utf-8?B?elJmbWRjYW1xRGRZUVFvZ0hZMWUwSXpmMEUrWjVWbVZxMzBPTS93RlptVkxv?=
 =?utf-8?B?aGxWK2FiQU9pcTNSUjVLeTA3c2Ric1RlU2lqcjVCbWZickcxK0d3QTd5d3hy?=
 =?utf-8?B?bnFUeGFZazV4RDl2MzFBc3F1TGRaR2JSRXlOSnBPZ0NSaHdiWUlkTGRwSjE2?=
 =?utf-8?B?dFpHejU3RHcxWERCS29oR2pCUms0L0F0S2NRQ0tMN3A5bWtQWUs2Q0lOU3RG?=
 =?utf-8?B?MHRnUURxa3VtcE44WjJicEVFQkFMMXBqNGxnQXpUZURoRTdVZ2RYUWZ6bmV5?=
 =?utf-8?B?d1FiMFNLL3RxY2FYRldIc2JzMWxLeUNMaEtMcFZzMTB4VHExSTVDTlc0Rmdr?=
 =?utf-8?B?N3pZV05hN0hkbWdCZHN0NzFWYTdaZTFtWVEwUmxzc0RHU2tjWnRyODNkZnlM?=
 =?utf-8?B?ckpBdnRpMEg1OTlqQXd4bVlLblF1NWtSZHVnWFBESEpCbUhTcWdPeDNFOUxs?=
 =?utf-8?B?cjNDWngrT2dvalZ0WFBVTWpvNG56WTV3M1hsOWRRL1NIZ1AxTWpQOWZlMU9n?=
 =?utf-8?B?MTh0WklSTmpBVXpXc1BrNVhKY3ZpKzNmMjBCUVdQdDlOVDBWYWVSaXhrNERR?=
 =?utf-8?B?ZnVuOVh1dEhXNEJIWnl5MDRsU01GYy9iZi9JZDlURGZzNlU2NHg2ZmlzY2FR?=
 =?utf-8?B?MS8xUVd3OW91TmVyMFpLWiswWTBFR2VEMUdlSHVsSGZMUTVSRE9kaVB4MzM4?=
 =?utf-8?B?QUFUNmtyd1YxNUNFUDYxVi9xbmJuc091bldKc3NmNVdjZEswYjRlUDZvaVc3?=
 =?utf-8?B?djd2VmtmZ09NR2xWNDYyam5PZXIzS1FBOXJKUDNrdkZiTFMxY2FTTUVwS21o?=
 =?utf-8?B?VkFBMmxCYzdUb0pUR25LS3BleUl2d2tWOEJVL2Ria0FIaDFPempTYU5jNjhv?=
 =?utf-8?B?aWZNUVlucTR2VXhzNTZ4c1RRekp6TXVzK0p3OUVISkJBNVAxL3lXNmNRV1ZS?=
 =?utf-8?B?UEdiWUpZd1BjcVhrKzcyV1llUjZSYWhOVjM4TnpnT0x2ZXdsSm94M1RkYVEr?=
 =?utf-8?B?d2JJNHlYeDZudzdSRzkzanNKdGoyMFUxc3dhTktwTGx2M05PZ25YdUYvS3dW?=
 =?utf-8?B?SUhlUjljY0oyY3lHcCtUWk13MTljZEVVaDZvVDdnTjRUbXpIM0h6M0lnUkwr?=
 =?utf-8?B?bnlXaXhTQmxEV1MrK1V2M3FZSlduNmdsbjVwakFkeXZQdGU1R2dOZnhjdTR2?=
 =?utf-8?B?ZTFUYytKZGlmenpHWFA2RmYyWUl2U1ZHTGZMMXVjdTRWRm9UQy9nSkhWd3Vu?=
 =?utf-8?Q?CbwTDGB1+YFgtBDy66dZbvfG8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b0T/nco02lZoSKNNQ6MxRbGTQHm/xvR/M5K1NwK7Z8cinB6+1KRQ149/KSGPX9LSrgouDbuJA1vmtI+joaua8VdPrIuRk+XEQC7n+Ln1ldqGab6Bq3ypMmUh1YALPsmS8eZ8oSpEuFda9QdJ3DgDXG+FWgee963IIitvJ0IKhFvq8abEPESbv4ET8cyetN4YGPPnAF0ysWkKscpL8jLor6p3kKnNRKqXZpr5pRK66StKGy4oPIGjGWywNLsaMRIlVu8+gC411VcxVaP4c4dVKylgIl2KZdjTMv1dehjzpyRmUdcB2GeG8HX4YkxiKN2OPio8FgOfIGogNYHIDPnH72i3dxDysinYIEOtNOodGT/CapucHke7Cr0VbJ03FQX6xTVF04OF7xvVivVCcvtMKuoqJAVUv4ugEFSTk+9J1iZvz2SN2H2dC1xiLI6MxS4Be9mewbzbJYrYxq2H1QoJjo2f9Do9656NQG5caMoDytzALctNkb+cSuwOGZBxb9j3G7iGjb2WOm1NTf8cZXS5DTKF9Ab8/5zvacEoHcwaV3e0IYOUQU19F8C/jmhtLX3MU6bxAkfYiwLayn9xywxZLLLvdy4eYMx20aOaF8+Vgc/6Bnr/T4j+EvX9EGOrKbA4p7/SpQtjXmUBnN2936iT6cKzSdLUDd1JQX2RRg1Jw6hEeQn1qFWx3j9FiL+Y8imbR1junmxE6dqFmh1V5wPosRVxSGfaQgXTPjuwhqHVP8sQzxqzUF+TL4BhofrCv2MbQ5/t1dfxgUEP1/mPRr2/Y/tVIF4T/+COXJIkD8/ko7LsDUUNu1KLXBprjru4i0Ono58aG0/s0cyuI80iJcSScw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b0df33-a8c1-4f15-6991-08dbb776b091
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2023 12:07:40.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jT0UEP6q+uixiJPvJjUf1DKe6CQ1Ms0Nt0v7fkiOoL9Lc2FHBr9f7VB4IHPsz50PAPmxWoNViSvF6C21Rk+6PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7353
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309170108
X-Proofpoint-GUID: mQEwAOB1hlqDBWYYjMh9mkfHBnGgvfdB
X-Proofpoint-ORIG-GUID: mQEwAOB1hlqDBWYYjMh9mkfHBnGgvfdB
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> In general, we've put filesystem specific post-mkfs commands inside
> the filesystem specific mkfs function.
> 
 >
> See _scratch_mkfs_xfs() for example. If we want to test TB scale
> scratch filesystems without requiring ENOSPC tests to fill TBs of
> disk space, we set LARGE_SCRATCH_DEV. This causes the mkfs function
> to do the post-mkfs creation of a hidden file that consumes all but
> 50GB of space via fallocate (by calling _setup_large_xfs_fs()).
> Hence filesystem filling tests don't spend forever filling the
> filesystem, and no code outside of XFS specific functions need to
> care that this hidden file exists....
> 
> Given that the use case here is to issue filesystem specific
> commands rather than generic setup commands needed for all
> filesystems, I think it would be better to encapsulate it inside the
> btrfs specific mkfs implementation....
> 


IMO, making it configurable and generic would also benefit other
filesystems. For instance, the XFS filesystem could set it to
'POST_MKFS_CMD="xfs_admin -p"' or something similar ?

The design choice here is to create an open and configurable command
variable. This is because we have several commands and options that
we need to test, and it wouldn't be practical to hardcode them.

Any comments would be appreciated. I thought I would check again; I
don't mind hardcoding it to a command specific to btrfs only if
you still think it wouldn't be useful otherwise."

Thanks, Anand
