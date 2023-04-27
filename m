Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D562A6F0F55
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 01:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbjD0Xvl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 19:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344155AbjD0Xvk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 19:51:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7E31BF8
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 16:51:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RKPLor013361;
        Thu, 27 Apr 2023 23:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1cBGQpTE1W/tlsXikqvGEBIET13eTUWizcmxFDNpqds=;
 b=LdciGi8I6iDKr78Q38vluHK3Fz8FiydP45U6GUbjTGsXI0X7epAC7/vNC/JfEUiFYg+r
 KQjP+3R+RoUumEqV6bscaJRep884HlOrjuqdeeqCQhR7gWpZJkibZEYVbxEybnF9NxP6
 2fJ5c79p4YJ/1teSu9ZGJfUuOufEJLJLC+EwppZCdv58vlyHwgku58yYegpAXdqwkUq3
 BG5lHeZAWbCdaOpLLEdS+iNMJjhKEwJBiRXEa6/FXjzRUMw+5XNB7S0WES7J5wjNdq7m
 GDXiePq5Neja8f+3h1hp6xezGWHWvHn0ZQy0nJPl+v2tD7mayLhF+Smci0XiVH0VPVZc Qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460dd201-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 23:51:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33RMOeR6008651;
        Thu, 27 Apr 2023 23:51:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461a8u9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 23:51:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJBkEm+FIzJLJ+LmNjKXmEoaUeJE/XMxQY5G2BkWyp9X+HLaRcipXhhryjXDS5DaTVC0YadX/QbNymrC+kpgU8pQz6BLWCWBW600KpD3eik81I0osLeLJjpul531eT1jmtwxT6XZ+dAMD3yMPSHc/jh2wnRRbDi3KBZ3AzN95UQ4PxxR+tNArZZ3MfBT7bS9qItM8fTyqbWC4QizQLdu9G9syPUVF9h1X1lkUHUZ/MEHfovwuzBzry/t2a9kUa493N0/AcLplAb4Mht1QhPg7q3TEIfesivU1qgAsrhIyYqOOIKSYSMgzRMZ03d5pNfS9l6jzCxHR511e3ufyWKv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cBGQpTE1W/tlsXikqvGEBIET13eTUWizcmxFDNpqds=;
 b=NdBWKpFaopH3RPbVW26W21iZmQoaJE+OFRvfsZJzkoq5+s+w/e5wDdBrwjDQ81uTBq9MZDeY0pVL260aK31Wzjb3hSF3fmCdszj0qPeNTOts3lYxNq1AgbH75GiZNUloo52HufGD4S1SeFwssvHLUC5OSuomsop2gmj4itClVwi4NAQZARLyRrFfRMJeIX716DNxj3maNMrJ2F8gFFYFsi+5HRfXd/9M1XALXKX+3vZw82K5V9yYhf7wCN33YYgaup4n/1mCW6y+qPf9kXV9Ijh4ME+urBLZ9ZxxvRFMnWkkcM0hKvXpaSXcehUtDY7VHs4F4xYSFA+ZIKRprzEfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cBGQpTE1W/tlsXikqvGEBIET13eTUWizcmxFDNpqds=;
 b=PDo1v0iXuNam5jygUXDBtdYxpjYReikD0gU4HeQUPMjmkU6sJxAjgQrNTnPsRPSGKKyhsVhaPamYQd43IxHqMdHc12UYOH90MHaJ4LzwsXTAfPLbQawF9Cb+6y69zlF6CEUjP5k4jKc1qPkaT9BUmBQz3V8fcluiSOEJkaVM1x0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6750.namprd10.prod.outlook.com (2603:10b6:8:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 23:51:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 23:51:31 +0000
Message-ID: <bec5a845-aafb-c7da-0438-6e91cca5ae30@oracle.com>
Date:   Fri, 28 Apr 2023 07:39:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] btrfs: fix leak of source device allocation state
 after device replace
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1682528751.git.fdmanana@suse.com>
 <e695f292be17c831e6024a743365737372a7a7aa.1682528751.git.fdmanana@suse.com>
 <043226b3-3543-0430-c479-7a1824be5fa6@oracle.com>
 <CAL3q7H6Xh9_Farxym2+a16TLNuSk+P5qJaoCZ4UcuV08PAo88w@mail.gmail.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H6Xh9_Farxym2+a16TLNuSk+P5qJaoCZ4UcuV08PAo88w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3f2515-b84b-4963-c272-08db477a5300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isCVUuDSs/pIMh3GaxwELo+ozHFgYprk5AxD9gwHH1sGTCcBextMwysl8jFFiNAn9kPf1NVfaDVxBZnaqSzeB3eg+dC/AhPK7nE4GaqsNeCWtKZ2INl+/KQ3qVZcVi7QUCKh/IpCxE8FbEGhMikzpoGT+9Ebnme87w81F94VVanDrfdImShvyXARf8LtW05/AeNEiDdK0ePYTIlwNr5nC6c5Fb1vMTIv3XHUD+gEtfsWxgNolsdcrYtTwxWMai7A+AEy/xMUX60as3LC+vmT6W7eX9VsPX/m+KtPlzdbvhhsH4azSDW0w1Icy9SKNz5J3NBZfxWU+676tApxwAiUiUAVKtzDmcpfS1SjSN60IvZWSUt13Lz6zGBBFY3pTxsfmyULx4si5qK1T9OnhbqeWXNdEyNDI1+1dg74n+t4dvTHLnnWyg4jcaJHj3rLsTub6s2E8k41Z4qwEvbc3HcIVk7gRD/Nixnml4QiP/7aFoeSjq83RDQqFIADE7AjoCqbSl3aLFe2l7K/Abxp5xwNyIKX7W1oI2xZcdXmQlnVntC1viZgno7IVYe+Um68KL92V4W2akmfyLTj5Jbt+ErarK8XQHru/UKi3IaOYWr7o2oAbZeiOicqbwOV3Gw8/OuNPh3twXxQZf0IdQ4vnHo8Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(6512007)(53546011)(26005)(186003)(6666004)(478600001)(36756003)(8936002)(5660300002)(8676002)(6486002)(44832011)(2906002)(38100700002)(86362001)(66556008)(66946007)(4326008)(316002)(31696002)(6916009)(6506007)(41300700001)(66476007)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHhMaXRCc01iRGNMOXVIVUhMTWl6aVJ0TkR2QmlQSmtGWnUwZUhWVk9Feitp?=
 =?utf-8?B?NmEvZzlJdVYvQkYyVFRWZ2VxTzZQSHR4SEI4SExsVGZlbWcyU2xJZXNPOEpm?=
 =?utf-8?B?M0xoUFFyYW9iMjhhUzA3RlR5ZXNZQXZiU3YwOGtXK0x4UUZtWHZ0V253bXR4?=
 =?utf-8?B?TXd5UXZTU1VOUWlHNi9kTjdQb09tYjFCdzBDWVYwclQzNDR6V0xnR1BlRUVt?=
 =?utf-8?B?ZEhSY1VKQ2VJNjhkMmdmT0xhcU84OGNCVXU2a0lyT0Q2NmlMc25FU1o5dnU3?=
 =?utf-8?B?VWR6dEI0N3FOTzE5NCtIUmlUMG5aVWo3OWxUYm0zWnM4YVN3WUJsbXhjT2Vi?=
 =?utf-8?B?aVZ6RU9zZ0RlTVZlYXVXbEE2US9VRk5mU0ZpN1pIZ2xSRGZndWRWTnBTTGJ1?=
 =?utf-8?B?VllxNVZCVEFNTll0VWNQQlc5UGJCbUJGZzk1dFh2SjNoVmlwMGFvbEFta1ZL?=
 =?utf-8?B?OXJNU3pJWVl2bTMzSlZwZ2ZBQ0dDdmZHZjN6cldvSzlWRjBubzE3aU9GeTU0?=
 =?utf-8?B?eXdwd1FVVldJb3lPN2FHVEF6Tm5wS0VPb3hIM05SZ3dMeTVqSUhzRWZPUUlW?=
 =?utf-8?B?TThYeEh5YnFWemQzK2Z0dTVNMnJtanJvRzhiV2x2SVVSQTB2bTYrRHYwYTRG?=
 =?utf-8?B?QTVrRzkzQ21hbkFBS3k2dmdiOSsvWGtnQk1GYmhPWXgxMVBEWXFFajRTV1F1?=
 =?utf-8?B?MjZnUnhlU0l1YlBSWFpVTFFXbk9CZVVRc1dFMEFFSjFlanlDMTJxYzVZcHA1?=
 =?utf-8?B?aWxxSmJQQVZqTm1YRjNlOTlodHorQVNkaDBuN0p4a3FKRjBMZW1hVjdDZXNY?=
 =?utf-8?B?SVMwQU4yKzVKa3NwejNqcVk3dUcwNE4wKzNlUDh5bVJSbDM5VGxScjJFaGFn?=
 =?utf-8?B?TVZMaC84QmtIUGlJN3l2bkkyV09HRUk4VWU4UjR5S2JlYmFvUnc5L0wyMEJ3?=
 =?utf-8?B?R2k0UHJFZTRGMzJxaUhKRzdNLy9TdFkweTVYSnhVbUdlRGpLUVdrL0xETGR0?=
 =?utf-8?B?VG9vdGg4dUVmSndXODFXWlkwU2tScGRQa0Q0RUtueS83UjdrQTF1SDN6cVdx?=
 =?utf-8?B?dmpnNlI4cEV4b1d0VmlnTUl5VHZZSUpoOXNTRDZ1MFp1b05DOVYvc2dENmFK?=
 =?utf-8?B?UUZoRVVoMUNLUVEwRGVLREd5VVFnWE85bk9qam8zMk1pWUE1aVU2YjZiRlZK?=
 =?utf-8?B?UmJRZjF1N2Evb1kwSEJETXMwMVpMUHV3UHFqRHd6M0phNVY3YWNRQUpJU3Ex?=
 =?utf-8?B?WXllZnRsUnc3Q2ZoRkZkRDJjZTNGaTVUY3VmcWY2NzE4OEpqeXI2VTJUWjRw?=
 =?utf-8?B?WktIbUMzenNnMkRpYVN4UEs0OEtjNjY2UmM0SFU4UUp2Uk9YbjJXbk4xKzFo?=
 =?utf-8?B?YVZ6M2dQWkV3Smg1d1ZjMEp6RFN6K0dZaFBKOExPeHpYT0ZycHFOVjczVjlO?=
 =?utf-8?B?WFFvcCtCRFBEYlQweXJvRTROZ3NpbFoyRXlHWGNjdTdndXpybk55dEI4c0Nm?=
 =?utf-8?B?Wko2UGJtVEVEeWcwVUptUkdjTE5STVVYWHRQUXBVWEFSQWlhZkpsdklJUStE?=
 =?utf-8?B?N0lFVUkxUXZVdERuTkxIcGUyUDlvUk9PVWJoaDlRd2o4bW5xZ2NQWlF2dEZB?=
 =?utf-8?B?aGZSRU5HbTdwL1RWTkh0MWN2a0V4TXhzOTlsRHZ6eEppWk9OZDBlTTZYOFB1?=
 =?utf-8?B?UlVRcGF2SnkwR2p5NkYwWk9qNDREckFucis3NldrZ0FUVC9WMXM2cDNwTWZO?=
 =?utf-8?B?cXRQQ1E5ZENQUDVTMHBGbEFKVUlYMG13SEE0dzlxMGo2QXBEb25ISkZiK0VC?=
 =?utf-8?B?VzI3ZXg5WGtLY1RXMVVvOFRraVY1dHRETmFGZEl6bmpNZ3RGL3hNYXY0TklK?=
 =?utf-8?B?VEtvWkVjV2ZkM0F3cHVVUjJUbXZCUHhRbWlDdjZJMkV0SElhRUdLSnpJSU9o?=
 =?utf-8?B?THJkVERyVnpjWnp2eHVacmpJVGpDRTlNSTlhNzArTlZRalJqSkhnc0JNQUU1?=
 =?utf-8?B?SnZQRmZUQXN4aXhVRU5xT0NacnA0Y09KalBsWktmYmZIME8rRjVYd3JhWDVW?=
 =?utf-8?B?MG5DNlM5MTFFZC82anhXanFJZVM0b1prN2NsaFRiQlE1NHdaWkRhYytYU3hm?=
 =?utf-8?Q?fCtkG7oRKUj6rapDfDIducVml?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bPybM2Eco58zPiD5MSfRGpm6V6rvvhZuaDt7z2r8S3s6Sd1pvYzCnDI+8Sc4fRK7dJQ2TmVAPaHD86dhHUiZ4icIajw2Og3p3DHZyxreIlcxV0y9lUjjTxONxUW5MSHwXH5na/7Z2v7M2AGdIpIw5Ea6BLWLkFVo24hnVP7hr/GGECdDtIOnY88Lx9Xa6Eu4Ti450CMsb71G0nfqVla12dm/PcKjX1VJrVPTS399dRO2sMlK5/Ukjild8lpJfKxOyaWhEEc6J8jICN9iu2eVwBJ+JrE0fQUcJlaHR4mv2Qtet6LpkSj+5XUMQ4ROeEcAeOTF9xVx/zQVAuxRB5CNyn8v1HJKhBWe362+BL+vYdyChTPnI/SZ1RwcmEn+DEryNREKQLncOtZJI/vaNJdNNPbIyDOcvJoumHLYgjt+JDIR5slH8Db1WZ7Y3aCmVKEEg3roCmqecF7xKd6DtG7B5H3vS2tFYJG3r8hWZiPQqXwyaAnDO5cvKdS+0V3sgzd0DapbSB7+l8pjbkarVTe77nX8t55l8nqr1xscKP1c505qppWkdwKgIfN61w3PgGL4ws/J+5dX+vmGgMNw3W6UGVfK9JSZTSwlA+yMtZlHR1ziiRCn9AV77ZZD7BQ9AiIQpUW2uBs7MaaCs5XBePCXrOUqzfHv58YCgmB+Bvwfn6sLs7BUZOHppj+Rg6ZCSJMh/l6oZZ8AtKzhwi5mlACCDeams59x+tTAXxlpJDA/+RMDje9Nz7/HrRrmoM+y25ieptFUSBCYSqEvUzMPuPCBQY2pkU6LoqdF/6olzcXpvAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3f2515-b84b-4963-c272-08db477a5300
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 23:51:30.9264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8rK97j2RCYcR7IBAqFaNw0t9HDWbWkMDZBuKBPMxEKJeV543WgrmjDYAu/7ZpVOkj7FhPA1wYX7WPH4gdi6bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270210
X-Proofpoint-GUID: cRMfAWJPFDLG0WyqTaNS_NdSWZB4N5mF
X-Proofpoint-ORIG-GUID: cRMfAWJPFDLG0WyqTaNS_NdSWZB4N5mF
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28/4/23 00:34, Filipe Manana wrote:
> On Thu, Apr 27, 2023 at 4:16 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> On 27/04/2023 01:13, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> When a device replace finishes, the source device is freed by calling
>>> btrfs_free_device() at btrfs_rm_dev_replace_free_srcdev(), but the
>>> allocation state, tracked in the device's alloc_state io tree, is never
>>> freed.
>>>
>>> This is a regression recently introduced by commit f0bb5474cff0 ("btrfs:
>>> remove redundant release of btrfs_device::alloc_state"), which removed a
>>> call to extent_io_tree_release() from btrfs_free_device(), with the
>>> rationale that btrfs_close_one_device() already releases the allocation
>>> state from a device and btrfs_close_one_device() is always called before
>>> a device is freed with btrfs_free_device(). However that is not true for
>>> the device replace case, as btrfs_free_device() is called without any
>>> previous call to btrfs_close_one_device().
>>>
>>> The issue is trivial to reproduce, for example, by running test btrfs/027
>>> from fstests:
>>>
>>>     $ ./check btrfs/027
>>>     $ rmmod btrfs
>>
>> Ah, module reload is a useful way to verify. I have now enabled
>> it in the fstests by setting TEST_FS_MODULE_RELOAD=1, and I am
>> able to reproduce the issue.
>>
>>>     $ dmesg
>>>     (...)
>>>     [84519.395485] BTRFS info (device sdc): dev_replace from <missing disk> (devid 2) to /dev/sdg started
>>>     [84519.466224] BTRFS info (device sdc): dev_replace from <missing disk> (devid 2) to /dev/sdg finished
>>>     [84519.552251] BTRFS info (device sdc): scrub: started on devid 1
>>>     [84519.552277] BTRFS info (device sdc): scrub: started on devid 2
>>>     [84519.552332] BTRFS info (device sdc): scrub: started on devid 3
>>>     [84519.552705] BTRFS info (device sdc): scrub: started on devid 4
>>>     [84519.604261] BTRFS info (device sdc): scrub: finished on devid 4 with status: 0
>>>     [84519.609374] BTRFS info (device sdc): scrub: finished on devid 3 with status: 0
>>>     [84519.610818] BTRFS info (device sdc): scrub: finished on devid 1 with status: 0
>>>     [84519.610927] BTRFS info (device sdc): scrub: finished on devid 2 with status: 0
>>>     [84559.503795] BTRFS: state leak: start 1048576 end 1351614463 state 1 in tree 1 refs 1
>>>     [84559.506764] BTRFS: state leak: start 1048576 end 1347420159 state 1 in tree 1 refs 1
>>>     [84559.510294] BTRFS: state leak: start 1048576 end 1351614463 state 1 in tree 1 refs 1
>>>
>>> So fix this by adding back the call to extent_io_tree_release() at
>>> btrfs_free_device().
>>>
>>> Fixes: f0bb5474cff0 ("btrfs: remove redundant release of btrfs_device::alloc_state")
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/volumes.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 03f52e4a20aa..841e799dece5 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -395,6 +395,7 @@ void btrfs_free_device(struct btrfs_device *device)
>>>    {
>>>        WARN_ON(!list_empty(&device->post_commit_list));
>>>        rcu_string_free(device->name);
>>> +     extent_io_tree_release(&device->alloc_state);
>>>        btrfs_destroy_dev_zone_info(device);
>>>        kfree(device);
>>>    }
>>
>>
>> Hmm. Is this fix incomplete? It does not address the concern raised in
>> f0bb5474cff0. Why don't we also do this...
> 
> What's the concern exactly?
> One extra call to extent_io_tree_release() that's actually needed?
I'm looking for a solution that meets the need without leading to a
situation where extent_io_tree_release() is invoked twice elsewhere.

> 
>>
>> -----
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 40ef429d10a5..e8c26856426e 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1133,7 +1133,6 @@ static void btrfs_close_one_device(struct
>> btrfs_device *device)
>>
>>           device->fs_info = NULL;
>>           atomic_set(&device->dev_stats_ccnt, 0);
>> -       extent_io_tree_release(&device->alloc_state);
> 
> This will change semantics a bit.
> Removing this, will make us hold on to more memory for a longer period
> when fs_devices->opened > 1, so btrfs_free_device() /
> free_fs_devices() will be called potentially much later.
> 
> I'd rather keep the behaviour we had unless there's a stronger reason
> other than removing 1 line of code.

I'm trying to simplify by merging steps in either 
btrfs_rm_dev_replace_remove_srcdev() or 
btrfs_rm_dev_replace_free_srcdev() with btrfs_close_one_device().

This could beautifully address the issue. Let's see if it works.

Thanks, Anand

> 
> Thanks.
> 
> 
> 
>>
>>           /*
>>            * Reset the flush error record. We might have a transient
>> flush error
>> -----
>>
>> Thanks, Anand
>>
>>
