Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199CD7870F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Aug 2023 15:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbjHXNzI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 09:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241369AbjHXNyr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 09:54:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B64519BC
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 06:54:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OAsvFv017379;
        Thu, 24 Aug 2023 13:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bKVgfJmBDl5CeHxdEOO8tonrEwgXZLCJDzsqTpklXvc=;
 b=zY/9kYLX6ofL+XFBATL/gkemxm0WD/K8RsIJ2YP1cVdWdKCeXCcywVm6mxSSqpXSq8sy
 vhHiVRY7W7f3mUfQM5eOe0y9JuBjHZdn0WBMBpU6WE7Ssewnwje2FUSqnkYXAeUAilQs
 Sg7cjJWuFirZDxPZQflKazp6w7fpiHeJXv1XcWrRFZ0auljSIdU0tCzE3JG4QXBlXB4B
 uvvJrgKrXzGZKg29AflNUPaIj82mYMwE3SG3QijSYxaNKus4LbT5eA4qRCeOCQ/LyV2Z
 iEAK5cH4j6sLJmLBmWPjT6xgHmBNQoumk5Ri0fTJkSZ2pyOgygXd3DHe/Lu6DP5afPbI xg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvv7xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 13:54:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ODShvJ036073;
        Thu, 24 Aug 2023 13:54:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yw0g3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 13:54:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXe8wK+VV+NH96VqWp8XqA7QmXohQPkFlIrBazs2JISqo6Xmkb5riiEpWwwY9Pntdpj3Hi/AN8AAa5ZJvKP4xwtZ4IspyIpJelGKUkfBb3Fk4IOpEyTOW3HR/4xszAiswrKSi1BELclJx/IEpX0tPu3rIvFI0dQmNa3RUY10iOvTdKM5Kjd0avYxxRulaRBRqp8+7D4Gbijod7ZjIFOS+pYeZmLb4LEMbz2JIotm1kIQnqFJ6wx2iS7EJE3SCQL8CvI4vFSs7QAdPsDcoWkidlhK3QSHoaHi5p6HKcewSCqKZzIkyBchsQOh7IwMHkv+bAvZpj8ds8WmwN2fp/3leA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKVgfJmBDl5CeHxdEOO8tonrEwgXZLCJDzsqTpklXvc=;
 b=aRFXeTVd5CCOROeCWVA8qJMVNo74HTukdJ0XoWuEqhG60QIQtyiYvTzto4Cv6N9FBwl7Ft2+wtpkFdzwzsLFiHcc1N9942/nauLiHQ/29E1Q1xD7oLXcDw6mLEMBHDy++CpCBKX3cG1STXUTEQgKmrlJ2KZ7WkGa/F2N+Mn0UQvLF/OZeYPWl5XUhr019qOtI9Aw7BBl8f3yloOJARKWoZlXV4bkWL9ILtqq262Uu8OHScF2/sWDAdUrDIynbMAcXP8/wat/5Ye03fUc/+kivyP/Fld/1djkSjt1NnV5HqOh5qKspNBXGLaMB0Pxd0iuz6sGJXBlTMpS/zpbVxZ53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKVgfJmBDl5CeHxdEOO8tonrEwgXZLCJDzsqTpklXvc=;
 b=jrOJwwVo/HsPpQBB5O4dyGSGbOGAiQvMe4yqJPkzpNLHz5mvN6stMkF7xNUHR/u8DBGdu4MlRC1vdrhRYLvAcCpLVjhtSHOyCOX1cZfJJqXGWMON/YRZp/k6NOGY3cztz1lFe0bm3L3RDlCankSWqZUNTt/j6tiyRIEu8duH78I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4578.namprd10.prod.outlook.com (2603:10b6:303:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 13:54:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.026; Thu, 24 Aug 2023
 13:54:38 +0000
Message-ID: <ee88691e-f484-58cd-4e48-50d2671e7e71@oracle.com>
Date:   Thu, 24 Aug 2023 21:54:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 00/16] btrfs-progs: recover from failed metadata_uuid
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1692018849.git.anand.jain@oracle.com>
 <20230823221315.GL2420@twin.jikos.cz> <20230823222434.GM2420@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230823222434.GM2420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: 844156dd-cca6-4cd7-f541-08dba4a9a84c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUoUepJvqtVvKPH8Bgg6r2YemafSy7GYrN4WdUu0rq/x7NCCqfk8hRLwfjbaGjXtVQPs/UhuzYwppyq6rCuRrcXkqvkyZdVf1BqbAi9w47/+/Vbt3gNmDIAIHa28fLlUWhM79UeL3yFeX8f03/HZ1eDU/MQXNP1MzrlxBi4rctwF7HhNNJOUwF2uZ4/zFgyHk6vZFbXCt5U1ehrK+EgokaVbvJcu5JZERDZOJn3DqEJDwAoaFUdB8xxNL78gNHYEmpxTdIfNJTKj6ScLzKyfdxCj/3DFG7O2H/Wt/w44toqrHnn9vcEgMaUU3MLdsM8+58ezar6RWnCqv4P/cNUBw8TMYpjy4OFmL63IInPEFJY8o7lS0ZFczrYxC87ar+Z7eneBASySLiyRsDeiFyiOpdDyiZYRiRuRDT2/SxC5JtPjJi3lD7adfzIb6aU2ah1dDipPLE1mz6QkieEJL19yt54Ro+sUGHM+5uF+lHyiTZI64GMnTZ7uB/Sfmzyyb0WGxKRQAC3w5mI+BZVWliBbQioXEQ85s/3VX8p5YAFbD5HKx0CYeoR9uKA+4/9VdRwBdup0Xe5kmYeaEo3lY4FQLPW33LoMguvvkB3QUpx2rnUnO+Bob4jJCtm2oNvMZ/unUgjsFBWCv+foB81VrOKXneWyzXMDbhAPzEnVcjbiq/eGjyyyksidCUl0yfq89L2L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199024)(186009)(1800799009)(66946007)(66476007)(66556008)(6916009)(316002)(478600001)(26005)(44832011)(6666004)(38100700002)(41300700001)(53546011)(86362001)(6486002)(31696002)(6512007)(2906002)(6506007)(966005)(31686004)(4326008)(8676002)(8936002)(2616005)(5660300002)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WklzQ250bXlzQUFDSWJ0ekJ1Q1BrR1lkelBwbmhadHN6QVU3SzBJTnpwRUs4?=
 =?utf-8?B?eHBCSm1mQURRZUZrSWpVQXVaZ0VIeitOM2Z3Y0p6clBiRnB3c1N1bXBMV29U?=
 =?utf-8?B?bEc2YlJpMmdTMmJOWEE3cXJOUHZSeEp1bndNdkZNTzhvOGl0K0NZMEF3MHc4?=
 =?utf-8?B?L3JaNTJBT0NFeEVacmppNUtZTkFURjdGZDd4NmJlNXBlNjkvNytqeXZQaVNn?=
 =?utf-8?B?dlFGay82NFpOQ2svSzhwZitZQXp6RUt0YXp1aW9KVE43MHdQeHRCa0Jac1lk?=
 =?utf-8?B?NGFBUHlqK3J0RjVkT2NQWTBSOG5XdCtIMjdKNnRCbVZqRnVxYllhbm40MHFT?=
 =?utf-8?B?WThDMXhQb2VCbUJTckhvN3hoQnh2QkVQUC9ubnpVa2J3UThYNmpOQVl1SVR1?=
 =?utf-8?B?amR1RWpuN3lFSXY3ZS9Xd3h5SlBYMEVacFNCZnlMdm8yMFEwTlkvdXY1OW03?=
 =?utf-8?B?MXU4b3h5TDRlb3ZKRENzS3RtYklidFNMbFZ3cUhrWG5IZUtKM0JsdEk5eVp0?=
 =?utf-8?B?cUlBa1AyV1dEWGo2d2I1NEZjVlhzWFRBakJiMFZGeS9iT3JyeU1KUHhxNFhY?=
 =?utf-8?B?S2RGUjk2eFRMbTd5SVR3c1Fab1ZMS1hYMHFLQ2NsYTBRYmQ5a28yTmZPU29j?=
 =?utf-8?B?R0hqbWh6MEdOQUFsbHJFSUpQWjIwY1kxcllpaTlBM0ozYVVOK1ZWM3p1ZUdN?=
 =?utf-8?B?M0s0N3JuNGxpZng1dnp2V2lxZzc3OFFYcGhuZlN3Rk1VY0owek9sek5KTkRD?=
 =?utf-8?B?ZlE0M25WOGR1cFRPencvNFRob25BZk1PUkt4dUZvcm1QSHRidzU0VnpjOFBi?=
 =?utf-8?B?TWdjQmdlOFRlTHlQaU5COUdwTmUxbnZDT1Jybzh5VGJUS0htQ2FzTldmai9C?=
 =?utf-8?B?MDlCaE53d25xQTlrTUo1SElPbS9FTjBwT0VQcVhEcnI3cExIdUgwNXlNeDlP?=
 =?utf-8?B?azJ5UjNKVXlPZGNWd0pxRU91WTQ1dk4yMDd3bjAxR3JtQ3NWaEs4dm5kOWhM?=
 =?utf-8?B?clk2VnFXRVI5TDBkeDIxbzIxS3RVT2hKU2hqSnQ1aS9TUEEyR0sxOVVobWJZ?=
 =?utf-8?B?WVpIVWkvRTdXQnlBd3lGTE91enl4S1FyRVlaNzVtODlvOTZjVjdXVUVZa1ZE?=
 =?utf-8?B?SnlraTJuTlhvUUhhcTcwUGx5YTNoWGdjcnZRMjFZVm90TXVkaldSK2x2YTJl?=
 =?utf-8?B?eVBPNTVRVWFxUmd1Y2pSMUtxa1pFd0xOcE1Mejk0TnV3N0pWc0JOT0tCZWtO?=
 =?utf-8?B?cE9Tb0pJajN2SDFjQmF3MWxRNlM0dnVRR04xWExvTVBaeisxSHFYcHpxMFVW?=
 =?utf-8?B?QzFmYXNqNmpMQnlBV0NQSXY4L0dHTCtNaExRcFN4amY0R0drL09oRDk4bzdk?=
 =?utf-8?B?ZEdFK2MrK0hTeUVJTUc0dFR4MSs2VXpqdFpLMjIvZmgrNkNmV0hXLy91Z0dQ?=
 =?utf-8?B?L2loRjRTbklseE5QUHVpd2dNNm9HMDd6VlNQK2JlOTVvdi9HNHdoSi84eS8v?=
 =?utf-8?B?U0NTOUpPZFJRQmV0ZjQyZ2FqQzhtMGZIaVlxNDVCYUtjT0VvRFlBYWZuUzBI?=
 =?utf-8?B?bGZGekVsdElWclZLUkgrdlE4blZobE5rQ0pKSzh0ZzVWWmZuQ0R1TnY4bzNv?=
 =?utf-8?B?cGIxb05YOFVYVDNOYWRZc0F1Z2xTQzBlWnhpQlNoTDBDMStxeEpzUWZ0MXhZ?=
 =?utf-8?B?YWNKc2NyOWlSR1dBazJYNk1ONVpQeWZxMmJLOHpvK0dCS0VEVjBtbTZGS2w1?=
 =?utf-8?B?RDQ4YUpuOXBKeWY2TU0xSVJrWjUweFpPUCtzbGYvUmdNRUVjL2RjVWJWS3cw?=
 =?utf-8?B?MUtZUDFNek1iMXdIUVRmbnNpQmFTVkw2RmZud3JVaWFVUXJkUnc4clFYSDBm?=
 =?utf-8?B?eW5ZY2ErZ05SN2h5aGh0NlJLYVFhY055cnlPRndZa3J0Y3VzTTNQNnZEeElC?=
 =?utf-8?B?ZG04ZGs2bHFMQTdqKzcxd0o0NEEwcG80bTZIUklQSmN5cW1pVHFnWHV0dUdD?=
 =?utf-8?B?NDlQUUxKaVBmdUFudUlwOVZldXIvQ0pDWXc5STh4MTRIcXFaV1ZWMUlRZHFL?=
 =?utf-8?B?cG9jSjJrM01DSHMyY2toajhLS1RSeFJEWnRPRkVKQVBjRnRSTXVnclE1Z2Nh?=
 =?utf-8?B?b0E1d3JMdC95VDJ5cHRxYVBRWHo1bTcweWxlUEdHRmM3UCtmS0pJeUZRRU1I?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MRxoo7Y1by5qYGUZwocMBp7o9dJY6pcGqJKuWCw+DMDz5uk9bxD4zLpu5yqQr/X8NsyIAA4W3YQ/VEavDhviZWfZZuWDrwojALsDGhD8/3crCrkl3zwEZaPO0NCEtYBFVIWEMhN8LfqJdrWT7nvSEGCMxP1G/jI+GBoGRDw46C16Zt8WzOwBmiszdA0E8CFVDWxcmQbXhrsLpdHdx9Oq6ftS7+nE48CrnQmi9L25e9vej4Rusy3SlYlB5Hx/kBJr0yRONKbF1LU52el4YBFGBfNMY4HL3CVdjOmf9FEjFQHsrfLzXGVUBm5iGQOIbSrR+2C5gPglnhbhj6xNPvMmIANUCGodrpE3LdLiLAEjOi4e+CTJOL+61/7H0FtxER2/zt0jrlSNpx2AQJ6EUbO5N44vD66IAIOImLqzLwkVdfc6uXJ3ycqADyFHGH33JyiodNvNo+kjgtQM9leESc4Tc8bq4AjfcUhT/SL5WSFG+1veVGJME919cg6hE7b/eNfVHnDivGVz4YNhnRPpS9n63ePylXv0II9oD8iuySujQ7fvvNUm4VI7jtN0Rfm9Tq4wm7Hs+tdEd49jJip/8SGw5VB/YubxHNLgYf3//NjGGsaqobVEnsKJcDZ4jm1T0fNTBbndnTyi9it6kYlJgbDxUeZ40wpvkzJjC1FdpqMUcvzE7i7xoz1x7ijz2+/ubG4x6WKOUWRH04TVVmcd0LXyC7DP/GmY2MWMVYqljyl4qdyEmLzUwdIIttT1ydiIzdHcWW/hrX6qMyXGKwn2VvlMyNGCVtVUzhEXxFYP9FQMv7M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844156dd-cca6-4cd7-f541-08dba4a9a84c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:54:38.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2EdweElXQnd3kcelNkV16FprQ5VzwProOHcWYFEzXdsXLbwcCF6isbJOyDLSUutvCx6mY3JSg0ILAlIqQPUhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_10,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240116
X-Proofpoint-GUID: 2p366DlX0Asy9Fc8T3iiXZIMULEoSKus
X-Proofpoint-ORIG-GUID: 2p366DlX0Asy9Fc8T3iiXZIMULEoSKus
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24/08/2023 06:24, David Sterba wrote:
> On Thu, Aug 24, 2023 at 12:13:15AM +0200, David Sterba wrote:
>> On Mon, Aug 14, 2023 at 11:27:56PM +0800, Anand Jain wrote:
>>> The kernel reunites split-brained devices after a failed `btrfstune -m|M`
>>> operation. We can achieve the same in btrfs-progs. So port it here.
>>> Ref the discussion here:
>>>
>>>     https://lore.kernel.org/all/1fa6802b-5812-14a8-3fc8-5da54bb5f79d@oracle.com/
>>>
>>> Patch 1/16 wasn't integrated as part of the set
>>> 	[PATCH 00/10 v2] fixes and preparatory related to metadata_uuid
>>> it's now merged with this patchset.
>>>
>>> Patches [2-6,11,12] are cleanup patches.
>>>
>>> Patches [7,8,10] are preparatory.
>>>
>>> Patch [9] addresses a bug.
>>>
>>> Patches [13, 14, 15] provide recovery from previously failed
>>> `btrfstune -m|M` operations.
>>>
>>> Patch [16] enhances the misc-test `034-metadata-uuid` to also validate this
>>> new recovery feature.
>>>
>>> This set has been successfully tested with the btrfs-progs testsuite.
>>>
>>> This patchset is on top the latest devel last commit:
>>>   8aba9b0052b6 btrfs-progs: btrfstune: consolidate error handling in main()
>>>
>>>
>>> Anand Jain (16):
>>>    btrfs-progs: track num_devices per fs_devices
>>>    btrfs-progs: tune can use local fs_info variable
>>>    btrfs-progs: rename set_metadata_uuid arg to new_fsid_str
>>>    btrfs-progs: rename set_metadata_uuid new_fsid to fsid
>>>    btrfs-progs: rename set_metadata_uuid new_uuid to new_fsid
>>>    btrfs-progs: rename set_metadata_uuid uuid_changed to fsid_changed
>>>    btrfs-progs: pass fsid in check_unfinished_fsid_change arg2
>>>    btrfs-progs: pass metadata_uuid in check_unfinished_fsid_change arg3
>>>    btrfs-progs: fix return without flag reset commit in tune
>>>    btrfs-progs: preparing the latest device's superblock for commit
>>>    btrfs-progs: rename fs_devices::list to match the kernel
>>>    btrfs-progs: rename fs_devices::latest_trans to match the kernel
>>>    btrfs-progs: tune use the latest bdev in fs_devices for super_copy
>>>    btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
>>>    btrfs-progs: recover from the failed btrfstune -m|M
>>>    btrfs-progs: test btrfstune -m|M ability to fix previous failures
>>
>> Patches added to devel, thanks.
> 
> On my machine the metadata uuid test does not run because the module is
> not loadable, but the GH actions report a failure:
> https://github.com/kdave/btrfs-progs/actions/runs/5956097489/job/1615613826

Local VM successfully runs misc-tests/034*. However, on OCI, the same
error as GH. Error reports missing device. It appears, inconsistent
results due to the varying device scan order from system to system.
I am looking more.

