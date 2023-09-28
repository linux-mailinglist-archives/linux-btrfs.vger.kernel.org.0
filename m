Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFCD7B1229
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 07:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjI1Fe4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 01:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Fez (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 01:34:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99388BF;
        Wed, 27 Sep 2023 22:34:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL7RvZ003981;
        Thu, 28 Sep 2023 05:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KYiFHhehmwArwdpZu0bP3JM3Lp2MUjlnR1h+dILAqBY=;
 b=GUcxzFtBnKd5UKIgZCMPfk7uTZpsKwtIf1abZb0RqVL9qggD+hzCWQN8rC6v+tFWJHQV
 h137qx7OeR+yX2Vz5fWD7Xv9Va1bEnsyFcUcAQUM/CzfcC/JWdUr0l/Rzo3gKEKCo2ZB
 sqFfb3FPxyPCBvQoNjPSDW6Df3YaBdpaO6o51xaQvF05AuDImRC1Q29kWY5IKmOD0XxJ
 UQYfeSIVF+M/55fw2wOos04VL2krV8kdrSuSRdn46sXqdJqgp9MQYnHHamazlERUGtDZ
 luXVF2lBnwRcpXQLpONDCg3Mz+EnDtQySM71RlquRq+/+LXuFxNS91zcapAIK/K9BNmy 6g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjuk7ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 05:34:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38S2qT3G039371;
        Thu, 28 Sep 2023 05:34:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pff7vdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 05:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEZ5myPaHQxH73HQtFHP+b8mvbs8lzdZaD3+8neEhMe39dqjcQw5Fe7/DRgcN/taboyoOzSiqKt4ftl0hmHWJK7+VxGtu8vArqWoJcCr6zOQt+S0kb97TtieyiI4g8y2v1hQVZ5egpDGLkXR2VmkmZ5kjuvygeIboRLBeuMQjRqoi47Gr0d/52oJB0BbDPsY9FyVlLyRkmqM33+PTEDeAwRCdIdWJU7V65ifekyw4UdYvZprvo37e689X51haUjao24fM+ZP9SOw0nwbSgWwyNGgXwTN+gq8S50modQqOcHYZD2I+/g8Z/9ilq+hKi9K7BzV19OMj6vhHgMXju+GTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYiFHhehmwArwdpZu0bP3JM3Lp2MUjlnR1h+dILAqBY=;
 b=DweEVotEBM4+YRezVm65mnBtAqY5MNCpfMgQfbW22gX0F5ZcyzZKX+KOR7cKic3/TjV7qVSs8d4+tKOdtxivbTWCKaOHy/cRznPKpggjR2b14YF4DeBifqbSm1qg2yfQ9AVTddcOVpdWzjjog6JlV6c/+5s2/qJfhGOTmDPCzVZ8YpYTZWwOqwVH38w3yUyOIa1vpoUxupGXShO21zmPaxW3OLTUm6FSgeXO7J+wS9nlUDGesOBVVmHRDiHalK5mq9T4EpI1zATyzSQboP8hhRITVlIVh7bSwV7dG1zg+Pp6CMJXJeTKIyCuat+glx8+2YKf+EeOhardIp3qEt7fWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYiFHhehmwArwdpZu0bP3JM3Lp2MUjlnR1h+dILAqBY=;
 b=kEKHUwgaqgb0pfbJ0gR/HYXGK3yvPjo48xqScBNAOF8oxGd0VqcMWYMF+8GECw94W4xNPlIW1bWVSyTehGArKeVGrYit23lJo68RS66krY3/jR4owBNhvaTrjJOuMCr4QQN9UlCk+5z3osmX5iZZAweTelJ4UdgQkTMwGn+wiy0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5725.namprd10.prod.outlook.com (2603:10b6:303:18b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Thu, 28 Sep
 2023 05:34:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 05:34:37 +0000
Message-ID: <5485cd32-2308-c9c5-4c97-9ff6c74c64dd@oracle.com>
Date:   Thu, 28 Sep 2023 13:34:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] fstests: add configuration option for executing post
 mkfs commands
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com
References: <cover.1695543976.git.anand.jain@oracle.com>
 <eff4da60fe7a6ce56851d5fc706b5f2f2d772c56.1695543976.git.anand.jain@oracle.com>
 <dfc4cece-d809-4b5b-93f7-7251ba3a492a@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <dfc4cece-d809-4b5b-93f7-7251ba3a492a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b45ee4-4b35-4125-e781-08dbbfe49a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Go0pVocEh0a4wTkGxt7GNrxkstU3Ek5pHVtyLfOict1f3jbKwgNq2QyqbEghV0bVNZbQaSGIPZJgiGFWp9xV6Widms4+UmjKBetjDtfwbG0UtvEA6KBVPxVuF8g2Qh2f2YMS/YELAOxqx2WsRjoCQ7YtjLNQtGhNvt7UvKjV25oXMLQAwSix6FBaN91Ed5ISr1lSAJWy8ksh1P168idCJ0qh+sxe9YLbB1ByVxPIJg5DA58VeoCUaIR0Eg1LASJxDKGWlAZid/JiRFGoHs5OZqyffK9DPdXrvEA7pYN7OBrwTHg1LUog+AarIOORG9h8P8u9BPhs21eevh8rgTSth60mdKENXX/Ez5+UM+b1aXCrIDqfpTjqQPSG7XoqWiwwMt5LPQTVrBQZkBuEhMlQcB146zPHxGqUBW0vRvts9hwC2nhon+6aya98dKL3F3PrZudqJEY/9eLcn8bAiAHrnI+P72hOCqD1JO6tI1hLGdc8zs8H6Uw88byKV6b7hqmStiNpHXEqSzVuBh+8npyICxH41On1Lv0yaVZ4W1PviB6c0eYE99h8DiJzbzSwEddvaG+XR/u7MT8VvtF2WKqEZ5WN/6aYNjPD3niggVqdwS2OUtRYZ4w1L2sEiJ2022jxmIDL02N+CwtlUcfQhUhjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2616005)(6666004)(6512007)(53546011)(26005)(6506007)(478600001)(6486002)(86362001)(36756003)(31696002)(83380400001)(38100700002)(2906002)(41300700001)(316002)(5660300002)(66556008)(66946007)(66476007)(8936002)(8676002)(4326008)(44832011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFg0NWh6V0tRY1hDRE9tZTExaTI3cnVIM2lzK1BmaFlTYUk2SE9GNTF2b1dt?=
 =?utf-8?B?TVpqRHYyR0hGSEtkc0N2d1hNdmpEeG9pc3FtWUlPaXZKTExQdXk3VFNLWDJz?=
 =?utf-8?B?aVhTSW1tSXo5bG92TGVZL1ZrUFNQSmVzQWFlMUtSemUxQzdrTGg1cXkxZ1Ey?=
 =?utf-8?B?WGtoVUZFaCs3cjlKQ0wvbkU2K3BFREpUeTR5aDh2aFo0S3UyU1FBeENTOXd2?=
 =?utf-8?B?ckZaNFFFdlpIcTZobFdnTHo1aXdkSkhHMzFMa3F3aU1SS2FYOGhCcXVGRDBH?=
 =?utf-8?B?elBucERkVnovZ1B5VGVoSU9lV3V1ZkY2VkJDM1FXVjZ3L3ZheWk4ZGVDeFdC?=
 =?utf-8?B?bWtlWE1hS21IYStsQXUvUHE1Ym5sMWEyeFFTNWtLTStINUJNSE1qeUtrMWIy?=
 =?utf-8?B?YnBYOVBQc3NXMVhYOHJ4VlpRcURISVJ4ZDlGVk8yS3cyRzUvSzN3dTZsUEhw?=
 =?utf-8?B?VGpvUVMxdmhEU214VzhsQStvOE1YVE9jQ0szTVBCVU1GWWZWVS90MFhtMDRj?=
 =?utf-8?B?ZjlpQVBteWt5WUJSZklDbDBhVS9aaFpVVldrRHNSNEJPY0dvSVVyeE1BRkdN?=
 =?utf-8?B?Vm95eUd2ZythMjZxTFFhOGFDYWc5bzhWdUZURzBIaXN2N3BjTCt5bCs2OUJu?=
 =?utf-8?B?eWZWU1JxTmthbkJCL0gxYzJjVE9oT1lEZ294QVg5Y050MlArNGdHZGlKUnB6?=
 =?utf-8?B?cHVnZ29rdmJXUmhGL2xiNmtsTE54WkRleTg4bXExbFdqOWJ5RElDYUE0cHNQ?=
 =?utf-8?B?Ri9uSVJ4RUw4L1lRcjkwblFGaEFtWnlYbnV2R0c2OHZJV05hbzBiaEFmYTNj?=
 =?utf-8?B?c3MvcDRPWHpOUjFJSjBXbWUrRTJSLzd6c1I4MG1KdDV6WXN2TERXR0NGVnZR?=
 =?utf-8?B?OTdyRHRydjVhR3FBMG9IVStqK0JJdHdNMnJmR2hXcHM5dHcyWiswckNNTVY5?=
 =?utf-8?B?OTBMVWZyaFQrVlJtdjE0d2ZHb1VZcHdsWDJicjBtN2szUnZJT0FTejE2VHox?=
 =?utf-8?B?Ry9Nb1B3WlJrNEZIREk1cFRZRGVuTTZFMytJR1diTEdJT2MwSTVTODFvRVdo?=
 =?utf-8?B?VzlKZ1NwYUJmTFlUTU94dGZjSmxTNlpMMERiNzROdk5UbFNuK3BWbWhGZUFq?=
 =?utf-8?B?SFlSK3NSQkNVV1JoYmJldDZySHhjL2pna0MzcTNnTmVQYzJud3pJTnRWb1Jt?=
 =?utf-8?B?amxJZTlsNDlYQTdHWjAyTzhmNkxXRStPaktYNDhCdnFMQ2RGclNKYjVWZFdV?=
 =?utf-8?B?QVlKZ1dxN0FtUzdYdjZvSmE4aWcwSmw0TDdLWUNwem9Wdko4TDlmemdQRzJ1?=
 =?utf-8?B?amZZQkZQdExGbU1iOHJFYlluNUZPZWxuREVMSkFEY3hrTFhVckdTbTUvWms0?=
 =?utf-8?B?VWFFVklYTDJFWGFaK2E3TE5IeFhMRFovRUpsRWIrazhXdlVRQy9zMGZ4MW8y?=
 =?utf-8?B?My9vTnUxZ2VOaE1VV3lGU3djdS9DVk0rMExNNm0xQURoZElqdjVDeDkzdk16?=
 =?utf-8?B?cHkwZnVNbWdZTUozdDF6N0tBWHo0VGJRd2d2M1FWRTVpKzRibFJLNUlPZjRU?=
 =?utf-8?B?RlpqVG5CS005bVpUaTQ0SEdtVlBRdEZoOHBqYndFLzczb0FXcGhXOUg0M2Jp?=
 =?utf-8?B?RFlTakVaVjJPelA3dzlyZG1hSU8xOXp1TUdhUEM4ZEZZbTY5REU2Um1ma29i?=
 =?utf-8?B?ZENiZ3ZySUR5OGJXZlNqdFU4UGpyNjJ0T0FEQlcyVG1jTE45UG1sc25sYTE0?=
 =?utf-8?B?bWd0MTh6dXdqb3pSMm5YODRLUkljSklXTDRQclNvdm5RZ0c0WENDNXNiNUtW?=
 =?utf-8?B?TlhKSlZJdEpXOG1aOGpsMzBTOEFkRUthTytzaTc5MTJXVEI0T2RpajlSSUJV?=
 =?utf-8?B?WUdZWldIVENhMjVQQndCMTlNL2J5bUZTTkljUm11L0xWQ1JFZktuMlZUbWlj?=
 =?utf-8?B?NWxZSmxJLzBOMmpqcG1DUDIrcmdUbVdZeU1TTG95SFBld2RzaEJ0Mnh1bm01?=
 =?utf-8?B?OUlzcitaNkVSUjhTVnhBQzVRLzdqSndTNUYwRjVTYnFLNmxQOFFnalR2YmJr?=
 =?utf-8?B?eis1TEg1Ry85M1dpMEFwZUErTFlSMVNhSXkvckVPRytPNFA2b09MdWd5WGRO?=
 =?utf-8?B?YXBDbjU3TEIwQzl4UDJick1QU3pNU00rc3MwVTZqcVU5TEFXU2ppVElTM2pJ?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Eyl4n+z0psuwRwm1q5vCNuMw+ptF8eczULwmy1zMPml061hck/L/26Y3YcMzuojvyrNzdccYqaz4/QIMtXH6zlwDegbyEUJ2kTqsSdbysqsW3lJpYx9aP+OV90PEbDcO0k/9+XeCAFGB+jLCYI4tJBTpSTPUt+hSohYSpkv+LgYtJcQRnl98qnkYgUkHUAw8bB/0j2EkjaVccreHBDCL39O3v2JhheSe6es6SwuEcBd0D+2HSCCVqewPlFW/WrmGBepqJ1wsHypqiYH5Uxu1J5117YolTU2TNwOLDdVPf5FwKbI0wifltWXGEJ6K/hBFwstx+Ek00HFrsuvdNUFfWZtEfXOv8Dj8D7ZJlE2eKinY57VVhTa2/ig33aixIZGQ+EjicEL3Qjd4BPfjKV2Cx/jOax+D+AxOPrkd25SWbAPr6UuhcpXWzxMHsKNYsOom+sfK+bkO2TTDeJ3QowyNnKLH52j9dgjc2I2QdwWdiR1CwNhpMSNEUwW7dXc3ZXxmKCLpjS49xayaasNVzjgs+T6RFdcgIwQ1sZaH3aTfAoptDm7YrVCcGPCwIajrGdN/Set9uH3/DqwcmdFpnOScRsdQp6I6OlYJiCHd+mDgEAodrJBy/XMTdvSIwpN+CH+n7oFDq/rsd3/2m7n8ilmgeFJuVbADkuBmx0gcOmly3w3Dw30Cjmis+RZIjduhxEHRZuAJXpbae3+5EjTNkriaMx+lv1DAUAwwG7pmyh3Eg3nq3h24O/qzq/88NQQVjvcsagTZM7VI24dZAUzZ/dHFfMFUAj7jI+NaBpzghOEp+d2Ga9U08eNKlFNa1yZA5/+j
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b45ee4-4b35-4125-e781-08dbbfe49a61
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 05:34:36.9295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxRrmtBnUFC214oxpEyDGzVCrb/aDU0CduRllMwUuc4Ow42l7Dvdj0RscRSvjvRpjsRaXCOSrarIzoMsw3LS7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_03,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280047
X-Proofpoint-ORIG-GUID: AiGOMN1hBAkRYF2_6GNHDv4tueciEyjq
X-Proofpoint-GUID: AiGOMN1hBAkRYF2_6GNHDv4tueciEyjq
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28/09/2023 12:26, Qu Wenruo wrote:
> 
> 
> On 2023/9/28 13:53, Anand Jain wrote:
>> This patch introduces new configuration file parameters,
>> POST_SCRATCH_MKFS_CMD and POST_SCRATCH_POOL_MKFS_CMD.
>>
>> Usage example:
>>
>>          POST_SCRATCH_MKFS_CMD="btrfstune -m"
>>          POST_SCRATCH_POOL_MKFS_CMD="btrfstune -m"
> 
> Can't we add extra options for mkfs.btrfs to support metadata uuid at
> mkfs time?
> 
> We already support quota and all other features, I think it would be
> much easier to implement metadata_uuid inside mkfs.
> 
> If this feature is only for metadata_uuid, then I really prefer to do it
> inside mkfs.btrfs.

Thanks for the comments.

The use of btrfstune -m is just an example; any other command,
function, or script can be assigned to the variable POST_SCRATCH_xx.

Now, regarding updating mkfs.btrfs with the btrfstune -m feature,
why not? It simplifies testing. However, can we identify a use case
other than testing?

Thanks, Anand

> 
> Thanks,
> Qu
>>
>> With this configuration option, test cases using _scratch_mkfs(),
>> scratch_pool_mkfs(), or _scratch_mkfs_sized() will run the above
>> set value after the mkfs operation.
>>
>> Other mkfs functions, such as _mkfs_dev(), are not connected to the
>> POST_SCRATCH_MKFS_CMD.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   common/btrfs | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index 798c899f6233..b0972e882c7c 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -690,17 +690,48 @@ _require_btrfs_scratch_logical_resolve_v2()
>>       _scratch_unmount
>>   }
>>
>> +post_scratch_mkfs_cmd()
>> +{
>> +    if [[ -v POST_SCRATCH_MKFS_CMD ]]; then
>> +        echo "$POST_SCRATCH_MKFS_CMD $SCRATCH_DEV"
>> +        $POST_SCRATCH_MKFS_CMD $SCRATCH_DEV
>> +        return $?
>> +    fi
>> +
>> +    return 0
>> +}
>> +
>> +post_scratch_pool_mkfs_cmd()
>> +{
>> +    if [[ -v POST_SCRATCH_POOL_MKFS_CMD ]]; then
>> +        echo "$POST_SCRATCH_POOL_MKFS_CMD $SCRATCH_DEV_POOL"
>> +        $POST_SCRATCH_POOL_MKFS_CMD $SCRATCH_DEV_POOL
>> +        return $?
>> +    fi
>> +
>> +    return 0
>> +}
>> +
>>   _scratch_mkfs_retry_btrfs()
>>   {
>>       # _scratch_do_mkfs() may retry mkfs without $MKFS_OPTIONS
>>       _scratch_do_mkfs "$MKFS_BTRFS_PROG" "cat" $*
>>
>> +    if [[ $? == 0 ]]; then
>> +        post_scratch_mkfs_cmd
>> +    fi
>> +
>>       return $?
>>   }
>>
>>   _scratch_mkfs_btrfs()
>>   {
>>       $MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
>> +
>> +    if [[ $? == 0 ]]; then
>> +        post_scratch_mkfs_cmd
>> +    fi
>> +
>>       return $?
>>   }
>>
>> @@ -708,5 +739,9 @@ _scratch_pool_mkfs_btrfs()
>>   {
>>       $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL
>>
>> +    if [[ $? == 0 ]]; then
>> +        post_scratch_pool_mkfs_cmd
>> +    fi
>> +
>>       return $?
>>   }
