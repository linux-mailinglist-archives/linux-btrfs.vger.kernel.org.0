Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3947DFCB0
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 23:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377485AbjKBW4H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 18:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjKBW4F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 18:56:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F970184
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 15:56:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2JL2Lo006111;
        Thu, 2 Nov 2023 22:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/POpUP+fIgowiVjChRC9lYkv2jNVX1Y3/2NYTsc1zPw=;
 b=fbwmcrxwxIRRxpQ/QRor4RUKbVC/IKNJHi0tijQG2D91FeVYqN7mOa63Fbp+tyCWcHY7
 N47sfZlsyIZtDECNZGeE9SBl5ZT8GBxuTuPt1y05OHAtkHDq25W3tISbPc4pImIasBAN
 YJ2IiVDadeemPOXHQLjKawfLadSJnDyy1nGctu+LoIQgTJEUWNb2THGwfmwom9Pg+ymt
 dynnkfEJf9tjph23Jyp9OdXovoF6pedQ/a2ZQVOF/YCkA0mkVKyb8bDX3/Coz4+aplG3
 bsEZAOMm/s3PiI+NP7ATwt4iMmRRCJ+bdhd7TDXqr6OwV5oP2YKSgfohASTjmLKCHiEG YA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtu144-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 22:55:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2LcS7f022605;
        Thu, 2 Nov 2023 22:55:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr9anqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 22:55:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcGyoNaJls+lqTlAuo/zzEAv+6SBoOxbjdShGPDdnrXo/UdtSnGmSIuEf+FndXmVVI1Qe1Cl18J+vohBk3X/5wfpkNJwoWEggwMzB6iQkLpbEgrg84LS8149EzUKVY8L/akZcA4jShjTFeLyKPi3hfVeFIOJb/jaeHXPiYitMIhJANy8+35zO6hiLHK5dkcfsjCqMikWljYsNvbrpJKAsaLaHl6FEqYB4LkWoepN44apva4P4lF2wvxAF+LecsvlioDo3GbIC00tSFxX/1LPQ7CJ3sBX5wE8aF9ric1SWqlWAkaRAPJLNv85t5wpfR1MMPrJcU/iSPp8RiuUTdJRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/POpUP+fIgowiVjChRC9lYkv2jNVX1Y3/2NYTsc1zPw=;
 b=eEYzLiJtaKUeFPXOnyfoatvGy9rb1HkwuX7jeiEqK/va5C4L/lGEzPBK5f81kL1/WJgJyXKrfiftvv5azDWgoaxbwW83tS2sNW3Ud65pw9oKSstiSPXW/qLWRPleKgR+wCw/UmjByxoD3yJf4gOLjqvxjcEyIHoi3XHAFveYy6JhksAPU7H5Nv9opad+C8vs/0QndjsmQ/cJ6jQh4t9zvoeWn1fPwrzJnOECJkV0vovsYFDqMGCHPYnMhaXXlolThUm3hcoqSBS07pZNQh3TaBuUO8eo22SKqqjZNjMhOy+UadJx0lZtskf3lfHCAQNW8RhiU7vlJLhjtL3+FL7v5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/POpUP+fIgowiVjChRC9lYkv2jNVX1Y3/2NYTsc1zPw=;
 b=X012O9o2vMzjdkqC0P73Vc+fVefT/e7dKxljqpZM9CpD6zBBNpk8LpDr3e/1pCz1efeBKigdJDrXMMnPBvfWgrUFbAGFMbGhpmWcvk8gfjYKzvdTD+lVY+t4/XpI88KUgMvkrCXy0XRCQdiDdobXYBB3yagGxHuXc+qiKMVp1yU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB5963.namprd10.prod.outlook.com (2603:10b6:930:2c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 22:55:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 22:55:56 +0000
Message-ID: <f5a58903-b6c8-4cfd-9328-ea8214ca3399@oracle.com>
Date:   Fri, 3 Nov 2023 06:55:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: pick device with lowest devt for show_devname
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
 <20231102202652.GK11264@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231102202652.GK11264@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8bd581-436d-4d78-54da-08dbdbf6df0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLowZyQr+CTSSnB0NVNkWyFmzso2YFl9ZKlF7DyGzXmdqtvlmWFpGNF02S869ZP1PVjuz99xz+53G6gcPEC/I/YmxixtQscdIAylKAydP3uwOWpEFHSjS7WB62TNC3O2BsnyGcvOARfU8YxeFWGaJDIXFEVSS0myWPUtlZQc1KobIYCZNQ/yBwxxWrXQucTgg83e9x32C0CAprrOolG5MOHV+lNl14wVPEdY/BcAfH2qRlg2vioeA+GDajFXj0xlqV/igDkAIpQFogVSetH6kgUfk6W/H/gRT1n04Hnnofk6z/LjQ73XYcKEk5rv8qUf4/ET1hvJZsnIsXrNMCn6NoilQyBu5gaALA9KXC5dmWl6/QyxlK3mH0VO8A8x0O1UGRCxI1OA5TyfQrr/JTtfcDHhLz3ZofiC4bZoa7R7yXY+tqxxVptLUSknJLtoFSolvd1k/pt24tQNtEJf1VtlwWSRQ6pHVK69dN2GCDD97fpvkq/OPejWvp8ajfDy0Rnt3ORt4o4GI2gxaH6cdF/vCkCln/18m8qj3c6v4m0MDHB3/8AyCVjdtvs+td5/puXpUw2f4chCy5BcEi+uIX3mIqa/6Yx4KFaD1KHUu9aSWdNIAluyO+j7I0XNjZ/fdJCuX8BerDiAXNqlvGw/k2aicw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(8936002)(31686004)(6512007)(6506007)(26005)(38100700002)(316002)(86362001)(36756003)(31696002)(2906002)(6486002)(83380400001)(2616005)(6666004)(8676002)(66946007)(53546011)(478600001)(66556008)(66476007)(6916009)(4326008)(44832011)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUFCL1ZGVlhFcExnM1lQUTRNbVFvSEZZWXhGaGZjYkNxdTB3MjJWRVJsQk0w?=
 =?utf-8?B?aTM5VnAvSjc0MzZ0a1JacmszVkpMeU9ldW04VUhHZkxVYWx0Y2dycmltcTZO?=
 =?utf-8?B?RnJBL0FjdzZHQkFoaDd0ZW9FZFEreEovTG9wSVJSbE55UzllSG9aRHFZNjBD?=
 =?utf-8?B?U2dzS0RRSjMyVUNRRGpEeFNrSmNKbURhMDBpejREWXN0ZU9jQlVrc2lHZXlL?=
 =?utf-8?B?UGIrOVlqbXVGQisxcEM0ZEpHNEFxOTFhWlFVc2o4Qks5NWRlZ0E0R3lIR29C?=
 =?utf-8?B?ZDNBT1ZOR3gwZFNRREJTWkFlb2F5TlNXd2t3bE9Ic1BWdTd2eDlRNWdGczFh?=
 =?utf-8?B?RFN4ZGJYQmJwK2Y1bWowMEdVZGx5NGtrOFMvUld5MnZBeklxQkNyZzRpVXpY?=
 =?utf-8?B?MVp1eVRkd2hObGJ2QW0rUXJsMHNYaTJFOHdWaHBucndJNnN6RzY4Q25qV3Jp?=
 =?utf-8?B?eFZFN25GdWMrRlNHNTcvRVQzOFR1L3k0RkdOL3N4dnlXaG5RTVh6NFNkMVJi?=
 =?utf-8?B?U0N5NjNLeEZoTHZtUGZFVzlPTzNzVkdnR2pIVm1JKzJveGR6UVZRdXF0TG9T?=
 =?utf-8?B?bG5SYmJxS0tQbDlFanhpUUNMS1BPdzlTTWZPV3BZOWp2cUVrc3NRSE5XUllQ?=
 =?utf-8?B?dWdyeFFDYVNuam9PTE54T2FJT1R1OUVPbnJBR3AzNitSOStWMENqNk82ZTdD?=
 =?utf-8?B?WXJmMjliWlRMaytadW9FdjJRV0FMK2EvLzhMQWVUZWU1MUtMejlVV08rZXdB?=
 =?utf-8?B?SWh5OWV4NXJLdEdyU0hJZkdUVDUwOFl1ZFZQRzU1TzVPRFZuWTVBdGdFcE1M?=
 =?utf-8?B?ZDgyNkpKdWw4QkZqSXRCdXYwVStPS1djWTJ3SVg0b1JhNmZvb2d2UmNwelRT?=
 =?utf-8?B?YmxiQ0dRU1UwcG9lNUtRMUYxOXZiZ3JhSlZsbzExRzV3QWt1QlVyMHlFUUFl?=
 =?utf-8?B?NFFTVUgrQVNFTUdhL2cxNHVPYlVRRHNTeWNZczdpWG45dnV6bzc0VE44ZWpt?=
 =?utf-8?B?YUQvOE5CTUMxbFFBVCtQbEw4anlUcnhaMzBMbnZNZ0hqQmRXRXZVM2RmTDV4?=
 =?utf-8?B?TTZwZThZM1JJdVpJUTFDL3hhS3dqUzRXL0NybFRGVHZBYlpwMTdIZUZWWENH?=
 =?utf-8?B?Q2dBTmtUazdrNGxhWUNlcWxTUG9ZdXlWR1VuTGs2SUl4aWFRZEllSGxDMFJa?=
 =?utf-8?B?S1JUbHpRNitRYnB4U1VXYS9MVDVuSG83R0wrUXJsdklaWWJrR1kvOVRKQzlz?=
 =?utf-8?B?MUEyMm5oQ3hYZW9SeitsVjhva0dDWkhjdmpRWHNteUtudnJ3TEdyMzhjZGJB?=
 =?utf-8?B?dmV2bm1iZVI2RnJQdXFUR29EZE1raDQwU1FneEZ5b2pid09QUmI5bnpQSXNW?=
 =?utf-8?B?RFdNdzlGTS85UmdIRnZQbDhGd01uT3FmVUpseUg1RkllMk9QaVNWdjNCc0Mw?=
 =?utf-8?B?bGw2eGRFbnBzbTNqdDFXdjZRZ09uRWhYZUhqMnRUTGxKYzlYcHlvdlJLTE5E?=
 =?utf-8?B?cXFOVHJ2Zmt0YWNJM0hnODZSNGxZQ1duVzgxeFVla0RoNDNOK3k3NVlZa1BR?=
 =?utf-8?B?eGxwajZPMlpUTFpIQ3dMK3pNYUZNTmxqTHRUQ3R1ejBMTzNMTFM4YnZIMDhG?=
 =?utf-8?B?bEJZKzI0UHA3R1NQWVloaFZiWnp4SlZMVis1cnFWSG12VVVML3lvdTFmdUtZ?=
 =?utf-8?B?SHBNS3c3QVUxWXBtd29xRk5yNHBDWHRCQ1I2aDllTVFtYnlPMENCMWlQaVhU?=
 =?utf-8?B?ZGEwcnlvS2Y2V2RlTXpSNTVRQ0dwU2JCVklWenRCUjdoeGdxL3V4T2hhSG55?=
 =?utf-8?B?RE1kRnA3Y1E4OW12NzFkcGt1My8zTTdHbzRoSnJXZ0pOMktYRm95akJqY29s?=
 =?utf-8?B?N2xxTUg4ZkF4VDZzMlQ0Wk1adnBCYWw3ejFXcFJvVHJrQmNMeEdIQ0w4V2xM?=
 =?utf-8?B?dUVlT0E2WnE5dFNieURHUmZtOE1LT2tlU2hHU1pOTngyQzZweHNDcmxWc3lX?=
 =?utf-8?B?cjRpdHcyL0JQVkI1eFBtckNJL3RtVTZIdWFsRFA5TGxZMnEySHExS1ZvT3lD?=
 =?utf-8?B?ZFM3Y2Z5Y2tkODN2WHVZTnVTVVFsOS9kNmJ2dHFod1FFOTgyQXdKMk5SV21D?=
 =?utf-8?B?R2JJS3p6MDROZ25DWnQyM1Y5NC8wcE4zdSt0bmNKdnpPK0JNT1dwRml5cFRq?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 95XweiCxVIYvNSYTdOaYgbcndFrwo8VrkteINQXoIrLdNcU/C0kiGzHZHYTKUGlFNQ5qKCHnPdKdIA0fIEAmt9OkZyPaQXm7NtPHfroqzNvPrl1Jb5M4YKo2tG5wwVHaecwmkwMrMmTZsqGjWoaWeY07AX5s/3cPdEQ+XxyxWA3CqR+2SbC65nO84FTArABimhOAbm3we8nBJvNojGXeqJ+bObT5EH1/6t0CD9jUqiiqc7SV100bp+oGEnenmnYJQVmRjSeUfUyAoJ86jmvfjPCnk5BUEYpJ7l1sINcAOQDMR0BCX8fvjib8lb1KC9WX36rot0lEUMIZ48wDt/kdx3zBSEYvOcvA2T7XRqrBj8CKc3SGatpSCReFGoi4L7YhqB04bzVFhtMYbsFp4pkpHJtz15JmpxWaChsSq4TjedvGxYmo8cYnKM++CdKygWOnUgP2TpTw3FSK7nUU7JK5/HIJl93pc0GMJBwtc9CV0iNyzPDVybvjcRcqhlrZgpRv+pOYrHUnm9TVHWg26120+he15XRRBev68Ri2ZmKcu7zxR6uM8/uQxAz0DHpG8HUFm0E4AYGaLKQ04WNS4xA8XSamfbxKyD9kFBNxgP2SP07/epAYRxu2uY1VNXpE2gAmW4gv/kTo3fP7/FxLw7L4EWP+THWMg4sUCpjSq3hlmAdVMJoxOciFx+aYIJBte8EE/gMTSvmLWV+EgZnT882w4YyvX5LgkDt3E4TaTBLUehDGLG3c0zdlWJYNh9N1HFQTADNFq38Ids6dc2i5BaOBetCMt78luDKGpm+W/Z0HO9A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8bd581-436d-4d78-54da-08dbdbf6df0b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 22:55:55.6643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fwpb/DHuKSJaiRRNNRSkLwhxsaG6SkOd7X5CWTE85ByMYP7IyABX7vJv7sq8AiY75Vh3TTc9nBTs+D2Ka+aJQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020184
X-Proofpoint-ORIG-GUID: QpmKblfJur6A6_prBAMKOIeEOFn_IC-T
X-Proofpoint-GUID: QpmKblfJur6A6_prBAMKOIeEOFn_IC-T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/3/23 04:26, David Sterba wrote:
> On Thu, Nov 02, 2023 at 07:10:48PM +0800, Anand Jain wrote:
>> In a non-single-device Btrfs filesystem, if Btrfs is already mounted and
>> if you run the command 'mount -a,' it will fail and the command
>> 'umount <device>' also fails. As below:
>>
>> ----------------
>> $ cat /etc/fstab | grep btrfs
>> UUID=12345678-1234-1234-1234-123456789abc /btrfs btrfs defaults,nofail 0 0
>>
>> $ mkfs.btrfs -qf --uuid 12345678-1234-1234-1234-123456789abc /dev/sda2 /dev/sda1
>> $ mount --verbose -a
>> /                        : ignored
>> /btrfs                   : successfully mounted
>>
>> $ ls -l /dev/disk/by-uuid | grep 12345678-1234-1234-1234-123456789abc
>> lrwxrwxrwx 1 root root 10 Nov  2 17:43 12345678-1234-1234-1234-123456789abc -> ../../sda1
>>
>> $ cat /proc/self/mounts | grep btrfs
>> /dev/sda2 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0
>>
>> $ findmnt --df /btrfs
>> SOURCE    FSTYPE SIZE  USED AVAIL USE% TARGET
>> /dev/sda2 btrfs    2G  5.8M  1.8G   0% /btrfs
>>
>> $ mount --verbose -a
>> /                        : ignored
>> mount: /btrfs: /dev/sda1 already mounted or mount point busy.
>> $echo $?
>> 32
>>
>> $ umount /dev/sda1
>> umount: /dev/sda1: not mounted.
>> $ echo $?
>> 32
>> ----------------
>>
>> I assume (RFC) this is because '/dev/disk/by-uuid,' '/proc/self/mounts,'
>> and 'findmnt' do not all reference the same device, resulting in the
>> 'mount -a' and 'umount' failures. However, an empirically found solution
>> is to align them using a rule, such as the disk with the lowest 'devt,'
>> for a multi-device Btrfs filesystem.
>>
>> I'm not yet sure (RFC) how to create a udev rule to point to the disk with
>> the lowest 'devt,' as this kernel patch does, and I believe it is
>> possible.
>>
>> And this would ensure that '/proc/self/mounts,' 'findmnt,' and
>> '/dev/disk/by-uuid' all reference the same device.
>>
>> After applying this patch, the above test passes. Unfortunately,
>> /dev/disk/by-uuid also points to the lowest 'devt' by chance, even though
>> no rule has been set as of now. As shown below.
> 
> Does this mean the devid of the device shown in /proc/self/mount won't
> be the lowest? Here the devid is the logical device number, while devt
> is some internal identifier or at least not something I'd consider a
> good identifier from user perspective.
> 
> The lowest devid has been there for a long time so I'd consider this as
> behaviour change which can potentially break things.

It's not the lowest devid, but rather the latest_bdev since commit
6605fd2f394b ('btrfs: use latest_dev in btrfs_show_devname').

We need a rule for choosing a device in a multi-device filesystem that
works both inside and outside the kernel. The major-minor (devt) is the
only consistent option.

OR Any other ideas?

Thanks, Anand
