Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAF368B60E
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 08:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBFHHe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 02:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBFHHd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 02:07:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1414012590
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 23:07:30 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 315NIM1q028286;
        Mon, 6 Feb 2023 07:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OrRb1QH/0Sgho9RkhSqf89d7Cq425Da4qOVJVghlGic=;
 b=PueXV25ISy7HwMy93ZwMaxelTMmFrS4RAa8NLq/mZ9+crweqGUSaiuiSXGGh7+rtAqUw
 +gRCMThK5fOiTuQTuQEhfmloHwq3JuWUhDqhu37K3LIDSLTLpCzbErwXB/hTuL1suVbu
 6JUJk00erb6UdEAdRgVSelj50WAc/khe8EoF7+uRsuSqE3RmEkiYEeaPB5DRA8lwSMzW
 HClNMXDyrFTIjq4dEIdzJqClcGkv/VpB2ug0HeTrJyrbVh1ByKTMwgvKLzRAZ/DTyuHS
 XSqgsR1lXo4ra+fsrb2TgJ4likgbXIAScD7yV+dCHYiWtYKF0aL22qEVQ02viE2r76A9 /Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfdca67t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 07:07:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3166Ebxt021023;
        Mon, 6 Feb 2023 07:07:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt3pbd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 07:07:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VraZNM6Y6UtIFPd3GfHQ4oJ+bhlGu/sY3yX4sgCfkEPrzkNYT7q9JvKHCPODhf+tnJEcjHmHbBPBK/Ina0Zis0fblgCgM8RFy/Qajs7VzxdR/qPp6GvoN+j3l07zspgIjS6tcfp7dxWDLuRHGVnJX0qystdPKlFHfVMi8QF1AOQDxOcSlMQmRQh7h02sNlKqXh41Q3xjAAc/tufjEnvH41460J9IU+oBUWgXwpvaTm2JHjhoXB2gKgcMwEQzrkyYjiECF1EFnXPFY1VEaXxwHcTcU8d96jRVufkQkxqrX1tXWsGq4f5Vy52t9nSF69LfMs/J49KfK+pr2ms8rXBzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrRb1QH/0Sgho9RkhSqf89d7Cq425Da4qOVJVghlGic=;
 b=cYGbcUSlHNLF6E0ljPj4u+oO05Oza9vnKyIr1Zuez/Xt3ceblN/9w7R0OU4xQX7DuQcLOfdhLOGWTqnzb8lsIhfu97I5D20idgGKgzhTv0QSVYmuzD3uVh5l3v8Q+/db+IjTSujVQliu1DMWcKCs50C6GwFNmOBp7bXZ2YF0gdJ12Mq/DvlTfsNzz99kJRkoQpdyH33uSF9dsMrfbHUzin8GHwUpSnvdkg21MU1s5zuO2+6dfWOdNsDBkLvPfJsCLHwwwWUesVpDUXFXqBvtSe6fnWBHhr/1NG/ddyevbVDl54aLeZaof5nrfZXbOrochj1H+rbVKjCDTUxIzuDCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrRb1QH/0Sgho9RkhSqf89d7Cq425Da4qOVJVghlGic=;
 b=OjWIclp2wKJ7iFaUm5tgVRPoYreKoI0pTZrGOAW8GMVXaVYKxR+bG3KGWAFD3+WWSTu4LyJxQ8OAgf0Gow6YRxn2Ka/flIxp2McuVMSGXsWzCdE7xglGlqzyqkKppz1W9wLWCOqFDuOpO6uR8HBSDczewNuoG0ldNz6tTnkS4c4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.9; Mon, 6 Feb
 2023 07:07:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6086.011; Mon, 6 Feb 2023
 07:07:24 +0000
Message-ID: <55ac5e49-0b8e-977a-150d-9b9ccac614be@oracle.com>
Date:   Mon, 6 Feb 2023 15:07:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v2 2/2] btrfs: reduce div64 calls by limiting the number
 of stripes of a chunk to u32
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1675645730.git.wqu@suse.com>
 <5392f2206e7431647a442a7f87fc1af5fbb47570.1675645730.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5392f2206e7431647a442a7f87fc1af5fbb47570.1675645730.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a239fa-9736-4414-dc85-08db0810cc60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afC1zp+V3JsCx4iYedNO33yt/C/WqlrMyI3QbsCM57mwe+OvddRMGjTJPLIMpAUbmd8AI7Ew93FASVsU7Air3PaKGqjxn6vKzpq5VmBJRfj7/rQJM1OejceaZFiFSWbBRNeeZOvvqLCwHvV4H5YC23qijFUxpBlHqe3aTMBstdzn9jzjUTaAb0B1ylivUoE8oCWLQ7olz4iFkJMzgKQTSdBEC8zMK433Vda2hoO67xwrwJ4Pu/621vFGyvNm+vfb9Jmbfo5g6ZukbaT5LqqWFTH2th1mQBhkHT8xvVoAa0xaFK5JPpMHZEgU7Jkr88l3Gk0bvOvZX9w/rOzRdkW5FLcMdidFuhEVhWfIbJz8slx41LRVLF/X/xgbRNxQ9/1n6RIm/VgZ7fEaw7Ifc5pEEZrE19vvE3PTA1xP2iXIRqdiMY2s+l/sN2MG0gs6nViQ2m0wsuUiWAg8rf1wk6XJxjaUq4vjGYbs2S1U5MqTCQU9uYMe4aIF/7w6jD1J6j6sofPKWwo1J5q+rQTmp+6Q8eCAfXRzP/+s4lIq7nxtzdl6QCY460J1iD5PAXioZOGBbzF0SoxSav42mtohB92UlSfEX/scwKsIlvJMjwGJKnsTlKrOm2v6HzxNZoyCgsB3cLLF9L1kssFQiVv3iBndNkjP39riahGCeZvKW4hJ/womXKtc80G4RP2hGAm1yKQ97mvdqma68kVbizji4ugAnPsuaMqbMhXYdyfy7oUqrSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199018)(6512007)(26005)(186003)(2616005)(38100700002)(6506007)(53546011)(31686004)(6666004)(6486002)(478600001)(316002)(8936002)(36756003)(44832011)(2906002)(86362001)(5660300002)(31696002)(8676002)(41300700001)(30864003)(83380400001)(66556008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFozVUVCVnIxRW8rbEhHejdsNFdZU3pvRThPRTluNUhFdkhnc1NGRFdVSExS?=
 =?utf-8?B?RzdOc1Q3WDNTREV3SXozeVJ0TWdFVnVrY0JiZnMxbWV3aTJuOFdHTGsyUVRB?=
 =?utf-8?B?UU5qL09ETnZDNHl5UHd6elA2Yy84SkFvSVZpQVpjS3FKUnBxRVVESkhscWZl?=
 =?utf-8?B?czc5ck1tSzRZbXhxM2NGOHBlYWpaa3NaZXU0UkVxNXIvTUJySVpVU3I3VVVP?=
 =?utf-8?B?Q1ZDbkhaa1doRmdjZ0JNQ2VIdlAvRzZNejZjMzNaa2ViaTBaeTlxN3F0RXE0?=
 =?utf-8?B?RGxhY3kxV3I1TXd5TzBRZ0VkYUw4SEVyZm8rWjQ4OGs4azdhSG5ZK1c5VTUz?=
 =?utf-8?B?d0hpU3MwNTJKM0RNZFEzd1VjUzJxV01TTjZyallZRjNoUlFtemNKaDRncnV6?=
 =?utf-8?B?Z1ZEdlE1K1lHMTd0a1FEWjV4S2J0UXl5TFQ1dHh4T2lqRmR1ZUQvMjk0TEY0?=
 =?utf-8?B?L21ncTRXS2FPcXpWQWpWdlNzR0Fram5CdHg2dy9mYjZHOVcwSW11YllPc29P?=
 =?utf-8?B?VGZqSi9VS3dFNUoxdUlEQ1B2bXJkWE5BWnZXUStnSTZNMWZlNEMzNVpRcmdl?=
 =?utf-8?B?dFpqRmVlTDlrdU9PeUlxS0xGYnRVWlJGMGllQVR4OHMwbUZUb3lucU1vajJ0?=
 =?utf-8?B?TW0yUURVSHdtWFFtdmxTenc0YjZBR0JpeE9DU1NkQ3RENjd5eENac25mU2Vz?=
 =?utf-8?B?eVhCLytXZWRKOXNHcUNjam1yNUlpVVBBNlVDdnJCSi9ocTV5OEFERThteHhu?=
 =?utf-8?B?SFF4aXJqZGxaeGQxRUtzRFV6RU9ScWdtYlNlSG4rMklETGVaU0RDWFNBTlVP?=
 =?utf-8?B?anRLL0ZYcytjUHpFbGJQbW1KM3NNM09FVDRja1VqVVM4eVBRNTFoQ2t4YVZi?=
 =?utf-8?B?enl1bmJlV3RvaGt3Q2FZY1dVNFNiRy9jUEcvTHNROTk2SUQ4N0prZGZVeXlp?=
 =?utf-8?B?OE1sVmxicUxDK3ZoTy85bjM5NlQ1QUJablNaNDM4bDB4VjEzL3NqSkhGOHRP?=
 =?utf-8?B?bG5nbU02bFpSc1dTOXFkdEtPR01ZT05tL0Z6d1d5NTAxc0tCTGY5N2ZnQ3pt?=
 =?utf-8?B?ays3Q2ZVd1diVThNNW05QVpjcXhiY0UvSXg0aXA2QmN6LzVXdUNmTndSbUc5?=
 =?utf-8?B?aWJUUmRTOWhGZUJZeDBFZlFhK2syL3U5QWRiTk1HdEppb0owYUgrbGcrVDMz?=
 =?utf-8?B?Sm1kN3NyUHhsdVpvbTFGR29FRXV2b2Y2N3F3b1I4TXFIQWJIczMwR2FLQVpF?=
 =?utf-8?B?TENiRUp6L0tmeGt5ZEhZVFVNMGs4dHlFZlRzTWZDb2tXZ0cvMnFnQ0MvN3dC?=
 =?utf-8?B?Rlk2a3JsRFBBZW85YldFNHRYZ0ZXcWgwV1BSZVpUV3Ztb2IrNXRlMVFGTng0?=
 =?utf-8?B?ZHFMWWdlbUdPK3FtR2RaOTcvVjRKemxKazlZazkzc1BHRkU4NlVvcWFQRUtY?=
 =?utf-8?B?aHpxRzdtK0VyNDJnc2VDeW90cjZrZ3lxejljNGZUb1lZa0d1ajFzL0VkUVN0?=
 =?utf-8?B?cDJQQUQxL1lucHVQUjB0WmNjdUs5c1JtS1RUQjd5Z29wbE9GQWV5Qk5MbUZ0?=
 =?utf-8?B?Sjk0b3FXVEU0WmQyaEZSbHpEQ0NGTWZ5aklDdFJXM1BOaGRLU0JScTJnYWt0?=
 =?utf-8?B?ZU5ybHdtaFl1VUZYNWVJU0cvdlBMWklZd3hmTkJCQVMyWjI3RE9mTnVhaE45?=
 =?utf-8?B?NDJOVlVQeHNGdit3QnJrbDU5QUI3a2VmR2RibnY4ZlVTMnZ5WmtZMTAwTEtm?=
 =?utf-8?B?N2dPRXlZUlhJbk9yQTc0VTZnR2xSS0twWXNKazBxNHp5a0FHVytMSThiOGhQ?=
 =?utf-8?B?QWdMeGVJNUVmYzNKVTA3SEtob3JTNzdtUlBrdEdKd0JRVVhWQkpKZHROaXpi?=
 =?utf-8?B?M2FNaGVFK1kydmtXVEgybm5lYktBOXMwb24wcTVxeDZyT2NZOUFyajNGWXlv?=
 =?utf-8?B?WTFoenZZOXVKdkttRllSS2M4K1Y1dDVPak1sam5UeXhGWmtYcks3QWV3bzU0?=
 =?utf-8?B?bC9kbE5nR1NIL0VHNkxoZ1ZuVDg5djFBb2NHcHVQV1FySW8rL1lDelJEWG1L?=
 =?utf-8?B?MXR2UUdTekxCYjE2VUdvQW1pL0VzV3pyQnFMUXZVN3k4eGJ5c2VkSmNSRnR4?=
 =?utf-8?Q?buMb1x3d5564PoqtAXUnID8xo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: or5GzJbRshI0Qk4UVaKTd841b0qY6PR+R1sjBOWdqfLHr5PseCwAUpNl0259LuCeSMK2ssUvOlntRKgw8mtp6wxt1rr3qbSGvvgN4giBDMUJm1fr2rR0UjyS07RGyNdY7Ow7EQLPYMBa/suQ6NcBxJuKGOj+E+s/dTw0Tb6tXBdPVxuSJ9d3QI5jBQiNzUSNTwMenSb6Ghy+zCfFMFZQTajp1ZXMNjWJceRJ0zcur+Odj8ORRxSqPizvFHrL+Q0CKVnx0TUzyOFZ3rjCoptK597Jzk9A6gxZO0cphSBkDemJQG0sI6iJPpx28izrNNT/bhJaHobLI3f+CAS/pnBV991wclUXyakVMnkRgLu6K0UB1Q8X6SsYdeuRcPqBO016kaKwmsPDlL4tfor+WlYdINWMf9bUW/atuwVILSjlgGJlQiCdO2M4G/n9nOeKpGWhe/Vdi2cnked2pWA8yceI41c0mKsg27ge/MCwbWMzYXpz7XYCatq2TzLUBIDZGbjZ936i2g19mZORxPebEEKtA6xJHwgkok/OvpLC6+55dLOxXiWOc1HH5nfwKfcvW5ueUuqMU/y7izQi9y5HDTrPykK1Tq7yhRu7kiZtECvfE1in7I17OmK956+N5VY5UztiqepW/kyeLcLKmzNbAN/BphZBP8rF206njzyP2lqm8+AcXQPIvXtP2PeYslocdU0QQxuI9rbieTmNg2DwmFhpnPiPplxvl8bh7LDDKyAaGV6TG2GGFE/oJWgwc9WBt5Ax0jTElujzbwH+Ht90yLTuAmOs4rq0/wf5GYIwo96VCLU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a239fa-9736-4414-dc85-08db0810cc60
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 07:07:24.8049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzR3KcaLJI6K0RO0qmOnurU3vwxtCMaC10P9gxr3wk2J/UjhSu6bD8euhKRbqyyQyJAf72V7cVxu8IfvLoYiFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_03,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060060
X-Proofpoint-GUID: 4qoVkxmIMm2qTHvL8YolO1W6XBkeuXGF
X-Proofpoint-ORIG-GUID: 4qoVkxmIMm2qTHvL8YolO1W6XBkeuXGF
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/23 09:10, Qu Wenruo wrote:
> There are quite some div64 calls inside btrfs_map_block() and its
> variants.
> 
> One of such calls are for @stripe_nr, where @stripe_nr is the number of
> stripes before our logical bytenr inside a chunk.
> 
> However we can eliminate such div64 calls by just reducing the width of
> @stripe_nr from 64 to 32.
> 
> This can be done because our chunk size limit is already 10G, with fixed
> stripe length 64K.
> Thus a U32 is definitely enough to contain the number of stripes.
> 
> With such width reduction, we can get rid of slower div64, and extra
> warning for certain 32bit arch.
> 
> This patch would do:
> 
> - Reduce the width of various stripe_nr variables
> 
> - Add a new tree-checker chunk validation on chunk length
>    Make sure no chunk can reach 256G, which can also act as a bitflip
>    checker.
> 
> - Replace unnecessary div64 calls with regular modulo and division
>    32bit division and modulo are much faster than 64bit operations, and
>    we are finally free of the div64 fear at least in those involved
>    functions.
> 


Sound good. However, it appears that some of the changes should have
been part of the patch 1; for instance, the %full_stripe_len in
the function btrfs_get_io_geometry().

Thanks, Anand

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/block-group.c  | 18 +++++-----
>   fs/btrfs/tree-checker.c | 14 ++++++++
>   fs/btrfs/volumes.c      | 79 ++++++++++++++++++++++-------------------
>   fs/btrfs/volumes.h      |  2 +-
>   4 files changed, 67 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 1c74af23f54c..93938e673f1e 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2009,8 +2009,8 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
>   
>   	for (i = 0; i < map->num_stripes; i++) {
>   		bool already_inserted = false;
> -		u64 stripe_nr;
> -		u64 offset;
> +		u32 stripe_nr;
> +		u32 offset;
>   		int j;
>   
>   		if (!in_range(physical, map->stripes[i].physical,
> @@ -2020,20 +2020,20 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
>   		if (bdev && map->stripes[i].dev->bdev != bdev)
>   			continue;
>   
> -		stripe_nr = physical - map->stripes[i].physical;
> -		stripe_nr = div64_u64_rem(stripe_nr, BTRFS_STRIPE_LEN, &offset);
> +		stripe_nr = (physical - map->stripes[i].physical) >>
> +			     BTRFS_STRIPE_LEN_SHIFT;
> +		offset = (physical - map->stripes[i].physical) &
> +			 ((1 << BTRFS_STRIPE_LEN_SHIFT) - 1);
>   
>   		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
> -				 BTRFS_BLOCK_GROUP_RAID10)) {
> -			stripe_nr = stripe_nr * map->num_stripes + i;
> -			stripe_nr = div_u64(stripe_nr, map->sub_stripes);
> -		}
> +				 BTRFS_BLOCK_GROUP_RAID10))
> +			stripe_nr = div_u64(stripe_nr * map->num_stripes + 1,
> +					    map->sub_stripes);
>   		/*
>   		 * The remaining case would be for RAID56, multiply by
>   		 * nr_data_stripes().  Alternatively, just use rmap_len below
>   		 * instead of map->stripe_len
>   		 */
> -
>   		bytenr = chunk_start + stripe_nr * io_stripe_size + offset;
>   
>   		/* Ensure we don't add duplicate addresses */
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index baad1ed7e111..7968fc89f278 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -849,6 +849,20 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
>   			  stripe_len);
>   		return -EUCLEAN;
>   	}
> +	/*
> +	 * We artificially limit the chunk size, so that the number of stripes
> +	 * inside a chunk can be fit into a U32.
> +	 * The current limit (256G) would be way too large for real world usage
> +	 * anyway, and it's already way larger than our existing limit (10G).
> +	 *
> +	 * Thus it should be a good way to catch obvious bitflip.
> +	 */
> +	if (unlikely(((u64)U32_MAX << BTRFS_STRIPE_LEN_SHIFT) <= length)) {
> +		chunk_err(leaf, chunk, logical,
> +			  "chunk length too large: have %llu limit %llu",
> +			  length, (u64)U32_MAX << BTRFS_STRIPE_LEN_SHIFT);
> +		return -EUCLEAN;
> +	}
>   	if (unlikely(type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
>   			      BTRFS_BLOCK_GROUP_PROFILE_MASK))) {
>   		chunk_err(leaf, chunk, logical,
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4c91cc6471c3..ce073083b0dc 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5940,15 +5940,15 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
>   	struct btrfs_discard_stripe *stripes;
>   	u64 length = *length_ret;
>   	u64 offset;
> -	u64 stripe_nr;
> -	u64 stripe_nr_end;
> +	u32 stripe_nr;
> +	u32 stripe_nr_end;
> +	u32 stripe_cnt;
>   	u64 stripe_end_offset;
> -	u64 stripe_cnt;
>   	u64 stripe_offset;
>   	u32 stripe_index;
>   	u32 factor = 0;
>   	u32 sub_stripes = 0;
> -	u64 stripes_per_dev = 0;
> +	u32 stripes_per_dev = 0;
>   	u32 remaining_stripes = 0;
>   	u32 last_stripe = 0;
>   	int ret;
> @@ -5974,13 +5974,13 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
>   	 * stripe_nr counts the total number of stripes we have to stride
>   	 * to get to this block
>   	 */
> -	stripe_nr = div64_u64(offset, BTRFS_STRIPE_LEN);
> +	stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
>   
>   	/* stripe_offset is the offset of this block in its stripe */
>   	stripe_offset = offset - (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
>   
> -	stripe_nr_end = round_up(offset + length, BTRFS_STRIPE_LEN);
> -	stripe_nr_end = div64_u64(stripe_nr_end, BTRFS_STRIPE_LEN);
> +	stripe_nr_end = round_up(offset + length, BTRFS_STRIPE_LEN) >>
> +			BTRFS_STRIPE_LEN_SHIFT;
>   	stripe_cnt = stripe_nr_end - stripe_nr;
>   	stripe_end_offset = (stripe_nr_end << BTRFS_STRIPE_LEN_SHIFT) -
>   			    (offset + length);
> @@ -6001,18 +6001,18 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
>   		factor = map->num_stripes / sub_stripes;
>   		*num_stripes = min_t(u64, map->num_stripes,
>   				    sub_stripes * stripe_cnt);
> -		stripe_nr = div_u64_rem(stripe_nr, factor, &stripe_index);
> +		stripe_index = stripe_nr % factor;
> +		stripe_nr /= factor;
>   		stripe_index *= sub_stripes;
>   		stripes_per_dev = div_u64_rem(stripe_cnt, factor,
>   					      &remaining_stripes);
> -		div_u64_rem(stripe_nr_end - 1, factor, &last_stripe);
> -		last_stripe *= sub_stripes;
> +		last_stripe = (stripe_nr_end - 1) % factor * sub_stripes;
>   	} else if (map->type & (BTRFS_BLOCK_GROUP_RAID1_MASK |
>   				BTRFS_BLOCK_GROUP_DUP)) {
>   		*num_stripes = map->num_stripes;
>   	} else {
> -		stripe_nr = div_u64_rem(stripe_nr, map->num_stripes,
> -					&stripe_index);
> +		stripe_index = stripe_nr % map->num_stripes;
> +		stripe_nr /= map->num_stripes;
>   	}
>   
>   	stripes = kcalloc(*num_stripes, sizeof(*stripes), GFP_NOFS);
> @@ -6286,11 +6286,10 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
>   			  struct btrfs_io_geometry *io_geom)
>   {
>   	struct map_lookup *map;
> -	const u32 stripe_len = BTRFS_STRIPE_LEN;
>   	u64 len;
>   	u64 offset;
>   	u64 stripe_offset;
> -	u64 stripe_nr;
> +	u32 stripe_nr;
>   	u64 raid56_full_stripe_start = (u64)-1;
>   	int data_stripes;
>   
> @@ -6303,20 +6302,22 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
>   	 * Stripe_nr is where this block falls in
>   	 * stripe_offset is the offset of this block in its stripe.
>   	 */
> -	stripe_nr = div64_u64_rem(offset, stripe_len, &stripe_offset);
> +	stripe_offset = offset & ((1 << BTRFS_STRIPE_LEN_SHIFT) - 1);
> +	stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
>   	ASSERT(stripe_offset < U32_MAX);
>   
>   	data_stripes = nr_data_stripes(map);
>   
>   	/* Only stripe based profiles needs to check against stripe length. */
>   	if (map->type & BTRFS_BLOCK_GROUP_STRIPE_MASK) {
> -		u64 max_len = stripe_len - stripe_offset;
> +		u64 max_len = BTRFS_STRIPE_LEN - stripe_offset;
>   
>   		/*
>   		 * In case of raid56, we need to know the stripe aligned start
>   		 */
>   		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> -			unsigned long full_stripe_len = stripe_len * data_stripes;
> +			unsigned long full_stripe_len = data_stripes <<
> +							BTRFS_STRIPE_LEN_SHIFT;
>   			raid56_full_stripe_start = offset;
>   
>   			/*
> @@ -6333,7 +6334,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
>   			 * reads, just allow a single stripe (on a single disk).
>   			 */
>   			if (op == BTRFS_MAP_WRITE) {
> -				max_len = stripe_len * data_stripes -
> +				max_len = (data_stripes << BTRFS_STRIPE_LEN_SHIFT) -
>   					  (offset - raid56_full_stripe_start);
>   			}
>   		}
> @@ -6344,7 +6345,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
>   
>   	io_geom->len = len;
>   	io_geom->offset = offset;
> -	io_geom->stripe_len = stripe_len;
> +	io_geom->stripe_len = BTRFS_STRIPE_LEN;
>   	io_geom->stripe_nr = stripe_nr;
>   	io_geom->stripe_offset = stripe_offset;
>   	io_geom->raid56_stripe_offset = raid56_full_stripe_start;
> @@ -6353,7 +6354,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
>   }
>   
>   static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *map,
> -		          u32 stripe_index, u64 stripe_offset, u64 stripe_nr)
> +			  u32 stripe_index, u64 stripe_offset, u32 stripe_nr)
>   {
>   	dst->dev = map->stripes[stripe_index].dev;
>   	dst->physical = map->stripes[stripe_index].physical +
> @@ -6369,8 +6370,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   	struct extent_map *em;
>   	struct map_lookup *map;
>   	u64 stripe_offset;
> -	u64 stripe_nr;
>   	u64 stripe_len;
> +	u32 stripe_nr;
>   	u32 stripe_index;
>   	int data_stripes;
>   	int i;
> @@ -6433,8 +6434,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   	num_stripes = 1;
>   	stripe_index = 0;
>   	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
> -		stripe_nr = div_u64_rem(stripe_nr, map->num_stripes,
> -				&stripe_index);
> +		stripe_index = stripe_nr % map->num_stripes;
> +		stripe_nr /= map->num_stripes;
>   		if (!need_full_stripe(op))
>   			mirror_num = 1;
>   	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
> @@ -6460,8 +6461,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
>   		u32 factor = map->num_stripes / map->sub_stripes;
>   
> -		stripe_nr = div_u64_rem(stripe_nr, factor, &stripe_index);
> -		stripe_index *= map->sub_stripes;
> +		stripe_index = stripe_nr % factor * map->sub_stripes;
> +		stripe_nr /= factor;
>   
>   		if (need_full_stripe(op))
>   			num_stripes = map->sub_stripes;
> @@ -6477,9 +6478,16 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   
>   	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
>   		if (need_raid_map && (need_full_stripe(op) || mirror_num > 1)) {
> -			/* push stripe_nr back to the start of the full stripe */
> -			stripe_nr = div64_u64(raid56_full_stripe_start,
> -					stripe_len * data_stripes);
> +			/*
> +			 * Push stripe_nr back to the start of the full stripe
> +			 * For those cases needing a full stripe, @stripe_nr
> +			 * is the full stripe number.
> +			 *
> +			 * Original we go raid56_full_stripe_start / full_stripe_len,
> +			 * but that can be expensive.
> +			 * Here we just divide @stripe_nr with @data_stripes.
> +			 */
> +			stripe_nr /= data_stripes;
>   
>   			/* RAID[56] write or recovery. Return all stripes */
>   			num_stripes = map->num_stripes;
> @@ -6497,25 +6505,24 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   			 * Mirror #2 is RAID5 parity block.
>   			 * Mirror #3 is RAID6 Q block.
>   			 */
> -			stripe_nr = div_u64_rem(stripe_nr,
> -					data_stripes, &stripe_index);
> +			stripe_index = stripe_nr % data_stripes;
> +			stripe_nr /= data_stripes;
>   			if (mirror_num > 1)
>   				stripe_index = data_stripes + mirror_num - 2;
>   
>   			/* We distribute the parity blocks across stripes */
> -			div_u64_rem(stripe_nr + stripe_index, map->num_stripes,
> -					&stripe_index);
> +			stripe_index = (stripe_nr + stripe_index) % map->num_stripes;
>   			if (!need_full_stripe(op) && mirror_num <= 1)
>   				mirror_num = 1;
>   		}
>   	} else {
>   		/*
> -		 * after this, stripe_nr is the number of stripes on this
> +		 * After this, stripe_nr is the number of stripes on this
>   		 * device we have to walk to find the data, and stripe_index is
>   		 * the number of our device in the stripe array
>   		 */
> -		stripe_nr = div_u64_rem(stripe_nr, map->num_stripes,
> -				&stripe_index);
> +		stripe_index = stripe_nr % map->num_stripes;
> +		stripe_nr /= map->num_stripes;
>   		mirror_num = stripe_index + 1;
>   	}
>   	if (stripe_index >= map->num_stripes) {
> @@ -6577,7 +6584,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   		unsigned rot;
>   
>   		/* Work out the disk rotation on this stripe-set */
> -		div_u64_rem(stripe_nr, num_stripes, &rot);
> +		rot = stripe_nr % num_stripes;
>   
>   		/* Fill in the logical address of each stripe */
>   		tmp = stripe_nr * data_stripes;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 7d0d9f25864c..96dda0f4c564 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -67,7 +67,7 @@ struct btrfs_io_geometry {
>   	/* offset of address in stripe */
>   	u32 stripe_offset;
>   	/* number of stripe where address falls */
> -	u64 stripe_nr;
> +	u32 stripe_nr;
>   	/* offset of raid56 stripe into the chunk */
>   	u64 raid56_stripe_offset;
>   };

