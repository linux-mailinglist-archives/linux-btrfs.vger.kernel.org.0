Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914547B1053
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 03:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjI1BZw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 21:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BZv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 21:25:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCF4AC
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 18:25:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL7SGj003991;
        Thu, 28 Sep 2023 01:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ATj8zEr/bLDxnGJx5d0P/Z//MusSaMKqG0brTi1Bb60=;
 b=rLrL6HYLqBHTz3+CUmkmrB80iQr0xI2EVjd53uaikSFWR+Z43uPpFW2k1K6i28iHRuzA
 nKjHEvJkH+Vm4KSNYpWtHeF1Z9ByCp88vRWk7pmGVlvznVXXyjyp5DjCFbhbU1jsb3SX
 UO4IGJGXcLIWHzqpf+Fr+hFzfaC+bWdc5AcZxhKfWhiOaMrAQ7nLCob7uB0QZfXJFejO
 ySWjg80NH3lPaFIh5Unk8UuHpIAT1wxxF3U/z7p/fDweENoZFpfjJNb9ZC8dAYnaYWLt
 bdvg4tZYp+n+awRr4fyX35ldAiDeEsjWs4omU+TxM0qwhGm59Ljl+JM0bAMd4A1cNr7I /g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjuk032-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 01:25:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RNT5j7030822;
        Thu, 28 Sep 2023 01:25:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfetkxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 01:25:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsrThNQRP89HrfzzP/amFHFR4OyGO8avwVKeJr29vas803F3lx7kSGW4s7MoaojPEL7rNaRfo86lHqheg3Ex+8j0s0vsvZs+EDDbYBpQDvBpYkXa8oq4m8fIroNMhCnohQdPe0WjumwoPei1Vh8AKvdv6SEDuGgOdLLQUfW82avbVfhBdEriJFZ+iarOwQbZM8yySrs3oLHg8WtWjkoQgbg5T9Yiqj5M3KmpJY6PinYJjpaLHfoECIBIElqqjc2RIy9mnFcteaMcSgoYZecGnO1FMLUbd5vi5mOk0AfmQOaa+OTkWim0Y8nhj2xfrIRZbsR23L837mpu5UHB3FHBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATj8zEr/bLDxnGJx5d0P/Z//MusSaMKqG0brTi1Bb60=;
 b=gq07v4Ip4mu0DDtsqV+EfAJ1zD0yLkTaCD0fST6+5+Q3K1bewKUvs/PTzLzQr8Qc2xDHj1FImqvacr7myyDAKcuT+rntmEds/GYREIuTcRKbG1cvHBC71ewB+oWu2ZLc9rw/9s2UejlJ2HSdjvEzWG1DmFA/l47gqD3U4spJxADuJ5DqT5wBDaELTermhm4npvaBQw6M0RabDmr+4Jn1KOWesUGgoQFHNnLHRvHRJwPJwcEwX50EGncPgOmK/8wxBhV7TIX4tbig99sY9j94rnQgFT/wI0bIrulSINkgJ9SuuPRzgdP4o4wVi4TA07bcW8FJbL6+9vH+zTEnVrGRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATj8zEr/bLDxnGJx5d0P/Z//MusSaMKqG0brTi1Bb60=;
 b=mA74k4TCR0NM97u9adq0DQaaWNX9TiR46Jpbnz+HoF/XMW4hqb4qeK1+MfO9xEyrgxZ6+Ue77hHIDQE5ueTB1NLOQIjlhRnc49R/Jvn6WU6Yx1HlRTEovrzQcyA9vkoaABNExIJ/K3VCRE/2KJ5SHrqtwpdXlIgMtizntIzQ5wg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4186.namprd10.prod.outlook.com (2603:10b6:5:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 01:25:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 01:25:41 +0000
Message-ID: <2da9986f-e53a-ecb6-ffc2-6363b450c9c1@oracle.com>
Date:   Thu, 28 Sep 2023 09:25:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/2 v2] btrfs: reject device with CHANGING_FSID_V2 flag
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1695244296.git.anand.jain@oracle.com>
 <20230925165806.GR13697@twin.jikos.cz>
 <757517d8-2f79-4897-7d43-5c12fd6274bd@oracle.com>
 <20230927174303.GA13697@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230927174303.GA13697@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: bafca64e-9c08-416a-b0f2-08dbbfc1d429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lgjTqHoz7L2fYilm4sKuDpLIzCZGRyTezFYcahuLiY9zmaxtvSBbUepLWJ4QNaYLazjKHQZ6dNGVpvdv2slnOqfBV2snkqZOC2LKRxYIh6t5TzwT9548OxB43M6nUVlFNto1B4AUo5SYIWui1lUsGbPgMfSme4bwY7x9IF0o4HEfkDCdcr7DnuXSyA4W2gVbQd7VGZq6dP2Banz0fZiEokq9/fC2e4Ym/uFt+vsHkv2lVuPlNmmZjTkpnJo1nOq2N7EO+XSo/xr7qxXLAyn9fU2RdB9Y37QcToI95vx8v7zfeTDr/UQeZ900HIAOS0SVRf20EkjVNl/3n8APtjySMiQMDzSgIPXd+riUzGWxBNiaDgbt2fiaWPk8EBqG/Q9TIIWDIvinn4qp9coWioci9N3p/CoUNJ76BM3OYpFoT3hklv41eUD/ui84nNe7Fsl7Fk1fqT99tCdFPsbr2/0C1TX0+UpvB/k3cLUNeEgDNGZ/3xae9pwAfTRg6pLJOKerL2marfuuMlNYxzPLal6lsN8dsGqDmazuYf63oqwzJpEoDUNNmAcMLQOV76l8Spya7x4UoVknT64nugGLhw7t6U6yVbVnreKTJuaTFS56EDSkoX0D5HqtDPegiwu4cQ5AI6525AE3iZq5+xRXRf2PoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66946007)(8936002)(4326008)(83380400001)(26005)(8676002)(5660300002)(6916009)(316002)(66556008)(6512007)(6666004)(41300700001)(6486002)(66476007)(53546011)(2906002)(2616005)(44832011)(478600001)(966005)(6506007)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTFxS2puY1l5MmE5RkhtTWxWUDVkeEFkM0F1Mlk5amNCOWpnQ0NVNVFwRWZX?=
 =?utf-8?B?QVY5KzhGU1NPTURWR3NHRjJXNDNTZitvSGY1REcyNDkwUThMM3dGekpqcDFv?=
 =?utf-8?B?L05MeXcrbzIrUUlEV1JrcmRkYURvb2dXNnFialJtSEtXcm1vbzN1U2doNCtU?=
 =?utf-8?B?RUt5RXlNUE1XNnVXcGFSLy94MGlONEZnZWhHUTg0dThYT21aZXVacWJwQUJn?=
 =?utf-8?B?bkNnN29WdU5pOUVLVjFtRFIzVmFaT3pzaDYrOE0rN1Y0c29vUlppTW5oRHhB?=
 =?utf-8?B?Rk1FNmI3dEhzdTVUUEQveFNEZko5MjRERlZWdEVNcWJ2RFp4WjhNMVBQL0t5?=
 =?utf-8?B?RlFXL3h4UTErQTV3YXV5ejRCOFZTWm5Edjh6THJwNm1TcTdrU2hKQzVLYVVQ?=
 =?utf-8?B?L3pzWHNqYmFNOHpBanFvNk9SWUl2ajNaSHlvU050ZGRmTnNDVEk0aHFWWmNF?=
 =?utf-8?B?VXpLTG4yMmI2VElTWDZXWFdBaGlZZDhmKzdoSWM5RUhaMEtXZ3BxN1FRdDVw?=
 =?utf-8?B?alhvckF3SjJMWVlaMHlZU0Y3bUJhVjNxZ01XV1hxbXVrUDZNOWgrdEgwV2pr?=
 =?utf-8?B?dkdFZVZRcHp2eFFTUjl4VDlEYjBWR05oS2dHN0phejBNb0NpWHVKRkI5ZFJl?=
 =?utf-8?B?b1B1VkozTjlWa3pyS0xJRm5OQUNnNzBSRVE2UlhVVVFtT3o5SVI1bVhpR0ZF?=
 =?utf-8?B?MExKWnBWRWhLSloxNmtUdTMzbHc0RW5kN09VQndvb2RqMG1jMjZkaXRnS2Y1?=
 =?utf-8?B?MjlMTEp6YXFxQWZ4aDhsUnpSTk9laHY3Qk9SZjRSVDlCZjNnYWZ1VTFFWEU1?=
 =?utf-8?B?aTdoZHNLMGhVLzVPMmJlV1YwdjVwVDY3ZU1JdElydVpxMG1NU3MyNlp5MW9l?=
 =?utf-8?B?RmFjOGovMjNyR1M3RkFZalFZZXdETVBKazdnRms3aDUyYXpPY1JkOGVsS0F2?=
 =?utf-8?B?bnU3d3RwcGdMWTRLTVRGNGd0NHc2M1l0YkthSStnWGl6RWFmYlJpWEViS3FZ?=
 =?utf-8?B?NHRPUUlPeitzQVQwR1pwZmlkbjFQTWIxOU8vRklIV0ttZllsUVlrUVkremJQ?=
 =?utf-8?B?NldoQ3JiYmhLS2pHOFg3TWVhRkJuL2w0aG9Ub1hlKy8zTkpzY3Z1cCsyWWRK?=
 =?utf-8?B?SXRuOWNkUCtBV0FNcDlocmZ1dXZ4Yko5N1JwSmhSblZ2T042NHZsbytBS1kv?=
 =?utf-8?B?QmdBNmVvUlBLdlJrb09qU0JWYm9lOHAvWTZjTnRtZGcxNldvampZeThSeDdp?=
 =?utf-8?B?cUZMMFlxc0lzaGgwQ3BYTFFoekV4Y013VEp3MXpQSHBPUjNyRS9vZHBUTktq?=
 =?utf-8?B?RGlEalplT2hnV3o1RGU1QmRmTm9PQ1ZmS1BEOTVHVTZSNldxTWJzUGUxTUpa?=
 =?utf-8?B?R1VxM0dVakhHcFlyUXNSQmpQcHFIQVpISG1WcVEweWRNVG8rTldYaGVHd0Fj?=
 =?utf-8?B?a05kclcxaHhaU3BFdEN0SXMrOFkvUTl1eWNCVE5kQVhBMmc2VnpaR2VPUlIr?=
 =?utf-8?B?ZWErZGt3WFVtV0FhMVlZZm53eUlnNTJlUERDZDJoNHlSVFpPa0RFanJEbW1P?=
 =?utf-8?B?VzFpemxqM2NVd2xlK25EZmh2ZXozTEFNWitZZ1RzT1Z4K3BJUENjRlh3WTFI?=
 =?utf-8?B?WFlGcllRZk1MdHZaaSsrQlUyZ0FrK2xEaXA1QU94azNNc2srWmMvTy9XUWxZ?=
 =?utf-8?B?d2kwZ2pFT216cnhhbUFTaFV1VmhCMkFaM2RZcWZpR213NWVYckg0ZUxxakJs?=
 =?utf-8?B?MUxCMVo2dTlneW80VmtjazFWMEtQVWsrcU5zV1RqcWVIcC9TNU9IZ1JCejdj?=
 =?utf-8?B?QWp6RWpGdVZleWtVNmF6aCs3SlIwdlkxZ2lqM3NaQ3NpaEFEV1R3T25lUCt4?=
 =?utf-8?B?R1ZOV3pERC9MZWFNWWFqa2ZRZ1o1cWxvUGRFc0Q3V2RreGQvV0JWU253dFNC?=
 =?utf-8?B?TzdLRmlXYzE1anBRa2Rya0ZxMHNqK0N1a0l2RWc0TjdXQ25xcFlGd2c5WFha?=
 =?utf-8?B?WVIxSXZuclJTNVhjMWtGZm4zbXkrazhvZnZNZm94U1l6SGFhblBsS2tZbDIz?=
 =?utf-8?B?MXNaN0o4d2FMTlp5VmdKUk5LUDZ6ODkrUWdCMWZmdEpoOElhWVRDTE9GUU1j?=
 =?utf-8?B?SzhySXQwS1NRVkkyNHgwaWxQY3hOb3BtQmxHZnd5M2hQRExaaGp3OTlwOUlr?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NUsNVJO1rHqJAIyDt2ItzZJ9M2EkHeKtLG5mklPB21kVxlK36mE+ZLRE4vgNgP+CET7imNigmcMefLBiZaoNKiuvQUviL82WrlmJTPjg1V0giFYzr54Bv3xvsZFlUkwaQeliepUpJzD7SPbeBbmp07N6QrDf1+3qpqvCeMWcsobwx54RMZ6BSD8HFsSqd5b4CwBGUtez8HKwZyZ4m0U24Oy3tDSjn1MiY+Pz91FCpJxqunOkw+qUv7u7gkXRom0FFCjAJKXn9G4ydyZIIBDanMBAWw7m8c74VG2zcCs3xbjnuIS3BFb+bwiwWjp5p9ylgkzJIp6PYWMJeM1LyT5EKMA3TaX/KpOLcI/Xwk1oWqaR/t+bfFVwqtFYE89xHODOxSLu1bXuzZoMLcLefGr1KB0wV8kxfisG5s0DWS63z1nO7qEUMays+9n+helEl+AfNtN4TzuS2D9PbsuILz/bypbiofQ3IMrFp5CMr3fdUSGiautpfGnuAATp0bpRlwmv2tFyiSWQtO0AfKre8B2Jghoef4nvmJSCLfi9HdWyg/1lTYny/tUu9j+xHeePrT/Qu1TthrnY437HGDNRGwX2l8LiafXhBrC68Ww4uKBY2ExaY6IRJrxwE0DnT6POD++Z6vXc6I2TlsjWe9ksQ8m4b7X0BMX4BmGn2/rtsOk+ZnhlFLeMMzi/JMxFo17lHj97D/MAMoLATQBUwTfXnVLqGJBfpDUlCdvomdB3fWWH/9vU2tM8J6prlaNp1n9+B4TVzg3EpJ+S7bGSNQLu/Gfh+0wx15waHNtijFs2ViQT2y4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafca64e-9c08-416a-b0f2-08dbbfc1d429
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 01:25:41.4992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/+H5TRpPlf6BZTegSSx9luP2RwOX/XK6fK8mbLaqGAEUFPb5mjFGT3RqBIMVRlMS4i3K27RM0nFxmzhn2VB1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280011
X-Proofpoint-ORIG-GUID: jzm4MTUAKL_MYYjzkhALYyuBEe0aqb68
X-Proofpoint-GUID: jzm4MTUAKL_MYYjzkhALYyuBEe0aqb68
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28/09/2023 01:43, David Sterba wrote:
> On Tue, Sep 26, 2023 at 07:56:57AM +0800, Anand Jain wrote:
>> On 26/09/2023 00:58, David Sterba wrote:
>>> On Thu, Sep 21, 2023 at 05:51:12AM +0800, Anand Jain wrote:
>>>> v2: Splits the patch into two parts: one for the new code to reject
>>>> devices with CHANGING_FSID_V2 and the second to remove the unused code.
>>>>
>>>> The btrfs-progs code to reunite devices with the CHANGING_FSID_V2 flag,
>>>> which is ported from the kernel, can be found in the following btrfs-progs
>>>> patchset:
>>>>
>>>>    [PATCH 0/4 v4] btrfs-progs: recover from failed metadata_uuid port kernel
>>>>       btrfs-progs: tune use the latest bdev in fs_devices for super_copy
>>>>       btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
>>>>       btrfs-progs: recover from the failed btrfstune -m|M
>>>>       btrfs-progs: test btrfstune -m|M ability to fix previous failures
>>>>
>>>> Furthermore, when the kernel stops supporting the CHANGING_FSID_V2 flag,
>>>> we will need to update the btrfs-progs test case accordingly:
>>>>
>>>>       btrfs-progs: misc-tests/034-metadata-uuid remove kernel support
>>>>
>>>> v1:
>>>> https://lore.kernel.org/linux-btrfs/02d59bdd7a8b778deb17e300354558498db59376.1692178060.git.anand.jain@oracle.com
>>>>
>>>>
>>>> Anand Jain (2):
>>>>     btrfs: reject device with CHANGING_FSID_V2
>>>>     btrfs: remove unused code related to the CHANGING_FSID_V2 flag
>>>
>>
>>
>>> Added to misc-next, thanks.
>>
>>> I've updated the 2nd patch with some
>>> historical background.
>>
>> Now much more complete! Thanks.
>>
>>> The temp-fsid patch now does not apply cleanly,
>>> I'll do a refresh on top of this series. Once it's in for-next, please
>>> have a look. Thanks.
>>
>> Sure. But, temp-fsid v4 still has a subvol mount bug, as reported
>> before. I have a fix that is in-memory only. I am trying to get a
>> reasonable list of fstests passed before sending it out. Guilherme
>> can add the super-block flag on top of this, although it is not
>> mandatory from the btrfs internals pov. I will send out the
>> in-memory based temp-fsid soon I get the fstests (with some fix)
>> working today.
> 
> Feel free the send the patches even if there are still failing tests,
> I'd like to get an idea of how are you fixing the remaining problem(s).
> Thanks.

Yep, it is almost ready. A few minor cleanups and code optimizations
are still due. However, I have sent them for the review comments.
Below are the patches in the mailing list now. Also, after sending
them, I realized it would have been easier for the searches if the
subject included 'temp-fsid' instead of 'cloned-device'

  [PATCH 0/2] btrfs: support cloned-device mount capability

  [PATCH 0/2] btrfs-progs: mkfs: testing cloned-device


Thanks, Anand


