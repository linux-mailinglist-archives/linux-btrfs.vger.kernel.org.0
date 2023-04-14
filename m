Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5E56E1B85
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Apr 2023 07:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDNFNn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Apr 2023 01:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjDNFNh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Apr 2023 01:13:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CF3B4
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 22:13:36 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E23wmb015070;
        Fri, 14 Apr 2023 05:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SiCUDfsorRpfSEqyMocREFG/LI9QwgA0Hz5hiaFnzWk=;
 b=GxHZmIzeWRpvubGONAKjOH4M8TPri8MrgbnvaxGEdWzXRbK/3y5A31Dx/NMs1PH/Rtg9
 WoXAJL7eqB0Wd0GfcPPIZ0mKy1Dvc/cBYrct7Z7tWrMND2wnPHptQJK08SmaWsAgTcN7
 VF4rx1LaIbhAMDLNUJLU1aSGNC+03TZq0XZFL3zr0x+v2ZtMNKvK1SC/Kgq82wx/jyQY
 kN6nsRgj69lgJJoV6sLiqCDXzx9CxEKTwMV5EQ3gaz8fL99hpRUI8JaUOWXP4qW9CLCT
 vhniJFXHiiSX2RbcYsOTmBFiOym6g6cDfuohw96Ogp9fcPTR6bUjjwxD1QuDY3YM1eFu jg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0b356xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 05:13:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33E4F3X3012959;
        Fri, 14 Apr 2023 05:13:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pwwgs116w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 05:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKLF+lbPebT8og8KxNAFfoibzwBDZ0KC3Zfyi6xiHqc6Kqlq3ShacGKSqwvziWuY/u3h6kYnW/VXSaAGV4u8yL7wSMkzpdkjLe8U8F1KI4AfxTrj11hS+pEzACaqV5Y9qB9+Rhdhim1TLl3OdxMm2dcgzgcPShbHytHXrL5M7sDg8ozJKp+2C7LfYqmfnG1grQVRUX1G2ladsuvPCFuHpFTqXdQAmTdsZilA3YSlduNLSxDbZVPrBzR3R2QbMKx2rP1mLOSNEO2JzwFe+bi4A88a/5M1EZqTU3Druoj6pJQbXIJAkFparo7a5QfFSjHti6h/QqLl56QJ4rl3twNnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiCUDfsorRpfSEqyMocREFG/LI9QwgA0Hz5hiaFnzWk=;
 b=jlmlg3jQ63CjiVFIdxB1amplBw8inHUKaFD9xyS3AcbFyLg5uaIG0Eu/OnPG2bKegW82uXdLn+NchwByTFXBUuA3zWtNu8OZTrEJ0qIpnoHifhke3PWsKxrkAIAPSpxJ488k3AmwJLBmY+2w6uCneyWK0aCxNRQXCUWSlbWFg/hYPZqXo+PPqTKsFmhlAfNZ7NJWlpYCCu7Bc4QGEZkX5uZayp9iJr1jcIs7pL5Jo9HDj2prWcGR5Aa2rHEy952QPpmVeBGviZXB/+TiKDX7ILtEVMOppo2PEtjcpqxzGJnZqo03GsVmXLr3vM9MpO7E9RGo9Bq9iki6akxddZ9z5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiCUDfsorRpfSEqyMocREFG/LI9QwgA0Hz5hiaFnzWk=;
 b=ZYurlaD4UpRvSQg7vfqqImxbiB72PjnWjQ9ZVnv9HHsdc+bamwVmvVWQNXexh2J7ZWOObm2keZ11Et6OEjKP/7RkwV2iH50/GeMpKSTcVvCNurjrth4mUnRyvrV1slRRfdnsyFJPJN3GiIuczB7uRK1QCTyj87YhPJreoWgpUnI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 05:13:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%6]) with mapi id 15.20.6277.038; Fri, 14 Apr 2023
 05:13:28 +0000
Message-ID: <f4b1eeb9-c81c-4a91-5b47-4512c7e7bad5@oracle.com>
Date:   Fri, 14 Apr 2023 13:07:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] btrfs-progs: mkfs: make -R|--runtime-features option
 deprecated
To:     dsterba@suse.cz
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1681180159.git.wqu@suse.com>
 <1ca85433fb63d9c9cf66da72e407381c0146b76c.1681180159.git.wqu@suse.com>
 <4a280a4c-5c84-8ecc-5dc3-4258ecb6eaf5@oracle.com>
 <20230413163245.GH19619@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230413163245.GH19619@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: 9772d3bd-a5f7-4420-5e00-08db3ca6faf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4dxr0k8V7Tcbr7Tf4mZqqsO3BfpXiw0gJk+SO/p97JjzuPiFfMMRIqLxcPqWvk97B+Wq4K23ni6t8LyB8tN4ppB1p/vVdb+iBivuDOtMzptMZJvosfB8SpYld047MdUc5ZoNUtc1NrnmBO3N6Ohn2FNn859PUGsShxKE1tvsbSs1CQ8qRj0OmRQ+9eSgH9PEy5DNKjCcl2lzkgQD2WClc+fR159KJWHWbF18oHihQxn5Dz1Kd6H2HnmwNsHCJBN+o/gdIvx5VrUjKQ1WmDPgDw7gxtVbRaAsifNODZhLAB0wqbAFAOnsoe/D8GpEyRdfWOiIXavWaiY52gDIxL/MLrWcyLikpLAnwYo3XTfDcmVmt+CDOGPaaPuRu5jSqC7De3T/rdlze2mp98DyMKMhCSwLWjK3O77azpyEPL3Tqxcq62Oe2V7d3275aHT5hUAAhW/jYswnQDLijMi5ZtbnMWFNrkUk22Y096KZ9FD92Q98D1EeE8dbimyaXbzIb7NYHpFSO+MHeB8FeWCHL1aJQHgo7bDVY5/SQcBgZVF4dQ1jLOwVxnPWnyGkORKdzUSQuszQ0cdSHcCnML3T1N+fU0XpKyXfHanF+Bm512cSclRBnfAnet98NOLrmSmJl/2xa9SVCv4jR3dGUdSele8SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(6916009)(4326008)(316002)(41300700001)(6512007)(38100700002)(6486002)(53546011)(86362001)(6666004)(186003)(6506007)(2616005)(83380400001)(66946007)(66476007)(66556008)(31696002)(36756003)(2906002)(44832011)(5660300002)(8936002)(8676002)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjZoWGJNU3FQc1ZzeklPKzRTQ0I2ZXZaa1hUVmVTMlRWTGo3ckl3aEppblR4?=
 =?utf-8?B?b2hBeG0xdWw0VjBOYWg0Y1FDVUdUaUxVRkdzcWJ6ZjJ2bVVCN3NyaWNkTjJD?=
 =?utf-8?B?MFdrZVliTUNwQklhbi9ZUTNHY2Yzc2ZBZVVJYjhjTWVsTWdhOHdITkM2dVRO?=
 =?utf-8?B?cXlxb0RQQThkdUhuMFk5eCtld3lWTkF5YmR5MENvV3R0eEdmeE1TMjBHQVc2?=
 =?utf-8?B?MzdLUWxZOFhoNjlwUks1cHBSaFJISGwwYUZqQlRtL2ZZMVNldnhXKzJ5T2Rj?=
 =?utf-8?B?Q0JkdEVtcnZicHJ5WVZJNE55blZ4VlJwcS92OGlqenNoVHptaG82M2xNLzhX?=
 =?utf-8?B?MC9pT3JIZmlCUTFsbzFGN0J0NFozVnZlL2pMK1oxMFlKYmhidDdMK1NKdnZq?=
 =?utf-8?B?eE1EUlRkcS8ySzRhby9WTDFmcTEwaUpJTEZZdDhXdVpWS3poY2hVaEU1amxM?=
 =?utf-8?B?eTdUMjVYazUwSGFFbG5WK3Vkek5LaFZHbjROekR3aEZaSSs4c2NxeFhlMWQz?=
 =?utf-8?B?WDNlNWZtL3A2ZTU2eFllZE5CV1h5QmsyMmJCNitWdGZiYkk5a3ZVUHA4aTdY?=
 =?utf-8?B?WkN3aDBvQnRkazF6ZUNUU3E5Wm1MSXovSW9iQSsraXZRM1lnYTEweXdLZ0pw?=
 =?utf-8?B?dnpqNUVMQjFSNFAwU3MxU0srazFORlgrUFZnTmRZY2Fmd2x5azZGZm1WV2RC?=
 =?utf-8?B?ajBPNXJDMmV2dExUV3VRdlA1Y3dETnJaYWQxWUNxUFVvbi8zaitmbGtNQlo2?=
 =?utf-8?B?bld0bUYvMkZpd2YyTWZQMkNNbUxpak9OV3hldThMWjg1ditZWlA0Z3VSTXRy?=
 =?utf-8?B?RU9FVk9YTjBSbTE2Vm1yMjR5bzBpVzQ5SFprc0V5eWg0amYrRGlRcS9jaUgr?=
 =?utf-8?B?bTZvZGJTb284ck9ITUc5MkdvOGR2VTZOOXhGNUdtMGRHRXlPTUlPUmx6OU5r?=
 =?utf-8?B?RVNOcGVON3pKcmdvMVVnWEhOMzN5OTZEZzNwSEhUUldVUkg0ZTNrcFV4aTZn?=
 =?utf-8?B?aXZnT29XaU51UVlBa2lXZ0pXbnp2dmUyZ0VQbHA5K00yYTRwTHJwYk05YVBq?=
 =?utf-8?B?b3NGVUk0NHc1ZDNRVHJ4TGJkUkMyelFSUGc4YVJVam1MaEttbmtkUXBMTEJ0?=
 =?utf-8?B?a2F1WXFWNGNlcnE0aEs0OXRTRVBNVFkwY2FWYUtBZUc2cGNJZnFKMHJMNy9a?=
 =?utf-8?B?STdyUzdCakNTY21PbndOY1FqSTNLVDl4QWxNTXRDVHVVMnlQeGZRandDb25V?=
 =?utf-8?B?M0IxcjFJc05ZeEZVVXlIUFMxM3RUWHJkVlp5SzZQRWo2VjFiRldTRk4xRXBO?=
 =?utf-8?B?QjRSaStTQzBJV2hKRWNIUWRuaDlQc2dmbUxQckY3MnlxMlpJNTVBeXVIRGwy?=
 =?utf-8?B?SlNQdXFPZlJTRG5RdGFUaVFxS3oxVFRkUElwZDFaOTExTGRTeUl1MU9rTmU5?=
 =?utf-8?B?OHMycDFuNWFmRmMvczBwSTlFQ3pOU1dBandzZmx0ODhZQlN3Q2toRWNISTRB?=
 =?utf-8?B?MTlwc1FlTVpoQzhOMlBCQlBPelFkbStFSk1IUHBTdDFqTzdTN0pyR0tsa1hU?=
 =?utf-8?B?Y0ZVS0J5NE5tODR5akVkaGRtMW0xVXhIRmJkNW0zMFlJZEhacGVXMk1uNHRE?=
 =?utf-8?B?c3BLdzRHNTNWVmhCdDFOMmFCNWNSMDlucFVaMVkxU0VJU2lzSVVrdW5mdFYy?=
 =?utf-8?B?b3l0bWQxeFpJYlBjT2NORXNBMnorWjRqSXgwcVErWFRBOGV3b0paOVFKNW5v?=
 =?utf-8?B?SkFEUVA0RW05N0VaRUVQSHdXSUlPOTgwRGhTck5vN3RLRE9jZHJTS0MyR2NU?=
 =?utf-8?B?QWhHRmFhd1M0Z0NIaXp1MWhvdE51SktmNkR3ZzVRbllHbEVtNlpBMDFGQ1VZ?=
 =?utf-8?B?bzdhbHltNzVmd2t5NXo1UjYyYitIQXc2R015c1NwSUN3NlpYTDNacHFOWlNt?=
 =?utf-8?B?QWZSZ2tZWjBaWDJrVU9WQmV3UmRjWW9IaXgwNnp4MkNJSmU4ZmdJUmg4cjNN?=
 =?utf-8?B?cWtuQldncVpadE9zMU1OM2hKYWhMTXNJWXZMZ2FUZ2dRQkoyZ1czT25yT1Rv?=
 =?utf-8?B?WjQyK3F5VDlpQ09PQ0Y5MG9PMk8yTEhTNGI3SFRoV2hLWDlhUXdhZzRISzhi?=
 =?utf-8?B?QUx4VnZteVBzS2ZnUmZEZWFxWVc1TFgyWHRWVWdidkhabXZQaUZ3aEdGR1lF?=
 =?utf-8?Q?eQziuhJRHNe/3Q5HYfuJZ945uzI7AsxNiJRIyII7Zx+t?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EiPrdVgCy04ot4ufIpndoEPZBDhb4u7WtKAK9fjgn6OptMb60av+mwqGuf654/VldQMzyC+6pNoFlkquSVse70as1T9U3W9UVmIEReiOSKRKLX6O6eXuRqD8Gep+mGXDw3XpdcqsqyW8SrVze2Og5PTxND7XX8DiA+NxJPBpaZzkcjj0bxapFNuEemsTxPLYQdPjm/3rED/zUNv/E9sR7Hd5RFjKNMmpP1nzTcM1PEOGsptQ3bGSc7dw+EK1f6CHCVnNiA3LCr9WSONIk1CK2VFD6ZugxbORluY4ydC5s9OnrAbuxlw1PLr8kECyjvrR4GSVyMYiq+Hk8eb867XA6lEyJ4v/GOM8p8/AuOtRDQnG76T46trs6MJriGmFdwBu9VfO9p13D6Q3i3gE61W+kjuPbUq2lFnVz8/6rR1UAAHdFyaRQjEKp5JiuReeoMRGcudAiZ0MKsl3WUhr5IyxNa8udjy3fzW9wuPhpLFpHBgK5EdTSc6SKbZRDl/L/Dwl+Xskf0kB+RJFKQtdr5Mf5HWEC0nc+o/bDVVaDQbjRekGk+xjrk9U4zrDom/gTJUY0nlckT0YsD+VoJFbyqoLhe9MjAEBby0ibhpjNYKVbr/USwTSsSwpvBWN55/5fuPEspL2FJ31quiTjrgV0r/Dvdm4qPoUyeJr1lGmDGGG7O8vdWUY+lurdkTZRw3h7k+9pvDXS4dbJ2TTj1YVFKdxtCedmC9PtNnZDmFmGXFjrm4HRWffePVVdB6K1YG/w6Sw7TIiFf+ty/Od031NJpVSawCRbHp5OuX+1um9wk2IHTtMnjWs1jTZXSQL+B2KbOtt
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9772d3bd-a5f7-4420-5e00-08db3ca6faf1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 05:13:27.9635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vU3iZergLs0oZ896KmX4+Mr2cTFQ4o32ThUF4aXN6lm78SYuC8//DX2NLT+1iqtNbCAOqCFLcdRDVMdZ6cKfCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_02,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140047
X-Proofpoint-GUID: oFEB-04RRBKdGbMF_GBH2B1DC1aTyHPM
X-Proofpoint-ORIG-GUID: oFEB-04RRBKdGbMF_GBH2B1DC1aTyHPM
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14/4/23 00:32, David Sterba wrote:
> On Thu, Apr 13, 2023 at 05:34:31PM +0530, Anand Jain wrote:
>> On 4/11/23 08:01, Qu Wenruo wrote:
>>> deprecated.
>>>
>>> For now we still keep the old option as for compatibility purposes.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>    Documentation/mkfs.btrfs.rst | 25 ++++---------------------
>>>    common/fsfeatures.c          |  6 ------
>>>    mkfs/main.c                  |  3 ++-
>>>    3 files changed, 6 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
>>> index ba7227b31f72..e80f4c5c83ee 100644
>>> --- a/Documentation/mkfs.btrfs.rst
>>> +++ b/Documentation/mkfs.btrfs.rst
>>> @@ -161,18 +161,6 @@ OPTIONS
>>>    
>>>                    $ mkfs.btrfs -O list-all
>>>    
>>> --R|--runtime-features <feature1>[,<feature2>...]
>>> -        A list of features that be can enabled at mkfs time,
>>
>>
>>> otherwise would have
>>> -        to be turned on on a mounted filesystem.
>>
>>    --R option is useful, why not consider rename?
> 
> For what use case is it useful? The reason it's getting dropped is
> because from user perspective it's not that important what kind of
> feature is it and it gets enabled from one place. It was my idea to have
> two options because other mkfs utilities have that, but with a different
> semantics than mkfs-time/mount-time, rather per object type (inode,
> journal, ...), and it turned out to be wrong.
> 
>> Such as:
>>    --mount-with
> 
> In the context of mkfs I'd find such option very confusing especially
> when there's no mount option like that.

Okay.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


