Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D8165BC74
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 09:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjACIsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 03:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjACIsa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 03:48:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FA7FE5
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 00:48:29 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302NJ9KD007050;
        Tue, 3 Jan 2023 08:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZiERQljno8E6/XsGbGz9AJGNH0NUgz/Jo6Mig3RHzVc=;
 b=kPELAyWfxVvDGBQkmRhd6ppNuCe7V79jCcpiRS49dvTuck5LcA74oUeNmNhKqRJ3X/QY
 dtSoYCNx9BpMhbSTAPYz+3EImwZws4BNM8GmeaqRvwKWuZFrIz2FNO9LeTgPjL7ELNNn
 cI3OitgEos7lTPwpGaLEsoWpO+ED3Lt/3S+O3RBdVFCuUyIOsvGCUzReTxIzQRD6wcoX
 9z0EcgR4tGe2KfkN6tIQ+Rgp8Gc4S7jxF6npMDdx5kKwJRrofKUH/wX8GTqzZ3YdFWpO
 5w/g4EvVcxpOwMGmjRpybcQuG/oSa8rWdM01GHdOrNvZC8GI+SyNC4T7j9ocHOLQycXp 0w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c3en1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 08:48:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3038Fv1F001664;
        Tue, 3 Jan 2023 08:48:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbhatmgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 08:48:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPc7X5Y8PnV/r9aujoFyPa7ijBW/Lh8Rg03zA1bEiRMHWE0RT70ZFW4+Z4WrTbMk3N+4Sx0r7J61Nm+dUNfCp/7Tuy8557b3kycnbHyIoXChdEoRqNmRlp5LmFeytgGmWfBa615iAWtg8Hd22wKcN86AQ+qgVNz02wODwPUk5vZtYsgJB1y5eJt36MyHqrMauL3aceyonhr2oVM1XeS02Xa9ElsGrnlgQ08HhzvCM0ugo5XnuhBuG6pvhrJfNLCNAI1R9SF3qMkjnZr/Q+JS7LpxQJCNqH7Nt5cHwjh8KcrV2cNIDAZXVVOpGzVGjYPtZrsD3LZTBdc1b6C4do9yrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiERQljno8E6/XsGbGz9AJGNH0NUgz/Jo6Mig3RHzVc=;
 b=P2stZYcN/Y+/uZnxsgMl94reoTxUYj84suCCiCfH6aUECJ/SjfRWigvQzhHYFhW00jetdIHS9gS5CKrIbjCueF6F/fCnm5EQ13h3tbrSfPc7Ibk8pXJ/Nz5xYZzqNznQMzWrlvZu+EraErAGbuaTw7zxU14DavDFLqEUMT3VCElCH727dtSA4KBmBeYPrTgBKnIqUhjCNNjJlIdNPPZgEot7xHCJNIZYgI+T+8QtwVZPIVjCtZS0RfIQ9HfmrCwB+ICd2ZK8SLSTVT6vYGVOMIwKgBdXsTfP3EwkjciUCjwXO1HS3l98tW+2ljYGzY4Di30zyAG8vLsG2A8+EPClAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiERQljno8E6/XsGbGz9AJGNH0NUgz/Jo6Mig3RHzVc=;
 b=GCLVJX5Bz+OqaBE8AvvkdHH6uVcveVp21eIccfA/0etmJIosd4lbdF1l+mMCiLDFhs3CApMo0Tl9PPbuXgIsgVuJSvHArDgAEt3PrPfL8CEMo68FE7gk1/XQZCoHQMuZbPh/QQRHOqZ4lFKgJf33VK8yXcCzLgCBqlVA8yiuZ5Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4464.namprd10.prod.outlook.com (2603:10b6:a03:2d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 08:48:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::57b0:9129:31d6:613a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::57b0:9129:31d6:613a%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 08:48:24 +0000
Message-ID: <8ec46f66-8ffa-d0f9-5c83-9449e2da0aca@oracle.com>
Date:   Tue, 3 Jan 2023 16:48:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 2/2] btrfs: always report error for run_one_delayed_ref()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1672016104.git.wqu@suse.com>
 <e8249a59dd7a59869dfaa4fbcb76424f458e21c7.1672016104.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e8249a59dd7a59869dfaa4fbcb76424f458e21c7.1672016104.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 32909e08-25e8-49e4-2ef8-08daed674619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M028cd8xfnQhwxJIOHXwygC6uHA2uLgsVAmeQr2fHhxKbUz7Kitx6Bo2WkWH/mdqdv8ShWrDx4kuCDjcrHA22NaAESZorvyCtaZ0gI3dX9bewmojDeGgca7bN6ZadZWX7b3QtPQaypIHDiyFTwp4pqXBo2Domx8ASH+iY6QsOj8bOQmFIjZa81ShlpCviG/8rXqz540f+fUtj/tgCCFWzWLNA/Vo+qaTqGO7nTwKjTFwbxZmokWO6PrTsljyedUYht7mByL4TxyWo24U/kQdGcDnu/0EE8TzDyWSfdUQGvCL5npq10HwjOX2mPPnRo9UMS8wqK1DimU9XFexMXhOjiv16XzWfXdL/vhKktpH99b3JDO6pGnjkIWIW3zRG9XJRcHKYbIRyUuPtMPCk42RxrSivsfbYr8nvfVkKlCcNLo/l+nnMzxa0z+rRsRXHYyKeHP9r7MtzeUBwsjyPurcop6CuViJutdwheOd9rAn2f4O+uYVe5FLHNXUWRstYqCmhixmoZMsrgQ66mM4DOYC+xIMHpYEVIrZcNaRObvesg8cjeKA8/YDLDWPJLvbfh5PswMC8IFYXh+0y49mXLd1Zs6J19P9A8kAEhTR8apNTt0NduajVrrsEHRdek022XqP+gav4puHbErfUQGfYM6g0DGPnrudCYnXSthxQtilKrLt+oATo7QTz2hLTCfDWpChz8BTjjlD34oMKOrCpBtXbeEf+5xsRLPt2VUELbl3zMrdH8ppMa/xQf22mQy0Xwyc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(83380400001)(6512007)(26005)(186003)(6666004)(53546011)(6506007)(31696002)(86362001)(36756003)(38100700002)(2616005)(8676002)(31686004)(41300700001)(2906002)(5660300002)(44832011)(8936002)(6486002)(478600001)(316002)(66476007)(66946007)(66556008)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mkl2WVNBRFJyVGhwaE1RL2xCOUx6clRnc3RGVUkyRWhxc0dzKzRhVHoxMzE2?=
 =?utf-8?B?SEhRbW9LOGFnTDhVeUlQZ3pkSXl3TkdwMUJCR0lMMGdkTVcvRnVtYnNKejRZ?=
 =?utf-8?B?RmxhQjFsaktEL2kwS0Uwd0Q5SUlncGdYV05JeFBjRzgwTW1CRFRHOFkxU0FP?=
 =?utf-8?B?ZmoxSHFsQXRCMTdDZVFaL2VnRWxvalRJdjFOaWNEVUhuQStzOGg1SEJWa25u?=
 =?utf-8?B?SVRpVm9jV1Z2dTVtcm9BcG1lTWtzMndqRklwUFROR2RWK1FsU2hZVFVGR05M?=
 =?utf-8?B?RmVKKzFhbUVucWJsdzJ5YjA2Z0ZkR1V5cXIrdUJqVS94a3FGaGVwU1B3T21I?=
 =?utf-8?B?bTA3WnpGZmtBYTA0VDFjYVQ5aTd3TnJheDRqWmFSSDFVeHd1Sy9oQ1NKUE1Y?=
 =?utf-8?B?bGgxbzgrdkV6QXlxVXN1QXBhMmRTMXdMTEJ4c1JORlEzUW1WUUkwNFJGQ0Zz?=
 =?utf-8?B?aTVhclA1MmZ5dGNrbC9TMlVLVlp6RU1vZTNZNTdVZGNiRGwwL01uNVNBdFpV?=
 =?utf-8?B?cVZPbENpNTBjWHBrWDR4U1lGdzNseTdRRlpLMU5SOWtjWGlMNWhKb0F4Y2JT?=
 =?utf-8?B?TVZjbzA1bmVUME1DUjdpbkkyREx0T0lQN0gwUE0vcWhzeFZVMHFqUklxQ1FB?=
 =?utf-8?B?TDIvcW83NG5Cejl2Zyt6NVNrZ2t5WEwwMVRpUFR5Um9qSVFEYTFMbU9JUjZM?=
 =?utf-8?B?UE8yNDFITnJCWFFIZTNtb3JhZm9CYzF2TnV0TCtseFlNRHVaL2lHQ1lMZG43?=
 =?utf-8?B?Y2tLdjJocCs0cEowcExoa2NYYnVUdEV3VTYxTG93V2RYTzZYUDc5YTAycUdN?=
 =?utf-8?B?dkxvaU1XZXhIc1p4MWdzTmY1bkFnYWJPcHB0N3UzSVFKbnRkbjRIYm9zaENu?=
 =?utf-8?B?b3NPM1dpSGw1ZWZZa3JpL3NQc3ZDWks1TXk3SEZKbk1aZGxnVW01ZWwyYzIv?=
 =?utf-8?B?dzA0TldVTGNyVk5DYS92bTlBL1NXWXBzdDgySkhqbHZabmJtc2JYTWsrTUZT?=
 =?utf-8?B?c2Jrck1vN2tEU3hINjlKdjNVMzFYYmtpZFk1MkExcmIyOXVPU29uSW5qbjRW?=
 =?utf-8?B?bTI5WCtLY0FIS0ptTktBWGRpekhYZkVBZEh2cXVpUDl4R0lNOHRSSjhzSzVN?=
 =?utf-8?B?L0lPQ0ZDbzZWbDR3TCsrd2NqL2FvcGJQNXY1U2JDNDJld1BJVDNRbTdwd1po?=
 =?utf-8?B?RFA1Q2taajZBeTVXRUwxZWl2eE03U1JUa3dwZE05VXFzQzJxcXJHSHhnQzdH?=
 =?utf-8?B?YTlvNkZjYjhkRkRWMVlvTGNkV2xPUVB4eGs1VUJhcXZBSUNHNFN1dDhvZzBk?=
 =?utf-8?B?VlY3RVplWnY5ang2SGlVK1dFZEREWmpxSTJrTVJVWk1Ednd0b21yK29UcVlB?=
 =?utf-8?B?blp6OUo3U0habHUyY1d3MTZVZS9nbWFWSmJLTEtUWGRJYWJJMXNZREZ2ZDQr?=
 =?utf-8?B?Nzd2UGxML3N2SXZ6U0lJMTZrYkluRFVCb3orSmd4SVhqTTZDUzd0ZWhsWFp3?=
 =?utf-8?B?a093MnVUMUhsMEYvdWxiN2pqd2Q4bVFEVlY2M2czVVRGRk53aHlJR1RGSEdH?=
 =?utf-8?B?a0JpTDhoT0Q0bWFIaGVoU2hKU3BGRkxMVmxQUFFsV0lOYWNnci8xUjZ5MGxi?=
 =?utf-8?B?T29OWTdHQ1VUd3liMnRldXZIYzAwNy9TQWM2Uk9ZRDAxOWdSTFRHSmJCS21x?=
 =?utf-8?B?MzFUZFRvTUluUFZTbFY4Q3dFTWFBVVlzRTVEOTBSdFg1eUl2dlY5TDA3WjNC?=
 =?utf-8?B?Z2RUcUNmOWdzclV0T3FieGZKVUhoMEkxOUliY2RIdzlZWjNNdXQvRnAyU1dR?=
 =?utf-8?B?VWFZRlJBOGx2ampkcXhjSFJ2UWVibk9PS2lIb21zNkEzRUNOZ2sxT3R6Ync2?=
 =?utf-8?B?cm10WVhkUXIrZzh4Zm9NWWY1KzZKTktxUDNWQkNRMmtxRk8rTTNacmlkTW5V?=
 =?utf-8?B?eFB1RWRRY211Y2dsTnZPTndkOGFzaDlrRDI0RXJwN2U3MEpqL25ES1k2UE9D?=
 =?utf-8?B?aHhLWm55T0FDR3NOY1o2cXdxQWMzVm9JdkYrcE5BeGpIZmprdmxVR3hucGNa?=
 =?utf-8?B?Lzh3UjJDRWZBbURrUXd6WUdmNnJxNUxkd2gwYU9ZWEpDZmJ3bG81QlFOWWJG?=
 =?utf-8?B?SUZVNWNPL1FTaTd6NkpsaFhsWm56cTgvdzZ3YitGZ2tGU0kvR0M5V1dtbUx4?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lylNHQN4iJ0z+EH5ZXF4whXrcsuwwKKcsHvM+IHZLBlmuWqrjEbz+kRNmkAvSiDb0ViqsQaVlTUvIKgjQOzGNRI+t7J4xeVpFsIEvHd8BfNkhzzt7xAzd8ryY/9XIAvoNRqj/0JiRH1CqltYrxgNZUST2KfM7ta99QGh1xO6/vCXNWwdjS9Nli0etQlN+chIxq4xIv5rQfeNQ0Yplz7JGNkm/APa/s4IJle7gi6z+szr+ERei/XuZEZgHQIxuL7cD0gMKIbx72FUAWtmC2IjUNdoDVeEMBaSjEK6FPa72hT+JNvF1C3OC3n3QLKmiAogO1xe7GbsAHymIBpnqF6HwFKSM9DlV14eIt5vph/Li9TohjYEZu3G43pEKXyhwIkiMTlWvvF3vSWAkEHQsJQnnmYq/uNEXAzwiiZSp9LSMx7Coehe3IH+/h1x6+8qw9wOqqV9Bc/IeTPWnMtaE8j7C5OorgoqE3GVvALyLIUH7Fce/qQbYhiYWwQSMWQsc7FSoLDjVd8UR0dxPDfaKKFe/On2dF7bDbcUgwfcFoPfHUDwZ890H3uTHwvq4/EFLeEkCbRdGOr7luT5svHZ0o40Ec2uaxwFd3y+Ia99rxRb8Iv/xMQk56xgHQCNB4Db6VTtIjuGXeTF7JKWTOg1bZcc4KRP5S04wW0glCBUqAmCIVTt/+b/5kq0iqvm6faddcfD3/kkxj/w86PO4If/RqlcODPAxHGlsnyhfQKOsO7Wl7R8KUfx93FiqWPC5d7it0zsC0CL2ugJm59TUs+XvxBqYYpkATrErMySpnNT/y7tdx8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32909e08-25e8-49e4-2ef8-08daed674619
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 08:48:24.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dyKqYsXJW2+rAdV53LrjTdNHiu3YhJzPhLa9ci7BbK9+gTPpOiHjw9aFYZkGURYwCuSTEr3zSPF1En/nlDN0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030077
X-Proofpoint-GUID: e6xr9HTiN5KZSjgntcCGwg3pk6Gcpgjq
X-Proofpoint-ORIG-GUID: e6xr9HTiN5KZSjgntcCGwg3pk6Gcpgjq
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/26/22 09:00, Qu Wenruo wrote:
> Currently we have a btrfs_debug() for run_one_delayed_ref() failure, but
> if end users hit such problem, there will be no chance that
> btrfs_debug() is enabled.
> 
> This can lead to very little useful info for debug.
> 
> This patch will:
> 
> - Add extra info for error reporting
>    Including:
>    * logical bytenr
>    * num_bytes
>    * type
>    * action
>    * ref_mod
> 
> - Replace the btrfs_debug() with btrfs_err()
> 
> - Move the error reporting into run_one_delayed_ref()
>    This is to avoid use-after-free, the @node can be freed in the caller.
> 
> This error should only be triggered at most once.
> 
> As if run_one_delayed_ref() failed, we trigger the error message, then
> causing the call chain to error out:
> 
> btrfs_run_delayed_refs()
> `- btrfs_run_delayed_refs()
>     `- btrfs_run_delayed_refs_for_head()
>        `- run_one_delayed_ref()
> 
> And we will abort the current transaction in btrfs_run_delayed_refs().
> If we have to run delayed refs for the abort transaction,
> run_one_delayed_ref() will just cleanup the refs and do nothing, thus no
> new error messages would be output.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


