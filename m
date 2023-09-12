Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D96479CB2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 11:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjILJIO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 05:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjILJIH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 05:08:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DDA210B;
        Tue, 12 Sep 2023 02:08:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C7h6oM011489;
        Tue, 12 Sep 2023 09:08:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7O/vlLFKrdU+ioOf7m62q0xl7Z5un8OW9msbv2ndSlA=;
 b=BueMtr6+AzAwqAhWmB8d/IwpS5Nno9VskND8rzjangkobPkKuETzFjWl7NRwRHOj3Ifu
 MqX7YwNQr4t3qKYPkHNMIwQ/hGoGXd9SU5SLDz2erU7hZfig1UEJpLsG0mEnHiTQ+IGI
 NQ0g+OaE6m4+5fG6HPwvrZLq1xbDmPAuBWdv/y5WYN+2ZRCVcLuZn4Tz3P76dvS/mF6P
 vM1sNrzQKTbdYBFdm2WJ8zg/Wxckr9zb04Kwvtj3oF3LcC6Cxkebehr7DPyal43eR4+f
 Bx2Xy+qjaRWrfksuMkqOiiIpcq1P1gPnP/IRgtaPJ0sKJnzkTH3AETbzlQEDMZJfo8Km ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jhqbgqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 09:08:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38C8jXh1007711;
        Tue, 12 Sep 2023 09:08:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f55fgsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 09:08:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9FhX4WLl79WsJWUjzGPWvkjrHJKd+suXZ2ZRx8/bs0maEjxK9Q9m+tSIPOjduWdOtA/iaCPB2niwcaADViQ/ogt8GLdNseCajAd374H3dzppf7ryxyG7YcAn4F2jJegX71VP3bK27FlogyEDoxyFZzHmtV+NAb6bbrBlb5wnrOYcii2ibtN3wb18nTiGbFD7zj14ZzVQbqLbPBUxQyDRX5q5BUT6ftSuB/sx9je5E3McpcFUT+KfaDWMkLJ/h63naB0/dfnBlen6JlCcVIRP8Z3IQygLvspTfkUAirHEad9cyoRnuLJcw2/vRGnIqJWXY0nHtdabACjEmMVIHtFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O/vlLFKrdU+ioOf7m62q0xl7Z5un8OW9msbv2ndSlA=;
 b=JRxSgYmnv+Ptgfcz8GypsEhldiM/FG+7/Pb2dm4fItWZ61FyxaDvMvW21CJiwngUcP89S2SO2FQEEbO0I87wme06oSVZnW0qk6DVjCjw6GRvld/uAsds9PNU9WKtQMKBDFQxfnOa+yj5l5wTPUif/eJpoM2KlKAbjcpOxa/VTudkzYoTCQRuCXzM8fK9EFAEfw6FlEmH/Acj8uYrGnKrOktNu9sbuNLU4jX/xNrMoCDg6razFDV8JfusLN4Rijr2TIuk0k+CVVAj+94MZQDQ+9fY5aVa52PuDdCUsaqt0SbarvAOR76chp3uRNbHS+VC/enl9gvCAth+lEC+JIjAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O/vlLFKrdU+ioOf7m62q0xl7Z5un8OW9msbv2ndSlA=;
 b=cAWoICCmTVmnCXtcBAS2EprI9ycujlNA8e/f6NBC+LnvGzUmlngjHveZG3P65ql/ILIZMv7Xqa3MkEy8ATGea0DngttI6XKEPoOF8ynOuLwwc/jTku6dEjT2MSEuKV10nMu33vNKoyA8rWPqvAf1iDEPb8PG11g5WDPFZv6yol8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6252.namprd10.prod.outlook.com (2603:10b6:510:210::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 12 Sep
 2023 09:07:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 09:07:58 +0000
Message-ID: <c4f62adc-a923-e253-2731-f27fb6cf5ae9@oracle.com>
Date:   Tue, 12 Sep 2023 17:07:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] fstests: btrfs/185 update for single device pseudo
 device-scan
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <7558eed09a89d25fbd8083d45078cfe2e9601f45.1694017375.git.anand.jain@oracle.com>
 <20230911183219.GA1770132@zen>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230911183219.GA1770132@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 5456a02e-3e60-4e92-e4af-08dbb36fc22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9NHihFXxFbMe2UZDkkyQzaMkIr8QcIefMvBlkRbS5j4EoImAwMqGanA3PPys5TMo5wkpxRV1zzUuAth0Qo46wl/b2ESu/ezqolljBMx6yhXLKgumZDe0FtJiAB4JPe7qGSn1hsfriFC7fpxa/UV271Qrr+GnjCGgPwCf8pm2thjOlgIEgHga1EtQO20CG1fCOMPRv6HcNJyIwhuSaGA5k644sZz1VoGXue+0PASCN4vYF0GtV3ots1JesMCGC1VZL4fr8OPuBG42Rg3q1gN+7whJGaGw/aqhH8uo4jtddkBFgMtd8Ip28CfEWadpRLr/LE++p25Y/iV7aCLcp784kCvhfG8Q3xbuwid7DDAKXipp4mZIIUrJcGzK6lLJDZAr6hJekQ/cVj6glzuuJb8YTU4Y4bD6UjiJTNVb3XTQAc86P9jpRzjYInaPHSIvVDGCc7kk7nKqyzWC3dPLd/C0TeV0R23WBiVcBu+18Sl1J+/ZmSgIpKDQB91u7zCz4uKYiDHb8HQcMXlQcW0eiNaGoNXnwbkq1LBJnzzevQhNifS+TeVnUiUbTtwj8IQXZmqrkr/TlFDIMhMUdSUnNvF3dU8skYUJw9+sHG/ytEYgOwyP+TZGa8TScXOhhahuPcpnnV+uEeprp8Vkn1j53RzqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199024)(186009)(1800799009)(316002)(6512007)(6506007)(31686004)(6486002)(83380400001)(6666004)(53546011)(6916009)(66476007)(66556008)(66946007)(8936002)(478600001)(8676002)(4326008)(5660300002)(36756003)(86362001)(38100700002)(41300700001)(2616005)(31696002)(2906002)(44832011)(26005)(15650500001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmwzU1hxWElaVm4rd0pwdGUwcC9kSUlTWXNucWw0RFFHelVSYk4zT1M5MjM2?=
 =?utf-8?B?UmdmTjBnY2k0Z0pJcGFOcUU1cFowMWMrRWZwWkhETTlpWlcraWRxZ2x0Nmdr?=
 =?utf-8?B?cFdHSDZ4NXRmUHE3dUF0Zmd0cVBPd3hHS0VnaVBPMWNKR1pNUVRYelJSbDFl?=
 =?utf-8?B?dkMwN082L0EwZGZleFNHVVozeGt4NzJjckdiTjcvblNkZEV0OXBieUF2aXlC?=
 =?utf-8?B?UmZFVzVhOHJocjdPYUVYUjhaZzh2VFJZREJDQkRGVWN0eitiRjU1WlE2QThJ?=
 =?utf-8?B?SmdzVkhubTRlam1yU08xK3R3TUo1MEtTMDZJRlhOeFJzVGdBWkpUZDhUZURu?=
 =?utf-8?B?YmYySGY0ajI0YnpHV1RPWmdkSkFUZ1VTbzlQMzJVaFVBa1RUS3JWaExRWjNH?=
 =?utf-8?B?VmljYzVqM2pvbEZaRXZGelBSQjNVdmFRWDJLSVFGdkYvSm9KYm11ejE3TmMx?=
 =?utf-8?B?dGJoQWErYXd6THFuQitLei9kekRsbHV5Y0x1eHV4ZStHK0ozODRMWU8yeC9y?=
 =?utf-8?B?ZlJnQnM0SmoyYjY2TktLekxHY3hnbjZzTmFyQjFSemRRUlQvQXpaVG80djZH?=
 =?utf-8?B?U2thKzg2ZXdwMzNpQ2pETWF0N2xCektDTnRWNkRBU1FVd2huRVF4ZzBKVWlK?=
 =?utf-8?B?ZDNYZ1VRR3FOeW1lMktNYnJJbldzNnRQWW8xUDVBQTNRODZaNGxwdGhTT3Rz?=
 =?utf-8?B?cEtTM0dQblVrUFN5dU5QQ0p6djRGZEVaV1FiQ3c5SFFUdzNiTTk4djdoblVa?=
 =?utf-8?B?bWtPUG14NXUwa1gzN01OdEt0QWszUDk1LzRRYk9iTDBIY3JmK0pxei8xQmtQ?=
 =?utf-8?B?Q3BEMVdveWxIdFJOLzQ2YVZQeXV1alhqak5BaThLYzhSTFZMcVlnUXEvaXJL?=
 =?utf-8?B?d29QN0dBQUlqa3RzcGtCWmhQWWdhY0hLVTRLQU1aN3h0MVJTRWpZWGNXM1Jo?=
 =?utf-8?B?RklFaGJsbGR6aGFKeDI3M1hKTGh1ZExVTi9aeDFZWkM0M1Y5UjhLVFVZUW93?=
 =?utf-8?B?cHpSYnhOS1dSckVycGFYQ3gvYkVLQmNhcmFvRS9FU3IrYmNkaWtBWXJ3MDhJ?=
 =?utf-8?B?aDRPL1cxVUxvS0FzanAvL0ZEaDVMb2dFUHE4REJLdnFLTC9BZFFycTFvNUZI?=
 =?utf-8?B?NmU4SEdnQk84dW1mS0F5cE5mYWVQM0lkcWlzQWl2dk5tOWZ2T2RKUmpKZlRL?=
 =?utf-8?B?RHpjY0dJb0pjQVdPbHlUM05KOHRKeUdYSEdjbTE2ZVU5K1kybHlpNkFyMnJO?=
 =?utf-8?B?QlAwYStHTWtPMW5zN214K216YUFuajJIN3ZBdURtUVl5b0VQZTR5VTBSOE81?=
 =?utf-8?B?cEpwRU93UlhTZDRGdzAvODhSZ1ZTY2hGcklsdzFOUkt4Ry9SbGR3UEN1aVZQ?=
 =?utf-8?B?dTV1MEtNcmlHa29iVzcvNHYzeTV2bUlmUXI0aXY4NHk4cnltYTZOTng2Z0Vt?=
 =?utf-8?B?NXRKSXF5a2ovWHZLR25pelNNZjBaSFVtSXVTRTRpTWNoTFNyOVBhR0pwWXJN?=
 =?utf-8?B?MGhCckdrd01pa3p6RHJVRGlUVXBkT1kyRXA4c3M2bytKZzk5aE5TOGJoOE9X?=
 =?utf-8?B?U3pETEtpeXpXNkFXWUlGUkkvU002ZXNlcm02dmJTczZtZGlSdW13SkN4S1pm?=
 =?utf-8?B?RVFyMkNsNWJnS3VPL2NPVzVnTUlWd1prVHRQQ0NTYTI4OEdLcmkrVVkyOWZK?=
 =?utf-8?B?QzlnaUZpbXVjSTY1OEJQWXZLVUdTTnBLZS9DWUx1S2dUOHZ1SGlFWngyZ3VD?=
 =?utf-8?B?UHhMVlcxQS9Tb3pVMEtZQm14NEcxajluY0JvWStNUTV3NFV3emRBeVdJVWhx?=
 =?utf-8?B?bE81T1daSi9jMWI5aVAvUURnTGFRTkN3N3ZvcWRPTDJIUkRnUmZWMW1SdXRD?=
 =?utf-8?B?U1ZpSzhlQTkyd3FjaHdmeHIwcThGV2lPTWVvam1OMjNGcStmUnl2U1FNc0VI?=
 =?utf-8?B?TVcvYWQwL2QyM0U4RlZuOTZ2UEw3RnRpeVdMNzM2cVVvUkZCaGFuMUlkUk0x?=
 =?utf-8?B?eEEwcURCbWVySUFMbk0zVEk2RDdQaW5zUjRDQjVadk1uMzhJbjVTcGcrVDla?=
 =?utf-8?B?ekpRZ3R1ZVZrcmM3bGNTNXlkb1VoUGtFN3BuaVhvd0lLd1RGSmJZSDk4bHlh?=
 =?utf-8?B?djduY2VMTlVyZGY4clhlRzFxT1dqS0ozcVB0bHE5RHFrSTJhc012OG1UQkxo?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 71LphS/X2zIFHUYAiGHIcwQ8Ys+0LNsXA9wSMdF7SQbEJTm2Dbi2riK3Ne2hn7XYmEz/1un3h0Y7bSbydDDLRKWvjoU28CZWJV4+ZynGVCeS9IG1AP/SrdsrkUhEO03PpTymJxjCitJN9KECdmmrzW8kqKoAMcqdkYJwW8Mgfs75W4OOO07rejadFaShwGOhNLwkZtocIWItXVTEnVht9KTombDPKQXU53sPDHJquaLXp5+quULziU5urunIDCTOONAW6UIzJ7o/7MjNVPnu0bwzvyE3xx2+hMvebIoX2/XThtg+L5qCxXA5AN2xyq9YPuc1TIfz4tT1UGe2xa2l966ndRzrSMzNYQo5sxVqNOamlpuy3/z6b4YttH9CBME2Z0GVAq1//vSiGeevLJXgLpEDpC926B+FymuXKClNSX31YXZyHQbt07S3Nrcp0yMccDdiy0G83sJlWvO8sOE8DxH9hyV7Vt6CB6nB+HemjuKYdzdRj6W7d+EWb5di7PPyhuj2NfjMisKVw3mm/mWua5ard+QTipWomxqTre9DYN86vR26ZC15Zy7Jn83pvk8PYOZ3xZD/G6eaSvcJXJnvzcDCn4q8tngYVvuo8+8zF+swdpI1o7+9TFE/q4MZpU6j6gJRZyXSJ/85mZMIdLwjcgXYvHJQjAfbsojSJTd/23vxdLXcrQ9tCGQGBpP9Tcy/csf7J47T8o0dNnwUAl0//yBxorN9LZgdJRZ/DIAfet2gy4BeOmes89Qjj+D7hkyQaDLPf/HRwyRN+top+6ALnA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5456a02e-3e60-4e92-e4af-08dbb36fc22e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:07:58.4580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAqCahMJ7TQzkYoiUKkikmL3XPMC3oT5FkBsOrLhG4I4DAHxli3ilEc4ypfATZx+8J1PHe+wWZYEqztsaZ+wcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120076
X-Proofpoint-ORIG-GUID: qOz4U6vHYZbsiLVP5kgrGihUD9eIf6hV
X-Proofpoint-GUID: qOz4U6vHYZbsiLVP5kgrGihUD9eIf6hV
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/09/2023 02:32, Boris Burkov wrote:
> On Thu, Sep 07, 2023 at 12:24:43AM +0800, Anand Jain wrote:
>> As we are obliterating the need for the device scan for the single device,
>> which will return success if the basic superblock verification passes,
>> even for the duplicate device of the mounted filesystem, drop the check
>> for the return code in this testcase and continue to verify if the device
>> path of the mounted filesystem remains unaltered after the scan.
>>
>> Also, if the test fails, it leaves the local non-standard mount point
>> remained mounted, leading to further test cases failing. Call unmount
>> in _cleanup().
> 
> This was also affecting my setup, thanks for the fix!

Hmm, it shouldn't, unless commit d41f57d15a90 ("brfs: scan but don't
  register device on single device filesystem") is already in the kernel
  you are testing. Do you have the logs?


> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/185 | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/btrfs/185 b/tests/btrfs/185
>> index ba0200617e69..c7b8d2d46951 100755
>> --- a/tests/btrfs/185
>> +++ b/tests/btrfs/185
>> @@ -15,6 +15,7 @@ mnt=$TEST_DIR/$seq.mnt
>>   # Override the default cleanup function.
>>   _cleanup()
>>   {



>> +	$UMOUNT_PROG $mnt > /dev/null 2>&1
> 
> Do you mean to umount before calling rm -rf on it? That seems.. risky.
> 
>>   	rm -rf $mnt > /dev/null 2>&1

mnt is a special mount point. Removing the special mnt directory after 
unmounting it is correct..


>>   	cd /
>>   	rm -f $tmp.*
>> @@ -51,9 +52,9 @@ for sb_bytenr in 65536 67108864; do
>>   	echo ..:$? >> $seqres.full
>>   done
>>   
>> -# Original device is mounted, scan of its clone should fail
>> +# Original device is mounted, scan of its clone must not alter the
>> +# filesystem device path
>>   $BTRFS_UTIL_PROG device scan $device_2 >> $seqres.full 2>&1
>> -[[ $? != 1 ]] && _fail "cloned device scan should fail"
>>   
>>   [[ $(findmnt $mnt | grep -v TARGET | $AWK_PROG '{print $2}') != $device_1 ]] && \
>>   						_fail "mounted device changed"
>> -- 
>> 2.39.3
>>
