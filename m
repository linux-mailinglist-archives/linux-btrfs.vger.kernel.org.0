Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD68B63A3D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 09:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiK1I6u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 03:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiK1I5F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 03:57:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0427B17E25
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 00:57:01 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AS6aQhD014811;
        Mon, 28 Nov 2022 08:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NuIGP3wwjLeHNeuV8EIHMbe/am0h6GpN1HouiwQfs8M=;
 b=Dos2Ek9u0sW1RklgqKVxAMYPv8hxVNpvQnPPfBscjMMav+5MhZ6zCSm35+4hAwEb3DnZ
 523A0OJLnIys7NBGqiJjgQaEWUz44wHVneEeCXW2b8NICr4cx63nTa4JUk76UqWY0r+A
 Vc/D4eIXQEX5mnQaHiYtRLLMslrrxvWoP4twK0Lj5hYgY4qHQtcFJ2RLAfgEAi11O2XE
 0XWsaCghhYHjigQmtBZn1aX4Cmo5q/MQsb1MlVxEifFR9YHvua0xbTlzrM7981PgJt/5
 klYleCUD7ABiL8EOtxEyC0C1I4KWRHGkdXQrHqnCvc89fEFy+rbfIpEdKYY4tAwTHts/ xQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2jqe5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 08:56:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AS6YXTP000599;
        Mon, 28 Nov 2022 08:56:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3984k3c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 08:56:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpdmI/lMd2ucrIxbgsVLytcf/BzeCfmyQZjmZTwoENO7zaNnojBcRY3KbJgBZZjcHinovAJh0aFoUv8FoRUtHJ1xpSsspXGZ/N4Oc4UtPnNQomiunk6GkMIP6Ig0xMIS3I0Le4MGjlsCPPPOXwJYhPL1HHjltRQ+qXoShlVSbyF0y9m5ZPhAAW4fqvBeuwCA+57ElUqXOikONe4NP4UEVn8ip1Ra5ZN/ZLjgnk8QCSLzqJ88WDfjF0uN9r52Cc+ek9Yh4YAjpeTqpsNsCkmHE0c6/opvICGLBbnh3O7pnmM95cF/kSzNR+ZJj6kcS7p/26Ae132/i0EaXgo/PjL++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuIGP3wwjLeHNeuV8EIHMbe/am0h6GpN1HouiwQfs8M=;
 b=l/jmCCKlRMU/JRGRe2Dj2k+UMmWlCblj6AbqYL8Tqz5zqLEuwv1L4DuKhRwWR7iN6dPvHb2aegUJzrfBGjySAX4cwRgCbGvZSgLrfmCfX2VF6pN1wx6kdr3SrmgojTivDlDB0sbCbmksBRy3CIKMMN+1JEMP2lRXO7lmz0xm/dWNptrjxR8M8OrOZ9qtFVj5Gvb/3Bv2ki9ZFPhQx8+0XrlwSNSIEMSOtE/Uy4rNg79g2dL6bie35Jtp66Id/mxpWb/z20qwdmFfjagjgR2CPtI8rS5qpdIZzqudsnNp5r1qJKaeV8Vje7OtY5sSXF3sUvET1CJs3M2bDyvR/NQV3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuIGP3wwjLeHNeuV8EIHMbe/am0h6GpN1HouiwQfs8M=;
 b=KEImNTqRCm3ZcZL445txKlVYwL5F1R2Jus3ZsEMXRwm/IqAsqIO6QqXosWhItOB1hBTVUhnJGusH3o2LyNaevHR3E2mwVbp5WvC9aF4bV7Jiyu9cL2hAmHY+TwS8a7BSko2osKT9nHppI1H1bYvC+0XLCupNBV/Lt5uqIfBCtOg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6334.namprd10.prod.outlook.com (2603:10b6:510:1b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 08:56:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%8]) with mapi id 15.20.5857.019; Mon, 28 Nov 2022
 08:56:56 +0000
Message-ID: <e4815c7b-9552-4748-ece7-181777c9a409@oracle.com>
Date:   Mon, 28 Nov 2022 14:26:47 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v3 05/29] btrfs-progs: move btrfs_err_str into
 common/utils.h
To:     linux-btrfs@vger.kernel.org
References: <cover.1669242804.git.josef@toxicpanda.com>
 <06076dba53813bbcb59b3dd9c070a3eeb249551c.1669242804.git.josef@toxicpanda.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <06076dba53813bbcb59b3dd9c070a3eeb249551c.1669242804.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0235.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a5890b-b4cc-4abf-26ce-08dad11e8013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXvQREps+cZjKwh5OwJ+i6ltGtd6x4A3Dvur1XWYNIftZLA4EreNi/oIaVn6uvluKlVAMOfUy6WdWTo71tBeSLU161rYG2ec8uS/gS/cAsYqTDCbwhC0QTKLAUgk2KE4t6xAAywa20WEDWXv0g18lTQOx0QQNygw4MtCctNx26HcGp9fcf1wVppSTBzIEv3s+703oSF4Tue8Z9VLVyKvhTuL2UT5NgN0wKL1RTp8dQyYF+bSI3G6qObYma65Jc2XLyKzwVQ6TnHNGYqbkeHbu08HpEqLq0XGhKbdc9ykONBC3F/hK+HhrdEJAes9kyv2DOMWExgqEzX0YGtFnl127ACmSQ4OTaM5y5PB9/ore1Fe9xGYgFOqNtz/sMYfH2oPhAZCanTmRSlCosTnavo6H/7jsnUo0ciJS+qu9GL0bZeeWQAipRy71iqriyagLlpadKvITAY73q+weoBFDGAUdF9EPUYompNggtu8sevtyMkUgOMvuGhDbiqyOWH0E6i2gf4P605t1RnBYFeOjxASixzEtDcRXKrokIaJnu+IAiqyuUyBrddErJtpqU7sFNrWOXND+OtTCh078ArrQC8sRDZKsglP79El0whW7eSlDApqvn5NzcGDvoq4RiXR0bD2WRxLOyGjs1D3UB3KlYe6NF5n1P+gEv2yM7F8JlhLoTFoad+nsZAN9NIbnFD9BTmq6NGBySvScBXLZPtkB8J1EaIlQV1t4Ib/DNGrcTVIb7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(6666004)(31686004)(53546011)(6512007)(2906002)(6506007)(6486002)(38100700002)(86362001)(5660300002)(31696002)(44832011)(558084003)(6916009)(316002)(478600001)(66556008)(66946007)(8676002)(66476007)(8936002)(2616005)(186003)(41300700001)(36756003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxBNE5PRDBabmR0VzlHYXJVenYwZndRQnI1d1BOYXdGSitMUHV3c21Zdk1J?=
 =?utf-8?B?UFY2UGFQRnd4UXhqeXRhWENwVnNiakRxTC9sVmNCbDhacGZlNTRVRG9tbmRp?=
 =?utf-8?B?ZytnOFRFWTRzM0VKbThFZy83RXQyR0pZUFhRRklzMFJQZFZaKzFyekZpSW9i?=
 =?utf-8?B?UUVuTGpqZFQ2WGMvZFEyRU11cEVFM0dsWmNlQUN6YU5hU1ZxTm9VbnpXTVpw?=
 =?utf-8?B?WC9jNVdLU05pZTRWRGYySFRZTGplaTk1QWh0M1hGRE4xSFNUV3lPa0JXZG0r?=
 =?utf-8?B?eG5rZ0N0ZzdFK2lVaWpqVlVBcm0wRjh3WVVzWU5yOW1IUS9Hdmo2S0JYc1Zs?=
 =?utf-8?B?dDJuS2FscjBwUDYvNFhNRU42ME5jSVg2bk9MRkVNZjRUdzV1QmcwK3Q4SEhj?=
 =?utf-8?B?RGtYd2htUFdxZnlzNjVFbVc1MWFnOHZXWDByZzdoazBwejRwcko3NU1XazRy?=
 =?utf-8?B?ZXdwWkJvdVdaK040RkdkQXJ5NjNHeHFHdS8xSzI0ZmdSSGU3QmlsYjh3b0Ro?=
 =?utf-8?B?QTZ6blBGa0syejhITFFxd0NXNDd0Y0EzUk5UTHNNRDUzL2FuZkpaNTZiQytQ?=
 =?utf-8?B?OUtuQkhVNldxYkV0NUJqWGRTTE55bXFjZUJaTG0ycmN0WDFlOTM5NEhXRFFY?=
 =?utf-8?B?VE1PWEZXNWhyZGY4UlErYjFmcFpkcVFDeisxLzFzRkRsZGllMkhTK0Nvcitp?=
 =?utf-8?B?RTQrYVRvQk5JMStsMHAwdXJJSXB5ajBhM0JTOWtKM0hhZDZHQXBnVXRWR09z?=
 =?utf-8?B?TWpFaWhWdmZPMkVhWHNMdzVEVGpFOGYrTXloTmtvMVNuZ0RKdzQ1ZXVZWnBZ?=
 =?utf-8?B?MUxtemh1WmFRdWFVbW9nVkhQcjBPeGVVUHA0ZHZpWGdCakQwSlF2d1Y3SGlM?=
 =?utf-8?B?YUZwOEtiL3lKMXQ2c0NkZE04OVUvSTRLOTQ2MTlnQ2NCa0ZuTUhGc2IyaDFr?=
 =?utf-8?B?NUgreHR1aitvYUh4bkZCK1ZPV3BJb25RWFU0RjM5WTUxblpkUWdvZlB4UWRG?=
 =?utf-8?B?ak9vVWRQcGZ0Z1BoVU1saVIyQXdBeERoUVlTZUlSb3Vyb0tObTA2SkxBYmxI?=
 =?utf-8?B?aXh5UThJdmw0TUoveXhibjBWd2dLdElVTEhpODQveHM0TnRVVkYrV1ZzeUNu?=
 =?utf-8?B?L1R3aHBySGpFZzRBcllxV013dmhKOWNCWk1Pb21YSnlrWWY0blp0QUJrSDJS?=
 =?utf-8?B?U2IyMUlqeXdPNUg5azB5RWd6aTlyZ2dLeXluak5ubTY4ck1mWUZ2SytyZU45?=
 =?utf-8?B?WFV4NXlZWCtJaktMblhrV3FrR3BvS09BMCtueERNK0dmVVFBZHNBMmwwU2pz?=
 =?utf-8?B?TWRQK0JqLzNaQldTejB1RmJ0eGNuNTRseDN1OElYMDBYOEFxc3BRc0REUk1k?=
 =?utf-8?B?WFc4TURxQkJLMW9GNzRSNDZvTEN0WDNtbHNFOFpiYVgwclM3VzlRbm5ZL3Zq?=
 =?utf-8?B?YnJZdFRGYzFoRjhBdjJnRFo0cUg3dUNFR25rS3MxY1hna0RsdEVtV0VQalhi?=
 =?utf-8?B?MzkwaGN2Y0NuaERvQUVnOWtCbm0vOHJNaEw5bngzNEZNWk5PQXlwMHFIaTl3?=
 =?utf-8?B?ZUQ0cnl2d0djUUNvWWZIbjhaRGNPSUpJK3lFa3NVU1laSFFQdGxENisrVUNn?=
 =?utf-8?B?RDJUQ0M2ako1bk1rQU1xTzE0VUJqK2puUFNpc3Urd1M3WGMzYXFnMUgrbmla?=
 =?utf-8?B?TE1Hb3VsZHFyZVBMcC8rek5IbnBPdjZRc2U1cnMyTlVKaWwrZWthdkV5OW1O?=
 =?utf-8?B?MkxTcDUxRUZHWTEwb0xoV3JHN2VsT1AxcVJJZW13VWQyNnJxTi9xTDJaZndp?=
 =?utf-8?B?MVdyVVY5b1EyUHJ3dVNDQU53QWluWGZKb21GZGdaWHFxR0hVdFlaUDRSZHAr?=
 =?utf-8?B?ck8yUU5iTEgzUEN2bERIblAxM1hQTXl4blBqcXcvMlJSd2ozVHJXNU0rUU1B?=
 =?utf-8?B?NXBlWDhWYU9SdnhDcWE3VkVFTkJNOXo2RDdSc2FPcEpqWGZWeFdiM2VWMmk4?=
 =?utf-8?B?aFpzZlF0NFFmVHliZ25wcTZ6OTdmam4rZWhBckJsWmFWdU55MUxrdTFIckxJ?=
 =?utf-8?B?Vm1rdGl3NVFRdUJld21vRXNNSUcxbGxnNUNTaENKSkFEV2dEN2VSM0J6S2kr?=
 =?utf-8?B?cC9KS1lrVXJDcXJmcTdWS2hkUDJvZkhNQ2lmUk1tZi9PaUtHazhhSms1dWtL?=
 =?utf-8?Q?Muxal4SslYJvT+E+L75wuBGBuS7Hmv8OhoPuVR+4JYJW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dyPT2lGuJhfN8bLercSUq4G0JGaiyy+4+sgQYNLN8UfKFKY7MKRAR+zVGqkb8dxGChbunmTIG95K/hOKjIHmi2W5FJb7BndHM5GMbus8BKw+sDxQeWxHCvgwV02bbNmqTWQ/1vsxNfxsICWD99DxmXDHgkh1pQ/1GhSK3qWv3JMDNLHs+kJdXqEpdj/0b+r4JPi7uaYEJ/xpU+3LiUqHq/qqzeE26lNhkkvtDihtj+4IX7oTDh1VZvol5Hfv6sir3wxUmiFjLh/5slzQ20QpeuZqSFcjriby4w4sSQJxz68Q5LHtHUsPGp5tjdnL7DuSEJpQ0TuvOaAZXlFMj9VkoEdE8PqZUuBvRljkTA40yrQv0AncAjjjcgTdRkJF/v6ci4/FHIU8guV/4j6nH5ep8/YwuQFo8lcLZdfuI0oqGztA8IrykU6xuKlAwyZx8NjlMxNqKbSwVkRIwzRTqRp8RGLTqmJ5PLmkeYNFRR6CyyNeNzdcAZmLPcwIE6irSXP3TreqTZ0dT/ZMU9BA3QXj/je+3wikBLnhK8qbbSkE+sN8HLXzx/cU5Lo0AXask2R1TO5HAHPyHc7HdKRxe/58t7Fg9MIM8fDtGmD0Brsqn+xNf2YyI8e66sTlqeCvs+jt0xvgpCmr9n1gi4DFyWF7B40l4CUqXu7gs89f5lFe1O3sqvUC5trJoLEeHLE+nVp0jxtoUlUjYWkDDRaMnMWBwBt89ORXnJh4T1bMTPZAGCPpKOTtkad9EOWUvpp5Iea4nU8CJQVy3ipTlnCCdRd43DxD049nAbw0kSEZ+M8hnz8HVcX8Y8c6Qnn7i0gqXkOw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a5890b-b4cc-4abf-26ce-08dad11e8013
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 08:56:56.9319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRpiBEtPhlueqqZz6VN8oEftr3mPI/U5y9b+famk+N9GCVOY+28pqXdtd141gOXP3BYpvds+Lxj6OOawPag/1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6334
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_07,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280068
X-Proofpoint-GUID: y0UeEuk4IF_Rlpq7Tx-ogEQ2VWzA53hY
X-Proofpoint-ORIG-GUID: y0UeEuk4IF_Rlpq7Tx-ogEQ2VWzA53hY
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/24/22 04:07, Josef Bacik wrote:
> This doesn't really belong with the ioctl definitions, and when we sync
> the ioctl definitions with the kernel this helper will go away, so
> adjust this now.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


