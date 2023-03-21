Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA10D6C31FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 13:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCUMpm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 08:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjCUMpl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 08:45:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB86F4609F
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:45:00 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LBiHht032764;
        Tue, 21 Mar 2023 12:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=hbnJaXk/Z95vfOmG3cdGPnNxO7afTtqaInKBO/BC+5kPPx7bh6plPZZOyu1/IhBXZOLA
 Qv4BtbcJo2zJ3DMjCMwX5DhdsYLLBhAppoXAk+7IFWAFZKO03yUNjedt1FmnO+JMwdHQ
 EVEjycJWWiCP+u9bU6FPWZ0fcMbvLLiHO/JuQuOUT1lp9qoUHPKKCXlhcOhqdlMvYQhl
 k8p9/8qwvy+ZsgsjvZMbnkWpCnbMnLh3krP8FN5nzkwTNKv4XXascGIN4bdaOqT6ZVH5
 N7slevlKHmtBOmbUU+d1WIeLD0kDx6vBoBwGa0Yt7dDvcK/UjviERZoACTEx06X1emuJ Dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5bce4us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 12:43:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LBs7cY036754;
        Tue, 21 Mar 2023 12:43:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3peg5ppxq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 12:43:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVidLtSuGhDmu74Q2fcU9xTA+Jm8XFXC8AQJEFpZJCiHoK35ZSYio9sLfDick3fePql87ju/0m6slLOJmlb6PjdOIryFjYk18uf+HPbp5w/UJZ7bF8ZUZMC45zMqLfW6jgUVBQrFaazYpaIzx/DlMbIJmz3yFwai5B/sEfigaMVTWjOyijFfL8qL0NIk6no2rdLxZQ/hAqvnY37BfP2dF+gLgSRGKmTEc1/2gMan4KRL9VfSBO72CdABEScJnxiN8UrHgjbhIF1De8NHR1rMg72//CJvmUiBl7sR/DjXgBlgRIxem5rfg0iD6alUSV1MUocSRBmir3LyvXKXUma07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=Lnrl9COEKjk4Zprwb7rH5MMDXUhUIxqcd/ScVAum6GSINl1CRVXSH+OSY04Ju5u2cRXmxsK/Ew+m+tPCxoRYU0LBksMbfxkQXO6h4qK4brUle2yfGG3RpKNKblGcsgUA9ZvhGIKwgtFE/aBrEji/p5KUS0C2bE8yRCNUU6MFfyKfTVyDtbXxh4DPGYMsNrbqNsu+aX+yikZ/I7aGTlnuRAPvm87T6Ht8thT2GCcVyn5KY0md6BCFwQTadOQ3BVSkrXdW4p1xIBbfArurHaEqP/WQQaIohtx2q8oG1xSqn33EPtYKscHZ/3rOgfYgg9dSj0Al95QDYvtP++oJ0p0JDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=VgsuMQZi0PUNoECwogWKZLfEp8rH4E/W+lJ+oPE6BPVhk6dpgbWdvcAFkY8cV+aD9HJvFSwOyZ1e9VPhHTEigR8s+t7oS0HqVm196v4W5KW0Uoq1TW6I2MxSzmYqq38vMLs0unfPYBxceTIYF2aL3e4MpHmm5sIjLF4AdCmFgOo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CYYPR10MB7571.namprd10.prod.outlook.com (2603:10b6:930:cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 12:43:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 12:43:53 +0000
Message-ID: <66138c98-47f4-821f-2697-8c855c0b9ab0@oracle.com>
Date:   Tue, 21 Mar 2023 20:43:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 06/24] btrfs: initialize ret to -ENOSPC at
 __reserve_bytes()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <e20f821150a7f888758021613820c70a268a072e.1679326431.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e20f821150a7f888758021613820c70a268a072e.1679326431.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CYYPR10MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfc6cc2-0291-4d67-2c0f-08db2a09ed87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfOwoVR1damZtnzirJ65Oxdhwj/X1xkdB0VelVNOrwf5+cOC+ZGcn1QoRt9J4fiYtnNEKBsruz+ZmSdBMm81hxKXZVuR+NE6CrPnodNz7IE0QrgleEa/z2ATIQ/R+tb2F6w5nVXYnNG5jl3H03RMfUdM5q6YGy4esZcl3EnhMDuXT8bqYY4qLiARPida58Vxn6RueSzMqm3hKMBRI7UK6SDI6EtV7NF15owv4PnCqyA1goTkUnoing5laajYYBQ7sy5eWz6m3ojDqJDlKtrKfSBSk73epDnTsek4h/PxxdsLRElTTXQLxh9Azim7RErro7+dbylP23EAvCDKLYm7xPzdyaBbycc52z9+0M6HxONfv0bvKnH5w+5zFusZwDcIok/jN7rmjKGjSkrcUHSIIyMiVJjCjf1Atvo4rPVXDW1fyt9VWW8bxZcouagm2pP+sBtwiHye5Zl5wWGiBVQahe76K9q9sL01rn9Kv6hPZPMiu0lVCFPc98+ouHHaHxo5PlTu71+ggVlP2yuSInZOr2Hbva0TTlulmaxLdkBNbKD6e15rnv96+KszrRlDwUZXV4pR1qgSwA+GHJgtZpKPwVPdytbC/Oru2CKyvlJL7vZH0gRlvYHLi+Sr1kO1wAHx93AhoSsTDa2Z9xty3ov7SdMtXUgWITt5ZFw3S3ZvMNsosBqpxGmR+c0KLt0B3S4gVxCu4cx43pdcmtTJh7r/4J4GanDCcx3aEACScY6+d5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199018)(5660300002)(44832011)(41300700001)(86362001)(558084003)(8936002)(31696002)(36756003)(19618925003)(38100700002)(2906002)(6666004)(6486002)(478600001)(4270600006)(2616005)(186003)(31686004)(26005)(6512007)(6506007)(8676002)(316002)(66946007)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THVWbUdLbmlqTldSQ0kzb2IzQmRvQWt5N1JZZ0pnZzIxY0FFZmt2bDkxb0pJ?=
 =?utf-8?B?RS9IVkU3SGUrd3dCdkxuamRQUWxqRFFJSm1ITUIrR0FuSmxyNml3emY2Qy9P?=
 =?utf-8?B?OHp4V0c1MDVZdTBLK1hQOUNuZTNuUU4ya3pqRTB4TjRNcHdRNFF5bEdLUjB3?=
 =?utf-8?B?bGlpbVZ1Yy9nWVB4aFNPUk9NdHVVSTY3RGJITk5BL053bXJONkFlRExJeFNo?=
 =?utf-8?B?c3BVeHdvbnZya1JqV0dWb0Z5clozTHJvNHNHdVhGT0ptbXk2TmkzaXRUbWND?=
 =?utf-8?B?ZGtDTkJwTExSWnFMRmgwb204NGxxNSsvQUkybDdVb0pDRFd6SElaOXlCYmJS?=
 =?utf-8?B?NFQ3bkNtMUt1Q0dzWFFKY3RtVEdweUZhTnAzWHNFSDRRVmNlTGlrems5b3lu?=
 =?utf-8?B?SmYyZmgyK2pXenhPZWVRQ3Y1WGhkYlBYM0JsR0phd2sxTGxKUkRURzZTbGh2?=
 =?utf-8?B?MTlibWdmY1FFRDZ4bVZwMjFYcXZ3ZThnRmg3NWhTVDU0YWoranBWNHlBYzNQ?=
 =?utf-8?B?ME9SdW9NbEtkVmVkeS91S3Q1VG5EcUJQSmN2YmRwNWtVVkxjZFVLeDdqN1h5?=
 =?utf-8?B?ejJDNVBpQU1RcE9MaWUxeFUvR0NQZ0VNTDN3Rnd3cXUrQ2RSbHJGMG9DVXp0?=
 =?utf-8?B?Wmd4M2UwWVBqY2JZb1l6Y2hmdEwxWVVZV1VYNXVJMlJpZWVEeStiVndLbWlK?=
 =?utf-8?B?cmxXNzM2YjlvWk1Lb2VwTktEUFpsZldZZmw4TTFFMHdwaDN2eHk0OHZLeXpS?=
 =?utf-8?B?bzBFNWZFQlJsR2tOaTBSQU5Fa3VxeEg3RXRteWlrUzRuWGxCSENYNkp2Ti9G?=
 =?utf-8?B?b1Brbks0V3FaK3Y4UjQ0SUV0cEl3MmIrL3hMTFBTUitHSWFOeWpWQlNMRHRY?=
 =?utf-8?B?WTBKQk1PVTF0YkN0UjJETWxteVFDVExaMXZKMjh3WFRhNzhVcEpZQ0ZFeExK?=
 =?utf-8?B?RTIzTlFzZTdSL0h0R002b05qaVhWbnNBdUxsZEhZZW1LUno4SE1QRTNpYVdI?=
 =?utf-8?B?Qk1zTFBiZm8vUUZDRFQxbmhtNGNxaE9XOS9DeDlMNnhGcWJCKzl0OENtUHd0?=
 =?utf-8?B?aXlzZ0x5THAvbUhtNGh0ckF2VjFiN1dYYjQrTmtkMzViZkZmUzQya3ROTjE0?=
 =?utf-8?B?MENlelZiaElNd3F0UW1qZVY2YWdqaTZTa2NYamltY29NVVNadEl4MkFHTC9U?=
 =?utf-8?B?OGVvYzZPNlJwTHpUVjY0SWZpR2FIcElXTWxMZStjc2FlR3lUcHZpMUtEbXND?=
 =?utf-8?B?d1R6QTdDQS95THluTUtQRHJqUnJjRCtudFNHSEU2R3FzWnhwU2JaeEMrcUhj?=
 =?utf-8?B?VlcvRW5CUVA1cTllZkZKalI1S1V6eHJ2dXlBL1lBYlVZTTBtb1MvNHVVck5Y?=
 =?utf-8?B?cEdjWFVocFRvTFIwNVNOUFliM3ljb3RxcHNPQm85YkxydXc1TUZZZ1dzNW5M?=
 =?utf-8?B?N1F1Ujd2a2pRSDB2TkNIcC92SXVndUg2d2Y3ZUxyaWhYRDNNcS8vdHVQQ2xk?=
 =?utf-8?B?TEVML0kwQmtDaFVIb1MxWHg2T2x4VVhlalpPL0NXNGcwUGpGM3I3eTFRaEFo?=
 =?utf-8?B?V1VqWEsyeUtnRWd5UzZBamtaL3lNTHF4ZkRwOG5GRlVndWM4V2VyNStOYjRZ?=
 =?utf-8?B?YXVoWm5VRGlKTCtxajNxemV4alp4aUJnOGxadzdFYVc1WWtzdVpKYVBvZGor?=
 =?utf-8?B?czBQODVKWjNFcVhGV0dHM1c5cGdnZi9zWFBueVdSOGZEVVNpbC9PTXRxRlhz?=
 =?utf-8?B?RWhpM0JwanNNVVRYUm04a01GUk83ZEkySEQvdnQvai8rcklySjRQQWZTNlVB?=
 =?utf-8?B?K2JoWXA1dkJyV1Y4SmkvaTV2VVBOeTFoM1FGRjNXL0hEMUdoZWZjTUFHZEta?=
 =?utf-8?B?VkRwY2srL3VJRWU0SW9uRFpNZHAvZlpEejZaOTQ0R1VUTXIrNzVKUTBncjFG?=
 =?utf-8?B?ZW9LLy90UThDNTFIOHNXaS8yNDdQMTViMHl5bEhVMC9QdnFOOSs3cmJMWUxx?=
 =?utf-8?B?SkwrcTFNN3ZDQjltNFhIOGhtL1lCODF2SE1kK2g1NzNsZFpOYmZUUU0xdzBK?=
 =?utf-8?B?T2kvUUhDaSt1YVBRZkNEOHdzelY4dnVScGM5S3VTU280OVoydFVmcjdVTCsx?=
 =?utf-8?Q?XCUyCNHRoxpHA4lAT5BGMaqrK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /AIqCk+SRqttS5Y16BFWViTKUNBzP73Ivv8IEZ2ZDkDXEkyDMngXOZ+Wu50t8ntrBKnjIaRZSliA53ysn3f5fMAU3Hx06N2JjGtCajHZKaS3Bs3e7kSQjg1C/Fyir6FtCo/jMWjB2uX4JrT9XyBMlRh7tLB4gZRx2O3WT3vDxlsz5fV7VigiJtqUdkxOEzqzTlax/Kzq56oNMW2pw5i009WIjLlnE72Jnn226Y9qVmmXoHpFmbBSpho8Zn8HKESfLgzzT/lb6S9SfI+XZakn/WSxUQryERFiHcftdNv323d20FC+1q1oIq2DDlvKGiiDLTbCwV2969VGNHcDydKuzwhpHPUDJr2VIV6vdeLyMUk4j9q+OMp+l2NG8KFDQaMirtt5nEWme3/jrQCojtB3aHXS/rsvOhjJsioZyGrXuF3iaxZXSxIVDdIbzIhn8yMrX8DV876sQgBxJuuy0ptazb/AK9yaOHJczXP7s5oZCJIUhAV+EIbXailDQ/5vrE7j0/FtKtRLDWofSt/+nTRu+rgx19juyHLI11Ey+IhQd0HXC4mTTm47rTwOBIqsVmktilJ1aeQjmsL2/LCpB5XVwJ/FXpO1seL+rCRx1AguwcEPJ0sMZsLDBtW96CfSU9YP6Q+513VvEfvsCd/lGFsaWXa9LAj8iKrRRV6hV1NRwlH1S2wFZfSFleYqaeOgPg+p2Qt/peUXFyoANJrYuLRsN6gfM3qiCrk/EUkropWujgnxREkq5Q1zsD+s7s1HxSu+DJgmGpkneNF9MIxHPalsZJavW8XhT50Nz5bscLEBN9A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfc6cc2-0291-4d67-2c0f-08db2a09ed87
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 12:43:53.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9pFO0vESy18JaHI1PYl0+fZNxIbW02kr8rtPtnPTm/vIWLTOpPoKZarTrSgCmkDLR7zST6oa1SsLXnbse9D6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_08,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=996 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210100
X-Proofpoint-ORIG-GUID: QLvXpoZJQMxCdAi317imafr4ChYwHRVo
X-Proofpoint-GUID: QLvXpoZJQMxCdAi317imafr4ChYwHRVo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>

