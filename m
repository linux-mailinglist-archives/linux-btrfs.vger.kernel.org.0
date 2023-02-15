Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6916975DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 06:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjBOFdz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 00:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBOFdx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 00:33:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C192A9A5;
        Tue, 14 Feb 2023 21:33:52 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EL44NZ027204;
        Wed, 15 Feb 2023 05:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zdPAJGNendPkpc0MSL2pGDMD61tygstkOVUTB4Uvgw8=;
 b=ZxbEo3xv/kIt4y3xWlNpkByq4fgiDz/LewUcRiKroA8Cif9/lnfqzpCHoiERtr/8CSFs
 0KUbSI2kOez4LqHeSjlo/Vxrc3D+kiwN4j1kXkNll+J/dS16BtfqDPPMN9hWLYz0OYPX
 leOzx+sk+1/ZK32g8w5d/FUs/k/J8RkY/TFmMukIJ4fjKqx4YnJwFkeLXpv9OFXK7hvU
 VOFMu7mkndRKOO6miEpWJR3N+D972lyoadqqxJHMVdAqhuf6bwVKO2k/h8xYa6umo23L
 CKJZOGeqXcE+LUP9/fDqpoosQgAG77chqueEZLHHIekXAkA5gpCPdWV+v3Bvq1f+Aomx VQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1xb7br2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 05:33:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31F30i8F013605;
        Wed, 15 Feb 2023 05:33:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f6awrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 05:33:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJ0RPx+XGaV8biRPeUSX5XJEVhTtqerfMX4NON7tX0/1215XHpbBVJRZOykGUh+5HOxZ3MfC2SkNhOF9IjoazrBtSVS7ulqviZN2fpxLX9dUNrx1LAZLJdpMODvBEbcrgkRO5fOzksJhWkxaIaaDQCieVrWuf4Y60sTDtucc0HP+ExksMgjguNVaUr0fRCUiVTIIDNeggfkbnV29PU9g2ae9JR8Zjp9E85fFvTs97hvF9xsXvX/BeEl955ouuyT+A146k0R/gKwbj/+hDaMzoMJ0EADNRlOumyVS98TvorXuTTu41lR/ec0U681wHWRM9M0IkZaRLCZYmyLMuHXWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdPAJGNendPkpc0MSL2pGDMD61tygstkOVUTB4Uvgw8=;
 b=OeOW2GjmTvWOw7IvPWUhiHC62rXrlL2fJ+8TCacUfrGVekNQcL7TYgxbbOkvonLqANC9PU/dB2UW7APz7pBUcgcswD0ePRYRXM4kG6bHsMP1I1TbbHDZGBZwxs0QeIWgJNcxbEUQqYPrUuGU6jNgYAU7KvNmOnIEjr/2c8jxZvf2FAvivgQParH9AQgZdexLtqOI3Us6vZPJFScHkzzZtjxc4PYWZJ3ef96ftEX69wepdamR13UMZw9YlHVLAu1vu1L0TxnZIccGkuCdGUoYkXGilo1JkJpS+snHHbO8xkYIh3eacBkMnfDvwXXPGYcrTnMcj9S1RQ/BO5ocdNYrkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdPAJGNendPkpc0MSL2pGDMD61tygstkOVUTB4Uvgw8=;
 b=Ximeqo4PS3eWQvUyI8VvMxaYHlgWaeyoD2ffAYH4lHnqGAa7USbpkX7tkAPWrLZIpsI19m7sZd5gI8UgYQ3sKUv32o77RrLsELio02np2iHe94aRIyF5tjzdinbEjRy71+MCgcUCMGa3gNMrdTauggiI0sg3DIs6hmE0bTSzxI8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6651.namprd10.prod.outlook.com (2603:10b6:510:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Wed, 15 Feb
 2023 05:33:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6111.010; Wed, 15 Feb 2023
 05:33:39 +0000
Message-ID: <679cbe50-ef90-0c4e-4b37-d04c64f70c04@oracle.com>
Date:   Wed, 15 Feb 2023 13:33:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 2/3] fstests: btrfs/219, add _fixed_by_kernel_commit
To:     Zorro Lang <zlang@redhat.com>, Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, zlang@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1676034764.git.anand.jain@oracle.com>
 <9c696ea007fbadac5aa4d18ecdd1702cbe6e7742.1676034764.git.anand.jain@oracle.com>
 <20230214060702.5jiajtxcogixruqj@zlang-mailbox>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230214060702.5jiajtxcogixruqj@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0177.apcprd04.prod.outlook.com
 (2603:1096:4:14::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e3934a-67fc-4e47-4a73-08db0f1630d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xA6OhuOmBDBlNRqylLg9Y7KTlmmOF7k4p0JHWDdwv/gtMcoK3kfDDxveZMN1q0x/2f+hsSVF3pUAEgmM5dxmm+g4KkNqv+hM4hYUyJykNMKDpxYBxSklbiAv030ClSPq4a3xD2kemWC10cw+NCmLXr92F+4M2x0YDLFAxctKzOCk7M5iPVhD711yto2byo6zuObvxkBg3X9qrvQ1qYrKQqz73N3ZHamqhmk1oWt4BcJDZ9aNlfR6QnnXY2ErSZiBmTU0pKR2Ff9tnDIooBeObdpyY/ueL9Wjo6nUsKbTLLZhIYvK+VGBmZawfXu3XYHeFhlsDrDiePYJrXE2QOVIajhkXNSEAjz9LiWwuLQHUE5CysXh/FJaayZxp/M2d+jLH+veay0++5fJKA1IxZ8I8VZUqmBErA5Lm73Q38pMLIWBHOOw9rShhgc/b++zkyE8mkBlvspS6JEuXwU5JmL1sQhrg2Hj4Oc//UJuP+sqHibJxUMgMoIsai6uCl6EXKACDcydJIUva6+rwusOV6Z8YYPaAkwfs5rI2BO2ukaKS5xbMWYL/a94RH20OFc+N59MVZTIKUaTnIdh/EfIq8T7c1dculQt/gmBzcWjN335eJKdhIy+Gx9Kg+LZC5N/5D9DaXXctrHNarQCdtQ0wO8xGg35OirugsZP7p+JnyLsh5z9w4IXCDnAd6kPvzEJFbgEtPGpd4IjxvwlHkOK1Y2E3Bm3g/Y/tJfXTmHoGy0rNb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199018)(6506007)(5660300002)(44832011)(2616005)(478600001)(53546011)(186003)(26005)(8936002)(6512007)(6666004)(31696002)(83380400001)(66556008)(36756003)(4326008)(8676002)(66946007)(66476007)(316002)(38100700002)(41300700001)(6486002)(110136005)(86362001)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG92QTVFdDByakROK0ppalA4eVd3Yk83Z1ZEOEdIZ2ppdVZYODlENW1JUFFn?=
 =?utf-8?B?VkJVOFl0eG42T1VsbnB0SWJER1A0ci8wQlN5V3NXMHlVQTNoaEVxVk5tNTAr?=
 =?utf-8?B?cDN5S0JWYjNoUGM4RWpqclJ6UkFSY1lzTXB4ZmxUS0hQZDNEamIzYjArTGNI?=
 =?utf-8?B?cVgwYVRHOU05TTBzaHNHVUdGYytXL2ZiWFp5TDhIWTN4emxNNlpFMzhTWmpM?=
 =?utf-8?B?a3ZVVXJVK20xRmIxYmJicDVPUnpZWGhKcWsxVnhwQlVVMGE4YUUvbXFsY3Ar?=
 =?utf-8?B?UU5FdXNsT2k5eU9YR3o2NTF2SWw0aG1kaEtTdVFjYnhSLzhtV25sQTFVQ1M5?=
 =?utf-8?B?YlpCTCtGZ21EU2VoaktrZnpLTGhVVTlWd045NmZ3UExIdzU5V2h2bjdzQWFa?=
 =?utf-8?B?TkZXTVZPbXh2QUpBazBZZGJGSCtJQ2JRT3BtTnlsSjlhdVV4cWg4RmZ0TVZ3?=
 =?utf-8?B?SUFURnA5eWQ2SnZWUW9sN2FacFM4SzBmMXFrcDVEWFZldE80bHZGL280Z0Ez?=
 =?utf-8?B?NTEwMWdBMXNFa2JPVEpvSmtMeGlMMmdYc2p0L0JyVTZxZllIVUV3ZllqK2I4?=
 =?utf-8?B?bXk3RkgyNWNmQWkwRU5zVno2bThGV3RnOGEwa2pmWUhpY2wzUzFLN0hIZXM5?=
 =?utf-8?B?V2NrbndVRnFQRlRTR2dwNGpUUGptR1IrNm8rOWRnajA3TGtMTHUyS1drQ0Q4?=
 =?utf-8?B?OE5hRnRJYWw5TzRrN1hINkRxOUJnNk0wZnY3YzdrWkQ3T3Y2YnNlN3dSc0RR?=
 =?utf-8?B?ZUdIbWpqSTJZTld4RTdqdHNCRisvZ2ZQNDZDTlZ3SVdFak82Uk9xc0N6VjY0?=
 =?utf-8?B?eUJ1R3NkY3Q5cXJWZVhNMEdabmRwd1ZNRDBMaXhxdVh6bnlPMXFoWEliOEV4?=
 =?utf-8?B?SWNRTkxaeTBick14cnRLMEgyeXNOOVMwRW5LV2k0WVA5WTJ0QWZhQUlCeU5h?=
 =?utf-8?B?bkVkM0wyWS9CTWlmMkphVHJJaFhDNW5PQ0c5NE5IcUdYWHk0NnowU0dUN3Q5?=
 =?utf-8?B?NXhJRzJTdHE5ZTR0aFpLaU5Pa1d1TUJ0WkRBa2FZaXVVbFZKOGFXSngrNXhy?=
 =?utf-8?B?M2E4SHBXZlU4NTNnaGVoVjRsdnBuS1JnNXgzOW1mbjJXbllBdWlXZC9PaEpo?=
 =?utf-8?B?UlN0OUNiSTJYSXk0a0ZaU0JRaGt2V2NJblpVYmxJQkVGSTBoWXJic3dRTkEx?=
 =?utf-8?B?anJYemt3clNMSzlXOFZTazcwTVR4b3JKNkFSSDBiUGlhemtVRWkrQklhays5?=
 =?utf-8?B?YWlKTUZDeDdkOXlhWkFGenlRc2o2RWs4VzdCcnU3M1JKcE5ob1IzRm5MRHdl?=
 =?utf-8?B?OEtvek9NbGRURzBoaGRxV2RPYlZNOUdrR2V1N0xxc01JNHA2UkVGZTFsZTRT?=
 =?utf-8?B?NDEvRG4xKzRlWlpSRnQ4NmJOaG1ibVJ4SVJoTVhUUWtRTHBhZzNkcXlYN0Jv?=
 =?utf-8?B?a3Q4N2VYZmtHOXJtZ3F5OENvblY5NWIyOWpmbUxacHVmKzlMbjYxQkFLcVFO?=
 =?utf-8?B?MDM4aHR4QTlZTFlUK25GWEU1N2oyamF2VzZhOW9zdFJkUjBsMk83QW94MkZB?=
 =?utf-8?B?cW9yY05oVWUvN04yNVQrT0VjbUNrYlNKU3NLUUFYRDZmZU56cUh4b0swRFZH?=
 =?utf-8?B?U1Z6eGhDUjVPNzdBNmpQYmsrYXRhK2xnVXlCNmJOMDdIa3RueXdXcFJqMXRk?=
 =?utf-8?B?aGdVeG5ucGtvcnY4M0d1N1h0RnoyYW5LSzVFeHJYVFNFckpmVUh0VlJxQ2pj?=
 =?utf-8?B?aU91WksrV1pubHZ1TE9uTlV4RTY3aXVBSTd4ZGNNdHBSOEtnWDdxVElXNzFL?=
 =?utf-8?B?bkJVSFdSd2xrVUpKdVhZem14N0ZWZmtDVVhXR0FwY2QzOHBvZDloa2NsenpR?=
 =?utf-8?B?b00vSk5IUGxITDM1NE1Cak5XMTdTNUZheHdlS01kQzRJT05ZOGhpZ3V4dTgx?=
 =?utf-8?B?S1Q2aDhDWFZhdmVKUk1TVXByOU5BNHZCT2hiT3UrK09iSDZxTjM2bU1xMlA4?=
 =?utf-8?B?WFdoNmRkQTAydFdaOU1PUnUrV2NFQ3l3SXQwTys5WGNjT2lRNHk1ZE5rWlB0?=
 =?utf-8?B?bHZ0a2lOSVc5UWhacGpWUmJxVnhGZko0NlFPNTFvdTNlMlBzM0FtVHJXNGps?=
 =?utf-8?B?c2xmQVNEOE9tcnlleEdmZ2ZuMExZY1RMRTdsdWJYV1A5c3ZtWGEyaktURE9m?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e+XgKI5glOKoQo2JlJNI0WVdxolhQ8RZXPsYqxPAFLSbXIi7rijz0Cb/mc5DnV33GcF0cMVeKfcX/oHOueXlfJvji/iwW6zURow/KyoYVzvF3UwBkU4WNGsGqsleCqenmgVNErOX29MVbQC3TUcLrED68kRSJ/4pu51jwo2ThIy+pyido/mqpmycvwCs5dfpn6HqlrVteQYqJlhiulabZ4nAddaJ2rOq5pPRZHQ1/nIC67JRixzpLqsQrsFjzEBo4pmr6xGJ9A4H+KgOxR94unpZTSJdedoqysYA5NAOlY9PMV8fU8GkC+Yng87/CxdsMpTszcQqtoFIY5eCDPkmQ6hKnLMg2UmZb2jCcruYPaAtdfVX8TwXcwOnqfz1TlCQPf/fDcB6rRx7Un1FnK4BPNUqTaCRX63yFOiD9xC3mikLqcAu9yEGr2EjpKorjFIc2EAMN/9Dk5vudYGCZo5Lj2fNupUIJD4gmMDMhajR/nrVbjCGsy7NwioFcJlKx9gwYtDvt3e09QZfpKq9kSIFG/H3DVRozkNfNWTsAybPH/K+F/RZlG2qpoNZn708lW6waFvFSufBRIS9Sy/VSTAeg+xv2P5faETkqwVKErDAPLnXgBmaNad1D9mufXpSTCBZmDzWEq+HDXRB2IVfun5jj+MwkVeNAmzYTfmFW8Qlv+NkJkzyjmEw5a/KO6/usSYpdemsOlUyZQyT68yP5vE0uc8qM0WCGfEc/lHE7gk4mWdlIVxPKXAPApfyaXXaFzlP1QhiQcDpWfAbzBAvohfQNUqka+XK5xqlWGxq6WI2J0b1PV0GBer+4JBSpan7mv/e
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e3934a-67fc-4e47-4a73-08db0f1630d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 05:33:38.9620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIJSybr3DsxqdNVrmwLSzA6EqCvaY1AAHKIwoIRuBQA3Rv3pF+ID1qwQ2t9ERawbbeyLuwX9eUMBjQKpXICcKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_02,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150049
X-Proofpoint-ORIG-GUID: zHNc5RRZKfKhFfLHx1CWSgBB433gNS4O
X-Proofpoint-GUID: zHNc5RRZKfKhFfLHx1CWSgBB433gNS4O
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/14/23 14:07, Zorro Lang wrote:
> On Fri, Feb 10, 2023 at 09:41:20PM +0800, Anand Jain wrote:
>> btrfs/219 is in the auto group so add the _fixed_by_kernel_commit
>> tag for the benifit of the older kernels. The required commit is not yet
>> in the mainline so there is no commit id yet.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/219 | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/btrfs/219 b/tests/btrfs/219
>> index 528175b8a4b9..79ba31549268 100755
>> --- a/tests/btrfs/219
>> +++ b/tests/btrfs/219
>> @@ -8,7 +8,7 @@
>>   # to make sure we do not allow stale devices, which can end up with some wonky
>>   # behavior for loop back devices.  This was changed with
>>   #
>> -#   btrfs: allow single disk devices to mount with older generations
>> +#	btrfs: free device in btrfs_close_devices for a single device filesystem
>>   #
>>   # But I've added a few other test cases so it's clear what we expect to happen
>>   # currently.
>> @@ -42,6 +42,8 @@ _supported_fs btrfs
>>   _require_test
>>   _require_loop
>>   _require_btrfs_forget_or_module_loadable
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +	"btrfs: free device in btrfs_close_devices for a single device filesystem"
> 
> It was just merged ;)
> 
> commit 5f58d783fd7823b2c2d5954d1126e702f94bfc4c
> Author: Anand Jain <anand.jain@oracle.com>
> Date:   Fri Jan 20 21:47:16 2023 +0800
> 
>      btrfs: free device in btrfs_close_devices for a single device filesystem
> 

Ok. I'm updating the commit id.

I am sending v2 just for this path.

Also, I can combine the series into a single patch if you prefer.

Thanks.


> 
>>   
>>   loop_mnt=$TEST_DIR/$seq.mnt
>>   loop_mnt1=$TEST_DIR/$seq.mnt1
>> -- 
>> 2.31.1
>>
> 

