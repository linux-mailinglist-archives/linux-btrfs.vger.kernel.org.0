Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA075720B
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jul 2023 05:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjGRDAl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 23:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGRDAk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 23:00:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950CD1B3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 20:00:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HKOeEg026084;
        Tue, 18 Jul 2023 03:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=K4H52cn22No/i5rOr0BxbUyz2mzEX9r9NkGE5weDzA4=;
 b=UFjsFvORtXviaU0+N3mKfESzMhJGHs54NOGYYSDNUmpEe/x7A662YJfGSSRITFA0H5DB
 zLsIGDHAedfI07NjP7HUpKY0s/6kSD3ESM6pTaDS2l+OheIO6IprAsliaDZfoI/t/t96
 Sypu81LbzoLTpIqM0UtZxJM+0fUXM5DLNDGL8ej4wz9GA0gGeUYNApjUtB/OQYOyk62I
 EUIRmyktOCI7q1uI4c5GegWaLHm9Oobg4GAnY1b/5g30PYW3NAoab0UFpPRPKJ4702AP
 fQiVqHu4LabkVilKf/dP7jERhit8D3n3MuKgCaf1JJOf/0cB8b1FxVBMIAciAa3N4WpS QQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run76v39v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 03:00:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HNaLs8000855;
        Tue, 18 Jul 2023 03:00:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw4frag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 03:00:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwFGyiuuQWHVDsWAkX2kR08l9VpQL1X2i1cnl83CIEdwx5xqFBtutbQpXNQg52LCg10hRnCdevhbWCPLfAEnNUeZNyIo7kTsaF8GW+/HsHy77B6y6Wm9owv1slrosTPiq9JNYvgWBV3v8+lcIChyMLK3qo7iHIeHIqhuOBjcsyYIR1FUPWcAR9nw+bRJMvQwM6R8S86ALJ5SoxM+e2Y5+QbSbWxicfjT6y3MTc56OkvyDuc3HdPBBfENp/Jc/NeKltGox+CRcMyZ3SRk260p8KhxX2NIPAPqKlwFWdOw9ufZtf+c/TRohQKt4Jnoc4rYCZUzOV62RksBPlhRIYgJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4H52cn22No/i5rOr0BxbUyz2mzEX9r9NkGE5weDzA4=;
 b=UqU6zQa1HlQIUpmFJahDb8Cmc4Jo/Md/E+JHKpJOCB3S3H3uAcFo5ecU2Z7cTv1CgZuDeQJd1EnyrkvQUNYGhXyYC15IEGI6PBROa8R+9YgU/n4YOsWnw+xwMrU0VhY5ie67LY3hGf5meTbiMgQ4HFEW062nmy7xA0R1i+gDT99yDBrVVn430qxlsguNEFHanjCKzxjC7a3gy5yAKa/a2/dnjeQQvrA48BgwM1kD5FEAXr2tsgB9fRf9gOkKLdDmBuVzYBrVXKpQfNvs1bnFudmqBeycAg/bgvtDl38n+vljRshSotpa/78WqF2O5h3pjkB3c/59y2271FY1NRZWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4H52cn22No/i5rOr0BxbUyz2mzEX9r9NkGE5weDzA4=;
 b=F8mvgIv6iR5L/vkG6Dx4GXsbO0TFZS5U1R+Ux3t9IXg7XeMayBztfwWS/vcMYM72Z/CX0/F+JVnEl1TgU23aewm3pQpYDpvDZHC/4wZHjWQta5stJ0HzahFSoHyK9KJdxT0N4jShV9mprPANFpt3F+HVGgQgQj1j/BokD1hRO9A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA3PR10MB7072.namprd10.prod.outlook.com (2603:10b6:806:31d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 18 Jul
 2023 03:00:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 03:00:27 +0000
Message-ID: <241e039d-be27-19ef-106b-2167574042a8@oracle.com>
Date:   Tue, 18 Jul 2023 11:00:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 01/10] btrfs-progs: common: add --device option helpers
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1687943122.git.anand.jain@oracle.com>
 <b369f8c90aabf121c53533ff60004b14cb19ec7b.1687943122.git.anand.jain@oracle.com>
 <20230713184101.GA30916@twin.jikos.cz> <20230714212855.GJ20457@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230714212855.GJ20457@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA3PR10MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f74a7a-bc49-49f5-97e2-08db873b23b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vc6UZvhC4Pgv/rL1brqWK48GGJKxKHUUGd55UTAhlEKllLEYpfX36ZylYerZDI9QwwTbx45KVKhr72h5EoTxJYytpvHiURrtEx93lXCIfus0CgavvS2Xb5EUAbEP4KwH8NSs/BC1Ncf4Eg81aGlS3HVTcXKf8hdDfTTlJC1KRA1XdOaKJgR3mkxwqA90y5LofQrp6QUX5WL/sISdWzvITb/EjOjOQJM+vtMk5Aruo58Kg9A1RkdXqRo9zc9O0ANALnzA79aHA6z/1TS4o13tquKyxTFngNiIqeD7JJUqL6DoymHwA/HBAtac+MbYFVO4Uk0xs2Z4+VZh8B2Mxm+c0unm/rinjfjum/fXozKVcunFVbismvU5zoYwJvVhM+XoyLXqUszhsxTcVmxisAXeC0msKr9uDIzVLvsKUjRRsHfb8Mk7q5yk9ylpK5HIjEdIMaptjfJu0/Pz8fIM1rOV5dIdYY9Cbj2ktIoV96dS+ygktimLYTs8cekkl2FchfQqpzrCtKJqzDC4zIv9uOSSJb4SB164xa/rftX72qAxkLXpWS38D464W7X06RENOgtGWOL4BKw4lYebJwBuW73fqIjR3SB/x+mbpx8UyTNY4wjGrJJeiOt08knLowYVOXUWGS0VoSA/nt3k4DxVI6UL+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(41300700001)(66476007)(66946007)(66556008)(2906002)(38100700002)(478600001)(6916009)(4326008)(316002)(5660300002)(6486002)(6666004)(83380400001)(31696002)(6512007)(86362001)(36756003)(186003)(44832011)(26005)(53546011)(6506007)(2616005)(8676002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlNaeU9zVnA4bUxQZTA0N2NkQzBhRDBJbGl2aFV5YVBKSkVoMVpmcDRta3gx?=
 =?utf-8?B?QWJEaGxTbjMrMzlvWHVSdEVnbWl4TUpQbkthZVEyMkd6THRIbVBqcGpHQWU1?=
 =?utf-8?B?Mk9XSGNGTGIzQnRHRlZQMGx3ZUpKVERmYjJlZC9BdG1oSU95RU83SDlGaVRi?=
 =?utf-8?B?aU5zUkJRYkJGWHp2ai9hNEJMaklwd1RDQm1wOXJaWGJnWi9nVUJndnNXRHh3?=
 =?utf-8?B?UnhNRDZ0QUJnNXlSM2FPSGY1SjNsejV5dUI5anV6QW03UnMrNWJWbmlxUzFo?=
 =?utf-8?B?SW5wWnR1SytKYXJhYXE4Y1Y2RWt2QU1XejBESytPdmlRRUZZcWlrNVBrMndz?=
 =?utf-8?B?VUNVT2ZJVHVCMEZrTnY3N3BuK0JMOEkzR1g2a3V1NmhXWjloUmJGRk52RHE2?=
 =?utf-8?B?d1lwMXRUN2lFWjFtYUlnNE5rdVVwZlZVNEVwNlNQVnpiL1hOUkxzeGp5QnFu?=
 =?utf-8?B?cm1tWEtlUkFxckkzMkh6VjlzUG1oS2hWL0VPZXhvcFN4UGJYaDhEMWsrbnd5?=
 =?utf-8?B?aHRIVHZnYllYU09mdEYrdFdSOUJJVTZ0UGJNYldhZXRMTFltMVNzYklyRmhM?=
 =?utf-8?B?SE12MEg4UVNLUmFIeVIwODJHRCtQVjdBVExEc0QvdW80U0lza2lENjdRZlRW?=
 =?utf-8?B?eG9vTjcwNSttTSsyckd1dUgwcW5rRDE4YkRXV1BVZkxwWUE3Qy9UelBoaTdw?=
 =?utf-8?B?Y2RWMVhzV2tNMWtOV2NkbHVoREZxbmNFQnVjS2NBSjk5R2IvZkZickFsTEVM?=
 =?utf-8?B?azkvMEpYYVZSYnlFTGJtTDBRUVFxbjNmWnhodzFtL0RDZUhabkNCOXRYWkdw?=
 =?utf-8?B?L21nZ2Rpa2liYW94RlRrdFlHQkVWK25MZ1FsVDkxVWl3OVkzQ0FnRzZnL0ZS?=
 =?utf-8?B?UTJZcTRCaVU1em9wbzNaaHpzVU9lemVhMjlaQ3I3ODQwcVhuMWxaaElIT2xI?=
 =?utf-8?B?RjVMQmJsN09reXdKVmRHZ2h2WTBib0VpSmpVcEQ0bzRkYU9XdDRsS09qRmpL?=
 =?utf-8?B?WlRzRGNTZXRpdmhscUlIQ1pxdm14RWlTMHh4ME5QMDJCWS9NTTRtdklCVUF0?=
 =?utf-8?B?MWtENlZEV2xOa3lkdzFHdHhJc1dyMDk0UmRWc2U0ZlRBcSsvSTNzbDQ4dlhM?=
 =?utf-8?B?Y0JBdE1QbDFCdXdlS2RaQ2NQdStQWDc4S3JTM0ZtOHBUQytTdE1SRWNLVVBD?=
 =?utf-8?B?dmV1UzFxOTBCdlphYVUxN2ZTQmNNbDdTczhhSUtXeVNiRnUzM1ZaVjJDWE40?=
 =?utf-8?B?Y1JwRmFHVEVkMnZ4MFQyUnlzRlVmZmlGVE5vcGZQTTZReldtd3R2bkVEOThy?=
 =?utf-8?B?d0RsMUFOeG4xazN5T2dMUnM3QVhDak9rTnJTd0J6Q05sSlUrRnU4NmxBTnZk?=
 =?utf-8?B?YTlZL1lCQkxBVGtpMUxzeFdPMEZuektqOC9EQ29XbVhocUZLOGFJdmFHWThF?=
 =?utf-8?B?MkNjdDlQQWQ5aEJkbFU2ZzhuV3h5dWVrV09IOVAxYXBWbVNIM3NiMm9MZVlH?=
 =?utf-8?B?NlNvWDBMMThDZ1BBa0JPcGlneE5QOHc1UUpiZzhMQXFiK1RJOWdYZ0R4OVdI?=
 =?utf-8?B?YnhkTmE2dnVlcEt3TGJHMWE4K09FR1NoMWs4dlhDRWp0c3ZxMkxRZGJMTjBV?=
 =?utf-8?B?SytXUFRMSkpSbDFvamk3d2FnczZsZTI0bFdMZkgrdW9qbkVGcW96bmVFcXNB?=
 =?utf-8?B?Uys3VE4rOXlUY1lpZWdEL01iV3ZpZnRWQk9yVkVmZzdtcVRYLzRRb2JaYkYw?=
 =?utf-8?B?MGYrNlk1TFo5aElPRXRNWHpTaVFkWUtyRUxIY1Z5Z21hSlJzYi9NTjBDNWh2?=
 =?utf-8?B?b3dCdHZzaHZPUU5kOHFDV1hqRWIyWUFEaXJaQWNzck54cE5PNk9tQWRRc2VU?=
 =?utf-8?B?emY2alZIL2pjdXRyaHdPS0puRURKT2U1S1ZXMjRMOWJhR21MdG50Z1Q1QmZJ?=
 =?utf-8?B?OHV1dmdNOGtoelN1b3ZOekx3S2VtWHFpU3hwb3JSL1RoMFJxb2F6N2FWb2JM?=
 =?utf-8?B?YTI1OFNwRVVFVVR2T0lUeWc0TnJucWlRUHRRb3BUOUFlVEJpSDh6TDc4TE8y?=
 =?utf-8?B?MVFUWUxlQU1DemVoOGp4TlJCNkZWYWlTMzErU29jR3FmbzNWZ0VaSHlwTDlk?=
 =?utf-8?Q?PcLUskkRN/n3mgcXiAjQCAPxN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: il+995vEw6efSIaEMFD1M9j155Gd31AuvROHM9WohzWq3Mg6z3J8cOi69oPJ15Je0dQ8lAojJX/X8UpCYcmw5RUz7N8X3kTIwkQG9Pci5W177Qv9hw8B8ONBWAUANAhNCfSCZ2Y1ZpOqVkH81vN/5+FoLkPqjlotey9EOyBh0j+f1Afm0C+FiIDnpOn0HHd0dfG+0l1fSh9KoALbRu1LSyT9Zw6LQ3RN0V0zJk5yD0mJC6qfCeg9PMdi9VQcBaH4X+7NpWnfZfhJWlCcMgNs4a6E+dAtyHS/df3MZVAZ4zeL2vtKm5yPyH8GSP/5RrSqX3jxIoIS+ip+JZOAWqDX8Q0NjM37aYy2eUOF08f8CNxRboAnF1mBSYFFRy1HCYFdL62mg78s3ar8zpe/b64qCZb70zFziBGikEgsK3Kum2zjkysdbTNnLemflnfD1wkh/Ztt3KOvuBEq64ACvc+NKmr7HrP0pqqiNrxr0C+x6dLMjSIJaB85+HEnW3h555/tGzBOCf/Rbwh7S0TXo8/7+W5Oapb0Hq5m0swzjZMJ3as9dAGlX5uPyMDempsQtQzd8niWHpUBhbyfHOHsOnMia9e/gUa8Qvq5DdMMbGufz1V2F24fOIfdgpXgJO1jfInfATaq85HuP2PFb5vwa+vyz9FHenFX1hIzUzkI0LWoT5cVH3ncJpzuxWd7/tnul+ucB9r1XKtijHW1+sx/8OHbPAxYyU6FdqFqWl5dmLZ0zzB1WE2awC+4Ok1z0IPW2s7i8ncAulGLAfhJtaAQx19NebmNIpiXrBxBY679ZfXaMtM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f74a7a-bc49-49f5-97e2-08db873b23b8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:00:27.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7CRtprhZLIqMSgUXRdu/XtjhB1IAcTxKpAGnlqULrOaVatjHTaOMVI5ygTePZj+1PX04+RudCkrGLVaYDXSbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=710
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180026
X-Proofpoint-GUID: vZgs3RfxNZhbroThsue8jYSWLRtA8R9I
X-Proofpoint-ORIG-GUID: vZgs3RfxNZhbroThsue8jYSWLRtA8R9I
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/07/2023 05:28, David Sterba wrote:
> On Thu, Jul 13, 2023 at 08:41:01PM +0200, David Sterba wrote:
>> On Wed, Jun 28, 2023 at 07:56:08PM +0800, Anand Jain wrote:
>>> +bool array_append(char **dest, char *src, int *cnt)
>>> +{
>>> +	char *this_tok = strtok(src, ",");
>>> +	int ret_cnt = *cnt;
>>> +
>>> +	while(this_tok != NULL) {
>>> +		ret_cnt++;
>>> +		dest = realloc(dest, sizeof(char *) * ret_cnt);
>>> +		if (!dest)
>>> +			return false;
>>> +
>>> +		dest[ret_cnt - 1] = strdup(this_tok);
>>> +		*cnt = ret_cnt;
>>> +
>>> +		this_tok = strtok(NULL, ",");
>>> +	}
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +void free_array(char **prt, int cnt)
>>> +{
>>> +	if (!prt)
>>> +		return;
>>> +
>>> +	for (int i = 0; i < cnt; i++)
>>> +		free(prt[i]);
>>> +
>>> +	free(prt);
>>> +}
>>
>> Looks like this is an extensible pointer array, we could use that in
>> more places where there are repeated parameters and we need to track all
>> the values (not just the last one).
>>
>> Then this should be in a structure and the usage side will do only
>> something like ptr_array_append(&array, newvalue), and not that all
>> places will have to track the base double pointer, count and has to
>> handle allocation failures. This should be wrapped into an API.
> 
> I did a quick search for reallocs, that usually mean there's an
> extensible array and there are too many, so I get you wanted add one more
> and be done. But now it looks like a proper structure should be used.
> I'll try to implement something.


Yes, indeed, this has to be an API. I thought it could be done separately.

Thanks.

