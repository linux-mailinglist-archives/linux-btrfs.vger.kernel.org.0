Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095EE7DC345
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 00:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjJ3Xsk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 19:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbjJ3Xsi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 19:48:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF174101;
        Mon, 30 Oct 2023 16:48:35 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMwuUi011069;
        Mon, 30 Oct 2023 23:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=V87iXXBpwrQ9kprShma3ZJO3W+hQE6O5uxG8Zy24lCM=;
 b=ijXbXXOvf2Y2XtehRuXreutHVkiCCgmMA6LCrYO4hh+nWyEU9X3OmXik93eOugxZ+vyA
 oIjpiP3esBUoH3TeY+LZ0sPa4naLhagp5WA4nTT4HuGfWu0454W0ThOlSFZsrcQaP5YI
 eMUmJ/Rxz0YEuQBTDxJt5c9c5T/qGG8OiX8/xKvs9jEPqLD5xeFxIlxV6ayTYPepZ56g
 neJKyA/Vg13n+MZciflY7QsHvjT/F9es+iyMkWA8CLhfB4gXpozUCUhVG+fa800mcYfw
 /gEsr182Y0WFIgv42EYoNa1/hUSM2vD8q/JYcsYCe/6loCqsVanK/CI4c21hjAQcFR3H 4A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdkv7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 23:48:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39ULKOnH009166;
        Mon, 30 Oct 2023 23:48:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x4uah1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 23:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVNB5/vjo3byOCRzBKinsVLu9A5cGt8R9AUAGbVDdSPNsnBoi+cP92Icae4GF1PIgssa+VGC2AuZoIddI2l07tmLM1f3WRiQ7vSxJWUEeCqVt24lnVfgoGKdNpUbNVLC+QDdzqmG00zpmjcHDOcEKgEflA/zyo+r4djYx+UdPT4FpTkl5KPjWbOvmmoLfgSdtSyX3v5qj+JeOoou7S8r6/bRpvXoMcv0Bjktomk74zDIaopHpx0/joHHao7jKIBJboMXdMtJeJEYJnn2N0qIO+6JNqhuuDsy3H2jvB16MTrLcheoZLQXwAKB+SC/II1/YQYDaxLVgZKhyjC7ofygRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V87iXXBpwrQ9kprShma3ZJO3W+hQE6O5uxG8Zy24lCM=;
 b=DY1vCZpn+f9lknhXIsmZ5cZmCmHQBbOju4yDHz0/eSbtVDC1L/bJS0q3FrKSv7g4ihTs3GBfFEbZ8gs5q/9qRismbdvBXlbinQtUD41O4z+SXQi7zHcGAt1Oa1sVFKMXGPUP6sTtMcwNlbRc+rb7pwBQcccFqiL53EQzbt62DwojEI1/oaq5f2U8Pxsjux9nyeiCBX9ak4RvXXAaIU7Mc2o81av3b3NSf3ZBfTpyrbhpXNdKffjJptXPc/fEp14pOA6c2kwZwxjvVJSEgWwBUSx9O4UZpEaty70YX65OVhTn86D2pw87likcu5R3zKBudlzJuoBMnV48JHqhQdTtOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V87iXXBpwrQ9kprShma3ZJO3W+hQE6O5uxG8Zy24lCM=;
 b=uGgqGsd5mO1yPg2gTHrvgEgWsRm56a/4ECiJrwmD9rQZ/qHYtZapZjwTkLJ7yBe5Ii6YtW0bZim6/F5OQQk093lIRDkQttb+NzhUQYdo1jXcU5XMi9P/nOVOmLk9LHXPhB+sVHA1gnUN5MCEm8LZ1rbuES3axhQq5PymPcnrRDI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6217.namprd10.prod.outlook.com (2603:10b6:208:3a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 23:48:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6933.029; Mon, 30 Oct 2023
 23:48:28 +0000
Message-ID: <f3b1e097-b692-4016-b44f-fa79941709ae@oracle.com>
Date:   Tue, 31 Oct 2023 07:48:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6 v3] common/rc: _destroy_loop_device confirm arg1 is
 set
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1698674332.git.anand.jain@oracle.com>
 <1f320bb0c1e11dbe441dd44eac006873de5f267c.1698674332.git.anand.jain@oracle.com>
 <CAL3q7H7P+U0a2a4SeeQKXm3-jDZcnoXhrM_4mMHdTiM_iG7dvQ@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H7P+U0a2a4SeeQKXm3-jDZcnoXhrM_4mMHdTiM_iG7dvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:54::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: cab57b10-ff47-4e9b-d705-08dbd9a2b72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/xWsH/7xWQ6X4oWfREQObUXFOoaujSGATqlPbJwFDjKj1iC6BOxhwaw+5xtvAF2JqN/3rqw1vYjW2MOlwrWx31tLbwjCpl/jjNWLgYBGZprZFo4zPZ6xU/By05kqWnAneswnTTubSnaSItg2lM83gC2LMrGRo7Q8QB2QG7U75AY1DdqTDPGC/DBZHugroln9/OHDvnnZKhadxA7u/UAJvRj72/5WOIld3Srei/6zkaNHKto+BqTgtt0Y6msXFuN0zdl5sGRX6h6PKKfA/i+RF5hkb6AN2fVMKTYyuaeT9Jy40nQAtJeZ/FePgqfcq5VRmdrLSCq0TVJQV0nLA6y1gSHKMULrT44VkalEdN9oBWdXuZNo2zpPF19T0QURLlpg5w78guB4LigOWCiiurW6o6NDPyqFAdOnjaTR2tj8IDM6rl8ByTwyUowpgD1rHeLDzwvdz3no+gXF70Kqr0K2KD+6b9fU2wx94TjguCCZVca4iQSvlb9pktevzEI+ivPbsJ35yP1vcDj5nb6INl9pfkSvMCgbL5lPSvegp6rPoN/KrX9JnG/ToYk20UEXb7llESVneMvxj/pEIN3remXuyHl3sXtsuA3D74secaa8e4kKWvHTQxeE8sOpm5tl1Q+sx03LeCywlaX/4DkpBRuhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(36756003)(44832011)(41300700001)(5660300002)(4326008)(8676002)(2906002)(86362001)(31696002)(83380400001)(38100700002)(6512007)(6506007)(6666004)(53546011)(478600001)(26005)(6486002)(2616005)(66476007)(66556008)(8936002)(316002)(6916009)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zng4VHU5ZExCVFhMUndTdkxRcTI5MWpReE90Ukc2eHdnWks1eW50aDdZUmVX?=
 =?utf-8?B?aEYrOEVLWmgxU0J2bXlRdm9paTgxWHVMOGV5QWFDWEFQQU4yb2kvMzRucWE3?=
 =?utf-8?B?MklqRkZxZXRmS2QzcUpwQnBxWjBTRXBjeHNZL0FzaGN0TFk0bk5IcFFZeHJx?=
 =?utf-8?B?L2NoUTdHS0dXSENkRk92eE0rNTQxdzBDb2xwVExjZFlvcW1LclMwd3g4ZVBv?=
 =?utf-8?B?VEtKTEJJaE9uYVllVjNvTnhsRjlaMktJcWRjY0dBRW1SekJtOFdnTTBJZk85?=
 =?utf-8?B?VTZ3QkZ5cFNRV2JBcFFyYUdNQ1VFb1BGOFphNTV4dXN4UzRaV3dzV2oxM0RW?=
 =?utf-8?B?V2xqSHVyOTdPWkVXMXk1QnFoTXM3cDhNY0ZPcGh3S1YwWENVcm50VTl1OWlt?=
 =?utf-8?B?UzlldVFYTXhpZ1lSdzNaT2dhaFdNeFJNYk53MURxczF0SlorQlZsVnFnZ1lv?=
 =?utf-8?B?M2pqVFgzMzZyL09nSE1xMm5PTmRtZ2s3WTVIVGxLTExRTnJNVGlZVXN1TFRK?=
 =?utf-8?B?MUlrUHM0RlBSSmxhQnluaFU4eWZTcTlJbnA5N3Jjd3dOVXUrbHR0ZkFNS0p3?=
 =?utf-8?B?YktFdTFrUWV6VzVyY0VhTlhoNkdPekFyN0hmNlN6Um52Rk8wcDhUL1dQUit0?=
 =?utf-8?B?QU03dGVtaUI0S3J2ZTBFZWdDU1VnWXY3N280RVRiSVh5Qnd5ZmllZGdEV3E4?=
 =?utf-8?B?Zy9TVzRGZDJCYkFnT3IweWdKSlJ0amliVEZoeUZPcExQT0dVczFzb0xzQ2cx?=
 =?utf-8?B?RXhIU2tEZE1nODhrbjlBelVRM09LTHNoRXBNVWxpUlJwYklYRC9ZUnpJKytw?=
 =?utf-8?B?cFlCS0loUkxPeVhPOWJaWWRwQVZGa2YxR2RpQllGWjRJM1hWNFdwdmMwbDF4?=
 =?utf-8?B?ak0yTSt2MFIveVp5TU1LK0o0bmc3STdkWGdlb2VLck5QMUtBT1BkTDlhNFNP?=
 =?utf-8?B?ZjBOaThZejRwZ016bXpaVFM1ckxGRjJweElZbVpGNmtVZWdOeXFHSkpSNU1k?=
 =?utf-8?B?UFMzZXVlU0MxaE1tc000UERZV2tqTlRGSGRGNFRsdlhsbmc3RWw4cEZXU2Ry?=
 =?utf-8?B?MDRLYlJxSGNjRDVvVFdjL0dNQ2NHbGtVZDlCTlR4SWQwRXNLYlRid0RISU0z?=
 =?utf-8?B?M3A3REtCcm42dTZoYTRYUEJRYTJsK2pyZ1VVRDV5akJ3M2pRUFA5dHVtY0V3?=
 =?utf-8?B?RmZLeFdUL3Z4R2lrWms1RFBxRkswYjU4WEtOSkxLNDh3N3g5OGwybU9WSE1G?=
 =?utf-8?B?Nm0vTnNrOXhSZzFUb1ZBZ3V4RDIyajArbjZZVnJ4UmdSaDJ5MmNJMjdWNHYy?=
 =?utf-8?B?UWJFeWZzbnlIeGtJOTc1WEUvb2hzc3UxcVlVQlBQeTV3cmJlTjArV3FmQzJY?=
 =?utf-8?B?cHBMbG9ZS2xTTFZQNERLZVJmc3dUdHRFblplWGVBczF4YXhtUGtiNnlXQi83?=
 =?utf-8?B?dlQ1VXNZVEYvME84N2lyU2xyT21vYVdYL2hMUSs5WHBaaTlCaVdGa0g0YWFp?=
 =?utf-8?B?TGtiTVIvb01NYngrTGJiamozdWhmUDJ1NStUMHBNc2lKeXlMN2E4WFFidHNP?=
 =?utf-8?B?VVpxM3FwZDVjMXZTWEQ5S05BMjhvYTFCN2YxeTluUU1ZbmErM1pNK2MybUVu?=
 =?utf-8?B?R05UTjkwVy9VazRvSTlWbzQxQndSc3EvRTlvdmc5NStKTzZCMDVlVFRpaHJQ?=
 =?utf-8?B?Z1l6SFpQU0VnRmxUWi91TGRPZ01XaU5EZjZOWkpCbVVNRVowMTdoUFhWc3FI?=
 =?utf-8?B?RllNTHd4MEtaK3FHaitMT2dYVCsxTlBCbTA2eXNBWGJCY0kxOGpXUlg1aThy?=
 =?utf-8?B?eTNQWDZnZktSQjUxK0wxN3JiTkNReXFpQmV0UUkrUTZoZWxzR1ZBTUR1bUtU?=
 =?utf-8?B?bmRGN0s5dGZzWEgrd1FpZmdhQUVuVFJwdlc2MXFzdU1uejczOTYrMmQ2WHlm?=
 =?utf-8?B?bmlBM3BmTTlINXR3Yldqem5uWVhXeDgrUDQ2RWZvQVFpZ0N4QUVhN0tyVXVz?=
 =?utf-8?B?SU05endBYzVBSXcwdFZvZWM2TG5wbFR2T05ZSkhnWDJWM2xPQzl2cHZveGR2?=
 =?utf-8?B?Rm1BU3NlUE1USm9ObS9aekNFbDlrSUpzZTFKcnJRcVBVL3U3UUZWNjJlSW5t?=
 =?utf-8?B?YVd5V1ZBL3JwYlBMVGFOMlZZTkdjLzNTYUxZLzR2NWFBUGtSNFNWMW9FZ2ZC?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xXp1lZokjFYq7MgC+USrWEoZQl82OWceEKGMcF2G6k5lvS/g5E2gSYTnrPDud44exCMTKsiykcKAow9twKc+SIn/3GI8jd+BXvefuHfOMwcj64caY+/h8ZGBYs+nOZOXiQxKMVqLU5duWyiuQQpZ9Urtaasl6T/Y2KgDbvh99mTLcLDFYytH1HihfI4tOa3C2WjJsWdoAmvQlHtobvrOkc/9/ZIV2pfDqoSXUeYWFs7KeSIlZo13mZuk4t+HTCWFWBvjCnAOMB9UQ/Y30NxFDKDOSlirMhGbHKOIa0i/KwYso+BVUrY1Lme7ogUdburKZ3iO3qdF1fGLFQVfNjpucdQp7OzytTSo5kOxFFcILH4tpcaRAtkQWUOIKtiOgOBlCmZ2H+Ez104WoKNd/tiJ9fN3LqrpcH4fl/zfnvjqxINm6zF8ptsq6Y5ia+UF/JZiwJW+SLTVm3TxMY3Xn1FtmOr0szPkaGAOLwaWgYh5TfS4oaal9SpbkO4nRSvXQLXHgKLiQlyiZLsJRME+3cgB8d5bwkmxwDlaIz8XtrzchJ9Gxtg/kriixgIH6LLjUcdsEIAsmduMzu3NOg0Aqw9/mEtMR3rNJ2T4ImpfakbDiQHtNPv5QvShRhLYrY/SSDJGfIqVh9hPJ2Aox0dFGKLBwGpU6f4Ec1bxhLl1WYxPMnP95+U6dhoAe9yFX8F586dO3Q8ulrCX5/hAaA3oo9hrzHsR1veltwQlKjAHeMNG0GhdhdhA4c65KgL5YnG6XirvSxSM5vfq4ivCRYNyyNufH3plmABrR+JXlnjnA/D66Vc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab57b10-ff47-4e9b-d705-08dbd9a2b72b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 23:48:28.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUI9eoLKjBMHk8YCi9v+UEqvmjnrbEOR5+SK3IdmsvmiX4U9lRgUNXvXvBKAY3jyYBWP86nWXWSV7b9thfiFnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300187
X-Proofpoint-GUID: Xx3h6La87aEy9vbkxlLXUwGYj2Oc8-36
X-Proofpoint-ORIG-GUID: Xx3h6La87aEy9vbkxlLXUwGYj2Oc8-36
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/31/23 00:21, Filipe Manana wrote:
> On Mon, Oct 30, 2023 at 2:15 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Check if the dev arg1 is set before calling losetup -d on it.
> 
> Why?
> 
> Do we have any callers that call the function without an argument?
> More comments below.
> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   common/rc | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 18d2ddcf8e35..e7d6801b20e8 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -4150,7 +4150,10 @@ _create_loop_device()
>>   _destroy_loop_device()
>>   {
>>          local dev=$1
>> -       losetup -d $dev || _fail "Cannot destroy loop device $dev"
>> +
>> +       if [ ! -z $dev ]; then
>> +               losetup -d $dev || _fail "Cannot destroy loop device $dev"
>> +       fi
> 
> So this is just ignoring if no argument is given and the function does nothing.
> This is quite the opposite of everywhere else, where we error out if a
> necessary argument is missing.
> 

> btrfs/219 never calls this function without the argument,
> both before
> and after this patchset, so I don't see why this patch is needed.

You are right. We no longer need this patch. In version 2, we had the
last mount called with or without temp-fsid. That's being removed,
and initialization is taken care of, so we can drop this patch.
I'll drop this patch.

> If we have any callers not passing the argument, I'd rather fix them
> and make the function error out if no argument is given.

Thanks, Anand
