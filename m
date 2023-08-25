Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D885788C00
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbjHYO6b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 10:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjHYO6F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 10:58:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6376C2106
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 07:58:03 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDO3DY012123;
        Fri, 25 Aug 2023 14:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ev2GlvkwtXuktD/O3GhCJ/uMIuBIqPp68S9bOsIT9LY=;
 b=IFy8EW0Ii0XjfTX/XtMKcjORm+8ucgqp7d3dvANy7uMviRieyqlR7hrb0eCqxXNmcgx1
 5DbBYkx056BaxwqqsvsjloiBxxr96GyAlWfs0xkXQPTOqSHI7/O+ACAQvmTRD0gurrdb
 28lLNlORgxGkbjjKq42jZj7rhQig86ZPfa5wVmJ5rHvbiX2IVi439o0LCuX8eQDH/2Wg
 Uoj9elmHUicpA9IQIi1TgCzp5MItPdSN6kAY1A4koamjjm/xaL9zLZw1csrHtElDzPfD
 +EUxvu9nkFq6VR22DaDXGcq/RJY5yUrUcI5i5hD0f+CaGCrc/TK3fca2qAA1ILaoofUu gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yu6p77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:57:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDIaPl000969;
        Fri, 25 Aug 2023 14:57:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yuxcnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:57:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkRC1KgVwckJmbX2rp5rcxNHSaVHdg9sJC3KmrC+0G3JsDJ9F2iNbFM7wDbP0rzZtm4FDxl9yoArYEhptoYXHt4lZ5emvws8n7XzNrFGCSxMCLL+7ULzLgTyxG31U/lJ0Ol5hCAyomLcUMYBCn8HPsxdRJ0KwiYJvCnogOPWJUNfPNeOEIFmbs6dtyxQ+scrGl3nh1jd541uR6+a/bqnrtTHpCGf0Q82WBK0+e0z2zLC2qjzHniVqIA8evRgnadjVnMHjjItjsGuxijqtYcuaoo6WqElKmdy2HpUuUz4EmtNhtTZIgl9aBsGlBNpUyPUNqo8Un5L5JvGj9UVr5vP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev2GlvkwtXuktD/O3GhCJ/uMIuBIqPp68S9bOsIT9LY=;
 b=aH46XC1sMXXE15kAA0Yw6zILLfvF3jPioYQb+mbHuqA2LjmWxaqVe2ZQGM3p+tfdFC6GtyvN7IqJMN0oNc8pB4J/Kf9u7pZefrV2/aY+QgyXYss8L8joj2TkqiJPvZ7ohIApTXo4J0svGj9MKjNbB3+uM5/rwQIdi7x/pjssNhAz4AJlTcx2Juf3oph4AwDwLYlbRg/7082zngheyAZWjKRGHxHeX4NS/yPbYG2ihDwMFeCDl0Om5cH2x07kYkLfprCa4egbE075AytaUWoZGBw/VgxTKNkEHtwZwDMf7S/Yz/DK4QRIa7Egvb5hM0cer7+gqYmYEfZaRUFX3Oa9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev2GlvkwtXuktD/O3GhCJ/uMIuBIqPp68S9bOsIT9LY=;
 b=lNAdDrYt6O/PlDsPTXBete+U882Hdd69+ZMoqN6myj2NvOV9wtcu9pkuRZwHG89f1BrPLsftQgShXr8ZdvGCGnLsYk+m+SJ1Dh2IPh1/qEo2slFHIsSwHz0i4E+rHUpArzgfzfz1DNfrAtiURFe+TyioHH5F50itA35gMMDiD/E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5579.namprd10.prod.outlook.com (2603:10b6:510:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 14:57:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 14:57:56 +0000
Message-ID: <24e268ee-e1eb-968a-e630-f558147cabca@oracle.com>
Date:   Fri, 25 Aug 2023 22:57:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 00/16] btrfs-progs: recover from failed metadata_uuid
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1692018849.git.anand.jain@oracle.com>
 <20230823221315.GL2420@twin.jikos.cz> <20230823222434.GM2420@twin.jikos.cz>
 <ee88691e-f484-58cd-4e48-50d2671e7e71@oracle.com>
 <20230825115301.GP2420@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230825115301.GP2420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5579:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6dfd23-4e4e-464d-12a6-08dba57baa48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yNpkZBncdqeExaNB64nAoKTmUJ+62zJX/GuWpLQl+vktHW+zUYJ2ik5b18FpASO11gnfFkrUdfBWIfTXaq41Q4uqhOM9KWjWfyUCIgkty46bNns6xCYwZv2wP5NHVv5nu50SgltT2e9HVvL5tF5chZENBogMDAqzi7pqhw+6LBCM2ubOtBC5r0cKgmioGp9Oq1PAKOVrdCFbMIxxmoQWS6elyTpZooS+uQh5t+pfxvA5efbAmkbg10PGD0CF0PjdNGRZ4QpcwdELBuM+BESOHpf4I4lSLkyMybmGsnAAADT6YXjrqrjJsxhi8DjNdta1mxBFOryVT9Uvm+mkErHWX9kXF0GytLhLV0l9NtEFR/CmIge1tP0nTK63LlPpFjSqpLlQc/LNSotWd0eZIJdio4qE98A/4hP0rKgtregDQZaZ2EJwyu6Eopg6hZ22PkEpQ8R0R5GdPENfixqI1HahOc7rRFC1g6dnYO57Hp1RLBQn1Md1e8gJdz7xH8ZGSb/DN7pswUydWdlmfUfFcnYkWShWDynZSiAlme+qaLD+5SmHvl8L0m0tzdwSvZn7NENUyZJYSBYm7FmJHV2uBZTEFrR3gAsfOKlDBIfPKbuxYZpTaBeQc7JbWnKZj9GWixvxspxZh5tc/2HwTFC1BOcdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(346002)(136003)(186009)(451199024)(1800799009)(2906002)(66476007)(66946007)(66556008)(316002)(6916009)(478600001)(26005)(38100700002)(6666004)(41300700001)(53546011)(6486002)(6506007)(86362001)(6512007)(31696002)(966005)(31686004)(4744005)(8676002)(8936002)(83380400001)(2616005)(4326008)(5660300002)(44832011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NktRM2k2VjhLdUxyeWNiN25xcFdRZVY3UExxVHlPdFFxdkxXWlozZU80NldI?=
 =?utf-8?B?TnZvcFJsQ2haTzB4RjdoNm90TzQ1NmsyVEF1ZEVWbUJ5SmJmcjBIeDQwVi9U?=
 =?utf-8?B?NCtwUElVSlN1MU9wZmthV05IWnA3ZGRiaWdsRTJHRmJDRGhUajJnV0VDV3hn?=
 =?utf-8?B?a1FpMEc1b0U3T2lLWUFMUk5uOVk0ekZjQVBPYXo5YXp0UWtBK2R6WkRwRGlj?=
 =?utf-8?B?OHMzV1d6Z2ZoTXllTldaSnZFTmZKeENsOS9VU3dQVGZVNGZUS09rZy9jeWJU?=
 =?utf-8?B?bGF4OVRWQlZRbXRyVWdaSFpVajd2MHpMQWM4QjdmcWIzdGZRdWtnWWI4c29o?=
 =?utf-8?B?U3p5T21sc3FVcmtjMkFNYnJ4MzZtSkQ0TjI4aGtZWnRteUFVanZWYTBsbmdv?=
 =?utf-8?B?Y3FmYkZJTDZOZDY5MVVoT045S1BqYlJqeFNoemUvbEErR3FMMXg3Mzd1QXNi?=
 =?utf-8?B?S2M5dEhEYzc0aHRhSjVNRldtQUhIVGJ2VlM2TFdRemNwdUFjWFMrdXVPWW01?=
 =?utf-8?B?L3kyWncvdUlZU3FWMVNFY2RrVUppODN2K3lWSTRpYlRDdWphY3ZwU1oxWXJQ?=
 =?utf-8?B?WE1rN2xWdWtOdGR1L2QwUWMyQ3p4M1VzNkNFVGRhMjllRVBUYVNZdVFvUUw3?=
 =?utf-8?B?MlhnTE9ZeGY2REdDdHp4T2w0NldoMkRIS2xFRlFNa3JmOEUyalJTWHVaOWha?=
 =?utf-8?B?bVhIejFvNjVtWThCR3lJTGRLbXBTNmJvaEVmSGs5djRRVEhMMlJaSzl5OU9o?=
 =?utf-8?B?cGNHMC91bWZveG1ScWE0VXJ2b1JUTnVVcCtVekdXbENIY2RWRWw0ajF2UGRl?=
 =?utf-8?B?U3B1czNBWEFEUllsb2dRVGI1b2FkekdaRVVNdjI3eC9FajArK1Y0M0luMW9P?=
 =?utf-8?B?ZHB3SjRCMFJrd0lYMXY4c2NnUHVBQ0xSbjN6RVFMajZjbHlHMlNPdkgzWmp6?=
 =?utf-8?B?ank5bnNUeEhHSEI2SWVFRHFrRzhDb0o3SkoyR0ZRM3dmQlozbE5vY2RHQWww?=
 =?utf-8?B?dHhZUzdiT2hpaEdLelErUHJmcHNzalMrYXVtdUtOZS9kR25nejVxa3p0c0ti?=
 =?utf-8?B?cXo2dlY0Z0I5TVl6YkFiZnc2S3pkMWMyOWZ5QTF3TTB0VzZsQXAyRXBDTGNt?=
 =?utf-8?B?UThnTGorRTE1MnlSMytDcWRYQmhEUHNnM2d5d3JqT0VjY1lTelRwdWVqcVh0?=
 =?utf-8?B?Q1VwdGJ4dzkwR0tQVllScnhyRGtVTm5BbENGenovZTJRbHNRSnp0djNHUzBo?=
 =?utf-8?B?bm85dHp6QzFkdW5UUFNsemoyQ2lobEd0WGhLV0FQdytXN0F0MVROT0dYSzRT?=
 =?utf-8?B?MGYzcnBsOGgvNXZHa1JwbUN4d01BWlhrZ2kzeGxOd3o3MnNRdkN2UndlZys3?=
 =?utf-8?B?KzFVVWE3Y2FvbDF1MDJkRys3aWYxQnVQa1J0cFdzWVh0Z0ZsV1g1K3Q4V2Jy?=
 =?utf-8?B?bHBGd1NPeWd1eTFIT1E3aHRSZWJiaHZiVTZuUHViMm5jbXNEQnN0dk44ZXhG?=
 =?utf-8?B?QnVKSXlBWnN2SDYrK2RUN2xQb2JqemViZzNRUzNhdUs1QzB0NFNINWUwYjNV?=
 =?utf-8?B?V2wxRVphSnZOTUljMUYvOXpweFlVQzBCaFdaQUpKT3Y3bmFydHE1NW5NaSsy?=
 =?utf-8?B?SVo0ZElHQVpIS3UzREVRcThLSUNhZlc4UkpwMkxRZFJHRUp4ZFMzWVZtVlAw?=
 =?utf-8?B?NENuWi9WV0tBOFFsRzBObXVHWVBVeDhmUWpGdzdtWmlUMUdsK2x6QXFSRnRT?=
 =?utf-8?B?aVVTb09PV04vL0RxVmh6RWJYNnBhVmQwdS93VnhaN3ltR0E2Mko1dmtNZVps?=
 =?utf-8?B?V08ySkFaSnpSdGxWWUd6MzlJRWxTUDM1UjJ6SkpCcUVsUUVJbkY4bThrWStI?=
 =?utf-8?B?clhHWXRkMjR5aGVpL3pES1pTcGpsTitkdWlvU1M1aGY3RXF6eWVzNXZReGU4?=
 =?utf-8?B?ekRIc3RwemZaT0tKa1JXMEswcmg5OHA4ZFZvNS8xczJOZ1pVNSsrbnFvbGZQ?=
 =?utf-8?B?Mm5OUHgxVzRIUitURjJOVUp4bWhucUZPYlhOWnZ6ZEtIbTBQcXZiblpteElM?=
 =?utf-8?B?Z3Y4WXdVMGx3ZGE5K1FGMGlvMTZjdE9PWmRlSE5tMjZWYk9ES1ZIYy9VSnV3?=
 =?utf-8?B?SURzZnFOWG4yR1Z2aGkyS3dsVDdOZ3E1c3BrWGJvUDVqdUFQTEorQXIwK2JM?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fuozMoYFm2ticxx4p5MR1vCEzQP8Qo51+tLUNo38w1MAEpP0akiWl0qbhsRYjQjA9LpqaN1LtCvWd3Tu9z8G6egaJUGBZe6Ow/d75248oSXeH1Lkyd7fJxWRVVQYIIP5ps68Z2yWBtiIDGwgiO3IfYReo9hf7XZxgBlarZrUFB/hQ4bmFJpNAFAio3hPVCWfd0NLbbXqJ3OKzoIYAiffilAGaPDJJJEr2kR6yz9WDu6GjBymjQIx5DommCXEOCTARwp7K2eftvlv7o57M6qCUvw4J6hXDA7+oiFJw7H3YFc1crNEQ6Xn1IMkJHNk1QFJ2siwbi9XZ+R5qhujtX6k4Zgv2fzvflOE3E2C7iJeLScNg5uNEHKJN6tuEU2gT2Wg4GU880DNjQ+hFrG8mlP35RMBnx/9Rvy6n7GnWfnj6tUym1w7TpE+i2gKD3CU2ljKCHk8ivoRoVPoCFfl+iEhzq6co3woXnW8uMwQNepoQg8m6HPDt/80xxfWWes/leGlU9Yoz8hsDHU867gkU0IcP39QSX2XFg//FCdWm2mggCKoCZ4DOIqlHPRFIiDPdp0R/8njgUgjGtAMhUeN5g/eP7p6JqeKyRFWyUUpgOxwCgjegOfeN171DAyTzff/e3F3ikkuc7Fek37EkQj5CAkMNt9a5rPYewFPKE9ljz/+fP2Mht67XjB38fz2ccHgfflwcx8OMvR0if8KS+K72XhGHKVm6hzy/7Q3s47p2CVrHe6lV9GeRpSHwNGrvhrP/Y81Ei1Dh0SQS+d/jwUdJ+Dfg5Nvvi7fMig7rPhoA8LfRBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6dfd23-4e4e-464d-12a6-08dba57baa48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 14:57:56.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxPSpFQiM8J4wTtAhRy3Fo/QHxhGQB1BY0zSbHa5OfMFZ08AcA0LiqcYEzc/uYarEiZmSmE9cuTY/gplcdLLEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250133
X-Proofpoint-GUID: d6S0S9VgeITgjplrPHji1_sS2gbJftF5
X-Proofpoint-ORIG-GUID: d6S0S9VgeITgjplrPHji1_sS2gbJftF5
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8/25/23 19:53, David Sterba wrote:
> On Thu, Aug 24, 2023 at 09:54:30PM +0800, Anand Jain wrote:
>>>> Patches added to devel, thanks.
>>>
>>> On my machine the metadata uuid test does not run because the module is
>>> not loadable, but the GH actions report a failure:
>>> https://github.com/kdave/btrfs-progs/actions/runs/5956097489/job/1615613826
>>
>> Local VM successfully runs misc-tests/034*. However, on OCI, the same
>> error as GH. Error reports missing device. It appears, inconsistent
>> results due to the varying device scan order from system to system.
>> I am looking more.
> 
> Patches 13-16 have been removed from devel until the issue is resolved.
> I've enabled build tests for pull requests you can use the github CI for
> testing too (open a PR against devel or master branch).

Yes, I noticed that patches 1 to 12 have been merged. I am able to
reproduce the bug. V3 is tested working fine.
